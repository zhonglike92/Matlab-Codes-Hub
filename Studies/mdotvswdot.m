
clear
p1=9000;
T4=1100;
PR_c=2;
% UA=10000;
A_panel=100;
T_amb=100;
fluid='CO2';
mode=2;
UA=[6000, 7000:1000:10000, 1000, 3000:1000:5000, 1921.6]; % was 2022.3
% UA = 6000;
% UA = [600:100:1000];
% UA=[6000, 7000:1000:10000, 1000, 3000:1000:5000, 2000]
m_dot=0.35:0.05:3;

figure

for j=1:length(UA)
    UA(j)
    for i=1:length(m_dot)
        m_dot(i)
        [net_power(i),~,~,~,~,~,~,q_reactor(i),q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,0);
%       [net_power(i),~,~,~,~,~,~,q_reactor(i),q_rad(i),T1(i),Power_T(i),Power_c(i),HEXeffect(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,0);
        %         [net_power(i),~,~,~,~,~,~,~,~,~,power_T(i),power_C(i),~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode);
    end
    options = [];
    [max_power(j),m_dotmax(j)] = findMaxPower2(p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,options);
    [~,~,~,~,~,~,~,q_reactormax(j),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dotmax(j),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,0);
    %     plot(m_dot,net_power/1000)
    
    if j == length(UA) || UA(j) == 2000
    inds = q_reactor/1000 > 950;
    q_reactor(inds) = [];
    net_power(inds) = [];
    elseif UA(j) == 1000
    inds = q_reactor/1000 > 990;
    q_reactor(inds) = [];
    net_power(inds) = [];
    elseif j == 3
    inds = q_reactor/1000 > 900;
    q_reactor(inds) = [];
    net_power(inds) = [];        
    else
    end
%     figure
%     plot(q_reactor/1000,Power_T)
%     title('Power_T')
%     hold on
%     plot(q_reactor/1000,Power_c)
%     title('Power_c')
% %     figure
%     plot(q_reactor/1000,cyc_efficiency)
%     title('efficiency')
%         figure
%     plot(q_reactor/1000,T1)
%     title('T1')
%     figure
%     plot(q_reactor/1000,abs(q_rad))
%     title('q_r_a_d')
%     figure
%     plot(q_reactor/1000,HEXeffect)
%     title('heseffect')
%     figure
    
    
    plot(q_reactor/1000,net_power/1000)
    %     figure
    %     plot(m_dot,power_T,m_dot,power_C)
    text(q_reactor(end)/1000+10,net_power(end)/1000,[num2str(UA(j)/1000) ' kW/K'])
    
    hold on
end
% xlabel('Mass Flow Rate [kg/s]')
xlabel('Reactor Heat Output [kW]')
ylabel('Cycle Power Output [kW]')
grid on

% with line
% % plot([0,424],[40,40],'k')
plot([0,1200],[40,40],'k')
h1 = scatter(q_reactormax/1000,max_power/1000,'k');
h2 = scatter(q_reactormax(end)/1000,max_power(end)/1000,'filled','k');
% legend('2.022 kW/K','5 kW/K','7 kW/K','9 kW/K','11 kW/K','13 kW/K','15 kW/K','17 kW/K','19 kW/K','40 kW','Peak Power','location','northeast')
% legend('1 kW/K Conductance','2.022 kW/K Conductance','3 kW/K Conductance','5 kW/K Conductance','5 kW/K Conductance','6 kW/K Conductance',...
%     '7 kW Conductance','8 kW/K Conductance','9 kW/K Conductance','10 kW/K Conductance','40 kW Power Output','Peak Power','location','northeast')
% legend('1 kW/K','2.022 kW/K','3 kW/K','5 kW/K','5 kW/K','6 kW/K',...
%     '7 kW','8 kW/K','9 kW/K','10 kW/K','40 kW Power Output','40 kW Power Output','Peak Power','location','northeast')
legend([h1 h2],{'Peak Power','40 kW Power Output'})
% legend([h1],{'Peak Power'})
ylim([10 70])
xlim([0 1200])



% vs m_dot!

% p1=9000;
% T4=1100;
% PR_c=2;
% % UA=10000;
% A_panel=100;
% T_amb=100;
% fluid='CO2';
% mode=2;
% UA=[1000, 1921.6, 3000:1000:10000]; % was 2022.3
% m_dot=0.25:0.05:3.8;
% 
% figure

% for j=1:length(UA)
%     UA(j)
%     parfor i=1:length(m_dot)
%         m_dot(i)
%         [net_power(i),~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,0);
% %         [net_power(i),~,~,~,~,~,~,~,~,~,power_T(i),power_C(i),~,~,~,~,~,~,~,~,~,~,~,~,~] = BraytonCycle(m_dot(i),p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode);
%     end
%     options = [];
%     [max_power(j),m_dotmax(j)] = findMaxPower2(p1,T4,PR_c,UA(j),A_panel,T_amb,fluid,mode,options);
%     plot(m_dot,net_power/1000)
% %     figure
% %     plot(m_dot,power_T,m_dot,power_C)
%     text(m_dot(end)+0.1,net_power(end)/1000,[num2str(UA(j)/1000) ' kW/K'])
%     
%     hold on
% end
% xlabel('Mass Flow Rate [kg/s]')
% ylabel('Power Output [kW]')
% grid on
% % plot([0,6],[40,40],'k')
% h1 = scatter(m_dotmax,max_power/1000,'k');
% h2 = scatter(m_dotmax(2),max_power(2)/1000,'filled','k');
% % legend('2.022 kW/K','5 kW/K','7 kW/K','9 kW/K','11 kW/K','13 kW/K','15 kW/K','17 kW/K','19 kW/K','40 kW','Peak Power','location','northeast')
% % legend('1 kW/K Conductance','2.022 kW/K Conductance','3 kW/K Conductance','5 kW/K Conductance','5 kW/K Conductance','6 kW/K Conductance',...
% %     '7 kW Conductance','8 kW/K Conductance','9 kW/K Conductance','10 kW/K Conductance','40 kW Power Output','Peak Power','location','northeast')
% % legend('1 kW/K','2.022 kW/K','3 kW/K','5 kW/K','5 kW/K','6 kW/K',...
% %     '7 kW','8 kW/K','9 kW/K','10 kW/K','40 kW Power Output','40 kW Power Output','Peak Power','location','northeast')
% legend([h1 h2],{'Peak Power','40 kW Power Output'})
% ylim([-12 70])
% xlim([0 5.5])