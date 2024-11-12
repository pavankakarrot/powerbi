# In your Jupyter notebook, run:
import os
print(os.getcwd())  # This shows your current working directory


# List all files
print(os.listdir())

# Method 1: Use full path
df = pd.read_csv('/full/path/to/your/file.csv')

# Method 2: Use relative path from current directory
df = pd.read_csv('./your_file.csv')

# Method 3: Join paths (safer method)
file_path = os.path.join(os.getcwd(), 'your_file.csv')
df = pd.read_csv(file_path)
