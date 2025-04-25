= Metodología


== Elección de la métrica de evaluación
// f1-macro porque balanceadas

== Preparación del _dataset_
Como observamos en la @sec:analistis-univariable, el _dataset_ está formado por variables tanto binarias, de rangos numéricos, y enumeradas. Para las variables binarias y enumeradas, es necesario codificarlas en valores numéricos #footnote([Para observar la codificación en detalle, ver el _notebook_ `analysis-preprocess.ipynb`.]) para el entrenamiento, ya que las entradas de nuestros modelos son numéricas.
// TODO: redo this

También se observó que las variables de rango contaban con un pequeño porcentaje de valores no enteros, los cuales se decidieron redondear al entero más cercano.


