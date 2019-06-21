%% Create system data with slTuner interface
TunedBlocks = {'controller_lonHdot/KP_theta'; ...
               'controller_lonHdot/KI_theta'; ...
               'controller_lonHdot/KP_q'; ...
               'controller_lonHdot/KP_q2'; ...
               'controller_lonHdot/KP_Hdot'; ...
               'controller_lonHdot/KI_Hdot'; ...
               'controller_lonHdot/KF_Hdot'; ...
               'controller_lonHdot/KF_theta'};
AnalysisPoints = {'controller_lonHdot/Hdotc/1'; ...
                  'controller_lonHdot/Hdot/1'; ...
                  'controller_lonHdot/ActuatorsDynamics/1'};
% Specify the custom options
Options = slTunerOptions('AreParamsTunable',false);
% Create the slTuner object
CL0 = slTuner('controller_lonHdot',TunedBlocks,AnalysisPoints,Options);

%% Create tuning goal to shape how the closed-loop system respondes to a specific input signal
% Inputs and outputs
Inputs = {'controller_lonHdot/Hdotc/1'};
Outputs = {'controller_lonHdot/Hdot/1'};
% Tuning goal specifications
Tau = 1.5; % Time constant
Overshoot = 5; % Overshoot (%)
% Create tuning goal for step tracking
StepTrackingGoal1 = TuningGoal.StepTracking(Inputs,Outputs,Tau,Overshoot);
StepTrackingGoal1.RelGap = 0.05; % Relative matching error
StepTrackingGoal1.Name = 'StepTrackingGoal1'; % Tuning goal name

%% Create tuning goal to enforce specific gain and phase margins
Locations = {'controller_lonHdot/ActuatorsDynamics/1'}; % Feedback loop locations
% Tuning goal specifications
GainMargin = 8; % Required minimum gain margin
PhaseMargin = 50; % Required minimum phase margin
% Create tuning goal for margins
MarginsGoal1 = TuningGoal.Margins(Locations,GainMargin,PhaseMargin);
MarginsGoal1.Name = 'MarginsGoal1'; % Tuning goal name

%% Create tuning goal to constrain the dynamics of the closed-loop system
% Tuning goal specifications
MinDecay = 0; % Minimum decay rate of closed-loop poles
MinDamping = 0; % Minimum damping of closed-loop poles
MaxFrequency = Inf; % Maximum natural frequency of closed-loop poles
% Create tuning goal for closed-loop poles
PolesGoal1 = TuningGoal.Poles(MinDecay,MinDamping,MaxFrequency);
PolesGoal1.Name = 'PolesGoal1'; % Tuning goal name

%% Create tuning goal to follow reference commands with prescribed performance
% Inputs and outputs
% Inputs = {'controller_lonHdot/Hdotc/1'};
% Outputs = {'controller_lonHdot/Hdot/1'};
% % Tuning goal specifications
% ResponseTime = 1.2; % Approximately reciprocal of tracking bandwidth
% DCError = 0.0001; % Maximum steady-state error
% PeakError = 3; % Peak error across frequency
% % Create tuning goal for tracking
% TrackingGoal1 = TuningGoal.Tracking(Inputs,Outputs,ResponseTime,DCError,PeakError);
% TrackingGoal1.Name = 'TrackingGoal1'; % Tuning goal name

%% Create option set for systune command
Options = systuneOptions();
Options.Display = 'final'; % Tuning display level ('final', 'sub', 'iter', 'off')
Options.RandomStart = 2;
%% Set soft and hard goals
SoftGoals = [ StepTrackingGoal1 ; ...
              PolesGoal1];
HardGoals = [ MarginsGoal1 ];

%% Tune the parameters with soft and hard goals
[CL1,fSoft,gHard,Info] = systune(CL0,SoftGoals,HardGoals,Options);
fSoft
%% View tuning results
% viewSpec([SoftGoals;HardGoals],CL1);
%%
%
writeBlockValue(CL1);
fprintf("\nKP_q = %f\nKP_q2 = %f\nKP_theta = %f\nKI_theta = %f\nKF_theta = %f\nKI_Hdot = %f\nKP_Hdot = %f\n",KP_q,KP_q2,KP_theta,KI_theta,KF_theta,KI_Hdot,KP_Hdot);
%}

