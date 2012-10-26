% Copyright (c) 2012 University of Rochester

function wilke_task(monkeysInitial)
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
      
      taskType        = 'double';             % Values: 'double', 'singleSky',
                                              %         'singleFruit', 'safeLeft', or
                                              %         'safeRight'.
      
      correlation     = 0;                    % Values: Floating point numbers between
                                              %         -1 and 1 inclusive.
      
      showUnchosen    = false;                % Values: true or false.
      
      safeRewards     = [0.05, 0.08, 0.15];   % Values: An array of floating point numbers.
      
      rewardDuration  = 0.1;                  % Values: An array of floating point numbers
      
      trackedEye      = 1;                    % Values: 1 (left eye), 2 (right eye).
      
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    % @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %
    
    % Colors.
    colorBackground  = [25 23 23];
    colorCyan        = [0 255 255];
    colorGray        = [128 128 128];
    colorDarkGray    = [60 60 60];
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
    choiceCorrect    = '';                   % Whether the subject chose correctly.
    choiceMade       = '';                   % Which option was chosen.
    choiceMachine    = '';                   % Which slot machine was chosen.
    data             = struct([]);           % Workspace variable where trial data is saved.
    numChoseApple    = 0;                    % Times fruit slot machine was chosen.
    numChoseFruit    = 0;                    % Times fruit slot machine was chosen.
    numChoseMoon     = 0;                    % Times fruit slot machine was chosen.
    numChoseOrange   = 0;                    % Times sky slot machine was chosen.
    numChoseSafeL    = 0;                    % Times left safe option was chosen.
    numChoseSafeR    = 0;                    % Times right safe option was chosen.
    numChoseSky      = 0;                    % Times sky slot machine was chosen.
    numChoseSun      = 0;                    % Times sky slot machine was chosen.
    numCorrTimes     = 0;                    % Times correct option chosen.
    percentCApple    = 0;                    % Percent apple option chosen.
    percentCCorrect  = 0;                    % Percent correct choice chosen.
    percentCFruit    = 0;                    % Percent fruit slot machine chosen.
    percentCMoon     = 0;                    % Percent moon option chosen.
    percentCOrange   = 0;                    % Percent orange option chosen.
    percentCSafeL    = 0;                    % Percent left safe option chosen.
    percentCSafeR    = 0;                    % Percent right safe option chosen.
    percentCSky      = 0;                    % Percent sky slot machine chosen.
    percentCSun      = 0;                    % Percent sun option chosen.
    wilkeTaskData    = '/Data/WilkeTask';    % Directory where .mat files are saved.
    saveCommand      = NaN;                  % Command string that will save .mat files.
    varName          = 'data';               % Name of the variable to save in the workspace.
    
    % Stimuli.
    pointRadius      = 10;                   % Radius of the fixation dot.
    
    % Times.
    chooseHoldTime   = 0.5;                  % How long subject must look at choice to select it.
    feedbackTime     = 0.5;                  % Time option selected feedback border is given.
    flashInterval    = 0.3;                  % Time between fame redraws when options are spinning.
    ITI              = 1;                    % Intertrial interval.
    initHoldFixTime  = 0.3;                  % Time fixation must be held before choosing an option.
    minFixTime       = 0.1;                  % Minimum time monkey must fixate to start trial.
    spinTime         = 2;                    % How long the slot machine options spin.
    timeToFix        = intmax;               % Amount of time monkey is given to fixate.
    
    % Trial.
    currTrial        = 0;                    % Current trial.
    currCorrChoice   = '';                   % Correct choice that computer chooses.
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
    prepare_for_saving;
    
    % Window.
    window = setup_window;
    
    % Eyelink.
    setup_eyelink;
    
    % ---------------------------------------------- %
    % ------------ Main experiment loop ------------ %
    % ---------------------------------------------- %
    
    running = true;
    while running
        run_single_trial;
        
        print_stats;
        
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
        % Uncomment the following 1 line for mouse control.
        % [xCoord, yCoord, ~, ~, ~, ~] = GetMouse(window);
        
        % Comment out the following 3 lines for mouse control.
        sampledPosition = Eyelink('NewestFloatSample');
        xCoord = sampledPosition.gx(trackedEye);
        yCoord = sampledPosition.gy(trackedEye);
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
    
    % Makes a folder and file where data will be saved.
    function prepare_for_saving()
        cd(wilkeTaskData);
        
        % Check if cell ID was passed in with monkey's initial.
        if numel(monkeysInitial) == 1
            initial = monkeysInitial;
            cell = '';
        else
            initial = monkeysInitial(1);
            cell = monkeysInitial(2);
        end
        
        dateStr = datestr(now, 'yymmdd');
        filename = [initial dateStr '.' cell '1.WT.mat'];
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
                filename = [initial dateStr '.' cell num2str(fileNum) '.WT.mat'];
            else
                fileNum = 0;
            end
        end
        
        saveCommand = ['save ' filename ' ' varName];
    end
    
    % Prints current trial stats.
    function print_stats()
        % Convert percentages to strings.
        percentCAppleStr = strcat(num2str(percentCApple), '%');
        percentCCorrectStr = strcat(num2str(percentCCorrect), '%');
        percentCFruitStr = strcat(num2str(percentCFruit), '%');
        percentCMoonStr = strcat(num2str(percentCMoon), '%');
        percentCOrangeStr = strcat(num2str(percentCOrange), '%');
        percentCSafeLStr = strcat(num2str(percentCSafeL), '%');
        percentCSafeRStr = strcat(num2str(percentCSafeR), '%');
        percentCSkyStr = strcat(num2str(percentCSky), '%');
        percentCSunStr = strcat(num2str(percentCSun), '%');
        trialCountStr = num2str(currTrial);
        correlationStr = num2str(correlation);
        
        home;
        disp('             ');
        disp('****************************************');
        disp('             ');
        fprintf('Trial: % s', trialCountStr);
        disp('             ');
        fprintf('Task: % s', taskType);
        disp('             ');
        fprintf('Correlation: % s', correlationStr);
        disp('             ');
        fprintf('Correct: % s', percentCCorrectStr);
        disp('             ');
        disp('             ');
        disp('----------------------------------------');
        disp('             ');
        
        if strcmp(taskType, 'double')
            fprintf('Sky: % s', percentCSkyStr);
            disp('             ');
            fprintf('Sun: % s', percentCSunStr);
            disp('             ');
            fprintf('Moon: % s', percentCMoonStr);
            disp('             ');
            fprintf('Fruit: % s', percentCFruitStr);
            disp('             ');
            fprintf('Orange: % s', percentCOrangeStr);
            disp('             ');
            fprintf('Apple: % s', percentCAppleStr);
            disp('             ');
        elseif strcmp(taskType, 'singleSky')
            fprintf('Sun: % s', percentCSunStr);
            disp('             ');
            fprintf('Moon: % s', percentCMoonStr);
            disp('             ');
        elseif strcmp(taskType, 'singleFruit')
            fprintf('Orange: % s', percentCOrangeStr);
            disp('             ');
            fprintf('Apple: % s', percentCAppleStr);
            disp('             ');
        elseif strcmp(taskType, 'safeLeft')
            fprintf('Safe: % s', percentCSafeLStr);
            disp('             ');
            fprintf('Fruit: % s', percentCFruitStr);
            disp('             ');
            fprintf('Orange: % s', percentCOrangeStr);
            disp('             ');
            fprintf('Apple: % s', percentCAppleStr);
            disp('             ');
        elseif strcmp(taskType, 'safeRight')
            fprintf('Safe: % s', percentCSafeRStr);
            disp('             ');
            fprintf('Sun: % s', percentCSunStr);
            disp('             ');
            fprintf('Moon: % s', percentCMoonStr);
            disp('             ');
        end
        
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
    function reward(rewardDuration)
        % Reset "rewardDuration" if this is this trial has a safe option.
        if strcmp(taskType, 'safeLeft') || strcmp(taskType, 'safeRight')
            matrixSize = size(rewardDuration);
            arrayLen = matrixSize(2);
            randIndex = rand_int(arrayLen);
            rewardDuration = rewardDuration(randIndex);
        end
        
        % Get a reference the juicer device and set reward duration.
        daq = DaqDeviceIndex;
        
        % Open juicer.
        DaqAOut(daq, 0, .6);

        % Keep looping to keep juicer open until reward end.
        startTime = GetSecs;
        while (GetSecs - startTime) < rewardDuration
        end

        % Close juicer.
        DaqAOut(daq, 0, 0);
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
                                reward(rewardDuration);
                                numCorrTimes = numCorrTimes + 1;
                                choiceCorrect = 'yes';
                            else
                                choiceCorrect = 'no';
                            end
                            
                            % Updates.
                            numChoseSky = numChoseSky + 1;
                            choiceMachine = 'sky';
                            choiceMade = area;
                            currCorrChoice = currCorrOpSky;
                            
                            if strcmp(area, 'sun')
                                numChoseSun = numChoseSun + 1;
                            else
                                numChoseMoon = numChoseMoon + 1;
                            end
                        elseif strcmp(area, 'orange') || strcmp(area, 'apple')
                            if strcmp(area, currCorrOpFruit)
                                reward(rewardDuration);
                                numCorrTimes = numCorrTimes + 1;
                                choiceCorrect = 'yes';
                            else
                                choiceCorrect = 'no';
                            end
                            
                            % Updates.
                            numChoseFruit = numChoseFruit + 1;
                            choiceMachine = 'fruit';
                            choiceMade = area;
                            currCorrChoice = currCorrOpFruit;
                            
                            if strcmp(area, 'orange')
                                numChoseOrange = numChoseOrange + 1;
                            else
                                numChoseApple = numChoseApple + 1;
                            end
                        elseif strcmp(area, 'safeLeft') || strcmp(area, 'safeRight')
                            reward(safeRewards);
                            
                            % Updates.
                            choiceMachine = 'safe';
                            choiceMade = area;
                            choiceCorrect = 'no';
                            
                            if strcmp(area, 'safeLeft')
                                numChoseSafeL = numChoseSafeL + 1;
                                currCorrChoice = currCorrOpFruit;
                            else
                                numChoseSafeR = numChoseSafeR + 1;
                                currCorrChoice = currCorrOpSky;
                            end
                        end
                        
                        % Update percentages.
                        percentCSky = round(numChoseSky / currTrial * 100);
                        percentCFruit = round(numChoseFruit / currTrial * 100);
                        percentCCorrect = round(numCorrTimes / currTrial * 100);
                        percentCOrange = round(numChoseOrange / currTrial * 100);
                        percentCApple = round(numChoseApple / currTrial * 100);
                        percentCSun = round(numChoseSun / currTrial * 100);
                        percentCMoon = round(numChoseMoon / currTrial * 100);
                        percentCSafeL = round(numChoseSafeL / currTrial * 100);
                        percentCSafeR = round(numChoseSafeR / currTrial * 100);
                        
                        save_trial_data;
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
        % Save variables to a .mat file.
        data(currTrial).trial = currTrial;       %#ok<SETNU>   % Current trial.
        data(currTrial).taskType = taskType;                   % Which of the 5 task types this task is.
        data(currTrial).machineChosen = choiceMachine;         % Which slot machine was chosen (can be the safe option).
        data(currTrial).optionChosen = choiceMade;             % Which option was chosen.
        data(currTrial).currCorrChoice = currCorrChoice;       % Which choice is currently correct for the machine chosen.
        data(currTrial).choiceCorrect = choiceCorrect;         % Whether or not the subject's choice is correct.
        data(currTrial).correlation = correlation;             % What is the correlation set for this experiment.
        data(currTrial).rewardDuration = rewardDuration;       % What is the usual reward duration (single value).
        data(currTrial).safeRewards = safeRewards;             % Array of reward durations that the safe reward is chosen from.
        data(currTrial).showUnchosen = showUnchosen;           % Whether or not the unselected machine shows its result.
        data(currTrial).chooseHoldTime = chooseHoldTime;       % How long subject must look at choice to select it.
        data(currTrial).feedbackTime = feedbackTime;           % Time option selected feedback border is given.
        data(currTrial).flashInterval = flashInterval;         % Time between fame redraws when options are spinning.
        data(currTrial).ITI = ITI;                             % Intertrial interval.
        data(currTrial).initHoldFixTime = initHoldFixTime;     % Time fixation must be held before choosing an option.
        data(currTrial).minFixTime = minFixTime;               % Minimum time monkey must fixate to start trial.
        data(currTrial).spinTime = spinTime;                   % How long the slot machine options spin.
        data(currTrial).timeToFix = timeToFix;                 % Amount of time monkey is given to fixate.
        data(currTrial).trackedEye = trackedEye;               % The tracked eye.
        
        if strcmp(taskType, 'double')
            data(currTrial).percentCSky = percentCSky;         % Percent the sky machine has been chosen so far.
            data(currTrial).percentCSun = percentCSun;         % Percent the sun option has been chosen so far.
            data(currTrial).percentCMoon = percentCMoon;       % Percent the moon option has been chosen so far.
            data(currTrial).percentCFruit = percentCFruit;     % Percent the fruit machine has been chosen so far.
            data(currTrial).percentCOrange = percentCOrange;   % Percent the orange option has been chosen so far.
            data(currTrial).percentCApple = percentCApple;     % Percent the apple option has been chosen so far.
            data(currTrial).percentCCorrect = percentCCorrect; % Percent the subject has chosen correctly so far.
        elseif strcmp(taskType, 'singleSky')
            data(currTrial).percentCSky = percentCSky;
            data(currTrial).percentCSun = percentCSun;
            data(currTrial).percentCMoon = percentCMoon;
            data(currTrial).percentCCorrect = percentCCorrect;
        elseif strcmp(taskType, 'singleFruit')
            data(currTrial).percentCFruit = percentCFruit;
            data(currTrial).percentCOrange = percentCOrange;
            data(currTrial).percentCApple = percentCApple;
            data(currTrial).percentCCorrect = percentCCorrect;
        elseif strcmp(taskType, 'safeLeft')
            data(currTrial).percentCSafeL = percentCSafeL;     % Percent the left safe option has been chosen so far.
            data(currTrial).percentCFruit = percentCFruit;
            data(currTrial).percentCOrange = percentCOrange;
            data(currTrial).percentCApple = percentCApple;
            data(currTrial).percentCCorrect = percentCCorrect;
        elseif strcmp(taskType, 'safeRight')
            data(currTrial).percentCSafeR = percentCSafeR;     % Percent the right safe option has been chosen so far.
            data(currTrial).percentCSky = percentCSky;
            data(currTrial).percentCSun = percentCSun;
            data(currTrial).percentCMoon = percentCMoon;
            data(currTrial).percentCCorrect = percentCCorrect;
        end
        
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