namespace GPPSimulations.Modules;

public class Simulation
{
    LimitedFactor lf = new LimitedFactor();
    Random rnd = new Random();
    private double[] temperature { get; set; }
    private double[] vpd { get; set; }
    private double[] light { get; set; }

    public Simulation(double[] temperature, double[] vpd, double[] light)
    {
        // Check for null input arrays
        if (temperature == null)
        {
            throw new ArgumentNullException(nameof(temperature), "Temperature array cannot be null.");
        }
        if (vpd == null)
        {
            throw new ArgumentNullException(nameof(vpd), "VPD array cannot be null.");
        }
        if (light == null)
        {
            throw new ArgumentNullException(nameof(light), "Light array cannot be null.");
        }
        // Check if the lengths of all arrays are the same
        if (vpd.Length != temperature.Length || vpd.Length != light.Length)
        {
            throw new ArgumentException("All input arrays must have the same length.");
        }
        
        this.temperature = temperature;
        this.vpd = vpd;
        this.light = light;
    }

    public double[] GPPestimation()
    {
        int l = temperature.Length;
        double[] GPP = new double[l];
        double[] fl = lf.temperature_modifier(temperature);
        double[] fd = lf.vpd_modifier(vpd);
        double[] fs = lf.light_modifier(light);
        double error = rnd.NextDouble();
        for (int i = 0; i < l; i++)
        {
            GPP[i] = Constants.β * light[i] * fl[i] * fd[i] * fs[i] + error;
        }

        return GPP;
    }
}