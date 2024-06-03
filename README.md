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
- *¿Qué es checkinstall y para qué sirve?*  
 CheckInstall es una herramienta útil para sistemas operativos Unix-like que facilita la gestión de paquetes. Este programa se utiliza principalmente para la instalación y desinstalación de un software compilado desde el código fuente.  
 Cuando se instala un programa de esta forma, normalmente el proceso implica ejecutar `make install`. Sin embargo, este método tiene algunas desventajas, especialmente cuando se necesita actualizar o desinstalar ese programa. Aquí es donde CheckInstall puede ser de gran ayuda. En lugar de `make install`, se usa `checkinstall`, y esta herramienta se encarga del resto. CheckInstall rastrea los cambios en los archivos durante la instalación y genera paquetes binarios a partir de los tarballs. Con CheckInstall, se puede generar un paquete RPM, deb o Slackware que se puede portar entre sistemas para una fácil instalación y eliminación.
  
 Para usar CheckInstall, seguimos los siguientes pasos:
1. Ejecutamos los comandos `./configure` y `make` como se hace normalmente para compilar el programa desde el código fuente.
2. En lugar de `make install`, ejecutamos `checkinstall`.
3. CheckInstall nos preguntó si queríamos crear un directorio para guardar alguna documentación que pueda ser necesaria para el empaquetado posterior. Aceptamos poniendo y (Sí) y continuamos.
4. Luego, pidió una descripción que se vería en lugares como el campo Resumen al mostrar la información del paquete.
5. Finalmente, obtuvimos la última pantalla confirmando todos los detalles del paquete. Un aspecto importante de esta pantalla es que puede establecer dependencias para el paquete.

- *Uso de checkinstall para empaquetar un hello world*  
  Para realizar esto, vamos a utilizar el archivo llamado "Hello.c" y un "Makefile". Primero vamos a ejecutar `make` para que se realice todo lo que esta dentro del makefile, y luego `sudo checkinstall`. Al hacer esto obtenemos como resultado 3 archivos: **hello** , **description-pak**, y **arch_20240528-1_amd64.deb**  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/399c6e82-c48d-4758-b44a-9a68ffd4cf85)  
 ¿Qué es lo que hicimos?  
En primer lugar compilamos el archivo hello.c y generamos un ejecutable llamado hello. Luego usamos un install: para instalar el programa en nuestro sistema. `install -m 755 hello /usr/local/bin/hello`, copiamos el ejecutable hello al directorio `/usr/local/bin` con permisos 755 (lo que significa que podemos leer, escribir y ejecutar, y otras personas sólo pueden leer y ejecutar). Luego ejecutamos `sudo checkinstall`, el cual, en lugar de simplemente copiar los archivos directamente al sistema como `make install`, crea un paquete de software compatible con nuestro sistema de gestión de paquetes (como DEB para Debian/Ubuntu, RPM para Fedora/RHEL, etc.) y luego instala ese paquete.  
  
 Esto tiene varias ventajas:
* Podemos desinstalar el paquete en cualquier momento utilizando nuestro sistema de gestión de paquetes (por ejemplo, apt, yum, dnf, etc.).
* Podemos distribuir el paquete a otros sistemas de la misma arquitectura y sistema operativo y instalarlo allí.
* Obtenemos un registro de los archivos que se instalaron y dónde se instalaron.  
  
 Revisar la bibliografía para impulsar acciones que permitan mejorar la seguridad del kernel, concretamente: evitando cargar módulos que no estén firmados: 
   A continuacion mencionaremos algunas medidas de seguridad para esto:
* SELinux/AppArmor: se puede configurar y activar SELinux o AppArmor para aplicar políticas de control de acceso que restrinjan las operaciones de los procesos y módulos del kernel.
* Auditoría y Monitoreo: se implementa herramientas de auditoría como auditd para monitorear y registrar eventos críticos relacionados con el kernel y los módulos.
* Control de Integridad: Utilizar IMA/EVM (Integrity Measurement Architecture/Extended Verification Module) para asegurar la integridad de los archivos y binarios del sistema, incluyendo módulos del kernel.
* Actualización Regular del Kernel y Módulos: Mantener el kernel y los módulos actualizados para protegerse contra vulnerabilidades conocidas. Utiliza herramientas como yum, dnf, o apt para actualizar regularmente.
* Uso de Módulos Firmados por el Distribuidor: Siempre que sea posible, utilizar módulos del kernel proporcionados y firmados por la distribución (Red Hat, Ubuntu, etc.) ya que estos han sido verificados y son confiables.
* Configuración de Políticas de Carga de Módulos: Modificar el archivo /etc/modprobe.d/ para controlar qué módulos pueden ser cargados. Se pueden establecer políticas estrictas para restringir módulos no deseados.

### Desafío #2  
Debe tener respuestas precisas a las siguientes preguntas y sentencias:
- ¿ Qué funciones tiene disponible un programa y un módulo ?
- Espacio de usuario o espacio del kernel.
- Espacio de datos.
- Drivers. Investigar contenido de /dev.  

RESPUESTAS  
- *¿Qué funciones tiene disponible un programa y un módulo?*
  Un programa tiene acceso a un conjunto limitado de funciones del sistema operativo a través de las llamadas al sistema. Estas funciones incluyen operaciones de E/S (como leer y escribir en archivos), operaciones de red, operaciones de memoria (como asignar y liberar memoria), y otras operaciones del sistema.  
  Un módulo del kernel, por otro lado, se ejecuta en el espacio del kernel y tiene acceso a las funciones internas del kernel y a las interfaces de hardware. Esto incluye funciones para interactuar con los controladores de dispositivos, manipular estructuras de datos del kernel, registrar controladores de interrupciones, y más. Sin embargo, un programa no puede acceder directamente al hardware ni a las regiones de memoria del kernel.
  
- *Espacio de usuario o espacio del kernel:*   El espacio del kernel se refiere a la memoria que el kernel del sistema operativo tiene reservada para su funcionamiento. Aquí es donde el kernel mantiene sus estructuras de datos y ejecuta código de nivel de sistema operativo. En contraste, el espacio de usuario es la memoria reservada para la ejecución de aplicaciones y procesos del usuario. El kernel protege su espacio de memoria para evitar que los procesos del usuario interfieran con su funcionamiento.  
- *Espacio de datos:*   Es una región de memoria asignada por el sistema operativo para almacenar las variables y los datos de ejecución de un programa. Cuando un programa se ejecuta, el sistema operativo crea un espacio de datos para ese programa donde puede almacenar sus variables y otros datos.  
- *Drivers*  
   Device driver (o controlador de dispositivo) es una clase de modulo que proporciona funcionalidad para hardware como un puerto serie. En Unix, cada pieza de hardware está representada por un archivo ubicado en /dev llamado device file (archivo de dispositivo) que proporciona los medios para comunicarse con el hardware1. El controlador de dispositivo proporciona la comunicación en nombre de un programa de usuario. Esto significa que los controladores de dispositivos actúan como un traductor entre el hardware y los programas o sistemas operativos que lo utilizan. Permiten que el software interactúe con el hardware sin necesidad de saber cómo funciona el hardware. Con el comando ` ls /dev ` podemos listar todos los archivos en el directorio, por ejemplo al ejecutar ` ls -l /dev/sda ` se obtiene ` brw-rw---- 1 root disk 8, 0 may 27 17:26 /dev/sda ` : 
`brw-rw----:` Estos son los permisos del archivo. El primer carácter **b** indica que /dev/sda es un archivo de dispositivo de bloque. Los siguientes nueve caracteres representan los permisos del archivo para el propietario, el grupo y otros, respectivamente. En este caso, **rw-** significa que el propietario tiene permisos de lectura y escritura, **rw-** significa que el grupo tiene permisos de lectura y escritura, y **---** significa que otros no tienen permisos.
`1:` Este es el número de enlaces al archivo. Para los archivos de dispositivo, esto generalmente será 1.
`root disk:` Estos son el propietario y el grupo del archivo, respectivamente. En este caso, el propietario es root y el grupo es disk.
`8, 0:` Estos son los números mayor y menor del dispositivo, respectivamente. Estos números son importantes para el sistema operativo ya que utiliza estos números para identificar el dispositivo de hardware específico que este archivo representa.
`may 27 17:26:` Esta es la última vez que se accedió o modificó el archivo.
`/dev/sda:` Este es el nombre del archivo de dispositivo.



## Bibliografía
https://access.redhat.com/documentation/es-es/red_hat_enterprise_linux/8/html/managing_monitoring_and_updating_the_kernel/signing-kernel-modules-for-secure-boot_managing-kernel-modules  
https://sysprog21.github.io/lkmpg/#what-is-a-kernel-module   
https://opensource.com/article/19/10/strace   
https://docs.google.com/presentation/d/1BYES6Zkfx5K85REWyXsFeW-VngBLOzlDzaYCsTVoc0Y/edit#slide=id.g724a4c87a0_0_5   



## PASOS - RESOLUCION
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
Al ejecutar el comando `sudo insmod mimodulo.ko`, se está insertando el módulo del kernel `mimodulo.ko` en el kernel de Linux. 
El comando `insmod` es una herramienta que se utiliza para insertar módulos en el kernel de Linux. Los módulos del kernel son piezas de código que se pueden cargar y descargar en el kernel según sea necesario. Estos módulos ofrecen funciones esenciales, como soporte para hardware y sistemas de archivos, que el kernel utilizará solo si se solicitan o se necesitan.  
Cuando se ejecuta `sudo insmod mimodulo.ko`, se está dando instrucciones al sistema para que cargue el módulo `mimodulo.ko` en el kernel. Este módulo ahora puede proporcionar funcionalidades adicionales al kernel.
Cabe mencionar que es necesiario tener privilegios de superusuario para ejecutar este comando, de ahí el uso de `sudo`. Esto se debe a que la manipulación de módulos del kernel puede afectar significativamente el funcionamiento del sistema.  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/16163059-dbf5-45c2-873f-d82067884d97)  
 Al ejecutar el comando `sudo dmesg`, le estamos solicitando al sistema que muestre los mensajes del kernel.  
El comando `dmesg` se utiliza para examinar o controlar el buffer del anillo del kernel. Este buffer contiene una gran variedad de mensajes importantes generados durante el arranque del sistema y durante la depuración de aplicaciones.
Estos mensajes pueden incluir información sobre el hardware del sistema, los controladores de dispositivos y cualquier error que pueda haber ocurrido durante el arranque. También puede mostrar información en tiempo real cuando se conecta o desconecta un dispositivo de hardware utilizado.  
En la primera imagen hay dos mensajes que sobresalen:  
`mimodulo: module verification failed: signature and/or required key missing - tainting kernel`: Este mensaje indica que el módulo del kernel mimodulo no pudo ser verificado porque falta una firma y/o una clave requerida. Esto puede suceder cuando se intenta cargar un módulo que no está firmado con la misma clave que el kernel. Para resolver este problema, se puede firmar el módulo mimodulo.ko usando la herramienta `scripts/sign-file` en el árbol de código fuente del kernel y la clave privada especificada por la opción de tiempo de compilación `CONFIG_MODULE_SIG_KEY3`. Si esta opción no está establecida, se utilizará la clave autogenerada por defecto en `certs/signing_key.pem` en el árbol de código fuente del kernel.  
`[UFW BLOCK] …`: Estos mensajes son generados por el firewall UFW (Uncomplicated Firewall). UFW está bloqueando ciertos paquetes que están intentando pasar a través de la interfaz de red. Los detalles del mensaje te dan información sobre el paquete que fue bloqueado, incluyendo la interfaz de red (IN=wlp3s0), la dirección MAC de origen y destino, la dirección IP de origen y destino (SRC=192.168.0.1 DST=224.0.0.1), la longitud del paquete (LEN=32), entre otros.  
En la segunda imagen podemos observar:  
`wlp3s0: deauthenticating from 38:6b:1c:bd:4c:8c by local choice (Reason: 3=DEAUTH_LEAVING)`: Este mensaje indica que el dispositivo de red inalámbrica (wlp3s0) se está desautenticando de la red con la dirección MAC 38:6b:1c:bd:4c:8c. La razón “3=DEAUTH_LEAVING” significa que la desautenticación se debe a que el cliente está dejando (o se desconecta de) la red.  
`PM: suspend entry (deep)`: Este mensaje indica que el sistema está entrando en un estado de suspensión profunda, también conocido como S3 o suspensión a RAM2.  
`Filesystems sync: 0.025 seconds`: Este mensaje indica que el sistema ha sincronizado los sistemas de archivos, es decir, que todos los datos pendientes se han escrito en el disco. Esto se hace generalmente antes de entrar en un estado de suspensión para asegurar que no se pierdan datos.  
`Freezing user space processes … (elapsed 0.009 seconds) done.`: Esto quiere decir que el sistema ha “congelado” los procesos del espacio de usuario como parte del proceso de suspensión. “Congelar” un proceso significa que se le impide ejecutar cualquier código adicional.  
`OOM killer disabled.`: Este mensaje indica que el “asesino de memoria insuficiente” (OOM killer) del kernel de Linux ha sido desactivado. El OOM killer es un mecanismo del kernel que se activa cuando el sistema se queda sin memoria. Su trabajo es seleccionar y matar procesos para liberar memoria.  
`printk: Suspending console(s) (use no_console_suspend to debug)`: Esto nos indica que las consolas del sistema están siendo suspendidas. Si se quisiera depurar el proceso de suspensión, se podría usar la opción `no_console_suspend`.  
  
Otro comando que podemos ejecutar es:  
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ sudo dmesg | grep -i usb2 `  
El cual nos devuelve:  
` [    3.512659] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15
[    3.512666] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.512668] usb usb2: Product: xHCI Host Controller
[    3.512670] usb usb2: Manufacturer: Linux 5.15.0-107-generic xhci-hcd
[    3.512673] usb usb2: SerialNumber: 0000:00:15.0 `  
Y las respectivas explicaciones de cada línea son:  
`usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15`: aquí se indica que se ha encontrado un nuevo dispositivo USB en el puerto usb2. Los campos idVendor y idProduct son identificadores numéricos que especifican el fabricante y el producto del dispositivo USB. En este caso, idVendor=1d6b y idProduct=00031. El campo bcdDevice es la versión del dispositivo.  
`usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1`: Este mensaje indica que el dispositivo USB tiene ciertos campos de cadena definidos. Estos campos pueden proporcionar información adicional sobre el dispositivo en un formato legible por humanos. En este caso, los campos definidos son Mfr (fabricante), Product (producto) y SerialNumber (número de serie).  
`usb usb2: Product: xHCI Host Controller`: Esta línea refiere a que el producto del dispositivo USB es un controlador de host xHCI. xHCI (eXtensible Host Controller Interface) es una interfaz para los controladores de host de dispositivos USB de versión 2.0 y superior.  
`usb usb2: Manufacturer: Linux 5.15.0-107-generic xhci-hcd`: nos dice que el fabricante del dispositivo USB es el controlador de host xHCI del kernel de Linux 5.15.0-107-generic.  
`usb usb2: SerialNumber: 0000:00:15.0`: con esto sabemos que el número de serie del dispositivo USB es 0000:00:15.0.  

- A continuacion al ejecutar:  
` lsmod | grep mod `
obtenemos: mimodulo               16384  0  
El comando lsmod muestra todos los módulos del kernel que están actualmente cargados en el sistema. La opción `| grep mod` filtra la salida para mostrar solo las líneas que contienen la cadena “mod”.
En este caso, la salida refiere a que el módulo del kernel mimodulo está cargado en el sistema. El número 16384 representa el tamaño del módulo en bytes. El último número 0 indica que ningún otro módulo depende de mimodulo.  
- Si ejecutamos  
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ cat /proc/modules  | grep mod `  
retorna:  
` mimodulo 16384 0 - Live 0x0000000000000000 (OE) `  

Esto muestra información sobre los módulos del kernel que están actualmente cargados en el sistema y que contienen la cadena “mod” en su nombre.
El módulo del kernel mimodulo está cargado en el sistema. Cada campo de la salida quiere decir:  
`mimodulo`: Este es el nombre del módulo del kernel.  
`16384`: Este es el tamaño del módulo en bytes.  
`0`: Este es el número de instancias del módulo que están actualmente cargadas. Un valor de 0 significa que el módulo está cargado pero no se está utilizando.  
`Live`: Este campo indica el estado del módulo. “Live” significa que el módulo está activo y en funcionamiento.  
`0x0000000000000000`: Esta es la dirección de memoria donde se carga el módulo.  
`(OE)`: Estas son las banderas del módulo. “O” significa que el módulo es oficial (es decir, que forma parte del kernel oficial de Linux) y “E” significa que el módulo está en un estado de error.  

- Finalmente ejecutamos:  
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ sudo rmmod mimodulo `  
El comando `sudo rmmod mimodulo` se utiliza para eliminar el módulo del kernel mimodulo.
Cuando ejecutamos sudo rmmod mimodulo, le damos instrucciones al sistema para que descargue el módulo mimodulo del kernel. Esto significa que las funcionalidades proporcionadas por este módulo ya no estarán disponibles para el kernel.  
- Ahora al ejecutar  
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ lsmod | grep mod `  
o tambien  
` ~/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module$ cat /proc/modules  | grep mod `  
no nos devuelven nada ya que en el paso anterior borramos el modulo  

- Con los comandos  
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
`filename`: el nombre del archivo del módulo del kernel.  
`author`: el autor del módulo del kernel.  
`description`: Esta es una breve descripción del módulo del kernel.  
`license`: Esta es la licencia bajo la cual se distribuye el módulo del kernel.  
`srcversion`: la versión del código fuente del módulo del kernel.  
`depends`: Esta es una lista de otros módulos del kernel de los que depende este módulo.  
`retpoline`: Este campo indica si el módulo del kernel está compilado con protecciones Retpoline para mitigar la vulnerabilidad de ejecución especulativa del procesador.  
`name`: el nombre del módulo del kernel.  
`vermagic`: cadena que contiene la versión del kernel, el tipo de CPU, el estado de SMP (Symmetric MultiProcessing), y otras opciones que deben coincidir exactamente con el kernel en ejecución para que el módulo pueda ser cargado.  

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

Muestra información sobre el módulo del kernel des_generic.ko. Cada campo de la salida quiere decir:
`filename`: el nombre del archivo del módulo del kernel.  
`alias`: los alias del módulo del kernel. Los alias son nombres alternativos que se pueden usar para referirse al módulo.  
`author`: Este es el autor del módulo del kernel.  
`description`: Esta es una breve descripción del módulo del kernel.
`license`: Esta es la licencia bajo la cual se distribuye el módulo del kernel.  
`srcversion`: Esta es la versión del código fuente del módulo del kernel.  
`depends`: Esta es una lista de otros módulos del kernel de los que depende este módulo.  
`retpoline`: Este campo indica si el módulo del kernel está compilado con protecciones Retpoline para mitigar la vulnerabilidad de ejecución especulativa del procesador.  
`intree`: Este campo indica si el módulo del kernel está incluido en el árbol de código fuente del kernel.
`name`: Este es el nombre del módulo del kernel.  
`vermagic`: Esta es una cadena que contiene la versión del kernel, el tipo de CPU, el estado de SMP (Symmetric MultiProcessing), y otras opciones que deben coincidir exactamente con el kernel en ejecución para que el módulo pueda ser cargado.  
`sig_id`: Este campo indica el tipo de firma digital utilizada para firmar el módulo del kernel.  
`signer`: Este campo indica la entidad que firmó el módulo del kernel.  
`sig_key`: Esta es la clave pública utilizada para verificar la firma digital del módulo del kernel.  
`sig_hashalgo`: Este campo indica el algoritmo de hash utilizado para generar la firma digital del módulo del kernel.  
`signature`: Esta es la firma digital del módulo del kernel.  

### ¿Qué diferencias se pueden observar entre los dos modinfo?  
Las diferencias observadas entre los dos comandos modinfo ejecutados son:  
* Módulo del kernel: El primer comando `modinfo mimodulo.ko` muestra información sobre el módulo del kernel personalizado mimodulo.ko, mientras que el segundo comando `modinfo /lib/modules/$(uname -r)/kernel/crypto/des_generic.ko` nos da la información sobre el módulo del kernel estándar `des_generic.ko` que se encuentra en la ruta `/lib/modules/$(uname -r)/kernel/crypto/`.
* Información del módulo: La información proporcionada por los dos comandos modinfo es diferente porque los dos módulos del kernel son diferentes. Por ejemplo, el autor, la descripción, la licencia, la versión del código fuente, las dependencias, el nombre y la firma digital del módulo son diferentes para `mimodulo.ko` y `des_generic.ko`.
* Dependencias del módulo: El módulo `mimodulo.ko` no tiene dependencias, mientras que el módulo `des_generic.ko` depende del módulo `libdes`.
* Alias del módulo: El módulo `mimodulo.ko` no tiene alias, mientras que el módulo `des_generic.ko` tiene varios alias.
* Firma digital del módulo: El módulo `mimodulo.ko` no tiene una firma digital, mientras que el `módulo des_generic.ko` tiene una firma digital.

### ¿Qué drivers/modulos estan cargados en sus propias pc?
Para poder ver esto se debe ejecutar el comando ` lsmod `.  
En la carpeta "ModulosIntegrantes" se encuentra un .txt por cada uno de los integrantes, con las salidas de sus pcs. con los comandos `diff GastonSegura.txt LourdesGuyot.txt > diffGS-LG.txt` y `diff GastonSegura.txt FedericaMayorga.txt > diffGS-FM.txt` obtenemos dos txt con las diferencias.  
Para entender un poco mas, se aclara que: Las líneas que comienzan con **<** representan líneas del primer archivo que no están en el segundo archivo y las líneas que comienzan con **>** representan líneas del segundo archivo que no están en el primer archivo. Vemos que en cuanto a las diferencias entre GS y LG: Hay varios módulos que están presentes en el primer conjunto pero no en el segundo, algunos de estos incluyen `mimodulo, nft_chain_nat, xt_MASQUERADE, nf_nat, nf_conntrack_netlink, xfrm_user, xfrm_algo, br_netfilter, bridge, stp, llc, ccm, rfcomm, overlay, cmac, algif_hash, algif_skcipher, af_alg, bnep, ip6t_REJECT, nf_reject_ipv6, xt_hl, ip6_tables, ip6t_rt`; Algunos módulos están presentes en ambos conjuntos, como `binfmt_misc, zfs, zunicode, zzstd, zlua, zavl, icp, zcommon, znvpair, spl, intel_rapl_msr, snd_hda_codec_hdmi, snd_hda_codec_realtek, snd_hda_codec_generic`.  
En cuanto a las diferencias entre GS y FM, hay algunos módulos que están presentes en el primer conjunto pero no en el segundo: `snd_compress, ac97_bus, snd_pcm_dmaengine, snd_intel_dspcfg, snd_intel_sdw_acpi, intel_rapl_msr, intel_rapl_common, intel_pmc_bxt, intel_telemetry_pltdrv, mei_hdcp, intel_punit_ipc, intel_telemetry_core`; y, algunos de los módulos presentes en ambos conjuntos: `snd_hda_codec_hdmi, nls_iso8859_1, snd_hda_intel, intel_rapl_msr, snd_intel_dspcfg, snd_intel_sdw_acpi, snd_hda_codec, intel_rapl_common, snd_hda_core, snd_hwdep, snd_pcm`.  

### ¿Cuáles no están cargados pero están disponibles? ¿Qué pasa cuando el driver de un dispositivo no está disponible?.
Para saber qué módulos del kernel están disponibles en cada sistema, se puede usar el comando `ls -R /lib/modules/$(uname -r)`  
Para saber qué módulos del kernel están actualmente cargados en el sistema, se puede ejecutar el comando `lsmod` 
Para realizar esta actividad se ha realizado un script de bash (llamado "scriptPreguntaCargNoDisp.sh") que encuentra cuales son los modulos están disponibles pero no guardados. Este script da como resultado una enorme cantidad de módulos, se adjunta una captura de una pequeñisima parte de todo lo obtenido:  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/2299608c-d3eb-496c-84f9-c1bf4f73252d)  
Cuando el driver de un dispositivo no está disponible, pueden ocurrir varios problemas:
* El dispositivo puede no ser reconocido por el sistema operativo, lo que significa que no se puede utilizar.
* Pueden surgir problemas de rendimiento, como una conexión de internet lenta, falta de calidad en el sonido o problemas de visualización en la pantalla.  
Existen varias soluciones para resolver este problema: 
* Actualizar el controlador del dispositivo: A veces, el problema puede ser causado porque el controlador del dispositivo no está actualizado.
* Desinstalar y reinstalar el controlador: Si el controlador está dañado o no funciona correctamente, desinstalarlo y luego reinstalarlo puede resolver el problema.

### hwinfo 
CONSIGNA: Correr hwinfo en una pc real con hw real y agregar la url de la información de hw en el reporte.  
En primer lugar, realizamos la instalación con el comando `sudo apt install hwinfo` , luego ejecutamos `hwinfo`. Como nos devuelve mucha información, hacemos `hwinfo > hwinfo.txt` para almacenarla y verla de una mejor manera.
Este txt es subido al drive como lo pide la consigna, aqui el link: [hwinfo.txt](https://drive.google.com/file/d/1Fl7qJL2dBHWLC2pBckQbaIGVLtf-Twwj/view?usp=drive_link)  
hwinfo es una herramienta de línea de comandos muy útil para obtener detalles sobre los componentes de hardware del sistema. Se utiliza para sondear el hardware presente en el sistema. Puede generar un registro de descripción general del sistema que luego puede ser utilizado para soporte.  
Muestra información sobre la mayoría de las unidades de hardware, incluyendo CPU, RAM, tarjetas gráficas, controladores USB, entre otros. Además, hwinfo puede ser usado con varios parámetros de línea de comandos para crear informes de hardware en varios formatos como texto, CSV, XML.

### ¿Qué diferencia existe entre un módulo y un programa? 
Las diferencias que podemos notar son las siguiente:
- Función: Un programa es una aplicación que se ejecuta en el sistema operativo para realizar una tarea específica, como procesar texto o navegar por la web. Por otro lado, un módulo es un componente de software que realiza una función específica dentro de un sistema mayor. Por ejemplo, un driver es un tipo de módulo que permite que el sistema operativo se comunique con un dispositivo de hardware.
- Interacción con el sistema operativo: Los programas invocan funciones específicas del sistema operativo para realizar sus tareas. En cambio, los módulos, como los drivers, son invocados por el sistema operativo para interactuar con el hardware.
- Ubicación en el sistema: Los programas suelen estar almacenados en el disco duro y se cargan en la memoria cuando se ejecutan. Los módulos, por otro lado, pueden ser cargados y descargados dinámicamente en el sistema, de manera que solo están activos en memoria cuando se les necesita.
-Reutilización de código: En la programación modular, los módulos permiten reutilizar código y compartir funciones entre programas. En cambio, aunque un programa puede contener funciones reutilizables, es una entidad independiente que se ejecuta para realizar una tarea específica.

### ¿Cómo puede ver una lista de las llamadas al sistema que realiza un simple helloworld en c? 
Para esto, primero creamos un archivo que se llama "HelloWorld.c" , luego ejecutamos ` gcc -Wall -o hello hello.c `. Al archivo "hello" que obtenemos como resultado, lo ejecutamos con los comandos: ` strace ./hello `. Nos devuelve bastante código (se almacena en el repositorio en un archivo llamado "SyscallsHello.txt"), en el cual cada línea que se ve corresponde a una llamada al sistema.` Strace ` es un programa útil que le brinda detalles sobre qué llamadas al sistema realiza un programa, incluida qué llamada se realiza, cuáles son sus argumentos y qué devuelve. 
En la penúltima linea de codigo del archivo podemos observar un: ` write(1, "hello world", 11hello world)             = 11 ` que es lo que está detrás del "printf("hello world")" que se ve en el programa de C.

### ¿Qué es un segmentation fault? ¿Cómo lo maneja el kernel y cómo lo hace un programa?
Cuando se ejecuta el programa y el sistema de informes del sistema lanza una "violación de segmentación", significa que el programa ha intentado acceder a un área de memoria a la cual no le está permitido el acceso. En otras palabras, se trató de acceder a una parte de la memoria que está más allá de los límites que el sistema operativo (Unix GNU/Linux ect) ha asignado para el programa.
Algunas causas comunes de este problema son:
- El uso incorrecto de los operadores "&" (dirección/address of) y "*" (indireccion/dereferencing)
- Cadena de control de formato incorrecto en declaraciones printf o scanf
- olvidarse de usar "&" en los argumentos de scanf 
- Acceso a más allá de los límites de una matriz/vector o similar
- Error al inicializar un puntero antes de acceder a él
- Tratar de acceder a una parte de la memoria de manera inadecuada aún estando accesible para su programa.
- Intentar acceder a un objeto o variable que ha sido borrado de la memoria

Cómo lo maneja el kernel: Cuando ocurre un Segmentation Fault, el sistema operativo recibe una interrupción del hardware. El kernel del sistema operativo debe determinar la causa del error y si se puede hacer algo al respecto. En algunos casos, como las referencias a punteros nulos, lo mejor que puede hacer el kernel es informar a la aplicación que ha ocurrido un error.

Cómo lo maneja un programa: Desde el punto de vista del programa, un Segmentation Fault generalmente resulta en que el programa se detenga inmediatamente y se genere un informe de error. Los programadores pueden utilizar herramientas de depuración, como gdb, para examinar el estado del programa en el momento del error y determinar qué parte del código causó el problema.

### Firmar un módulo de kernel
¿Se animan a intentar firmar un módulo de kernel y documentar el proceso?  
https://askubuntu.com/questions/770205/how-to-sign-kernel-modules-with-sign-file  
Agregar evidencia de la compilación, carga y descarga de su propio módulo imprimiendo el nombre del equipo en los registros del kernel. 

- En primerlugar instalamos los modulos: openssl , sign-file , mokutil y keyctl  
- Luego vamos a Generar un par de claves X.509, ya que son necesarias una clave privada para firmar el módulo y una clave pública para verificar la firma. Para ello utilizando OpenSSL, vamos a seguir estos pasos:
  1- Generar una clave privada: La clave privada se utiliza para firmar el módulo. Podemos generar una clave privada RSA de 2048 bits con el siguiente comando:`openssl genrsa -out private.key 2048`
  2- Crear un certificado X.509: El certificado X.509 contiene la clave pública y se utiliza para verificar la firma. Creamos un certificado X.509 que sea válido por 365 días con el siguiente comando: `openssl req -new -x509 -key private.key -out publickey.cer -days 365`. Este comando nos pide ingresar información que se incorporará en a la solicitud de certificado. Tuvimos proporcionar detalles como el nombre de país (código de 2 letras), el nombre de la provincia, el nombre de localidad, el nombre de organización, el nombre de una unidad organizativa, el nombre propio y dirección de correo electrónico.  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/fe0a2391-ca90-4f73-89bc-3b12fec8c5cb)  
Para verificar que los dos pasos se realizaron correctamente, ejecutamos primero `openssl rsa -check -in private.key` para verificar la validez de la clave privada.  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/90ec884a-9031-4fff-b5cc-903f0141b741)  
luego `openssl x509 -in publickey.cer -text -noout` para Verificar el certificado X.509  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/c0979bb4-7101-480e-9675-a27b4d1e60db)  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/d72fe4c9-4b38-4419-ad9f-8808e4af0251)  
y por ultimo `openssl x509 -in publickey.cer -noout -pubkey openssl rsa -in private.key -pubout` para verificar la correspondencia entre la clave privada y el certificado: La clave pública contenida en la clave privada y el certificado debe ser la misma, lo cual se verifica al observar que ambos comandos deben producen la misma salida.  

- El tercer paso es firmar el módulo: Usar la herramienta sign-file que viene con el código fuente del kernel para firmar el módulo. Proporcionamos la clave privada, la clave pública y el módulo del kernel con el que estamos trabajando.  
  1- en primer lugar se ubica la herramienta sign-file: La herramienta sign-file se encuentra en el directorio scripts/ del código fuente del kernel de Linux. En la mayoría de los sistemas, se encuentra en `/usr/src/linux-headers-$(uname -r)/scripts/`  
  ![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/aa7ef802-4554-4f75-bc3d-64a298c7981f)  
  2- Se procede a firmar el módulo del kernel: Firmamos el módulo del kernel utilizando el siguiente comando: `sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 private.key publickey.cer /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/mimodulo.ko` (sha256 es el algoritmo de hash que se utiliza para la firma, private.key es la clave privada, publickey.cer es la clave pública y mimodulo.ko es el módulo del kernel que deseamos firmar). "mimodulo.ko" es el modulo que forkeamos al inicio. Para verificar que se realizó de forma correcta la firma del modulo, usamos el comando modinfo. Este comando muestra información sobre un módulo del kernel Linux: `modinfo /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/mimodulo.ko`  
  ![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/17962672-0a2b-4e8b-9e47-cf6e86513558)  

- El cuarto paso es cargar la clave pública en el sistema objetivo: Para que el kernel pueda verificar la firma del módulo, cargamos la clave pública en el sistema. Esto se hace con la herramienta mokuti
  1- Asegurándonos de que el sistema esté utilizando el arranque seguro UEFI: verificamos esto con el comando `efibootmgr -v`: luego de realizamos este paso y, al obtener algunas respuestas erróneas, se descubre que en el sistema utilizado para realizar este ejercicio, no se inicia en modo UEFI, por lo tanto este paso no es necesario. En este caso, se pueden firmar los módulos y el sistema los reconoce como seguros, aunque la seguridad proporcionada será menor en comparación con un sistema con UEFI Secure Boot habilitado.  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/0b6ba79e-eb0c-485c-907e-e13636a4336f)  
 Entonces lo que se realizan son estos pasos:  
  - Copiamos el módulo firmado al directorio apropiado: Por lo general, los módulos del kernel se almacenan en el directorio `/lib/modules/$(uname -r)/kernel/`. Copiamos el módulo firmado a este directorio o a un subdirectorio apropiado dentro de él:  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/5d30dbd0-567f-411d-92e6-3b8c92b2a145)  
Luego, al realizar el copiado del modulo:  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/5db4b713-9e2b-436f-8f0e-5b23ac6f00ce)  
- siguiente paso: Registrar el módulo con depmod: depmod es una utilidad que genera un archivo de dependencias para los módulos del kernel. Podemos usarlo para registrar el módulo firmado con el sistema. Entonces ejecutamos:  `gaston@gaston-Lenovo-ideapad-320-14IAP:/lib/modules/5.15.0-107-generic/kernel$ sudo depmod -a`  
- el ultimo paso es: Cargar el módulo con modprobe o insmod: modprobe y insmod son utilidades que se usan para cargar módulos en el kernel1modprobe es generalmente preferible porque maneja las dependencias del módulo automáticamente.  
- Para verificar si el modulo se cargo correctamente usamos lsmod y modinfo  
![image](https://github.com/gastonsegura2908/SistDeCompTP4/assets/54334534/9cdba381-7e7c-4138-aa06-86350ede40a9)  


4- Firmar los Módulos del Kernel:
Una vez inscritas las claves, los módulos del kernel deben ser firmados usando la clave privada.
Ejemplo de firma de un módulo:
`sh
Copy code
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 MOK.priv MOK.der /path/to/module.ko`  


### Secure boot 
- ¿Qué pasa si mi compañero con secure boot habilitado intenta cargar un módulo firmado por mí? 
Secure Boot es una característica de seguridad que verifica que cada pieza de software tiene una firma válida antes de permitir que se ejecute. Esto incluye el sistema operativo, los controladores de dispositivos y los módulos del kernel.
Si un compañero tiene Secure Boot habilitado e intenta cargar un módulo firmado por mí, el resultado dependerá de si la clave pública correspondiente a mi firma privada ha sido añadida al almacén de claves del sistema en mi computadora.
Si un compañero intenta cargar un módulo firmado por mí, pero mi clave pública no ha sido añadida a su almacén de claves, el módulo no se cargará. Esto se debe a que Secure Boot no puede verificar la firma del módulo.
Para que un compañero pueda cargar el módulo firmado por mí, tendría que proporcionarle mi clave pública. EL compañero tendría que añadir esta clave a su almacén de claves utilizando una herramienta como ` mokutil `. Una vez que mi clave pública esté en su almacén de claves, Secure Boot podrá verificar la firma del módulo y permitir que se cargue.
