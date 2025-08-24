package sysinfo

import (
	"fmt"
	"os"
	"strings"
	"sysinfo/programa/models"
)

// /proc/meminfo: info de la memoria RAM

func LeerRamInfo() models.MemRamInfo {

	data, err := os.ReadFile("/proc/meminfo")
	if err != nil {
		fmt.Println("Error al leer meminfo")
	}
	return SerializarDatosRam(data)

}

func SerializarDatosRam(data []byte) models.MemRamInfo {
	var ramInfo = models.MemRamInfo{}
	lines := strings.SplitSeq(string(data), "\n")
	for line := range lines {
		partes := strings.Split(string(line), ":")
		if len(partes) != 2 {
			continue
		}
		k := strings.TrimSpace(partes[0])
		v := strings.TrimSpace(partes[1])
		if k == "" {
			continue
		}
		switch k {
		case "MemTotal":
			ramInfo.MemTotal = v
		case "MemFree":
			ramInfo.MemFree = v

		case "MemAvailable":
			ramInfo.MemAvailable = v
		case "SwapTotal":
			ramInfo.SwapTotal = v
		case "SwapFree":
			ramInfo.SwapFree = v
		case "Cached":
			ramInfo.Cached = v
		case "SwapCached":
			ramInfo.SwapCached = v
		}
		if ramInfo.MemTotal != "" && ramInfo.MemFree != "" && ramInfo.MemAvailable != "" && ramInfo.SwapTotal != "" && ramInfo.SwapFree != "" && ramInfo.Cached != "" && ramInfo.SwapCached != "" {
			break //Si tengo todos los datos termina el bucle
		}
	}
	//fmt.Println(ramInfo)
	return ramInfo
}
