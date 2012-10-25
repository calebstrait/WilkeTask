% Copyright (c) 2012 University of Rochester

function wilke_task()
    % ---------------------------------------------- %
    % -------------- Global variables -------------- %
    % ---------------------------------------------- %
    
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@                                @@@@@@@ %
    % @@@@@@@  FREQUENTLY CHANGED VARIABLES  @@@@@@@ %
    % @@@@@@@                                @@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
      
      taskType  = 'double';             % Values: 'double', 'singleSky',
                                        %         'singleFruit', 'safeLeft', or
                                        %         'safeRight'.
      trackedEye = 1;                   % Values: 1 (left eye), 2 (right eye).
      
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    
    % Colors.
    colorBackground  = [25 23 23];
    colorCyan        = [0 255 255];
    colorGray        = [128 128 128];
    colorDarkGray    = [70 70 70];
    colorYellow      = [255 255 0];
    colorWhite       = [255 255 255];
    
    % Coordinates.
    borderThick      = 20;                   % Thickness of image borders.
    centerX          = 512;                  % X pixel coordinate for the screen center.
    centerY          = 384;                  % Y pixel coordinate for the screen center.
    distFromSide     = 50;                   % Margin between images and screen edge side.
    distFromUpDown   = 139;                  % Margin between images and screen top and bottom.
    hfWidth          = 75;                   % Half the width of the fixation boxes.
    imageSize        = 150;                  % Height and width for images.
    safeOpHeight     = 300;                  % Height of safe option bar.
    safeOpWidth      = 80;                   % Width of safe option bar.
    
    % Intermediate calculation for the safe option bar height position.
    safeOpCeilGap    = ((centerY * 2 - distFromUpDown * 2) - safeOpHeight) / 2;
    
    % Values to calculate fixation point bounds.
    fixBoundXMax     = centerX + imageSize * 0.75;
    fixBoundXMin     = centerX - imageSize * 0.75;
    fixBoundYMax     = centerY + imageSize * 0.75;
    fixBoundYMin     = centerY - imageSize * 0.75;
    
    % Option fixation boundry values.
    sunBoundXMax     = centerX - hfWidth - imageSize;
    sunBoundXMin     = 0;
    sunBoundYMax     = centerY - imageSize / 2;
    sunBoundYMin     = 0;
    
    moonBoundXMax    = centerX - hfWidth - imageSize;
    moonBoundXMin    = 0;
    moonBoundYMax    = centerY * 2;
    moonBoundYMin    = centerY + hfWidth;
    
    orangeBoundXMax  = centerX * 2;
    orangeBoundXMin  = centerX + hfWidth + imageSize;
    orangeBoundYMax  = centerY - imageSize / 2;
    orangeBoundYMin  = 0;
    
    appleBoundXMax   = centerX * 2;
    appleBoundXMin   = centerX + hfWidth + imageSize;
    appleBoundYMax   = centerY * 2;
    appleBoundYMin   = centerY + hfWidth;
    
    % Coordinates for sun slot machine option.
    sunPosXMax       = distFromSide + imageSize;
    sunPosXMin       = distFromSide;
    sunPosYMax       = distFromUpDown + imageSize;
    sunPosYMin       = distFromUpDown;
    
    % Coordinates for the moon slot machine option.
    moonPosXMax      = distFromSide + imageSize;
    moonPosXMin      = distFromSide;
    moonPosYMax      = distFromUpDown + imageSize * 3 + borderThick * 2;
    moonPosYMin      = distFromUpDown + imageSize * 2 + borderThick * 2;
    
    % Coordinates for the orange slot machine option.
    orangePosXMax    = centerX * 2 - distFromSide;
    orangePosXMin    = centerX * 2 - distFromSide - imageSize;
    orangePosYMax    = distFromUpDown + imageSize;
    orangePosYMin    = distFromUpDown;
    
    % Coordinates for the apple slot machine option.
    applePosXMax     = centerX * 2 - distFromSide;
    applePosXMin     = centerX * 2 - distFromSide - imageSize;
    applePosYMax     = distFromUpDown + imageSize * 3 + borderThick * 2;
    applePosYMin     = distFromUpDown + imageSize * 2 + borderThick * 2;
    
    % Coordinates for the left gray spin area.
    leftSpinPosXMax  = distFromSide + imageSize;
    leftSpinPosXMin  = distFromSide;
    leftSpinPosYMax  = distFromUpDown + imageSize * 2 + borderThick;
    leftSpinPosYMin  = distFromUpDown + imageSize + borderThick;
    
    % Coordinates for the right gray spin area.
    rightSpinPosXMax = centerX * 2 - distFromSide;
    rightSpinPosXMin = centerX * 2 - distFromSide - imageSize;
    rightSpinPosYMax = distFromUpDown + imageSize * 2 + borderThick;
    rightSpinPosYMin = distFromUpDown + imageSize + borderThick;
    
    % Coordinates for the left safe option.
    leftSafePosXMax  = distFromSide + safeOpWidth;
    leftSafePosXMin  = distFromSide;
    leftSafePosYMax  = safeOpCeilGap + distFromUpDown + safeOpHeight;
    leftSafePosYMin  = safeOpCeilGap + distFromUpDown;
    
    % Coordinates for the right safe option.
    rightSafePosXMax = centerX * 2 - distFromSide;
    rightSafePosXMin = centerX * 2 - distFromSide - safeOpWidth;
    rightSafePosYMax = safeOpCeilGap + distFromUpDown + safeOpHeight;
    rightSafePosYMin = safeOpCeilGap + distFromUpDown;
    
    % References.
    monkeyScreen     = 0;                    % Number of the screen the monkey sees.
    
    % Saving.
    choiceMade       = '';                   % Which side was chosen.
    data             = struct([]);           % Workspace variable where trial data is saved.
    numChoseImg      = 0;                    % Times image was chosen.
    numCorrTimes     = 0;                    % Times "correct" probe option chosen.
    percentChoseImg  = 0;                    % Percent of times the image option was chosen.
    percentCorrect   = 0;                    % Percent "corect" probe chosen.
    rewardRepeatData = '/Data/WilkeTask';    % Directory where .mat files are saved.
    saveCommand      = NaN;                  % Command string that will save .mat files.
    varName          = 'data';               % Name of the variable to save in the workspace.
    
    % Stimuli.
    bordThick        = 20;                   % Thickness for all borders.
    dotRadius        = 10;                   % Radius of the fixation dot.
    feedThick        = 10;                   % Thickness of the feedback borders.
    fixAdj           = 1;
    
    % Times.
    chooseHoldTime   = 1;                  % How long subject must look at choice to select it.
    ITI              = 1;                    % Intertrial interval.
    initHoldFixTime  = 0.3;                  % Time fixation must be held before choosing an option.
    minFixTime       = 0.1;                  % Minimum time monkey must fixate to start trial.
    timeToFix        = intmax;               % Amount of time monkey is given to fixate.
    
    % Trial.
    currTrial        = 0;                    % Current trial.
    redoFlag         = false;                % Indicates whether a trial is repeating.
    
    % ---------------------------------------------- %
    % ------------------- Setup -------------------- %
    % ---------------------------------------------- %
    
    disp('MAKE SURE TO TAKE IN MONKEY INITIAL');
    
    % Load images.
    imgApple = imread('images/apple.jpg', 'jpg');
    imgOrange = imread('images/orange.jpg', 'jpg');
    imgSun = imread('images/sun.jpg', 'jpg');
    imgMoon = imread('images/moon.jpg', 'jpg');
    
    % Saving.
    % prepare_for_saving;
    
    % Window.
    window = setup_window;
    
    % Eyelink.
    % setup_eyelink;
    
    % ---------------------------------------------- %
    % ------------ Main experiment loop ------------ %
    % ---------------------------------------------- %
    
    running = true;
    while running
        run_single_trial;
        
        % print_stats;
        
        % Check for pausing or quitting during ITI.
        startingTime = GetSecs;
        while ITI > (GetSecs - startingTime)
            key = key_check;
            
            % Pause experiment.
            if key.pause == 1
                pause(key);
            end
            
            % Exit experiment.
            if key.escape == 1
                running = false;
            end
        end
    end
    
    Screen('CloseAll');
    
    % ---------------------------------------------- %
    % ----------------- Functions ------------------ %
    % ---------------------------------------------- %
    
    % TODO: Uses globals AND only two stimuli locations. Be careful using.
    % Determines if the eye has fixated within the given bounds
    % for the given duration before the given timeout occurs.
    function [fixation, area] = check_fixation(type, duration, timeout)
        startTime = GetSecs;
        
        % Keep checking for fixation until timeout occurs.
        while timeout > (GetSecs - startTime)
            [xCoord, yCoord] = get_eye_coords;
            
            % Determine if one, two, or three locations are being tracked.
            if strcmp(type, 'single')
                % Determine if eye is within the fixation boundary.
                if xCoord >= fixBoundXMin && xCoord <= fixBoundXMax && ...
                   yCoord >= fixBoundYMin && yCoord <= fixBoundYMax
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(fixBoundXMin, fixBoundXMax, ...
                                                    fixBoundYMin, fixBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'single';
                        
                        return;
                    end
                end
            elseif strcmp(type, 'double')
                % Determine if eye is within the sun option boundary.
                if xCoord >= sunBoundXMin && xCoord <= sunBoundXMax && ...
                   yCoord >= sunBoundYMin && yCoord <= sunBoundYMax
                    draw_feedback('sun', colorWhite);
                    
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(sunBoundXMin, sunBoundXMax, ...
                                                    sunBoundYMin, sunBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'sun';
                        
                        return;
                    else
                        draw_options('double');
                        Screen('Flip', window);
                    end
                % Determine if eye is within the moon option boundary.
                elseif xCoord >= moonBoundXMin && xCoord <= moonBoundXMax && ...
                       yCoord >= moonBoundYMin && yCoord <= moonBoundYMax
                    draw_feedback('moon', colorWhite);
                    
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(moonBoundXMin, moonBoundXMax, ...
                                                    moonBoundYMin, moonBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'moon';
                        
                        return;
                    else
                        draw_options('double');
                        Screen('Flip', window);
                    end
                % Determine if eye is within the orange option boundary.
                elseif xCoord >= orangeBoundXMin && xCoord <= orangeBoundXMax && ...
                       yCoord >= orangeBoundYMin && yCoord <= orangeBoundYMax
                    draw_feedback('orange', colorWhite);
                    
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(orangeBoundXMin, orangeBoundXMax, ...
                                                    orangeBoundYMin, orangeBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'orange';
                        
                        return;
                    else
                        draw_options('double');
                        Screen('Flip', window);
                    end
                % Determine if eye is within the apple option boundary.
                elseif xCoord >= appleBoundXMin && xCoord <= appleBoundXMax && ...
                       yCoord >= appleBoundYMin && yCoord <= appleBoundYMax
                    draw_feedback('apple', colorWhite);
                    
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(appleBoundXMin, appleBoundXMax, ...
                                                    appleBoundYMin, appleBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'apple';
                        
                        return;
                    else
                        draw_options('double');
                        Screen('Flip', window);
                    end
                end
            else
                disp('Fixation being checked with an illegal value for the "type" parameter.');
            end
        end
        
        % Timeout reached.
        fixation = false;
        area = 'none';
    end
    
    % Draw colored outlines around options for feedback.
    function draw_feedback(location, color)
        if strcmp(location, 'sun')
            draw_options(taskType);
            Screen('FrameRect', window, color, [sunPosXMin - borderThick, ...
                                                sunPosYMin - borderThick, ...
                                                sunPosXMax + borderThick, ...
                                                sunPosYMax + borderThick], borderThick);
        elseif strcmp(location, 'moon')
            draw_options(taskType);
            Screen('FrameRect', window, color, [moonPosXMin - borderThick, ...
                                                moonPosYMin - borderThick, ...
                                                moonPosXMax + borderThick, ...
                                                moonPosYMax + borderThick], borderThick);
        elseif strcmp(location, 'orange')
            draw_options(taskType);
            Screen('FrameRect', window, color, [orangePosXMin - borderThick, ...
                                                orangePosYMin - borderThick, ...
                                                orangePosXMax + borderThick, ...
                                                orangePosYMax + borderThick], borderThick);
        elseif strcmp(location, 'apple')
            draw_options(taskType);
            Screen('FrameRect', window, color, [applePosXMin - borderThick, ...
                                                applePosYMin - borderThick, ...
                                                applePosXMax + borderThick, ...
                                                applePosYMax + borderThick], borderThick);
        elseif strcmp(location, 'safeLeft')
            draw_options(taskType);
            Screen('FrameRect', window, color, [leftSafePosXMin - borderThick, ...
                                                leftSafePosYMin - borderThick, ...
                                                leftSafePosXMax + borderThick, ...
                                                leftSafePosYMax + borderThick], borderThick);
        elseif strcmp(location, 'safeRight')
            draw_options(taskType);
            Screen('FrameRect', window, color, [rightSafePosXMin - borderThick, ...
                                                rightSafePosYMin - borderThick, ...
                                                rightSafePosXMax + borderThick, ...
                                                rightSafePosYMax + borderThick], borderThick);
        end
        
        Screen('Flip', window);
    end
    
    % TODO: Uses globals. Make sure they are what you think they are.
    % Draws a thin line on top of the invisible fixation boundaries.
    function draw_fixation_bounds()
        Screen('FrameRect', window, colorYellow, [fixBoundXMin fixBoundYMin ...
                                                  fixBoundXMax fixBoundYMax], 1);
        Screen('Flip', window);
    end
    
    % Draws the fixation point on the screen.
    function draw_fixation_point(color)
        Screen('FillRect', window, color, [centerX - dotRadius + fixAdj; ...
                                           centerY - dotRadius; ...
                                           centerX + dotRadius - fixAdj; ...
                                           centerY + dotRadius]);
    end
    
    function draw_options(type)
        if strcmp(type, 'double')
            Screen('PutImage', window, imgSun, [sunPosXMin, sunPosYMin, ...
                                                sunPosXMax, sunPosYMax]);
            Screen('PutImage', window, imgMoon, [moonPosXMin, moonPosYMin, ...
                                                 moonPosXMax, moonPosYMax]);
            Screen('PutImage', window, imgOrange, [orangePosXMin, orangePosYMin, ...
                                                   orangePosXMax, orangePosYMax]);
            Screen('PutImage', window, imgApple, [applePosXMin, applePosYMin, ...
                                                  applePosXMax, applePosYMax]);
            Screen('FillRect', window, colorDarkGray, [leftSpinPosXMin; ...
                                                       leftSpinPosYMin; ...
                                                       leftSpinPosXMax; ...
                                                       leftSpinPosYMax]);
            Screen('FillRect', window, colorDarkGray, [rightSpinPosXMin; ...
                                                       rightSpinPosYMin; ...
                                                       rightSpinPosXMax; ...
                                                       rightSpinPosYMax]);
        elseif strcmp(type, 'singleSky')
            Screen('PutImage', window, imgSun, [sunPosXMin, sunPosYMin, ...
                                                sunPosXMax, sunPosYMax]);
            Screen('PutImage', window, imgMoon, [moonPosXMin, moonPosYMin, ...
                                                 moonPosXMax, moonPosYMax]);
            Screen('FillRect', window, colorDarkGray, [leftSpinPosXMin; ...
                                                       leftSpinPosYMin; ...
                                                       leftSpinPosXMax; ...
                                                       leftSpinPosYMax]);
        elseif strcmp(type, 'singleFruit')
            Screen('PutImage', window, imgOrange, [orangePosXMin, orangePosYMin, ...
                                                   orangePosXMax, orangePosYMax]);
            Screen('PutImage', window, imgApple, [applePosXMin, applePosYMin, ...
                                                  applePosXMax, applePosYMax]);
            Screen('FillRect', window, colorDarkGray, [rightSpinPosXMin; ...
                                                       rightSpinPosYMin; ...
                                                       rightSpinPosXMax; ...
                                                       rightSpinPosYMax]);
        elseif strcmp(type, 'safeLeft')
            Screen('PutImage', window, imgOrange, [orangePosXMin, orangePosYMin, ...
                                                   orangePosXMax, orangePosYMax]);
            Screen('PutImage', window, imgApple, [applePosXMin, applePosYMin, ...
                                                  applePosXMax, applePosYMax]);
            Screen('FillRect', window, colorDarkGray, [rightSpinPosXMin; ...
                                                       rightSpinPosYMin; ...
                                                       rightSpinPosXMax; ...
                                                       rightSpinPosYMax]);
            Screen('FillRect', window, colorGray, [leftSafePosXMin; ...
                                                   leftSafePosYMin; ...
                                                   leftSafePosXMax; ...
                                                   leftSafePosYMax]);
        elseif strcmp(type, 'safeRight')
            Screen('PutImage', window, imgSun, [sunPosXMin, sunPosYMin, ...
                                                sunPosXMax, sunPosYMax]);
            Screen('PutImage', window, imgMoon, [moonPosXMin, moonPosYMin, ...
                                                 moonPosXMax, moonPosYMax]);
            Screen('FillRect', window, colorDarkGray, [leftSpinPosXMin; ...
                                                       leftSpinPosYMin; ...
                                                       leftSpinPosXMax; ...
                                                       leftSpinPosYMax]);
            Screen('FillRect', window, colorGray, [rightSafePosXMin; ...
                                                   rightSafePosYMin; ...
                                                   rightSafePosXMax; ...
                                                   rightSafePosYMax]);
        end
    end
    
    % Checks if the eye breaks fixation bounds before end of duration.
    function fixationBreak = fix_break_check(xBoundMin, xBoundMax, ...
                                             yBoundMin, yBoundMax, ...
                                             duration)
        fixStartTime = GetSecs;
        
        % Keep checking for fixation breaks for the entire duration.
        while duration > (GetSecs - fixStartTime)
            [xCoord, yCoord] = get_eye_coords;
            
            % Determine if the eye has left the fixation boundaries.
            if xCoord < xBoundMin || xCoord > xBoundMax || ...
               yCoord < yBoundMin || yCoord > yBoundMax
                % Eye broke fixation before end of duration.
                fixationBreak = true;
                
                return;
            end
        end
        
        % Eye maintained fixation for entire duration.
        fixationBreak = false;
    end
    
    % TODO: Change back to eye (not mouse) control.
    % Returns the current x and y coordinants of the given eye.
    function [xCoord, yCoord] = get_eye_coords()
        %{
        sampledPosition = Eyelink('NewestFloatSample');
        xCoord = sampledPosition.gx(trackedEye);
        yCoord = sampledPosition.gy(trackedEye);
        %}
        
        [xCoord, yCoord, ~, ~, ~, ~] = GetMouse(window);
    end
    
    % Checks to see what key was pressed.
    function key = key_check()
        % Assign key codes to some variables.
        stopKey = KbName('ESCAPE');
        pauseKey = KbName('RightControl');
        
        % Make sure default values of key are zero.
        key.pressed = 0;
        key.escape = 0;
        key.pause = 0;
        
        % Get info about any key that was just pressed.
        [~, ~, keyCode] = KbCheck;
        
        % Check pressed key against the keyCode array of 256 key codes.
        if keyCode(stopKey)
            key.escape = 1;
            key.pressed = 1;
        end
        
        if keyCode(pauseKey)
            key.pause = 1;
            key.pressed = 1;
        end
    end
    
    % TODO: Make sure files/folders are correct.
    % Makes a folder and file where data will be saved.
    function prepare_for_saving()
        cd(rewardRepeatData);
        
        % Check if cell ID was passed in with monkey's initial.
        if numel(monkeysInitial) == 1
            initial = monkeysInitial;
            cell = '';
        else
            initial = monkeysInitial(1);
            cell = monkeysInitial(2);
        end
        
        dateStr = datestr(now, 'yymmdd');
        filename = [initial dateStr '.' cell '1.RR.mat'];
        folderNameDay = [initial dateStr];
        
        % Make and/or enter a folder where .mat files will be saved.
        if exist(folderNameDay, 'dir') == 7
            cd(folderNameDay);
        else
            mkdir(folderNameDay);
            cd(folderNameDay);
        end
        
        % Make sure the filename for the .mat file is not already used.
        fileNum = 1;
        while fileNum ~= 0
            if exist(filename, 'file') == 2
                fileNum = fileNum + 1;
                filename = [initial dateStr '.' cell num2str(fileNum) '.RR.mat'];
            else
                fileNum = 0;
            end
        end
        
        saveCommand = ['save ' filename ' ' varName];
    end
    
    % Prints current trial stats.
    function print_stats()
        % TODO: Update to print stats for this task.
        % Convert percentages to strings.
        percentChoseImgStr = strcat(num2str(percentChoseImg), '%');
        percentCorrStr = strcat(num2str(percentCorrect), '%');
        trialCountStr = num2str(currTrial);
        
        home;
        disp('             ');
        disp('****************************************');
        disp('             ');
        fprintf('Total trials: % s', trialCountStr);
        disp('             ');
        disp('             ');
        disp('----------------------------------------');
        disp('             ');
        fprintf('Total correct: % s', percentCorrStr);
        disp('             ');
        fprintf('Chose image: % s', percentChoseImgStr);
        disp('             ');
        disp('             ');
        disp('****************************************');
    end
    
    function k = pause(k)
        disp('             ');
        disp('\\\\\\\\\\\\\\\\\\\\\\\\\\\\          /////////////////////////////');
        disp(' \\\\\\\\\\\\\\\\\\\\\\\\\\\\ PAUSED /////////////////////////////');
        disp('  |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
        
        while k.pressed == 1
            k = key_check;
        end
        
        pause = 1;
        while pause == 1 && k.escape ~= 1
            k = key_check;
            
            if k.pause == 1
                pause = 0;
            end
        end
        
        while k.pressed == 1
            k = key_check;
        end
        
        disp('             ');
        disp('  ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
        disp(' /////////////////////////// UNPAUSED \\\\\\\\\\\\\\\\\\\\\\\\\\\');
        disp('///////////////////////////            \\\\\\\\\\\\\\\\\\\\\\\\\\\');
        disp('             ');
    end
    
    % Returns a random int between 1 (inclusive) and integer (inclusive).
    function randInt = rand_int(integer)
        randInt = floor(rand(1) * integer + 1);
    end
    
    % Rewards monkey using the juicer with the array of passed duration(s).
    function reward(rewardDurationsArray)
        % Get a reference the juicer device and set reward duration.
        daq = DaqDeviceIndex;
        
        % Determine if multiple rewards should be given.
        numOfRewards = size(rewardDurationsArray, 2);
        if numOfRewards > 1
            multRewards = 1;
        else
            multRewards = 0;
        end
        
        for index = 1:numOfRewards
            % Open juicer.
            DaqAOut(daq, 0, .6);
            
            % Keep looping to keep juicer open until reward end.
            startTime = GetSecs;
            while (GetSecs - startTime) < rewardDurationsArray(index)
            end
            
            % Close juicer.
            DaqAOut(daq, 0, 0);
            
            % Pause between multiple rewards.
            if multRewards
                % Don't pause after the last reward in a sequence.
                if index ~= numOfRewards
                    WaitSecs(rewardPause);
                end
            end
        end
    end
    
    function run_single_trial()
        % Increment trial counter only if this trial is not a repeated trial.
        if ~redoFlag
            currTrial = currTrial + 1;
        end
        
        % Fixation dot appears.
        draw_fixation_point(colorYellow);
        Screen('Flip', window);
        
        % Check for fixation.
        [fixating, ~] = check_fixation('single', minFixTime, timeToFix);
        
        if fixating
            % Turn all options on.
            draw_options('double');
            draw_fixation_point(colorYellow);
            Screen('Flip', window);
            
            % Determine if eye maintained hold fixation for given duration.
            checkFixBreak = fix_break_check(fixBoundXMin, fixBoundXMax, ...
                                            fixBoundYMin, fixBoundYMax, ...
                                            initHoldFixTime);
            
            % Repeat trial if fixation is broken in hold state.
            if checkFixBreak
                redoFlag = true;
                
                % Redo this trial since monkey failed it.
                run_single_trial;
                
                return;
            else
                redoFlag = false;
                
                % Turn all options on without a fixation point.
                draw_options('double');
                Screen('Flip', window);
                
                % Choice period. Check for choice fixations on any four options.
                fixatingOnTarget = false;
                while ~fixatingOnTarget
                    % Check for fixation on any three targets.
                    [fixatingOnTarget, area] = check_fixation(taskType, chooseHoldTime, timeToFix);
                    
                    % Do appropriate action for choices.
                    if fixatingOnTarget
                        % Spin options.
                        
                        % Give feedback.
                    end
                end
            end
        else
            % Redo this trial since monkey failed to start it.
            run_single_trial;
        end 
    end
    
    % Saves trial data to a .mat file.
    function save_trial_data()
        % TODO: Update/add saved variables relevant variables.
        % Save variables to a .mat file.
        data(currTrial).trial = currTrial;
        
        eval(saveCommand);
    end
    
    % Sets up the Eyelink system.
    function setup_eyelink()
        abortSetup = false;
        setupMode = 2;
        
        % Connect Eyelink to computer if unconnected.
        if ~Eyelink('IsConnected')
            Eyelink('Initialize');
        end
        
        % Start recording eye position.
        Eyelink('StartRecording');
        
        % Set some preferences.
        Eyelink('Command', 'randomize_calibration_order = NO');
        Eyelink('Command', 'force_manual_accept = YES');
        
        Eyelink('StartSetup');
        
        % Wait until Eyelink actually enters setup mode.
        while ~abortSetup && Eyelink('CurrentMode') ~= setupMode
            [keyIsDown, ~, keyCode] = KbCheck;
            
            if keyIsDown && keyCode(KbName('ESCAPE'))
                abortSetup = true;
                disp('Aborted while waiting for Eyelink!');
            end
        end
        
        % Put Eyelink in output mode.
        Eyelink('SendKeyButton', double('o'), 0, 10);
        
        % Start recording.
        Eyelink('SendKeyButton', double('o'), 0, 10);
    end
    
    % Sets up a new window and sets preferences for it.
    function window = setup_window()
        % Print only PTB errors.
        Screen('Preference', 'VisualDebugLevel', 1);
        
        % Suppress the print out of all PTB warnings.
        Screen('Preference', 'Verbosity', 0);
        
        % Setup a screen for displaying stimuli for this session.
        window = Screen('OpenWindow', monkeyScreen, colorBackground);
    end
end