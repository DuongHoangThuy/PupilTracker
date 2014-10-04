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
%vidObj = VideoReader('video001.mp4');       
vidObj=videoinput('winvideo',1, 'YUY2_640x480');		% Storing the video as an object | input from camera/webcam
%preview(vidObj)
%lastFrame = read(vidObj, inf);
%numFrames = vidObj.NumberOfFrames;
numFrames = 5;								% Number of frames to be captured for analysis to be carried out

for i=1:numFrames 								% Iterating pupil detection for every frame  
    %c_initial = clock;							% Measuring the time required to execute the program; add on
    %gr=rgb2gray(read(vidObj,i));
    %cropped = imresize(gr, 0.4);					% Incase, the processing time is high, image can be resized 
    %cropped = imcrop(cropped,[80 10 350 350]);		% Can be cropped if noise or unnecessary objects exist
    im=getsnapshot(vidObj);		
    cropped = im;
    imshow(cropped);							% Display present frame on which detected circle is drawn

    bw = im2bw(cropped,0.225);					% Thresholding the input frame
    [centersDark, radiiDark] = imfindcircles(bw,[15 30],'ObjectPolarity','dark');		% Approximating pupil to circle ;  deducing centers and radius 
    if isempty(radiiDark)							% Incase there is no pupil in the present image / eye blink
        radii(i)= 0;				
    else						
        radii(i)=radiiDark;							% appending all radii to a list
    end

    viscircles(centersDark, radiiDark,'EdgeColor','b');		% Drawing circles for the approximated pupil
    %imwrite(cropped,strcat('F:\op2\',num2str(i),'.jpg'));  	% Incase the frames are to be re-checked
    % imwrite(bw,strcat('F:\op2\',num2str(i),'bw.jpg'));

    %{						
    c_final = clock;				 
    time=c_final-c_initial;
    time_final = 3600*time(4)+60*time(5)+time(6);
    time_final 
    %}
end

for i=1:numFrames 								% X-axis for the plot /  time instants
X(i)=i;
end

plot(X,radii);									% Plot the graph for time instants vs radii





