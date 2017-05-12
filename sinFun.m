function y = sinFun(x,a,ampl,phi)

f = 0.04;
omega = 2*pi*f;
y = a + ampl*sin(omega*x + phi);

end