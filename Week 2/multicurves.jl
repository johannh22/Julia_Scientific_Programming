cd("/Users/johannhomonnai/Documents/Julia_Scientific_Programming/")

using DelimitedFiles
EVDdata = DelimitedFiles.readdlm("wikipediaEVDconvdata.csv", ',')
rows, cols = size(EVDdata)
for j = 1 : cols
    for i = 1 : rows
        if !isnumeric(string(EVDdata[i,j])[1])
            EVDdata[i,j] = 0
        end
    end
end
DelimitedFiles.writedlm("wikipediaEVDconvdata.csv", EVDdata, ',')

# extract the data
epidays = EVDdata[:,1]
EVDcasesbycountry = EVDdata[:, [4, 6, 8]]
EVDcasesbycountry = convert(Array{Int64}, EVDcasesbycountry)
# load Plots and use them
using Plots
gr()
plot(epidays, EVDcasesbycountry,
legend = :topleft,
marker = ([:diamond :circle :square], 4),
label = ["Guinea" "Liberia" "Serra Leone"],
title = "EVD in West Africa epidemic segregated by country",
xlabel = "Days since 22 Mar 2014",
ylabel = "Number of cases",
line = (:scatter)
)
savefig("multicurves.pdf")
