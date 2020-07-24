function mu = sigmamf(z, a, b)
% SIGMAMF Sigma membership function

mu = trapezmf(z, a, b, Inf, Inf);