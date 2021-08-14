function j=RouletteWheelSelection(P)

    r=rand;
    C=cumsum(P);
%    C(i)=0; % EP(i)=0
    j=find(r<=C,1,'first');

end