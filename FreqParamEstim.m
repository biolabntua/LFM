%% PARAMETER ESTIMATION VIA FREQUENCY-DOMAIN RESPONSE
%% Transversely Isotropic Biphasic(TIB) Model
pz = pole./zero;

eRatio = 1;
nRatio = 1;
c1 = pz-1;

% Estimation of E1 and E3
E3 = gain./pz;
E1 = eRatio*E3;

nsM = linspace(0,0.499,300);
a1M = 0*nsM;
A1M = 0*nsM;
opts = optimoptions('fsolve','Display','off');
for ct = 1:length(nsM)
    a1M(ct) = fsolve(@(x)BesselRatioCohen(x,nsM(ct),eRatio,nRatio),2,opts);
end
D1 = 1-nsM-(2*((nsM/nRatio).^2)*eRatio);
D2 = (1-(((nsM/nRatio).^2)*eRatio))./(1+nsM);
D3 = (1-(2*((nsM/nRatio).^2))).*D2./D1;
C1M = (eRatio*D3)./(((D2.*a1M).^2)-(D1./(1+nsM))); 

% Calculate intersection points to estimate v21
for itep = 1:length(c1)
    tempc1 = c1(itep)*ones(length(nsM));
    L = InterX([nsM;C1M],[nsM;tempc1]);
    v21(itep) = L(1);
end

% Estimation v31
v31 = v21./nRatio;

% Calculation of a1(v21) in order to estimate permeability,k
for ii = 1:length(v21)
    a1(ii) = fsolve(@(x)BesselRatioCohen(x,v21(ii),eRatio,nRatio),2);
end
D11 = 1-v21-(2*(v31.^2)*eRatio);
C11 = (E1.*(1-v21.^2*eRatio))./(D11.*(1+v21));
k = 1000*(2.25*pole)./((a1.^2).*C11);
