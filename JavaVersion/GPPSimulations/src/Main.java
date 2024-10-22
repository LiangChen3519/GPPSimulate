import com.opencsv.exceptions.CsvException;

import java.io.IOException;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) throws IOException, CsvException {

        // start time
        long startTime = System.currentTimeMillis();
        //TIP Press <shortcut actionId="ShowIntentionActions"/> with your caret at the highlighted text
        // to see how IntelliJ IDEA suggests fixing it.
        String path = "data/CR3000_Daily_Averages.csv";
        DataLoader dl = new DataLoader(path);
        dl.FileExists();
        dl.FileFormat();
        var df = dl.ReadData();
        dl.checkMissing(df);
        //get columns
        var tair = dl.getColumn(df,4);
        var light = dl.getColumn(df,13);
        var vpd = dl.getColumn(df,6);

        var sim = new Simulations(tair, light, vpd);
        var GPP = sim.GPPSimulate();
        for(double g:GPP){
            System.out.println(g);
        }
        var endTime = System.currentTimeMillis();
        System.out.println("GPP calculation takes " +
                (endTime - startTime) / 1000.0 + "s");
    }
}