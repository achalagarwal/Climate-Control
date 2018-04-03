function Plot( x,a,steps,maze,start,goal, ptitle )

[N M] = size(maze);

subplot(2,1,1);
% Agent
plot(x(1)+0.5,x(2)+0.5,'sk','MarkerFaceColor','k','MarkerSize',10);
title(ptitle);
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

[mx my] = find(maze);
plot(mx-0.5,my-0.5,'s','MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor',[.5 .5 .5],'MarkerSize',20);
drawnow
hold off
