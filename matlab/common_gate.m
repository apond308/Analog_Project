%% Import the AC data and plot the magnitude response
clear all; close all;
simDir = [getenv('ECE6720_WORKDIR') '/simulation/HW10/spectre/schematic/psf'];
% read simulation result, use this helper code to resolve '~/' for cds_srr:
currentDir = pwd(); cd(simDir); simDir = pwd(); cd(currentDir);
Id = cds_srr(simDir,'dc-dc', 'M0:d');

Vgs = [0:0.2:1.8];

Vt1 = 0.436;
K1 = 5.66e-3;
Id1 = K1*(Vgs-Vt1).^2;


Vt2 = 0.05347;
K2 = 2.21e-3;
Id2 = K2*(Vgs-Vt2).^2;

%Font and size for plot text
font_size = 12; font_name = 'Arial';
%Plot the magnitude response
figure(1);
plot(Id.Vgs, Id.I);
hold on;
plot(Vgs, Id1);
plot(Vgs, Id2);
hold off;
legend('Simulation', 'Sq Law 1', 'Sq Law 2');
% semilogx(f, magdB, 'linewidth', 2);
set(gca,'FontSize',font_size,'FontName',font_name);
% axis([f(1) f(end) -60 20])
grid;
title(sprintf('Common Gate Magnitude Response\n'))
xlabel('Vgs')
ylabel('Id (mA)')
