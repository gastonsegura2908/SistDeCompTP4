cmd_/home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/Module.symvers := sed 's/\.ko$$/\.o/' /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/modules.order | scripts/mod/modpost -m -a  -o /home/gaston/Documentos/SdC_Proyectos/TP4_SdC_Practico/kenel-modules-tp-4/part1/module/Module.symvers -e -i Module.symvers   -T -