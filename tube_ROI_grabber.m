% this script is based off of Allison's tube ROI grabber
%% open image
clear all
filename='pH';
I = imread(strcat(filename,'.png'));
imshow(I,'Border','tight')

%% analyze it

clear all; close all

filename='pH';
I = imread(strcat(filename,'.png'));
imshow(I,'Border','tight')

height = length(I(:,1,:));
width = length(I(1,:,:));

numtubes = 6;

bead_ROIs = zeros(5,2*numtubes);
sup_ROIs = zeros(4,2*numtubes);

%% beads
imshow(I(:,:,3));%using the blue channel for even bead pellet identification.
title('Draw a 5-point polygonal ROI around the bead for each tube.')
for i = 1:numtubes
    p = drawpolygon('LineWidth',3,'Color','cyan');
    pos = customWait(p);
    bead_ROIs(:,i*2-1:i*2) = pos(:,:);
end

%% supernatant 
imshow(I(:,:,3));%using the blue channel for even bead pellet identification.
title('Draw a 4-point polygonal ROI around the supernatant for tube.')
for i = 1:numtubes
    p = drawpolygon('LineWidth',3,'Color','cyan');
    pos = customWait(p);
    sup_ROIs(:,i*2-1:i*2) = pos(:,:);
end

%% bead & supernatant in colour
figure
imshow(I)
hold on
for i = 1:numtubes
    pgon=polyshape(bead_ROIs(:,i*2-1), bead_ROIs(:,i*2));
    plot(pgon);
    pgon=polyshape(sup_ROIs(:,i*2-1), sup_ROIs(:,i*2));
    plot(pgon);
end
hold off

%% saves coordinates
save(strcat(filename,'_ROIs.mat'),'bead_ROIs','sup_ROIs');

bead_ROIs

%% other stuff I don't understand
function pos = customWait(hROI)

% Listen for mouse clicks on the ROI
l = addlistener(hROI,'ROIClicked',@clickCallback);

% Block program execution
uiwait;

% Remove listener
delete(l);

% Return the current position
pos = hROI.Position;

end

function clickCallback(~,evt)

if strcmp(evt.SelectionType,'double')
    uiresume;
end

end
