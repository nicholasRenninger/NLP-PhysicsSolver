clear all
close all


choice = menu('Physics', 'Input Parameters', 'Text Solver', 'Exit Program');
while choice ~= 3
    switch choice
        
        case 0
            break;
            
        case 1
            %manual solver 
            main_script_manual();
            n_parameters = new_parameters;
            
            fid = fopen('Solved_Output.txt', 'wt');
            for i = 1: 18
                
                if ~strcmp(char(class(n_parameters{i})), 'char')
                    fprintf(fid, 'The value of %s is %f ', parameter_names_save{i}, n_parameters{i});
                    fprintf(fid, '\n');
                else
                    fprintf(fid, 'The value of %s is not known. ', parameter_names_save{i});
                    fprintf(fid, '\n');
                end
                    
            end
            fclose(fid);
            break;
            
        case 2
            %text solver
            clear all
            parameter_names_save = {'initial x-position', 'final x-position', 'intial y-velocity',...
            'final y-velocity', 'x-velocity (it is both final and initial)', 'initial speed', ...
            'final speed','time to maximum height', 'final time', 'flight time', 'x-position at maximum height',...
            'maximum height', 'initial y-position', 'final y-position', 'range', 'theta',...
            'value of theta for max. range', 'y-velocity when the projectile hits the ground'};
        
            numbers = string_partB;
            [parameters, display_indicies] = reader(numbers);
            solver();
            answer_choice = menu('Which Answer do You Want', 'Automatically Selected Answers', 'Output All variables', 'Plot Trajectory');
            
        switch answer_choice
            case 0
            break;
            case 1
                
                fid = fopen('Solved_Output.txt', 'wt');
                
                first_zero = find(display_indicies == 0, 1, 'first'); % finds first zero element of display_indicies
                
                for i = 1: (first_zero - 1)
                
                      if ~strcmp(char(class(new_parameters{display_indicies(i)})), 'char')
                         fprintf(fid, 'The value of %s is %f ', parameter_names_save{display_indicies(i)}, new_parameters{display_indicies(i)});
                         fprintf(fid, '\n');
                      else
                         fprintf(fid, 'The value of %s is not known. ', parameter_names_save{display_indicies(i)});
                         fprintf(fid, '\n');
                      end
                         
                end
                fclose(fid);
                    
            case 2
        
                %display answer here or we can make another menu in this
                %menu with the option of choosing what they want. idk 
                n_parameters = new_parameters;
            
                fid = fopen('Solved_Output.txt', 'wt');
                for i = 1: 18
                
                    if ~strcmp(char(class(n_parameters{i})), 'char')
                         fprintf(fid, 'The value of %s is %f ', parameter_names_save{i}, n_parameters{i});
                         fprintf(fid, '\n');
                    else
                         fprintf(fid, 'The value of %s is not known. ', parameter_names_save{i});
                         fprintf(fid, '\n');
                    end
                    
                end
                fclose(fid);
                
        case 3
                g = 9.8;
              
               
                plotT = linspace(0,(new_parameters{10}), 1000);
                %10 = flight time
                plotX = new_parameters{5}*plotT;
                %5 = horizontal velocity
                plotY = new_parameters{13} + new_parameters{3} * plotT - (g * plotT .^ 2) / 2;
                %3 = vertical velocity initial
                %13 = y initial
                plot(plotX, plotY)
                xlabel('Distance(m)')
                ylabel('Height(m)')
                title('Trajectory')
        end
    end


choice = menu('Physics', 'Input Parameters', 'Text Solver', 'Exit Program');
end