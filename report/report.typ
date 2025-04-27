#import "uc3mreport.typ": conf

#show: conf.with(
  degree: "Máster en Ingeniería Informática",
  subject: "Análisis Inteligente de Datos",
  year: (24, 25),
  project: "Proyecto Final",
  title: [Aplicación de _Machine Learning_],
  group: 1,
  authors: (
    (
      name: "Luis Daniel",
      surname: "Casais Mezquida",
      nia: 100429021
    ),
  ),
  professor: "Pablo Gutierrez Ruiz",
  logo: "old",
  toc: true,
  language: "es",
  // bibliography_file: "references.yaml"
)

#include "parts/introduction.typ"
#include "parts/analysis.typ"
#include "parts/methodology.typ"
#include "parts/experimentation.typ"
#include "parts/conclusions.typ"


