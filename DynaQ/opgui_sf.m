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
sizes.NumInputs      = 8;
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
     fanlight = findobj(fig,'Tag','radiobutton1');
       heaterlight = findobj(fig,'Tag','radiobutton2');
      external = findobj(fig,'Tag','edit8');
       current = findobj(fig,'Tag','edit6');
       desired = findobj(fig,'Tag','edit7');
       
       set(external,'String',round(u(5),1));
       set(current,'String',round(u(3),1));
       set(desired,'String',round(u(4),1));
      
      hexternal = findobj(fig,'Tag','edit18');
       hcurrent = findobj(fig,'Tag','edit16');
       hdesired = findobj(fig,'Tag','edit17');
       set(hexternal,'String',round(u(6),1));
       set(hcurrent,'String',round(u(7),1));
       set(hdesired,'String',round(u(8),1));
       heater = findobj(fig,'Tag','edit3');
       fan = findobj(fig,'Tag','editbox');
       set(heater,'String',round(u(1),0));
       set(fan,'String',round(abs(u(2)),0));
       round(abs(u(2)),0)
       
    if u(1)>0.5,
       set(heaterlight,'Value',1);
    else 
        set(heaterlight,'Value',0);
    end
    if u(2)<-0.5
       set(fanlight,'Value',1);
    else
               set(fanlight,'Value',0);
    end
 
end
% end mdlUpdate

function sys = mdlOutputs(t,x,u)

 sys = [];
% end mdlOutputs

