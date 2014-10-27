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
  
vidObj = VideoReader('video002.avi');       	% Storing the video as an object | input from camera/webcam
%numFrames = 100;								% Number of frames to be captured for analysis to be carried out
%numFrames = vidObj.NumberOfFrames;
%figure

figure
imshow(read(vidObj,1));
numFrames=15;
for i=1:numFrames    							% Iterating pupil detection for every frame  
    
    img= read(vidObj,i);
    subplot(2, 1, 1);
    imshow(img);
    cropped=rgb2gray(img);
    %cropped = imresize(gr, 0.5);		
    %imshow(cropped);							% Display present frame on which detected circle is drawn
       
    bw = im2bw(cropped,0.04);					% Thresholding the input frame
    %imshow(bw)
    [centersDark, radiiDark] = imfindcircles(bw,[10 20],'ObjectPolarity','dark');		% Approximating pupil to circle ;  deducing centers and radius 

 if isempty(radiiDark)
     bw = im2bw(cropped,0.05);
     [centersDark, radiiDark] = imfindcircles(bw,[10 20],'ObjectPolarity','dark');		
     if isempty(radiiDark)							% Incase there is no pupil in the present image / eye blink
       radii(i)= 0;	
     
     else						
        radii(i)=radiiDark(1);							% appending all radii to a list
     end
 else
    radii(i)=radiiDark(1);							
 end
     
    viscircles(centersDark,radii(i),'EdgeColor','b');		% Drawing circles for the approximated pupil
    
    %subplot(2,1,2);
    %plot(X,radii(i));
end


for i=1:numFrames 								% X-axis for the plot /  time instants
X(i)=i;
end
  

subplot(2,1,2);
plot(X,radii);	


