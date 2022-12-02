function [C_cls, RMSEP_cls, C_cls_train, RMSEC_cls_train, C_cls_cross_validation, RMSECV_cls, data] = pnnl_napalm_cls(varargin)
    %pnnl_napalm_cls Classical least squares (CLS) regression on the napalm data
    %
    %   pnnl_napalm_cls with no output parameters performs classical least
    %   squares regression on the napalm data and plots the results.
    %
    %   [C_cls, RMSEP_cls, C_cls_train, RMSEC_cls_train, C_cls_cross_validation, RMSECV_cls, data] = pnnl_napalm_cls(varargin)
    %   with output parameters performs classical least squares regression
    %   on the napalm data and returns the results without plotting.
    %
    %   Examples:
    %
    %      % Plot results of CLS on napalm data
    %      pnnl_napalm_cls
    %
    %      % Return results of CLS on napalm data without plotting
    %      [C_cls, RMSEP_cls, C_cls_train, RMSEC_cls_train, C_cls_cross_validation, RMSECV_cls, data] = pnnl_napalm_cls;

    % Copyright 2022 Battelle Memorial Institute
    data = load('pnnl_napalm_data');
    A_train = data.A_train;
    C_train = data.C_train;
    C_validation = data.C_validation;
    A_unknown = data.A_unknown;
    ConstituentNames = data.ConstituentNames;
    label_format = 'CLS';
    method = @pnnl_cls;
    if nargout == 0
        % Compute and plot
        pnnl_predictions(method,ConstituentNames,label_format,A_train,C_train,A_unknown,C_validation,varargin{:});
    else
        % Just compute
        [C_cls, RMSEP_cls, C_cls_train, RMSEC_cls_train, C_cls_cross_validation, RMSECV_cls] = ...
        pnnl_compute_predictions(method,label_format,A_train,C_train,A_unknown,C_validation,varargin{:});
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