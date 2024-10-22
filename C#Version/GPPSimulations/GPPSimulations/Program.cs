using GPPSimulations.Modules;
using System.Diagnostics;
using Microsoft.Data.Analysis;

namespace GPPSimulations
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Stopwatch sw = new Stopwatch();
            sw.Start();
            // Create a new Stopwatch instance
            var path =
                @"C:\Users\liangch\OneDrive - University of Eastern Finland\Documents\MY_C#\GPPSimulations\GPPSimulations\data\CR3000_Daily_Averages.csv";
            var dl = new DataLoader(path);
            dl.FileExists();
            dl.FileFormat();
            var df = dl.ReadData();
            dl.CheckMissings(df);
            // start calculation
            // we automatically mark the null value as -9999
            // get columns -- air temperature
            var tair = df.Columns["PTemp_C_Avg"] as SingleDataFrameColumn;
            var tairArray = dl.To_non_Nullable(tair);
            // get columsn -- light
            var light = df.Columns["NetRs_Avg"] as SingleDataFrameColumn;
            var lightArray = dl.To_non_Nullable(light);
            // get vpd
            var vpd = df.Columns["RH"] as SingleDataFrameColumn;
            var vpdArray = dl.To_non_Nullable(vpd);
            var sim = new Simulation(tairArray, vpdArray, lightArray);
            var GPP = sim.GPPestimation();
            foreach (var g in GPP)
            {
                Console.WriteLine(g);
            }
            sw.Stop();
            Console.WriteLine("Time Taken-->{0} s",sw.ElapsedMilliseconds /1000.0);
        }
        
    }
}
