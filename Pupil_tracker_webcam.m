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
    acquired_snapshot = getsnapshot(vid);       % acquire single image from feed
    subplot(1,2,1), imshow(acquired_snapshot);  % normal camera (greyscale)
    
    thresholded_image = im2bw(acquired_snapshot,0.37);   % threshold karo... this value has been obtained after playing around
    subplot(1,2,2), imshow(thresholded_image);  % display the image
    pause(0.001);                               % much less than 30 fps. wihtout this it doesn't seem to work
    
    
end% Preview