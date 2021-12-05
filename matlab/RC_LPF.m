%% Import the AC data and plot the magnitude response
clear all; close all;
simDir = ['/home/u0666767/ECE6720_F21' '/simulation/RC_LPF/spectre/schematic/psf'];
% read simulation result, use this helper code to resolve '~/' for cds_srr:
currentDir = pwd(); cd(simDir); simDir = pwd(); cd(currentDir);
vout = cds_srr(simDir,'ac-ac','out');
%Unpack the frequency vector from the struct
f = vout.freq;
%Calculate the magnitude response in dB
magdB = 20*log10(abs(vout.V));
%Find the -3dB frequency
%Cut out the first few points, can cause numeric problems with interp1
indx = find(f > 1e4);
%Interpolate to find the -3dB frequency
f3dB = interp1(magdB(indx), f(indx), magdB(1)-3)
%Format the result into a string, to attach to the plot
result_str = sprintf('f_{-3dB} = %.1f MHz', f3dB/1e6);
%Font and size for plot text
font_size = 20; font_name = 'Arial';
%Plot the magnitude response
figure(1);
semilogx(f, magdB, 'linewidth', 2);
set(gca,'FontSize',font_size,'FontName',font_name);
axis([f(1) f(end) -60 20])
grid;
title(sprintf('RC LPF Magnitude Response\n%s',result_str))
xlabel('Frequency [Hz]')
ylabel('Magntiude [dB]')

%%   Import the DC sweep data and plot the device capacitances
%Written by Sakthidasan Kalidasan
clear all; close all;
%Point to the right simulation directory
simDir = [getenv('ECE6720_WORKDIR') '/simulation/example_cs/spectre/schematic/psf'];
currentDir = pwd(); cd(simDir); simDir = pwd(); cd(currentDir);
%Grab the simulation outputs
sig1 = cds_srr(simDir,'dc-dc','M1:cgd');
sig2 = cds_srr(simDir,'dc-dc','M1:cgs');
sig3 = cds_srr(simDir,'dc-dc','M1:cdb');
sig4 = cds_srr(simDir,'dc-dc','M1:cgb');
cgd = abs(sig1.F);
cgs = abs(sig2.F);
cdb = abs(sig3.F);
cgb = abs(sig4.F);
%Font and size for plot text
font_size = 14; font_name = 'Arial';
%Plot the device caps
figure(1);
plot(sig1.dc,cgd*1e15,'LineWidth',2)
set(gca,'FontSize',font_size,'FontName',font_name);
hold on
title('Device Capacitances vs V_G_S')
xlabel('V_G_S [V]')
ylabel('Capacitance Value [fF]')
plot(sig2.dc,cgs*1e15,'LineWidth',2)
plot(sig3.dc,cdb*1e15,'LineWidth',2)
plot(sig4.dc,cgb*1e15,'LineWidth',2)
legend('Cgd', 'Cgs', 'Cdb', 'Cgb')
hold off
