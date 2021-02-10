function updateSIR(popnvector)
    susceptibles = popnvector[1]
    infecteds    = popnvector[2]
    removeds     = popnvector[3]
    newS   = susceptibles - lambda*susceptibles*infecteds*dt
    newI   = infecteds + lambda*susceptibles*infecteds*dt - gam*infecteds*dt
    newR   = removeds + gam*infecteds*dt
    return [newS newI newR]
end

dt = 0.5

s0 = 1.0e5
i0 = 20.
r0 = 0
gam = 0.125
lambda = 1.47e-6
tfinal = 610
nsteps = round(Int64, tfinal/dt)
resultvals = Array{Float64}(undef, nsteps+1, 3)
timevec = Array{Float64}(undef, nsteps+1)
resultvals[1,:] = [s0, i0, r0]
timevec[1] = 0

for step = 1:nsteps
    resultvals[step + 1, :] = updateSIR(resultvals[step,:])
    timevec[step+1] = timevec[step] + dt
end
using Plots
gr()
svals = resultvals[:,1]
ivals = resultvals[:,2]
rvals = resultvals[:,3]
cvals = ivals + rvals

plot(timevec, cvals,
title = "Model versus Data",
xlabel = "Epidemic day",
ylabel = "Number of cases to date",
label = "Model values"
)
cd("/Users/johannhomonnai/Documents/Julia_Scientific_Programming/")
using DelimitedFiles
EVDdata = DelimitedFiles.readdlm("wikipediaEVDconvdata.csv", ',')
tvals_from_data = wikiEVD[:,1]
total_cases_from_data = wikiEVD[:,2]
plot!(tvals_from_data, total_cases_from_data,
    legend = :right,
    line   = :scatter,
    label  = "Reported number of cases")
