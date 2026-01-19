
resource "local_file" "script-ex"{
    content="#!/bin/bash \n echo Hola: $1 \nData=$(</dev/stdin) echo $Data "
    filename = "${path.module}/script-ex1.sh"
}