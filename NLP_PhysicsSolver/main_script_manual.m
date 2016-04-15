%%% V 2.0 (added param_save and x_pos_maxH, v_y_tmax) %%%
clear all

parameters = {'initial x-position', 'final x-position', 'intial y-velocity',...
    'final y-velocity', 'x-velocity (it is both final and initial)', 'initial speed', ...
    'final speed','time to maximum height', 'final time', 'flight time', 'x-position at maximum height',...
    'maximum height', 'initial y-position', 'final y-position', 'range', 'theta',...
    'value of theta for max. range', 'y-velocity when the projectile hits the ground'};

parameter_names_save = parameters; % saves string values of parameters for later use

[parameters] = manual_enter(parameters); % takes user input, checks it for errors and 
                                      % formats it the way we want,and puts it in parameters cell array

solver(); % solves for as many unknowns in parameters as possible


%{
%%%%%%%%% Makes sure to explicitly initialize all %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% parameters with inputed value from user. %%%%%%%%%%%%%%%%%%%%%%%%
x_pos_init = parameters{1};
x_pos_final = parameters{2};
v_y_init = parameters{3};
v_y_final = parameters{4};
v_x = parameters{5};
speed_init = parameters{6};
speed_final = parameters{7};
t_max_ht = parameters{8};
t_final = parameters{9};
flight_time = parameters{10};
x_pos_maxH = parameters{11}
H_max = parameters{12};
y_init = parameters{13};
y_final = parameters{14};
range = parameters{15};
theta = parameters{16};
theta_max = parameters{17};
v_y_tmax_var = parameters{18};



%}
