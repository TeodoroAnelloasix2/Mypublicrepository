package sistema

import (
	"context"
	"fmt"
	basedatos "gospy/conectarbbdd"
	"gospy/modelos"
	"gospy/variables"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

var (
	UltimosDatosleidos     modelos.MemRamInfo
	UltimaFechaParaUsuario string
	UlitmaFechaBBDD        string
)

// Ejecuta la pagina para leer la ram actual, Se escoge medida kb,mb,gb
func PreviaRamActual() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		if err := variables.Plantillas.ExecuteTemplate(w, "rampage-form-leer", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

// Recoge los datos de formulario
func RamActual() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		//capturar medida

		var medida = r.FormValue("eleccion")
		DatosRam := LeerRamInfo(medida)
		CambiarMedida(medida, &DatosRam)
		DatosRam.UnidadMedida = strings.ToUpper(medida)
		UltimosDatosleidos = DatosRam
		fecha := time.Now()
		fechaAmigableUsuario := fecha.Format("02-01-2006 15:04") //Formato mas amigable
		fechabbdd := fecha.Format("2006-01-02 15:04:05")         //Formato DATETIME de MYSQL
		UlitmaFechaBBDD = fechabbdd
		DatosRam.Fecha = fechaAmigableUsuario
		if err := variables.Plantillas.ExecuteTemplate(w, "ram-datos", DatosRam); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

// Leer datos RAM
func LeerRamInfo(medida string) modelos.MemRamInfo {

	raminfo := modelos.MemRamInfo{}
	raminfo.UnidadMedida = medida
	fmt.Println("Medida: " + medida)
	datosram, err := os.ReadFile("/systeminfo/meminfo")
	if err != nil {
		err = fmt.Errorf("error al leer la info de la ram %w", err)
		raminfo.Errores = err
		return raminfo
	}
	LlenarDatos(&raminfo, datosram)
	return raminfo
}

// Llena el modelo de la ram
func LlenarDatos(raminfo *modelos.MemRamInfo, datos []byte) {
	lines := strings.SplitSeq(string(datos), "\n")
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
			raminfo.Total = v
		case "MemFree":
			raminfo.Libre = v
		case "MemAvailable":
			raminfo.Disponible = v
		case "SwapTotal":
			raminfo.SwapTotal = v
		case "SwapFree":
			raminfo.SwapLibre = v
		case "Cached":
			raminfo.Cache = v
		case "SwapCached":
			raminfo.SwapCache = v

		}
		if raminfo.Total != "" && raminfo.Libre != "" && raminfo.Disponible != "" && raminfo.SwapTotal != "" && raminfo.SwapLibre != "" && raminfo.Cache != "" && raminfo.SwapCache != "" {
			break
		}
	}
	raminfo.Errores = nil
}

//Convertir a KB,MB o GB

func CambiarMedida(medida string, datos *modelos.MemRamInfo) {

	divisor := 1

	if strings.Contains(medida, "m") || strings.Contains(medida, "M") {
		divisor = 1024
	} else if strings.Contains(medida, "g") || strings.Contains(medida, "G") {
		divisor = 1024 * 1024
	}

	//Convertir a unidad deseada

	datos.Total = convertirCampo(datos.Total, divisor)
	datos.Libre = convertirCampo(datos.Libre, divisor)
	datos.Disponible = convertirCampo(datos.Disponible, divisor)
	datos.SwapTotal = convertirCampo(datos.SwapTotal, divisor)
	datos.SwapLibre = convertirCampo(datos.SwapLibre, divisor)
	datos.Cache = convertirCampo(datos.Cache, divisor)
	datos.SwapCache = convertirCampo(datos.SwapCache, divisor)
}

func convertirCampo(valor string, divisor int) string {
	partes := strings.Split(valor, " ")

	if len(partes) == 0 {
		return valor
	}
	if divisor == 1 {
		return strings.TrimSpace(partes[0])
	}
	num, err := strconv.Atoi(strings.TrimSpace(partes[0]))
	if err != nil {
		return valor
	}

	res := float64(num) / float64(divisor)
	if divisor > 1024 {
		return fmt.Sprintf("%.3f", res)
	}
	return fmt.Sprintf("%.2f", res)
}

// Guarda los datos en la bbdd
func GuardarDatosBBDD() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		UltimosDatosleidos.Fecha = UlitmaFechaBBDD
		Res := modelos.ResultadoInsercionRam{}
		ctx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
		defer cancel()
		condb := basedatos.Conectar()
		defer condb.Close()

		queryInsert := `INSERT INTO raminfogospy (unidadmedida,total,disponible,swaptotal,swaplibre,cache,swapcache,fecha) 
						VALUES(?,?,?,?,?,?,?,?)`

		output, err := condb.ExecContext(ctx, queryInsert, UltimosDatosleidos.UnidadMedida,
			UltimosDatosleidos.Total,
			UltimosDatosleidos.Disponible,
			UltimosDatosleidos.SwapTotal,
			UltimosDatosleidos.SwapLibre,
			UltimosDatosleidos.Cache,
			UltimosDatosleidos.SwapCache,
			UltimosDatosleidos.Fecha,
		)
		if err != nil {
			fmt.Printf("Error: %v\n", err)
			return
		}

		rows, err := output.RowsAffected()
		if err != nil {
			fmt.Printf("Error: %v\n", err)
			return
		}
		Res.FilasAfectada = rows
		i, err := output.LastInsertId()
		if err != nil {
			fmt.Printf("Error: %v\n", err)
			return
		}
		Res.Insercion = i
		if err := variables.Plantillas.ExecuteTemplate(w, "guardar-ok", Res); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}

	}

}
