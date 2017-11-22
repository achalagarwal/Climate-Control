%Nitin skandan, 11-Aug-2011
% This is the s function which passes data from model to GUI
function [sys,x0,str,ts] = opgui_sf(t,x,u,flag,Ts)
%Control GUI for DRS

%   Nitin Skandan 27-1-2011
switch flag,
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes(Ts); 
  case 2,
    sys=mdlUpdate(t,x,u,Ts);
  case 3,
    sys = mdlOutputs(t,x,u); % Calculate outputs
  case { 1, 4, 9 },
    sys = [0 0 0 0];
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
% end drs_switch

function [sys,x0,str,ts]=mdlInitializeSizes(Ts)

% call simsizes for a sizes structure, fill it in and convert to a sizes array.
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 1;
sizes.NumOutputs     = 0;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
x0  = [0];
str = [];
ts  = [Ts 0];
% create the figure, if necessary
OpGUI;
% end mdlInitializeSizes

function sys=mdlUpdate(t,x,u,Ts)
fig = get_param(gcbh,'UserData'); %get figure handle
sys=x;
if ishandle(fig), % 
  if strcmp(get(fig,'Visible'),'on'),
      
      chnd = findobj(fig,'Tag','editbox'); % get handle to editbox
      str = floor(u(1)); 
      if num2str(str)
          set(chnd, 'String', str) ; %set value of editbox
      else
          set(chnd,'String','NA') ; %set value of editbox
      end

      y = [ 0 1]*u(2) ; %generate data to plot 
      x = [ 0 1]*t ;
      
      chnd = findobj(fig,'Tag','plotx'); % find handle of plot object
      plot(chnd, x, y);        % plot    
      set(chnd, 'XLim', [0 5]) ;
      set(chnd, 'YLim', [0 5]) ;       
      set(chnd,'Tag','plotx') ; % Tag seems to be set to NULL after every plot, so this line is needed
  end
end
% end mdlUpdate

function sys = mdlOutputs(t,x,u)

 sys = [];
% end mdlOutputs

