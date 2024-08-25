# A Mathematica program for calculating Hirota bilinear D-operator.

## Intro

This Mathematica program may help you finding the bilinear form of certain equation, or quickly verifying your calculation result.

Four kinds of different definition of Hirota D-operator are defined in `HirotaD.m`

These four different definitions have different calling methods. You can choose the one you like.

## Usage of different definitions

Just copy the definition of function into your project and run it.

The use of these functions is described below

### Equation examples

Let's place some equations here for late use.

(1)

$$
 \mathrm{D}_x \ f(x) \cdot g(x)
$$

(2)

$$
 \mathrm{D}^2_x \ f(x) \cdot g(x)
$$

(3)

$$
 \mathrm{D}_x\mathrm{D}^2_t \ f(x, t) \cdot g(x, t)
$$

(4)

$$
 \mathrm{D}_{x_1}\mathrm{D}_{x_2}\mathrm{D}_{x_3} \ f(x_1,x_2,x_3) \cdot g(x_1,x_2,x_3)
$$

(5)

$$
 (\mathrm{D}_x + \mathrm{D}_t + 1)f(x,t) \cdot g(x,t)
$$


### Function `HirotaD`

#### Definition

`HirotaD[P(x, t, ...)][f, g]` gives the multiple derivative $P(\mathrm{D}_x, \mathrm{D}_t, \dots)\ f \cdot g$, where $P(x, t, \dots)$ is a polynomial of $x, t, \dots$


#### Example

Eq. (1)-(5) defined above can be written as

```
(* 1 *)
HirotaD[x][f[x], g[x]]
(* 2 *)
HirotaD[x^2][f[x], g[x]] 
  or
HirotaD[x x][f[x], g[x]] 
(* 3 *)
HirotaD[x t^2][f[x, t], g[x, t]] 
(* 4 *)
HirotaD[x1 x2 x3][f[x1, x2, x3], g[x1, x2, x3]]
(* 5 *)
HirotaD[x + t + 1][f[x, t], g[x, t]] 
```

#### Known problem
`
- Inside the function, variables (e.g. `x`) have intermediate form with argument (e.g `x[1]`). So when input function contain variable and it's function calling form (e.g. `x` and `x[1]`), `HirotaD` may cause miscalculation.
- Argument `P` will try to differentiate all symbols it have. So when `P` contains constant $C$, make sure $C$ has a value or change the definition to execlude specific symbol.

### Function `HirotaDD`

(I know that this function name isn't good, you can rename it by yourself.)

#### Definition

`HirotaD[P][f, g][x1, x2, ...]`, where 
- `f`, `g` are functions that differentiated by $\mathrm{D}$, 
- `x1, x2, ...` are independent variables and 
- `P` is a pure function consisting of a polynomial with anonymous parameters representing the order of independent variables.

**NOTE**: `f` and `g` need to be functions in Mathematica and should have same arguments.

#### Example

Eq. (1)-(5) defined above can be written as

```
(* 1 *)
HirotaDD[#1 &][f, g][x]
(* 2 *)
HirotaDD[#1^2 &][f, g][x]
  or
HirotaDD[#1 #1 &][f, g][x]
(* 3 *)
HirotaDD[#1 #2^2 &][f, g][x, t]
(* 4 *)
HirotaDD[#1 #2 #3 &][f, g][x1, x2, x3]
(* 5 *)
HirotaDD[#1 + #2 + 1 &][f, g][x, t]
```

### Function `Dop`

#### Definition

`Dop[x, y, ...][n, m, ...][f, g]`  gives the multiple derivative $\cdots \mathrm{D}_y^m\mathrm{D}_x^n\ f \cdot g$.


#### Example

Eq. (1)-(5) defined above can be written as

```
(* 1 *)
Dop[x][1][f[x], g[x]]
(* 2 *)
Dop[x][2][f[x], g[x]]
(* 3 *)
Dop[x, t][1, 2][f[x], g[x]]
(* 4 *)
Dop[x1, x2, x3][1, 1, 1][f[x1, x2, x3], g[x1, x2, x3]]
(* 5 *)
Dop[x][1][f[x, t], g[x, t]] + Dop[t][1][f[x, t], g[x, t]] + 1
```

### Function `HD`

The definition of `HD` is rely on `Dop`, so to use it, you have to define `Dop` first.

#### Definition

`HD[f, g, {x, n}, {y, m}, ...]` gives the multiple derivative $\cdots \mathrm{D}_y^m\mathrm{D}_x^n\ f \cdot g$. 

`{x, n}` can be wrtten as `x` if n=1.

#### Example

Eq. (1)-(5) defined above can be written as

```
(* 1 *)
HD[f[x], g[x], x]
  or
HD[f[x], g[x], {x, 1}]
(* 2 *)
HD[f[x], g[x], {x, 2}]
(* 3 *)
HD[f[x], g[x], x, {t, 2}]
(* 4 *)
Dop[f[x1, x2, x3], g[x1, x2, x3], x1, x2, x3]
(* 5 *)
HD[f[x, t], g[x, t], x] + HD[f[x, t], g[x, t], t] + 1
```

### Warning

There is not guarantee that all functions will give the correct result all the time. (Though I believe they should be right.)