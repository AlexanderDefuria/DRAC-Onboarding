import pandas as pd # type: ignore

def count_rows(file_name):
    df = pd.read_csv(file_name, index_col=False)
    print(df.head())
    print(f"Number of rows in {file_name}: {len(df)}")

if __name__ == "__main__":
    import sys
    count_rows(sys.argv[1])