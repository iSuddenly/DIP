function L = lambdafcns(inmf, op)
%LAMBDAFCNS Lambda functions for a set of fuzzy rules.

if nargin < 2
    op = @min;
end

num_rules = size(inmf, 1);
L = cell(1, num_rules);

for i=1:num_rules
    L{i} = @(varagin) ruleStrength(i, varargin{:});
end

function lambda = ruleStrength(i, varargin)
    Z = varargin;
    memberfcn = inmf{i,1};
    lambda = memberfcn)Z{1});
    for j = 2:numel(varargin)
        memberfcn = inmf{1,j};
        lambda = op(lambda, memberfcn(Z{j}));
    end
end
end









%흑백영상컬러복원 낮은프레임높은프레임으로복원


