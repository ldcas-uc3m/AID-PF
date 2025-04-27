#import "@preview/subpar:0.2.2"


= Experimentación


== Modelos base


#let models = (
  "K-Neighbours",
  "Logistic Regression",
  "Naive Bayes",
  "Random Forest",
  "SVM",
  "XGBoost"
)

#subpar.grid(
  columns: 3,
  align: center,
  caption: [Matrices de confusión de los modelos],
  ..for model in models {
    // for showing the figures, we use spreading, creating an array within the loop
    // see https://forum.typst.app/t/how-come-this-does-not-generate-a-grid-as-expected/1660/2
    (
      figure(
        image("../img/cm_" + model + ".svg"),
        caption: [ #model ]
      )
    ,
    )
  },
) <fig:cm-base>


#figure(
  image("../img/models_result.svg", width: 70%),
  caption: [ Resultado de los distintos modelos empleados ]
) <fig:result-base>

#figure(
  image("../img/models_time.svg", width: 70%),
  caption: [ Tiempo de entrenamiento de los distintos modelos empleados ]
) <fig:time-base>




== _Stacking_


#figure(
  image("../img/stacking_result.svg", width: 70%),
  caption: [ Resultado de la técnica de _stacking_ ]
) <fig:result-stacking>

#figure(
  image("../img/stacking_time.svg", width: 70%),
  caption: [ Tiempo de entrenamiento de la técnica de _stacking_]
) <fig:time-stacking>