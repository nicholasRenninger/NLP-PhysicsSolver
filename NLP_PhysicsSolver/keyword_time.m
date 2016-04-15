function [flight_t, t_final, t_hmax] = keyword_time(sentence)

    %token_sub = textscan(sub_string,'%s', 'Delimiter', ' '); % tokenize each substring with space delimiter
    
    keywords_tFlight = {'takes',  'in the air for', 'seconds to reach the ground', 'to hit the ground', 'hang time', 'to the ground'};
    keywords_tFinal = {'after it flies for', 'after it has traveled for', 'it has flown for', 'it has been in the air for'};
    keywords_tMaxH = {'to reach its max height', 'to reach its maximum height', 'reaches its max height after', 'reaches its maximum height after'};
    
    
    n1 = length(keywords_tFlight);
    n2 = length(keywords_tFinal);
    n3 = length(keywords_tMaxH);
    
    flight_t = 0;
    t_final = 0;
    t_hmax = 0;
    
    for i = 1: n1 % loops through keyword cell and gives variable 1 if sentence is contains variable or 0 if it does not
        
        if ~isempty(strfind(char(sentence), keywords_tFlight{i}))  % loops through and finds if keyword phrase is in the sentence
            
            flight_t = 1; %tells reader that there should be value 
        
        end
        
    end
    
    for i = 1: n2
        
        if ~isempty(strfind(char(sentence), keywords_tFinal{i}))
            t_final = 1;
       
        end
    end
    
    for i = 1: n3
        
        if ~isempty(strfind(char(sentence), keywords_tMaxH{i}))
            t_hmax = 1;

        end
    end
   
end
