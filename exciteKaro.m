function exciteKaro(source,callbackdata, a)
  % the two arguments 'source' and 'callbackdata' are required to be
  % specified otherwise it doesn't work. taken from http://in.mathworks.com/help/matlab/ref/uicontrol.html
  % a = arduino();
  white = 10;         % connected to PWM pin10
  white_power = 0.1;
  writePWMDutyCycle(a, white, white_power);
end