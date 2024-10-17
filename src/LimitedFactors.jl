module LimitedFactors
"""
Descript: Here is a module for limitation factors in photosynthesis processes, including air temperature, soil moisture, light, and air dreness ---- vapor pressure deficite (VPD).
"""

include("Constants.jl")
using .Constants

export Temperature_modifier!, VPD_modifier!, Light_modifier!

# we have different modifer, so can careat a abstact type
abstract type Modifer end

mutable struct light{T <: Number} <: Modifer
    radiation::Vector{T}
    fl::Vector{T}
    function light(radiation::Vector{T},fl::Vector{T} = Vector{T}()) where T <: Number
        new{T}(radiation,fl)
    end
end

#=
mutable struct soil <: Modifer
    # we skip the soil part, howevery
    swc::Vector{T,1}
    fw1::Vector{T,1}
    fw2::Vector{T,1}
end
=#

mutable struct vpd{T <: Number} <: Modifer
    vapor::Vector{T}
    fd::Vector{T}

    function vpd(vapor::Vector{T}, fd::Vector{T} = Vector{T}()) where T <:Number
        new{T}(vapor, fd)
    end
end

mutable struct temperature{T <: Number} <: Modifer
    tair::Vector{T}
    fs::Vector{T}
    function temperature(tair::Vector{T},fs::Vector{T} = Vector{T}()) where T <:Number
        new{T}(tair,fs)
    end
end


#### function below ######
## temperature modifier
function Temperature_modifier!(t::temperature)
    X = []
    push!(X, t.tair[1])
    @inbounds for i in range(2,length(t.tair))
        Xk = X[i - 1] + (1 / τ) * (t.tair[i] - X[i - 1])
        push!(X,Xk)
    end
    #Sk = [x - x₀ if x - x₀ > 0 else 0 for x in X]
    Sk = [x - x₀ > 0 ? x - x₀ : 0 for x in X]
    fs = [s / Smax < 1 ?  s / Smax : 1 for s in Sk]
    t.fs = fs

end

## vpd modifier
function VPD_modifier!(v::vpd)
    fd = exp.(v.vapor*k)
    v.fd = fd
end

## light modifier
function Light_modifier!(l::light)
    fl = 1 ./ (l.radiation*γ .+ 1)
    l.fl = fl
end

## soil modifier

# we skiped the soil part
end