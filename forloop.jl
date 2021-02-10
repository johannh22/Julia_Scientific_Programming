using DelimitedFiles
using Dates
cd("/Users/johannhomonnai/Documents/Julia_Scientific_Programming/")
wikiEVDraw = readdlm("wikipediaEVDraw.csv", ',')
col1 = wikiEVDraw[:,1]

for i = 1:length(col1)
    col1[i] = Dates.DateTime(col1[i], "d u y")
end

wikiEVDraw[:,1] = col1

using Dates
dayssinceMar22(x) = Dates.datetime2rata(x) - Dates.datetime2rata(col1[54])

epidays = Array{Int64}(undef, 54)

for i = 1:length(col1)
    epidays[i] = dayssinceMar22(col1[i])
end

wikiEVDraw[:,1] = epidays
allcases = wikiEVDraw[:,2]
DelimitedFiles.writedlm("wikipediaEVDconvdata.csv", wikiEVDraw, ',')
using Plots
gr()
plot(epidays, allcases,
title = "West African EVD epidemic total cases",
xlabel = "Days since March 22 2015",
ylabel = "Total Cases",
marker = (:diamond),
line = (:scatter),
grid = false,
legend = false
)
savefig("WAfricanEVD.png")
