package validardatos

import (
	"regexp"
	"unicode"
)

func ValidarPassword(pswd string) bool {

	hasUpper := false
	hasNumber := false
	hasLower := false

	// Validar longitud mínima
	if len(pswd) < 6 {
		return false
	}
	for _, char := range pswd {

		if unicode.IsNumber(char) {
			hasNumber = true
		}
		if unicode.IsLower(char) {
			hasLower = true
		}
		if unicode.IsUpper(char) {
			hasUpper = true
		}
		if hasUpper && hasLower && hasNumber { //Si las 3 se cumplen no hace falta seguir iterando
			break
		}

	}
	isok := hasLower && hasNumber && hasUpper
	return isok

}

func ValidarCorreo(correo string) bool {
	patron := "^[0-9A-Za-z-_]+@[0-9A-Za-z]+\\.[a-zA-Z]{2,}$"
	re := regexp.MustCompile(patron)
	return re.MatchString(correo)
}

func ValidarNombre(nombre string) bool {
	return nombre != "" && nombre != " " && len(nombre) != 0
}
