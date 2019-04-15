function [] = plot_PD_without_PF(savee)

    % Plotting the simulation for the Design Project
    % PD controller without PreFilter
    % EE-386 - Spring 2019
    % Hunter Phillips

    addpath('../src/simulations')
    sim('PD_without_PreFilter_out.slx')
    
    % Plot Command Input theta_A*
    f1 = figure;
    plot(reference_input.time, reference_input.signals.values, 'b')
    legend('\theta_A^*','fontsize', 12, 'location', 'southeast')
    title('Hunter Phillips Antenna Commanded Position','interpreter','latex')
    xlabel('Time (s)','interpreter','latex')
    ylabel('Angle (rad)','interpreter','latex')
    ylim([-0.2 1.2])
    grid
    
    % Plot Armature Voltage Va
    f2 = figure;
    plot(vA.time, vA.signals.values, 'r')
    legend('V_A','fontsize', 12, 'location', 'southeast')
    title('Hunter Phillips Armature Voltage','interpreter','latex')
    xlabel('Time (s)','interpreter','latex')
    ylabel('Voltage (Volts)','interpreter','latex')
    ylim([-20 140])
    grid

    % Plot Antenna Position Output theta_A
    f3 = figure;
    plot(control_output.time, control_output.signals.values, 'b')
    legend('\theta_A','fontsize', 12, 'location', 'southeast')
    title('Hunter Phillips Antenna Position Output','interpreter','latex')
    xlabel('Time (s)','interpreter','latex')
    ylabel('Angle (rad)','interpreter','latex')
    ylim([-0.2 1.2])
    grid
    
    % Plot Angle Error eA
    f4 = figure;
    plot(eA.time, eA.signals.values, 'm')
    legend('e_A','fontsize', 12, 'location', 'southeast')
    title('Hunter Phillips Angle Error','interpreter','latex')
    xlabel('Time (s)','interpreter','latex')
    ylabel('Angle (rad)','interpreter','latex')
    ylim([-0.2 1.2])
    grid
    
    % Plot Wind Disturbance
    f5 = figure;
    plot(disturbance.time, disturbance.signals.values, 'k')
    legend('T_d','fontsize', 12, 'location', 'southeast')
    title('Hunter Phillips Wind Disturbance','interpreter','latex')
    xlabel('Time (s)','interpreter','latex')
    ylabel('Torque (N-m)','interpreter','latex')
    ylim([-2 20])
    xlim([0 5])
    grid
    
    if savee == true
        print(f1,'../results/pd_without_pf_command_pos', '-dpng', '-r1200')
        print(f2,'../results/pd_without_pf_arma_v', '-dpng', '-r1200')
        print(f3,'../results/pd_without_pf_actual_pos', '-dpng', '-r1200')
        print(f4,'../results/pd_without_pf_angle_error', '-dpng', '-r1200')
        print(f5,'../results/pd_without_pf_disturb', '-dpng', '-r1200')
    end
    
end

