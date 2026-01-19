package sistema

import "time"

func FormatoUsuario(fecha time.Time) string {
	return fecha.Format("02-01-2006 15:04")
}
