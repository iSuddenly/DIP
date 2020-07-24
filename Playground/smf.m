function mu = smf(z, a, b)
% SMF S-shaped membership function

mu = zeros(size(z));

p = (a + b) / 2;
low_range = (a <= z) & (z < p);
mu(low_range) = 2 * ((z(low_range) - a) ./ (b - a) ).^2;
mid_range = (p <= z) & (z < b);
mu(mid_range) = 1 - 2 * ((z(mid_range) - b) ./ (b - a)).^2;

high_range = (b <= z);
mu(high_range) = 1;