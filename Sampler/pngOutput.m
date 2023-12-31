clear % Recomended for mistake prevention
clc % Clear output window

% Replace this with your plot

% Set high resolution for the plot
set(gcf,'renderer','Painters'); % Set renderer for better vector graphics
set(gcf,'color','w'); % Set background color
set(gca, 'FontSize', 12); % Set font size for better readability

% Save the plot as an image with high resolution
print('Image_Name','-dpng','-r4000'); % Adjust resolution by changing '-r4000' (4000 DPI)