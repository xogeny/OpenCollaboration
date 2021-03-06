within ORNL_AdvSMR.Media.Fluids.IdealGases.MixtureGases;
package SimpleNaturalGas "simple natural gas mix with 6 components"
extends Common.MixtureGasNasa(
  mediumName="SimpleNaturalGas",
  data={Common.SingleGasesData.CH4,Common.SingleGasesData.C2H6,Common.SingleGasesData.C3H8,
      Common.SingleGasesData.C4H10_n_butane,Common.SingleGasesData.N2,Common.SingleGasesData.CO2},

  fluidConstants={Common.FluidData.CH4,Common.FluidData.C2H6,Common.FluidData.C3H8,
      Common.FluidData.C4H10_n_butane,Common.FluidData.N2,Common.FluidData.CO2},

  substanceNames={"Methane","Ethane","Propane","N-Butane,","Nitrogen",
      "Carbondioxide"},
  reference_X={0.92,0.048,0.005,0.002,0.015,0.01});


annotation (Documentation(info="<html>

</html>"));
end SimpleNaturalGas;
