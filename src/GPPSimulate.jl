module GPPSimulate

include("Constants.jl")
include("LimitedFactors.jl")

using .Constants
using .LimitedFactors


export GPPestimation

function GPPestimation(light::Vector{T} ,
    fl::Vector{T},
    fs::Vector{T},
    fd::Vector{T}) where T <: Number
    return β .* light .* fl .* fs .* fd .+ rand(length(light))
end

end # module GPPSimulate
