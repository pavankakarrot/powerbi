

#### Create a new virtual environment: python3 -m venv venv

#### Activate the virtual environment
##### For Windows: venv\Scripts\activate
##### For Mac/Linux: source venv/bin/activate

#### Install required packages : pip install jupyter pandas numpy matplotlib seaborn scikit-learn plotly fsspec

#### To open notebook: jupyter notebook
#### Exit Jupyter: Control + C
#### To deactivate environment: deactivate
#### For cleaning:
rm -rf venv
jupyter cache clear
find . -name ".ipynb_checkpoints" -type d -exec rm -r {} +
pip cache purge

#### Import necessary libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime
import warnings

#### Ignore warnings
warnings.filterwarnings('ignore')

#### Display settings
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', 100)

#### Enable inline plotting
%matplotlib inline

#### Print package versions
import sys
print(f"Python version: {sys.version}")
print(f"Pandas version: {pd.__version__}")
print(f"NumPy version: {np.__version__}")
