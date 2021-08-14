%___________________________________________________________________%
%  Heat transfer relation-based optimization algorithm (HTOA)       %
%   source codes version 1.0                                        %
%  Developed in MATLAB R2019a(9.6.0)                                %
%                                                                   %
%  Author and programmer: Foad asef                                 %
%                                                                   %
%         E-Mail: Foadasef@gmail.com                                %

%                                                                   %
%   Main paper: Foad Asef • Vahid Majidnezhad1
%          Mohammad-Reza Feizi-Derakhshi • Saeed Parsa             %
%            Heat transfer relation-based optimization algorithm ,  %
%              soft computing , in press,                           %
%               DOI: https://doi.org/10.1007/s00500-021-05734-0     %
%                                                                   %
%___________________________________________________________________%

clear all
close all
clc
profile on
SearchAgents_no=30;      % Number of search agents
aveHTOA=0;
aveGWO=0;
avepso2=0;
aveBBO=0;
aveWOA=0;
aveGA=0;
aveCA=0;
aveDE=0;
aveBOA=0;
aveHHO=0;
% Function_name=N;    % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=500;      % Maximum numbef of iterations
% Load details of the selected benchmark function
% [lb,ub,dim,fobj]=Get_Functions_details(Function_name);
    tempHTOA=[];
    result=[];
    tempGWOA=[];
    temppso2=[];
    tempBBO=[];
    tempWOA=[];
    tempGA=[];
    tempCA=[];
    tempDE=[];
    tempBOA=[];
    tempHHO=[];
   for i=1:19
      i
       switch i
           case 1
              [lb,ub,dim,fobj]=Get_Functions_details('F1');
              display(['Benchmark Function  is : Sphere']);
           case 2
               [lb,ub,dim,fobj]=Get_Functions_details('F2');
               display(['Benchmark Function  is : Schwefel 2.22']);
           case 3 
               [lb,ub,dim,fobj]=Get_Functions_details('F3');
               display(['Benchmark Function  is : Schwefel 1.2']);
           case 4 
               [lb,ub,dim,fobj]=Get_Functions_details('F4');
               display(['Benchmark Function  is : Schwefel 2.21']);
           case 5 
               [lb,ub,dim,fobj]=Get_Functions_details('F5');
               display(['Benchmark Function  is : Brown ']);
           case 6 
               [lb,ub,dim,fobj]=Get_Functions_details('F6');
               display(['Benchmark Function  is : Alpine']);
           case 7 
               [lb,ub,dim,fobj]=Get_Functions_details('F7');
               display(['Benchmark Function  is : Quartic']);
           case 8 
               [lb,ub,dim,fobj]=Get_Functions_details('F8');
               display(['Benchmark Function  is : Schwefel']);
           case 9 
               [lb,ub,dim,fobj]=Get_Functions_details('F9');
               display(['Benchmark Function  is : Rastrigin']);
           case 10 
               [lb,ub,dim,fobj]=Get_Functions_details('F10');
               display(['Benchmark Function  is : Ackley']);
           case 11 
               [lb,ub,dim,fobj]=Get_Functions_details('F11');
               display(['Benchmark Function  is : GRIEWANK']);
           case 12 
               [lb,ub,dim,fobj]=Get_Functions_details('F12');
               display(['Benchmark Function  is : Salomon']);
           case 13 
               [lb,ub,dim,fobj]=Get_Functions_details('F13');
               display(['Benchmark Function  is : Xin-She Yang']);
           case 14 
               [lb,ub,dim,fobj]=Get_Functions_details('F14');
               display(['Benchmark Function  is : Ackley N. 2']);
           case 15 
               [lb,ub,dim,fobj]=Get_Functions_details('F15');
               display(['Benchmark Function  is : Kowalik']);
           case 16 
               [lb,ub,dim,fobj]=Get_Functions_details('F16');
               display(['Benchmark Function  is : SIX-HUMP CAMEL']);
             % case 17 
             % [lb,ub,dim,fobj]=Get_Functions_details('F17');
             % display(['Benchmark Function  is : Branins RCOS No.01']);
           case 17 
               [lb,ub,dim,fobj]=Get_Functions_details('F18');
               display(['Benchmark Function  is : Branins RCOS No.02']);
           case 18 
               [lb,ub,dim,fobj]=Get_Functions_details('F19');
               display(['Benchmark Function  is : Hartman 3']);
           case 19 
               [lb,ub,dim,fobj]=Get_Functions_details('F20');
               display(['Benchmark Function  is : Hartman 6']);
       end
   
    for j=1:1
         
        [GWOBest_score,GWOBest_pos,GWO_cg_curve,TimeGWO]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        [HTOABest_score,HTOABest_pos,HTOA_cg_curve,TimeHTOA]=HTOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        [PSOBest_score,PSOBest_pos,PSO_cg_curve,Timepso2]=pso2(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        [BBOBest_score,BBOBest_pos,BBO_cg_curve,TimeBBO]=BBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        [WOABest_score,WOABest_pos,WOA_cg_curve,TimeWOA]=WOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        [GABest_score,GABest_pos,GA_cg_curve,TimeGA]=GA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        [CABest_score,CABest_pos,CA_cg_curve,TimeCA]=CA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        [DEBest_score,DEBest_pos,DE_cg_curve,TimeDE]=DE(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        [BOABest_score,BOABest_pos,BOA_cg_curve,TimeBOA]=BOA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        [HHORabbit_Energy,HHORabbit_Location,HHOCNVG,TimeHHO]=HHO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
        tempHTOA(j) = HTOABest_score;
        tempGWOA(j) = GWOBest_score;
        temppso2(j) = PSOBest_score;
        tempBBO(j) = BBOBest_score;
        tempWOA(j) = WOABest_score;
        tempGA(j) = GABest_score;
        tempCA(j) = CABest_score;
        tempDE(j) = DEBest_score;
        tempBOA(j) = BOABest_score;
        tempHHO(j) = HHORabbit_Energy;
    end
    result=tempHTOA
    aveHTOA(i) = mean(tempHTOA)
    Standard_Deviation_HTOA(i) = std(tempHTOA)
     
    aveGWO(i) = mean(tempGWOA)
    Standard_Deviation_GWOA(i) = std(tempGWOA)
    
    avepso2(i) = mean(temppso2)
    Standard_Deviation_PSO(i) = std(temppso2)
 
    aveBBO(i) = mean(tempBBO)
    Standard_Deviation_BBO(i) = std(tempBBO)
   
    aveWOA(i) = mean(tempWOA)
    Standard_Deviation_WOA(i) = std(tempWOA)
    
    aveGA(i) = mean(tempGA)
    Standard_Deviation_GA(i) = std(tempGA)
    
    aveCA(i) = mean(tempCA)
    Standard_Deviation_CA(i) = std(tempCA)
    
    aveDE(i) = mean(tempDE)
    Standard_Deviation_DE(i) = std(tempDE)
    
    aveBOA(i) = mean(tempBOA)
    Standard_Deviation_BOA(i) = std(tempBOA)
    
    aveHHO(i) = mean(tempHHO)
    Standard_Deviation_HHO(i) = std(tempHHO)
   
        timeHTOA(i) = TimeHTOA;
        timeGWOA(i) = TimeGWO;
        timePSO(i) = Timepso2;
        timeBBO(i) = TimeBBO;
        timeWOA(i) = TimeWOA;
        timeGA(i) = TimeGA;
        timeCA(i) = TimeCA;
        timeDE(i) = TimeDE;
        timeBOA(i) = TimeBOA;
        timeHHO(i) = TimeHHO;
   
   end

%Draw objective space
semilogy(HTOA_cg_curve,'r--','linewidth',3)
hold on
semilogy(GWO_cg_curve,'b--','linewidth',2)
hold on
semilogy(WOA_cg_curve,'g--','linewidth',2)
 hold on
semilogy(HHOCNVG,'m--','linewidth',2)

title('Objective space about F3')
xlabel('Iteration');
ylabel('Best score obtained so far');

box on
legend('HTOA','GWO','WOA','HHO')
