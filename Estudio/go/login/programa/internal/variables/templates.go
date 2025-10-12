package variables

import "text/template"

var Plantillas = template.Must(template.ParseGlob("./public/html/*"))
