using Distributions
using StatsBase
using CSV
using DataFrames
using HypothesisTests
using StatsPlots
using GLM
pyplot()

age = rand(18:80, 100); # Uniform distribution
wcc = round.(rand(Distributions.Normal(12,2), 100), digits = 1) # Normal distribution & round to one decimal place
crp = round.(Int, rand(Distributions.Chisq(4), 100)).*10 # Chi-squared distribution with broadcasting and alternating round()
treatment = rand(["A", "B"], 100); # Uniformly weighted
result = rand(["Improved", "Static", "Worse"], 100); # Uniformly weighted


# You can use these functions to describe the statistics
StatsBase.summarystats(wcc)
StatsBase.describe(crp)

data = DataFrame(Age = age, WCC = wcc, CRP = crp, Treatment = treatment, Result = result)

dataA = data[data[:, :Treatment] .== "A", :] # only patients in group A
dataB = data[data[:, :Treatment] .== "B", :] # only patients in group B
