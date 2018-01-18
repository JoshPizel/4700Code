function AddTriangAtomicArray(LAtoms, HAtoms, X0, Y0, VX0,VY0,InitDist,Temp,Type)
global C
global x y AtomSpacing
global nAtoms
global AtomType Vx Vy Mass0 Mass1

if Type == 0
    Mass=Mass0;
else
    Mass=Mass1;
end

L = LAtoms*AtomSpacing;
H = HAtoms*AtomSpacing;

NumAtoms = LAtoms*HAtoms/2;

xindex=1;
yindex=1;
offset=0;
rowMinus=0;
for i=1:HAtoms-1
    for j=1:LAtoms-rowMinus
        xp(1,xindex)=(j-1)*AtomSpacing+offset;
        yp(1,yindex)=(i-1)*AtomSpacing;
        xindex=xindex+1;
        yindex=yindex+1;
    end
    offset=offset+0.5*AtomSpacing;
    rowMinus=rowMinus+1;
end

x = xp;
y = yp;

x(nAtoms + 1:nAtoms + NumAtoms) = x(nAtoms + 1:nAtoms + NumAtoms) + ...
    (rand(1, NumAtoms) - 0.5) * AtomSpacing * InitDist + X0;
y(nAtoms + 1:nAtoms + NumAtoms) = y(nAtoms + 1:nAtoms + NumAtoms) + ...
    (rand(1, NumAtoms) - 0.5) * AtomSpacing * InitDist + Y0;


AtomType(nAtoms +1:nAtoms + NumAtoms)=Type;

if Temp ==0
    Vx(nAtoms + 1:nAtoms +NumAtoms)=0;
    Vy(nAtoms + 1:nAtoms +NumAtoms)=0;
else
    std0 = sqrt(C.kb * Temp/Mass);
    
    Vx(nAtoms + 1:nAtoms +NumAtoms)=std0*randn(1,NumAtoms);
    Vy(nAtoms + 1:nAtoms +NumAtoms)=std0*randn(1,NumAtoms);
end

Vx(nAtoms + 1:nAtoms + NumAtoms) = Vx(nAtoms + 1:nAtoms + NumAtoms) - ...
    mean(Vx(nAtoms + 1:nAtoms + NumAtoms)) + VX0;
Vy(nAtoms + 1:nAtoms + NumAtoms) = Vy(nAtoms + 1:nAtoms + NumAtoms) - ...
    mean(Vy(nAtoms + 1:nAtoms + NumAtoms)) + VY0;

nAtoms = nAtoms + NumAtoms;

end