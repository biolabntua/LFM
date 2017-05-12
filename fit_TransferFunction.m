clear all
clc
%% BODE PLOT OF EXPERIMENTAL DATA
%% Load sample frequency data
load FreqData

%% Plot experimental bode
figure()
ax1 = subplot(2,1,1);
semilogx(w,PBSampl1,'--o')
grid on
ylabel('Magnitude (dB)')
ax2 = subplot(2,1,2);
semilogx(w,PBSph1,'--o')
grid on
xlabel('Frequency (rad/sec)')
ylabel('Phase (deg)')
ylim(ax1,[0 30])
xlim(ax1,[1e-03 10])
xlim(ax2,[1e-03 10])

%% SYSTEM IDENTIFICATION
%% Create an idfrd object using the experimental frequency response data
ampl = db2mag(PBSampl1);
h_exp = ampl.*exp(1i*PBSph1*pi/180);
resp_exp = idfrd( h_exp, w, 0); 

%% Define number of poles (np) and zeros (nz) of desired transfer function (sys)
np = 1;
nz = 1;
opt = tfestOptions('SearchMethod','lsqnonlin');
sys = tfest(resp_exp, np, nz, opt); 

%% Extract zero, pole and gain from the estimated transfer function
[z, p, gain] = zpkdata(sys);
zero = -cell2mat(z);
pole = -cell2mat(p);

%% Evaluate estimated transfer function
w2 = logspace(-3,1,100); 
[magn,phasen] = bode(sys,w2);    
mag1 = squeeze(magn);
mag = mag2db(mag1);
phas = squeeze(phasen);

figure()
ax1 = subplot(2,1,1);
semilogx(w,PBSampl1,'--o')
hold on
semilogx(w2,mag)
grid on
ylabel('Magnitude (dB)')
ax2 = subplot(2,1,2);
semilogx(w,PBSph1,'--o')
hold on
semilogx(w2,phas)
grid on
xlabel('Frequency (rad/sec)')
ylabel('Phase (deg)')
ylim(ax1,[0 30])
xlim(ax1,[1e-03 10])
xlim(ax2,[1e-03 10])
