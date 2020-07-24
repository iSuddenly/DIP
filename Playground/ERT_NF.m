%Name: ERT_NF (Eigenvalue Ratio Test for the Number of Factors)
%Purpose: Selection of the number of factors by Ahn and Horenstein (2013)
%Format: [ER_k,GR_k] = ERT_NF(eig_value,maxk,m)
%inputs:  (1) eig_value (M by 1 vector): eigen values where M=max(N,T)
%         (2) maxk (scalar): maximum number of the factors in our interest
%         (3) m (scalar): m = min(N,T)
% Output: (1) ER_k (scalar): the selected number of factors by ER
%         (eigenvalue ratio)
%         (2) GR_k (scalar): the selected number of factors by GR (growth
%         ratio)
% Note
%       1) maxk has to be smaller than m.
% Reference
% Ahn, S. C., and A.R. Horenstein (2013): "Eigenvalue Ratio Test for the
% Numberof Factors," Econometrica, 81, 1203-1227.
%
% 2018-01-29  
% Version 1.0 
% By Yongok Choi (choiyongok@gmail.com)

function [ER_k,GR_k] = ERT_NF(eig_value,maxk,m)

mu = eig_value;

ER = zeros(maxk,1);
GR = zeros(maxk,1);

V_k = zeros(maxk+1,1);
V_k(1) = sum(mu(1:m,1));

for j=2:maxk+2
    V_k(j) = sum(mu(j:m,1)); % V_0, ..., V_{maxk+1}
end 

for i=1:maxk
    ER(i) = mu(i,1)/mu(i+1,1);
    GR(i) = log(V_k(i)/V_k(i+1))/log(V_k(i+1)/V_k(i+2));
end

[ER_V,ER_k]=max(ER);[GR_V,GR_k]=max(GR);
