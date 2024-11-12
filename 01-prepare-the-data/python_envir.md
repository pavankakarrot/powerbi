# Navigate to your project directory
cd DataAnalysisPortfolio/online_retail_analysis

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Install required packages
pip install jupyter pandas numpy matplotlib seaborn scikit-learn plotly fsspec

jupyter notebook

1. Exit Jupyter:
Control + C

1. deactivate
2. rm -rf venv
3. jupyter cache clear
4. find . -name ".ipynb_checkpoints" -type d -exec rm -r {} +
5. pip cache purge

# Import necessary libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime
import warnings

# Ignore warnings
warnings.filterwarnings('ignore')

# Display settings
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', 100)

# Enable inline plotting
%matplotlib inline

# Print package versions
import sys
print(f"Python version: {sys.version}")
print(f"Pandas version: {pd.__version__}")
print(f"NumPy version: {np.__version__}")
