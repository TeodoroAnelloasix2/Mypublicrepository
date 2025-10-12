package conbbdd

var (
	RegistrarUsuario = "INSERT INTO usuarios (nombre, cell, password) VALUES (?,?,?);"
	LoginUsuario     = "SELECT id,nombre,cell,password FROM usuarios WHERE nombre=?;"
)
