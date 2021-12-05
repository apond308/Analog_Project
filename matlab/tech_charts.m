% Generate technology characterization charts for NMOS and PMOS data
% Ross Walker, Univ of Utah, 9/9/2014

close all;
clear all;
% Load NMOS and PMOS data tables
% Note: the nch and pch data entries generally correspond to dimensions:
% nch(L, VGS, VDS, VSB)
load 180n.mat;
load 180p.mat;

%-----------------Main User Variables--------------------------------------
%Define a working range of gm/ID values (typically 5-20)
gm_id = 15;
%Choose the lengths to be plotted
Lnmos = [0.18:0.02:0.3]*1e-6;
Lpmos = [0.18:0.02:0.3]*1e-6;
%The VDS value to use for generating the intrinsic gain charts
VDSgmro = 0.9;
%--------------------------------------------------------------------------

%Plot settings
font_size = 20; font_name = 'Arial'; linewidth = 1; legend_font_size = 16;
fTAxisNMOS = [gm_id(1) gm_id(end) 0 40];
fTAxisPMOS = [gm_id(1) gm_id(end) 0 15];
IdWAxisNMOS = [gm_id(1) gm_id(end) 1e-1 1e2];
IdWAxisPMOS = [gm_id(1) gm_id(end) 1e-1 1e2];
gmroAxisNMOS = [gm_id(1) gm_id(end) 0 150];
gmroAxisPMOS = [gm_id(1) gm_id(end) 0 150];


% Plot NMOS fT against gm_ID
% Note that VDS is not specified here; it then defaults to max(nch.VDS)/2
wt = Lookup(nch, 'GM_CGG', 'GM_ID', gm_id, 'L', Lnmos);
figure(1)
set(gca,'FontSize',font_size,'FontName',font_name);
plot(gm_id, wt/2/pi/1e9,'LineWidth',linewidth)
xlabel('g_m/I_D [S/A]')
ylabel('f_T [GHz]')
title('NMOS Transit Frequency Chart')
%Create a legend string cell and display it
for i=1:length(Lnmos)
   legendCell{i} = sprintf('NMOS L=%.0fnm',Lnmos(i)*1e9); 
end
legend(legendCell, 'FontSize', legend_font_size)
axis(fTAxisNMOS)



% Plot PMOS fT against gm_ID
% Note that VDS is not specified here; it then defaults to max(nch.VDS)/2
wt = Lookup(pch, 'GM_CGG', 'GM_ID', gm_id, 'L', Lpmos);
figure(2)
set(gca,'FontSize',font_size,'FontName',font_name);
plot(gm_id, wt/2/pi/1e9,'LineWidth',linewidth)
xlabel('g_m/I_D [S/A]')
ylabel('f_T [GHz]')
title('PMOS Transit Frequency Chart')
%Create a legend string cell and display it
for i=1:length(Lpmos)
   legendCell{i} = sprintf('PMOS L=%.0fnm',Lpmos(i)*1e9); 
end
legend(legendCell, 'FontSize', legend_font_size)
axis(fTAxisPMOS)

% Plot NMOS ID/W against gm_ID
% Note that VDS is not specified here; it then defaults to max(nch.VDS)/2
id_w = Lookup(nch, 'ID_W', 'GM_ID', gm_id, 'L', Lnmos);
figure(3)
set(gca,'FontSize',font_size,'FontName',font_name);
semilogy(gm_id, id_w,'LineWidth',linewidth)
xlabel('g_m/I_D [S/A]')
ylabel('I_D/W [\muA/\mum]')
title('NMOS Current Density Chart')
%Create a legend string cell and display it
for i=1:length(Lnmos)
   legendCell{i} = sprintf('NMOS L=%.0fnm',Lnmos(i)*1e9); 
end
legend(legendCell, 'FontSize', legend_font_size)
axis(IdWAxisNMOS)


% Plot PMOS ID/W against gm_ID
% Note that VDS is not specified here; it then defaults to max(nch.VDS)/2
id_w = Lookup(pch, 'ID_W', 'GM_ID', gm_id, 'L', Lpmos);
figure(4)
set(gca,'FontSize',font_size,'FontName',font_name);
semilogy(gm_id, id_w,'LineWidth',linewidth)
xlabel('g_m/I_D [S/A]')
ylabel('I_D/W [\muA/\mum]')
title('PMOS Current Density Chart')
%Create a legend string cell and display it
for i=1:length(Lpmos)
   legendCell{i} = sprintf('PMOS L=%.0fnm',Lpmos(i)*1e9); 
end
legend(legendCell, 'FontSize', legend_font_size)
axis(IdWAxisPMOS)


% Plot NMOS gm/gds against gm_id for the specific VDS
gm_gds = Lookup(nch, 'GM_GDS', 'GM_ID', gm_id, 'L', Lnmos, 'VDS', VDSgmro);
figure(5)
set(gca,'FontSize',font_size,'FontName',font_name);
plot(gm_id, gm_gds,'LineWidth',linewidth)
xlabel('g_m/I_D [S/A]')
ylabel('g_m/g_d_s')
title(sprintf('NMOS Intrinsic Gain versus g_m/I_D\nV_D_S = %.2fV',VDSgmro))
%Create a legend string cell and display it
for i=1:length(Lnmos)
   legendCell{i} = sprintf('NMOS L=%.0fnm',Lnmos(i)*1e9); 
end
legend(legendCell, 'FontSize', legend_font_size)
axis(gmroAxisNMOS)


% Plot PMOS gm/gds against gm_id for the specific VDS
gm_gds = Lookup(pch, 'GM_GDS', 'GM_ID', gm_id, 'L', Lpmos, 'VDS', VDSgmro);
figure(6)
set(gca,'FontSize',font_size,'FontName',font_name);
plot(gm_id, gm_gds,'LineWidth',linewidth)
xlabel('g_m/I_D [S/A]')
ylabel('g_m/g_d_s')
title(sprintf('PMOS Intrinsic Gain versus g_m/I_D\nV_D_S = %.2fV',VDSgmro))
%Create a legend string cell and display it
for i=1:length(Lpmos)
   legendCell{i} = sprintf('PMOS L=%.0fnm',Lpmos(i)*1e9); 
end
legend(legendCell, 'FontSize', legend_font_size)
axis(gmroAxisPMOS)

% Plot NMOS capacitance ratios wrt Cgg for gm/ID of 10 and VDS of 0.9V
cgd_cggn = Lookup(nch, 'CGD_CGG', 'GM_ID', 10, 'L', Lnmos);
cgs_cggn = Lookup(nch, 'CGS_CGG', 'GM_ID', 10, 'L', Lnmos);
cdd_cggn = Lookup(nch, 'CDD_CGG', 'GM_ID', 10, 'L', Lnmos);
figure(7)
set(gca,'FontSize',font_size,'FontName',font_name);
plot(Lnmos*1e6, cgd_cggn,'LineWidth',linewidth)
hold on
plot(Lnmos*1e6, cgs_cggn, 'r', 'LineWidth',linewidth)
plot(Lnmos*1e6, cdd_cggn, 'g', 'LineWidth',linewidth)
xlabel('Length (um)')
ylabel('Ratio')
title('NMOS Capacitance Ratios Versus Length, gm/ID = 10S/S, VDD = 0.9V')
%Create a legend string cell and display it
legendCell{1} = 'Cgd/Cgg';
legendCell{2} = 'Cgs/Cgg';
legendCell{3} = 'Cdd/Cgg';
legend(legendCell, 'FontSize', legend_font_size)
axis([min(Lnmos)*1e6 max(Lnmos)*1e6 0 1])

% Plot PMOS capacitance ratios wrt Cgg for gm/ID of 10 and VDS of 0.9V
cgd_cggp = Lookup(pch, 'CGD_CGG', 'GM_ID', 10, 'L', Lpmos);
cgs_cggp = Lookup(pch, 'CGS_CGG', 'GM_ID', 10, 'L', Lpmos);
cdd_cggp = Lookup(pch, 'CDD_CGG', 'GM_ID', 10, 'L', Lpmos);
figure(8)
set(gca,'FontSize',font_size,'FontName',font_name);
plot(Lpmos*1e6, cgd_cggp,'LineWidth',linewidth)
hold on
plot(Lpmos*1e6, cgs_cggp, 'r', 'LineWidth',linewidth)
plot(Lpmos*1e6, cdd_cggp, 'g', 'LineWidth',linewidth)
xlabel('Length (um)')
ylabel('Ratio')
title('PMOS Capacitance Ratios Versus Length, gm/ID = 10S/S, VDD = 0.9V')
%Create a legend string cell and display it
legendCell{1} = 'Cgd/Cgg';
legendCell{2} = 'Cgs/Cgg';
legendCell{3} = 'Cdd/Cgg';
legend(legendCell, 'FontSize', legend_font_size)
axis([min(Lpmos)*1e6 max(Lpmos)*1e6 0 1])




