function [C_predicted, RMSEP, C_predicted_train, RMSEC, C_predicted_cross_validation, RMSECV] = ...
        pnnl_predictions(method,ConstituentNames,label_format,A_train,C_train,A_unknown,C_validation,varargin)

    % Copyright 2022 Battelle Memorial Institute

    [C_predicted, RMSEP, C_predicted_train, RMSEC, C_predicted_cross_validation, RMSECV,label_array] = ...
        pnnl_compute_predictions(method,label_format,A_train,C_train,A_unknown,C_validation,varargin{:});

    pnnl_plot_predictions(label_array,ConstituentNames,C_train,C_validation,...
        C_predicted,C_predicted_train,C_predicted_cross_validation, ...
        RMSEP,RMSEC,RMSECV);
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
