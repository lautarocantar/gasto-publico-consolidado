
# ------------------------------------------------------------------------------------------------
#                               1. Funciones
# ------------------------------------------------------------------------------------------------


# Limpiar los datos ni bien entran desde Excel
limpiar_datos <- function(d){
  
  dat <- d %>% 
    clean_names() %>%         # Limpio los nombres
    rename(codigo = x1) %>%   # Le cambio el nombre a la primer columna
    remove_empty("rows") %>%  # Saco las filas en blanco del medio
    filter(!is.na(x2017))     # Limpio las notas del final
  
  return(dat)
}

# Hace la transformación según el Nivel de Gobierno
for_plot_nivel <- function(d, cod, nivel){
  
  dat <- d %>% 
    filter(codigo %in% cod) %>% 
    # select(-codigo) %>% 
    gather("anio", "valor", -codigo, -finalidad_funcion) %>% 
    mutate(anio = anio %>% str_remove("x") %>% as.numeric(),
           finalidad_funcion = finalidad_funcion %>%  as.factor(),
           Nivel = nivel) 

  return(dat)
}


for_plot_nivel_b80 <- function(d, cod, nivel){
  
  dat <- d %>% 
    filter(codigo %in% cod) %>% 
    # select(-codigo) %>% 
    gather("anio", "valor", -codigo, -finalidad_funcion) %>% 
    mutate(anio = anio %>% str_remove("x") %>% as.numeric(),
           finalidad_funcion = finalidad_funcion %>%  as.factor(),
           Nivel = nivel) 
  
  d.1 <- dat %>%
    filter(anio == 1980) %>%
    select(-anio) %>%
    rename(valor_1980 = valor)
  
  dat <- dat %>%
    left_join(d.1) %>%
    mutate(base_1980 = (valor / valor_1980)*100)
  
  return(dat)
}


# Para cada categoria, hace un dataframe con los 3 niveles de gobierno
consolidado_niveles <- function(codigo){
  
  cons <- gpc_cons %>%
    for_plot_nivel(cod = codigo, nivel = "Consolidado")
  
  mun <- gpc_mun %>%
    for_plot_nivel(cod = codigo, nivel = "Municipal") 
  
  prov <- gpc_pro %>% 
    for_plot_nivel(cod = codigo, nivel = "Provincial")
  
  nac <- gpc_nac %>% 
    for_plot_nivel(cod = codigo, nivel = "Nacional")
  
  tot <- rbind(cons, mun, prov, nac)
  
  return(tot)
  
}


consolidado_niveles_b80 <- function(codigo){
  
  cons <- gpc_cons %>%
    for_plot_nivel_b80(cod = codigo, nivel = "Consolidado")
  
  mun <- gpc_mun %>%
    for_plot_nivel_b80(cod = codigo, nivel = "Municipal") 
  
  prov <- gpc_pro %>% 
    for_plot_nivel_b80(cod = codigo, nivel = "Provincial")
  
  nac <- gpc_nac %>% 
    for_plot_nivel_b80(cod = codigo, nivel = "Nacional")
  
  tot <- rbind(cons, mun, prov, nac)
  
  return(tot)
  
}
