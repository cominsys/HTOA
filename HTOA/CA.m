function [Cost,Pos,Curve,TimeCA]=CA(nPop,MaxIt,VarMin,VarMax,nVar,CostFunction)
%% Problem Definition

VarSize=[1 nVar];   % Decision Variables Matrix Size
%% Cultural Algorithm Settings
tic

pAccept=0.35;                   % Acceptance Ratio
nAccept=round(pAccept*nPop);    % Number of Accepted Individuals

alpha=0.25;

beta=0.5;

%% Initialization

% Initialize Culture
Culture.Situational.Cost=inf;
Culture.Normative.Min=inf(VarSize);
Culture.Normative.Max=-inf(VarSize);
Culture.Normative.L=inf(VarSize);
Culture.Normative.U=inf(VarSize);

% Empty Individual Structure
empty_individual.Position=[];
empty_individual.Cost=[];

% Initialize Population Array
pop=repmat(empty_individual,nPop,1);
initPosition=initialization(nPop,nVar,VarMin,VarMax);
% Initialize Penguin Emperor
for i=1:nPop
    pop(i).Position=initPosition(i,:);
    pop(i).Cost=CostFunction(pop(i).Position);
end

% Sort Population
[~, SortOrder]=sort([pop.Cost]);
pop=pop(SortOrder);

% Adjust Culture
spop=pop(1:nAccept);
Culture=AdjustCulture(Culture,spop);

% Update Best Solution Ever Found
BestSol=Culture.Situational;

% Array to Hold Best Costs
BestCost=zeros(MaxIt,1);

%% Cultural Algorithm Main Loop
tic
t = cputime;
for it=1:MaxIt
    
    % Influnce of Culture
    for i=1:nPop
        
        % % 1st Method
%         sigma=alpha*Culture.Normative.Size;
%         pop(i).Position=pop(i).Position+sigma.*randn(VarSize);
        
        % 2nd Method
%         for j=1:nVar
%            sigma=0.1*(VarMax-VarMin);
%            dx=sigma*randn;
%            if pop(i).Position(j)<Culture.Situational.Position(j)
%                dx=abs(dx);
%            elseif pop(i).Position(j)>Culture.Situational.Position(j)
%                dx=-abs(dx);
%            end
%            pop(i).Position(j)=pop(i).Position(j)+dx;
%         end
        
        % 3rd Method
        for j=1:nVar
          sigma=alpha*Culture.Normative.Size(j);
          dx=sigma*randn;
          if pop(i).Position(j)<Culture.Situational.Position(j)
              dx=abs(dx);
          elseif pop(i).Position(j)>Culture.Situational.Position(j)
              dx=-abs(dx);
          end
          pop(i).Position(j)=pop(i).Position(j)+dx;
        end        
        
        % 4th Method
%         for j=1:nVar
%           sigma=alpha*Culture.Normative.Size(j);
%           dx=sigma*randn;
%           if pop(i).Position(j)<Culture.Normative.Min(j)
%               dx=abs(dx);
%           elseif pop(i).Position(j)>Culture.Normative.Max(j)
%               dx=-abs(dx);
%           else
%               dx=beta*dx;
%           end
%           pop(i).Position(j)=pop(i).Position(j)+dx;
%         end        
        
        pop(i).Cost=CostFunction(pop(i).Position);
    end
    
    % Sort Population
    [~, SortOrder]=sort([pop.Cost]);
    pop=pop(SortOrder);

    % Adjust Culture
    spop=pop(1:nAccept);
    Culture=AdjustCulture(Culture,spop);

    % Update Best Solution Ever Found
    BestSol=Culture.Situational;
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
end

%% Results
Cost=BestSol.Cost;
Pos=BestSol.Position;
Curve=BestCost;
TimeCA=toc;
eCA = cputime-t;
% figure;
% %plot(BestCost,'LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');

