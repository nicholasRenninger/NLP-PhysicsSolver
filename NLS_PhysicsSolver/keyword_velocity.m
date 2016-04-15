function [v_y_init, v_y_final, v_x, speed, speed_init, v_y_fin_tflight] = keyword_velocity(sentence)

    
    %token_sub = textscan(sub_string,'%s', 'Delimiter', ' '); % tokenize each substring with space delimiter
    
    keywords_initial = {'initial', 'starts', 'begins with', 'preliminary', 'start'};
    keywords_final = {'has attained', 'final', 'just before it hits the ground', 'ends with'};
    
    keywords_vyfinal = {'final y-velocity after', 'final y-speed after', 'y-velocity after', 'y-speed after'};
    keywords_vy = {'y-velocity', 'vertical velocity', 'vertical speed', 'speed in the y', 'velocity in the y', 'upwards velocity', 'upwards speed', 'y-speed', 'upwards component'};
    keywords_vx = {'x-velocity', 'horizontal velocity', 'horizontal speed', 'speed in the x', 'sideways velocity', 'sideways speed', 'velocity in the x', 'x-speed', 'sideways component'};
    keywords_speed = {'speed', 'moving at'};
    
    
    n1 = length(keywords_initial);
    n2 = length(keywords_final);
    n3 = length(keywords_vy);
    n4 = length(keywords_vx);
    n5 = length(keywords_speed);
    n6 = length(keywords_vyfinal);
    
     v_y_init = 0;
     speed_init = 0;
     v_y_fin_tflight = 0;
     speed = 0;
     v_y_final = 0;
     v_x = 0;
    
   for i = 1: n1
       if ~isempty(strfind(char(sentence), keywords_initial{i}))
           
            for j = 1: n3
                if ~isempty(strfind(char(sentence), keywords_vy{j}))
                    v_y_init = 1;
                
                end
            end
            
            for j = 1: n5
                if ~isempty(strfind(char(sentence), keywords_speed{j}))
                    speed_init = 1;
  
                end
            end
           
       end
       
   end
   
   
   for i = 1: n2
       if ~isempty(strfind(char(sentence), keywords_final{i}))
           
           for j = 1: n3
               if ~isempty(strfind(char(sentence), keywords_vy{j}))
                   v_y_fin_tflight = 1;
               
               end
           end
           
           for j = 1: n5
               if ~isempty(strfind(char(sentence), keywords_speed{j}))
                   speed = 1;
               
               end
           end
           
       end
   end
   
   
   for i = 1: n4
       if ~isempty(strfind(char(sentence), keywords_vx{i}))
           v_x = 1;
       end
       
   end
   
   for i = 1: n6
       if ~isempty(strfind(char(sentence), keywords_vyfinal{i}))
           v_y_final = 1;
       end
       
   end
   
   if ~isempty(strfind(char(sentence), 'velocity')) && v_y_final ~= 1 && v_y_init ~= 1 && v_x ~= 1 && v_y_fin_tflight ~= 1 % only checks if velocity is related to speed if velocity hasnt been used for any other variable
       for i = 1: n1
           if ~isempty(strfind(char(sentence), keywords_initial{i}))
              speed_init = 1;
           end
       end
 
       for i = 1: n2
           if ~isempty(strfind(char(sentence), keywords_final{i}))
              speed = 1;
           end 
       end
       
   end
           
                           
end
