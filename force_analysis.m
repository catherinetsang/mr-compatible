close all
clear all
clc

%% INPUTS
theta_deg   = (10:5:30); % [deg]
Mwrist      = (0:8); % [N/m]
FoS         = 8; % factor of safety for Mwrist

%% CALCULATION
Mwrist  = Mwrist./FoS;
theta = theta_deg * pi/180;

AC_female = 59e-3; % [m] 5th percentile female
AC_male =   78e-3; % [m] 95th percentile male

Fband_female_hand   = zeros(length(theta),length(Mwrist));
Farm_female_hand    = zeros(length(theta),length(Mwrist));
Fband_male_hand     = zeros(length(theta),length(Mwrist));
Farm_male_hand      = zeros(length(theta),length(Mwrist));

for i = 1:length(theta)
    for j = 1:length(Mwrist)
        Fband_female_hand(i,j)  = Mwrist(j)/(2*sin(theta(i))*AC_female);
        Farm_female_hand(i,j)   = 2*Fband_female_hand(i,j)*cos(theta(i));
        Fband_male_hand(i,j)    = Mwrist(j)/(2*sin(theta(i))*AC_male);
        Farm_male_hand(i,j)     = 2*Fband_male_hand(i,j)*cos(theta(i));
    end
end


Fband_female_hand   = Fband_female_hand./4.45; % N to lbs
Farm_female_hand    = Farm_female_hand./4.45; % N to lbs
Fband_male_hand     = Fband_male_hand./4.45; % N to lbs
Farm_male_hand      = Farm_male_hand./4.45; % N to lbs

%% PLOT

fig = figure();

subplot(2,1,1)
[c,h] = contourf(Mwrist,theta_deg,Farm_female_hand,[2:5],'ShowText','on');
title('F_a_r_m for 5th Percentile Female (lbs)')
xlabel('Mwrist (Nm)')
ylabel('theta (deg)')

h.LevelList = round(h.LevelList,0);  % rounds levels to 3rd decimal place
clabel(c,h)

subplot(2,1,2)
[c,h] = contourf(Mwrist,theta_deg,Farm_female_hand,[2:5],'ShowText','on');
title('F_a_r_m for 95th Percentile Male (lbs)')
xlabel('Mwrist (Nm)')
ylabel('theta (deg)')

h.LevelList = round(h.LevelList,0);  % rounds levels to 3rd decimal place
clabel(c,h)

%%
% syms theta fband
% eq1 = fband.*cos(theta) == farm;
% eq2 = fband.*sin(theta).*AC == Mwrist;
% vars = [theta, fband];
% [theta_sym,fband_sym] = solve(eq1,eq2,vars);
% theta_sym = double(theta_sym(2))
% fband_sym = double(fband_sym(2))