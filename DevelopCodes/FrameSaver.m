classdef FrameSaver < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        saveFlag
        video
        quality
        fig
        profile
        frameRate
        frameDt
        frameCount
        frameTime
        syncMode
        replayMode
    end

    methods
        function obj = FrameSaver(varargin)
            %FRAMESAVER Construct and initialize the FrameSaver
            %   FrameSaver(filename, fig, ...)
            %   filename gives the path and name of video to save
            %   fig provides a specific figure to save
            %   

            parser = inputParser();
            addOptional (parser,'filename','',@(x) ischar(x)||isstring(x));
            addOptional (parser,'fig',[],@ishghandle);
            addParameter(parser,'Framerate',30,@isnumeric);
            addParameter(parser,'Profile','',@(x) ischar(x)||isstring(x));
            addParameter(parser,'EncodeBalance',[],@(x) isnumeric && x >= 0 && x <= 100);
            addParameter(parser,'Quality',80,@isnumeric);
            addParameter(parser,'Prompt','Animation_test',@(x) ischar(x)||isstring(x));
            addParameter(parser,'SyncMode', 'Frames', @(x) any(validatestring(x, {'Frames', 'FrameRate'})));
            addParameter(parser,'ReplayMode', 'FastForward', @(x) any(validatestring(x, {'Pause', 'FastForward'})));

            parse(parser, varargin{:});

            filename = parser.Results.filename;
            profile = parser.Results.Profile;
            encodeBalance = parser.Results.EncodeBalance;
            prompt = parser.Results.Prompt;
            obj.quality = parser.Results.Quality;
            obj.fig = parser.Results.fig;
            obj.frameRate = parser.Results.Framerate;
            obj.syncMode = parser.Results.SyncMode;
            obj.replayMode = parser.Results.ReplayMode;


            % Set profile
            if (isempty(profile) || profile == "")
                % No specified profile, use encode Balance feature
                if isempty(encodeBalance)
                    encodeBalance = 70;
                end

                profiles = {
                    'Uncompressed AVI', 0;
                    'Archival', 10;
                    'Grayscale AVI', 20;
                    'Indexed AVI', 30;
                    'Motion JPEG AVI', 50;
                    'MPEG-4', 70;
                    'Motion JPEG 2000', 100;
                    };
                SupporttedProfiles = string({VideoWriter.getProfiles().Name});

                % Filter out supported profiles
                available = false(1,size(profiles, 1));
                for i = 1:size(profiles, 1)
                    available(i) = ismember(profiles{i, 1}, SupporttedProfiles);
                end
                balanceList = [profiles{available,2}];
                profileList = string(profiles(available,1));
                [~, ind] = min(abs(balanceList - encodeBalance));
                profile = profileList(ind);
            else
                if ~isempty(parser.Results.EncodeBalance)
                    warning("You have specified both Profile and " + ...
                        "EncoderBalance parameters. The video will use the " + ...
                        "encoder %s; EncoderBalance has been ignored.",profile);
                end
            end
            obj.profile = profile;

            % Set extension name
            switch profile
                case {'Uncompressed AVI', 'Archival', 'Grayscale AVI', 'Indexed AVI', 'Motion JPEG AVI'}
                    extensionName = ".avi";
                case 'MPEG-4'
                    extensionName = ".mp4";
                case 'Motion JPEG 2000'
                    extensionName = ".mj2";
            end

            % Open video writer
            if isempty(filename)
%                 filename = inputdlg("File name of video: ","Save as Video",[1 40],prompt + extensionName);
                [file,path,ind] = uiputfile(prompt + extensionName, "Save Video Name");
                filename = [path file];
            end

            if isempty(filename) || ind == 0
                obj.saveFlag = false;
            else
                obj.saveFlag = true;

                obj.video = VideoWriter(filename,profile);
                obj.video.Quality = obj.quality;
                obj.video.FrameRate = obj.frameRate;
                obj.frameDt = 1/obj.frameRate;
                open(obj.video);
                obj.frameCount = 0;
                obj.frameTime = 0;
            end
        end

        function framepause(obj, sec, inputFig)
            %FRAMEPAUSE Pause a frame and write to video
            %   framepause(sec, inputFig)
            %   sec: how long should this frame pause
            %   inputFig: the frame to be saved (optional)
            %   This function would write serval frames to video if the 
            %   video file is defined at initialization, and would just
            %   pause if no video is defined (i.e., you canceled save)
            %   
            %   Note: due to the rendering time, the frame rate of direct
            %   pause is not actuate. 
            %   For veido writing, see the comments of this class for 
            %   how to keep the frame rate.
            drawnow;
            if obj.saveFlag
                    if nargin >= 3
                        if ishghandle(inputFig)
                            figSave = inputFig;
                        else
                            inputFig
                            error("You must input a figure for the second parameter inputFig.");
                        end
                    else
                        if isempty(obj.fig)
                            % No fig given, use the current as default
                            figSave = gcf;
                        else
                            figSave = obj.fig;
                        end
                    end
                frame = getframe(figSave);
                for i=1:max(sec*obj.frameRate,1)
                    writeVideo(obj.video,frame);
                end

                targetFrame = ceil((obj.frameTime + sec)*obj.frameRate);
                switch lower(obj.syncMode)
                    case 'frames'
                        targetFrame = targetFrame + 1;
                        obj.frameTime = obj.frameDt * targetFrame;
                end
                for i = obj.frameCount+1 : targetFrame
                    writeVideo(obj.video,frame);
                end
                obj.frameCount = targetFrame;
            else
                switch lower(obj.replayMode)
                    case 'pause'
                        pause(sec);
                end
            end
        end

        function finish(obj)
            close(obj.video);
        end
    end
end