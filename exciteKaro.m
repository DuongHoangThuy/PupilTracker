% arguments need to be at the end, after source and callbackdata which are
% fixed args: http://stackoverflow.com/questions/9078790/pushbutton-to-change-variable
function exciteKaro(source,callbackdata, a)
  t3 = clock;       % get the time at the start yo
  tnow = clock;
  % the two arguments 'source' and 'callbackdata' are required to be
  % specified otherwise it doesn't work. taken from http://in.mathworks.com/help/matlab/ref/uicontrol.html
  %% first we put the white LED on...
  white = 10;         % connected to PWM pin10
  white_power = 0.1;
  writePWMDutyCycle(a, white, white_power);
  
  %% next we wait for 5 seconds to pass.. and then close the LED..
  while(etime(tnow, t3) < 5.00)
    % do nothing.
    tnow = clock;
  end
  writePWMDutyCycle(a, white, 0);
end