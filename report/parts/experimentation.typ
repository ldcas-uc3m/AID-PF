#import "@preview/subpar:0.2.2"


= Experimentación
Para el proceso de experimentación, se empezará realizando pruebas con distintos modelos para ver sus resultados (@sec:base-models), y luego se probará a combinar los mejores modelos mediante la técnica de _stacking_ para observar si se obtiene un mejor resultado (@sec:stacking).

Para todos los entrenamientos, se dividió el _dataset_ en 80% datos de entrenamiento y 20% datos de prueba, y se usó un valor de _Cross Validation_ de 5.


== Modelos base <sec:base-models>
#let models = (
  "Naive Bayes",
  "K-Neighbours",
  "SVM",
  "Logistic Regression",
  "Random Forest",
  "XGBoost"
)

Para la experimentación con modelos base, se decidió probar con modelos más sencillos y más avanzados, ya que no siempre un modelo más avanzado implica un resultado mejor.

Dado que se trata de un problema de clasificación multiclase, se eligieron los siguientes modelos#footnote([Para más información sobre los modelos exactos utilizados, ver el _notebook_ `models.ipynb`.]):

#for model in models [
  + #emph(model)
]

Para cada uno de los modelos (exceptuando _Naive Bayes_), se procedió también a un ajuste de los hiperparámetros más prevalentes, para así también obtener las mejores versiones de cada uno de los modelos para el problema.

También se guardó información del tiempo que duró el entrenamiento de cada uno de los modelos, aúnque este incluye la búsqueda de los hiperparámetros óptimos.


=== Resultados
La @fig:result-base muestra los resultados de cada uno de los modelos utilizados.

Se puede observar que el modelo más simple, _Naive Bayes_, tiene un resultado verdaderamente horroroso, con $"f1_macro" < 0.5$, el cual indica que no ha aprendido nada. Al ser un problema multiclase y no binario, no podemos simplemente invertir la salida del clasificador para obtener un resultado mejor.

El modelo _K-Neighbours_ obtuvo un resultado más que aceptable, aún siendo un modelo simple, probablemente debido a la alta correlación de algunas de las características con la característica objetiva. Los mejores hiperparámetros encontrados fueron:
- Métrica: Distancia _Manhattan_
- Número de vecinos: 5
- Función de pesos: Inverso de la distancia

El modelo _SVM_ obtuvo un resultado excelente y, dado que el conjunto de datos es pequeño, lo convierte en un buen candidato. Los mejores hiperparámetros encontrados fueron:
- $C$: 10
- _Kernel_: Lineal

#figure(
  image("../img/models_result.svg", width: 70%),
  placement: top,
  caption: [ Resultado de los distintos modelos empleados. ]
) <fig:result-base>

El modelo _Logistic Regression_, obtuvo unos resultados también excelentes. Cabe destacar que en algunas pruebas experimentales, éste modelo fue capar de obtener resultados con $"f1_macro" > 0.9$ incluso con un 30% del _dataset_ total dedicado al entrenamiento, y el resto a la prueba, por lo que no está haciendo _overfitting_. Los mejores hiperparámetros encontrados fueron:
- $C$: 10
- Penalización: L1
- _Solver_: SAGA

El modelo _Random Forest_ obtuvo unos resultados igualmente excelentes, pero ligeramente inferiores a sus compañeros. Los mejores hiperparámetros encontrados fueron:
- Profundidad máxima: 20
- Mínimo número de muestras para el _split_: 2
- Número de estimadores: 100

Finalmente, se probó un tipo de modelo más avanzado, _XGBoost_, el cual también obtuvo unos resultados excelentes, pero ligeramente por debajo de _SVM_ y _Logistic Regression_. Los mejores hiperparámetros encontrados fueron:
- Tasa de aprendizaje: 0.2
- Profundidad máxima: 3
- Número de estimadores: 200

La @fig:cm-base muestra las matrices de confusión de los distintos modelos, las cuales muestran que, en general, se suelen confundir más los tipos de peso normales y con sobrepeso leve.

Finalmente, la @fig:time-base muestra el tiempo empleado en el entrenamiento de cada uno de los modelos. Se observa que, de entre los mejores modelos, _SVM_ cuenta con el entenamiento más veloz, aunque es posible que sea debido en parte al menor número de hiperparámetros buscados.

#subpar.grid(
  columns: 3,
  align: center,
  gutter: .4em,
  caption: [ Matrices de confusión de los modelos. ],
  ..for model in models {
    // for showing the figures, we use spreading, creating an array within the loop
    // see https://forum.typst.app/t/how-come-this-does-not-generate-a-grid-as-expected/1660/2
    (
      figure(
        image("../img/cm_" + model + ".svg"),
        caption: [ #model ]
      ),
      label("fig:cm-" + model)
    ,
    )
  },
  label: <fig:cm-base>
)


#figure(
  image("../img/models_time.svg", width: 70%),
  caption: [ Tiempo de entrenamiento de los distintos modelos empleados. ]
) <fig:time-base>



== _Stacking_ <sec:stacking>
Como último paso, se decidió aplicar la técnica de _stacking_ con el objetivo de comprobar si producía mejores resultados que los modelos base. Para ello, se decidió usar los tres mejores modelos, _SVM_, _Logistic Regression_, y _XGBoost_, con los mejores hiperparámetros encontrados. Para el estimador final, se usó otro modelo _Logistic Regression_.


=== Resultados
La @fig:result-stacking muestra los resultados de cada uno de los modelos utilizados. Se puede observar que el uso de ésta técnica ha resultado muy útil, obteniendo un resultado de $"f1_macro" approx 0.97$.

La @fig:cm-stacking muestra la matriz de confusión, la cual es similar a las del resto de modelos usados. La @fig:time-stacking muestra el tiempo de entrenamiento comparado con el tiempo del resto de modelos usados. Al no tener que buscar hiperparámetros, el tiempo es considerablemente inferior.

#figure(
  image("../img/stacking_result.svg", width: 70%),
  caption: [ Resultado de la técnica de _stacking_. ]
) <fig:result-stacking>

#figure(
  image("../img/cm_Stacking.svg", width: 70%),
  caption: [ Matriz de confusión de la técnica de _stacking_. ]
) <fig:cm-stacking>

#figure(
  image("../img/stacking_time.svg", width: 70%),
  caption: [ Tiempo de entrenamiento de la técnica de _stacking_. ]
) <fig:time-stacking>