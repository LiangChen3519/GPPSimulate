import java.util.Random;

public class Simulations {

    private double[] temperature;
    private double[] vpd;
    private double[] light;

    public double[] getTemperature() {
        return temperature;
    }

    public void setTemperature(double[] temperature) {
        this.temperature = temperature;
    }

    public double[] getVpd() {
        return vpd;
    }

    public void setVpd(double[] vpd) {
        this.vpd = vpd;
    }

    public double[] getLight() {
        return light;
    }

    public void setLight(double[] light) {
        this.light = light;
    }

    public Simulations(double[] temperature, double[] vpd, double[] light) {
        this.temperature = temperature;
        this.vpd = vpd;
        this.light = light;
    }

    LmitedFactors lf = new LmitedFactors();
    Random rnd = new Random();

    public double[] GPPSimulate() {
        int l = temperature.length;
        double[] GPP = new double[l];
        double[] fl = lf.temperature_modifier(temperature);
        double[] fd = lf.vpd_modifier(vpd);
        double[] fs = lf.light_modifier(light);
        double error = rnd.nextDouble();

        for (int i = 0; i < l; i++) {
            GPP[i] = Constants.β * light[i] * fl[i] * fd[i] * fs[i] + error;
        }
        return GPP;
    }

}
