package modelos

type MemRamInfo struct {
	UnidadMedida string
	Total        string
	Libre        string
	Disponible   string
	SwapTotal    string
	SwapLibre    string
	Cache        string
	SwapCache    string
	Fecha        string //Mysql devuelve tipo date como []bytes o uint8
	Errores      error
}

type ResultadoInsercionRam struct {
	Errores       error
	Insercion     int64
	FilasAfectada int64
}

type CpuInfo struct {
	ModelName string
	VendorId  string
	IdModelFK int //Apunta a la tabla cpumodelnamegospy
	IdTable   int //Apunta a la tabla cpuinfogospy
	IdModel   int //Usar para FK
	Procesor  int
	CpuMHZ    string
	Cache     string
	CpuCores  int
	CoreId    int
}
