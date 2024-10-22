namespace GPPSimulations.Modules;
using System.Linq;

public class LimitedFactor
{
    
    /*Temperature modifier function to apply the
     suppressions of  the temperature 
     */
    public double[] temperature_modifier(double [] temperature)
    {
        var l = temperature.Length;
        double[] X = new double[l];
        X[0] = temperature[0];
        for (var i = 1; i < l; i++)
        {
            X[i] = X[i-1] + (1 / Constants.τ) * (temperature[i] - X[i - 1]);
        }
        var sk = X.Select(x => x - Constants.x0 > 0 ? x - Constants.x0  : 0).ToArray();
        var fs = sk.Select(s => s / Constants.Smax < 1 ? s / Constants.Smax : 1).ToArray();
        
        return fs;
    }
    // here is VPD modifier
    public double[] vpd_modifier(double[] vpd)
    {
        var fd = vpd.Select(v => v * Constants.k).ToArray();
        return fd;
    }
    
    // light modifier
    public double [] light_modifier(double[] light)
    {
        var fl = light.Select(l => l * Constants.γ + 1).ToArray();
        return fl;
    }
    
}