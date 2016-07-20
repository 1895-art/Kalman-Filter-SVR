%% ģ��һ���˶��켣
% ����ֱ��ͨ������Բ�����ӣ�Ŀ�������˶�
% ����ʱ�̡�������롢��λ�Ǻ;����ٶ�
function  [time, measure] = W_Trajectory()       
    target.v = 10;      % m/s
    target.a = 1;       % m/(s^-2)
    target.j = 0.2;
    target.dt = 0.05;   % sec
    target.heading = [];
    target.maneuver = 'CA'; % CV:constant Velocity
                            % CA:constant Acceleration
                            % CJ:constant Jerk
                            % GS:go-and-stop
    % 1
    start.x = 10;
    start.y = 10;
    ends.x = 20;
    ends.y = 20;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = m; 
    
    % 2
    ends.x = 10;
    ends.y = 30;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 3
    ends.x = 20;
    ends.y = 40;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 4
    ends.x = 10;
    ends.y = 50;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 5
    ends.x = 20;
    ends.y = 60;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 6
    ends.x = 10;
    ends.y = 70;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 7
    ends.x = 20;
    ends.y = 80;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
     % 8
    org.x = 40;
    org.y = 60;
    [m, target, start] = GenerateArc(org, start, 1, pi/2, target);
    measure = [measure, m];
    
    % 9
    ends.x = 70;
    ends.y = 70;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 10
    ends.x = 60;
    ends.y = 60;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 11
    ends.x = 70;
    ends.y = 50;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 12
    ends.x = 60;
    ends.y = 40;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 13
    ends.x = 70;
    ends.y = 30;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    % 14
    ends.x = 60;
    ends.y = 20;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
     % 15
    ends.x = 70;
    ends.y = 10;
    [m, target, start] = GenerateLine(start, ends, target);
    measure = [measure, m];
    
    time = (1:size(measure,2)).* target.dt;
    
    if(0)
        % ���ƹ켣�������ٶ�
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
        title('ģ��Ŀ��켣');
        axis equal;
        axis([0,120,0,120]);
        grid on;
        xlabel('X/m');
        ylabel('Y/m');
        legend('�켣','�����ٶ�');
    end
    if(0)
        % ���ƾ�����롢��λ�Ǻ;����ٶ�����
        figure;
        subplot(3,1,1);
        plot(measure(R,:));
        title('ģ�⾶�����');
        xlabel('ʱ��/(50ms)');
        ylabel('�������/m');
        legend('�������');
        grid on;
        subplot(3,1,2);
        plot(rad2deg(measure(A,:)));
        title('ģ�ⷽλ��');
        xlabel('ʱ��/(50ms)');
        ylabel('��λ��/��');
        legend('��λ��');
        grid on;
        subplot(3,1,3);
        plot(measure(V,:));
        title('ģ�⾶���ٶ�');
        xlabel('ʱ��/(50ms)');
        ylabel('�����ٶ�/(m/s)');
        legend('�����ٶ�');
        grid on;
    end
    if(0)
        % ���ƺ���Ǽ������ٶ�
        figure;
        subplot(3,1,1);
        plot(rad2deg(target.heading));
        title('ģ�⺽���');
        xlabel('ʱ��/(50ms)');
        ylabel('�����/��');
        legend('�����');
        grid on;
        subplot(3,1,2);
        plot(repmat(target.v, length(target.heading)));
        title('ģ�⺽���ٶ�')
        xlabel('ʱ��/(50ms)');
        ylabel('�����ٶ�/(m/s)');
        legend('ģ�⺽���ٶ�');
        grid on;
        subplot(3,1,3);
        h = pi/2 - target.heading;
        s = target.v;
        plot(s .* cos(h));
        hold on;
        plot(s .* sin(h));
        title('ģ�⺽����ٶ�');
        xlabel('ʱ��/(50ms)');
        ylabel('�ٶ�/(m/s)');
        legend('X�����ٶ�','Y�����ٶ�');
        grid on;
    end
end

%% ����һ��ֱ��
% ���: (x1,y1)
% �յ�: (x2,y2)
% ����: alpha
% �ٶ�: speed
% ����: dt
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

%% ����һ��Բ��
% ���: (x1,y1)
% Բ��: (x0, y0)
% ����: radian
% ����: clockwise=1��ʾ˳ʱ�룬0��ʾ��ʱ��
% ����alpha
% �ٶ�: speed
% ����: dt
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
