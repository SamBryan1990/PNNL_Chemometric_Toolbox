function [C_pcr, RMSEP_pcr, C_pcr_train, RMSEC_pcr, C_pcr_cross_validation, RMSECV_pcr, data] = pnnl_napalm_pcr(nPrincipalComponents,varargin)
    %pnnl_napalm_pcr Principal component regression (PCR) on the napalm data
    %
    %   pnnl_napalm_pcr(r) with no output parameters performs principal
    %   component regression on the napalm data with r principal components
    %   and plots the results.  If r is a vector, then PCR is repeated
    %   for each of the r(i) number of principal components.
    %
    %   [C_pcr, RMSEP_pcr, C_pcr_train, RMSEC_pcr, ...
    %    C_pcr_cross_validation, RMSECV_pcr, data] = pnnl_napalm_pcr(r)
    %   with output parameters performs principal component regression on
    %   the napalm data and returns the results without plotting.
    %   If r is a vector, then PCR is repeated for each of the r(i) number 
    %   of principal components, and the results are returned in
    %   three-dimensional arrays with each tile of the array corresponding
    %   to the number of principal components in r.
    %
    %   Examples:
    %
    %      % Plot results of PCR on napalm data for 2, 4, 
    %      % and 8 principal components
    %      r = [2 4 8];
    %      pnnl_napalm_pcr(r)
    %
    %      % Return results of PCR on napalm data for 2, 4, 
    %      % and 8 principal components without plotting
    %      r = [2 4 8];
    %      [C_pcr, RMSEP_pcr, C_pcr_train, RMSEC_pcr, ...
    %       C_pcr_cross_validation, RMSECV_pcr, data] = pnnl_napalm_pcr(r)

    % Copyright 2022-2023 Battelle Memorial Institute
    data = load('pnnl_napalm_data');
    A_train = data.A_train;
    C_train = data.C_train;
    C_validation = data.C_validation;
    A_unknown = data.A_unknown;
    ConstituentNames = data.ConstituentNames;
    if nargin < 1
        nPrincipalComponents = min(2,size(C_train,1));
    end
    label_format = 'PCR, %2d principal components';
    method = @pnnl_pcr;
    if nargout == 0
        % Compute and plot
        pnnl_predictions(method,ConstituentNames,label_format,A_train,C_train,A_unknown,C_validation,nPrincipalComponents,varargin{:});
    else
        % Just compute
        [C_pcr, RMSEP_pcr, C_pcr_train, RMSEC_pcr, C_pcr_cross_validation, RMSECV_pcr] = ...
        pnnl_compute_predictions(method,label_format,A_train,C_train,A_unknown,C_validation,nPrincipalComponents,varargin{:});
    end
 end
% Disclaimer
%
% This material was prepared as an account of work sponsored by an agency
% of the United States Government.  Neither the United States Government
% nor the United States Department of Energy, nor Battelle, nor any of
% their employees, nor any jurisdiction or organization that has cooperated
% in the development of these materials, makes any warranty, express or
% implied, or assumes any legal liability or responsibility for the
% accuracy, completeness, or usefulness or any information, apparatus,
% product, software, or process disclosed, or represents that its use would
% not infringe privately owned rights.
% 
% Reference herein to any specific commercial product, process, or service
% by trade name, trademark, manufacturer, or otherwise does not necessarily
% constitute or imply its endorsement, recommendation, or favoring by the
% United States Government or any agency thereof, or Battelle Memorial
% Institute. The views and opinions of authors expressed herein do not
% necessarily state or reflect those of the United States Government or any
% agency thereof.
% 
%                  PACIFIC NORTHWEST NATIONAL LABORATORY
%                               operated by
%                                 BATTELLE
%                                 for the
%                    UNITED STATES DEPARTMENT OF ENERGY
%                     under Contract DE-AC05-76RL01830