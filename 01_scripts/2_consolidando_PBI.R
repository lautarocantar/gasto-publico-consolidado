
# Proyecto: Gasto Público Consolidado
# Autor: Lauti Cantar

# Archivo: Archivo consolidado del GPC como % del PBI

# ------------------------------------------------------------------------------------------------
#                               0. Abriendo paquetes y datos
# ------------------------------------------------------------------------------------------------

library(tidyverse)
library(ggplot2)
library(readxl)
library(janitor)

# Cargando las funciones para analizar los datos
source("01_scripts/funciones.R")

# Abriendo los datos

# ------ % PBI ------ #

# Consolidados
gpc_cons <- read_excel("02_archivos/02_01_originales/gasto_publico_consolidado_1980-2017.xls", 
                       sheet = 2, skip = 3) %>% 
  limpiar_datos() 

# Nivel Nacional
gpc_nac <- read_excel("02_archivos/02_01_originales/gasto_publico_nacional_1980-2017.xls", 
                      sheet = 2,  skip = 3) %>% 
  limpiar_datos()

# Nivel Provincial
gpc_pro <- read_excel("02_archivos/02_01_originales/gasto_publico_provincial_1980-2017.xls", 
                      sheet = 2, skip = 3) %>% 
  limpiar_datos()

# Nivel Municipal
gpc_mun <- read_excel("02_archivos/02_01_originales/gasto_publico_municipal_1980-2017.xls", 
                      sheet = 2, skip = 3) %>% 
  limpiar_datos() 


# Definiendo las categorias
categorias <- c("1.0",
                "1.1",
                "1.1.1",
                "1.1.2",
                "1.1.3",
                "1.2",
                "1.2.1",
                "1.2.1.1",
                "1.2.1.2",
                "1.2.1.3",
                "1.2.1.4",
                "1.2.1.5",
                "1.2.2",
                "1.2.2.1",
                "1.2.2.2",
                "1.2.2.3",
                "1.2.3",
                "1.2.4",
                "1.2.5",
                "1.2.5.1",
                "1.2.5.2",
                "1.2.5.3",
                "1.2.6",
                "1.2.7",
                "1.2.7.1",
                "1.2.7.2",
                "1.2.8",
                "1.3",
                "1.3.1",
                "1.3.2",
                "1.3.3",
                "1.3.4",
                "1.3.4.1",
                "1.3.4.2",
                "1.3.5",
                "1.4",
                "1.4.1")


# ------------------------------------------------------------------------------------------------
#                               1. NIVELES - AÑOS NORMALES
# ------------------------------------------------------------------------------------------------

# Haciendo la union de todos los archivos provinciales

dat_normal_niveles <- data.frame()

for (i in 1:length(categorias)) {
  
  print(i)
  c <- categorias[i]

  d <- consolidado_niveles(c)  
  
  dat_normal_niveles <- rbind(dat_normal_niveles, d)
}


dat_normal_niveles <- dat_normal_niveles %>% 
  mutate(base = "normal",
         Nivel = factor(Nivel, levels = c("Consolidado", "Nacional", "Provincial", "Municipal"))) %>% 
  select(codigo, finalidad_funcion, base, Nivel, anio, valor)


# ------------------------------------------------------------------------------------------------
#                               2. NIVELES - AÑOS BASE 1980
# ------------------------------------------------------------------------------------------------

# Haciendo la union de todos los archivos provinciales

dat_1980_niveles <- data.frame()

for (i in 1:length(categorias)) {
  
  print(i)
  c <- categorias[i]
  
  d <- consolidado_niveles_b80(c)  
  
  dat_1980_niveles <- rbind(dat_1980_niveles, d)
}


dat_1980_niveles <- dat_1980_niveles %>% 
  select(-valor, -valor_1980) %>% 
  rename(valor = base_1980) %>% 
  mutate(base = "base_1980",
         Nivel = factor(Nivel, levels = c("Consolidado", "Nacional", "Provincial", "Municipal"))) %>% 
  select(codigo, finalidad_funcion, base, Nivel, anio, valor)

# ------------------------------------------------------------------------------------------------
#                               3. Compilando archivos y guardando
# ------------------------------------------------------------------------------------------------

dat <- rbind(dat_normal_niveles,
             dat_1980_niveles) %>% 
  mutate(fuente = "pje_pbi")


# Guardando el archivo
openxlsx::write.xlsx(dat, "02_archivos/02_03_finales/consolidado_pbi.xlsx")
