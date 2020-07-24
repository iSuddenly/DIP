function mu = trapezmf(z, a, b, c, d)
%TRAPEZMF = Trapezoidal membership function

mu = zeros(size(z));

up_ramp_region = (a <= z) & (z < b);
top_region = (b <= z) & (z < c);
down_ramp_region = (c <= z) & (z < d);

mu(up_ramp_region) = 1 - (b - z(up_ramp_region)) ./ (b - a);
mu(top_region) = 1;
mu(down_ramp_region) = 1 - (z(down_ramp_region) - c) ./ (d - c);