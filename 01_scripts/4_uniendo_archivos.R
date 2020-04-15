
# Proyecto: Gasto Público Consolidado
# Autor: Lauti Cantar

# Archivo: Archivo que une los archivos resultantes de los scripts 1, 2 y 3

# ------------------------------------------------------------------------------------------------
#                               0. Abriendo paquetes y datos
# ------------------------------------------------------------------------------------------------

library(tidyverse)
library(ggplot2)
library(readxl)
library(janitor)

# Abriendo los archivos

nuevas_cats <- read_excel("02_archivos/02_02_intermedios/nueva_clasificacion.xlsx")

dat_pbi <- read_excel("02_archivos/02_03_finales/consolidado_pbi.xlsx")

dat_gpc <- read_excel("02_archivos/02_03_finales/consolidado_gpc.xlsx") 


# ------------------------------------------------------------------------------------------------
#                               1. Jugando con los archivos
# ------------------------------------------------------------------------------------------------

# Uniendo los archivos
dat <- rbind(dat_pbi, 
             dat_gpc)

# Agregando las nuevas categorias
dat <- dat %>% 
  left_join(nuevas_cats %>% select(-finalidad_funcion), by = "codigo")

# ------------------------------------------------------------------------------------------------
#                               2. Exportando el archivo final
# ------------------------------------------------------------------------------------------------

# Guardando el archivo
openxlsx::write.xlsx(dat, "02_archivos/02_03_finales/consolidado_final.xlsx")

