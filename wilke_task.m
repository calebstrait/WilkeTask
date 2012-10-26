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
      
      taskType     = 'safeLeft';           % Values: 'double', 'singleSky',
                                           %         'singleFruit', 'safeLeft', or
                                           %         'safeRight'.
      
      correlation  = 0;                    % Values: Floating point numbers between
                                           %         -1 and 1 inclusive.
      
      showUnchosen = true;                 % Values: true or false.
      
      rewardPause  = 0.1;                  % Values: Floating point number.
      
      safeRewards  = [0.08];               % Values: An array of floating point numbers.
      
      rewardArray  = [0.1, 1.0];           % Values: An array of floating point numbers
      
      trackedEye   = 1;                    % Values: 1 (left eye), 2 (right eye).
      
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
    
    safeLBoundXMax   = centerX - hfWidth - imageSize;
    safeLBoundXMin   = 0;
    safeLBoundYMax   = centerY * 2;
    safeLBoundYMin   = 0;
    
    safeRBoundXMax   = centerX * 2;
    safeRBoundXMin   = centerX + hfWidth + imageSize;
    safeRBoundYMax   = centerY * 2;
    safeRBoundYMin   = 0;
    
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
    pointRadius      = 10;                   % Radius of the fixation dot.
    
    % Times.
    chooseHoldTime   = 1;                    % How long subject must look at choice to select it.
    feedbackTime     = 0.5;                  % Time option selected feedback border is given.
    flashInterval    = 0.3;                  % Time between fame redraws when options are spinning.
    ITI              = 1;                    % Intertrial interval.
    initHoldFixTime  = 0.3;                  % Time fixation must be held before choosing an option.
    minFixTime       = 0.1;                  % Minimum time monkey must fixate to start trial.
    spinTime         = 3;                    % How long the slot machine options spin.
    timeToFix        = intmax;               % Amount of time monkey is given to fixate.
    
    % Trial.
    currTrial        = 0;                    % Current trial.
    currCorrOpSky    = '';                   % Current correct sky slot machine option.
    currCorrOpFruit  = '';                   % Current correct fruit slot machine option.
    lastCorrOpSky    = '';                   % Last trial option that was correct for the sky slot machine.
    lastCorrOpFruit  = '';                   % Last trial option that was correct for the fruit slot machine.
    redoFlag         = false;                % Indicates whether a trial is repeating.
    
    % ---------------------------------------------- %
    % ------------------- Setup -------------------- %
    % ---------------------------------------------- %
    
    % Make sure the "taskType" global variable has a legal value.
    if ~strcmp(taskType, 'double') && ...
       ~strcmp(taskType, 'singleSky') && ...
       ~strcmp(taskType, 'singleFruit') && ...
       ~strcmp(taskType, 'safeLeft') && ...
       ~strcmp(taskType, 'safeRight')
        disp('Error: The "taskType" global variable has an illegal value.');
        disp('Legal values: "double", "singleSky", "singleFruit", "safeLeft", or "safeRight".');
        
        Screen('CloseAll');
        
        return;
    end
    
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
                        draw_options(taskType);
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
                        draw_options(taskType);
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
                        draw_options(taskType);
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
                        draw_options(taskType);
                        Screen('Flip', window);
                    end
                end
            elseif strcmp(type, 'singleSky')
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
                        draw_options(taskType);
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
                        draw_options(taskType);
                        Screen('Flip', window);
                    end
                end
            elseif strcmp(type, 'singleFruit')
                % Determine if eye is within the orange option boundary.
                if xCoord >= orangeBoundXMin && xCoord <= orangeBoundXMax && ...
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
                        draw_options(taskType);
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
                        draw_options(taskType);
                        Screen('Flip', window);
                    end
                end
            elseif strcmp(type, 'safeLeft')
                % Determine if eye is within the left safe option boundary.
                if xCoord >= safeLBoundXMin && xCoord <= safeLBoundXMax && ...
                   yCoord >= safeLBoundYMin && yCoord <= safeLBoundYMax
                    draw_feedback('safeLeft', colorWhite);
                    
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(safeLBoundXMin, safeLBoundXMax, ...
                                                    safeLBoundYMin, safeLBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'safeLeft';
                        
                        return;
                    else
                        draw_options(taskType);
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
                        draw_options(taskType);
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
                        draw_options(taskType);
                        Screen('Flip', window);
                    end
                end
            elseif strcmp(type, 'safeRight')
                % Determine if eye is within the right safe option boundary.
                if xCoord >= safeRBoundXMin && xCoord <= safeRBoundXMax && ...
                   yCoord >= safeRBoundYMin && yCoord <= safeRBoundYMax
                    draw_feedback('safeRight', colorWhite);
                    
                    % Determine if eye maintained fixation for given duration.
                    checkFixBreak = fix_break_check(safeRBoundXMin, safeRBoundXMax, ...
                                                    safeRBoundYMin, safeRBoundYMax, ...
                                                    duration);
                    
                    if checkFixBreak == false
                        % Fixation was obtained for desired duration.
                        fixation = true;
                        area = 'safeRight';
                        
                        return;
                    else
                        draw_options(taskType);
                        Screen('Flip', window);
                    end
                % Determine if eye is within the sun option boundary.
                elseif xCoord >= sunBoundXMin && xCoord <= sunBoundXMax && ...
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
                        draw_options(taskType);
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
                        draw_options(taskType);
                        Screen('Flip', window);
                    end
                end
            else
                disp('Fixation being checked with an illegal value for the "type" parameter.');
                disp('Make sure the "taskType" global variable value is correct.');
            end
        end
        
        % Timeout reached.
        fixation = false;
        area = 'none';
    end
    
    function choose_correct_options()
        optionsSky = [{'sun'}, {'moon'}];
        optionsFruit = [{'orange'}, {'apple'}];
        randInt = rand_int(2);
        
        % Choose correct options randomly if on first trial.
        if currTrial == 1
            if strcmp(taskType, 'double')
                % Select a correct choice for the sky slot machine.
                currCorrOpSky = char(optionsSky(randInt));
                lastCorrOpSky = currCorrOpSky;
                
                % Select a correct choice for the fruit slot machine.
                currCorrOpFruit = char(optionsFruit(randInt));
                lastCorrOpFruit = currCorrOpFruit;
            elseif strcmp(taskType, 'singleSky') || strcmp(taskType, 'safeRight')
                % Select a correct choice for the sky slot machine.
                currCorrOpSky = char(optionsSky(randInt));
                lastCorrOpSky = currCorrOpSky;
            elseif strcmp(taskType, 'singleFruit') || strcmp(taskType, 'safeLeft')
                % Select a correct choice for the fruit slot machine.
                currCorrOpFruit = char(optionsFruit(randInt));
                lastCorrOpFruit = currCorrOpFruit;
            end
        else
            if strcmp(taskType, 'double')
                % Select a correct choice for the sky and fruit slot machines.
                if correlation < 0
                    randVal1 = rand;
                    randVal2 = rand;
                    
                    % Make the sky correct choice opposite of the last correct choice.
                    if randVal1 < (correlation * -1)
                        if strcmp(lastCorrOpSky, 'sun')
                            currCorrOpSky = 'moon';
                        else
                            currCorrOpSky = 'sun';
                        end
                        
                        lastCorrOpSky = currCorrOpSky;
                    % Otherwise, make the sky correct choice random.
                    else
                        currCorrOpSky = char(optionsSky(randInt));
                        lastCorrOpSky = currCorrOpSky;
                    end
                    
                    % Make the fruit correct choice opposite of the last correct choice.
                    if randVal2 < (correlation * -1)
                        if strcmp(lastCorrOpFruit, 'orange')
                            currCorrOpFruit = 'apple';
                        else
                            currCorrOpFruit = 'orange';
                        end
                        
                        lastCorrOpFruit = currCorrOpFruit;
                    % Otherwise, make the fruit correct choice random.
                    else
                        currCorrOpFruit = char(optionsFruit(randInt));
                        lastCorrOpFruit = currCorrOpFruit;
                    end
                elseif correlation == 0
                    currCorrOpSky = char(optionsSky(randInt));
                    lastCorrOpSky = currCorrOpSky;
                    
                    currCorrOpFruit = char(optionsFruit(randInt));
                    lastCorrOpFruit = currCorrOpFruit;
                elseif correlation > 0
                    randVal1 = rand;
                    randVal2 = rand;
                    
                    % Make the sky correct choice the same as the last correct choice.
                    if randVal1 < correlation
                        currCorrOpSky = lastCorrOpSky;
                    % Otherwise, make the sky correct choice random.
                    else
                        currCorrOpSky = char(optionsSky(randInt));
                        lastCorrOpSky = currCorrOpSky;
                    end
                    
                    % Make the fruit correct choice the same as the last correct choice.
                    if randVal2 < correlation
                        currCorrOpFruit = lastCorrOpFruit;
                    % Otherwise, make the fruit correct choice random.
                    else
                        currCorrOpFruit = char(optionsFruit(randInt));
                        lastCorrOpFruit = currCorrOpFruit;
                    end
                end
            elseif strcmp(taskType, 'singleSky') || strcmp(taskType, 'safeRight')
                % Select a correct choice for the sky and fruit slot machines.
                if correlation < 0
                    randVal = rand;
                    
                    % Make the sky correct choice opposite of the last correct choice.
                    if randVal < (correlation * -1)
                        if strcmp(lastCorrOpSky, 'sun')
                            currCorrOpSky = 'moon';
                        else
                            currCorrOpSky = 'sun';
                        end
                        
                        lastCorrOpSky = currCorrOpSky;
                    % Otherwise, make the sky correct choice random.
                    else
                        currCorrOpSky = char(optionsSky(randInt));
                        lastCorrOpSky = currCorrOpSky;
                    end
                elseif correlation == 0
                    currCorrOpSky = char(optionsSky(randInt));
                    lastCorrOpSky = currCorrOpSky;
                elseif correlation > 0
                    randVal = rand;
                    
                    % Make the sky correct choice the same as the last correct choice.
                    if randVal < correlation
                        currCorrOpSky = lastCorrOpSky;
                    % Otherwise, make the sky correct choice random.
                    else
                        currCorrOpSky = char(optionsSky(randInt));
                        lastCorrOpSky = currCorrOpSky;
                    end
                end
            elseif strcmp(taskType, 'singleFruit') || strcmp(taskType, 'safeLeft')
                % Select a correct choice for the sky and fruit slot machines.
                if correlation < 0
                    randVal = rand;
                    
                    % Make the fruit correct choice opposite of the last correct choice.
                    if randVal < (correlation * -1)
                        if strcmp(lastCorrOpFruit, 'orange')
                            currCorrOpFruit = 'apple';
                        else
                            currCorrOpFruit = 'orange';
                        end
                        
                        lastCorrOpFruit = currCorrOpFruit;
                    % Otherwise, make the fruit correct choice random.
                    else
                        currCorrOpFruit = char(optionsFruit(randInt));
                        lastCorrOpFruit = currCorrOpFruit;
                    end
                elseif correlation == 0
                    currCorrOpFruit = char(optionsFruit(randInt));
                    lastCorrOpFruit = currCorrOpFruit;
                elseif correlation > 0
                    randVal = rand;
                    
                    % Make the fruit correct choice the same as the last correct choice.
                    if randVal < correlation
                        currCorrOpFruit = lastCorrOpFruit;
                    % Otherwise, make the fruit correct choice random.
                    else
                        currCorrOpFruit = char(optionsFruit(randInt));
                        lastCorrOpFruit = currCorrOpFruit;
                    end
                end
            end
        end
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
        Screen('FillRect', window, color, [centerX - pointRadius; ...
                                           centerY - pointRadius; ...
                                           centerX + pointRadius; ...
                                           centerY + pointRadius]);
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
        % daq = DaqDeviceIndex;
        
        % Determine if multiple rewards should be given.
        numOfRewards = size(rewardDurationsArray, 2);
        if numOfRewards > 1
            multRewards = 1;
        else
            multRewards = 0;
        end
        
        for index = 1:numOfRewards
            % Open juicer.
            % DaqAOut(daq, 0, .6);
            
            % Keep looping to keep juicer open until reward end.
            startTime = GetSecs;
            while (GetSecs - startTime) < rewardDurationsArray(index)
            end
            
            % Close juicer.
            % DaqAOut(daq, 0, 0);
            
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
        % Stuff to do only if this trial is not a repeated trial.
        if ~redoFlag
            currTrial = currTrial + 1;
            choose_correct_options;
        end
        
        % Fixation dot appears.
        draw_fixation_point(colorYellow);
        Screen('Flip', window);
        
        % Check for fixation.
        [fixating, ~] = check_fixation('single', minFixTime, timeToFix);
        
        if fixating
            % Turn all options on.
            draw_options(taskType);
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
                draw_options(taskType);
                Screen('Flip', window);
                
                % Choice period. Check for choice fixations on any four options.
                fixatingOnTarget = false;
                while ~fixatingOnTarget
                    % Check for fixation on any three targets.
                    [fixatingOnTarget, area] = check_fixation(taskType, chooseHoldTime, timeToFix);
                    
                    % Do appropriate action for choices.
                    if fixatingOnTarget
                        % Flash choice feedback border.
                        draw_feedback(area, colorCyan);
                        WaitSecs(feedbackTime);
                        draw_options(taskType);
                        Screen('Flip', window);
                        
                        % Flicker options in gray area.
                        spin_slot_machines(area);
                        
                        % Give reward feedback if earned.
                        if strcmp(area, 'sun') || strcmp(area, 'moon')
                            if strcmp(area, currCorrOpSky)
                                reward(rewardArray);
                            end
                        elseif strcmp(area, 'orange') || strcmp(area, 'apple')
                            if strcmp(area, currCorrOpFruit)
                                reward(rewardArray);
                            end
                        elseif strcmp(area, 'safeLeft') || strcmp(area, 'safeRight')
                            reward(safeRewards);
                        end
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

    function spin_slot_machines(area)
        % Set values for first images displayed in image spins.
        optionsSky = [{'sun'}, {'moon'}];
        optionsFruit = [{'orange'}, {'apple'}];
        randInt1 = rand_int(2);
        randInt2 = rand_int(2);
        optionSky = char(optionsSky(randInt1));
        optionFruit = char(optionsFruit(randInt2));
        
        if strcmp(taskType, 'double')
            startTime = GetSecs;
            while (GetSecs - startTime) < spinTime
                % Set values for displaying images.
                if strcmp(optionSky, 'sun')
                    skyImage = imgSun;
                else
                    skyImage = imgMoon;
                end
                
                if strcmp(optionFruit, 'orange')
                    fruitImage = imgOrange;
                else
                    fruitImage = imgApple;
                end
                
                % Flash images to simulate spin.
                if showUnchosen
                    draw_options(taskType);
                    Screen('PutImage', window, skyImage, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                          leftSpinPosXMax, leftSpinPosYMax]);
                    Screen('PutImage', window, fruitImage, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                            rightSpinPosXMax, rightSpinPosYMax]);
                    Screen('Flip', window);
                    WaitSecs(flashInterval);
                else
                    draw_options(taskType);
                    if strcmp(area, 'sun') || strcmp(area, 'moon')
                        Screen('PutImage', window, skyImage, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                              leftSpinPosXMax, leftSpinPosYMax]);
                    else
                        Screen('PutImage', window, fruitImage, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                                rightSpinPosXMax, rightSpinPosYMax]);
                    end
                    Screen('Flip', window);
                    WaitSecs(flashInterval);
                end

                % Flip displayed image values for next cycle.
                if strcmp(optionSky, 'sun')
                    optionSky = 'moon';
                else
                    optionSky = 'sun';
                end

                if strcmp(optionFruit, 'orange')
                    optionFruit = 'apple';
                else
                    optionFruit = 'orange';
                end
            end

            % After all spinning is done, show actual correct values.
            if strcmp(currCorrOpSky, 'sun') && strcmp(currCorrOpFruit, 'orange')
                draw_options(taskType);
                if showUnchosen
                    Screen('PutImage', window, imgSun, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                        leftSpinPosXMax, leftSpinPosYMax]);
                    Screen('PutImage', window, imgOrange, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                           rightSpinPosXMax, rightSpinPosYMax]);
                else
                    if strcmp(area, 'sun') || strcmp(area, 'moon')
                        Screen('PutImage', window, imgSun, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                            leftSpinPosXMax, leftSpinPosYMax]);
                    else
                        Screen('PutImage', window, imgOrange, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                               rightSpinPosXMax, rightSpinPosYMax]);
                    end
                end
                Screen('Flip', window);
            elseif strcmp(currCorrOpSky, 'sun') && strcmp(currCorrOpFruit, 'apple')
                draw_options(taskType);
                if showUnchosen
                    Screen('PutImage', window, imgSun, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                        leftSpinPosXMax, leftSpinPosYMax]);
                    Screen('PutImage', window, imgApple, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                          rightSpinPosXMax, rightSpinPosYMax]);
                else
                    if strcmp(area, 'sun') || strcmp(area, 'moon')
                        Screen('PutImage', window, imgSun, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                            leftSpinPosXMax, leftSpinPosYMax]);
                    else
                        Screen('PutImage', window, imgApple, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                              rightSpinPosXMax, rightSpinPosYMax]);
                    end
                end
                Screen('Flip', window);
            elseif strcmp(currCorrOpSky, 'moon') && strcmp(currCorrOpFruit, 'orange')
                draw_options(taskType);
                if showUnchosen
                    Screen('PutImage', window, imgMoon, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                         leftSpinPosXMax, leftSpinPosYMax]);
                    Screen('PutImage', window, imgOrange, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                           rightSpinPosXMax, rightSpinPosYMax]);
                else
                    if strcmp(area, 'sun') || strcmp(area, 'moon')
                        Screen('PutImage', window, imgMoon, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                             leftSpinPosXMax, leftSpinPosYMax]);
                    else
                        Screen('PutImage', window, imgOrange, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                               rightSpinPosXMax, rightSpinPosYMax]);
                    end
                end
                Screen('Flip', window);
            elseif strcmp(currCorrOpSky, 'moon') && strcmp(currCorrOpFruit, 'apple')
                draw_options(taskType);
                if showUnchosen
                    Screen('PutImage', window, imgMoon, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                         leftSpinPosXMax, leftSpinPosYMax]);
                    Screen('PutImage', window, imgApple, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                          rightSpinPosXMax, rightSpinPosYMax]);
                else
                    if strcmp(area, 'sun') || strcmp(area, 'moon')
                        Screen('PutImage', window, imgMoon, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                             leftSpinPosXMax, leftSpinPosYMax]);
                    else
                        Screen('PutImage', window, imgApple, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                              rightSpinPosXMax, rightSpinPosYMax]);
                    end
                end
                Screen('Flip', window);
            end
        elseif strcmp(taskType, 'singleSky') || strcmp(taskType, 'safeRight')
            if showUnchosen || strcmp(area, 'sun') || strcmp(area, 'moon')
                startTime = GetSecs;
                while (GetSecs - startTime) < spinTime
                    % Set values for displaying images.
                    if strcmp(optionSky, 'sun')
                        skyImage = imgSun;
                    else
                        skyImage = imgMoon;
                    end

                    % Flash images to simulate spin.
                    draw_options(taskType);
                    Screen('PutImage', window, skyImage, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                          leftSpinPosXMax, leftSpinPosYMax]);
                    Screen('Flip', window);
                    WaitSecs(flashInterval);
                    
                    % Flip displayed image values for next cycle.
                    if strcmp(optionSky, 'sun')
                        optionSky = 'moon';
                    else
                        optionSky = 'sun';
                    end
                end

                % After all spinning is done, show actual correct values.
                if strcmp(currCorrOpSky, 'sun')
                    draw_options(taskType);
                    Screen('PutImage', window, imgSun, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                        leftSpinPosXMax, leftSpinPosYMax]);
                    Screen('Flip', window);
                elseif strcmp(currCorrOpSky, 'moon')
                    draw_options(taskType);
                    Screen('PutImage', window, imgMoon, [leftSpinPosXMin, leftSpinPosYMin, ...
                                                         leftSpinPosXMax, leftSpinPosYMax]);
                    Screen('Flip', window);
                end
            end
        elseif strcmp(taskType, 'singleFruit') || strcmp(taskType, 'safeLeft')
            if showUnchosen || strcmp(area, 'orange') || strcmp(area, 'apple')
                startTime = GetSecs;
                while (GetSecs - startTime) < spinTime
                    % Set values for displaying images.
                    if strcmp(optionFruit, 'orange')
                        fruitImage = imgOrange;
                    else
                        fruitImage = imgApple;
                    end

                    % Flash images to simulate spin.
                    draw_options(taskType);
                    Screen('PutImage', window, fruitImage, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                            rightSpinPosXMax, rightSpinPosYMax]);
                    Screen('Flip', window);
                    WaitSecs(flashInterval);
                    
                    if strcmp(optionFruit, 'orange')
                        optionFruit = 'apple';
                    else
                        optionFruit = 'orange';
                    end
                end

                % After all spinning is done, show actual correct values.
                if strcmp(currCorrOpFruit, 'orange')
                    draw_options(taskType);
                    Screen('PutImage', window, imgOrange, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                           rightSpinPosXMax, rightSpinPosYMax]);
                    Screen('Flip', window);
                elseif strcmp(currCorrOpFruit, 'apple')
                    draw_options(taskType);
                    Screen('PutImage', window, imgApple, [rightSpinPosXMin, rightSpinPosYMin, ...
                                                          rightSpinPosXMax, rightSpinPosYMax]);
                    Screen('Flip', window);
                end
            end
        end
    end
end