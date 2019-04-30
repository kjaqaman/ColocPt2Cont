classdef MultiThreshProcess < SegmentationProcess
    % A concrete class for using multi-otsu for background/foreground
    % segmentation
    % Anthony Vega 09/2014
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
    methods (Access = public)
        function obj = MultiThreshProcess(owner,varargin)
            
            if nargin == 0
                super_args = {};
            else
                % Input check
                ip = inputParser;
                ip.addRequired('owner',@(x) isa(x,'MovieData'));
                ip.addOptional('outputDir',owner.outputDirectory_,@ischar);
                ip.addOptional('funParams',[],@isstruct);
                ip.parse(owner,varargin{:});
                outputDir = ip.Results.outputDir;
                funParams = ip.Results.funParams;
                
                % Define arguments for superclass constructor
                super_args{1} = owner;
                super_args{2} = MultiThreshProcess.getName;
                super_args{3} = @multiThreshMovie;
                if isempty(funParams)
                    funParams = MultiThreshProcess.getDefaultParams(owner,outputDir);
                end
                super_args{4} = funParams;
            end
            
            obj = obj@SegmentationProcess(super_args{:});
        end
        
    end
    methods (Static)
        function name = getName()
            name = 'Thresholding';
        end
        function h = GUI()
            h= @thresholdProcessGUI;
        end
        
        function funParams = getDefaultParams(owner,varargin)
            % Input check
            ip=inputParser;
            ip.addRequired('owner',@(x) isa(x,'MovieData'));
            ip.addOptional('outputDir',owner.outputDirectory_,@ischar);
            ip.parse(owner, varargin{:})
            outputDir=ip.Results.outputDir;
            
            % Set default parameters
            funParams.ChannelIndex = 1:numel(owner.channels_);
            funParams.OutputDirectory = [outputDir  filesep 'masks'];
            funParams.ProcessIndex = [];%Default is to use raw images
            funParams.ThresholdValue = []; % automatic threshold selection
            funParams.MaxJump = 0; %Default is no jump suppression
            funParams.GaussFilterSigma = 0; %Default is no filtering.
            funParams.BatchMode = false;
            funParams.incThreshold = [];
            funParams.decThreshold = [];
        end
    end
end