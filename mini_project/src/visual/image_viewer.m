% Image Visualization with PNG of Rocket System
% EE386 - Mini Project
% Not part of the project, just experimentation for skills development.
% Hunter Phillips

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run example:
% Run PID_sim_3_5.slx located in the current folder to output appropriate
% data for the test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read in example sim data
angledata = rad2deg(pid_6_25_scope.signals(2).values); % make sure it is in deg
disturbance = pid_6_25_step.signals.values; % "wind"
time = pid_6_25_scope.time;

% read png and pad it
robot = imread('robot.png');
robot(:,:,:)=255-robot(:,:,:);
robot = padarray(robot,[25 25],255); % Might need to decrease [X X] depending on screen size

% assign figure 1 for visualizer
f1 = figure(1);
movegui(f1,'west')

% assign figure 2 for alpha plot
f2 = figure(2);
movegui(f2,'northeast')

set(0,'CurrentFigure',f2) % use animated line for aesthetics
a1 = animatedline('Color',[107/255 91/255 149/255]);
x = time;
axis([0 10 -10 10])

% assign figure 2 for step plot
f3 = figure(3);
movegui(f3,[-1,50])

set(0,'CurrentFigure',f3)
a2 = animatedline('Color',[0 110/255 109/255]);
axis([0 10 -1 15])


for t = 1:length(angledata) % traverse all sim data
    
    theta = angledata(t);   % assign current theta being observed
    
    X = imrotate(robot, theta, 'crop');                 % rotate image to theta and crop excess parts of image instead 
    Mrot = ~imrotate(true(size(robot)),theta, 'crop');  % of sizing to fit (plot isn't stable if this occurs)
    X(Mrot&~imclearborder(Mrot)) = 255;                 % change default cropped border fill to white (no argument to typically change the default black)

    RI = imref2d(size(X));      % take coords
    RI.XWorldLimits = [0 10];   % and assign arbitrary values
    RI.YWorldLimits = [0 10];   % (for possible future numerical representation on plot)
    
    % rocket plot
    set(0,'CurrentFigure',f1)
    imshow(X, RI)
    drawnow % force image to display real time
    
    % alpha plot
    set(0,'CurrentFigure',f2)
    xk = x(t);
    addpoints(a1, xk, theta)
    drawnow
    
    % disturbance plot
    set(0,'CurrentFigure',f3)
    xk = x(t);
    addpoints(a2, xk, disturbance(t))
    drawnow
    
end

