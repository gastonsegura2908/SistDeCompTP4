# SISTEMAS DE COMPUTACION TP4
Repositorio destinado al trabajo práctico #4 de la parte practica de la materia Sistemas de Computación.  
### GRUPO: The Tux Titans
### INTEGRANTES : 
- Federica Mayorga
- Gaston Marcelo Segura
- Lourdes Guyot

---

## Introducción
¿Qué es exactamente un módulo del núcleo? Los módulos son fragmentos de código que se pueden cargar y descargar en el kernel según se requiera. Extienden la funcionalidad del kernel sin necesidad de reiniciar el sistema. Por ejemplo, un tipo de módulo es el controlador de dispositivo, que permite que el núcleo acceda al hardware conectado al sistema. Sin módulos, tendríamos que construir kernels monolíticos y agregar nuevas funciones directamente en la imagen del kernel. Además de tener kernels más grandes, esto tiene la desventaja de requerir que reconstruyamos y reiniciemos el kernel cada vez que queramos una nueva funcionalidad.

## Preparación
Vamos a necesitar un SO Linux instalado con sus fuentes o al menos los headers. La descarga puede demorar algunos minutos, dependiendo del BW de descarga de su conexión a internet.
Por otro lado, en esta primera parte vamos a trabajar con los siguientes programas fuentes y make files.

`fork https://gitlab.com/sistemas-de-computacion-unc/kenel-modules.git `  
` git clone (su propia url… empieza con SU nombre de usuario) `  
` sudo apt-get install build-essential checkinstall kernel-package linux-source `

## Desafios
### Desafío #1 
¿Qué es checkinstall y para qué sirve?
¿Se animan a usarlo para empaquetar un hello world ? 
Revisar la bibliografía para impulsar acciones que permitan mejorar la seguridad del kernel, concretamente: evitando cargar módulos que no estén firmados.

### Desafío #2
Debe tener respuestas precisas a las siguientes preguntas y sentencias:
¿ Qué funciones tiene disponible un programa y un módulo ?
Espacio de usuario o espacio del kernel.
Espacio de datos.
Drivers. Investigar contenido de /dev.  
## Bibliografía
https://access.redhat.com/documentation/es-es/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/signing-kernel-modules-for-secure-boot_managing-kernel-modules  
https://sysprog21.github.io/lkmpg/#what-is-a-kernel-module   
https://opensource.com/article/19/10/strace   
https://docs.google.com/presentation/d/1BYES6Zkfx5K85REWyXsFeW-VngBLOzlDzaYCsTVoc0Y/edit#slide=id.g724a4c87a0_0_5   

## Resolucion
- En primer lugar se ingresa a la pagina https://gitlab.com/sistemas-de-computacion-unc/kenel-modules.git y se realiza un fork de ella
- Luego se realiza el clone: ` git clone  `
- 

# Pasos 

cd part1
make
sudo insmod mimodulo.ko
sudo dmesg
lsmod | grep mod

[67375.506122] mimodulo: loading out-of-tree module taints kernel.
[67375.506166] mimodulo: module verification failed: signature and/or required key missing - tainting kernel
[67375.506348] Modulo cargado en el kernel.


sudo rmmod mimodulo
sudo dmsg
lsmod | grep mod

cat /proc/modules  | grep mod

mimodulo 16384 0 - Live 0xffffffffc097e000 (OE)



modinfo mimodulo.ko 
modinfo /lib/modules/$(uname -r)/kernel/crypto/des_generic.ko

¿Qué diferencias se pueden observar entre los dos modinfo ? 
¿Qué divers/modulos estan cargados en sus propias pc? comparar las salidas con las computadoras de cada integrante del grupo. Expliquen las diferencias. Carguen un txt con la salida de cada integrante en el repo y pongan un diff en el informe.
¿cuales no están cargados pero están disponibles? que pasa cuando el driver de un dispositivo no está disponible. 
Correr hwinfo en una pc real con hw real y agregar la url de la información de hw en el reporte. 
¿Qué diferencia existe entre un módulo y un programa  ? 
¿Cómo puede ver una lista de las llamadas al sistema que realiza un simple helloworld en c?
¿Que es un segmentation fault? como lo maneja el kernel y como lo hace un programa?
¿Se animan a intentar firmar un módulo de kernel ? y documentar el proceso ?  https://askubuntu.com/questions/770205/how-to-sign-kernel-modules-with-sign-file
Agregar evidencia de la compilación, carga y descarga de su propio módulo imprimiendo el nombre del equipo en los registros del kernel. 
¿Que pasa si mi compañero con secure boot habilitado intenta cargar un módulo firmado por mi? 


