within ORNL_AdvSMR.Components;
model SinkW "Flowrate sink for water/steam flows"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.Water.SourceW;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby ORNL_AdvSMR.Media.Interfaces.PartialMedium "Medium model";
  parameter Modelica.SIunits.MassFlowRate w0=0 "Nominal mass flowrate";
  parameter Modelica.SIunits.Pressure p0=1e5 "Nominal pressure";
  parameter ORNL_AdvSMR.SIunits.HydraulicConductance G=0
    "Hydraulic conductance";
  parameter Modelica.SIunits.SpecificEnthalpy h=1e5 "Nominal specific enthalpy";
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction";
  outer ORNL_AdvSMR.System system "System wide properties";
  Modelica.SIunits.MassFlowRate w "Mass flowrate";
  ORNL_AdvSMR.Interfaces.FlangeA flange(redeclare package Medium = Medium,
      m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0))
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}, rotation
          =0)));
  Modelica.Blocks.Interfaces.RealInput in_w0 annotation (Placement(
        transformation(
        origin={-40,60},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealInput in_h annotation (Placement(
        transformation(
        origin={40,60},
        extent={{-20,-20},{20,20}},
        rotation=270)));
equation
  if G == 0 then
    flange.m_flow = w;
  else
    flange.m_flow = w + (flange.p - p0)*G;
  end if;

  w = in_w0 "Flow rate set by connector";
  if cardinality(in_w0) == 0 then
    in_w0 = w0 "Flow rate set by parameter";
  end if;

  flange.h_outflow = in_h "Enthalpy set by connector";
  if cardinality(in_h) == 0 then
    in_h = h "Enthalpy set by parameter";
  end if;
  annotation (
    Icon(graphics={Text(extent={{-98,72},{-48,40}}, textString="w0"),Text(
            extent={{48,72},{98,40}}, textString="h")}),
    Documentation(info="<HTML>
<p><b>Modelling options</b></p>
<p>If <tt>G</tt> is set to zero, the flowrate source is ideal; otherwise, the incoming flowrate increases proportionally to the inlet pressure.</p>
<p>If <tt>w0Fix</tt> is set to true, the incoming flowrate is given by the parameter <tt>w0</tt>; otherwise, the <tt>in_w0</tt> connector must be wired, providing the (possibly varying) source flowrate.</p>
<p>If <tt>hFix</tt> is set to true, the source enthalpy is given by the parameter <tt>h</tt>; otherwise, the <tt>in_h</tt> connector must be wired, providing the (possibly varying) source enthalpy.</p>
</HTML>", revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium model and standard medium definition added.</li>
<li><i>18 Jun 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Removed <tt>p0_fix</tt> and <tt>hfix</tt>; the connection of external signals is now detected automatically.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Diagram(graphics));
end SinkW;
