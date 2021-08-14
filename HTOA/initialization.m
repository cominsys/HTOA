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

% This function initialize the first population of search agents
function Positions=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    Positions=rand(SearchAgents_no,dim).*(ub-lb)+lb;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    end
end