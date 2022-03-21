function ret = makePositiveDefinite(m, tol) 
    % A function implemented by Diethelm Wuertz
    % Description:
    %   Forces the matrix x to be positive definite
    % Arguments:
    %   x - a symmetric matrix or any other rectangular object
    %       describing a covariance matrix which can be converted into
    %       a matrix by the function 'as.matrix'.
    % Make Positive Definite:
% ------------------------------------------------------------------------------
% .make.positive.definite <-     function(m, tol)
   % Author:
    %   Copyright 2003-05 Korbinian Strimmer
    %   Rank, condition, and positive definiteness of a matrix
    %   GNU General Public License, Version 2
    % Method by Higham 1988

    if ~ismatrix(m)
        m = as.matrix(m) ;
    end
    d = size(m,1) ;
    if  size(m,2) ~= d 
        %continue  %stop ("Input matrix is not square!")  %A CONTINUE may only be used within a FOR or WHILE loop.
        %break   % A BREAK statement appeared outside of a loop. Use RETURN instead.
        return
    end

    [es, es_vectors]  = eig(m) ;
    esv = diag(es); %$values

    if nargin <2  %(missing(tol)) 
        %tol = d*max(abs(esv))*.Machine$double.eps ;  % realmin >> ans=2.2251e-308
        tol = d*max(abs(esv))*realmin ;  % en R 2.220446e-16 
    end
    delta =  2*tol ;
        % factor two is just to make sure the resulting
        % matrix passes all numerical tests of positive definiteness
    %tau = pmax(0, delta - esv) ; % in R: pmax and pmin will also work on classed S3 or S4 objects with appropriate methods for comparison, is.na and rep (if recycling of arguments is needed).
    tau = max(0, delta - esv) ;
    %diag(tau)
    %eye(d)*tau
    %size_esvectors = size(es_vectors)
    dm = es_vectors * diag(tau) * (es_vectors)' ;

    % print(max(DA))
    % print(esv[1]/delta)
ret = m + dm ;
 %   return( m + dm )

