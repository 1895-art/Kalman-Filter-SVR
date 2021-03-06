%% 模拟一段运动轨迹
% 三条直线通过两个圆弧连接，目标匀速运动
% 返回时刻、径向距离、方位角和径向速度
function  [time, measure] = S_Trajectory()       
    target.v = 10;      % 10m/s
    target.a = 2;       % 2m/(s^-2)
    target.j = 0.5;
    target.dt = 0.05;   % 0.05s
    target.heading = [];
    target.maneuver = 'CJ'; % CV:constant Velocity
                            % CA:constant Acceleration
                            % CJ:constant Jerk
                            % GS:go-and-stop
    turning = [];
    % 1
    start.x = 10;
    start.y = 10;
    ends.x = 40;
    ends.y = 10;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = m; 
    turning = [turning,length(measure)];
    % 2
    org.x = 40;
    org.y = 20;
    [m, target, start] = GenerateArc(org, start, 0, pi, target);
    measure = [measure, m];
    turning = [turning,length(measure)];
%     measure = m;
    
    % 3
    ends.x = 10;
    ends.y = 30;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    turning = [turning,length(measure)];
    
    % 4
    org.x = 10;
    org.y = 40;
    [m, target, start] = GenerateArc(org, start, 1, pi, target);
    measure = [measure, m];
    turning = [turning,length(measure)];
    
%     target.j = target.j * -10;
    % 5
    ends.x = 40;
    ends.y = 50;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    turning = [turning,length(measure)];
    
    % 6
    org.x = 40;
    org.y = 60;
    [m, target, start] = GenerateArc(org, start, 0, pi, target);
    measure = [measure, m];
    turning = [turning,length(measure)];
    
    % 7
    ends.x = 10;
    ends.y = 70;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    turning = [turning,length(measure)];
    
    % 8
    org.x = 10;
    org.y = 80;
    [m, target, start] = GenerateArc(org, start, 1, pi, target);
    measure = [measure, m];
    turning = [turning,length(measure)];
    
    % 9
    ends.x = 30;
    ends.y = 90;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    turning = [turning,length(measure)];
    
    time = (1:size(measure,2)).* target.dt;
    
    if(0)
        % 绘制轨迹及径向速度
        close all;
        figure;
        R = 1;
        A = 2;
        V = 3;
        plot(measure(R,:).*sin(measure(A,:)),measure(R,:).*cos(measure(A,:)),'.b','linewidth',0.5);
        if(0)
            hold on;
            for i=1:2:size(measure,2)
                x1 = measure(R,i) * sin(measure(A,i));
                y1 = measure(R,i) * cos(measure(A,i));
                x2 = x1 + measure(V,i)*sin(measure(A,i));
                y2 = y1 + measure(V,i)*cos(measure(A,i));
                plot([x1,x2],[y1,y2],'r-.');
                hold on;
            end
        end
        for i=1:length(turning)
            idx = turning(i);
            x = measure(R,idx) * sin(measure(A,idx));
            y = measure(R,idx) * cos(measure(A,idx));
            s = sprintf('\\downarrow%d',idx);
            text(x,y+4,s,'color','red','fontsize',13);
        end
        title('模拟目标轨迹');
        axis equal;
        axis([0,120,0,120]);
        grid on;
        xlabel('X/m');
        ylabel('Y/m');
        legend('轨迹','径向速度');
    end
    
     if(0)
        % 绘制轨迹及径向速度
        close all;
        figure;
        R = 1;
        A = 2;
        V = 3;
        plot(measure(R,:).*sin(measure(A,:)),measure(R,:).*cos(measure(A,:)),'.b','linewidth',0.5);
        hold on;
        for i=1:2:size(measure,2)
            x1 = measure(R,i) * sin(measure(A,i));
            y1 = measure(R,i) * cos(measure(A,i));
            x2 = x1 + measure(V,i)*sin(measure(A,i));
            y2 = y1 + measure(V,i)*cos(measure(A,i));
            plot([x1,x2],[y1,y2],'r');
            hold on;
        end
        title('模拟目标轨迹');
        axis equal;
        axis([0,120,0,120]);
        grid on;
        xlabel('X/m');
        ylabel('Y/m');
        legend('轨迹','径向速度');
     end
    
    if(0)
        % 绘制x,y方向位置
        figure;
        subplot(2,1,1);
        plot(measure(R,:).*sin(measure(A,:)));
        title('模拟X方向位置');
        xlabel('时间/(50ms)');
        ylabel('X/m');
        legend('X');
        grid on;
        subplot(2,1,2);
        plot(measure(R,:).*cos(measure(A,:)));
        title('模拟Y方向位置');
        xlabel('时间/(50ms)');
        ylabel('Y/m');
        legend('Y');
        grid on;
    end
    if(0)
        % 绘制航向角及航向速度
        figure;
        subplot(3,1,1);
        plot(rad2deg(target.heading));
        title('模拟航向角');
        xlabel('时间/(50ms)');
        ylabel('航向角/°');
        legend('航向角');
        grid on;
        subplot(3,1,2);
        plot(repmat(target.v, length(target.heading)));
        title('模拟航向速度')
        xlabel('时间/(50ms)');
        ylabel('航向速度/(m/s)');
        legend('模拟航向速度');
        grid on;
        subplot(3,1,3);
        h = pi/2 - target.heading;
        s = target.v;
        plot(s .* cos(h));
        hold on;
        plot(s .* sin(h));
        title('模拟航向分速度');
        xlabel('时间/(50ms)');
        ylabel('速度/(m/s)');
        legend('X方向速度','Y方向速度');
        grid on;
    end
end

%% 产生一条直线
% 起点: (x1,y1)
% 终点: (x2,y2)
% 航向: alpha
% 速度: speed
% 周期: dt
function [measure, tar, ends] = GenerateLine(start, ends, tar)
    ds = tar.v * tar.dt;
    dots = floor(sqrt((ends.x-start.x)^2 + (ends.y-start.y)^2) / ds);
    gama = atan2(ends.y-start.y, ends.x-start.x);
    alpha = pi/2 - gama;
    dx = ds * cos(gama);
    dy = ds * sin(gama);
    x = start.x;
    y = start.y;
    index = 1;
    while(index <= dots)
        tar.heading = [tar.heading alpha]; 
        x = x + dx;
        y = y + dy;
        theta = atan2(x, y);
        beta = theta - alpha;
        measure(1, index) = sqrt(x*x + y*y);
        measure(2, index) = theta;
        measure(3, index) = tar.v * cos(beta);
        index = index + 1;
        if(true==strcmp(tar.maneuver,'CJ'))
            tar.a = tar.a + tar.j * tar.dt;
            tar.v = tar.v + tar.a * tar.dt;
        end
        if(true==strcmp(tar.maneuver,'CA'))
            tar.v = tar.v + tar.a * tar.dt;
        end
        if(true==strcmp(tar.maneuver,'GS'))
            if (index < dots/2)
                tar.v = tar.v + tar.a * tar.dt;
            else
                tar.v = tar.v - tar.a * tar.dt;
            end
        end
    end
    ends.x = x;
    ends.y = y;
end

%% 产生一段圆弧
% 起点: (x1,y1)
% 圆心: (x0, y0)
% 弧度: radian
% 方向: clockwise=1表示顺时针，0表示逆时针
% 航向：alpha
% 速度: speed
% 周期: dt
function [measure,tar, ends] = GenerateArc(org, start, clockwise,radian, tar)
    R = sqrt((start.x-org.x)^2+(start.y-org.y)^2);
    ds = tar.v * tar.dt;
    gama = atan2(start.y-org.y, start.x-org.x);
    if(gama < 0)
        gama = mod(gama, 2*pi);
    end
    index = 1;
    x = 0;
    y = 0;
    alpha = tar.heading(length(tar.heading));
    if(clockwise == 1)
        mingama = gama - radian;
        while(gama >= mingama)
            alpha = alpha +  ds/R;
            tar.heading = [tar.heading alpha];
            gama = gama -  ds/R;
            x = R*cos(gama) + org.x;
            y = R*sin(gama) + org.y;
            theta = atan2(x, y);
            beta = theta - alpha;
            measure(1, index) = sqrt(x*x+y*y);
            measure(2, index) = theta;
            measure(3, index) = tar.v * cos(beta);
            index = index + 1;
            if(true==strcmp(tar.maneuver,'CJ'))
                tar.a = tar.a + tar.j * tar.dt;
                tar.v = tar.v + tar.a * tar.dt;
            end
            if(true==strcmp(tar.maneuver,'CA'))
                tar.v = tar.v + tar.a * tar.dt;
            end
        end
    else
        maxgama = gama + radian;
        while(gama <= maxgama)
            alpha = alpha - ds/R;
            tar.heading = [tar.heading alpha];
            gama = gama + ds/R;
            x = R*cos(gama) + org.x;
            y = R*sin(gama) + org.y;
            theta = atan2(x, y);
            beta = theta - alpha;
            measure(1, index) = sqrt(x*x+y*y);
            measure(2, index) = theta;
            measure(3, index) = tar.v * cos(beta);
            index = index + 1;
            if(true==strcmp(tar.maneuver,'CJ'))
                tar.a = tar.a + tar.j * tar.dt;
                tar.v = tar.v + tar.a * tar.dt;
            end
            if(true==strcmp(tar.maneuver,'CA'))
                tar.v = tar.v + tar.a * tar.dt;
            end
        end
    end
    ends.x = x;
    ends.y = y;
end
