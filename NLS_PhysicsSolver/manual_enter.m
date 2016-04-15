%V 1.3 added x_pos @ t_max_ht and made sure user cant have final x be less
%than initial x, added v_y_tmax condition
function [parameters] = manual_enter(parameters)
    

    param_save = parameters; % keep copy of parameters incase user enter invalid parameter

    [~, length] = size(parameters); 

    p = cell(1,length); % pre-allocate storage of inputs

    i = 1;
    while i <= length



        fprintf('Please enter the numeric value for the %s, or * if it is not given: ', parameters{i});
        p{i} = input('','s'); % puts user inputs in cell array

        parameters{i} = struct('val', p{i}); % creates structure 'val' (user inputed value for parameter) of cell array parameters


        if isstrprop(parameters{i}.val, 'digit') == 0 % gives parameter value of -1 if no numeric val was assigned to it.

            parameters{i} = 'not';

        elseif isempty(parameters{i}.val) == 1 % check if user entered nothing and ask them to re-enter data

            fprintf('Error - a value must be entered \n');
            parameters{i} = param_save{i};
            i = i - 1;
        else

            parameters{i} = str2double(parameters{i}.val); % otherwise gives cell value of the val struct

        end


        %%% check if user inputed value in permited domain of parameter %%%
            if i == 1 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0  

                fprintf('Value for initial x-position cannot be negative \n');
                parameters{i} = 'initial x-position';
                i = i - 1;

            end

            if i == 2 && strcmp(char(parameters{i}), 'not') ~= 1
               
                if parameters{i} < 0
                    
                   fprintf('Value for final x-position cannot be negative \n');
                   parameters{i} = 'final x-position';
                   i = i - 1;
                    
                elseif strcmp(char(parameters{i-1}), 'not') ~= 1 && parameters{i} < parameters{i-1}
                   
                   fprintf('Value for final x-position cannot be less than value of initial x-position \n');
                   parameters{i} = 'final x-position';
                   i = i - 1;
                end
                
            end
            
            if i == 5 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0  

                fprintf('Value for x-velocity cannot be negative \n');
                parameters{i} = 'x-velocity';
                i = i - 1;

            end

            if i == 6 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0  

                fprintf('Value for speed cannot be negative \n');
                parameters{i} = 'initial speed';
                i = i - 1;

            end

            if i == 7 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0 

                fprintf('Value for speed cannot be negative \n');
                parameters{i} = 'final speed';
                i = i - 1;

            end

            if i == 8 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0  

                fprintf('Value for time cannot be negative \n');
                parameters{i} = 'time of maximum height';
                i = i - 1;

            end

            if i == 9 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0

                fprintf('Value for time cannot be negative \n');
                parameters{i} = 'time(final)';
                i = i - 1;

            end

            if i == 10 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0  

                fprintf('Value for time cannot be negative \n');
                parameters{i} = 'flight time';
                i = i - 1;

            end
            
            if i == 11 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0

                fprintf('Value for x-position cannot be negative \n');
                parameters{i} = 'x-position at maximum height';
                i = i - 1;

            end
            
            if i == 12 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0

                fprintf('Value for height cannot be negative \n');
                parameters{i} = 'maximum height';
                i = i - 1;

            end

            if i == 13 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0

                fprintf('Value for initial y-position cannot be negative \n');
                parameters{i} = 'initial y-position';
                i = i - 1;

            end
            
            if i == 14 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0  

                fprintf('Value for the final y-position  cannot be negative \n');
                parameters{i} = 'final y-position';
                i = i - 1;

            end

            if i == 15 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0

                fprintf('Value for x-range cannot be negative \n');
                parameters{i} = 'range';
                i = i - 1;

            end

            if i == 16 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0 && parameters{9} == 0

                fprintf('Value for theta cannot be negative while intial height is zero \n');
                parameters{i} = 'theta';
                i = i - 1;

            end     

            if i == 17 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} < 0  

                fprintf('Value for range maximizing angle cannot be negative \n');
                parameters{i} = 'range maximizing angle';
                i = i - 1;

            end
            
            if i == 18 && strcmp(char(parameters{i}), 'not') ~= 1 && parameters{i} > 0  

                fprintf('Value for y-velocity cannot be positive here \n');
                parameters{i} = 'y-velocity when the ball hits the ground';
                i = i - 1;

            end
            
            if any(isnan(parameters{i})) == 1 % check if user inputed a value with combination of char and numbers

                fprintf('Invalid entry: re-enter numeric value or * \n');
                parameters{i} = param_save{i};
                i = i - 1;

            end

        i = i + 1;
    end

end