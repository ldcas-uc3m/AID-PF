= Metodología

== Elección de la métrica de evaluación
El problema que nos encontramos es uno de clasificación multiclase. Para asegurarnos de que el clasificador es versátil y damos la misma importancia a la precisión y la exhaustividad, se decidió usar como métrica de evaluación el _F1-score_, específicamente en su versión _macro_, dado que, como mencionamos en la @fig:target-distribution, el _target_ está relativamente balanceado.

== Preparación del _dataset_
Como observamos en la @sec:analistis-univariable, el _dataset_ está formado por variables tanto binarias, de rangos numéricos, y enumeradas. Para las variables binarias y enumeradas, es necesario codificarlas en valores numéricos para el entrenamiento, ya que las entradas de nuestros modelos son numéricas. Para las variables numéricas, se aplicó 
#footnote([Para observar la codificación en detalle, ver el _notebook_ `models.ipynb`.])

También se observó que las variables de rango contaban con un pequeño porcentaje de valores no enteros, los cuales se decidieron redondear al entero más cercano, ya que asumimos que pueden tratarse de errores en el _dataset_, ya que en esta característica no vemos necesario el uso de valores tan precisos.


