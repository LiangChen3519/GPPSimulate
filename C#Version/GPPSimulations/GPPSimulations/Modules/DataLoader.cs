using Microsoft.Data.Analysis;


namespace GPPSimulations.Modules
{
    internal class DataLoader
    {
        //private string filepath;
        private  string Path { get; set; }

        public DataLoader(string path)
        {
            Path = path;
        }

        // check file exists or not 
        public void FileExists()
        {
            if (!File.Exists(Path))
            {
                Console.WriteLine($"{Path} is not exists");
            }
            else
            {
                Console.WriteLine($"{Path} is exists");
            }
        }

        //get the format of the file,e.g. txt, csv, dat, xlsx or other 

        public string FileFormat()
        {
            string fileformat;
            fileformat = System.IO.Path.GetExtension(Path).ToLower();
            Console.WriteLine($"the file formate is {fileformat}");
            return fileformat;
        }

        // read data, unlike Julia or Matlab, we read the file based on byte streams

        public DataFrame ReadData()
        {
            var df = DataFrame.LoadCsv(Path, separator: ',', header: true);
            return df;
        }

        public void CheckMissings(DataFrame df)
        {
            // get the column numbers in a dataframe
            int cols = df.Columns.Count;
            for (int i = 0; i < cols; i++)
            {
                // get each column
                var column = df.Columns[i];
                var missingCount = column.NullCount;
                // also print the type of each column
                Console.WriteLine($"Column '{column.Name}' is of type {column.DataType}.");
                if (missingCount > 0)
                {
                    Console.WriteLine($"Column '{column.Name}' has {missingCount} missing values.");
                }
                else
                {
                    Console.WriteLine($"Column '{column.Name}' has no missing values.");
                }
                
            }
        }
        // to mark the null value as -9999
        public double[] To_non_Nullable(SingleDataFrameColumn? col)
        {
            if (col == null)
            {
                throw new ArgumentNullException(nameof(col), "Null values are not allowed.");
            } 
            var doubleValues = new double[col.Length];
            //convert
            for (var i = 0; i < col.Length; i++)
            {
                doubleValues[i] = (double)col[i]!;
            }
            /*
            var nonNullableArray = doubleValues
                    .Select<double, object>(x => x.GetValueOrDefault(-9999))  // Directly extract the non-nullable double values
                    .ToArray();
                    */
            return doubleValues;
        }
    }
}