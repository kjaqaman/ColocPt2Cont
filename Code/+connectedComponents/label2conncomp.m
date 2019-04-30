function [ out ] = label2conncomp( lm, conn)
%labelconncomp Converts label matrix back to connected components map
% lm is the label matrix from labelmatrix
% conn is the connectivity , which is ignored. Assumes 8
%
% Copyright (C) 2016, Jaqaman & Danuser Labs - UT Southwestern 
%
% This file is part of ColocP2C.
% 
% ColocP2C is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% ColocP2C is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with ColocP2C.  If not, see <http://www.gnu.org/licenses/>.
% 
% 

% Mark Kittisopikul
% UT Southwestern
% 2014 / 11 / 17

if(nargin < 2)
    conn = 8;
end
out.Connectivity = conn;
out.ImageSize = size(lm);
out.NumObjects = double(max(lm(:)));
% find nonzero values
nzList = find(lm);
% group label indices together
out.PixelIdxList = accumarray(lm(nzList),nzList,[],@(x) {x})';



end

