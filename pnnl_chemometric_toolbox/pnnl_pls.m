function [C_pls, B_pls] = pnnl_pls(A_train, C_train, A_unknown, r, meanCentered)
    %pnnl_pls Partial least squares (PLS) regression
    %
    %   [C_pls, B_pls] = pnnl_pls(A_train, C_train, A_unknown, r) returns
    %   concentration matrix C_pls computed using the weights and loadings
    %   from the SIMPLS algorithm on mean-centered A_train and C_train.
    %   The relationship between multiplier matrix B_pls and C_pls is
    %   C_pls = (A_unknown - mean(A_train,1)) * B_pls + mean(C_train,1).
    %
    %   pnnl_pls(A_train, C_train, A_unknown, r, meanCentered) applies mean
    %   centering when meanCentered is true, and does not apply mean
    %   centering when meanCentered is false.  When meanCentered is not
    %   supplied, the default is false (no mean centering).
    %
    %   Example:
    %
    %     load pnnl_napalm_data
    %     r = 3;
    %     meanCentered = true;
    %     [C_pls, B_pls] = pnnl_pls(A_train, C_train, A_unknown, r, meanCentered);
    %
    %   See also pnnl_cls, pnnl_pcr.

    % Copyright 2022 Battelle Memorial Institute
    if nargin < 5
        meanCentered = false;
    end

    X = A_train;
    Y = C_train;
    if meanCentered
        X0 = X - mean(X,1);
        Y0 = Y - mean(Y,1);
    else
        X0 = X;
        Y0 = Y;
    end
    
    [X_loadings,Y_loadings,X_scores,Y_scores,Weights] = pnnl_simpls(X0,Y0,r); %#ok<ASGLU>
    
    B_pls = Weights * Y_loadings';
    
    if meanCentered
        C_pls = (A_unknown - mean(A_train,1)) * B_pls + mean(C_train,1);
    else
        C_pls = A_unknown * B_pls;
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