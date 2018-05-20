function PlotMaze( x,maze,start,goal )

[N, M] = size(maze);
N = N*20;
M = M*20;

%% The big picture

subplot(2,5,[4 5]);
% Agent
plot(x(1)+0.5,x(2)+0.5,'sk','MarkerFaceColor','k','MarkerSize',10);
title('Full view');
% Create axes
set(gca,'YTick',-M/2:M/2,'YGrid','on',...
    'XTick',-N/2:N/2,...
    'XGrid','on',...
    'XTickLabel',[],...
    'YTickLabel',[],...            
    'PlotBoxAspectRatio',[N M 1],...
    'GridLineStyle','-',...
    'DataAspectRatio',[1 1 1]);


% Uncomment the following line to preserve the X-limits of the axes
xlim(gca,[-N/2 N/2]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(gca,[-M/2 M/2]);
box(gca,'on');
hold on

text(start(1)+0.3,start(2)+0.5,'S','FontName','Courier New');
text(goal(1)+0.3,goal(2)+0.5,'G','FontName','Courier New');

[mx, my] = find(maze);
plot(mx-0.5,my-0.5,'s','MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor',[.5 .5 .5],'MarkerSize',20);
drawnow
hold off

%% Zoomed in
subplot(2,5,[9 10]);
% Agent
plot(x(1)+0.5,x(2)+0.5,'sk','MarkerFaceColor','k','MarkerSize',10);
title('Zoomed in');
% Create axes
set(gca,'YTick',-15:15,'YGrid','on',...
    'XTick',-15:15,...
    'XGrid','on',...
    'XTickLabel',[],...
    'YTickLabel',[],...            
    'PlotBoxAspectRatio',[N M 1],...
    'GridLineStyle','-',...
    'DataAspectRatio',[1 1 1]);


% Uncomment the following line to preserve the X-limits of the axes
xlim(gca,[-15 15]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(gca,[-15 15]);
box(gca,'on');
hold on

text(goal(1)+0.3,goal(2)+0.5,'G','FontName','Courier New');

[mx, my] = find(maze);
plot(mx-0.5,my-0.5,'s','MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor',[.5 .5 .5],'MarkerSize',20);
drawnow
hold off
