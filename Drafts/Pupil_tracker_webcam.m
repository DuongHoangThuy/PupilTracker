%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 																 
%    Aim : Pupil Detection - Latency measurement							 
%    Author : Sandeep Konam											 
%    Collaborators : Ayush Sagar, Dhruv Joshi, Sanketh Vedula					 
%    Organization : Srujana Innovation Center, LVEPI						 	 
%																 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Approach :: Extracting frames -> Thresholding the frame at hand  -> Circle Detection(Pupil Approximation) -> Radius measurement -> Plotting the graph

close all;
clear all;
clc;

%% Extracting Frames
  
vidObj=videoinput('winvideo',1, 'YUY2_640x480');		% Storing the video as an object | input from camera/webcam
numFrames = 5;								% Number of frames to be captured for analysis to be carried out
figure

for i=1:numFrames 								% X-axis for the plot /  time instants
X(i)=i;
end
   
for i=1:numFrames 								% Iterating pupil detection for every frame  
    
    cropped=getsnapshot(vidObj);	
       
    subplot(2, 1, 1);
    imshow(cropped);							% Display present frame on which detected circle is drawn
       
    bw = im2bw(cropped,0.225);					% Thresholding the input frame
    [centersDark, radiiDark] = imfindcircles(bw,[15 30],'ObjectPolarity','dark');		% Approximating pupil to circle ;  deducing centers and radius 
     
    if isempty(radiiDark)							% Incase there is no pupil in the present image / eye blink
        radii(i)= 0;				
    else						
        radii(i)=radiiDark(1);							% appending all radii to a list
    end
    
    viscircles(centersDark,radii(i),'EdgeColor','b');		% Drawing circles for the approximated pupil
    
    subplot(2,1,2);
    plot(X,radii(i));
end

subplot(2,1,2);
plot(X,radii);	


