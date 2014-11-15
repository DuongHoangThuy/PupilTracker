% arguments need to be at the end, after source and callbackdata which are
% fixed args: http://stackoverflow.com/questions/9078790/pushbutton-to-change-variable
% the two arguments 'source' and 'callbackdata' are required to be
% specified otherwise it doesn't work. taken from http://in.mathworks.com/help/matlab/ref/uicontrol.html
function exciteKaro(source,callbackdata)
  % since asynchronous multithreaded work on MATLAB is not possible, we
  % will simply use serial communication to arduino and write the functions
  % on the arduino. http://arduino.stackexchange.com/questions/140/how-can-i-communicate-from-arduino-to-matlab
  s = serial('COM10');      % serial communication object, change com port as needed
  fopen(s);                 % open the serial port for comm
  fprintf(s, 'w');          % single character to communicate white LED should be turned on*
end