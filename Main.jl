include("src/DataLoader.jl")
include("src/LimitedFactors.jl")
include("src/GPPSimulate.jl")



using .DataLoader
using .LimitedFactors
using .GPPSimulate
using BenchmarkTools


function main()
    file_path = "data/CR3000_Daily_Averages.csv"
    #GPPSimulate.greet()
    df = load_data(file_path)
    check_missing_value(df)
    t= df.PTemp_C_Avg
    l = df.NetRs_Avg
    v = df.RH

    # initailize vpd, light, and temperature structure (mutable)
    VPD = LimitedFactors.vpd(v)
    TEM = LimitedFactors.temperature(t)
    L = LimitedFactors.light(l)

    # get modifier values
    VPD_modifier!(VPD)
    Temperature_modifier!(TEM)
    Light_modifier!(L)
    GPP = GPPestimation(L.radiation,L.fl,TEM.fs,VPD.fd) # Get results
    print("\n GPP are : \n")
    println(GPP)
    
end
# run
@btime main()
