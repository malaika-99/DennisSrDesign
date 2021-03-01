%this is the preliminary code to take in image from raspberry pi
r = raspi;
cam = cameraboard;
for k = 1:10
    img = snapshot(cam);
end
