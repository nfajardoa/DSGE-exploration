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
M_.fname = 'Ferroni';
M_.dynare_version = '4.5.4';
oo_.dynare_version = '4.5.4';
options_.dynare_version = '4.5.4';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('Ferroni.log');
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
M_.endo_names = char(M_.endo_names, 'h');
M_.endo_names_tex = char(M_.endo_names_tex, 'h');
M_.endo_names_long = char(M_.endo_names_long, 'h');
M_.endo_names = char(M_.endo_names, 'e_a');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_a');
M_.endo_names_long = char(M_.endo_names_long, 'e_a');
M_.endo_names = char(M_.endo_names, 'e_b');
M_.endo_names_tex = char(M_.endo_names_tex, 'e\_b');
M_.endo_names_long = char(M_.endo_names_long, 'e_b');
M_.endo_names = char(M_.endo_names, 'y_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'y\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'y_obs');
M_.endo_names = char(M_.endo_names, 'h_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'h\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'h_obs');
M_.endo_names = char(M_.endo_names, 'gy_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gy\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'gy_obs');
M_.endo_names = char(M_.endo_names, 'gh_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'gh\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'gh_obs');
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
M_.param_names = char(M_.param_names, 'sigma_a');
M_.param_names_tex = char(M_.param_names_tex, 'sigma\_a');
M_.param_names_long = char(M_.param_names_long, 'sigma_a');
M_.param_names = char(M_.param_names, 'sigma_b');
M_.param_names_tex = char(M_.param_names_tex, 'sigma\_b');
M_.param_names_long = char(M_.param_names_long, 'sigma_b');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 10;
M_.param_nbr = 8;
M_.orig_endo_nbr = 10;
M_.aux_vars = [];
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('Ferroni_static');
erase_compiled_function('Ferroni_dynamic');
M_.orig_eq_nbr = 10;
M_.eq_nbr = 10;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 1 8 18;
 0 9 19;
 2 10 0;
 3 11 0;
 4 12 20;
 5 13 21;
 6 14 0;
 7 15 0;
 0 16 0;
 0 17 0;]';
M_.nstatic = 2;
M_.nfwrd   = 1;
M_.npred   = 4;
M_.nboth   = 3;
M_.nsfwrd   = 4;
M_.nspred   = 7;
M_.ndynamic   = 8;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(10, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(8, 1);
M_.NNZDerivatives = [43; -1; -1];
M_.params( 1 ) = 0.3;
alpha = M_.params( 1 );
M_.params( 2 ) = 0.99;
beta = M_.params( 2 );
M_.params( 3 ) = 0.025;
delta = M_.params( 3 );
M_.params( 4 ) = 1;
chi = M_.params( 4 );
M_.params( 5 ) = 0.8;
rho_a = M_.params( 5 );
M_.params( 6 ) = 0.8;
rho_b = M_.params( 6 );
M_.params( 7 ) = 1;
sigma_a = M_.params( 7 );
M_.params( 8 ) = 0.5;
sigma_b = M_.params( 8 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 1 ) = 2.3664095;
oo_.steady_state( 7 ) = 1;
oo_.steady_state( 9 ) = 1;
oo_.steady_state( 2 ) = 1.86078099;
oo_.steady_state( 4 ) = 0.94350963;
oo_.steady_state( 8 ) = 1;
oo_.steady_state( 10 ) = 1;
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
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = M_.params(7)^2;
M_.Sigma_e(2, 2) = M_.params(8)^2;
options_.order = 1;
options_.periods = 240;
var_list_ = char();
info = stoch_simul(var_list_);
save('Ferroni_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('Ferroni_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('Ferroni_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('Ferroni_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('Ferroni_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('Ferroni_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('Ferroni_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
