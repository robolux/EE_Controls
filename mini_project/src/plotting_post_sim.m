% Script to plot scope data from simulation runs
% Extracts data from mat files that contain data structures
% EE386 - Mini Project
% Hunter Phillips

clear
clc

load('../results/uncomp_data.mat')
load('../results/pd_0_data.mat')
load('../results/pd_3_5_data.mat')
load('../results/pid_3_5_data.mat')

% Uncompensated Simulation Plot
figure(1)
plot(uncomp_scope.time, uncomp_scope.signals.values, 'b')
legend('\alpha', 'fontsize', 12, 'location', 'northwest');
grid
title('Hunter Phillips Uncompensated','interpreter','latex')
xlabel('time (s)')
ylabel('angle (rad)')
% print('../results/uncomp_sim', '-dpng', '-r1200')


% PD with w(t) = 0 Simulation Plot
figure(2)
plot(pd_scope_0.time, pd_scope_0.signals(2).values, 'b')
hold on
plot(pd_scope_0.time, pd_scope_0.signals(1).values, 'r')
legend('\alpha', '\delta', 'fontsize', 12, 'location', 'southeast');
grid
title('Hunter Phillips PD with $w(t) = 0$','interpreter','latex')
xlabel('time (s)')
ylabel('angle (rad)')
% print('../results/pd_0_sim', '-dpng', '-r1200')


% PD with w(t) = 3.5*1(t-4) Simulation Plot
figure(3)
plot(pd_3_5_scope.time, pd_3_5_scope.signals(2).values, 'b')
hold on
plot(pd_3_5_scope.time, pd_3_5_scope.signals(1).values, 'r')
legend('\alpha', '\delta', 'fontsize', 12, 'location', 'northwest');
grid
title('Hunter Phillips PD with w(t) = $3.5\cdot1(t-4)$','interpreter','latex')
xlabel('time (s)')
ylabel('angle (rad)')
% print('../results/pd_3_5_sim', '-dpng', '-r1200')


% PD with w(t) = 3.5*1(t-4) Step Plot
figure(4)
plot(pd_3_5_step.time, pd_3_5_step.signals.values, 'm')
legend('Step \rightarrow w(t)', 'fontsize', 10, 'location', 'northwest','interpreter','tex');
grid
title('Hunter Phillips PD with w(t) = $3.5\cdot1(t-4)$ Step','interpreter','latex')
xlabel('time (s)')
ylabel('w(t)')
ylim([-0.5 4])
% print('../results/pd_3_5_step', '-dpng', '-r1200')


% PID with w(t) = 3.5*1(t-4) Simulation Plot
figure(5)
plot(pid_3_5_scope.time, pid_3_5_scope.signals(2).values, 'b')
hold on
plot(pid_3_5_scope.time, pid_3_5_scope.signals(1).values, 'r')
legend('\alpha', '\delta', 'fontsize', 12, 'location', 'southeast');
grid
title('Hunter Phillips PID with w(t) = $3.5\cdot1(t-4)$','interpreter','latex')
xlabel('time (s)')
% print('../results/pid_3_5_sim', '-dpng', '-r1200')

 
% PID with w(t) = 3.5*1(t-4) Step Plot
figure(6)
plot(pid_3_5_step.time, pid_3_5_step.signals.values, 'm')
legend('Step \rightarrow w(t)', 'fontsize', 10, 'location', 'northwest','interpreter','tex');
grid
title('Hunter Phillips PID with w(t) = $3.5\cdot1(t-4)$ Step','interpreter','latex')
xlabel('time (s)')
ylabel('w(t)')
ylim([-0.5 4])
% print('../results/pid_3_5_step', '-dpng', '-r1200')
