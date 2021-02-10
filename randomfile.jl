f(x) = 3 * x^2 + 6 * x - 9
for x = -5:5
  println("(",x, ", ", f(x), ")")
end
using Plots
gr() # Activate the GR backend for use with Plots
plot(f, -4, 3) # plot f over [-4,4]
plot!(zero, -3, 3)
