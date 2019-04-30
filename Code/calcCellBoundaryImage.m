function [threshold] = calcCellBoundaryImage(image,fixFrameUp, fixFrameDown)
%CALCCELLBOUNDARY applies mutli-otsu threshold to determine cell boundary
% Mask is best suited for images in which cell is large relative to image
% dimensions
% Synopsis: [maskList,mask] = calcCellBoundary(image)
% Input:
%       image - image that will be thresholded
%
%       fixFrameUp - since the function separates an image into multiple
%       tiers of intensity to find a threshold and the edge of the 
%       foreground maybe poorly defined, it may occur that the
%       threshold chosen is off by a tier. Enter any value to increase the
%       threshold by one tier.
%
%       fixFrameDown - similar to fixFrameUp, enter any value to decrease 
%       the chosen threshold by one tier
%
% Output:
%   threshold - value chosen to separate foreground and background of image 
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

%% Masking Process

 
     % Compute the thresholds
    Nvals = 1:20;
    metric = zeros(length(Nvals),1);
    for i = 1:length(Nvals)
        [~, metric(i)] = multithresh(image, Nvals(i) );
    end
 
     
    %Apply multi-Otsu threshold on image
    thresh = multithresh(image,Nvals(find(metric == (max(metric)))));
    
    %Attempt to find largest gap in thresholds
    diffThresh = zeros(length(thresh)-1,1);
    for i = 1:(length(thresh)-1)
       diffThresh(i) = thresh(i+1)/thresh(i);
    end
    threshLevel =1 + (find(diffThresh == max(diffThresh)));
    
    %Change threshold on tier higher or lower if selected
     if isempty(fixFrameUp) && isempty(fixFrameDown)
         threshold = thresh(threshLevel);
     elseif isempty(fixFrameDown)
         threshold = thresh(threshLevel+1);
     else
         threshold =  thresh(threshLevel-1);
     end
    
end