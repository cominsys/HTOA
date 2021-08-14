% clc;
% clear;
% close all;
function [Cost,Pos,Curve,Timepso2]=pso2(nPop,MaxIt,VarMin,VarMax,nVar,CostFunction)
%% Problem Definition

global NFE;
NFE=0;
% 
% model.x=[0 1 2 4];
% model.y=[1 0 2 2];
% model.fhat=@(x,a) polyval(a,x);
% % model.fhat=@(x,a) a(1)+a(2)/(1+a(3)*x)+a(4)*x;

% CostFunction=@(a) MyCost(a,model);        % Cost Function
% 
% nVar=2;             % Number of Decision Variables

VarSize=[1 nVar];   % Size of Decision Variables Matrix

% VarMin=-10;         % Lower Bound of Variables
% VarMax= 10;         % Upper Bound of Variables


%% PSO Parameters

% MaxIt=500;      % Maximum Number of Iterations
% 
% nPop=100;        % Population Size (Swarm Size)

w=1;            % Inertia Weight
wdamp=0.99;     % Inertia Weight Damping Ratio
c1=1;           % Personal Learning Coefficient
c2=1;           % Global Learning Coefficient

% % Constriction Coefficients
% phi1=2.05;
% phi2=2.05;
% phi=phi1+phi2;
% chi=2/(phi-2+sqrt(phi^2-4*phi));
% w=chi;          % Inertia Weight
% wdamp=1;        % Inertia Weight Damping Ratio
% c1=chi*phi1;    % Personal Learning Coefficient
% c2=chi*phi2;    % Global Learning Coefficient

% Velocity Limits
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;

mu=0.05;

%% Initialization

empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Sol=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
empty_particle.Best.Sol=[];

particle=repmat(empty_particle,nPop,1);

GlobalBest.Cost=inf;
tic
t = cputime;
for i=1:nPop
    
    % Initialize Position
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity
    particle(i).Velocity=zeros(VarSize);
    
    % Evaluation
    [particle(i).Cost]=CostFunction(particle(i).Position);
    
    % Update Personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    particle(i).Best.Sol=particle(i).Sol;
    
    % Update Global Best
    if particle(i).Best.Cost<GlobalBest.Cost
        
        GlobalBest=particle(i).Best;
        
    end
    
end

BestCost=zeros(MaxIt,1);

nfe=zeros(MaxIt,1);


%% PSO Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        % Update Velocity
        particle(i).Velocity = w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        
        % Apply Velocity Limits
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        
        % Update Position
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % Velocity Mirror Effect
        IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);
        
        % Apply Position Limits
        particle(i).Position = max(particle(i).Position,VarMin);
        particle(i).Position = min(particle(i).Position,VarMax);
        
        % Evaluation
        [particle(i).Cost] = CostFunction(particle(i).Position);
        
        NewSol.Position=Mutate(particle(i).Position,mu,VarMin,VarMax);
        [NewSol.Cost]=CostFunction(NewSol.Position);
        if NewSol.Cost<=particle(i).Cost
            particle(i).Position=NewSol.Position;
            particle(i).Cost=NewSol.Cost;
%             particle(i).Sol=NewSol.Sol;
        end
        
        % Update Personal Best
        if particle(i).Cost<particle(i).Best.Cost
            
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            particle(i).Best.Sol=particle(i).Sol;
            
            % Update Global Best
            if particle(i).Best.Cost<GlobalBest.Cost
                
                GlobalBest=particle(i).Best;
                
            end
            
        end
        
    end
    
    NewSol.Position=Mutate(GlobalBest.Position,mu,VarMin,VarMax);
    [NewSol.Cost]=CostFunction(NewSol.Position);
    if NewSol.Cost<=GlobalBest.Cost
        GlobalBest=NewSol;
    end
    
    BestCost(it)=GlobalBest.Cost;
    
    nfe(it)=NFE;
    
    disp(['Iteration ' num2str(it) ': NFE = ' num2str(nfe(it)) ', Best Cost = ' num2str(BestCost(it))]);
    
    w=w*wdamp;
    
%     
%     PlotSolution(GlobalBest.Position,model);
    
end

%% Results
Cost=GlobalBest.Cost;
Pos=GlobalBest.Position;
Curve=BestCost;
Timepso2=toc;
epso = cputime-t;
% figure;
% plot(nfe,BestCost,'LineWidth',2);
% xlabel('NFE');
% ylabel('Best Cost');

