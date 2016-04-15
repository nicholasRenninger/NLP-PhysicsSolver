function [nums] =  string_partB()
    
    text_string = lower(fileread('problem.txt'));
    text_string = regexprep(text_string,'-\D',' $&');
    text_string = regexprep(text_string,'°',' $&');
    text = textscan(text_string,'%s', 'Delimiter', ' ');
    sub_strings = text;
    n = length(sub_strings{1});
    nums = cell(1, round(n/4)); %pre-allocate numbers array based on size of inputed string
    numbers = nums;
    
    a = 1;
    
    for i = 1:n
        
        sub_strings{i} = text{1}(i);
        sub_strings{i} = regexprep(sub_strings{i}, '\.(?!\d)', ''); %gets rid of trailing period so can be used for str2num
    end
    
    for i = 1: n
        if ~isempty(str2num(char(sub_strings{i}))) % runs if current token contains a number
            if strcmp(char(class(str2num(char(sub_strings{i})))), 'double')
               
                nums{a} = str2double(char(sub_strings{i})); % creates numbers array
            end
            a = a + 1; % only increment when new number is put into numbers
        end
        

    end
        
end
    
 