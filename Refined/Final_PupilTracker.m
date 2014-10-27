%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                %  
%    Aim : Pupil detection and radius vs time plot               %				 
%    Authors : Sandeep Konam, Dhruv Joshi						 %					 
%    Acknowledgements : Sujeath Pareddy, Sanketh Vedula          %
%    Organization : Srujana - Center for Innovation, LVEPI		 %				 	 
%																 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Approach : Extracting frames -> Hard Thresholding the frame at hand  -> cropping out excess -> Circle Detection(Pupil Approximation) -> Radius measurement -> Plotting the graph
% to be able to see the two feeds (greyscale and thresholded) simultaneously, uncomment the subplot part.

close all;
clear all;
clc;

%% Initializing Variables
t = 0;                                    % initialize time | x-axis for the graph 
pointsArray = [];                         % creating an appendable empty array | To append time(x-axis) and radius(y-axis)
frameCount = 0;                           % For the purpose of couting the processed frames
%% declare the video object
vid = videoinput('winvideo', 2,'YUY2_320x240');          % Video Parameters
%vid = videoinput('winvideo', 1,'YUY2_320x240');          % Video Parameters
% Print out the properties of the webcam. 
src = getselectedsource(vid);
get(src)

set(vid,'ReturnedColorSpace','grayscale');      % acquire in greyscale
triggerconfig(vid, 'manual');					% manual trigger, increase speed

start(vid);                                     % start acquiring from imaqwindow
figure                                          % figure
% 
t1 = clock;                                     % Base time for the x-axis
numFrames=300;
while(frameCount<numFrames)                     % Loop runs till the required number of frames are processed
      
    %% first we acquire the feed and crop out unrequired parts to speed it all up
    acquired_snapshot = getsnapshot(vid);       % acquire single image from feed
    cropped_snapshot = imcrop(acquired_snapshot,[110 30 130 110]);   % crop it out so that you can see just the center ref: http://www.mathworks.in/help/images/ref/imcrop.html
    subplot(1,2,1),imshow(cropped_snapshot);  % normal camera (grayscale)
    
    %% Then we threshold it to some value of threshold to be able to get the pupil out
    thresholded_image = im2bw(cropped_snapshot,0.37);   % Hard thresholding the threshold being 0.37
    %subplot(1,2,2),         imshow(thresholded_image);  % display the image
        
    %% next we extract circles from this baby...and plot them if they are found
    [centers, radii] = imfindcircles(thresholded_image,[10 20], 'ObjectPolarity','dark');
    %'Sensitivity',0.91); 
    if ~isempty(centers)                            % plot only if circle is detected.. ~ is logical not. simple error handling for viscircles
      viscircles(centers, radii,'EdgeColor','b', 'LineWidth', 1);
      
      y = radii(1);                                 % radii(1) is the first returned radius, converted to y-variable
      t2 = clock;                                   % finding out the time elapsed
      drawnow
      subplot(1,2,2);
      hold on;                                      % this will let us see the previous values also by rapidly auto-changing the x-axis i.e plot won't refresh new values will plotted on the same plot
      
      pointsArray = [pointsArray;[etime(t2,t1),y]]  % appending the array with the new entries ; etime -> difference in time
      if t == 0
         plot(pointsArray(t+1),pointsArray(t+1,2), 'linewidth',1.0),xlabel('time in sec'),ylabel('Pupil radius'); %pllotting the points by taking the value from the array
      end
       if t ~= 0 
           plot(pointsArray(t:t+1),pointsArray(t:t+1,2), 'linewidth',1.0),xlabel('time in sec'),ylabel('Pupil radius')
       end
       t = t + 1;                                   % t just counts the iterations
    end
    frameCount=frameCount+1;                        % Counting the frames
end

if(frameCount==numFrames)
    delete(vid);                                    % Deleting the video object, once the graph is plotted
end
