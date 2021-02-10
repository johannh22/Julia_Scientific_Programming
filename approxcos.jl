function approxcos(x)
    outval = Array{Any}(undef, size(x))

    ii = 0
    for aa in x
        y = 1 - aa^2/2 + aa^4/24 - aa^6/720 + aa^8/(56*720)
        ii = ii + 1
        outval[ii] = y

    end
    return outval
end

x1 = 4*rand(10)

x2 = range(0., stop = 4., step = 0.01)

y1 = approxcos(x1)
y2 = cos.(x2)

using Plots; gr()

plot(x1, y1,
    legend = :false,
    line = (:scatter),
    title = "Illustrating 6-th order approximation to cos")

plot!(x2,y2)
