function [parameters, display_indicies] = reader(numbers)

t_string = lower(fileread('problem.txt'));
text_string = strrep(t_string, '-', ' '); % get rid of - in sentences here

%string='A pool ball leaves a 0.60-meter high table with an initial horizontal velocity of 2.4 m/s. Predict the time required for the pool ball to fall to the ground and the horizontal distance between the tables edge and the balls landing location.';
sentences = strsplit(text_string,{', ', '. ', '? ', '! ', ' with ', ' and ', ' at '});
sentences_question = strsplit(text_string,{'. ','? ', '! '});

parameters = cell(1,18);


% intialize all to not, only change when one of keyword finders finds
% something
parameters{1} = 'not'; % assume that starting x position is zero unless otherwise found
parameters{2} = 'not';
parameters{3} = 'not';
parameters{4} = 'not';
parameters{5} = 'not';
parameters{6} = 'not';
parameters{7} = 'not';
parameters{8} = 'not';
parameters{9} = 'not';
parameters{10} = 'not';
parameters{11} = 'not';
parameters{12} = 'not';
parameters{13} = 'not'; % assume initial height is zero unless otherwise stated.
parameters{14} = 'not'; % assume final height is zero unless otherwise stated.
parameters{15} = 'not';
parameters{16} = 'not';
parameters{17} = 'not';
parameters{18} = 'not';


for i = 1: length(sentences_question) % finds the indicies in paramters to display from the question
    
    [display_indicies] = isQuestion(sentences_question{i});
end


a = 1;
for i = 1: length(sentences) % finds intial conditions
    
    dummy = 0;
    
    if sum(size(regexpi(sentences{i},'m(eters)?(/|p|\sper\s)s(ec|econd)?','match'))) >= 1 %if sentence has m/s in it, then pass it to keyord_angle to find which variables sentence contains
        
        dummy = 1;
        %test{1}=1;
        %function figures out which variable is in substring{i}, spits out
        %correct location for value for example if vx is number 14 and
        % function finds initial horizontal velocity, function spits out 14
        %value in parameters is a string atm, use char to get value
        [v_y_init, v_y_fin, v_x, speed_fin, speed_init, v_y_fin_tflight] = keyword_velocity(sentences{i});
        
        if v_y_init
            parameters{3} = numbers{a};
      
        end
        
        if v_y_fin
            parameters{4} = numbers{a};
       
        end
        
        if v_x
            parameters{5} = numbers{a};
        
        end
        
        if speed_fin
            parameters{7} = numbers{a};
      
        end
        
        if speed_init
            parameters{6} = numbers{a};
        
        end
        
        if v_y_fin_tflight
            parameters{18} = numbers{a};
      
        end
        a = a + 1;
    end
    
    if sum(size(regexpi(sentences{i},'meters','match')) >= 1) && (dummy ~= 1) %if sentence has meters in it, then pass it to keyord_angle to find which variables sentence contains
       
        [x_init, x_final, y_init, y_final, h_max, range, x_fin_tmax] = keyword_meters(sentences{i});
        
        if x_init
            parameters{1} = numbers{a};
        
        end
        
        if x_final
            parameters{2} = numbers{a};
       
        end
        
        if y_init
            parameters{13} = numbers{a};
        
        end
        
        if y_final
            parameters{14} = numbers{a};
       
        end
        
        if h_max
            parameters{12} = numbers{a};
        
        end
        
        if range
            parameters{15} = numbers{a};
       
        end
        
        if x_fin_tmax
            parameters{11} = numbers{a};
       
        end
        a = a + 1; 
    end
    
    if sum(size(regexpi(sentences{i},'s(ec|econds)','match'))) >= 1 && (dummy ~=1) %if sentence has seconds in it, then pass it to keyord_angle to find which variables sentence contains
       
        [Ft, tF, tMH] = keyword_time(sentences{i});
       
        if Ft
            parameters{10} = numbers{a};
      
        end
            
        if tF
           parameters{9} = numbers{a};
      
        end
           
        if tMH
            parameters{8} = numbers{a};
        
        end
        
        a = a + 1;
    end
    
    if sum(size(regexpi(sentences{i},'(°|degre(e|es))','match'))) >= 1 %if sentence has degrees in it, then pass it to keyord_angle to find which variables sentence contains
        
        [theta, theta_max] = keyword_angle(sentences{i});
        
        if theta
            parameters{16} = numbers{a};
        
        end
            
        if theta_max
            parameters{17} = numbers{a};
       
        end
        
        a = a + 1;
    end
    
end
