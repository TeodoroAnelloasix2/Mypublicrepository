package sysinfo

// /proc/cpuinfo: info del procesador
import (
	"fmt"
	"os"
	"strings"
	"sync"
	"sysinfo/programa/models"
)

func LeerCpuInfo() []models.CpuInfo {
	data, err := os.ReadFile("/proc/cpuinfo")
	if err != nil {
		fmt.Println("Error al leer cpuinfo")
	}
	cpuBlocks := strings.Split(string(data), "\n\n")
	DatosCpuFiltrados := SerializarDatosCpu(cpuBlocks)
	return DatosCpuFiltrados
}

func SerializarDatosCpu(cpuBlocks []string) []models.CpuInfo {
	var (
		cpus = make([]models.CpuInfo, len(cpuBlocks))
		wg   sync.WaitGroup
	)

	for i, block := range cpuBlocks {
		wg.Add(1)
		go func(i int, bl string) {
			defer wg.Done()
			var cpu models.CpuInfo
			for line := range strings.SplitSeq(bl, "\n") {
				partes := strings.Split(line, ":")
				if len(partes) != 2 {
					continue
				}

				k := strings.TrimSpace(partes[0])
				v := strings.TrimSpace(partes[1])
				if k == "" {
					continue
				}
				switch k {
				case "processor":
					cpu.Procesor = v
				case "vendor_id":
					cpu.VendorId = v
				case "model name":
					cpu.ModelName = v
				case "cpu MHz":
					cpu.CpuMHz = v
				case "cache size":
					cpu.CacheSize = v
				case "core id":
					cpu.CoreId = v
				case "cpu cores":
					cpu.CpuCores = v
				}
			}
			cpus[i] = cpu
		}(i, block)
	}
	wg.Wait()
	return cpus
}
