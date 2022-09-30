#=
Created on 17/08/2022 21:31:24
Last update: 20/09/2022

@author: Michiel Stock
michielfmstock@gmail.com

Code for the prey-predator project
=#

using CairoMakie, InsectBook

r = 0.6
K = 10_000

# Derivatives
# -----------

f(x) = x^2 + x * sin(x) + 3
ḟ(x) = 2x + sin(x) + x * cos(x)

a = 3

lines(-3..1, f)

eindige_differentie(f, x; Δx=0.01) = (f(x + Δx) - f(x)) / Δx

x_waarden = -3:.2:1
f_waarden = f.(x_waarden)
dfdx_waarden = diff(f_waarden) ./ diff(x_waarden)


fig, ax = lines(-3..1, ḟ, label="ẏ(x)")
scatter!(ax, -3:0.2:1, x->eindige_differentie(f, x), label="eindige diff. benadering")

# ODE 1 variable
# --------------

# TODO: x or y?

function euler(f, y₀, (t₀, tₑ); Δt=0.2)
    ys = [y₀]
    ts = t₀:Δt:tₑ
    for t in t₀:Δt:(tₑ-Δt)
        yₜ = last(ys)
        yₜ₊₁ = yₜ + Δt * f(yₜ)
        push!(ys, yₜ₊₁)
    end
    return ts, ys
end

f_luizen(x; r=0.6, K=10_000) = r * (1 - x / K) * x

lines(0..11_000, f_luizen)

tluizen, yluizen = euler(f_luizen, 500.0, (0, 10))

scatter(tluizen, yluizen)

# ODE 2 variables
# ---------------

y1dot((y1, y2)) = r * (1 - y1 / K) * y1 - 0.01y1 * y2
y2dot((y1, y2)) =  - 0.01y2 + 0.001y1 * y2

ẏ((y1, y2)) = [y1dot((y1, y2)), y2dot((y1, y2))]

# phase plot
fig = Figure(resolution = (800, 800))
Axis(f[1, 1], backgroundcolor = "black")

y1s = range(0, 0.6K, length=20)
y2s = range(0, 100, length=20)
y1dots = [y1dot((y1, y2)) for y1 in y1s, y2 in y2s]
y2dots = [y2dot((y1, y2)) for y1 in y1s, y2 in y2s]
strength = sqrt.(y1dots .^ 2 .+ y2dots .^ 2)

# normalize
y1dots .*= 200 ./ strength
y2dots .*= 200 ./ strength

arrows(y1s, y2s, y1dots, y2dots, arrowsize = 10, lengthscale = 0.3,
    arrowcolor = vec(strength), linecolor = vec(strength))

tpp, ypp = euler(ẏ, [500.0, 20.0], (0, 20))

fig, ax = scatter(tpp, first.(ypp))
scatter!(ax, tpp, last.(ypp))
fig