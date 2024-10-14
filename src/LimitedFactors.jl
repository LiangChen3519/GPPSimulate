module LimitedFactors
"""
Descript: Here is a module for limitation factors in photosynthesis processes, including air temperature, soil moisture, light, and air dreness ---- vapor pressure deficite (VPD).
"""

include("Constants.jl")

using .Constants

# we have different modifer, so can careat a abstact type
abstract type Modifer end


mutable struct light <: Modifer
    radiation::Vector{T,1}
    fl::Vector{T,1}
end

mutable struct soil <: Modifer
    swc::Vector{T,1}
    fw1::Vector{T,1}
    fw2::Vector{T,1}
end

mutable struct vpd <: Modifer
    vapor::Vector{T,1}
    fd::Vector{T,1}
end

mutable struct temperature <: Modifer
    tair::Vector{T,1}
    fs::Vector{T,1}
end


#### function below ######
## temperature modifier
function Temperature_modifier!(t::temperature)
    X = []
    push!(X, t.tair[0])
    @inbounds for i in range(1,length(t.tair))
        Xk = X[i - 1] + (1 / τ) * (t.tair[i] - X[i - 1])
        push!(X,Xk)
    end
    #Sk = [x - x₀ if x - x₀ > 0 else 0 for x in X]
    Sk = [x - x₀ > 0 ? x - x₀ : 0 for x in X]
    fs = [s / Smax < 1 ?  s / Smax : 1 for s in Sk]
    t.fs = fs

end

## vpd modifier
function VPD_modifier(v::vpd)
    fd = exp(v.vapor*k)
    v.fd = fd
end

## light modifier
function Light_modifier(l::light)
    fl = 1 / (l.radiation*γ +1)
    l.fl = fl
end

## 

end