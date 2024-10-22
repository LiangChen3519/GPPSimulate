from src.data_loader import DataLoader
from src.modifying_factors import ModifyingFactors
from src.constants import Constants as  Con
import numpy as np

class GppSimulation:
    def __init__(self, file_path):
        self.data_loader = DataLoader(file_path)
        self.modifying_factors = ModifyingFactors()

    def simulate(self):
        # load and check data
        df = self.data_loader.load_data()
        self.data_loader.check_missing()

        # get columns
        light = df['NetRs_Avg'].values
        vpd = df['RH'].values
        temp = df['PTemp_C_Avg'].values

        my_suppress = self.modifying_factors
        my_suppress.light = light
        my_suppress.vpd = vpd
        my_suppress.temperature = temp
        # get modifier
        fl = my_suppress.light_modifier()
        fd = my_suppress.vpd_modifier()
        fs = my_suppress.temperature_modifier()


        GPP = Con.β * np.array(fl) * np.array(fs)* np.array(fd)* np.array(light) * np.random.uniform(0, 1,size=len(light))
        return GPP