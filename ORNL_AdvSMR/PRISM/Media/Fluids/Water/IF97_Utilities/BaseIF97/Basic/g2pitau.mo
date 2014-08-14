within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function g2pitau "derivative of g w.r.t. pi and tau"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output Real pi "dimensionless pressure";
  output Real tau "dimensionless temperature";
  output Real gpi "dimensionless dervative of Gibbs function w.r.t. pi";
  output Real gtau "dimensionless dervative of Gibbs function w.r.t. tau";
protected
  Real tau2 "dimensionless temperature";
  Real[22] o "vector of auxiliary variables";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function g2pitau called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  assert(p <= 100.0e6,
    "IF97 medium function g2pitau: the input pressure (= " +
    String(p) + " Pa) is higher than 100 Mpa");
  assert(T >= 273.15,
    "IF97 medium function g2pitau: the temperature (= " +
    String(T) + " K) is lower than 273.15 K!");
  assert(T <= 1073.15,
    "IF97 medium function g2pitau: the input temperature (= "
     + String(T) + " K) is higher than the limit of 1073.15 K");
  pi := p/data.PSTAR2;
  tau := data.TSTAR2/T;
  tau2 := -0.5 + tau;
  o[1] := tau*tau;
  o[2] := o[1]*o[1];
  o[3] := tau2*tau2;
  o[4] := o[3]*tau2;
  o[5] := o[3]*o[3];
  o[6] := o[5]*o[5];
  o[7] := o[6]*o[6];
  o[8] := o[5]*o[6]*o[7]*tau2;
  o[9] := o[3]*o[5];
  o[10] := o[5]*o[6]*tau2;
  o[11] := o[3]*o[7]*tau2;
  o[12] := o[3]*o[5]*o[6];
  o[13] := o[3]*o[5]*tau2;
  o[14] := o[5]*o[6]*o[7];
  o[15] := pi*pi;
  o[16] := o[15]*o[15];
  o[17] := o[15]*o[16];
  o[18] := o[5]*o[7]*tau2;
  o[19] := o[7]*o[7];
  o[20] := o[3]*o[5]*o[6]*tau2;
  o[21] := o[5]*o[7];
  o[22] := o[3]*o[7];
  gtau := (0.0280439559151 + tau*(-0.2858109552582 + tau*(
    1.2213149471784 + tau*(-2.848163942888 + tau*(4.38395111945
     + o[1]*(10.08665568018 + (-0.5681726521544 +
    0.06380539059921*tau)*tau))))))/(o[1]*o[2]) + pi*(-0.017834862292358
     + tau2*(-0.09199202739273 + (-0.172743777250296 -
    0.30195167236758*o[4])*tau2) + pi*(-0.000033032641670203 +
    (-0.0003789797503263 + o[3]*(-0.015757110897342 + o[4]*(-0.306581069554011
     - 0.000960283724907132*o[8])))*tau2 + pi*(
    4.3870667284435e-7 + o[3]*(-0.00009683303171571 + o[4]*(-0.0090203547252888
     - 1.42338887469272*o[8])) + pi*(-7.8847309559367e-10 + (
    2.558143570457e-8 + 1.44676118155521e-6*tau2)*tau2 + pi*(
    0.0000160454534363627*o[9] + pi*((-5.0144299353183e-11 + o[
    10]*(-0.033874355714168 - 836.35096769364*o[11]))*o[3] + pi
    *((-0.0000138839897890111 - 0.973671060893475*o[12])*o[3]*o[
    6] + pi*(o[13]*(9.0049690883672e-11 - 296.320827232793*o[14])
     + pi*(2.57526266427144e-7*o[5]*o[6] + pi*(o[4]*(
    4.1627860840696e-19 + (-1.0234747095929e-12 -
    1.40254511313154e-8*o[5])*o[9]) + o[17]*(o[14]*(-2.34560435076256e-9
     + 5.3465159397045*o[18]) + o[15]*(-19.1874828272775*o[19]*
    o[6]*o[7] + o[15]*(o[11]*(1.78371690710842e-23 + (
    1.07202609066812e-11 - 0.000201611844951398*o[10])*o[20])
     + pi*(-1.24017662339842e-24*o[21] + pi*(
    0.000200482822351322*o[19]*o[5]*o[7] + pi*(-4.97975748452559e-14
    *o[19]*o[3]*o[5] + (1.90027787547159e-27 + o[12]*(
    2.21658861403112e-15 - 0.0000547344301999018*o[22]))*o[6]*o[
    7]*pi*tau2))))))))))))))));
  gpi := (1. + pi*(-0.0017731742473213 + tau2*(-0.017834862292358
     + tau2*(-0.045996013696365 + (-0.057581259083432 -
    0.05032527872793*o[4])*tau2)) + pi*(tau2*(-0.000066065283340406
     + (-0.0003789797503263 + o[3]*(-0.007878555448671 + o[4]*(
    -0.087594591301146 - 0.000053349095828174*o[8])))*tau2) +
    pi*(6.1445213076927e-8 + (1.31612001853305e-6 + o[3]*(-0.00009683303171571
     + o[4]*(-0.0045101773626444 - 0.122004760687947*o[8])))*
    tau2 + pi*(tau2*(-3.15389238237468e-9 + (5.116287140914e-8
     + 1.92901490874028e-6*tau2)*tau2) + pi*(
    0.0000114610381688305*o[13] + pi*((-1.00288598706366e-10 +
    o[10]*(-0.012702883392813 - 143.374451604624*o[11]))*o[4]
     + pi*(-4.1341695026989e-17 + (-8.8352662293707e-6 -
    0.272627897050173*o[12])*o[3]*o[6]*tau2 + pi*((
    9.0049690883672e-11 - 65.8490727183984*o[14])*o[6] + pi*(
    1.78287415218792e-7*o[10] + pi*(o[5]*(1.0406965210174e-18
     + (-1.0234747095929e-12 - 1.0018179379511e-8*o[5])*o[9])
     + o[17]*((-1.29412653835176e-9 + 1.71088510070544*o[18])*o[
    8] + o[15]*(-6.05920510335078*o[19]*o[6]*o[7]*tau2 + o[15]*
    ((1.78371690710842e-23 + (6.1258633752464e-12 -
    0.000084004935396416*o[10])*o[20])*o[21] + pi*(-1.24017662339842e-24
    *o[18] + pi*(0.0000832192847496054*o[19]*o[5]*o[7]*tau2 +
    pi*((1.75410265428146e-27 + o[12]*(1.32995316841867e-15 -
    0.0000226487297378904*o[22]))*o[3]*o[6]*o[7]*pi -
    2.93678005497663e-14*o[19]*o[3]*o[5]*tau2)))))))))))))))))/
    pi;
end g2pitau;