%% open image
clear all
filename='Prototype_Left';
I = imread(strcat(filename,'.jpeg'));
I=imrotate(I,90);
imshow(I,'Border','tight')
I=I(:,:,1); %using only the red channel

%%identify beads and displaying them as bounded regions
bin=imbinarize(I);
bin=imclearborder(bin);
imshow(bin); %displaying the binarized image
[label,ROI]=bwlabel(bin);
coloredLabel = label2rgb(label, 'hsv', 'k', 'shuffle');
imshow(coloredLabel)
boundedROI=regionprops(label,'BoundingBox');
figure
for i=1:ROI
    displayROI = boundedROI(i).BoundingBox;
    rectangle('Position',displayROI,'LineWidth',3');
end



