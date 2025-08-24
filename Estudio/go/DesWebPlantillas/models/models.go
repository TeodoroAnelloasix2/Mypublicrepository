package models

type DatosEstructura struct {
	Nombre    string
	Edad      int
	Profesion string
	Skills    []TecnologiasConocidas
}

type TecnologiasConocidas struct {
	Tecn string
}
