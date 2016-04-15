% takes inputed vars and outputs same variables solved as much as is
% possible

% V 2.1 (added variable intializer and new_parameters updating at end of while loop and inputed all solving "definitions", did testing, fixed handling of squared results)
%function [new_parameters] = solver(parameters)

    
    %{
    keep this, might need for later
    x_pos_init_var = parameters{1};
    x_pos_final_var = parameters{2};
    v_y_init_var = parameters{3};
    v_y_final_var = parameters{4};
    v_x_var = parameters{5};
    speed_init_var = parameters{6};
    speed_final_var = parameters{7};
    t_max_ht_var = parameters{8};
    t_final_var = parameters{9};
    flight_time_var = parameters{10};
    H_max_var = parameters{11};
    y_init_var = parameters{12};
    y_final_var = parameters{13};
    rangeX_var = parameters{14};
    theta_var = parameters{15};
    theta_max_var = parameters{16};
    %}
    
    syms x_pos_init_var  x_pos_final_var  v_y_init_var  v_y_final_var  v_x_var  speed_init_var  speed_final_var  t_max_ht_var...
         t_final_var  flight_time_var  x_pos_maxH_var  H_max_var  y_init_var  y_final_var  range_var  theta_var  theta_max_var  v_y_tmax_var; % change class of inputed vars to symbolic for double/string
     
    var_names_cell = {'x_pos_init_var', 'x_pos_final_var', 'v_y_init_var', 'v_y_final_var', 'v_x_var', 'speed_init_var', 'speed_final_var', 't_max_ht_var'...
    't_final_var', 'flight_time_var','x_pos_maxH_var', 'H_max_var', 'y_init_var', 'y_final_var', 'range_var', 'theta_var', 'theta_max_var', 'v_y_tmax_var'}; % used to dynamically initialize all variables in parameters

    g = 9.8; % define g

    % changes any variable with numeric value to double and leave anything
    % that is 'not' as symbolic variable
    for i = 1: 18
        
        if strcmp(char(parameters{i}), 'not') ~= 1           
           
            eval(sprintf('%s = %d', var_names_cell{i}, parameters{i})); % initialize any numeric variables with correct name
        
        end
    end
    
   
    a = 1; % set solver var to one to start solving while loop
    b = 0; % keeps track of how many time loop runs
    
     
    while a ~= 0
        
        a = 0;
        
        
        %%% solving for v_y_final, v_y_init, t_final %%%
        if (strcmp(char(class(v_y_final_var)), 'sym')) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(t_final_var)), 'sym') ~= 1)
           
             v_y_final_var = double(solve( (v_y_final_var == v_y_init_var - (g * t_final_var)), v_y_final_var)); % solve for missing value
             a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(v_y_final_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym')) && (strcmp(char(class(t_final_var)), 'sym') ~= 1)
            
            v_y_init_var = double(solve( (v_y_final_var == v_y_init_var - (g * t_final_var)), v_y_init_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(v_y_final_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(t_final_var)), 'sym'))
            
            t_final_var = double(solve( (v_y_final_var == v_y_init_var - (g * t_final_var)), t_final_var)); % solve for missing value
            if length(t_final_var) > 1
                t_final_var = t_final_var(2); % only take positive time
            end
            a = a + 1; % continue solving loop
        end
        
        
        
        
        
        
        %%% solving for v_y_tmax, v_y_init, flight_time %%%
        if (strcmp(char(class(v_y_tmax_var)), 'sym')) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(flight_time_var)), 'sym') ~= 1)
           
             v_y_tmax_var = double(solve( (v_y_tmax_var == v_y_init_var - (g * flight_time_var)), v_y_tmax_var)); % solve for missing value
             a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(v_y_tmax_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym')) && (strcmp(char(class(flight_time_var)), 'sym') ~= 1)
            
            v_y_init_var = double(solve( (v_y_tmax_var == v_y_init_var - (g * flight_time_var)), v_y_init_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(v_y_tmax_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(flight_time_var)), 'sym'))
            
            flight_time_var = double(solve( (v_y_tmax_var == v_y_init_var - (g * flight_time_var)), flight_time_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        
        
        
        
        
        %%% solving for speed_init, v_x, v_y_init %%%
        if (strcmp(char(class(speed_init_var)), 'sym')) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1)
        
            speed_init_var = double(solve( speed_init_var == sqrt((v_x_var)^2 + (v_y_init_var)^2), speed_init_var)); % solve for missing value
            a = a + 1; %increment a to continue solving
        end
        
        if (strcmp(char(class(speed_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym')) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1)
        
            v_x_var = double(solve( speed_init_var == sqrt((v_x_var)^2 + (v_y_init_var)^2), v_x_var)); % solve for missing value
            if length(v_x_var) > 1
                v_x_var = v_x_var(2); % always take + val
            end
            a = a + 1; %increment a to continue solving
        end
        
        if (strcmp(char(class(speed_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym'))
        
            v_y_init_var = double(solve( speed_init_var == sqrt((v_x_var)^2 + (v_y_init_var)^2), v_y_init_var)); % solve for missing value
            if length(v_y_init_var) > 1 && (strcmp(char(class(theta_var)), 'sym') ~= 1) && theta_var < 0 
               v_y_init_var = v_y_init_var(1); % only take - val if theta is -
            elseif length(v_y_init_var) > 1
               v_y_init_var = v_y_init_var(2); % take + val if theta is positive
            end
            a = a + 1; %increment a to continue solving
        end
        
        
        
        
        
        %%% solving for speed_init, theta, v_x %%%
        if (strcmp(char(class(speed_init_var)), 'sym')) && (strcmp(char(class(theta_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1)
            if ~(theta_var == 0 && v_x_var == 0)
                speed_init_var = double(solve(( v_x_var == speed_init_var * cos(theta_var * (pi/180))), speed_init_var));
            end
            a = a + 1;
        end
        
        if (strcmp(char(class(speed_init_var)), 'sym') ~= 1) && (strcmp(char(class(theta_var)), 'sym')) && (strcmp(char(class(v_x_var)), 'sym') ~= 1)
            if ~(speed_init_var == 0 && v_x_var == 0)
                theta_var = double(solve(( v_x_var == speed_init_var * cos(theta_var * (pi/180))), theta_var));
            end
            a = a + 1;
        end
        
        if (strcmp(char(class(speed_init_var)), 'sym') ~= 1) && (strcmp(char(class(theta_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym'))
            if ~(theta_var == 0 && speed_init_var == 0)
                v_x_var = double(solve(( v_x_var == speed_init_var * cos(theta_var * (pi/180))), v_x_var));
            end
            a = a + 1;
        end
        
        
        
        
        
        %%% solving for speed_init, theta, v_y_init %%%
        if (strcmp(char(class(speed_init_var)), 'sym')) && (strcmp(char(class(theta_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) 
            if ~(theta_var == 0 && v_y_init_var == 0) 
                speed_init_var = double(solve(( v_y_init_var == speed_init_var * sin(theta_var * (pi/180))), speed_init_var));
            end
            a = a + 1;
        end
        
        if (strcmp(char(class(speed_init_var)), 'sym') ~= 1) && (strcmp(char(class(theta_var)), 'sym')) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1)
            if ~(speed_init_var == 0 && v_y_init_var == 0) 
                theta_var = double(solve(( v_y_init_var == speed_init_var * sin(theta_var * (pi/180))), theta_var));
            end
            a = a + 1;
        end
        
        if (strcmp(char(class(speed_init_var)), 'sym') ~= 1) && (strcmp(char(class(theta_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym'))
            if  ~(theta_var == 0 && speed_init_var == 0) 
                v_y_init_var = double(solve(( v_y_init_var == speed_init_var * sin(theta_var * (pi/180))), v_y_init_var));
            end
            a = a + 1;
        end
        
        
        
        
        
        %%% solving for x_pos_init, x_pos_final, v_x, t_final %%%
        if (strcmp(char(class(x_pos_final_var)), 'sym')) && (strcmp(char(class(x_pos_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(t_final_var)), 'sym') ~= 1)
            
            x_pos_final_var = double(solve( x_pos_final_var == (v_x_var * t_final_var) + x_pos_init_var, x_pos_final_var)); % solve for missing value
            a = a + 1; % increment a to continue solving while loop
        end
        
        if (strcmp(char(class(x_pos_final_var)), 'sym') ~= 1) && (strcmp(char(class(x_pos_init_var)), 'sym')) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(t_final_var)), 'sym') ~= 1)
        
            x_pos_init_var = double(solve( x_pos_final_var == (v_x_var * t_final_var) + x_pos_init_var, x_pos_init_var)); % solve for missing value
            a = a + 1;
        end
        
        if (strcmp(char(class(x_pos_final_var)), 'sym' ~= 1)) && (strcmp(char(class(x_pos_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym')) && (strcmp(char(class(t_final_var)), 'sym') ~= 1)
        
            v_x_var = double(solve( x_pos_final_var == (v_x_var * t_final_var) + x_pos_init_var, v_x_var)); % solve for missing value
            a = a + 1;
        end
        
        if (strcmp(char(class(x_pos_final_var)), 'sym') ~= 1) && (strcmp(char(class(x_pos_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(t_final_var)), 'sym'))
        
            t_final_var = double(solve( x_pos_final_var == (v_x_var * t_final_var) + x_pos_init_var, t_final_var)); % solve for missing value
            a = a + 1;
        end
        
        
        
        
        
        %%% solving for x_pos_init, range, v_x, flight_time %%%
        if (strcmp(char(class(range_var)), 'sym')) && (strcmp(char(class(x_pos_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(flight_time_var)), 'sym') ~= 1)
            
            range_var = double(solve( range_var == (v_x_var * flight_time_var) + x_pos_init_var, range_var)); % solve for missing value
            a = a + 1; % increment a to continue solving while loop
        end
        
        if (strcmp(char(class(range_var)), 'sym') ~= 1) && (strcmp(char(class(x_pos_init_var)), 'sym')) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(flight_time_var)), 'sym') ~= 1)
        
            x_pos_init_var = double(solve( range_var == (v_x_var * flight_time_var) + x_pos_init_var, x_pos_init_var)); % solve for missing value
            a = a + 1;
        end
        
        if (strcmp(char(class(range_var)), 'sym' ~= 1)) && (strcmp(char(class(x_pos_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym')) && (strcmp(char(class(flight_time_var)), 'sym') ~= 1)
        
            v_x_var = double(solve( range_var == (v_x_var * flight_time_var) + x_pos_init_var, v_x_var)); % solve for missing value
            a = a + 1;
        end
        
        if (strcmp(char(class(range_var)), 'sym') ~= 1) && (strcmp(char(class(x_pos_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(flight_time_var)), 'sym'))
        
            flight_time_var = double(solve( range_var == (v_x_var * flight_time_var) + x_pos_init_var, flight_time_var)); % solve for missing value
            a = a + 1;
        end
        
        
        
        
        
        
        %%% solving for x_pos_init, x_pos_maxH, v_x, t_max_ht %%%
        if (strcmp(char(class(x_pos_maxH_var)), 'sym')) && (strcmp(char(class(x_pos_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(t_max_ht_var)), 'sym') ~= 1)
            
            x_pos_maxH_var = double(solve( x_pos_maxH_var == (v_x_var * t_max_ht_var) + x_pos_init_var, x_pos_maxH_var)); % solve for missing value
            a = a + 1; % increment a to continue solving while loop
        end
        
        if (strcmp(char(class(x_pos_maxH_var)), 'sym') ~= 1) && (strcmp(char(class(x_pos_init_var)), 'sym')) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(t_max_ht_var)), 'sym') ~= 1)
        
            x_pos_init_var = double(solve( x_pos_maxH_var == (v_x_var * t_max_ht_var) + x_pos_init_var, x_pos_init_var)); % solve for missing value
            a = a + 1;
        end
        
        if (strcmp(char(class(x_pos_maxH_var)), 'sym' ~= 1)) && (strcmp(char(class(x_pos_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym')) && (strcmp(char(class(t_max_ht_var)), 'sym') ~= 1)
            if t_max_ht_var ~= 0 
                v_x_var = double(solve( x_pos_maxH_var == (v_x_var * t_max_ht_var) + x_pos_init_var, v_x_var)); % solve for missing value
            end
            a = a + 1;
        end
        
        if (strcmp(char(class(x_pos_maxH_var)), 'sym') ~= 1) && (strcmp(char(class(x_pos_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(t_max_ht_var)), 'sym'))
            if v_x_var ~= 0
                t_max_ht_var = double(solve( x_pos_maxH_var == (v_x_var * t_max_ht_var) + x_pos_init_var, t_max_ht_var)); % solve for missing value
            end
            a = a + 1;
        end
        
        
        
        
        
      
        %%% solving for v_y_final, v_y_init, y_init, y_final %%%
        if (strcmp(char(class(v_y_init_var)), 'sym')) && (strcmp(char(class(v_y_final_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_final_var)), 'sym') ~= 1)
            
            v_y_init_var = double(solve((v_y_final_var == sqrt((v_y_init_var)^2 - (2 * g *(y_final_var - y_init_var)))), v_y_init_var)); % solve for missing value
            if length(v_y_init_var) > 1 && (strcmp(char(class(theta_var)), 'sym') ~= 1) && theta_var < 0 
               v_y_init_var = v_y_init_var(1); % only take - val if theta is -
            elseif length(v_y_init_var) > 1
               v_y_init_var = v_y_init_var(2); % take + val if theta is positive
            end
            a = a + 1; %increment a to continue solving loop
        end
        
        if (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_final_var)), 'sym')) && (strcmp(char(class(y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_final_var)), 'sym') ~= 1)
            
            v_y_final_var = -double(solve((v_y_final_var == sqrt((v_y_init_var)^2 - (2 * g *(y_final_var - y_init_var)))), v_y_final_var)); % solve for missing value
            if (strcmp(char(class(theta_var)), 'sym') ~= 1) &&  (strcmp(char(class(x_pos_final_var)), 'sym') ~= 1) && (strcmp(char(class(range_var)), 'sym') ~= 1)
                if x_pos_final_var < (range_var/2)
                    v_y_final_var = -1 * v_y_final_var;
                end
            end
            a = a + 1; %increment a to continue solving loop
        end
        
        if (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_final_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym')) && (strcmp(char(class(y_final_var)), 'sym') ~= 1)
            
            y_init_var = double(solve((v_y_final_var == sqrt((v_y_init_var)^2 - (2 * g *(y_final_var - y_init_var)))), y_init_var)); % solve for missing value
            a = a + 1; %increment a to continue solving loop
        end
        
        if (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_final_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_final_var)), 'sym'))
            
            y_final_var = double(solve((v_y_final_var == sqrt((v_y_init_var)^2 - (2 * g *(y_final_var - y_init_var)))), y_final_var)); % solve for missing value
            a = a + 1; %increment a to continue solving loop
        end
        
        
        
        
        
        
        %%% solving for v_y_final, v_y_init, t_final, y_init, y_final %%%
        if (strcmp(char(class(v_y_final_var)), 'sym')) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(t_final_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_final_var)), 'sym') ~= 1)
            
            v_y_final_var = double(solve((y_final_var == (((-1/2) * g) * (t_final_var ^ 2)) + (v_y_init_var * t_final_var) + y_init_var), v_y_final_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(v_y_final_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym')) && (strcmp(char(class(t_final_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_final_var)), 'sym') ~= 1)
            
            v_y_init_var = double(solve((y_final_var == (((-1/2) * g) * (t_final_var ^ 2)) + (v_y_init_var * t_final_var) + y_init_var), v_y_init_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(v_y_final_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(t_final_var)), 'sym')) && (strcmp(char(class(y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_final_var)), 'sym') ~= 1)
            
            t_final_var = double(solve((y_final_var == (((-1/2) * g) * (t_final_var ^ 2)) + (v_y_init_var * t_final_var) + y_init_var), t_final_var)); % solve for missing value
            if length(t_final_var) > 1
                t_final_var = t_final_var(2);
            end
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(v_y_final_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(t_final_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym')) && (strcmp(char(class(y_final_var)), 'sym') ~= 1)
            
            y_init_var = double(solve((y_final_var == (((-1/2) * g) * (t_final_var ^ 2)) + (v_y_init_var * t_final_var) + y_init_var), y_init_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(v_y_final_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(t_final_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_final_var)), 'sym'))
            
            y_final_var = double(solve((y_final_var == (((-1/2) * g) * (t_final_var ^ 2)) + (v_y_init_var * t_final_var) + y_init_var), y_final_var)); % solve for missing value
            if length(y_final_var) > 1
                y_final_var = y_final_var(2); % only take positive value
            end
            a = a + 1; % continue solving loop
        end
        
        
        
        
        
        %%% solving for  speed_final, v_y_final, v_x %%%
        if (strcmp(char(class(speed_final_var)), 'sym')) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_final_var)), 'sym') ~= 1)
        
            speed_final_var = double(solve( speed_final_var == sqrt((v_x_var)^2 + (v_y_final_var)^2), speed_final_var)); % solve for missing value
            a = a + 1; %increment a to continue solving
        end
        
        if (strcmp(char(class(speed_final_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym')) && (strcmp(char(class(v_y_final_var)), 'sym') ~= 1)
        
            v_x_var = double(solve( speed_final_var == sqrt((v_x_var)^2 + (v_y_final_var)^2), v_x_var)); % solve for missing value
            if length(v_x_var) > 1
                v_x_var = v_x_var(2);
            end
            a = a + 1; %increment a to continue solving
        end
        
        if (strcmp(char(class(speed_final_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_final_var)), 'sym'))
        
            v_y_final_var = double(solve( speed_final_var == sqrt((v_x_var)^2 + (v_y_final_var)^2), v_y_final_var)); % solve for missing value
            if length(v_y_final_var) > 1
             
                if v_y_final_var(1) > 0
                    v_y_final_var = v_y_final_var(2);
                else
                  v_y_final_var = v_y_final_var(1);
                end 
             
            end
            a = a + 1; %increment a to continue solving
        end
        
        
        
        
        
        %%% solving for  speed_final, v_y_tmax, v_x %%%
        if (strcmp(char(class(speed_final_var)), 'sym')) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_tmax_var)), 'sym') ~= 1)
        
            speed_final_var = double(solve( speed_final_var == sqrt((v_x_var)^2 + (v_y_tmax_var)^2), speed_final_var)); % solve for missing value
            a = a + 1; %increment a to continue solving
        end
        
        
        
        
        
        
        %%% solving for H_max, theta, and Range %%%
        if (strcmp(char(class(H_max_var)), 'sym')) && (strcmp(char(class(theta_var)), 'sym') ~= 1) && (strcmp(char(class(range_var)), 'sym') ~= 1)
            
            H_max_var = double(solve( (H_max_var == (1/4) * range_var * tan( theta_var * (pi/180))), H_max_var));
            a = a + 1;
        end
        
        if (strcmp(char(class(H_max_var)), 'sym') ~= 1) && (strcmp(char(class(theta_var)), 'sym')) && (strcmp(char(class(range_var)), 'sym') ~= 1)
            
            theta_max = double(solve( (H_max_var == (1/4) * range_var * tan( theta_var * (pi/180))), theta_max));
            a = a + 1;
        end
        
        if (strcmp(char(class(H_max_var)), 'sym') ~= 1) && (strcmp(char(class(theta_var)), 'sym') ~= 1) && (strcmp(char(class(range_var)), 'sym'))
            
            range_var = double(solve( (H_max_var == (1/4) * range_var * tan( theta_var * (pi/180))), range_var));
            a = a + 1;
        end
        
        
        
        
        
        %%% solving for H_max %%%
        if (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) % check first if v_y_init is known or not, if it is :
  
            if v_y_init_var < 0 || v_y_init_var == 0 % we know y_init is the max y if v_y_init is negative
                
                H_max_var = y_init_var;
            end
        end
        
        
        
        
        
        %%% solving for H_max, v_y_init, y_init %%%
        if (strcmp(char(class(H_max_var)), 'sym')) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1)
            
             H_max_var = double(solve( (H_max_var == ((v_y_init_var ^ 2)/(2 * g)) + y_init_var), H_max_var)); %solve for missing value
             a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(H_max_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym')) && (strcmp(char(class(y_init_var)), 'sym') ~= 1)
            
            v_y_init_var = double(solve( (H_max_var == ((v_y_init_var ^ 2)/(2 * g)) + y_init_var), v_y_init_var)); %solve for missing value
            if length(v_y_init_var) > 1 && (strcmp(char(class(theta_var)), 'sym') ~= 1) && theta_var < 0 
               v_y_init_var = v_y_init_var(1); % only take - val if theta is -
            elseif length(v_y_init_var) > 1
               v_y_init_var = v_y_init_var(2); % take + val if theta is positive
            end
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(H_max_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym'))
           
            y_init_var = double(solve( (H_max_var == ((v_y_init_var ^ 2)/(2 * g)) + y_init_var), y_init_var)); %solve for missing value
            a = a + 1; % continue solving loop
        end
       
        
        
        
        
        %%% solving for range, v_x, v_y_init, y_init %%%
        if (strcmp(char(class(range_var)), 'sym')) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1)
            
            range_var = double(solve( (range_var == (v_x_var / g) * (v_y_init_var + sqrt((v_y_init_var)^2 + (2 * g * y_init_var)))), range_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(range_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym')) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1)
            
            v_x_var = double(solve( (range_var == (v_x_var / g) * (v_y_init_var + sqrt((v_y_init_var)^2 + (2 * g * y_init_var)))), v_x_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(range_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym')) && (strcmp(char(class(y_init_var)), 'sym') ~= 1)
            if v_x_var ~= 0
                v_y_init_var = double(solve( (range_var == (v_x_var / g) * (v_y_init_var + sqrt((v_y_init_var)^2 + (2 * g * y_init_var)))), v_y_init_var)); % solve for missing value
                if length(v_y_init_var) > 1 && (strcmp(char(class(theta_var)), 'sym') ~= 1) && theta_var < 0 
                   v_y_init_var = v_y_init_var(1); % only take - val if theta is -
                elseif length(v_y_init_var) > 1
                   v_y_init_var = v_y_init_var(2); % take + val if theta is positive
                end
            end
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(range_var)), 'sym') ~= 1) && (strcmp(char(class(v_x_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym'))
           if v_x_var ~= 0
                y_init_var = double(solve( (range_var == (v_x_var / g) * (v_y_init_var + sqrt((v_y_init_var)^2 + (2 * g * y_init_var)))), y_init_var)); % solve for missing value
           end
           a = a + 1; % continue solving loop
        end
        
        
        
        
        
        %%% solving for flight_time, v_y_init, y_init %%%
        if (strcmp(char(class(flight_time_var)), 'sym')) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1)
            
           flight_time_var = double(solve( (flight_time_var == (1 / g) * (v_y_init_var + sqrt((v_y_init_var)^2 + (2 * g * y_init_var)))), flight_time_var)); % solve for missing value
           a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(flight_time_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym')) && (strcmp(char(class(y_init_var)), 'sym') ~= 1)
            
           v_y_init_var = double(solve( (flight_time_var == (1 / g) * (v_y_init_var + sqrt((v_y_init_var)^2 + (2 * g * y_init_var)))), v_y_init_var)); % solve for missing value
          
           if length(v_y_init_var) > 1 && (strcmp(char(class(theta_var)), 'sym') ~= 1) && theta_var < 0 
               v_y_init_var = v_y_init_var(1); % only take - val if theta is -
            elseif length(v_y_init_var) > 1
               v_y_init_var = v_y_init_var(2); % take + val if theta is positive
            end
           a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(flight_time_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym'))
            
           y_init_var = double(solve( (flight_time_var == (1 / g) * (v_y_init_var + sqrt((v_y_init_var)^2 + (2 * g * y_init_var)))), y_init_var)); % solve for missing value
           a = a + 1; % continue solving loop
        end
        
        
        
        
        
        %%% solving for t_max_ht_var, v_y_init %%%
        if (strcmp(char(class(t_max_ht_var)), 'sym')) && (strcmp(char(class(v_y_init_var)), 'sym') ~= 1)
            
            t_max_ht_var = double(solve( (t_max_ht_var == v_y_init_var / g), t_max_ht_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        if (strcmp(char(class(t_max_ht_var)), 'sym') ~= 1) && (strcmp(char(class(v_y_init_var)), 'sym'))
            
            v_y_init_var = double(solve( (t_max_ht_var == v_y_init_var / g), v_y_init_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
        
        
        
        
        %%% solve for theta_max_var%%%
        if (strcmp(char(class(y_init_var)), 'sym') ~= 1) && y_init_var ==0
            theta_max_var = 45;
        end
        
        if (strcmp(char(class(theta_max_var)), 'sym')) && (strcmp(char(class(speed_init_var)), 'sym') ~= 1) && (strcmp(char(class(y_init_var)), 'sym') ~= 1)
            
            theta_max_var = double(solve( (tan(theta_max_var * (pi/180)) == ( speed_init_var / sqrt( (speed_init_var ^ 2) + (2 * g * y_init_var)))), theta_max_var)); % solve for missing value
            a = a + 1; % continue solving loop
        end
        
    
        
        
        b = b + 1; % keeps track of how many times loop ran
        
    end
    
    
    
    
    % After solver is done solving for every variable it can, 
    % puts solved values into parameters for output
    new_parameters{1} = x_pos_init_var;
    new_parameters{2} = x_pos_final_var;
    new_parameters{3} = v_y_init_var;
    new_parameters{4} = v_y_final_var;
    new_parameters{5} = v_x_var;
    new_parameters{6} = speed_init_var;
    new_parameters{7} = speed_final_var;
    new_parameters{8} = t_max_ht_var;
    new_parameters{9} = t_final_var;
    new_parameters{10} = flight_time_var;
    new_parameters{11} = x_pos_maxH_var;
    new_parameters{12} = H_max_var;
    new_parameters{13} = y_init_var;
    new_parameters{14} = y_final_var;
    new_parameters{15} = range_var;
    new_parameters{16} = theta_var;
    new_parameters{17} = theta_max_var;
    new_parameters{18} = v_y_tmax_var;
    

    
    % finds all vars that were not solved for and changes their value in
    % new_parameters back to 'not'
    for i = 1: 18   
        if strcmp(char(class(new_parameters{i})),'sym')           
           new_parameters{i} = 'not';
        end
    end
    
%end