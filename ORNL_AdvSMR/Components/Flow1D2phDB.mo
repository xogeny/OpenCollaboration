within ORNL_AdvSMR.Components;
model Flow1D2phDB
  "1-dimensional fluid flow model for 2-phase boiling flow (finite volumes, 2-phase, computation of heat transfer coeff.)"
  extends ThermoPower3.Water.Flow1D2ph(redeclare ThermoPower3.Thermal.DHThtc
      wall);
  parameter Modelica.SIunits.CoefficientOfHeatTransfer gamma_b=20000
    "Coefficient of heat transfer for boiling flow";
  parameter Real xCHF=0.9
    "Steam quality corresponding to the Critical Heat Flux";
  Medium.ThermodynamicState bubble "Bubble point state";
  Medium.ThermodynamicState dew "Dew point state";
protected
  Modelica.SIunits.CoefficientOfHeatTransfer gamma[N]
    "Raw heat transfer coefficient";
  Modelica.SIunits.CoefficientOfHeatTransfer gamma_ls
    "H.t.c. just before bubble point";
  Modelica.SIunits.CoefficientOfHeatTransfer gamma_chf "H.t.c. just after CHF";
  Modelica.SIunits.CoefficientOfHeatTransfer gamma_corr_left[N]
    "Correction term to get smooth h.t.c.";
  Modelica.SIunits.CoefficientOfHeatTransfer gamma_corr_right[N]
    "Correction term to get smooth h.t.c.";
  Modelica.SIunits.SpecificEnthalpy hCHF
    "Enthalpy corresponding to the Critical Heat Flux";
  Modelica.SIunits.DynamicViscosity mu_ls "Dynamic viscosity at bubble point";
  Modelica.SIunits.DynamicViscosity mu_vs "Dynamic viscosity at dew point";
  Modelica.SIunits.ThermalConductivity k_ls
    "Thermal conductivity at bubble point";
  Modelica.SIunits.ThermalConductivity k_vs "Thermal conductivity at dew point";
  Modelica.SIunits.SpecificHeatCapacity cp_ls
    "Specific heat capacity at bubble point";
  Modelica.SIunits.SpecificHeatCapacity cp_vs
    "Specific heat capacity at dew point";
equation
  hCHF = hl + xCHF*(hv - hl)
    "Specific enthalpy corresponding to critical heat flux";
  // Saturated fluid properties
  bubble = Medium.setBubbleState(sat, 1);
  dew = Medium.setDewState(sat, 1);
  mu_ls = Medium.dynamicViscosity(bubble);
  k_ls = Medium.thermalConductivity(bubble);
  cp_ls = Medium.heatCapacity_cp(bubble);
  mu_vs = Medium.dynamicViscosity(dew);
  k_vs = Medium.thermalConductivity(dew);
  cp_vs = Medium.heatCapacity_cp(dew);
  // H.t.c. just outside the nucleate boiling region
  gamma_ls = ThermoPower3.Water.f_dittus_boelter(
    w,
    Dhyd,
    A,
    mu_ls,
    k_ls,
    cp_ls);
  gamma_chf = ThermoPower3.Water.f_dittus_boelter(
    w*xCHF,
    Dhyd,
    A,
    mu_vs,
    k_vs,
    cp_vs);

  // Nodal h.t.c.
  for j in 1:N loop
    // a) Subcooled liquid
    // b) Wet steam after dryout: Dittus-Boelter's correlation considering
    //    only the vapour phase
    // c) Nucleate boiling: constant h.t.c.
    gamma[j] = noEvent(if h[j] < hl or h[j] > hv then
      ThermoPower3.Water.f_dittus_boelter(
      w,
      Dhyd,
      A,
      Medium.dynamicViscosity(fluidState[j]),
      Medium.thermalConductivity(fluidState[j]),
      Medium.heatCapacity_cp(fluidState[j])) else if h[j] > hCHF then
      ThermoPower3.Water.f_dittus_boelter(
      w*x[j],
      Dhyd,
      A,
      mu_vs,
      k_vs,
      cp_vs) else gamma_b);
  end for;

  // Corrections due to boundaries near the nodes to the left
  // to achieve continuous h.t.c.
  gamma_corr_left[1] = 0;
  for j in 2:N loop
    gamma_corr_left[j] = noEvent(if h[j] < hl then (if (h[j - 1] + h[j])/2 > hl
       then ((h[j - 1] - hl)/(h[j - 1] - h[j]) - 0.5)*(gamma_b - gamma_ls)*(if
      j == N then 2 else 1) else 0) else if h[j] > hCHF then (if (h[j - 1] + h[
      j])/2 < hCHF then ((hCHF - h[j - 1])/(h[j] - h[j - 1]) - 0.5)*(gamma_b -
      gamma_chf)*(if j == N then 2 else 1) else 0) else if (h[j - 1] + h[j])/2
       < hl then ((hl - h[j - 1])/(h[j] - h[j - 1]) - 0.5)*(gamma_ls - gamma_b)
      *(if j == N then 2 else 1) else if (h[j - 1] + h[j])/2 > hCHF then ((h[j
       - 1] - hCHF)/(h[j - 1] - h[j]) - 0.5)*(gamma_chf - gamma_b)*(if j == N
       then 2 else 1) else 0);
  end for;

  // Corrections due to boundaries near the nodes to the right
  // to achieve continuous h.t.c.
  gamma_corr_right[N] = 0;
  for j in 1:N - 1 loop
    gamma_corr_right[j] = noEvent(if h[j] < hl then (if (h[j + 1] + h[j])/2 >
      hl then ((h[j + 1] - hl)/(h[j + 1] - h[j]) - 0.5)*(gamma_b - gamma_ls)*(
      if j == 1 then 2 else 1) else 0) else if h[j] > hCHF then (if (h[j + 1]
       + h[j])/2 < hCHF then ((hCHF - h[j + 1])/(h[j] - h[j + 1]) - 0.5)*(
      gamma_b - gamma_chf)*(if j == 1 then 2 else 1) else 0) else if (h[j + 1]
       + h[j])/2 < hl then ((hl - h[j + 1])/(h[j] - h[j + 1]) - 0.5)*(gamma_ls
       - gamma_b)*(if j == 1 then 2 else 1) else if (h[j + 1] + h[j])/2 > hCHF
       then ((h[j + 1] - hCHF)/(h[j + 1] - h[j]) - 0.5)*(gamma_chf - gamma_b)*(
      if j == 1 then 2 else 1) else 0);
  end for;

  wall.gamma = gamma + gamma_corr_left + gamma_corr_right
    "H.t.c. including smoothing terms";
  annotation (Documentation(info="<HTML>
<p>This model extends <tt>Flow1D2ph</tt> by computing the distribution of the heat transfer coefficient <tt>gamma</tt> and making it available through an extended version of the <tt>wall</tt> connector.
<p>This simplified model can be used for one-phase or two-phase water/steam flow. The heat transfer coefficient is computed according to the following hypotheses:
<ul>
<li> If the fluid is subcooled liquid or superheated steam, Dittus-Boelter's correlation [1] is used.
<li> If the fluid is a two-phase mixture with a steam fraction less than the (constant) critical value <tt>xCHF</tt>, boiling heat transfer is assumed with a heat transfer coefficient equal to <tt>gamma_b</tt>.
<li> If the fluid is wet steam with a steam fraction greater than the (constant) critical value <tt>xCHF</tt>, the heat transfer coefficient is computed according to Dittus-Boelter's correlation, by considering only the steam fraction of the mixture.
</ul>
<p>A smoothing algorithm is applied to the nodes which are in the neighbourhood of a transition boundary between non-boiling and boiling conditions, to avoid non-physical sudden changes of the nodal values of the heat transfer coefficient when the transition boundary passes through a node. The computed values of the heat transfer coefficient are thus a continuous function of the nodal enthalpies and pressures, so that it is not necessary to generate events in order to handle discontinuities
<p><b>References</b></p>
<ol>
<li>J. C. Collier: <i>Convective Boiling and Condensation</i>, 2nd ed.,McGraw Hill, 1981, pp. 146.
</ol>
</HTML>", revisions="<html>
<ul>
<li><i>24 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       <tt>FFtypes</tt> package and <tt>NoFriction</tt> option added.</li>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Standard medium definition added.</li>
<li><i>1 Nov 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Equations revisited.</li>
<li><i>24 Sep 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<li><i>11 Feb 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Computation of the h.t.c. extended to all the thermodynamic conditions of the fluid.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end Flow1D2phDB;