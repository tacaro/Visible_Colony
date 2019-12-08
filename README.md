# Visible_Colony

This is a simple tool created for calculating the amount of time it would take a bacteria to become visible on an agar plate given its doubling time and cell morphology. The purpose of this is to demonstrate how estimated doubling time corresponds to the feasibility of growing an isolate in culture.

The model is based on some assumptions:
1. Cells are perfectly packed and do not produce extracellular compounds that would distance them from each other.
2. The cells are growing at a constant rate.
3. The cells are not dying at a significant rate.
4. Rod-shaped cells are assumed to be rectangular prisms of volume = `(major_axis * minor_axis * minor_axis)`.
5. Cocci are assumed to be perfect spheres of volume `(4/3)*pi*(major_axis / 2)`.
6. Colony morphology is that of a half-ellipsoid with a perfectly circular base and a height that is proportional to its width.


## Usage
Currently, on an R-based version exists. It requires tidyverse.
`library(tidyverse)`.

Within `counter.R`:
Define the attributes of a generic colony with the following attributes: xax, yax, zax; the x width, y width, and z width of the colony. For this example, I used:
```
xax <-  1000
yax <-  1000
zax <-  (1/6)*1000
```
where each is length in µm. We can then compute the volume of the colony with `col_volumer()`.

The tool then sequentially computes:
- the volume of an individual cell (vi)
- the number of cells (N) required to produce a colony whose size was determined with `col_volumer()` (V)
- the number of divisions (X) required to reach this population (N) density
- the amount of time (T) that this number (X) of divisions would take

We can then plot this result using `ggplot2`.

[!Image](inc_time.png)
