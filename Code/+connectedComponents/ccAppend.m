function [ cc ] = ccAppend( cc, pixels )
%ccAppend Append a new connected component to the list
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

if(length(pixels) ~= numel(pixels))
    pixels = sub2ind(cc.ImageSize,pixels(:,1),pixels(:,2));
end

cc.NumObjects = cc.NumObjects + 1;
cc.PixelIdxList{cc.NumObjects} = pixels(:);


end

