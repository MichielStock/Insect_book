#=
Created on 17/08/2022 21:31:24
Last update: -

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
    for t in ts[begin:end-1]
        yₜ = last(ys)
        yₜ₊₁ = yₜ + Δt * f(yₜ)
        push!(ys, yₜ₊₁)
    end
    return ts, ys
end

f_luizen(x; r=0.6, K=10_000) = r * (1 - x / K) * x

lines(0..11_000, luizengroei)

tluizen, yluizen = euler(f_luizen, 500.0, (0, 10))

scatter(tluizen, yluizen)

# ODE 2 variables
# ---------------

ẏpp((x, y)) = [r * (1 - x / K) * x - 0.01x * y, - 0.1y + 0.002x * y]

tpp, ypp = euler(ẏpp, [500.0, 20.0], (0, 20))

fig, ax = scatter(tpp, first.(ypp))
scatter!(ax, tpp, last.(ypp))
fig