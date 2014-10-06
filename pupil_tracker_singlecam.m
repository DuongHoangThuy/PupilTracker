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
%vidObj = VideoReader('vv_0001.avi');       
%vidObj2 = VideoReader('vv_0001.avi');       
vidObj=videoinput('winvideo',1, 'YUY2_640x480');		% Storing the video as an object | input from camera/webcam
%vidObj2 =videoinput('winvideo',1, 'YUY2_640x480');	
%%vidObj=videoinput('winvideo',1,'MJPG_640x480');
%preview(vidObj)
%lastFrame = read(vidObj, inf);
%numFrames = vidObj.NumberOfFrames;
numFrames = 30;								% Number of frames to be captured for analysis to be carried out
figure

for i=1:numFrames 								% X-axis for the plot /  time instants
X(i)=i;
end

   
for i=1:numFrames 								% Iterating pupil detection for every frame  
    %c_initial = clock;							% Measuring the time required to execute the program; add on
    %gr=rgb2gray(read(vidObj,i));
    %gr2=rgb2gray(read(vidObj2,i));
    
    %cropped = imresize(gr, 0.5);					% Incase, the processing time is high, image can be resized 
    %cropped2 = imresize(gr2, 0.5);
    %cropped = imcrop(cropped,[80 10 350 350]);		% Can be cropped if noise or unnecessary objects exist
    im=getsnapshot(vidObj);		
    cropped = im;
    
       
    bw = im2bw(cropped,0.225);					% Thresholding the input frame
    [centersDark, radiiDark] = imfindcircles(bw,[15 30],'ObjectPolarity','dark');		% Approximating pupil to circle ;  deducing centers and radius 
    
    %bw2 = im2bw(cropped2,0.225);					% Thresholding the input frame
    %[centersDark2, radiiDark2] = imfindcircles(bw2,[15 30],'ObjectPolarity','dark');	
    
    if isempty(radiiDark)							% Incase there is no pupil in the present image / eye blink
        radii(i)= 0;				
    else						
        radii(i)=radiiDark(1);							% appending all radii to a list
    end
%{
     if isempty(radiiDark2)							% Incase there is no pupil in the present image / eye blink
        radii2(i)= 0;				
    else						
        radii2(i)=radiiDark2(1);							% appending all radii to a list
     end
%}
    
    
    subplot(2, 1, 1);
    imshow(cropped);							% Display present frame on which detected circle is drawn
    
    text(-20,-30,'Left Eye','HorizontalAlignment','center','BackgroundColor',[.8 .8 .8]);
    %text(350,110,'\rightarrow','HorizontalAlignment','center','BackgroundColor',[.8 .8 .8]);
    viscircles(centersDark,radii(i),'EdgeColor','b');		% Drawing circles for the approximated pupil
    %imwrite(cropped,strcat('F:\op2\',num2str(i),'.jpg'));  	% Incase the frames are to be re-checked
    % imwrite(bw,strcat('F:\op2\',num2str(i),'bw.jpg'));

    %{
    subplot(2, 2, 3);
    imshow(cropped2);

    text(-10,-30,'Right Eye','HorizontalAlignment','center','BackgroundColor',[.8 .8 .8]);
    %text(350,120,'\rightarrow','HorizontalAlignment','center','BackgroundColor',[.8 .8 .8]);
    viscircles(centersDark2,radii2(i),'EdgeColor','b');		
    %}
    
    subplot(2, 1, 2);
    plot(X,radii(i));									% Plot the graph for time instants vs radii
    %linkdata on
    %{						
    c_final = clock;				 
    time=c_final-c_initial;
    time_final = 3600*time(4)+60*time(5)+time(6);
    time_final 
    %}
    %{
    subplot(2, 2, 4);
    plot(X,radii2(i));
    %}
end

subplot(2,1,2);
plot(X,radii);	

%subplot(2,2,4);
%plot(X,radii2);	

