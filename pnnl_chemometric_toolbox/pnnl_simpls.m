function [X_loadings, Y_loadings, X_scores, Y_scores, Weights] = pnnl_simpls(X0, Y0, r)
    %pnnl_simpls Statistically inspired modification of the partial least squares (SIMPLS) method
    %
    %    [X_loadings, Y_loadings, X_scores, Y_scores, Weights] = pnnl_simpls(X0, Y0, r)
    %    returns the loadings, scores, and weights of the statistically
    %    inspired modification of the partial least squares (SIMPLS) method
    %    on mean-centered X0 and Y0 with r latent variables.
    %
    %    Example
    %
    %       load pnnl_napalm_data
    %       X = A_train;
    %       Y = C_train;
    %       X0 = X - mean(X,1);
    %       Y0 = Y - mean(Y,1);
    %       r = 2;
    %       [X_loadings,Y_loadings,X_scores,Y_scores,Weights] = pnnl_simpls(X0,Y0,r);
    %
    %    Reference.
    %    Sijmen De Jong., 1993. SIMPLS: an alternative approach to partial
    %    least squares regression. Chemometrics and Intelligent Laboratory
    %    Systems, 18: 251–263.

    % Copyright 2022 Battelle Memorial Institute
    [p,m] = size(X0);
    n = size(Y0,2);

    X_loadings = zeros(m,r);
    Y_loadings = zeros(n,r);
    X_scores = zeros(p,r);
    Y_scores = zeros(p,r);
    Weights = zeros(m,r);
    Q = zeros(m,r);

    C = X0'*Y0;
    for i = 1:r
        [u,s,v] = svd(C,'econ'); 
        u = u(:,1); 
        v = v(:,1); 
        s = s(1);
        w = X0*u;
        normw = norm(w); 
        w = w / normw;
        X_loadings(:,i) = X0'*w;

        y = s*v/normw;
        Y_loadings(:,i) = y;

        X_scores(:,i) = w;
        Y_scores(:,i) = Y0*y;
        Weights(:,i) = u ./ normw;

        qi = X_loadings(:,i);
        for k = 1:2
            for j = 1:i-1
                qj = Q(:,j);
                qi = qi - (qj'*qi)*qj;
            end
        end
        qi = qi ./ norm(qi);
        Q(:,i) = qi;

        C = C - qi*(qi'*C);
        Qi = Q(:,1:i);
        C = C - Qi*(Qi'*C);
    end

    for i = 1:r
        y = Y_scores(:,i);
        for k = 1:2
            for j = 1:i-1
                x = X_scores(:,j);
                y = y - (x'*y)*x;
            end
        end
        Y_scores(:,i) = y;
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