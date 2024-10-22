from src.gpp_simulation import GppSimulation
import time

if __name__ == '__main__':
    # Start the timer
    start_time = time.time()
    file_path = r"data/CR3000_Daily_Averages.csv"
    gpp_sim = GppSimulation(file_path)
    GPP = gpp_sim.simulate()

    print(f"GPP = {GPP}")

    end_time = time.time()
    # Calculate elapsed time
    elapsed_time = end_time - start_time
    print(f"Elapsed time: {elapsed_time:.6f} seconds")