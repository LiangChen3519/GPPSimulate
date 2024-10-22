import os
from os.path import split
import pandas as pd


class DataLoader:
    def __init__(self,file_path):
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"{file_path} does not exist")
        else:
            print(f"File found: {file_path}")
            self.file_path = file_path

    def check_data_types(self):
        file_format = self.file_path.split(".")[-1]
        print(f"File format: {file_format}")
        return file_format

    def load_data(self):
        flag = self.check_data_types()
        print(flag)

        if flag == "csv":
            df = pd.read_csv(self.file_path)
        elif flag == "xlsx":
            df = pd.read_excel(self.file_path)
        elif (flag == "dat") | (flag == "txt"):
            df = pd.read_table(self.file_path)
        else:
            raise ValueError("File format not supported")

        return df

    def check_missing(self):
        df = self.load_data()
        missings = df.isnull().sum()
        print(missings)
        return missings

