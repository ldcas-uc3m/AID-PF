---
marp: true
title: Presentación
theme: default
paginate: false
size: 4:3
math: mathjax
style: |
   img[alt~="center"] {
      display: block;
      margin: 0 auto;
   }
   .columns {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 1rem;
   }
---


<!-- _paginate: skip -->
![bg contain opacity:.15](../report/img/old_uc3m_logo.svg)
# Proyecto Final
Luis Daniel Casais Mezquida

Análisis Inteligente de Datos 24/25
Universidad Carlos III de Madrid

---
## _Dataset_
[“Obesity Prediction Dataset”](https://www.kaggle.com/datasets/adeniranstephen/obesity-prediction-dataset), por Stephen Adeniran (2025)
- Estimar nivel de obesidad
- Hábitos alimenticios, físicos, y médicos
- México, Perú, y Colombia

---
<!-- header: '**Dataset**' -->

- 2112 observaciones
- 17 características
   - categóricas (5), numéricas (8), booleanas (4)
- 0 celdas vacías, 9 (33) duplicados (1.56%)

![center w:500](../report/img/duplicates.svg)

---

![center w:550](img/duplicates.png)

---

### Análisis univariable
- Características muy desbalanceadas (>80%): _SMOKE_, _family_history_with_overweight_
- Característica objetivo balanceada
- Características de rangos numéricos con "ruido"

---

![center w:350](../report/img/target_distribution.svg)
![center w:600](../report/img/ch2o_distribution.svg)

---
### Análisis multivariable
- Alta correlación entre género, peso, e historial familiar con obesidad
- Obesidad por género:
   - Tipo II: apenas mujeres
   - Tipo III: apenas hombres

--- 
![center w:700](../report/img/feature_correlation.svg)

---

![center w:550](../report/img/gender.svg)

---
<!-- header: '' -->
## Metodología

Métrica de evaluación: F1-score, macro

Preprocesado:
1. Redondear rangos numéricos a entero
2. Escalado para variables numéricas
3. Encoding para categóricas

---
## Experimentación
- 20% test
- _Cross Validation_ de 5
- Ajuste hiperparámetros

---
Modelos:
1. Base
   - _Naive Bayes_
   - _K-Neighbours_
   - _SVM_
   - _Logistic Regression_
   - _Random Forest_
   - _XGBoost_
2. _Stacking_

---
<!-- header: '**Experimentación**' -->
### Modelos base
![center w:600](../report/img/models_result.svg)

---
![center w:600](../report/img/models_time.svg)

---
### _Stacking_
- _SVM_ + _Logistic Regression_ + _XGBoost_
- Usando mejores hiperparámetros de búsqueda anterior
- Estimador final: _Logistic Regression_

<br/>

Modelo elegido.

---

![center w:600](../report/img/stacking_result.svg)

---
![center w:600](../report/img/cm_Stacking.svg)

---
![center w:600](../report/img/stacking_time.svg)

---

<!-- _paginate: skip -->
![bg contain opacity:.15](../report/img/old_uc3m_logo.svg)
# _Gracias por su atención_