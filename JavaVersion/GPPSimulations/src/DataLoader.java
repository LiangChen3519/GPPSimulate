import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvException;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class DataLoader {
    private String filepath;

    public String getPath() {
        return filepath;
    }

    public void setPath(String path) {
        filepath = path;
    }

    public DataLoader(String filepath) {
        this.filepath = filepath;
    }

    public boolean FileExists() {
        boolean exists = false;
        //System.out.println(this.filepath + " is exists");
        //System.out.println(this.filepath + " does not exist");
        exists = Files.exists(Path.of(this.filepath));
        return exists;
    }

    public String FileFormat() throws FileNotFoundException {
        String format = "";
        boolean exists = this.FileExists();
        if (exists) {
            //System.out.println(this.filepath + " is exists");
            int i = this.filepath.lastIndexOf(".");
            if (i == -1 || i == this.filepath.length() - 1) {
                return format;
            } else {
                format = this.filepath.substring(i + 1);
            }
        } else {
            throw new FileNotFoundException("File is not found");
        }
        return format;
    }


    public List<String[]> ReadData() throws IOException, CsvException {
        boolean exists = this.FileExists();
        if (exists) {
            CSVReader reader = new CSVReader(new FileReader(this.filepath));
            List<String[]> data = reader.readAll();
            if (data.isEmpty()) {
                System.out.println("data is empty");
            }

            return data;


        }
        return null;
    }


    public void checkMissing(List<String[]> df) {
        // assume the 1st row is header
        // data is from the 2nd
        String[] headers = df.get(0);
        int columns = df.get(0).length;
        for (String header : headers) {
            System.out.println(header);
        }
        // print data
        int[] missingCountPerColumn = new int[columns];
        for (int i = 1; i < df.size(); i++) {

            String[] row = df.get(i); // get row by row
            // for each row, we the slice each column
            for (int j = 0; j < row.length; j++) {
                // check parse to number
                if (row[j] == null || row[j].isEmpty()) {
                    missingCountPerColumn[j]++;
                }
            }
        }
        // get a summary of percentage of missing value
        for (int i = 0; i < columns; i++) {
            double missing = (double) missingCountPerColumn[i] / df.size();
            System.out.printf("Column %s: %.2f%% missing values (%d out of %d)\n", headers[i], missing,
                    missingCountPerColumn[i], df.size());
        }
    }

    public double [] getColumn(List<String[]> df, int index) {
        double[] column = new double[df.size()];
        for (int i = 1; i < df.size(); i++) {
            column[i] = Double.parseDouble(df.get(i)[index]);
        }
        return column;
    }
}
