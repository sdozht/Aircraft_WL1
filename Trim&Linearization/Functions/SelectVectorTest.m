model='Trim_Model';
opt = linearizeOptions('LinearizationAlgorithm','numericalpert',...
    'SampleTime',0);
x_Gyro=0;
Op=TrimPoints(5,1);
OpReport=opreport(5,1);
sys = linearize(model,Op,opt);
sys = minreal(sys);
LinedMod51=SelectVector(sys,OpReport);

LinedMod51.Pnzw.A
LinedMod(5,1).Pnz.A

