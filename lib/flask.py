import pandas as pd
import os

# Specify the file path (use raw string or double backslashes)
file_path = r'C:\Users\anike\OneDrive\Documents\mobile-dev\stock_app\assets\nifty_stock_sheet.xlsx'

# Check if the file exists
if os.path.exists(file_path):
    print("File found!")

    # Load the Excel file into a dictionary of DataFrames
    sheets = pd.read_excel(file_path, sheet_name=None)

    # Clean data from each sheet (company)
    for company_name, df in sheets.items():
        # Convert 'Date' column to datetime type for consistency
        df['Date'] = pd.to_datetime(df['Date'], errors='coerce')

        # Sort by date and remove rows with missing values
        df = df.dropna(subset=['Date', 'Close', 'Open', 'High', 'Low', 'Volume'])
        df = df.sort_values(by='Date', ascending=True)

        # Store cleaned data back into the dictionary
        sheets[company_name] = df

    # Display sheet names (company names)
    print(sheets.keys())  # It will show the sheet names (company names)

    # Optionally, you can print the cleaned data of the first company (for example)
    first_company_name = next(iter(sheets))
    print(f"Cleaned data for {first_company_name}:")
    print(sheets[first_company_name].head())
else:
    print("File not found. Please check the file path.")
