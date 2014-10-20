%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 																 
%    Aim : Pupil detection and diameter plot							 
%    Authors : Sandeep Konam, Dhruv Joshi											 
%    Acknowledgements : Sujeath Pareddy			 
%    Organization : Srujana - Center for Innovation, LVEPI						 	 
%																 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Approach :: Extracting frames -> Thresholding the frame at hand  -> Circle Detection(Pupil Approximation) -> Radius measurement -> Plotting the graph

close all;
clear all;
clc;

vid = videoinput('winvideo', 1,'YUY2_320x240');          % Video Parameters
set(vid,'ReturnedColorSpace','grayscale');      % acquire in greyscale
triggerconfig(vid, 'manual');					% manual trigger, increase speed

start(vid);                                     % start acquiring from imaqwindow
gcf = figure;                                   % figure

set(gcf,'CloseRequestFcn',@my_closefcn)			% this is incomplete
hold on;										% image will persist
closeflag = 1;                                  % for now this doesn't really do anythng

while(closeflag)                                % infinite loop
    %% first we acquire the feed
    acquired_snapshot = getsnapshot(vid);       % acquire single image from feed
    cropped_snapshot = imcrop(acquired_snapshot,[85 50 140 112]);   % crop it out so that you can see just the center
    subplot(1,2,1), imshow(cropped_snapshot);  % normal camera (greyscale)
    
    %% Then we threshold it to some value of threshold to be able to get the pupil out
    thresholded_image = im2bw(cropped_snapshot,0.37);   % threshold karo... this value has been obtained after playing around
    subplot(1,2,2), imshow(thresholded_image);  % display the image
    pause(0.001);                               % much less than 30 fps. wihtout this it doesn't seem to work
    
    %% next we want to be able to crop out the unnecessary part of the image, keep only the center so we can perform a circle search...
    
end% Preview