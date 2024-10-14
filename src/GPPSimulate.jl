module GPPSimulate
include("Constants.jl")
include("LimitedFactors.jl")

using .Constants
using .LimitedFactors
using Revise


export GPPestimation

function GPPestimation()
    return β * light.radiation * light.fl * temperature.fs * vpd.fd + rand(length(light.radiation))
end

end # module GPPSimulate
