# SISTEMAS DE COMPUTACION TP4
Repositorio destinado al trabajo práctico #4 de la parte practica de la materia Sistemas de Computación.  
### GRUPO: The Tux Titans
### INTEGRANTES : 
- Federica Mayorga
- Gaston Marcelo Segura
- Lourdes Guyot

---

## Preparación
Vamos a necesitar un SO Linux instalado con sus fuentes o al menos los headers. La descarga puede demorar algunos minutos, dependiendo del BW de descarga de su conexión a internet.
Por otro lado, en esta primera parte vamos a trabajar con los siguientes programas fuentes y make files.

`fork https://gitlab.com/sistemas-de-computacion-unc/kenel-modules.git `  
` https://gitlab.com/sistemas-de-computacion-unc/kenel-modules.git `  
` sudo apt-get install build-essential checkinstall kernel-package linux-source `

## Desafios
### Desafío #1 
- ¿Qué es checkinstall y para qué sirve?
CheckInstall es una herramienta útil para sistemas operativos Unix-like que facilita la gestión de paquetes. Esta herramienta se utiliza principalmente cuando necesitas instalar un programa desde el código fuente.
Cuando instalas un programa de esta manera, normalmente el proceso implica ejecutar `make install`. Sin embargo, este método tiene algunas desventajas, especialmente cuando necesitas actualizar o desinstalar ese programa.
Aquí es donde CheckInstall puede ser de gran ayuda. En lugar de `make install`, usarías `checkinstall`, y esta herramienta se encargaría del resto. CheckInstall rastrea los cambios en los archivos durante la instalación y genera paquetes binarios a partir de tus tarballs. Con CheckInstall, puedes generar un paquete RPM, deb o Slackware que se puede portar entre sistemas para una fácil instalación y eliminación.
Para usar CheckInstall, sigue estos pasos:
1. Ejecuta los comandos `./configure` y `make` como lo harías normalmente para compilar el programa desde el código fuente.
2. En lugar de `make install`, ejecuta `checkinstall`.
3. CheckInstall te preguntará si deseas crear un directorio para guardar alguna documentación que pueda ser necesaria para el empaquetado posterior. Acepta el valor predeterminado de Sí y continúa.
4. Luego, se te pedirá una descripción. Esto es lo que se verá en lugares como el campo Resumen al mostrar la información del paquete.
5. Finalmente, obtendrás la última pantalla confirmando todos los detalles de tu paquete. Un aspecto importante de esta pantalla es que puedes establecer dependencias para tu paquete.

- Usarlo para empaquetar un hello world ? 
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

# PASOS - RESOLUCION
- En primer lugar ejecutamos make en la carpeta correspondiente:
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ make `
A partir de ejecutar este comando se generan los siguientes archivos:
` make -C /lib/modules/5.15.0-107-generic/build M=/home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module modules
make[1]: se entra en el directorio '/usr/src/linux-headers-5.15.0-107-generic'
  CC [M]  /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/mimodulo.o
  MODPOST /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/Module.symvers
  CC [M]  /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/mimodulo.mod.o
  LD [M]  /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/mimodulo.ko
  BTF [M] /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/mimodulo.ko
Skipping BTF generation for /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/mimodulo.ko due to unavailability of vmlinux `
- Luego insertamos:
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ sudo insmod mimodulo.ko `
Al ejecutar el comando `sudo insmod mimodulo.ko`, estás insertando el módulo del kernel `mimodulo.ko` en el kernel de Linux⁷. 
El comando `insmod` es una herramienta que se utiliza para insertar módulos en el kernel de Linux⁴. Los módulos del kernel son piezas de código que se pueden cargar y descargar en el kernel según sea necesario. Estos módulos ofrecen funciones esenciales, como soporte para hardware y sistemas de archivos, que el kernel utilizará solo si se solicitan o se necesitan⁴.
Cuando ejecutas `sudo insmod mimodulo.ko`, estás dando instrucciones al sistema para que cargue el módulo `mimodulo.ko` en el kernel. Este módulo ahora puede proporcionar funcionalidades adicionales al kernel⁷.
Es importante mencionar que debes tener privilegios de superusuario para ejecutar este comando, de ahí el uso de `sudo`⁷. Esto se debe a que la manipulación de módulos del kernel puede afectar significativamente el funcionamiento del sistema⁴.
- Al ejecutar:
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ sudo dmesg `
Se puede observar una gran cantidad de codigo,pero se adjunta una parte de el:
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/5160cc42-e59b-4c16-8925-5a6072ccde86)
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/16163059-dbf5-45c2-873f-d82067884d97)
Al ejecutar el comando sudo dmesg, estás solicitando al sistema que muestre los mensajes del kernel1.
El comando dmesg se utiliza para examinar o controlar el buffer del anillo del kernel1. Este buffer contiene una gran variedad de mensajes importantes generados durante el arranque del sistema y durante la depuración de aplicaciones1.
Estos mensajes pueden incluir información sobre el hardware del sistema, los controladores de dispositivos y cualquier error que pueda haber ocurrido durante el arranque1. También puede mostrar información en tiempo real cuando se conecta o desconecta un dispositivo de hardware1.
En la primera imagen hay dos mensajes que sobresalen:
mimodulo: module verification failed: signature and/or required key missing - tainting kernel: Este mensaje indica que el módulo del kernel mimodulo no pudo ser verificado porque falta una firma y/o una clave requerida2. Esto puede suceder cuando intentas cargar un módulo que no está firmado con la misma clave que el kernel3. Para resolver este problema, puedes intentar firmar el módulo mimodulo.ko usando la herramienta scripts/sign-file en el árbol de código fuente del kernel y la clave privada especificada por la opción de tiempo de compilación CONFIG_MODULE_SIG_KEY3. Si esta opción no está establecida, se utilizará la clave autogenerada por defecto en certs/signing_key.pem en el árbol de código fuente del kernel3.
[UFW BLOCK] …: Estos mensajes son generados por el firewall UFW (Uncomplicated Firewall). UFW está bloqueando ciertos paquetes que están intentando pasar a través de tu interfaz de red4. Los detalles del mensaje te dan información sobre el paquete que fue bloqueado, incluyendo la interfaz de red (IN=wlp3s0), la dirección MAC de origen y destino, la dirección IP de origen y destino (SRC=192.168.0.1 DST=224.0.0.1), la longitud del paquete (LEN=32), entre otros4.
En la segunda imagen podemos observar:
wlp3s0: deauthenticating from 38:6b:1c:bd:4c:8c by local choice (Reason: 3=DEAUTH_LEAVING): Este mensaje indica que tu dispositivo de red inalámbrica (wlp3s0) se está desautenticando de la red con la dirección MAC 38:6b:1c:bd:4c:8c. La razón “3=DEAUTH_LEAVING” significa que la desautenticación se debe a que el cliente está dejando (o se desconecta de) la red1.  
PM: suspend entry (deep): Este mensaje indica que tu sistema está entrando en un estado de suspensión profunda, también conocido como S3 o suspensión a RAM2.  
Filesystems sync: 0.025 seconds: Este mensaje indica que el sistema ha sincronizado los sistemas de archivos, lo que significa que todos los datos pendientes se han escrito en el disco. Esto se hace generalmente antes de entrar en un estado de suspensión para asegurar que no se pierdan datos2.  
Freezing user space processes … (elapsed 0.009 seconds) done.: Este mensaje indica que el sistema ha “congelado” los procesos del espacio de usuario como parte del proceso de suspensión. “Congelar” un proceso significa que se le impide ejecutar cualquier código adicional3.  
OOM killer disabled.: Este mensaje indica que el “asesino de memoria insuficiente” (OOM killer) del kernel de Linux ha sido desactivado. El OOM killer es un mecanismo del kernel que se activa cuando el sistema se queda sin memoria. Su trabajo es seleccionar y matar procesos para liberar memoria2.  
printk: Suspending console(s) (use no_console_suspend to debug): Este mensaje indica que las consolas del sistema están siendo suspendidas. Si quisieras depurar el proceso de suspensión, podrías usar la opción no_console_suspend4.
  
Otro comando que podemos ejecutar es:
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ sudo dmesg | grep -i usb2 `
El cual nos devuelve:
` [    3.512659] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15
[    3.512666] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.512668] usb usb2: Product: xHCI Host Controller
[    3.512670] usb usb2: Manufacturer: Linux 5.15.0-107-generic xhci-hcd
[    3.512673] usb usb2: SerialNumber: 0000:00:15.0 `
Sus respectivas explicaciones son:
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15: Este mensaje indica que se ha encontrado un nuevo dispositivo USB en el puerto usb21. Los campos idVendor y idProduct son identificadores numéricos que especifican el fabricante y el producto del dispositivo USB1. En este caso, idVendor=1d6b y idProduct=00031. El campo bcdDevice es la versión del dispositivo1.
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1: Este mensaje indica que el dispositivo USB tiene ciertos campos de cadena definidos1. Estos campos pueden proporcionar información adicional sobre el dispositivo en un formato legible por humanos1. En este caso, los campos definidos son Mfr (fabricante), Product (producto) y SerialNumber (número de serie)1.
usb usb2: Product: xHCI Host Controller: Este mensaje indica que el producto del dispositivo USB es un controlador de host xHCI2. xHCI (eXtensible Host Controller Interface) es una interfaz para los controladores de host de dispositivos USB de versión 2.0 y superior2.
usb usb2: Manufacturer: Linux 5.15.0-107-generic xhci-hcd: Este mensaje indica que el fabricante del dispositivo USB es el controlador de host xHCI del kernel de Linux 5.15.0-107-generic2.
usb usb2: SerialNumber: 0000:00:15.0: Este mensaje indica que el número de serie del dispositivo USB es 0000:00:15.01.

- A continuacion al ejecutar:
` lsmod | grep mod `
obtenemos: mimodulo               16384  0
El comando lsmod que has ejecutado muestra todos los módulos del kernel que están actualmente cargados en tu sistema. La opción | grep mod filtra la salida para mostrar solo las líneas que contienen la cadena “mod”.
En tu caso, la salida indica que el módulo del kernel mimodulo está cargado en tu sistema. El número 16384 representa el tamaño del módulo en bytes. El último número 0 indica que ningún otro módulo depende de mimodulo.
- Si ejecutamos
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ cat /proc/modules  | grep mod `
retorna:
` mimodulo 16384 0 - Live 0x0000000000000000 (OE) `

muestra información sobre los módulos del kernel que están actualmente cargados en tu sistema y que contienen la cadena “mod” en su nombre1.
En tu caso, la salida indica que el módulo del kernel mimodulo está cargado en tu sistema. Aquí te explico cada campo de la salida:
mimodulo: Este es el nombre del módulo del kernel1.
16384: Este es el tamaño del módulo en bytes1.
0: Este es el número de instancias del módulo que están actualmente cargadas1. Un valor de 0 significa que el módulo está cargado pero no se está utilizando1.
Live: Este campo indica el estado del módulo1. “Live” significa que el módulo está activo y en funcionamiento1.
0x0000000000000000: Esta es la dirección de memoria donde se carga el módulo1.
(OE): Estas son las banderas del módulo1. “O” significa que el módulo es oficial (es decir, que forma parte del kernel oficial de Linux) y “E” significa que el módulo está en un estado de error1.

- finalmente ejecutamos:
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ sudo rmmod mimodulo `
El comando sudo rmmod mimodulo se utiliza para eliminar el módulo del kernel mimodulo.
Cuando ejecutas sudo rmmod mimodulo, estás dando instrucciones al sistema para que descargue el módulo mimodulo del kernel1. Esto significa que las funcionalidades proporcionadas por este módulo ya no estarán disponibles para el kernel1.
- Ahora al ejecutar
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ lsmod | grep mod `
o tambien
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ cat /proc/modules  | grep mod `
no nos devuelven nada ya que en el paso anterior borramos el modulo

- con los comandos
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ modinfo mimodulo.ko `
obtenemos
` filename:       /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/mimodulo.ko
author:         Catedra de SdeC
description:    Primer modulo ejemplo
license:        GPL
srcversion:     C6390D617B2101FB1B600A9
depends:        
retpoline:      Y
name:           mimodulo
vermagic:       5.15.0-107-generic SMP mod_unload modversions `
Cada campo de salida significa:
cada campo de la salida:
filename: Este es el nombre del archivo del módulo del kernel.
author: Este es el autor del módulo del kernel.
description: Esta es una breve descripción del módulo del kernel.
license: Esta es la licencia bajo la cual se distribuye el módulo del kernel.
srcversion: Esta es la versión del código fuente del módulo del kernel.
depends: Esta es una lista de otros módulos del kernel de los que depende este módulo.
retpoline: Este campo indica si el módulo del kernel está compilado con protecciones Retpoline para mitigar la vulnerabilidad de ejecución especulativa del procesador.
name: Este es el nombre del módulo del kernel.
vermagic: Esta es una cadena que contiene la versión del kernel, el tipo de CPU, el estado de SMP (Symmetric MultiProcessing), y otras opciones que deben coincidir exactamente con el kernel en ejecución para que el módulo pueda ser cargado.

- Al ejecutar
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ modinfo /lib/modules/$(uname -r)/kernel/crypto/des_generic.ko `
Se obtiene:
` filename:       /lib/modules/5.15.0-107-generic/kernel/crypto/des_generic.ko
alias:          crypto-des3_ede-generic
alias:          des3_ede-generic
alias:          crypto-des3_ede
alias:          des3_ede
alias:          crypto-des-generic
alias:          des-generic
alias:          crypto-des
alias:          des
author:         Dag Arne Osvik <da@osvik.no>
description:    DES & Triple DES EDE Cipher Algorithms
license:        GPL
srcversion:     E943DEED5E78CA63B2A81B5
depends:        libdes
retpoline:      Y
intree:         Y
name:           des_generic
vermagic:       5.15.0-107-generic SMP mod_unload modversions 
sig_id:         PKCS#7
signer:         Build time autogenerated kernel key
sig_key:        66:36:BA:75:E1:C2:01:89:6B:68:62:8D:3F:0A:A5:21:B5:B3:F5:C9
sig_hashalgo:   sha512
signature:      8D:60:20:7C:EC:D7:FA:9A:EE:BC:83:20:32:9D:32:B1:2B:6B:A6:F8:
		FA:FF:F2:77:89:E5:DF:4A:19:4E:5B:8F:7B:36:66:5A:16:FB:DD:C3:
		34:B2:73:EE:8B:09:4F:B0:E8:1D:25:31:8C:C4:96:5D:79:88:44:8F:
		50:56:7B:4A:B6:5B:A1:2F:8E:BD:88:C0:40:E9:8B:20:55:93:2E:7F:
		56:63:2C:70:66:EC:4C:87:A5:FB:B7:ED:2B:20:24:6E:F0:44:2C:5B:
		75:93:07:68:45:40:79:3B:EE:C7:8F:64:94:D0:10:C6:B2:99:C5:21:
		74:18:76:D6:39:E1:7D:84:70:A2:2D:D7:E9:CF:35:67:A4:70:73:0F:
		3E:E8:87:47:F1:3F:70:C4:EE:1D:9D:17:34:65:73:C3:76:DB:42:1B:
		77:DE:41:AA:91:7F:47:29:B9:AE:D7:6D:2C:78:5F:3E:57:7F:F9:64:
		86:C7:01:7B:16:BA:65:11:84:74:34:D4:59:7B:B7:F0:C4:77:74:34:
		54:E9:2D:58:FD:29:DC:52:DC:AA:B6:29:8B:AC:FF:3D:E1:4C:4C:D2:
		51:CF:D1:93:45:DA:C0:28:86:05:F4:54:1B:AC:F7:70:19:FA:95:60:
		C0:77:67:4B:F6:E4:A9:DD:7F:4B:61:F1:86:FB:69:17:7A:22:9F:1F:
		96:45:39:C9:2A:42:90:3D:AB:0F:B7:6F:97:2B:D5:AB:5F:04:D1:11:
		C2:70:20:49:D5:87:61:AB:AD:8C:6E:85:6C:EE:B7:FE:F3:8A:6A:59:
		88:E7:C7:C7:E5:A3:31:29:E5:3B:25:D5:76:4E:34:35:D9:64:8D:19:
		EF:8A:35:04:6F:2C:13:28:B2:DD:87:45:36:36:60:DD:7A:13:85:4B:
		8B:5F:24:72:82:6C:24:72:14:AA:EB:A2:2F:CA:D0:C7:FC:29:48:B6:
		6A:A4:5B:5F:08:A3:51:83:D6:53:23:AC:CF:14:03:93:6C:0C:55:5B:
		EB:4B:46:44:D6:A2:85:D7:85:1F:23:69:8A:2A:00:BF:60:9E:C0:1E:
		0F:13:73:B6:2A:38:EF:32:68:1A:13:9C:09:5A:19:7E:24:BB:C7:03:
		AA:16:58:07:DC:33:A5:37:47:59:31:F9:8D:5F:F1:20:90:C0:90:13:
		94:87:63:60:F6:FD:65:DD:C3:89:50:92:72:B7:CC:C6:2E:B5:70:1A:
		1D:C8:03:D6:B0:41:2E:1C:9B:60:CB:C1:14:4F:C6:4D:75:99:DE:A7:
		C9:38:13:81:C2:55:9A:F0:0D:29:EE:F6:01:5D:08:6C:B0:79:4E:57:
		31:3E:EA:CF:86:5C:CF:68:B5:F0:30:0D `

Muestra información sobre el módulo del kernel des_generic.ko. Aquí te explico cada campo de la salida:
filename: Este es el nombre del archivo del módulo del kernel.
alias: Estos son los alias del módulo del kernel. Los alias son nombres alternativos que se pueden usar para referirse al módulo.
author: Este es el autor del módulo del kernel.
description: Esta es una breve descripción del módulo del kernel.
license: Esta es la licencia bajo la cual se distribuye el módulo del kernel.
srcversion: Esta es la versión del código fuente del módulo del kernel.
depends: Esta es una lista de otros módulos del kernel de los que depende este módulo.
retpoline: Este campo indica si el módulo del kernel está compilado con protecciones Retpoline para mitigar la vulnerabilidad de ejecución especulativa del procesador.
intree: Este campo indica si el módulo del kernel está incluido en el árbol de código fuente del kernel.
name: Este es el nombre del módulo del kernel.
vermagic: Esta es una cadena que contiene la versión del kernel, el tipo de CPU, el estado de SMP (Symmetric MultiProcessing), y otras opciones que deben coincidir exactamente con el kernel en ejecución para que el módulo pueda ser cargado.
sig_id: Este campo indica el tipo de firma digital utilizada para firmar el módulo del kernel.
signer: Este campo indica la entidad que firmó el módulo del kernel.
sig_key: Esta es la clave pública utilizada para verificar la firma digital del módulo del kernel.
sig_hashalgo: Este campo indica el algoritmo de hash utilizado para generar la firma digital del módulo del kernel.
signature: Esta es la firma digital del módulo del kernel.

- ¿Qué diferencias se pueden observar entre los dos modinfo ? 
Las diferencias entre los dos comandos modinfo que has ejecutado son las siguientes:
Módulo del kernel: El primer comando modinfo mimodulo.ko muestra información sobre el módulo del kernel personalizado mimodulo.ko, mientras que el segundo comando modinfo /lib/modules/$(uname -r)/kernel/crypto/des_generic.ko muestra información sobre el módulo del kernel estándar des_generic.ko que se encuentra en la ruta /lib/modules/$(uname -r)/kernel/crypto/.
Información del módulo: La información proporcionada por los dos comandos modinfo es diferente porque los dos módulos del kernel son diferentes. Por ejemplo, el autor, la descripción, la licencia, la versión del código fuente, las dependencias, el nombre y la firma digital del módulo son diferentes para mimodulo.ko y des_generic.ko.
Dependencias del módulo: El módulo mimodulo.ko no tiene dependencias, mientras que el módulo des_generic.ko depende del módulo libdes.
Alias del módulo: El módulo mimodulo.ko no tiene alias, mientras que el módulo des_generic.ko tiene varios alias.
Firma digital del módulo: El módulo mimodulo.ko no tiene una firma digital, mientras que el módulo des_generic.ko tiene una firma digital.

- ¿Qué divers/modulos estan cargados en sus propias pc? 
Para ver esto se debe colocar el comando ` lsmod `
En la carpeta "ModulosIntegrantes" se encuentra un .txt por cada uno de los integrantes, con las salidas de sus pcs
