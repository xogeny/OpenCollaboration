within ORNL_AdvSMR.Thermal;
model ConvHT_htcPass
  "1D Convective heat transfer between a DHT_htc and a DHT_htc with heat transfer coefficient pass-through"

  extends ORNL_AdvSMR.Icons.HeatFlow;
  parameter Integer N=2 "Number of Nodes";

  DHThtc otherside(N=N) annotation (Placement(transformation(extent={{-40,-40},
            {40,-20}},rotation=0), iconTransformation(extent={{-40,-40},{40,-20}})));
  DHThtc_in fluidside(N=N) annotation (Placement(transformation(extent={{-40,20},
            {40,40}}, rotation=0), iconTransformation(extent={{-40,20},{40,40}})));
equation
  otherside.gamma = fluidside.gamma;
  for j in 1:N loop
    fluidside.phi[j] = fluidside.gamma[j]*(fluidside.T[j] - otherside.T[j])
      "Convective heat transfer";
    otherside.phi[j] = -fluidside.phi[j] "Energy balance";
  end for;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-100,-44},{100,-70}},
          lineColor={191,95,0},
          textString="%name"),
        Text(
          extent={{-118,46},{-30,14}},
          lineColor={191,95,0},
          textString="fluid"),
        Text(
          extent={{34,48},{122,16}},
          lineColor={191,95,0},
          textString="side")}),
    Documentation(info="<HTML>
<p>Model of a simple convective heat transfer mechanism between two 1D objects. The heat transfer coefficient is supplied by the fluid-side extended connector.
<p>Node <tt>j</tt> on the fluid side interacts with node <tt>j</tt> on the other side.
</HTML>", revisions="<html>
<ul>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>
"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end ConvHT_htcPass;
