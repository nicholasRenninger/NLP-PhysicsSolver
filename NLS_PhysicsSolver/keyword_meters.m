function [x_init, x_final, y_init, y_final, h_max, range, x_fin_tmax] = keyword_meters(sentence)

    %token_sub = textscan(sub_string,'%s', 'Delimiter', ' '); % tokenize each substring with space delimiter
    
    keywords_initial = {'initial', 'starts', 'begins with', 'preliminary', 'start', 'is launched', 'from a', 'is placed', 'is thrown', 'is projected', 'is kicked'};
    keywords_final = {'ends with', 'final', 'stops after', 'flies for', 'goes for', 'travels'};
    
    keywords_x = {'from the launch position', 'x-position', 'horizontal position', 'horizontal distance', 'x-direction'};
    keywords_y = {'y-position', 'vertical position', 'height', 'vertical distance', 'y-direction', 'altitude', 'above the ground'};
    keywords_hmax = {'maximum height', 'maximum y-position', 'maximum', 'highest', 'maximum altitude'};
    keywords_range = {'range', 'hits the ground', 'flies a maximum distance', 'maximum distance', ''};
    keywords_xfintmax = {'at the maximum height', 'x-position at maximum height'};
    
    
    
    n1 = length(keywords_initial);
    n2 = length(keywords_final);
    n3 = length(keywords_x);
    n4 = length(keywords_y);
    n5 = length(keywords_hmax);
    n6 = length(keywords_range);
    n7 = length(keywords_xfintmax);
    
    x_init = 0;
    x_final = 0;
    y_init = 0;
    y_final = 0;
    h_max = 0;
    range = 0;
    x_fin_tmax = 0;
    
    for i = 1: n1
        
        if ~isempty(strfind(char(sentence), keywords_initial{i})) % check if initial or final, and do appropriate assignment check below if is intial

            for j = 1: n3 % loops through keyword cell and gives variable 1 if sentence is contains variable or 0 if it does not

                if ~isempty(strfind(char(sentence), keywords_x{j})) % loops through and finds if keyword phrase is in the sentence

                    x_init = 1; %tells reader that there should be value 
             
                end

            end

            for j = 1: n4

                if ~isempty(strfind(char(sentence), keywords_y{j}))
                    y_init = 1;
               
                end
            end
            
        end
    end
    
    
    for i = 1: n2 % check if is initial or final
        
        if ~isempty(strfind(char(sentence), keywords_final{i})) % if final, do following checks and assignments

            for j = 1: n3

                if ~isempty(strfind(char(sentence), keywords_x{j}))
                    x_final = 1;
                
                end
            end

            for j = 1: n4

                if ~isempty(strfind(char(sentence), keywords_y{j}))
                    y_final = 1;
              
                end
            end
            
        end
    end
    
    
    for i = 1: n5
        
        if ~isempty(strfind(char(sentence), keywords_hmax{i}))
            h_max = 1;
 
        end
    end
    
    
    for i = 1: n6
        
        if ~isempty(strfind(char(sentence), keywords_range{i}))
            range = 1;
     
        end
    end
    
    
    for i = 1: n7
        
        if ~isempty(strfind(char(sentence), keywords_xfintmax{i}))
            x_fin_tmax = 1;
     
        end
    end
    
end
