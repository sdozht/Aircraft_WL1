%% Create system data with slTuner interface
TunedBlocks = {'controller_lat/KP_phi'; ...
               'controller_lat/KI_phi'; ...
               'controller_lat/KP_p'; ...
               'controller_lat/KP_p2'; ...
               'controller_lat/KP_r'; ...
               'controller_lat/KF_phi'};
AnalysisPoints = {'controller_lat/phic/1'; ...
                  'controller_lat/Gain6/1'; ...
                  'controller_lat/ActuatorsDynamics/1'; ...
                  'controller_lat/ActuatorsDynamics1/1'};
% Specify the custom options
Options = slTunerOptions('AreParamsTunable',false);
% Create the slTuner object
CL0 = slTuner('controller_lat',TunedBlocks,AnalysisPoints,Options);

%% Create tuning goal to shape how the closed-loop system respondes to a specific input signal
% Inputs and outputs
Inputs = {'controller_lat/phic/1'};
Outputs = {'controller_lat/Gain6/1'};
% Tuning goal specifications
Tau = 0.5; % Time constant
Overshoot = 5; % Overshoot (%)
% Create tuning goal for step tracking
StepTrackingGoal1 = TuningGoal.StepTracking(Inputs,Outputs,Tau,Overshoot);
StepTrackingGoal1.RelGap = 0.05; % Relative matching error
StepTrackingGoal1.Name = 'StepTrackingGoal1'; % Tuning goal name

%% Create tuning goal to enforce specific gain and phase margins
Locations = {'controller_lat/ActuatorsDynamics/1'}; % Feedback loop locations
% Tuning goal specifications
GainMargin = 8; % Required minimum gain margin
PhaseMargin = 50; % Required minimum phase margin
% Create tuning goal for margins
MarginsGoal1 = TuningGoal.Margins(Locations,GainMargin,PhaseMargin);
MarginsGoal1.Name = 'MarginsGoal1'; % Tuning goal name

%% Create tuning goal to enforce specific gain and phase margins
Locations = {'controller_lat/ActuatorsDynamics1/1'}; % Feedback loop locations
% Tuning goal specifications
GainMargin = 8; % Required minimum gain margin
PhaseMargin = 50; % Required minimum phase margin
% Create tuning goal for margins
MarginsGoal2 = TuningGoal.Margins(Locations,GainMargin,PhaseMargin);
MarginsGoal2.Name = 'MarginsGoal2'; % Tuning goal name
%% Create tuning goal to constrain the dynamics of the closed-loop system
% Tuning goal specifications
MinDecay = 0; % Minimum decay rate of closed-loop poles
MinDamping = 0.3; % Minimum damping of closed-loop poles
MaxFrequency = Inf; % Maximum natural frequency of closed-loop poles
% Create tuning goal for closed-loop poles
PolesGoal1 = TuningGoal.Poles(MinDecay,MinDamping,MaxFrequency);
PolesGoal1.Name = 'PolesGoal1'; % Tuning goal name

%% Create tuning goal to follow reference commands with prescribed performance
% Inputs and outputs
Inputs = {'controller_lat/phic/1'};
Outputs = {'controller_lat/Gain6/1'};
% Tuning goal specifications
ResponseTime = 1.2; % Approximately reciprocal of tracking bandwidth
DCError = 0.0001; % Maximum steady-state error
PeakError = 2; % Peak error across frequency
% Create tuning goal for tracking
TrackingGoal1 = TuningGoal.Tracking(Inputs,Outputs,ResponseTime,DCError,PeakError);
TrackingGoal1.Name = 'TrackingGoal1'; % Tuning goal name

%% Create option set for systune command
Options = systuneOptions();
Options.Display = 'final'; % Tuning display level ('final', 'sub', 'iter', 'off')

%% Set soft and hard goals
SoftGoals = [ StepTrackingGoal1 ; ...
              PolesGoal1 ; ...
              TrackingGoal1 ];
HardGoals = [ MarginsGoal1 ];

%% Tune the parameters with soft and hard goals
[CL1,fSoft,gHard,Info] = systune(CL0,SoftGoals,HardGoals,Options);

%% View tuning results
% viewSpec([SoftGoals;HardGoals],CL1);
%%
%
writeBlockValue(CL1);
fprintf("\nKP_p = %f\nKP_p2 = %f\nKP_r = %f\nKP_phi = %f\nKI_phi = %f\nKF_phi = %f\n",KP_p,KP_p2,KP_r,KP_phi,KI_phi,KF_phi);
%}

