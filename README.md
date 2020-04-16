
## Explorador del Gasto Público Consolidado por finalidad y función


### Introducción

El *"Gasto Público Consolidado por finalidad y función"* es una forma en la cual la [Secretaría de Política Económica del Ministerio de Economía, Presidencia de la Nación](https://www.argentina.gob.ar/economia/politicaeconomica/macroeconomica/gastopublicoconsolidado) presenta la información respecto al gasto público en la Argentina. 

La clasificación _"Consolidado"_ es porque incluye los tres niveles de gobierno: nación, provincias y municipios. La denominación "finalidad y función"

Tal como define el [Manual de Clasificaciones Presupuestarias para el Sector Público Nacional - Sexta Edición Actualizada 2016](https://www.minhacienda.gob.ar/onp/documentos/manuales/clasificador16.pdf) la clasificación "por finalidad y función" responde a que _presenta el gasto público según la naturaleza de los servicios que las instituciones públicas brindan a la comunidad. Los gastos clasificados por finalidad y función permiten determinar los objetivos generales y los medios a través de los cuales se estiman alcanzar éstos. En estos términos la clasificación por finalidades y funciones se constituye en un instrumento fundamental para la toma de decisiones por el poder político._ 

Por lo tanto, el Gasto Público Consolidado se puede analizar desde muchas aristas diferentes: desde los niveles de gobierno, desde las funciones y desde la presentación de los datos. Para hacer más sencillo el análisis, se desarrolló el *Explorador del Gasto Público Consolidado*.

Este repositorio agrupa las rutinas necesarias para transformar las datos crudos de la página de Secretaría de Política Económica en un archivo final que utiliza el _Explorador del Gasto Público Consolidado_. A su vez, hay un diccionario de las variables


### Explorador del Gasto Público Consolidado

El *[Explorador del Gasto Público Consolidado](https://lautarocantar.shinyapps.io/gpc_v1)* es una aplicación web desarrollada con R y Shany que permite explorar de forma interactiva las diferentes aristas del _Gasto Público Consolidado por finalidad y función_. 


### Fuentes de Información

La Secretaría de Política Económica publica 4 archivos diferentes (uno para cada nivel de gobierno y un archivo consolidado). Cada uno de los archivos contiene 3 pestañas que presentan los mismos datos de diferente formas: en precios corrientes, en porcentaje del PBI o como porcentaje del Gasto Público Consolidado sin Servicios de la Deuda.

Aquí se puede acceder a dichos archivos (al hacer click, se descarga cada uno de los archivos):

* [Gasto público consolidado por finalidad y función 1980-2017](https://www.argentina.gob.ar/sites/default/files/gasto_publico_consolidado_1980-2017.xlx)
* [Gasto público nacional por finalidad y función 1980-2017](https://www.argentina.gob.ar/sites/default/files/gasto_publico_nacional_1980-2017.xls)
* [Gasto público provincial por finalidad y función 1980-2017](https://www.argentina.gob.ar/sites/default/files/gasto_publico_provincial_1980-2017.xls)
* [Gasto público municipal por finalidad y función 1980-2017](https://www.argentina.gob.ar/sites/default/files/gasto_publico_municipal_1980-2017.xls)

### Diccionario de variables

Con el código que se encuentra en la carpeta `01_scripts/` (escritos en R), se logra pasar de cada archivo individual a una gran tabla que es más sencilla de trabajar con filtros y es más adecuada para realizar visualizaciones. [Aquí se puede descargar el archivo final](https://github.com/lautarocantar/gasto-publico-consolidado/raw/master/02_archivos/02_03_finales/consolidado_final.xlsx)

#### Variables:

* *"codigo"*: código de la finalidad o función.
* *"finalidad_funcion"*: nombre de la finalidad o función.
* *"base"*: se refiere al año que se utiliza como base para los cálculos:
    + _"normal"_: los valores que salen de las tablas
    + _"base_1980"_: tomando el año 1980 como 100, qué evolución tuvieron los valores
* *"Nivel"*: los valores se refieren al documento original de dónde vienen los datos, hay 4 categorías:
    + _Consolidado_: : Gasto Público Consolidado
    + _Nacional_: Gasto Público Nacional
    + _Provincial_: Gasto Público Provincial
    + _Municipal_: : Gasto Público Municipal
* *"fuente"*: refiere cómo fueron presentados los datos (plantilla del archivo original):
    + _"pje_pbi"_: valores en porcentaje del PBI
    + _"pje_gpc"_: valores en porcentaje del GPC sin Serv. Deuda (IV)
* *"anio"*: año del registro
* *"valor"*: valor del registro

