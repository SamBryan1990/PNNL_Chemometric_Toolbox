function [U,S,V] = pnnl_rectifiedSVD(X)
    %rectifiedSVD Singular value decomposition with rectified V
    %
    % [U,S,V] = rectifiedSVD(X) returns the economy-size singular value
    % decomposition of X, where the maximum magnitude element of each
    % column of V is positive.

    % Copyright 2022 Battelle Memorial Institute
    [U,S,V] = svd(X,'econ');
    [m,n]=size(V);
    [~,I]=max(abs(V));
    K=sub2ind([m,n],I,1:n);
    D=diag(sgn(V(K)));
    U=U*D;
    V=V*D;
end
function s = sgn(x)
    %SGN Sign function with SGN(0) = 1.
    s = sign(x);
    s(s==0) = 1;
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