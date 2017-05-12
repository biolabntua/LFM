%% Load, preprocess and plot harmonic sample data of f=0.04Hz
% Load sample data
load SampleData

% Noise removal via median filter
StrainN = medfilt1(Strain,9);
StressN = medfilt1(Stress,9);

% Plot recorded sample data
figure()
plot( Time, StressN)
xlabel('Time (sec)')
ylabel('Stress (MPa)')
grid on
%% Fit data to a sine function
% Isolate last 10 cycles where sample has equilibrated. Given the sampling
% frequency and the frequency of the harmonic, total points of the last 10
% cycles are calculated. Time, stress and strain matrices are then
% redefined for curve-fitting to a sine function. Amplitudes of stress and 
% strain harmonics are estimated and magnitude and phase are calculated.

f = 0.04;
fs = 70; 
totalPoints = fs*10/f;
Time_sd = Time(totalPoints:end);
Stress_sd = StressN(totalPoints:end);
Strain_sd = StrainN(totalPoints:end);
[mag,phase,cfStrain,cfStress] = fitToSine(Time_sd,Strain_sd,Stress_sd);
%% Evaluate curve-fitting

fitStrain = cfStrain.a + cfStrain.ampl*sin(2*pi*f*Time_sd + cfStrain.phi);
fitStress = cfStress.a + cfStress.ampl*sin(2*pi*f*Time_sd + cfStress.phi);

figure()
subplot(2,1,1)
plot(Time_sd,Strain_sd,Time_sd,fitStrain)
grid on
ylabel('Strain %')
subplot(2,1,2)
plot(Time_sd,Stress_sd,Time_sd,fitStress)
grid on
xlabel('Time (sec)')
ylabel('Stress (MPa)')


