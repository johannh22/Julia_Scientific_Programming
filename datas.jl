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

describe(data)

combine(df -> DataFrame(N = size(df,1)), groupby(data, :Treatment))
combine(size, groupby(data, :Treatment))
# mean age of A and B
combine(df -> mean(df.Age), groupby(data, :Treatment))
# standard deviation of the age of A and B
combine(df -> std(df.Age), groupby(data, :Treatment))

combine(df -> describe(df.Age), groupby(data, :Treatment))

@df data density(:Age, group = :Treatment, title = "Distribution of ages by treatment group",
    xlab = "Age", ylab = "Distribution",
    legend = :topright)

@df data density(:Age, group = :Result, title = "Distribution of ages by result group",
    xlab = "Age", ylab = "Distribution",
    legend = :topright)

@df data density(:Age, group = (:Treatment, :Result), title = "Distribution of ages by treatment and result group",
    xlab = "Age", ylab = "Distribution",
    legend = :topright)

@df data boxplot(:Treatment, :WCC, lab = "WCC", title = "White cell count by treatment group",
    xlab = "Groups", ylab = "WCC")

@df data boxplot(:Result, :WCC, lab = "WCC", title = "White cell count by result group",
    xlab = "Groups", ylab = "WCC")

@df data corrplot([:Age :WCC :CRP], grid = false)

@df data cornerplot([:Age :WCC :CRP], grid = false, compact = true)

# Difference in age between patients in groups A and B
HypothesisTests.EqualVarianceTTest(dataA[!,:Age], dataB[!,:Age])

# Only the p value for the difference in white cell count between patients in groups A and B
pvalue(EqualVarianceTTest(dataA[!,:WCC], dataB[!,:WCC]))

# Simple model predicting CRP
fit(LinearModel, @formula(CRP ~ 1), data)

# Adding age as a predictor variable
fit(LinearModel, @formula(CRP ~ Age), data)

combine(df -> DataFrame(N = size(df,1)), groupby(dataA, :Result))
combine(df -> DataFrame(N = size(df,1)), groupby(dataA, :Result))
observed = reshape([23, 17, 15, 23, 17, 15], (2, 3))
ChisqTest(observed)
CSV.write("ProjectData_1_point_0.csv", data)
cd("/Users/johannhomonnai")
cd("/Users/johannhomonnai//Documents/Julia_Scientific_Programming")
