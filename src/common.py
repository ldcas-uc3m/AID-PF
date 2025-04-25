"""
Common preprocessing for all modules
"""

from pathlib import Path
from itertools import chain

import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer


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


def get_dataset() -> tuple[pd.DataFrame, pd.Series]:
    """
    Obtains the dataset.
    """

    dataset = pd.read_csv(DATASET_PATH)

    # round to nearest integer for ranges
    dataset[RANGE_INDEXES] = (
        dataset[RANGE_INDEXES].apply(round).astype(np.int64)
    )

    # transform targets into numbers
    dataset[TARGET] = dataset[TARGET].map(
        {type: i for i, type in enumerate(OBESITY_TYPES)}
    )

    return dataset.drop(TARGET, axis="columns"), dataset[TARGET]


def get_preprocessor() -> ColumnTransformer:
    """ """
    return ColumnTransformer(
        transformers=[
            (
                "numeric",
                StandardScaler(),
                [
                    "Age",
                    "Height",
                    "Weight",
                    "FCVC",
                    "NCP",
                    "CH2O",
                    "FAF",
                    "TUE",
                ],
            ),
            (
                "categorical",
                OneHotEncoder(
                    categories=list(
                        # python magic here
                        flatten(
                            [
                                [vals for _ in range(len(feats))]
                                for feats, vals in CATEGORICAL_FEATURES
                            ]
                        )
                    )
                ),
                list(flatten([feats for feats, _ in CATEGORICAL_FEATURES])),
            ),
        ]
    )
