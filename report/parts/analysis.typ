#import "../mymacros.typ": two-tone-table

#let dataset = csv("../../data/obesity-prediction-dataset.csv")
#let duplicates = csv("../../data/duplicates.csv")

= Análisis exploratorio de datos
Empezaremos con un análisis del _dataset_ elegido, para obtener posible información oculta en el mismo.
Para éste análisis, se ha usado la librería de Python `ydata-profiling` @ydata-profiling.

El _dataset_ consta de las siguientes variables:
- _Gender_: Género (sexo) de la persona
- _Age_: Edad de la persona
- _Height_: Altura, en metros
- _family_history_with_overweight_: Si la persona tiene un historial familiar de sobrepeso
- _FAVC_: Si la persona consume alimentos con alto contenido calórico
- _FCVC_: Frecuencia de consumición de vegetales (escala de 1 a 3).
- _NCP_: Número de comidas principales diarias
- _CAEC_: Frecuencia de consumición de alimentos entre comidas (_Never_, _Sometimes_, _Frequently_, _Always_)
- _SMOKE_: Si la persona fuma
- _CH2O_: Consumición diaria de agua (escala de 1 a 3)
- _SCC_: Si la persona monitoriza las calorías que consume
- _FAF_: Frecuencia de actividad física (escala de 0 a 3)
- _TUE_: Tiempo gastado usando dispositivos electrónicos (escala de 0 a 3)
- _CALC_: Frecuendia de consumición de alcohol (_Never_, _Sometimes_, _Frequently_, _Always_)
- _MTRANS_: Principal modo de transporte (_Automobile_, _Bike_, _Motorbike_, _Public_ _Transportation_, _Walking_)
- _NObeyesdad_: Nivel de obesidad (_Insufficient Weight_, _Normal Weight_, _Overweight Level I_, _Overweight Level II_, _Obesity Type I_, _Obesity Type II_, _Obesity Type III_).


== Estadísticas descriptivas
Las principales características de los datos quedan recogidas en la @tab:dataset-stats y @tab:dataset-types.


#let total_duplicates = duplicates.slice(1).fold(
  0,
  (sum, row) => { sum + int(row.pop() ) }
)

#figure(
  two-tone-table(
    columns: 2,
    align: (left, right),
    [Número de características],[#dataset.at(0).len()],
    [Número de observaciones],[#dataset.len()],
    [Celdas vacías],[0],
    [Registros duplicados],[#(duplicates.len() - 1) (#total_duplicates)],
    [% duplicados],[#str(total_duplicates * 100 / (dataset.len() - 1)).slice(0, 4)%],
  ),
  caption: [Estadísticas del _dataset_]
) <tab:dataset-stats>

#figure(
  two-tone-table(
    columns: 2,
    align: (left, right),
    [Categóricas],[5],
    [Numéricas],[8],
    [Booleanas],[4],
  ),
  caption: [Tipos de características]
) <tab:dataset-types>


Como podemos observar, no hay celdas vacías y los tipos de variables usadas están perfectamente descritas y enumerados, por lo que es fácil tratar con los datos. Sin embargo, también podemos observar que hay un número significativo de registros duplicados.

Analizando estos casos en la @fig:duplicates, vemos que la mayoría están duplicadas de dos a cuatro veces, mientras que hay una en específico que está duplicada catorce veces.

// SVGs optimizados con https://jakearchibald.github.io/svgomg/
#figure(
  image(width: 80%, "../img/duplicates.svg"),
  caption: "Cantidad de registros duplicados por registro duplicado"
) <fig:duplicates>


#let main_duplicate = duplicates.at(0).zip(duplicates.at(1))  // first row is the one w/ the most duplicates
#let duplicate_percentage = int(main_duplicate.to-dict().at("# duplicates")) * 100 / (dataset.len() - 1)

En la @tab:duplicate se puede observar con más detenimiento éste caso. Dado que estos duplicados suponen apenas un #{str(duplicate_percentage).slice(0, 4)}% del _dataset_, y dado que se refieren a varones de edad joven y estatura y peso medio para su país de origen, podríamos asumir que se trata de una simple casualidad.

#figure(
  two-tone-table(
    columns: 2,
    align: (left, right),
    ..main_duplicate.flatten()
  ),
  caption: "Registro con mayor número de duplicados"
) <tab:duplicate>


== Evaluación de las características
A continuación evaluaremos las características para observar qué tipo de preprocesado es necesario realizar para mejorar el entrenamiento.

=== Análisis univariable
Primero, analizaremos las distintas características de forma aislada, y mencionaré las más relevantes #footnote([Para un resumen detallado, ver el _notebook_ `analysis.ipynb`.]).

Hay características muy desbalanceadas, como son _family_history_with_overweight_ (_True_, 81.8%), _FAVC_ (_True_, 88.4%), _CAEC_ (_Sometimes_, 83.6%), _SMOKE_ (valor _False_, 97.9%), _SCC_ (_False_, 95.5%), _MTRANS_ (_Public_Transportation_, 74.8%). Sin embargo, la característica objetivo, _NObeyesdad_, está relativamente balanceada, como se puede observar en la @fig:target-distribution.

Con respecto a las variables de rangos numéricos (_FCVC_, _NCP_, _CH20_, _FAF_, _TUE_), podemos observar que un pequeño porcentaje de los registros contienen valores entre los rangos discretos, lo cual puede ser debido a errores en la recogida de los datos. Un ejemplo de esto queda reflejado en la @fig:ch2o-distribution.

#figure(
  image(width: 65%, "../img/target_distribution.svg"),
  caption: [Distribución de la característica _NObeyesdad_]
) <fig:target-distribution>

#figure(
  image(width: 85%, "../img/ch2o_distribution.svg"),
  caption: [Distribución de la característica _CH2O_]
) <fig:ch2o-distribution>



=== Análisis multivariable
La @fig:feature-correlation muestra la correlación entre las distintas características. Si nos fijamos en la columna de _NObeyesdad_, observamos que tanto el género, como el peso y el historial familiar con el peso están bastante relacionados con la obesidad. Los dos primeros tienen sentido, pero es el caso del género el que resulta extraño. Si observamos más detenidamente el tipo de obesidad por género (véase @fig:gender-correlation), podemos ver que en el caso de Obesidad de tipo II, no hay apenas mujeres, mientras que en el caso del tipo III, no hay apenas hombres.

#figure(
  image(width: 90%, "../img/feature_correlation.svg"),
  caption: [Correlación entre las distintas características]
) <fig:feature-correlation>

#figure(
  image(width: 65%, "../img/gender.svg"),
  caption: [Correlación entre el género y el tipo de obesidad]
) <fig:gender-correlation>