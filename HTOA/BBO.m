function [Cost,Pos,Curve,TimeBBO]=BBO(nPop,MaxIt,VarMin,VarMax,nVar,CostFunction)
%% Problem Definition
VarSize=[1 nVar];   % Decision Variables Matrix Size
%% BBO Parameters
tic
t = cputime;
KeepRate=0.2;                   % Keep Rate
nKeep=round(KeepRate*nPop);     % Number of Kept Habitats

nNew=nPop-nKeep;                % Number of New Habitats

% Migration Rates
mu=linspace(1,0,nPop);          % Emmigration Rates
lambda=1-mu;                    % Immigration Rates

alpha=0.9;

pMutation=0.2;

% sigma=0.02*(VarMax(2)-VarMin(1));% only for F17
sigma=0.02*(VarMax-VarMin);
%% Initialization

% Empty Habitat
habitat.Position=[];
habitat.Cost=[];

% Create Habitats Array
pop=repmat(habitat,nPop,1);

initPosition=initialization(nPop,nVar,VarMin,VarMax);
% Initialize Habitats
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

%% BBO Main Loop

for it=1:MaxIt
    
    newpop=pop;
    for i=1:nPop
        for k=1:nVar
            % Migration
            if rand<=lambda(i)
                % Emmigration Probabilities
                EP=mu;
                EP(i)=0;
                EP=EP/sum(EP);
                
                % Select Source Habitat
                j=RouletteWheelSelection(EP);
                
                % Migration
                newpop(i).Position(k)=pop(i).Position(k) ...
                    +alpha*(pop(j).Position(k)-pop(i).Position(k));
                
            end
            
            % Mutation
            if rand<=pMutation
                newpop(i).Position(k)=newpop(i).Position(k)+sigma*randn;
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
    
    % Update Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end

%% Results
Cost=BestSol.Cost;
Pos=BestSol.Position;
Curve=BestCost;
TimeBBO=toc;
eBBO = cputime-t;
% figure;
% %plot(BestCost,'LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');

