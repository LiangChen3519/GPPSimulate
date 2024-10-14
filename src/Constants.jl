"""
Some constant parameters for LUE based model
Here, for simplify, we set constant for them more details
please check Mäkelä's paper:

'Developing an empirical model of stand GPP with the LUE approach: analysis of eddy covariance data at five contrasting conifer sites in Europe'
"""
module Constants


export β, γ, κ, τ, x₀, k, Smax, ν, α, x₀

const β = 0.513   # potential daily light use efficiency
const γ = 0.0196  # Empirical parameter
const κ = -0389   # Empirical parameter
const τ = 7.2     # Time constant of delay process
const x₀ = -4.0   # Shreshold value of the delayed temperature
const k = -0.389  # Empirical parameter
const Smax = 17.3 # Empirical parameter
const ν = 5.0     # Empirical parameter
const α = 1.0     # Empirical parameter
end # module Constants

