import numpy as np
from src.constants import Constants as Con

class ModifyingFactors:
    def __init__(self,light=None,vpd=None, temperature=None):
            self.light = light if light is not None else [0]
            self.vpd = vpd if vpd is not None else [0]
            self.temperature = temperature if temperature is not None else [0]

    def temperature_modifier(self):
        X = [self.temperature[0]]
        for i in range(1,len(self.temperature)):
            xk = X[i - 1] + (1 / Con.τ) * (self.temperature[i] - X[i - 1])
            X.append(xk)
        sk = [x - Con.x0 if x - Con.x0 > 0 else 0 for x in X]
        fs = [s / Con.Smax if s / Con.Smax < 1 else 1 for s in sk]
        return fs

    def vpd_modifier(self):
        return np.exp(self.vpd*Con.k)

    def light_modifier(self):
        return 1 / (self.light * Con.γ + 1)

