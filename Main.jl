include("src/DataLoader.jl")
include("src/GPPSimulate.jl")

using Revise

import .DataLoader
import .GPPSimulate

function main()
    file_path = "data/CR3000_Daily_Averages.dat"
    GPPSimulate.greet()
    df = DataLoader.load_data(file_path)
    DataLoader.check_missing_value(df)
end
# run
main()
