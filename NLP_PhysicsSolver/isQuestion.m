function [param_display_indicies] = isQuestion(long_sentence)

    
    keyword_questions = {'what', 'find', 'calculate', 'how', 'predict'};
    keyword_time = {'long', 'time'};
    keyword_range = {'go', 'distance', 'travel', 'far', 'goes'};
    
    keyword_initial = {'initial', 'started at', 'begin'};
    keyword_final = {'ends with', 'final'};
    keyword_height = {'height', 'high'};
    
    
    n1 = length(keyword_questions);
    n2 = length(keyword_time);
    n3 = length(keyword_range);
    n4 = length(keyword_height);
    n5 = length(keyword_initial);
    n6 = length(keyword_final);
    
    param_display_indicies = zeros(1,18); % pre-allocate 
    
    
    % set all to zero by default, only changed if the sentence is a
    % question
    flight_t = 0;
    t_final = 0;
    t_hmax = 0;
    x_init = 0;
    x_final = 0;
    y_init = 0;
    y_final = 0;
    h_max = 0;
    range = 0;
    x_fin_tmax = 0;
    v_y_init = 0;
    v_y_final = 0;
    v_x = 0;
    speed = 0;
    speed_init = 0;
    v_y_fin_tflight = 0;
    theta = 0;
    theta_max = 0;
    
    for i = 1: n1
        
        if ~isempty(strfind(char(long_sentence), keyword_questions{i})) % if sentence is a question, find what it is asking by using the keyword finders for all of our variables
            
            [v_y_init, v_y_final, v_x, speed, speed_init, v_y_fin_tflight] = keyword_velocity(long_sentence);
            [theta, theta_max] =  keyword_angle(long_sentence);
            
            for j = 1: n5 
                if ~isempty(strfind(char(long_sentence), keyword_initial{j}))
                    for k = 1: n4
                        if ~isempty(strfind(char(long_sentence), keyword_height{k}))
                         y_init = 1;
                        end
                    end
                end
            end
            
            for j = 1: n6
               if ~isempty(strfind(char(long_sentence), keyword_final{j}))
                   for k = 1: n4
                       if ~isempty(strfind(char(long_sentence), keyword_height{k}))
                            y_final = 1;
                       end
                   end
               end
            end
                    
            for j = 1: n2
                if ~isempty(strfind(char(long_sentence), keyword_time{j}))
                    flight_t = 1;
                end
            end
            
            for j = 1: n3
                if ~isempty(strfind(char(long_sentence), keyword_range{j}))
                    range = 1;
                    x_final = 1;
                end
            end
            
            if ~isempty(strfind(char(long_sentence), 'range-maximizing theta'))
                    theta_max = 1;
            end
            
            if ~isempty(strfind(char(long_sentence), 'maximum height'))
                    h_max = 1;
            end
            
        end
    end
    
    
    
    a = 1; % get starting index of 1 and then increment it as more things to solve for are found 
    if flight_t
        param_display_indicies(a) = 10;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
       
    if t_final
        param_display_indicies(a) = 9;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if t_hmax
        param_display_indicies(a) = 8;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if x_init
        param_display_indicies(a) = 1;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if x_final
        param_display_indicies(a) = 2;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if y_init
        param_display_indicies(a) = 13;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
        
    if y_final
        param_display_indicies(a) = 14;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if h_max
        param_display_indicies(a) = 12;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if range
        param_display_indicies(a) = 15;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if x_fin_tmax
        param_display_indicies(a) = 11;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if v_y_init
        param_display_indicies(a) = 3;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
        
    if v_y_final
        param_display_indicies(a) = 4;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if v_x
        param_display_indicies(a) = 5;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if speed
        param_display_indicies(a) = 7;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if speed_init
        param_display_indicies(a) = 6;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if v_y_fin_tflight
        param_display_indicies(a) = 18;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if theta
        param_display_indicies(a) = 16;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    if theta_max
        param_display_indicies(a) = 17;
        a = a + 1; % inncrement to next indicie of param_disp for every question we find
    end
    
    
    
    
end