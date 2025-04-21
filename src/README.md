# Proyecto Final: Aplicación de Machine Learning
By Luis Daniel Casais Mezquida  
Análisis Inteligente de Datos 24/25  
Máster en Ingeniería Informática  
Universidad Carlos III de Madrid


## Dataset
Se ha elegido el dataset 'Obesity Prediction Dataset', de Stephen Adeniran, el
cual se puede encontrar en
https://www.kaggle.com/datasets/adeniranstephen/obesity-prediction-dataset.

Es necesario descargarse el mismo y descomprimirlo, dejando el CSV resultante en
`data/obesity-prediction-dataset.csv`.

E.g.:
```bash
cd data
wget https://www.kaggle.com/api/v1/datasets/download/adeniranstephen/obesity-prediction-dataset -O obesity-prediction-dataset.zip
unzip obesity-prediction-dataset.zip
mv ObesityDataSet_raw_and_data_sinthetic.csv obesity-prediction-dataset.csv
```


## Dependencias
Las dependencias requeridas se encuentran en el archivo `pyproject.toml`.  
También se proporciona un archivo `requirements.txt` con las versiones exactas.


## Archivos proporcionados
Se proporcionan los siguientes IPython Notebooks:
- `analysis.ipynb`: Se procede a realizar un análisis exploratorio de los datos
