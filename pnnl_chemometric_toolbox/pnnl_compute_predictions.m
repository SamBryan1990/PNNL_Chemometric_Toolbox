function [C_predicted_array, RMSEP, C_predicted_train_array, RMSEC, C_cross_validation_array, RMSECV,label_array] = ...
        pnnl_compute_predictions(method,label_format,A_train,C_train,A_unknown,C_validation,varargin)
    %pnnl_compute_predictions

    % Copyright 2022 Battelle Memorial Institute
    if isempty(varargin)
        nConstituents = 1;
    else
        nConstituents = varargin{1};
    end
    [p_train,n_train] = size(C_train);
    [p_unknown,n] = size(C_validation);
    assert(isequal(n_train,n),'The training and validation sets must have the same number of constituents');

    C_predicted_array = zeros(p_unknown,n,length(nConstituents));
    C_predicted_train_array = zeros(p_train,n,length(nConstituents));
    C_cross_validation_array = zeros(p_train,n,length(nConstituents));
    RMSEP = zeros(length(nConstituents),n);
    RMSEC = zeros(length(nConstituents),n);
    RMSECV = zeros(length(nConstituents),n);
    label_array = cell(length(nConstituents),1);
    for k = 1:length(nConstituents)
        r = nConstituents(k);
        label_array{k} = sprintf(label_format,r);
        C_predicted = method(A_train,C_train,A_unknown,r,varargin{2:end});
        C_predicted_array(:,:,k) = C_predicted;
        C_predicted_train = method(A_train,C_train,A_train,r,varargin{2:end});
        C_predicted_train_array(:,:,k) = C_predicted_train;
        C_cross_validation = pnnl_cross_validation(method,A_train,C_train,r,varargin{2:end});
        C_cross_validation_array(:,:,k) = C_cross_validation;
        RMSEP(k,:) = pnnl_rmse(C_validation,C_predicted);
        RMSEC(k,:) = pnnl_rmse(C_train,C_predicted_train);
        RMSECV(k,:) = pnnl_rmse(C_train,C_cross_validation);

    end
    C_predicted_array = squeeze(C_predicted_array);
    C_predicted_train_array = squeeze(C_predicted_train_array);
    C_cross_validation_array = squeeze(C_cross_validation_array);
    RMSEP = squeeze(RMSEP);
    RMSEC = squeeze(RMSEC);
    RMSECV = squeeze(RMSECV);
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