within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function dtsatofp "derivative of saturation temperature w.r.t. pressure"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output Real dtsat(unit="K/Pa") "derivative of T w.r.t. p";
protected
  Real pi "dimensionless pressure";
  Real[49] o "vector of auxiliary variables";
algorithm
  pi := max(Modelica.Constants.small, p*data.IPSTAR);
  o[1] := pi^0.75;
  o[2] := 1/o[1];
  o[3] := -4.268461735023*o[2];
  o[4] := sqrt(pi);
  o[5] := 1/o[4];
  o[6] := 0.5*o[5];
  o[7] := o[3] + o[6];
  o[8] := pi^0.25;
  o[9] := -3.2325550322333e6*o[8];
  o[10] := -724213.16703206*o[4];
  o[11] := 405113.40542057 + o[10] + o[9];
  o[12] := -4*o[11]*o[7];
  o[13] := -808138.758058325*o[2];
  o[14] := -362106.58351603*o[5];
  o[15] := o[13] + o[14];
  o[16] := -17.073846940092*o[8];
  o[17] := 14.91510861353 + o[16] + o[4];
  o[18] := -4*o[15]*o[17];
  o[19] := 3005.2061756175*o[2];
  o[20] := 583.52607263835*o[5];
  o[21] := o[19] + o[20];
  o[22] := 12020.82470247*o[8];
  o[23] := 1167.0521452767*o[4];
  o[24] := -4823.2657361591 + o[22] + o[23];
  o[25] := 2.0*o[21]*o[24];
  o[26] := o[12] + o[18] + o[25];
  o[27] := -4.0*o[11]*o[17];
  o[28] := o[24]*o[24];
  o[29] := o[27] + o[28];
  o[30] := sqrt(o[29]);
  o[31] := 1/o[30];
  o[32] := (-o[30]);
  o[33] := -12020.82470247*o[8];
  o[34] := -1167.0521452767*o[4];
  o[35] := 4823.2657361591 + o[32] + o[33] + o[34];
  o[36] := o[30];
  o[37] := -4823.2657361591 + o[22] + o[23] + o[36];
  o[38] := o[37]*o[37];
  o[39] := 1/o[38];
  o[40] := -1.72207339365771*o[30];
  o[41] := 21592.2055343628*o[8];
  o[42] := o[30]*o[8];
  o[43] := -8192.87114842946*o[4];
  o[44] := -0.510632954559659*o[30]*o[4];
  o[45] := -3100.02526152368*o[1];
  o[46] := pi;
  o[47] := 1295.95640782102*o[46];
  o[48] := 2862.09212505088 + o[40] + o[41] + o[42] + o[43] + o[
    44] + o[45] + o[47];
  o[49] := 1/(o[35]*o[35]);
  dtsat := data.IPSTAR*0.5*((2.0*o[15])/o[35] - 2.*o[11]*(-3005.2061756175
    *o[2] - 0.5*o[26]*o[31] - 583.52607263835*o[5])*o[49] - (
    20953.46356643991*(o[39]*(1295.95640782102 +
    5398.05138359071*o[2] + 0.25*o[2]*o[30] - 0.861036696828853
    *o[26]*o[31] - 0.255316477279829*o[26]*o[31]*o[4] -
    4096.43557421473*o[5] - 0.255316477279829*o[30]*o[5] -
    2325.01894614276/o[8] + 0.5*o[26]*o[31]*o[8]) - 2.0*(o[19]
     + o[20] + 0.5*o[26]*o[31])*o[48]*o[37]^(-3)))/sqrt(o[39]*o[
    48]));
end dtsatofp;