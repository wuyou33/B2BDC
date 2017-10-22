<<<<<<< Updated upstream
function [yout,sensitivity] = sosconsisabs_2(obj,abE,sosOpt)
% 

%  Created: Dec 22, 2016     Wenyu Li
x=[];
y = [];
syms x y
warning('off','all');
vars = obj.Variables;
allName = obj.VarNames;
nVar = vars.Length;
A0 = vars.ExtraLinConstraint.A;
units = obj.DatasetUnits.Values;
nUnit = length(units);
if ~isempty(A0)
   lLB = vars.ExtraLinConstraint.LB;
   lUB = vars.ExtraLinConstraint.UB;
end
nlX = size(A0,1);
xbd = obj.Variables.calBound;
LB = xbd(:,1);
UB = xbd(:,2);
obd = obj.calBound;
obd = obd+[-abE abE];
Qx = getQuaFromLin;
v = sym(zeros(1,nVar));
vt = sym(zeros(nVar,1));
for i = 1:nVar
   v(i) = sym(['v' num2str(i)]);
   vt(i) = v(i);
end
gamma = sym('gamma');
ro = sym('ro');
nC = 2*nUnit+length(Qx);
lam = sym(zeros(nC,1));
for i = 1:nC
   lam(i) = sym(['lam' num2str(i)]);
end
sosIneq = sym(zeros(nC,1));
for i = 1:nUnit
   sM = findVarIndex(units(i).SurrogateModel);
   coefV = units(i).SurrogateModel.Coefficient;
   sosIneq(2*i-1) = sum(prod(repmat(v,size(sM,1),1).^sM,2).*coefV)-obd(i,1)-gamma;
   sosIneq(2*i) = -sum(prod(repmat(v,size(sM,1),1).^sM,2).*coefV)+obd(i,2)-gamma;
end
for i = 1:length(Qx)
   tmpQ = Qx{i}(2:end,2:end);
   tmpL = 2*Qx{i}(2:end,1);
   tmpC = Qx{i}(1,1);
   sosIneq(2*nUnit+i) = -v*tmpQ*vt - v*tmpL - tmpC;
end
sosObj = ro;
[gam,var1,opt1] = findbound(-gamma,sosIneq,[],2);
warning('on','all');



   function Qx = getQuaFromLin
      Qx = cell(nVar+nlX,1);
      for i1 = 1:nVar
         lx = LB(i1);
         ux = UB(i1);
         Qx{i1} = sparse([1,1,i1+1,i1+1],[1,i1+1,1,i1+1],...
            [lx*ux,-(lx+ux)/2,-(lx+ux)/2,1],nVar+1,nVar+1);
      end
      for i1 = 1:nlX
         ai = A0(i1,:);
         E = zeros(nVar+1);
         E(2:end,2:end) = ai'*ai;
         E(1,1) = lLB(i1)*lUB(i1);
         E(1,2:end) = -0.5*(lLB(i1)+lUB(i1))*ai;
         E(2:end,1) = -0.5*(lLB(i1)+lUB(i1))*ai';
         Qx{nVar+i1} = E;
      end
   end

   function s = findVarIndex(tModel)
      tName = tModel.VarNames;
      [~,~,id] = intersect(tName,allName,'stable');
      s1 = tModel.SupportMatrix;
      s = zeros(size(s1,1),nVar);
      s(:,id) = s1;
   end

=======
function [yout,sensitivity] = sosconsisabs_2(obj,abE,sosOpt)
% 

%  Created: Dec 22, 2016     Wenyu Li
x=[];
y = [];
syms x y
warning('off','all');
vars = obj.Variables;
allName = obj.VarNames;
nVar = vars.Length;
A0 = vars.ExtraLinConstraint.A;
units = obj.DatasetUnits.Values;
nUnit = length(units);
if ~isempty(A0)
   lLB = vars.ExtraLinConstraint.LB;
   lUB = vars.ExtraLinConstraint.UB;
end
nlX = size(A0,1);
xbd = obj.Variables.calBound;
LB = xbd(:,1);
UB = xbd(:,2);
obd = obj.calBound;
obd = obd+[-abE abE];
Qx = getQuaFromLin;
v = sym(zeros(1,nVar));
vt = sym(zeros(nVar,1));
for i = 1:nVar
   v(i) = sym(['v' num2str(i)]);
   vt(i) = v(i);
end
gamma = sym('gamma');
ro = sym('ro');
nC = 2*nUnit+length(Qx);
lam = sym(zeros(nC,1));
for i = 1:nC
   lam(i) = sym(['lam' num2str(i)]);
end
sosIneq = sym(zeros(nC,1));
for i = 1:nUnit
   sM = findVarIndex(units(i).SurrogateModel);
   coefV = units(i).SurrogateModel.Coefficient;
   sosIneq(2*i-1) = sum(prod(repmat(v,size(sM,1),1).^sM,2).*coefV)-obd(i,1)-gamma;
   sosIneq(2*i) = -sum(prod(repmat(v,size(sM,1),1).^sM,2).*coefV)+obd(i,2)-gamma;
end
for i = 1:length(Qx)
   tmpQ = Qx{i}(2:end,2:end);
   tmpL = 2*Qx{i}(2:end,1);
   tmpC = Qx{i}(1,1);
   sosIneq(2*nUnit+i) = -v*tmpQ*vt - v*tmpL - tmpC;
end
sosObj = ro;
[gam,var1,opt1] = findbound(-gamma,sosIneq,[],2);
warning('on','all');



   function Qx = getQuaFromLin
      Qx = cell(nVar+nlX,1);
      for i1 = 1:nVar
         lx = LB(i1);
         ux = UB(i1);
         Qx{i1} = sparse([1,1,i1+1,i1+1],[1,i1+1,1,i1+1],...
            [lx*ux,-(lx+ux)/2,-(lx+ux)/2,1],nVar+1,nVar+1);
      end
      for i1 = 1:nlX
         ai = A0(i1,:);
         E = zeros(nVar+1);
         E(2:end,2:end) = ai'*ai;
         E(1,1) = lLB(i1)*lUB(i1);
         E(1,2:end) = -0.5*(lLB(i1)+lUB(i1))*ai;
         E(2:end,1) = -0.5*(lLB(i1)+lUB(i1))*ai';
         Qx{nVar+i1} = E;
      end
   end

   function s = findVarIndex(tModel)
      tName = tModel.VarNames;
      [~,~,id] = intersect(tName,allName,'stable');
      s1 = tModel.SupportMatrix;
      s = zeros(size(s1,1),nVar);
      s(:,id) = s1;
   end

>>>>>>> Stashed changes
end