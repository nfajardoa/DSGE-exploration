%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'Ferroni_3';
M_.dynare_version = '4.5.4';
oo_.dynare_version = '4.5.4';
options_.dynare_version = '4.5.4';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('Ferroni_3.log');
M_.exo_names = 'v_a';
M_.exo_names_tex = 'v\_a';
M_.exo_names_long = 'v_a';
M_.exo_names = char(M_.exo_names, 'v_b');
M_.exo_names_tex = char(M_.exo_names_tex, 'v\_b');
M_.exo_names_long = char(M_.exo_names_long, 'v_b');
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'h_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'h\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'h_obs');
M_.endo_names = char(M_.endo_names, 'e_a');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_a');
M_.endo_names_long = char(M_.endo_names_long, 'e_a');
M_.endo_names = char(M_.endo_names, 'e_b');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_b');
M_.endo_names_long = char(M_.endo_names_long, 'e_b');
M_.endo_names = char(M_.endo_names, 'y_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'y\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'y_obs');
M_.endo_partitions = struct();
M_.param_names = 'alpha';
M_.param_names_tex = 'alpha';
M_.param_names_long = 'alpha';
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'chi');
M_.param_names_tex = char(M_.param_names_tex, 'chi');
M_.param_names_long = char(M_.param_names_long, 'chi');
M_.param_names = char(M_.param_names, 'rho_a');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_a');
M_.param_names_long = char(M_.param_names_long, 'rho_a');
M_.param_names = char(M_.param_names, 'rho_b');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_b');
M_.param_names_long = char(M_.param_names_long, 'rho_b');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 7;
M_.param_nbr = 6;
M_.orig_endo_nbr = 7;
M_.aux_vars = [];
options_.varobs = cell(1);
options_.varobs(1)  = {'y_obs'};
options_.varobs(2)  = {'h_obs'};
options_.varobs_id = [ 7 4  ];
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 0;
erase_compiled_function('Ferroni_3_static');
erase_compiled_function('Ferroni_3_dynamic');
M_.orig_eq_nbr = 7;
M_.eq_nbr = 7;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 1 5 12;
 0 6 13;
 2 7 0;
 0 8 0;
 3 9 14;
 4 10 0;
 0 11 0;]';
M_.nstatic = 2;
M_.nfwrd   = 1;
M_.npred   = 2;
M_.nboth   = 2;
M_.nsfwrd   = 3;
M_.nspred   = 4;
M_.ndynamic   = 5;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(7, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(6, 1);
M_.NNZDerivatives = [28; 50; -1];
M_.params( 2 ) = 0.99;
beta = M_.params( 2 );
M_.params( 3 ) = 0.025;
delta = M_.params( 3 );
M_.params( 1 ) = 0.3;
alpha = M_.params( 1 );
M_.params( 4 ) = 1;
chi = M_.params( 4 );
M_.params( 5 ) = 0.8;
rho_a = M_.params( 5 );
M_.params( 6 ) = 0.8;
rho_b = M_.params( 6 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 1 ) = 2.3664095;
oo_.steady_state( 7 ) = 1;
oo_.steady_state( 2 ) = 1.86078099;
oo_.steady_state( 4 ) = 0.94350963;
oo_.steady_state( 3 ) = 20.2251401;
oo_.steady_state( 5 ) = 0;
oo_.steady_state( 6 ) = 0;
oo_.exo_steady_state( 1 ) = 0;
oo_.exo_steady_state( 2 ) = 0;
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
resid;
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
estim_params_.param_vals = [estim_params_.param_vals; 1, NaN, (-Inf), Inf, 1, 0.5, 0.2886751345948129, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 2, 1, 0.8452, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 1, 0.5, 0.2886751345948129, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 1, 0.5, 0.2886751345948129, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.1, 4, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.1, 4, NaN, NaN, NaN ];
tmp1 = find(estim_params_.param_vals(:,1)==1);
estim_params_.param_vals(tmp1,2) = 0.3;
tmp1 = find(estim_params_.param_vals(:,1)==4);
estim_params_.param_vals(tmp1,2) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==5);
estim_params_.param_vals(tmp1,2) = 0.8;
tmp1 = find(estim_params_.param_vals(:,1)==6);
estim_params_.param_vals(tmp1,2) = 0.8;
tmp1 = find(estim_params_.var_exo(:,1)==1);
estim_params_.var_exo(tmp1,2) = 1;
tmp1 = find(estim_params_.var_exo(:,1)==2);
estim_params_.var_exo(tmp1,2) = 0.5;
options_ident = struct();
dynare_identification(options_ident);
options_.bayesian_irf = 1;
options_.mh_conf_sig = 0.95;
options_.mh_replic = 50000;
options_.mode_check.status = 1;
options_.mode_compute = 6;
options_.selected_variables_only = 1;
options_.datafile = 'variables_simuladas';
options_.order = 1;
var_list_ = char();
oo_recursive_=dynare_estimation(var_list_);
save('Ferroni_3_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('Ferroni_3_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('Ferroni_3_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('Ferroni_3_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('Ferroni_3_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('Ferroni_3_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('Ferroni_3_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
