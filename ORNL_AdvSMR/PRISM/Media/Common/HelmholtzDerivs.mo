within ORNL_AdvSMR.PRISM.Media.Common;
record HelmholtzDerivs
  "derivatives of dimensionless Helmholtz-function w.r.t. dimensionless pressuredensity and temperature"
  extends Modelica.Icons.Record;
  SI.Density d "density";
  SI.Temperature T "temperature";
  SI.SpecificHeatCapacity R "specific heat capacity";
  Real delta(unit="1") "dimensionless density";
  Real tau(unit="1") "dimensionless temperature";
  Real f(unit="1") "dimensionless Helmholtz-function";
  Real fdelta(unit="1") "derivative of f w.r.t. delta";
  Real fdeltadelta(unit="1") "2nd derivative of f w.r.t. delta";
  Real ftau(unit="1") "derivative of f w.r.t. tau";
  Real ftautau(unit="1") "2nd derivative of f w.r.t. tau";
  Real fdeltatau(unit="1") "mixed derivative of f w.r.t. delta and tau";
end HelmholtzDerivs;
