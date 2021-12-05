% Basic usage examples for function "Lookup"
% Boris Murmann
% Stanford University
% Rev. 20140731
% Modified by Ross Walker, Univ of Utah, 8/1/2014
clear all; close all;

% Load data tables
% Note: the nch and pch data entries generally correspond to dimensions:
% nch(L, VGS, VDS, VSB)
load 180n.mat;
load 180p.mat;

% Find wT
wTn = Lookup(nch, 'GM_CGG', 'GM_ID', 15, 'L', 240e-9, 'W', 158e-6);% 5.2e10
wTp = Lookup(pch, 'GM_CGG', 'GM_ID', 15, 'L', 280e-9, 'W', 644e-6);% 1.1e10

gm = 20e-3;
CGGn = gm/wTn;% 3.8e-13
CGGp = gm/wTp;% 1.8e-12

CGDn = Lookup(nch, 'CGD_CGG', 'GM_ID', 15, 'L', 240e-9, 'W', 158e-6)*CGGn;% 7.5e-14
CGDp = Lookup(pch, 'CGD_CGG', 'GM_ID', 15, 'L', 280e-9, 'W', 644e-6)*CGGp;% 4.19e-13



% Find current density
density_n = Lookup(nch, 'ID_W', 'GM_ID', 15, 'L', 240e-9);
density_p = Lookup(pch, 'ID_W', 'GM_ID', 15, 'L', 280e-9);


