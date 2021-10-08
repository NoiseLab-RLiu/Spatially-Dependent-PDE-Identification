# Spatially-Dependent-PDE-Identification

The codes are in the "Code" folder. The dataset used by the codes are in the "Data" folder.

In the "Data" folder:

(1) "Spatially-Dependent" contains 2 fields governed by spatially-dependent heat equation and 2D wave equations. 

(2) "Spatially-Independent" contains 4 fields governed by spatially-independent PDEs: Burgers equation, heat equation, 2D non-attenuating wave equation and 2D attenuating wave equation.

For the codes:

1, load the desired dataset from "Data" folder.

2, use OneD_dict.m or TwoD_dict.m to generate dictionaries.

3(a), use the lasso_seq to identify the active terms of the spatially-dependent PDEs for various locations sequentially.

or 

3(b), use comp_sbl to compare the efficiency for identifying spatially-independent PDEs between this method and the SBL with errorbars method. Codes for another baseline method, i.e., the cross-validation based method, is at: https://github.com/NoiseLab-RLiu/Automate-PDE-identification 

4, use recover_c_a2dwave.m (for spatially-dependent 2D wave eq.) or recover_param_1d.m (for Burgers eq., spatially-dependent heat eq.) to recover physical parameters.

