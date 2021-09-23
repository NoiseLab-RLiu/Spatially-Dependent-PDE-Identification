# Spatially-Dependent-PDE-Identification

The codes are in the "Code" folder. The dataset used by the codes are in the "Data" folder.

In the "Data" folder:
(1) Waves_2d_sp_dp.mat are the 2D waves governed by spatially-dependent wave equations.
(2) Waves_2d_nat_idp.mat are the 2D waves governed by spatially-independent non-attenuating wave equation.
(3) Waves_2d_at_idp.mat are the 2D waves governed by spatially-independent attenuating wave equation.
(4) Heat_sp_dp.mat are the data for spatially-dependent heat equation simulation.
(5) Heat_idp.mat are the data for spatially-independent heat equation simulation.

For the codes:
First, use OneD_dict.m or TwoD_dict.m to generate dictionaries.
Second, use the lasso_par to identify the active terms.
Third, use recover_a_c2dwave.m or recover_a_heat.m to recover physical parameters.

The comp_sbl.m is used to compare efficiency between the proposed method and the SBL with error bars method for identifying spatially-independent PDEs.
