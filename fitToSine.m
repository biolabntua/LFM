function [magnitude,phase,coefStrain,coefStress] = fitToSine(Time_sd,Strain_sd,Stress_sd)
% This function fits a sine function, a + b*sin(w*t + ?), to experimental
% data, in order to estimate the amplitudes and phases of strain and
% stress.

x = Time_sd;
y = Strain_sd;
z = Stress_sd;

Options = fitoptions('Method','NonlinearLeastSquares','Lower',[-Inf, -Inf,...
    -pi],'Upper',[Inf, Inf, pi]);
ft = fittype('sinFun(x,a,ampl,phi)');
coefStrain = fit( x, y, ft, Options);
coefStress = fit( x, z, ft, Options);

magnitude = db(coefStress.ampl/coefStrain.ampl);
phase = rad2deg(coefStress.phi - coefStrain.phi);
end