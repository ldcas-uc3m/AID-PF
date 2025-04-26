"""
Common preprocessing for all modules
"""

from pathlib import Path
from itertools import chain


def flatten(list_of_lists):
    "Flatten one level of nesting."
    return chain.from_iterable(list_of_lists)


DATASET_PATH = Path("../data/obesity-prediction-dataset.csv")

# dataset characteristics
TARGET = "NObeyesdad"
RANGE_INDEXES = ["FCVC", "NCP", "CH2O", "FAF", "TUE"]
OBESITY_TYPES = [
    "Insufficient_Weight",
    "Normal_Weight",
    "Overweight_Level_I",
    "Overweight_Level_II",
    "Obesity_Type_I",
    "Obesity_Type_II",
    "Obesity_Type_III",
]
