function y = BesselRatioCohen(x,n,ee,nr)

y = (1-n-(2*(n/nr)^2*ee))*besselj(1,x) - (1-(n/nr)^2*ee)*x.*besselj(0,x);
end

