# GPPSimulate
 A GPP modeling method base on Mäkelä's LUE model. More detail please check the paper: "Developing an empirical model of stand GPP with the LUE approach: analysis of eddy covariance data at five contrasting conifer sites in Europe"
 
 # model formula

 $$P_k = \beta \Phi_{k} \prod_i f_{ik} + \epsilon_{k}$$

 where $P_k$ is canopy GPP ($g \cdot C \cdot m^{-2}$) during day $k$, $\beta$ is potential daily LUE ($g \cdot C \cdot mol^{-1}$), $\Phi_{k}$ is APAR ($mol \cdot m^{-2}$) during day $k$, $f_{ik}$ $\in$ [0, 1] are modifying factors accounting for suboptimal conditions in day $k$, and $\epsilon_{k}$ is random error during day $k$. The actual LUE of the canopy in day $k$ is the product of $\beta$ and the current values of the modifiers.

More details please check: *Developing an empirical model of stand GPP with the LUE approach: analysis of eddy covariance data at five contrasting conifer sites in Europe. DOI: 10.1111/j.1365-2486.2007.01463.x*
