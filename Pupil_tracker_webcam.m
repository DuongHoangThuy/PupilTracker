%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 																 
%    Aim : Pupil detection and diameter plot							 
%    Authors : Dhruv Joshi											 
%    Acknowledgements : Sujeath Pareddy, Sandeep Konam
%    Organization : Srujana - Center for Innovation, LVEPI						 	 
%																 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Approach :: Extracting frames -> Thresholding the frame at hand  -> cropping out excess -> Circle Detection(Pupil Approximation) -> Radius measurement -> Plotting the graph
% to be able to see the two feeds (greyscale and thresholded) simultaneously, uncomment the subplot part.

close all;
clear all;
clc;

pointsArray = [];                         % creating an appendable empty array

%% open the arduino object. Setup all the arduino stuff (including fixed brightness for IR LEDs and white LED
a = arduino();
ir_brightness = 0.8;    % this needs to be in the range (0,1). This value is optimized for our specific case
ir = 9;
white = 10;         % connected to PWM pin10
white_power = 0.1;

% writing to the LED via PWM...
writePWMDutyCycle(a, ir, ir_brightness);

%% declare the video object
vid = videoinput('winvideo', 1,'YUY2_320x240');          % Video Parameters

% next we print out the properties of the webcam. 
src = getselectedsource(vid);
get(src)

set(vid,'ReturnedColorSpace','grayscale');      % acquire in greyscale
triggerconfig(vid, 'manual');					% manual trigger, increase speed

start(vid);                                     % start acquiring from imaqwindow
gcf = figure;                                   % figure

set(gcf,'CloseRequestFcn',@my_closefcn)			% this is incomplete
hold on;										% image will persist
closeflag = 1;                                  % for now this doesn't really do anythng

%% the following variables will be used to measure the time
t1 = clock;                                     % initialize time
t = 0;                                                   

while(closeflag)                                % infinite loop
    %% first we acquire the feed and crop out unrequired parts to speed it all up
    acquired_snapshot = getsnapshot(vid);       % acquire single image from feed
    cropped_snapshot = imcrop(acquired_snapshot,[110 30 130 110]);   % crop it out so that you can see just the center ref: http://www.mathworks.in/help/images/ref/imcrop.html
    subplot(1,2,1),         imshow(cropped_snapshot);  % normal camera (greyscale)
    
    %% Then we threshold it to some value of threshold to be able to get the pupil out
    thresholded_image = im2bw(cropped_snapshot,0.30);   % threshold karo... this value has been obtained after playing around
    % subplot(1,2,2),         imshow(thresholded_image);  % display the image
        
    %% next we extract circles from this baby...and plot them if they are found
    [centers, radii] = imfindcircles(thresholded_image,[10 20], 'ObjectPolarity','dark','Sensitivity',0.85); 
    
    if ~isempty(centers)                        % plot only if circle is detected.. ~ is logical not. simple error handling for viscircles
      viscircles(centers, radii,'EdgeColor','b', 'LineWidth', 1);
      % disp(radii(1))                          % just seeing radii range
      % all the plotting...
      y = radii(1);                              % radii(1) is the first returned radius, converted to y-variable
      t2 = clock;                               % finding out the time elapsed
      drawnow
      subplot(1,2,2);
      hold on;                                  % this will let us see the previous values also by rapidly auto-changing the x-axis i.e plot won't refresh new values will plotted on the same plot
      
      pointsArray = [pointsArray;[etime(t2,t1)*1000, y]]      % appending the array with the new entries
       if t == 0
         plot(pointsArray(t+1),pointsArray(t+1,2), 'linewidth',1.0),xlabel('time in 10ms'),ylabel('Pupil radius'); %pllotting the points by taking the value from the array
       end
       if t ~= 0 
           plot(pointsArray(t:t+1),pointsArray(t:t+1,2), 'linewidth',1.0),xlabel('time in 10ms'),ylabel('Pupil radius');%should work on this part this should give lines
           % plot(pointsArray(t),pointsArray(t+1,2), 'linewidth',1.0);
       end
       t = t + 1;                               % t just counts the iterations
    end
   
    pause(0.001);                               % much less than 30 fps. wihtout this it doesn't seem to work
end% Preview
