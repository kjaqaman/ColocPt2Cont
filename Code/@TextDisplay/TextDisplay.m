classdef TextDisplay < MovieDataDisplay
    %Concrete display class for text as an overlay
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
    
    %Hunter Elliott
    %4/2013
    
    properties
        Color=[1 0 0];                
        Visible = 'on';
        Position = [];
        String = [];
    end
    methods
        function obj=TextDisplay(varargin)
            obj@MovieDataDisplay(varargin{:})
        end
        function h=initDraw(obj,data,tag,varargin)            
            %Data should be structure:
            %   data.Position - Nx2 of coordinates for text
            %   data.String - Nx1 cell array of character arrays with text            
            %   data.Color - Nx3 or 1x3 array of RGB colors (optional)
            
            if isfield(data,'Color')
                obj.Color = data.Color;
            end            
            if size(obj.Color) ~= numel(data.String)
                obj.Color = repmat(obj.Color,[numel(data.String) 1]);
            end
            
            h = arrayfun(@(x)(text(data.Position(x,1),data.Position(x,2),data.String{x},'Color',obj.Color(x,:))),1:numel(data.String),...
                'UniformOutput',false);            
            if iscell(h)
                cellfun(@(x) set(x,'Tag',tag),h);
                cellfun(@(x) set(x,'Visible',obj.Visible),h);
                cellfun(@(x) uistack(x,'top'),h);            
            else
                set(h,'Tag',tag);
                set(h,'Visible',obj.Visible)
                uistack(h,'top');            
            end
        end
        function updateDraw(obj,h,data)
            %Being lazy, just redraw it. Ideally this would only update
            %those which had changed.
            tag = get(h(1),'Tag');
            delete(h);
            initDraw(obj,data,tag);            
            
        end

    end    
    
    methods (Static)
        function params=getParamValidators()
            params(1).name='Color';
            params(1).validator=@(x)(size(x,2) == 3);
            params(2).name='Position';
            params(2).validator=@(x)(size(x,2) == 2);
            params(3).name='String';
            params(3).validator=@ischar;
            params(4).name='Visible';
            params(4).validator=@(x)(ismember(x,{'on','off'}));
        end
        function f=getDataValidator()
            f=@(x)(isfield(x,'Position') && size(x.Position,2) == 2 && isfield(x,'String') && iscell(x.String));
        end
    end    
end