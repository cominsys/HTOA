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

% This function containts full information and implementations of the benchmark 
% functions in Table     in the paper

% lb is the lower bound: lb=[lb_1,lb_2,...,lb_d]
% up is the uppper bound: ub=[ub_1,ub_2,...,ub_d]
% dim is the number of variables (dimension of the problem)

function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F        % Sphere Function
    case 'F1'
        fobj = @F1;
        lb=-100;
        ub=100;
        dim=30;
        
    case 'F2'  % Schwefel 2.22 Function   
        fobj = @F2;
        lb=-10;
        ub=10;
        dim=30;
        
    case 'F3'   % Schwefel 1.2 Function
        fobj = @F3;
        lb=-100;
        ub=100;
        dim=30;
        
    case 'F4'   % Schwefel 2.21 Function
        fobj = @F4;
        lb=-100;
        ub=100;
        dim=30;
        
%     case 'F5'   % Rosenbrock Function
%         fobj = @F5;
%         lb=-30;
%         ub=30;
%         dim=30;
       
   case 'F5'   % Brown  Function
        fobj = @F5;
        lb=-1;
        ub=4;
        dim=30;
        
        
%     case 'F6'   % Step 2 Function
%         fobj = @F6;
%         lb=-100;
%         ub=100;
%         dim=30;
    
    case 'F6'   % Alpine Function
        fobj = @F6;
        lb=0;
        ub=10;
        dim=30;

    case 'F7'   % Quartic  Function
        fobj = @F7;
        lb=-1.28;
        ub=1.28;
        dim=30;
        
    case 'F8'   % Schwefel Function
        fobj = @F8;
        lb=-500;
        ub=500;
        dim=30;
        
    case 'F9'   % Rastrigin Function
        fobj = @F9;
        lb=-5.12;
        ub=5.12;
        dim=30;
        
    case 'F10'  % Ackley Function
        fobj = @F10;
        lb=-32;
        ub=32;
        dim=30;
        
    case 'F11'  % GRIEWANK Function
        fobj = @F11;
        lb=-600;
        ub=600;
        dim=30;
        
%     case 'F12'   % Penalized Function
%         fobj = @F12;
%         lb=-50;
%         ub=50;
%         dim=30;
        
     case 'F12'   % Salomon Function
        fobj = @F12;
        lb=-100;
        ub=100;
        dim=30;
    
%     case 'F13'   % Generalized Penalized Function
%         fobj = @F13;
%         lb=-50;
%         ub=50;
%         dim=30;
         
        case 'F13'   % Xin-She Yang    Function
        fobj = @F13;
        lb=-5;
        ub=5;
        dim=30;
        
%     case 'F14'   % Shekel's Foxholes Function
%         fobj = @F14;
%         lb=-65.536;
%         ub=65.536;
%         dim=2;
%         
        case 'F14'   % Ackley N. 2 Function
        fobj = @F14;
        lb=-32;
        ub=32;
        dim=2;
        
    case 'F15'   % Kowalik Function
        fobj = @F15;
        lb=-5;
        ub=5;
        dim=4;
        
    case 'F16'   % SIX-HUMP CAMEL Function
        fobj = @F16;
        lb=-5;
        ub=5;
        dim=2;
        
    case 'F17'   % Branin's RCOS No.01 Function 
        fobj = @F17;
        lb=[-5,0];
        ub=[10,15];
        dim=2;
        
    case 'F18'   % Branin's RCOS No.02 Function
        fobj = @F18;
        lb=-2;
        ub=2;
        dim=2;
        
    case 'F19'   % Hartman 3 Function
        fobj = @F19;
        lb=0;
        ub=1;
        dim=3;
        
    case 'F20'   % Hartman 6 Function
        fobj = @F20;
        lb=0;
        ub=1;
        dim=6;     
        
    case 'F21'   % Shekel 5 Function
        fobj = @F21;
        lb=0;
        ub=10;
        dim=4;    
        
    case 'F22'   %Shekel 7 Function
        fobj = @F22;
        lb=0;
        ub=10;
        dim=4;    
         
    case 'F23'  %Shekel 10 Function
        fobj = @F23;
        lb=0;
        ub=10;
        dim=4;   
        
    case '24' %zakharove Function
        fobj=@F24;
        lb=-5;
        ub=10;
        dim=30;
end

end

% F1  % Sphere Function

function o = F1(x)
o=sum(x.^2);
end

% F2   % Schwefel 2.22 Function

function o = F2(x)
o=sum(abs(x))+prod(abs(x));
end

% F3   % Schwefel 1.2 Function

function o = F3(x)
dim=size(x,2);
o=0;
for i=1:dim
    o=o+sum(x(1:i))^2;
end
end

% F4   % Schwefel 2.21 Function

function o = F4(x)
o=max(abs(x));
end

% % F5   % Rosenbrock Function
% 
% function o = F5(x)
% dim=size(x,2);
% o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
% end

% F5   % Brown 
function o = F5(x)
    n = size(x, 2);  
    o = 0;
    x = x .^ 2;
    for i = 1:(n-1)
        o = o + x(:, i) .^ (x(:, i+1) + 1) + x(:, i+1).^(x(:, i) + 1);
    end
end 

% F6   % Step 2 Function

% function o = F6(x)
% o=sum(abs((x+.5)).^2);
% end

%F6 Alpine Function
function o = F6(x)
o = sum(abs(x .* sin(x) + 0.1 * x), 2);
end
% F7   % Quartic  Function

function o = F7(x)
dim=size(x,2);
o=sum([1:dim].*(x.^4))+rand;
end

% F8   % Schwefel Function

function o = F8(x)
o=sum(-x.*sin(sqrt(abs(x))));
end

% F9    % Rastrigin Function

function o = F9(x)
dim=size(x,2);
o=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end

% F10   % Ackley Function

function o = F10(x)
dim=size(x,2);
o=-20*exp(-.2*sqrt(sum(x.^2)/dim))-exp(sum(cos(2*pi.*x))/dim)+20+exp(1);
end

% F11   % GRIEWANK Function

function o = F11(x)
dim=size(x,2);
o=sum(x.^2)/4000-prod(cos(x./sqrt([1:dim])))+1;
end

% % F12   % Penalized Function
% 
% function o = F12(x)
% dim=size(x,2);
% o=(pi/dim)*(10*((sin(pi*(1+(x(1)+1)/4)))^2)+sum((((x(1:dim-1)+1)./4).^2).*...
% (1+10.*((sin(pi.*(1+(x(2:dim)+1)./4)))).^2))+((x(dim)+1)/4)^2)+sum(Ufun(x,10,100,4));
% end

% F12   % Salomon

function o = F12(x)
   x2 = x .^ 2;
    sumx2 = sum(x2, 2);
    sqrtsx2 = sqrt(sumx2);
    
    o = 1 - cos(2 .* pi .* sqrtsx2) + (0.1 * sqrtsx2);
end

% % F13   % Generalized Penalized Function
% 
% function o = F13(x)
% dim=size(x,2);
% o=.1*((sin(3*pi*x(1)))^2+sum((x(1:dim-1)-1).^2.*(1+(sin(3.*pi.*x(2:dim))).^2))+...
% ((x(dim)-1)^2)*(1+(sin(2*pi*x(dim)))^2))+sum(Ufun(x,5,100,4));
% end

% F13   %Xin-She Yang  Function
function o = F13(x)
 n = size(x, 2);
    o = 0;
    for i = 1:n
        o = o + rand * (abs(x(:, i)) .^ i);
    end
end

% % F14    % Shekel's Foxholes Function
% 
% function o = F14(x)
% aS=[-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;,...
% -32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];
% 
% for j=1:25
%     bS(j)=sum((x'-aS(:,j)).^6);
% end
% o=(1/500+sum(1./([1:25]+bS))).^(-1);
% end

% F14    % Ackley N. 2 Function
function o = F14(x)
%     n = size(x, 2);
%     assert(n == 2, 'Ackley N. 2 function is only defined on a 2D space.')
    X = x(:, 1);
    Y = x(:, 2);
    o = -200 * exp(-0.02 * sqrt((X .^ 2) + (Y .^ 2)));
end


% F15    % Kowalik Function

function o = F15(x)
aK=[.1957 .1947 .1735 .16 .0844 .0627 .0456 .0342 .0323 .0235 .0246];
bK=[.25 .5 1 2 4 6 8 10 12 14 16];bK=1./bK;
o=sum((aK-((x(1).*(bK.^2+x(2).*bK))./(bK.^2+x(3).*bK+x(4)))).^2);
end

% F16    % SIX-HUMP CAMEL Function

function o = F16(x)
o=4*(x(1)^2)-2.1*(x(1)^4)+(x(1)^6)/3+x(1)*x(2)-4*(x(2)^2)+4*(x(2)^4);
end

% F17    % Branin's RCOS No.01 Function

function o = F17(x)
o=(x(2)-(x(1)^2)*5.1/(4*(pi^2))+5/pi*x(1)-6)^2+10*(1-1/(8*pi))*cos(x(1))+10;
end

% F18    % Branin's RCOS No.02 Function

function o = F18(x)
o=(1+(x(1)+x(2)+1)^2*(19-14*x(1)+3*(x(1)^2)-14*x(2)+6*x(1)*x(2)+3*x(2)^2))*...
    (30+(2*x(1)-3*x(2))^2*(18-32*x(1)+12*(x(1)^2)+48*x(2)-36*x(1)*x(2)+27*(x(2)^2)));
end

% F19   % Hartman 3 Function

function o = F19(x)
aH=[3 10 30;.1 10 35;3 10 30;.1 10 35];cH=[1 1.2 3 3.2];
pH=[.3689 .117 .2673;.4699 .4387 .747;.1091 .8732 .5547;.03815 .5743 .8828];
o=0;
for i=1:4
    o=o-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
end
end

% F20   % Hartman 6 Function

function o = F20(x)
aH=[10 3 17 3.5 1.7 8;.05 10 17 .1 8 14;3 3.5 1.7 10 17 8;17 8 .05 10 .1 14];
cH=[1 1.2 3 3.2];
pH=[.1312 .1696 .5569 .0124 .8283 .5886;.2329 .4135 .8307 .3736 .1004 .9991;...
.2348 .1415 .3522 .2883 .3047 .6650;.4047 .8828 .8732 .5743 .1091 .0381];
o=0;
for i=1:4
    o=o-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
end
end

% F21   % Shekel 5 Function

function o = F21(x)
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:5
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

% F22   % Shekel 7 Function

function o = F22(x)
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:7
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

% F23  % Shekel 10 Function

function o = F23(x)
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:10
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

function o=Ufun(x,a,k,m)
o=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
end

%F24 zakharove
function o = F24(xx)

d = length(xx);
sum1 = 0;
sum2 = 0;

for ii = 1:d
	xi = xx(ii);
	sum1 = sum1 + xi^2;
	sum2 = sum2 + 0.5*ii*xi;
end

o = sum1 + sum2^2 + sum2^4;

end

