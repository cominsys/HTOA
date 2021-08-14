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
function [Cost,Pos,Curve,TimeHTOA]=HTOA(nPop,MaxIt,VarMin,VarMax,nVar,CostFunction)
%% Problem Definition

% N=4;
% CostFunction=@(x,N) Benchmarknew(x,N);        % Cost Function

% nVar=30;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size
%% Benchmark Function Selection

% D = inputdlg('Enter  Benchmark Function numbers : Sphere=1*   Rasrigin=2  Ackley=3*  Rosenbrock=4*  Griwank=5  Michalewicz=6*    (nVar<=10)        Schwefel=7  DixsonandPrice=8*  Easom=9*     (nVar=2)  zakharov=10*  shubert=11*     (nVar=2)  booth=12*      (nVar=2)  camel3=13*      (nVar=2) BOHACHEVSKY=14*       (nVar=2) ',...
%              'EPOA', [1 19]);
% N = str2num(D{:});

% [VarMin, VarMax]=Boundnew(N);   % Decision Variables Lower Bound and Upper Bound
%% HTOA Parameters

% MaxIt=500;          % Maximum Number of Iterations

% nPop=200;            % Number of Material  (Population Size)
KeepRate=0.2;                   % Keep Rate
nKeep=round(KeepRate*nPop);     % Number of Kept Material 

nNew=nPop-nKeep;                % Number of New Material 
                        
A=1.22; % for Unimodal&Multimodal A is 1.22 --- for  Fixed dimension A is 1
deltax=0.65;

pMutation=0.03;                  %mutation rate
sigma=0.02*(VarMax-VarMin); % only for F17

%% Initialization

% Empty material
material.Position=[];
material.Cost=[];

% Create material Array
pop=repmat(material,nPop,1);

initPosition=initialization(nPop,nVar,VarMin,VarMax);
% Initialize material 
for i=1:nPop
    pop(i).Position=initPosition(i,:);
    pop(i).Cost=CostFunction(pop(i).Position);
end

% Sort Population
[~, SortOrder]=sort([pop.Cost]);
pop=pop(SortOrder);

% Best Solution Ever Found
BestSol=pop(1);

% Array to Hold Best Costs
BestCost=zeros(MaxIt,1);
%% HTOA Main Loop
tic
t = cputime;
for it=1:MaxIt
    newpop=pop;
    for i=10:nPop
         for j=1:nVar
                 % heat transfer
                  R=randi(10);
                  DeltaCost=(((i-1))/(10*nPop));
                    k = 0.9 + DeltaCost;  %  for Unimodal&Multimodal
%                     k=rand(1)*k;
%                     k=rand(1)*k;
%                     k= rand(1)*DeltaCost;   %  for  Fixed dimension
%                          k = normrnd(0,1)*DeltaCost;

              deltateta = pop(R).Position(j)-pop(i).Position(j);  % temperature difference
              q = (k*A)*((deltateta)/(sin(deltax)));  % heat transfered in minimization problem --  all 
%               q= ((2*pi*A)/(log(4*(A/deltax))*(k*deltateta)));% cylinder vertical
%               q = (deltate ta)/(deltax-(k*A)); 
%               q=(2*pi*k*A*deltateta)/log(deltax); %  for Unimodal&Multimodal-F8 
%               q = k*(deltateta)*A; %heat transfered in maximization problem
%                newpop(i).Position(j)=deltateta*pop(i).Position(j) ...
%                     +q;
                  newpop(i).Position(j)=(2/nVar)*(pop(i).Position(j) ...
                    +q);                                       
                  % Mutation
                if rand<=pMutation
                newpop(i).Position(j)=newpop(i).Position(j)+sigma*randn;
                end
        end
        
        % Evaluation
        newpop(i).Cost=CostFunction(newpop(i).Position);
          
    end
     
    % Sort New Population
    [~, SortOrder]=sort([newpop.Cost]);
    newpop=newpop(SortOrder);
    
    % Select Next Iteration Population
    pop=[pop(1:nKeep)
         newpop(1:nNew)];
        
     % Sort Population
    [~, SortOrder]=sort([pop.Cost]);
    pop=pop(SortOrder);
   
%% destory of material
    for i2=24:nPop % 
          pop(i2).Position = unifrnd(VarMin,VarMax,VarSize);
          deltateta = pop(1).Position - pop(i2).Position;
          q = (k*A*deltateta)/deltax;
%            q=deltateta*0.9;% only  for Fixed dimension 
          pop(i2).Position = pop(i2).Position + q; 
          pop(i2).Cost = CostFunction(pop(i2).Position);
    end
%%    

    % Update Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end
Cost=BestSol.Cost;
Pos=BestSol.Position;
Curve=BestCost;
TimeHTOA=toc;
eHTOA = cputime-t;
%% Results
% % 
% figure;
% plot(BestCost,'LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');
% disp(['Total time of NPOA is']); 
% toc
