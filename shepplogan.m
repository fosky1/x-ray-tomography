% Shepp-Logan reconstruction
clear;
clc;

n = 512; % Number of pixels
P = phantom('Shepp-Logan', n);
PM = phantom('Modified Shepp-Logan', n);

% Display the Shepp-Logan and Modified Shepp-Logan phantoms
figure;
subplot(1, 2, 1);
imshow(P, []);
title('Shepp-Logan');
subplot(1, 2, 2);
imshow(PM, []);
title('Modified Shepp-Logan');

theta = 0:179; % Range of angles for the Radon transform

% Compute the Radon transform for Shepp-Logan phantom
[RP, xP] = radon(P, theta);

% New y-axis range
yMin = -100;
yMax = 100;
yScale = linspace(yMin, yMax, size(RP, 1)); % Number of points as the size of the row of RP

% Display the Radon transform for Shepp-Logan phantom
figure;
imshow(RP', [], 'XData', yScale, 'YData', theta, 'InitialMagnification', 'fit');
xlabel('x''');
ylabel('\theta (degrees)');
colormap(gca, hot);
colorbar;
title('Radon Transform of Shepp-Logan Phantom');

% Compute the Radon transform for Modified Shepp-Logan phantom
[RPM, xPM] = radon(PM, theta);

yScalePM = linspace(yMin, yMax, size(RPM, 1));

% Display the Radon transform for Modified Shepp-Logan phantom
figure;
imshow(RPM', [], 'XData', yScalePM, 'YData', theta, 'InitialMagnification', 'fit');
xlabel('x''');
ylabel('\theta (degrees)');
colormap(gca, hot);
colorbar;
title('Radon Transform of Modified Shepp-Logan Phantom');

% Reconstruction using iradon for Shepp-Logan phantom
reconP1 = iradon(RP, theta);
reconP2 = iradon(RP, theta, 'linear', 'Ram-Lak');

figure;
subplot(1, 2, 1);
imshow(reconP1, []);
title('Filtered Backprojection');
subplot(1, 2, 2);
imshow(reconP2, []);
title('Unfiltered Backprojection');

% Reconstruction using iradon for Modified Shepp-Logan phantom
reconPM1 = iradon(RPM, theta);
reconPM2 = iradon(RPM, theta, 'linear', 'Ram-Lak');

figure;
subplot(1, 2, 1);
imshow(reconPM1, []);
title('Filtered Backprojection');
subplot(1, 2, 2);
imshow(reconPM2, []);
title('Unfiltered Backprojection');