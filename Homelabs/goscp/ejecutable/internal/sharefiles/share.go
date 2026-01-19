package share

import (
	"context"
	"fmt"
	"io/fs"
	"net"
	"os"
	v "sharefile/internal/variables"
	"strings"
	"time"

	fpth "path/filepath"

	scp "github.com/bramvdbogaerde/go-scp"
	"golang.org/x/crypto/ssh"
	kh "golang.org/x/crypto/ssh/knownhosts"
)

func ExecScp() (err error) {

	//Creating our function which provide the known host check reading the specified file
	hkcallback, err := CreateCallBack()
	if err != nil {
		return err
	}

	//Parsing private key to use it
	key, err := ReadSshKey()
	if err != nil {
		return err
	}
	//Creating connection configuration
	cfg := &ssh.ClientConfig{
		User:            v.UserDemo,
		Auth:            []ssh.AuthMethod{ssh.PublicKeys(key)},
		HostKeyCallback: hkcallback, //To use Known Host file
		//HostKeyCallback: ssh.InsecureIgnoreHostKey(), // This is a default option, it does not implement the check
		Timeout: 30 * time.Second,
	}
	//Establish timeout with context
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	server := net.JoinHostPort(v.HostRemote, v.Port)

	//Connection
	conn := scp.NewClientWithTimeout(server, cfg, cfg.Timeout)
	err = conn.Connect()
	if err != nil {
		return fmt.Errorf("error opening connection %w", err)
	}
	defer conn.Close()
	//With walkdir we can walks the files in the given directory
	//path is the absolute path to reach the current file
	//d is the name of the current file
	err = fpth.WalkDir(v.PathFiles, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return fmt.Errorf("error walks dir 1 %w", err)
		}
		//If the current file is not a directory and contanis the word "file" in its name
		if !d.IsDir() && strings.Contains(d.Name(), "file") {
			// Wrap file operations in an anonymous function to ensure the file is closed with defer
			if err := func() error {
				f, err := os.Open(path)
				if err != nil {
					return fmt.Errorf("error opening file %s-> %w", d.Name(), err)
				}
				defer f.Close()
				dest := fpth.Join(v.RemotePath, d.Name())
				err = conn.CopyFile(ctx, f, dest, "0744")
				if err != nil {
					return fmt.Errorf("error sending file %w", err)
				}
				return nil
			}(); err != nil {
				return err
			}
		}
		return nil
	})
	if err != nil {
		return err
	}
	return nil
}

// Read private key so we can use to send file
func ReadSshKey() (key ssh.Signer, err error) {
	fmt.Println("Reading ssh key ")
	buf, err := os.ReadFile(v.SshKeyFile)
	if err != nil {
		return nil, fmt.Errorf("error reading file %s -> %w", v.SshKeyFile, err)
	}
	key, err = ssh.ParsePrivateKey(buf)
	if err != nil {
		return nil, fmt.Errorf("error parsing private key %s -> %w", v.SshKeyFile, err)
	}
	fmt.Printf("File %s read successfully\n", v.SshKeyFile)
	return key, nil
}

// Read file and return hostkeycallback
func CreateCallBack() (function ssh.HostKeyCallback, err error) {
	fmt.Println("Reading knownHost file ")
	function, err = kh.New(v.KnownHostFile)
	if err != nil {
		return nil, fmt.Errorf("error reading file %s -> %w", v.KnownHostFile, err)
	}
	fmt.Printf("File %s read successfully\n", v.KnownHostFile)
	return function, nil
}
