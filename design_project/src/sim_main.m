% Script to run simulations to produce
% datasets for post analysis
% EE386 - Design Project
% Hunter Phillips

clear
clc

addpath('sim_function_calls')

% Plot PD Controller with PreFilter
plot_PD_with_PF(false)      % Run Plotting without saving them
                            % change input arg to true to save figures

% Plot PD Controller without PreFilter                            
plot_PD_without_PF(false)

% Plot PID Controller with PreFilter
plot_PID_with_PF(false)

% Plot PID Controller without PreFilter
plot_PID_without_PF(false)   

