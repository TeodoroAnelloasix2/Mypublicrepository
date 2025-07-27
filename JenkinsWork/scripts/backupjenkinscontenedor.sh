#!/bin/bash

if [[ $1 = '/var' ]];then
	echo "Se hace copia del volume"
elif [[ $1 = '/null' ]];then
	echo "No se hace copia de seguridad"
	exit 0
fi

#Script para automatizar la copia de seguridad del volume de docker de jenkins
cd "$1" || {
    echo "No se pudo cambiar al directorio de trabajo especificado"
    exit 1
}
#Variables
#####################################################
src_dir="jenkins_home"
prefijo="jenkishomebackup"
timestamp=$(date +%F-%H%M)
bkpfile="${prefijo}_${timestamp}.tar.gz"
#####################################################

#Comprobar que somos root
#####################################################

if [[ $(id -u) -ne 0 ]];then
    echo "Ejecutar como root o con sudo!"
  exit 1
fi
#####################################################

#Comprobar que existe copia de seguridad previa
#####################################################
ls -l | grep -i "$prefijo" >/dev/null
res=$?
if [[ $res -eq 0 ]];then
    antiguo=$(ls -l | grep -i "$prefijo" | awk '{print $NF}')
    echo "Eliminando backup antiguo: $antiguo ........."
    
    sleep 1

    rm -rf "$prefijo"*.tar.gz
else
    echo "No se ha detectado ninguna copia de seguridad previa"
fi
#####################################################


echo "Se procede a realizar la copia de seguridad, esto puede llevar unos minutos......"


#Crear copia de seguridad
#####################################################
tar czf "$bkpfile" "$src_dir"
#####################################################

#Comprobar que se ha realizado la copia correctamente
#####################################################
res=$?
if [[ $res -eq 0 ]];then
    echo "Copia de seguridad creada correctamente: $bkpfile"
else
    echo "Error al crear la copia de seguridad."
    exit 1
fi
#####################################################
