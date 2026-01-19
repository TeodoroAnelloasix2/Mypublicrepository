package modelos

type Cliente struct {
	Id        int
	Nombre    string
	Correo    string
	Telefono  string
	FechaAlta string //El driver de mysql devuelve las fechas como array de byte o uint8
}

type Clientes []Cliente
