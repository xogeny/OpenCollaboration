within ORNL_AdvSMR.Media.Fluids.IdealGases.SingleGases;
package C4H8_1_butene "Ideal gas \"C4H8_1_butene\" from NASA Glenn coefficients"
extends Common.SingleGasNasa(
  mediumName="1-Butene",
  data=Common.SingleGasesData.C4H8_1_butene,
  fluidConstants={Common.FluidData.C4H8_1_butene});


annotation (Documentation(info="<HTML>
      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/C4H8_1_butene.png\"></HTML>"));
end C4H8_1_butene;
