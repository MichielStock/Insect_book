#=
Created on 03/11/2022 09:37:54
Last update: -

@author: Michiel Stock
michielfmstock@gmail.com

Generates the BOOK.
=#

using Books, InsectBook

using Plots
using Plots: Plot

Books.is_image(plot::Plots.Plot) = true
Books.svg(svg_path::String, p::Plot) = savefig(p, svg_path)

Books.png(png_path::String, p::Plot) = savefig(p, png_path)

gen(;)

pdf()