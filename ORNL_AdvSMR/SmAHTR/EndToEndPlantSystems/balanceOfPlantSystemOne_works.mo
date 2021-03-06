within ORNL_AdvSMR.SmAHTR.EndToEndPlantSystems;
model balanceOfPlantSystemOne_works "Test of STG with condenser control"
  package FluidMedium = ThermoPower3.Water.StandardWater;

  ThermoPower3.Water.SourceP sourceHPT(
    h=3.47e6,
    redeclare package Medium = FluidMedium,
    p0=12800000) annotation (Placement(transformation(
        origin={-92,70},
        extent={{-5,-5},{5,5}},
        rotation=270)));
  ThermoPower3.Water.SourceP sourceLPT(
    h=3.109e6,
    p0=6e5,
    redeclare package Medium = FluidMedium) annotation (Placement(
        transformation(
        origin={-44,65},
        extent={{-5,-5},{5,5}},
        rotation=270)));
  ThermoPower3.PowerPlants.SteamTurbineGroup.Examples.STG_3LRh_valve_cc
    sTG_3LRh(redeclare package FluidMedium = FluidMedium, steamTurbines(
        SSInit=true)) annotation (Placement(transformation(extent={{-100,
            -55},{-20,25}}, rotation=0)));
  ThermoPower3.Water.SinkP sinkWater(
    redeclare package Medium = FluidMedium,
    h=1.43495e5,
    p0=6e5) annotation (Placement(transformation(
        origin={-28,75},
        extent={{-5,5},{5,-5}},
        rotation=90)));
public
  Modelica.Blocks.Sources.Constant com_valveHP(k=1) annotation (Placement(
        transformation(extent={{100,60},{90,70}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveIP(k=1) annotation (Placement(
        transformation(extent={{100,40},{90,50}}, rotation=0)));
public
  Modelica.Blocks.Sources.Constant com_valveLP(k=1) annotation (Placement(
        transformation(extent={{100,20},{90,30}}, rotation=0)));
protected
  ThermoPower3.PowerPlants.Buses.Actuators actuators annotation (
      Placement(transformation(
        origin={85,-75},
        extent={{-15,-5},{15,5}},
        rotation=180)));
public
  Modelica.Blocks.Sources.Constant n_pump(k=1425) annotation (Placement(
        transformation(extent={{60,60},{70,70}}, rotation=0)));
  inner ThermoPower3.System system(allowFlowReversal=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  ThermoPower3.PowerPlants.ElectricGeneratorGroup.Examples.GeneratorGroup
    singleShaft(
    eta=0.9,
    J_shaft=15000,
    d_shaft=25,
    Pmax=150e6,
    SSInit=true,
    delta_start=0.7) annotation (Placement(transformation(extent={{-10,-55},
            {70,25}},rotation=0)));
equation
  connect(com_valveHP.y, actuators.Opening_valveHP) annotation (Line(
        points={{89.5,65},{85,65},{85,-75}}, color={0,0,127}));
  connect(com_valveIP.y, actuators.Opening_valveIP) annotation (Line(
        points={{89.5,45},{85,45},{85,-75}}, color={0,0,127}));
  connect(com_valveLP.y, actuators.Opening_valveLP) annotation (Line(
        points={{89.5,25},{85,25},{85,-75}}, color={0,0,127}));
  connect(actuators, sTG_3LRh.ActuatorsBus) annotation (Line(points={{85,
          -75},{-15,-75},{-15,-43},{-20,-43}}, color={213,255,170}));
  connect(sTG_3LRh.WaterOut, sinkWater.flange) annotation (Line(
      points={{-28,25},{-28,70}},
      thickness=0.5,
      color={0,0,255}));
  connect(sTG_3LRh.From_SH_LP, sourceLPT.flange) annotation (Line(
      points={{-44,25},{-44,60}},
      thickness=0.5,
      color={0,0,255}));
  connect(sTG_3LRh.From_SH_HP, sourceHPT.flange) annotation (Line(
      points={{-92,25},{-92,65}},
      thickness=0.5,
      color={0,0,255}));
  connect(n_pump.y, actuators.nPump_feedLP) annotation (Line(points={{
          70.5,65},{85,65},{85,-75}}, color={0,0,127}));
  connect(singleShaft.shaft, sTG_3LRh.Shaft_b) annotation (Line(
      points={{-10,-15},{-20,-15}},
      color={0,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sTG_3LRh.To_RH_IP, sTG_3LRh.From_RH_IP) annotation (Line(
      points={{-80,25},{-80,35},{-68,35},{-68,25}},
      color={0,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics),
    experiment(StopTime=20000, NumberOfIntervals=10000),
    experimentSetupOutput(equdistant=false),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end balanceOfPlantSystemOne_works;
