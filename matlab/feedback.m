%Post process STB simulation results
clear all; close all;
% Read simulation result
simDir = [getenv('ECE6720_WORKDIR') '/simulation/HW9/spectre/schematic/psf'];
% Use this helper code to resolve the '~/' symbol for cds_srr:
currentDir = pwd(); cd(simDir); simDir = pwd(); cd(currentDir);
%Grab the unity gain frequency and phase margin results
fu = cds_srr(simDir, 'stb-margin.stb', 'phaseMarginFreq');
PM = cds_srr(simDir, 'stb-margin.stb', 'phaseMargin');
%Grab the loop gain
data = cds_srr(simDir, 'stb-stb', 'loopGain');
freq = data.freq; T = data.LOOPGAIN;
%Grab the 'DC' loop gain and measurement frequency
To = T(1); TodB = 20*log10(T(1)); fTo = freq(1);
%Calculate the magnitude and phase of T
MagTdB = 20*log10(abs(T));
PhaseTdeg = 360*phase(T)/2/pi - 180; %Shift by 180 for the minus sign
%Build result strings to display with the plot
result_strMag = sprintf('To = %.1fV/V = %.1fdB at f=%.1fkHz funity = %.1fMHz',abs(To),TodB,fTo/1e3,fu/1e6);
result_strPhase = sprintf('Phase of T(s) is %.1fdeg at fu=%.1fMHz Phase Margin = %.1fdeg',PM-180,fu/1e6,PM);
% Font and size for plots
font_size = 18; font_name = 'Arial';
% Make the plot
figure(1);
subplot(2,1,1)
set(gca,'FontSize',font_size,'FontName',font_name);
semilogx(freq, MagTdB, 'linewidth', 2);
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
title(sprintf('Magnitude Response of T(s)\n%s',result_strMag))
axis([freq(1) freq(end) -70 80])
grid
subplot(2,1,2)
set(gca,'FontSize',font_size,'FontName',font_name);
semilogx(freq, PhaseTdeg, 'linewidth', 2);
xlabel('Frequency [Hz]');
ylabel('Phase [deg]');
title(sprintf('Phase of T(s)\n%s',result_strPhase))
axis([freq(1) freq(end) -200 45])
grid