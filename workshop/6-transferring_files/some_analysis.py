import pandas as pd # type: ignore

# Load the CSV file
csv_file_path = './csvfile.csv'
data = pd.read_csv(csv_file_path)

# Perform some analysis
summary = data.describe()

# Print the analysis to a text file
output_file_path = './outdata.txt'
with open(output_file_path, 'w') as file:
    file.write(summary.to_string())

print(f"Analysis summary has been written to {output_file_path}")