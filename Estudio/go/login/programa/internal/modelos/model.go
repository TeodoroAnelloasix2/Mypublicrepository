package modelos

type Usuario struct {
	Id       int
	Nombre   string
	Cell     string
	Password string
}

type Users []Usuario
