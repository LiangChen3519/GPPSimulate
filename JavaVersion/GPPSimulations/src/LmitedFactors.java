import java.util.Arrays;

public class LmitedFactors {

    public double[] temperature_modifier(double[] temperature) {
        int l = temperature.length;
        double[] X = new double[l];
        X[0] = temperature[0];
        for (int i = 1; i < l; i++) {
            X[i] = X[i - 1] + (1 / Constants.τ) * (temperature[i] - X[i - 1]);
        }
        double[] sk = Arrays.stream(X)
                .map(x -> x - Constants.x0 > 0 ? x - Constants.x0 : 0)
                .toArray();
        double[] fs = Arrays.stream(sk)
                .map(s -> s / Constants.Smax < 1 ? s / Constants.Smax : 1)
                .toArray();
        return fs;
    }

    public double[] vpd_modifier(double[] vpd) {
        double[] fd = Arrays.stream(vpd)
                .map(v -> v * Constants.k)
                .toArray();
        return fd;
    }

    public double[] light_modifier(double[] light) {
        double[] fl = Arrays.stream(light)
                .map(l -> l * Constants.γ)
                .toArray();
        return fl;
    }
}
