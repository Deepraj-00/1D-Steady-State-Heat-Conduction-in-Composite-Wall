% Input parameters
L1 = 1; % (m) (Material 1)
L2 = 1; % (m) (Material 2)
K1 = 400; % (W/m*k) (Thermal conductivity of material 1)
K2 = 200; % (W/m*k) (Thermal conductivity of material 2)
M1 = 5; % No. of sections / grid spacings in domain
M2 = 5; % No. of sections / grid spacings in domain
dx1 = L1/M1; % Segment length
dx2 = L2/M2; % Segment length
TA = 1000; % Temperature at left end in Celsius
TC = 100; % Temperature at right end in Celsius

%TB estimation
TB = (((K1/L1)*TA)+((K2/L2)*TC))/((K1/L1)+(K2/L2));

N1 = M1 - 1; % No. of points in domain 1
N2 = M2 - 1; % No. of points in domain 2

%Domain 1
X1 = zeros(N1,N1);
for i = 1:N1
    X1(i,i) = -2;
end
for i = 1:N1-1
    X1(i,i+1) = 1;
    X1(i+1,i) = 1;
end

B1 = zeros(N1,1);
B1(1,1) = -TA;
B1(N1,1) = -TB;

T1 = X1\B1;

% Domain 2
X2 = zeros(N2,N2);
for i = 1:N2
    X2(i,i) = -2;
end
for i = 1:N2-1
    X2(i,i+1) = 1;
    X2(i+1,i) = 1;
end

B2 = zeros(N2,1);
B2(1,1) = -TB;
B2(N2,1) = -TC;

T2 = X2\B2;

% Combine temperature distributions
T_combined = [T1; T2];

% Create x-coordinates for plotting
x = linspace(0, L1+L2, N1+N2+1);

% Plot the temperature distribution
figure;
imagesc(x, 1, T_combined');
colorbar;
xlabel('Position (m)');
ylabel('Temperature (°C)');
title('Temperature Distribution along the Material');

% Set axis limits
xlim([0, L1+L2]);