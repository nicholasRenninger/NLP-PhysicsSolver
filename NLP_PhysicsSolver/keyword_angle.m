function [theta, theta_max] =  keyword_angle(sentence)

    
    %token_sub = textscan(sub_string,'%s', 'Delimiter', ' '); % tokenize each substring with space delimiter
    
    keywords_theta = {'at an angle of', 'angle of', 'launch angle', 'angle with', 'angle', 'theta', 'above the horizontal'};
    keywords_thetamax = {'range maximizing angle', 'angle that maximizes', 'maximizing angle'};
    
    
    n1 = length(keywords_theta);
    n2 = length(keywords_thetamax);
    
    %initialize as 0 until changed by loop
    theta = 0;
    theta_max = 0;
    
    for i = 1: n1 % loops through keyword cell and gives variable 1 if sentence is contains variable or 0 if it does not
        
        if ~isempty(strfind(char(sentence), keywords_theta{i})) && theta ~= 1% loops through and finds if keyword phrase is in the sentence and stops once it finds a value     
            theta = 1; %tells reader that there should be value 
        end
        
    end
    
    for i = 1: n2
        
        if ~isempty(strfind(char(sentence), keywords_thetamax{i})) && theta_max ~= 1
            theta_max = 1;
        end
    end

end
