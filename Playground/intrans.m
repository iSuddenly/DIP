% nargchk, nargin, varargin, numel, mat2gray

function g = intrans(f, method, varargin)
%INTRANS performs intensity(gray-level) transformations.
%G = INTRANS(F, 'neg') computes the negative of input image F.
%G = INTRANS(F, 'gamma', GAM)
%G = INTRANS(F, 'specified', TXFUN)
%G = 

% error(nargchk(2, 4, nargin))
narginchk(2, 4)

if strcmp(method, 'log')
    g = logTransform(f, varargin{:});
    return;
end

if isfloat(f) && (max(f(:)) > 1 || min(f(:)) <0)
    f = mat2gray(f);
end
[f, revertclass] = tofloat(f);

switch method
    case 'neg'
        g = imcomplement(f);
    case 'gamma'
        g = gammaTransform(f, varargin{:});
    case 'stretch'
        g = stretchTransform(f, varargin{:});
    case 'specified'
        g = spcfiedTransform(f, varargin{:});
    otherwise
        error('Unknown enhancement method.')
end

g = revertclass(g);


function g = gammaTransform(f, gamma)
g = imadjust(f, [ ], [ ], gamma);

function g = stretchTransform(f, varargin)
if isempty(varargin)
    m = mean2(f);
    E = 4.0;
elseif length(varargin) == 2
    m = varargin{1};
    E = 4.0;
elseif length(varargin) == 2
    m = varargin{1};
    E = varargin{2};
else
    error('Incorrect number of inputs for the stretch method.')
end
g = 1./(1 + (m./f).^E);


function g = spcfiedTransform(f, txfun)
txfun = txfun(:);
if any(txfun) > 1 || any(txfun) <= 0
    error('All elements of txfun must be in the range [0 1].')
end
T = txfun;
X = linspace(0, 1, numel(T))';
g = interp1(X, T, f);

function g = logTransform(f, varargin)

[f, revertclass] = tofloat(f);
if numel(varargin) >= 2
    if strcmp(varargin{2}, 'uint8')
        revertclass = @im2uint8';
    elseif strcmp(varargin{2}, 'uint16')
        revertclass = @im2uint16;
    else
        error('Unsupported CLASS option for ''log'' method.')
    end
end

if numel(varargin) < 1
    C = 1;
else
    C = varargin{1};
end
g = C * (log(1 + f));
g = revertclass(g);