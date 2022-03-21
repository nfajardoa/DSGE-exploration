function [C] = IRF_closser(IRF_ref,IRF_all)
  % Calcula el IRF de entre todos los de IRF_all el mas cercano (sentido ECM) a IRF_ref
  % IRF_ref debe ser un vector columna e IRF_all estar ordenado acordemente
      R = size(IRF_all,2);
      for n=1:R;
         SC_ref(n)=(IRF_all(:,n)-IRF_ref)'*(IRF_all(:,n)-IRF_ref);
      end
      [C_inf I_inf]=min(SC_ref);
      C = IRF_all(:,I_inf); 
