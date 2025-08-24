package cargarmodelos

import "desweb1/models"

func DefinirUsuario() models.DatosEstructura {
	Datos := models.DatosEstructura{}
	habilidad1 := models.TecnologiasConocidas{Tecn: "Golang"}
	habilidad2 := models.TecnologiasConocidas{Tecn: "Python"}
	habilidad3 := models.TecnologiasConocidas{Tecn: "SQL"}
	/////////////////////////////////////
	Datos.Nombre = "Italiano"
	Datos.Edad = 29
	Datos.Profesion = "Informatico"
	Datos.Skills = []models.TecnologiasConocidas{habilidad1, habilidad2, habilidad3}
	///////////////////////////////////
	return Datos
}
