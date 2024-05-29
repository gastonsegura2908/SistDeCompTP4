#!/bin/bash

# Guarda la lista de módulos cargados en una variable
loaded_modules=$(lsmod | awk '{print $1}' | tail -n +2)

# Recorre todos los módulos disponibles
for module in $(find /lib/modules/$(uname -r) -type f -name '*.ko'); do
    module=$(basename $module .ko)
    if ! echo "$loaded_modules" | grep -q "^$module$"; then
        echo "El módulo $module está disponible pero no cargado"
    fi
done