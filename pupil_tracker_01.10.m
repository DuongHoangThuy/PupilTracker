close all;
clear all;
clc;

% Extracting Frames
%vidObj = VideoReader('video001.mp4');       % Storing the video as an object
vidObj=videoinput('winvideo',1, 'YUY2_640x480');
%preview(vidObj)

%lastFrame = read(vidObj, inf);
%numFrames = vidObj.NumberOfFrames;
numFrames = 5;

for i=1:numFrames  %1:numFrames    %:numFrames  
    %c_initial = clock;
    %gr=rgb2gray(read(vidObj,i));
    %cropped = imresize(gr, 0.4);
    %cropped = imcrop(cropped,[80 10 350 350]);
    im=getsnapshot(vidObj);
    cropped = im;
    imshow(cropped);

    bw = im2bw(cropped,0.225);
    [centersDark, radiiDark] = imfindcircles(bw,[15 30],'ObjectPolarity','dark');
    if isempty(radiiDark)
        radii(i)= 0;
    else
        radii(i)=radiiDark;
    end
    viscircles(centersDark, radiiDark,'EdgeColor','b');
    imwrite(cropped,strcat('F:\op2\',num2str(i),'.jpg'));
    imwrite(bw,strcat('F:\op2\',num2str(i),'bw.jpg'));
    %{
    c_final = clock;
    time=c_final-c_initial;
    time_final = 3600*time(4)+60*time(5)+time(6);
    time_final 
    %}
end

for i=1:numFrames 
X(i)=i;
end

plot(X,radii);





