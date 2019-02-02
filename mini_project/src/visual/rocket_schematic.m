% Plot Rocket FBD as scalable graph with live feedback
% EE-386 Mini Project
% Technical Representation to test abilities with complex 
% line plotting in real-time
% Hunter Phillips

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run example:
% Run PID_sim_6_25.slx located in the current folder to output appropriate
% data for the test

% if the simulation displays quickly and you would like the visualization
% to be slower, go to line 158 and change the pause() command to delay the
% plot to your personal preference
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clf

% read in sim data
angledata = rad2deg(pid_6_25_scope.signals(2).values);
disturbance = pid_6_25_step.signals.values;
time = pid_6_25_scope.time;

% set figure 1
f1 = figure(1);
xlim([-15 15])
ylim([-10 15])
set(groot,'defaultfigureposition',[680 558 560 420]) % makes sure this plot is default size
hold on                                              % on all platforms

% set figure 2
f2 = figure(2);
movegui(f2,'northeast')
xtt = time;

set(0,'CurrentFigure',f2)
a1 = animatedline('Color',[107/255 91/255 149/255]);
axis([0 10 -10 10])

% set figure 3
f3 = figure(3);
movegui(f3,[-1,50])

set(0,'CurrentFigure',f3)
a2 = animatedline('Color',[0 110/255 109/255]);
axis([0 10 -1 15])


for t = 1:length(angledata)     % iterate across all angle data
    
    theta = -90+angledata(t);   % shift angle since curve of nosecone is along the +x axis
    
    set(0,'CurrentFigure',f1)        % set current figure to f1
    children = get(gca, 'children'); 
    delete(children)                 % delete all children of plot (you don't need the last frame)
    hold on
    
    if angledata(t) < 0.1 && angledata(t) > -0.1 % when displaying the alpha angle if below a certain threshold
        conv_string = 0;                         % don't show the full float value (the E nomenclature makes it hard
    else                                         % to read when real-time
        conv_string = -angledata(t); % negative because flipping +- axis to be -LR+
    end
    
    txt = strcat('\alpha = ^{ }', num2str(conv_string,3)); % form string to display
    text(-1.25,14,txt, 'Interpreter', 'tex')               % show string of data
    
    %% Tangent Ogive Nosecone 
    x = 0.001:12;
    R = 2;
    L = 11;
    rho = (R^2 + L^2)/(2*R);
    
    % shifting around angle using rotation "matrix"
    y = (sqrt(rho^2-(L-x).^2) + R - rho);
    xprime_1 = (x-9.119918923940819).*cosd(theta) - y.*sind(theta);
    yprime_1 = (x-9.119918923940819).*sind(theta) + y.*cosd(theta);

    y2 = -(sqrt(rho^2-(L-x).^2) + R - rho);
    xprime_2 = (x-9.119918923940819).*cosd(theta) - y2.*sind(theta);
    yprime_2 = (x-9.119918923940819).*sind(theta) + y2.*cosd(theta);

    plot(xprime_1, yprime_1, 'm') % plot 1st half of nosecone
    plot(xprime_2, yprime_2, 'm') % plot 2nd hald of nosecone (reverse side)

    plot([xprime_2(end), xprime_1(end)], [yprime_2(end), yprime_1(end)], 'm') % plot connecting line between lower points to finish shape

    %% Center of Mass (CM)
    vl      = length(xprime_2)*5/6;                 % pick point along length of nosecone to place CM
    x_di_cm = ((xprime_2(vl) - xprime_1(vl)))/2;    % pick midpoint between lower nosecone endpoints
    xpos_cm = xprime_2(vl)-x_di_cm;                 % determine associated x point
    y_di_cm = ((yprime_2(vl) - yprime_1(vl)))/2;
    ypos_cm = yprime_2(vl)-y_di_cm;
    plot(xpos_cm,ypos_cm,'bo') % combine a circle and * to get symbol
    plot(xpos_cm,ypos_cm,'r*') % that resembles a CM symbol

    %% Center of Pressure (CP)
    vl      = length(xprime_2)*1/3;                 % calculate CP same as CP just with different
    x_di_cp = ((xprime_2(vl) - xprime_1(vl)))/2;    % shift along body length
    xpos_cp = xprime_2(vl)-x_di_cp;
    y_di_cp = ((yprime_2(vl) - yprime_1(vl)))/2;
    ypos_cp = yprime_2(vl)-y_di_cp;
    plot(xpos_cp,ypos_cp,'bo') % CP symbol
    plot(xpos_cp,ypos_cp,'r*')

    %% Body Y Axis
    vl     = length(xprime_2)*1/4;
    x_di_y = ((xprime_2(vl) - xprime_1(vl)))/2;
    xpos_y = -xprime_2(vl)+x_di_y;
    y_di_y = ((yprime_2(vl) - yprime_1(vl)))/2;
    ypos_y = -yprime_2(vl)+y_di_y;

    L = -20;                    % draw vector with length 20
    x2=xpos_y+(L*cosd(theta));  % find endpoint using standard trig
    y2=ypos_y+(L*sind(theta));
    plot([xpos_y x2],[ypos_y y2],'g--') % plot line between the 2 points

    %% Alpha Angle
    B = [0 13.12]';
    A = [x2 y2]';
    plot([A(1) B(1)], [A(2) B(2)],'b-') % draw line to represent alpha angle

    %% Body Z Axis
    vl   = length(xprime_2)*5/6;
    x_di_z = ((xprime_2(vl) - xprime_1(vl)))/2;
    xpos_z = xprime_2(vl)+x_di_z;
    y_di_z = ((yprime_2(vl) - yprime_1(vl)))/2;
    ypos_z = yprime_2(vl)+y_di_z;

    L = 8;
    x2=xpos_z+(L*cosd(theta+90));
    y2=ypos_z+(L*sind(theta+90));
    plot([xpos_z x2],[ypos_z y2],'g--')

    %% Center Axis Frame
    
    L = -13;
    x2=xpos_cm+(L*cosd(-90));
    y2=ypos_cm+(L*sind(-90));
    plot([xpos_cm x2], [ypos_cm y2],':k')

    %% Inertial Frame X Axis
    
    L = 5;
    x2=xpos_cm+(L*cosd(0));
    y2=ypos_cm+(L*sind(0));
    plot([xpos_cm x2], [ypos_cm y2],'k')

    %% Inertial Frame Y Axis
    
    L = 5;
    x2=xpos_cm+(L*cosd(-90));
    y2=ypos_cm+(L*sind(-90));
    plot([xpos_cm x2], [ypos_cm y2],'k')
    
    hold off
    drawnow
    pause(0.025)
    
    %% alpha plot
    set(0,'CurrentFigure',f2)
    xk = xtt(t);
    theta_a = angledata(t);
    addpoints(a1, xk, theta_a)
    drawnow
    
    %% disturbance plot
    set(0,'CurrentFigure',f3)
    addpoints(a2, xk, disturbance(t))
    drawnow
    
end
