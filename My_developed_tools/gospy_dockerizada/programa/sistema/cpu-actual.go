package sistema

import (
	"fmt"
	"gospy/modelos"
	"gospy/variables"
	"net/http"
	"os"
	"strconv"
	"strings"
	"sync"
)

var (
	CpuInfoModel modelos.CpuInfo
)

func ServirPaginaCpu() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		info := ExtraerDatosCpu()
		if err := variables.Plantillas.ExecuteTemplate(w, "cpupage", info); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func ExtraerDatosCpu() (listaDatos []modelos.CpuInfo) {
	data, err := os.ReadFile("/systeminfo/cpuinfo")
	if err != nil {
		fmt.Printf("Error leyendo datos: %v\n", err)
		return
	}
	bloques := strings.Split(string(data), "\n\n")
	listaDatos = PoblarCpuInfo(bloques)
	fmt.Println(listaDatos)
	return listaDatos
}

func PoblarCpuInfo(datos []string) []modelos.CpuInfo {
	var (
		cpus = make([]modelos.CpuInfo, len(datos))
		wg   sync.WaitGroup
	)
	for i, block := range datos {
		wg.Add(1)
		go func(i int, bl string) {
			defer wg.Done()
			var cpu modelos.CpuInfo
			for linea := range strings.SplitSeq(bl, "\n") {
				partes := strings.Split(linea, ":")
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
					cpu.Procesor, _ = strconv.Atoi(v)
				case "vendor_id":
					cpu.VendorId = v
				case "model name":
					cpu.ModelName = v
				case "cpu MHz":
					cpu.CpuMHZ = v
				case "cache size":
					cpu.Cache = v
				case "core id":
					cpu.CoreId, _ = strconv.Atoi(v)
				case "cpu cores":
					cpu.CpuCores, _ = strconv.Atoi(v)
				}
			}

			cpus[i] = cpu
		}(i, block)
	}
	wg.Wait()
	return cpus
}
