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
