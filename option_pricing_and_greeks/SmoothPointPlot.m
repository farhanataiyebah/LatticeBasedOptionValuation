% Create the original knot points.
xInitial = [1.6 1.1 .6 .1 .4 .9 1.4 1.9];
yInitial = [1 1.5 2 2.5 3 3.5 4 4.5];
lengthX = length(xInitial);
% flip sideways so there is only 1 y for every x
x = yInitial;
y = xInitial;
% Plot it and show how the line has sharp bends.
plot(x, y, '-sr', 'LineWidth', 2);
grid on;
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
% Use splines to interpolate a smoother curve,
% with 10 times as many points,
% that goes exactly through the same data points.
samplingRateIncrease = 10;
newXSamplePoints = linspace(min(x), max(x), lengthX * samplingRateIncrease);
smoothedY = spline(x, y, newXSamplePoints);
% Now flip back
ySmooth = newXSamplePoints;
xSmooth = smoothedY;
% Plot smoothedY and show how the line is
% smooth, and has no sharp bends.
hold on; % Don't destroy the first curve we plotted.
plot(newXSamplePoints, smoothedY, '-ob');
title('Spline Interpolation Demo', 'FontSize', 20);
legend('Original Points', 'Spline Points');
figure;
plot(xInitial, yInitial, '-sr', 'LineWidth', 2);
% Plot smoothedY and show how the line is
% smooth, and has no sharp bends.
hold on; % Don't destroy the first curve we plotted.
plot(xSmooth, ySmooth, '-ob');
grid on;