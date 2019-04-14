% Stability Analysis
% EE386 - Design Project
% Hunter Phillips

% PD Controller Nyquist Plot
f1 = figure;
k1_PD = 59.6063;
k2_PD = 0.67;
PI_num = [0.06*k2_PD 0.06*k1_PD];
PI_den= [0.05 (0.46+0.06*k2_PD) 0.06*k1_PD];
nyquist (tf(PI_num,PI_den))
title('Hunter Phillips Nyquist Plot for PD Controller')
xlim([-1.2 1.2])
grid

% PD Controller Bode Plot
f2 = figure;
bode (tf(PI_num,PI_den)) % using previous vars
title('Hunter Phillips Bode Plot for PD Controller')
grid

% PID Controller Nyquist Plot
f3 = figure;
k1_PID = 279.9;
k2_PID = 10.56;
k3_PID = 1627.6;
PID_num = [0.06*k2_PID 0.06*k1_PID + 0.06*k3_PID];
PID_den = [0.05 (0.46+0.06*k2_PID) 0.06*k1_PID 0.06*k3_PID];
nyquist (tf(PID_num,PID_den))
title('Hunter Phillips Nyquist Plot for PID Controller')
xlim([-1.2 1.2])
grid

% PD Controller Bode Plot
f4 = figure;
bode (tf(PID_num,PID_den)) % using previous vars
title('Hunter Phillips Bode Plot for PID Controller')
grid

print(f1,'../results/pd_nyquist', '-dpng', '-r1200')
print(f2,'../results/pd_bode', '-dpng', '-r1200')
print(f3,'../results/pid_nyquist', '-dpng', '-r1200')
print(f4,'../results/pid_bode', '-dpng', '-r1200')

