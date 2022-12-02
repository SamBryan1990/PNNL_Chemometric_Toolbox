function [C_pls, RMSEP_pls, C_pls_train, RMSEC_pls, C_pls_cross_validation, RMSECV_pls, data] = pnnl_napalm_pls(nLatentVariables,varargin)
    %pnnl_napalm_pls Partial least squares (PLS) regression on the napalm data
    %
    %   pnnl_napalm_pls(r) with no output parameters performs partial least squares regression
    %   on the napalm data with r latent variables
    %   and plots the results.  If r is a vector, then PLS is repeated
    %   for each of the r(i) number of latent variables.
    %
    %   [C_pls, RMSEP_pls, C_pls_train, RMSEC_pls, C_pls_cross_validation, RMSECV_pls, data] = pnnl_napalm_pls(r)
    %   with output parameters performs partial least squares on
    %   the napalm data and returns the results without plotting.
    %   If r is a vector, then PCR is repeated for each of the r(i) number 
    %   of latent variables, and the results are returned in
    %   three-dimensional arrays with each tile of the array corresponding
    %   to the number of latent variables in r.
    %
    %   Examples:
    %
    %      % Plot results of PLS on napalm data for 2, 4, and 8 latent variables
    %      r = [2 4 8];
    %      pnnl_napalm_pls(r)
    %
    %      % Return results of PLS on napalm data for 2, 4, and 8 latent variables without plotting
    %      r = [2 4 8];
    %      [C_pls, RMSEP_pls, C_pls_train, RMSEC_pls, C_pls_cross_validation, RMSECV_pls, data] = pnnl_napalm_pls(r)

    % Copyright 2022 Battelle Memorial Institute
    data = load('pnnl_napalm_data');
    A_train = data.A_train;
    C_train = data.C_train;
    C_validation = data.C_validation;
    A_unknown = data.A_unknown;
    ConstituentNames = data.ConstituentNames;
    if nargin < 1
        nLatentVariables = min(2,size(C_train,1)-1);
    end
    label_format = 'PLS, %2d latent variables';
    method = @pnnl_pls;
    if nargout == 0
        % Compute and plot
        pnnl_predictions(method,ConstituentNames,label_format,A_train,C_train,A_unknown,C_validation,nLatentVariables,varargin{:});
    else
        % Just compute
        [C_pls, RMSEP_pls, C_pls_train, RMSEC_pls, C_pls_cross_validation, RMSECV_pls] = ...
        pnnl_compute_predictions(method,label_format,A_train,C_train,A_unknown,C_validation,nLatentVariables,varargin{:});
    end
end
% Disclaimer
%
% This material was prepared as an account of work sponsored by an agency of the
% United States Government.  Neither the United States Government nor the United
% States Department of Energy, nor Battelle, nor any of their employees, nor any
% jurisdiction or organization that has cooperated in the development of these
% materials, makes any warranty, express or implied, or assumes any legal
% liability or responsibility for the accuracy, completeness, or usefulness or
% any information, apparatus, product, software, or process disclosed, or
% represents that its use would not infringe privately owned rights.
% 
% Reference herein to any specific commercial product, process, or service by
% trade name, trademark, manufacturer, or otherwise does not necessarily
% constitute or imply its endorsement, recommendation, or favoring by the United
% States Government or any agency thereof, or Battelle Memorial Institute. The
% views and opinions of authors expressed herein do not necessarily state or
% reflect those of the United States Government or any agency thereof.
% 
%                  PACIFIC NORTHWEST NATIONAL LABORATORY
%                               operated by
%                                 BATTELLE
%                                 for the
%                    UNITED STATES DEPARTMENT OF ENERGY
%                     under Contract DE-AC05-76RL01830