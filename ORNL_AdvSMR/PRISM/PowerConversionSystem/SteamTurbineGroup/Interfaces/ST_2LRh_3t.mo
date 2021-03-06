within ORNL_AdvSMR.PRISM.PowerConversionSystem.SteamTurbineGroup.Interfaces;
partial model ST_2LRh_3t
  "Base class for Steam Turbine with two pressure levels, reheat and three tappings"

  replaceable package FluidMedium = ThermoPower3.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialPureSubstance;

  //Turbines parameter
  parameter Modelica.SIunits.MassFlowRate steamHPNomFlowRate
    "Nominal HP steam flow rate";
  parameter Modelica.SIunits.MassFlowRate steamIPNomFlowRate
    "Nominal IP steam flow rate";
  parameter Modelica.SIunits.MassFlowRate steamLPNomFlowRate
    "Nominal LP steam flowr rate";
  parameter Modelica.SIunits.Pressure steamHPNomPressure
    "Nominal HP steam pressure";
  parameter Modelica.SIunits.Pressure steamIPNomPressure
    "Nominal IP steam pressure";
  parameter Modelica.SIunits.Pressure steamLPNomPressure
    "Nominal LP steam pressure";
  parameter Modelica.SIunits.Area HPT_Kt "Flow coefficient"
    annotation (Dialog(group="HP Turbine"));
  parameter Real HPT_eta_mech=0.98 "Mechanical efficiency"
    annotation (Dialog(group="HP Turbine"));
  parameter Real HPT_eta_iso_nom=0.92 "Nominal isentropic efficiency"
    annotation (Dialog(group="HP Turbine"));
  parameter Modelica.SIunits.Area IPT_Kt "Flow coefficient"
    annotation (Dialog(group="IP Turbine"));
  parameter Real IPT_eta_mech=0.98 "Mechanical efficiency"
    annotation (Dialog(group="IP Turbine"));
  parameter Real IPT_eta_iso_nom=0.92 "Nominal isentropic efficiency"
    annotation (Dialog(group="IP Turbine"));
  parameter Modelica.SIunits.Area LPT_Kt "Flow coefficient"
    annotation (Dialog(group="LP Turbine"));
  parameter Real LPT_eta_mech=0.98 "Mechanical efficiency"
    annotation (Dialog(group="LP Turbine"));
  parameter Real LPT_eta_iso_nom=0.92 "Nominal isentropic efficiency"
    annotation (Dialog(group="LP Turbine"));

  //Start value
  //HPT
  parameter Modelica.SIunits.Pressure HPT_pstart_in=steamHPNomPressure
    "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));
  parameter Modelica.SIunits.Pressure HPT_pstart_out=steamIPNomPressure
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));
  parameter Modelica.SIunits.MassFlowRate HPT_wstart=steamHPNomFlowRate
    "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="HP Turbine"));

  //IPT
  parameter Modelica.SIunits.Pressure IPT_pstart_in=steamIPNomPressure
    "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="IP Turbine"));
  parameter Modelica.SIunits.Pressure IPT_pstart_out=steamLPNomPressure
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="IP Turbine"));
  parameter Modelica.SIunits.MassFlowRate IPT_wstart=steamIPNomFlowRate
    "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="IP Turbine"));

  //LPT
  parameter Modelica.SIunits.Pressure LPT_pstart_in=steamLPNomPressure
    "Inlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.Pressure LPT_pstart_out=pcond
    "Outlet pressure start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));
  parameter Modelica.SIunits.MassFlowRate LPT_wstart=steamLPNomFlowRate
    "Mass flow rate start value"
    annotation (Dialog(tab="Initialization", group="LP Turbine"));

  //other parameter
  parameter Modelica.SIunits.Pressure pcond "Condenser pressure";

  ThermoPower3.Water.FlangeB Tap1(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-140,-210},{-120,-190}},
          rotation=0)));
  ThermoPower3.Water.FlangeB Tap2(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-50,-210},{-30,-190}},
          rotation=0)));
  ThermoPower3.Water.FlangeB Tap3(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-10,-210},{10,-190}},
          rotation=0)));

  ThermoPower3.Water.FlangeA HPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-180,180},{-140,220}},
          rotation=0)));
  ThermoPower3.Water.FlangeB HPT_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-120,180},{-80,220}},
          rotation=0)));
  ThermoPower3.Water.FlangeA IPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{-60,180},{-20,220}}, rotation
          =0)));
  ThermoPower3.Water.FlangeA LPT_In(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{60,180},{100,220}}, rotation=
            0)));
  ThermoPower3.Water.FlangeB LPT_Out(redeclare package Medium = FluidMedium)
    annotation (Placement(transformation(extent={{60,-220},{100,-180}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b Shaft_b annotation (
      Placement(transformation(extent={{180,-20},{220,20}}, rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a Shaft_a annotation (
      Placement(transformation(extent={{-220,-20},{-180,20}}, rotation=0)));
  ThermoPower3.PowerPlants.Buses.Sensors SensorsBus annotation (Placement(
        transformation(extent={{180,-100},{220,-60}}, rotation=0)));
  ThermoPower3.PowerPlants.Buses.Actuators ActuatorsBus annotation (Placement(
        transformation(extent={{220,-160},{180,-120}}, rotation=0)));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics), Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}},
        initialScale=0.1), graphics={Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={170,170,255},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),Line(points={{-160,198},{-160,30}},
          color={0,0,255}),Line(points={{-100,200},{-100,86}}, color={0,0,255}),
          Line(points={{-40,200},{-40,30}}, color={0,0,255}),Rectangle(
          extent={{-200,14},{202,-14}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),Line(points={{20,52},{20,140},{80,140},{80,
          198}}, color={0,0,255}),Line(points={{80,-76},{80,-198}}, color={0,0,
          255}),Line(
          points={{-130,-50},{-130,-200}},
          color={0,0,255},
          pattern=LinePattern.Dash),Line(
          points={{-40,-200},{-40,-100},{-10,-100},{-10,-40}},
          color={0,0,255},
          pattern=LinePattern.Dash),Line(
          points={{0,-200},{0,-130},{50,-130},{50,-66}},
          color={0,0,255},
          pattern=LinePattern.Dash),Polygon(
          points={{-40,30},{-40,-30},{80,-90},{80,92},{-40,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-160,30},{-160,-30},{-100,-90},{-100,90},{-160,30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),Polygon(
          points={{-166,148},{-154,148},{-160,132},{-166,148}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-106,134},{-94,134},{-100,150},{-106,134}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{-46,148},{-34,148},{-40,132},{-46,148}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{14,108},{26,108},{20,92},{14,108}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255}),Polygon(
          points={{74,-134},{86,-134},{80,-150},{74,-134}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255})}));

end ST_2LRh_3t;
