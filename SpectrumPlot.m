(* ::Package:: *)

(* Mathematica Package *)

(* Created by the Wolfram Workbench 02.05.2013 *)

BeginPackage["SpectrumPlot`",{"CGSUnits`","ASTRO`"}]
(* Exported symbols added here with SymbolName::usage *) 

Unprotect[
ImportSpectrum,CleanFITSHeader,StripHeaderComments,JoinHeader, \
FindDuplicateHeaderKeys, flattenCube, splitMultipleBintable, \
FormatSpectrum, singleBintableQ, hipeBintableQ, classOriginQ, \
MetaDataPattern, SpectrumPattern, MultipleSpectraQ, SpectrumArrayQ, \
SpectralAxisType, VelocityAxisQ, FrequencyAxisQ, HeaderKeyExistsQ, \
absoluteCoordinatesInTFIELDSQ, relativeCoordinatesInTFIELDSQ, \
GetHeaderKeyValue, PutHeaderKeyValue, DeleteHeaderKey, FindSpectralAxis, \
FindRAAxis, FindDecAxis, GetTFIELDDec, GetTFIELDRA, GetDeltaRA, \
GetDeltaDec, GetAbsRA, GetAbsDec, calculateAxisValues, ObservedCoordinates, \
GetCoordinateSystem, GetAbsoluteSpectralAxis, ComposeXYSpectrum, \
RegridSpectralAxis, ToVelocity, ToFrequency, SpectrumPlot, \
BaselineDegree, SetLineWindow, SubtractBaseline, MaskSpectrum, \
SpectralAxisConfiguration, AverageSpectrum, CalculateRMS, \
SmoothSpectrum, ListTFIELDS, TFIELD2FITSKey, HICLASSQ, \
PureDataTableQ, HeaderKeyInDataQ, exData, multibleBintable, \
AngularSeparation, AntennaBeamRadius, AzElToRADec, CosmicBackgroundEnergy , CosmicRayEnergy, \
DaysSince, deltaT, DMStoRad, DMStoRadian, DopplerVelocity, \
EquivalentDisk, Erg2Watt, ErgToJansky,Kelvin2Erg,Erg2Kelvin,KelvinKmsec2Erg,Erg2KelvinKmsec, FrequencyToWavelength, \
FrequencyToWavenumber, FromHMS, FromRadian, FullPrecision, GAST, \
GeocentricToRADec, GMST, GST, HMSList, HMSString, HMSToRad, \
HMSToRadian, HMSToSeconds, HourAngle, HoursToHMS, HydrodynamicEnergy, \
JanskyToErg, JohnsonPhotometricSystem, JulianCenturies, JulianDate, \
KelvinKmsec2Watt, LocalSiderealTime, LST, MagneticEnergy, \
MagneticPressure, ModifiedJulianDate, Nutation, NutationMatrix, \
Obliquity, RADecToAzEl, RADecToHeliocentric, RadianToDMS, \
RadioVelocity, RadianToDMS, RadToHMS, SecondsToHMS, ThermalEnergy, \
ThermalPressure, ToRadian, VelocityDispersionToDopplerWidth, \
VelocityDispersionToFWHM, Watt2Erg, Watt2KelvinKmsec, \
WavelengthToFrequency, WavelengthToWavenumber];


ImportSpectrum::usage = 
  "ImportSpectrum[FITSfile] imports spectra from a FITS file and \
tries to format the data as spectrum data objects.";

CleanFITSHeader::usage = 
  "CleanFITSHeader[header] strips all comments fields from the header \
entries (provided as a list of Rules.";
CleanFITSHeader::headx = "Unknown FITS header format.";
StripHeaderComments::usage = 
  "stripHeaderComments[header] removes commentary entries from each \
header key value.";
JoinHeader::usage = 
  "JoinHeader[\!\(\*SubscriptBox[\(head\), \
\(1\)]\),\!\(\*SubscriptBox[\(head\), \(2\)]\)] returns a joined \
header with the duplicate entries in \!\(\*SubscriptBox[\(head\), \(1\
\)]\) replaced by a \"p\" character (e.g. pNAXIS instead of NAXIS).";
FindDuplicateHeaderKeys::usage = 
  "FindDuplicateHeaderKeys[\!\(\*SubscriptBox[\(head\), \
\(1\)]\),\!\(\*SubscriptBox[\(head\), \(2\)]\)] returns all header \
keys that occur in \!\(\*SubscriptBox[\(head\), \(1\)]\) and \
\!\(\*SubscriptBox[\(head\), \(2\)]\).";


flattenCube::usage = 
  "flattenCube[data,header] flattens out FITS data to be in accord \
with the header information.";

splitMultipleBintable::usage = 
  "splitMultipleBintable[data,header] splits a HICLASS file \
containing multiple BINTABLE's into a List of single BINTABLE \
datasets.";
splitMultipleBintable::xhead = "Unknown header format.";

FormatSpectrum::usage = 
  "formatSpectrum[data,header] formats the data as a spectrum data \
object of the form {header,y-data}.";
singleBintableQ::usage = 
  "singleBintableQ[head] returns True if the head was produced as \
output from HIPE-CLASS export or from Gildas-CLASS export as BINTABLE.";
hipeBintableQ::usage = 
  "hipeBintableQ[head] returns True if the head was produced as \
output from HIPE-CLASS export.";
classOriginQ::usage = 
  "classOriginQ[head] returns True if the head was produced as \
output from CLASS export.";
MetaDataPattern::usage = 
  "MetaDataPattern is a Pattern matching the MetaData part of a \
Spectrum data object.";
SpectrumPattern::usage = 
  "SpectrumPattern is a Pattern matching the Data part of a Spectrum \
data object.";
MetaDataQ::usage = 
  "MetaDataQ[head] returns True if head is a List of Rules.";
(*MissingQ::usage = "MissingQ[e] returns True if Head[e]===Missing.";*)
SpectrumQ::usage = 
  "SpectrumQ[spectrum] returns true if spectrum is of the form \
{Metadata, Data}, where Metadata is a List of Rules of the form key\
\[Rule]value, and Data is a Vector of y-values.";
MultipleSpectraQ::usage "MultipleSpectraQ[list] returns True if list \
is a List of Spectra.";
SpectrumArrayQ::usage = 
  "SpectrumArrayQ[array] returns True when array is an Array of \
spectra.";
SpectralAxisType::usage = 
  "SpectralAxisType[head] returns the type of the spectral axis from \
the head.";
VelocityAxisQ::usage = 
  "VelocityAxisQ[value] tests whether the key value identifying the \
spectral axis is in units of velocity.";
FrequencyAxisQ::usage = 
  "FrequencyAxisQ[value] tests wwhether the key value identifying the \
spectral axis is in units of a frequency.";
HeaderKeyExistsQ::usage = 
  "HeaderKeyExistsQ[head, key] tests whether the Metadata head contains the \
Keyword key.";

absoluteCoordinatesInTFIELDSQ::usage = 
  "absoluteCoordinatesInTFIELDSQ[data,header] tests whether absolute \
coordinate values (CRVAL) are stored in BINTABLE TFIELDS."  ;
relativeCoordinatesInTFIELDSQ::usage = 
  "relativeCoordinatesInTFIELDSQ[data,header] tests whether relative \
coordinate values (CDELT) are stored in BINTABLE TFIELDS.";
GetHeaderKeyValue::usage = 
  "GetHeaderKeyValue[head, key] retrieves the value of the the Metadata \
keyword key from the header."; 
PutHeaderKeyValue::usage = 
  "PutHeaderKeyValue[head, key\[Rule]value] (over)writes the entry key\
\[Rule]value into the header Metadata and returns the new header.";  
DeleteHeaderKey::usage= "DeleteHeaderKey[head, key] deletes the entry key from \
the Metadata head and returns the new header.";

FindSpectralAxis::usage = 
  "FindSpectralAxis[header] searches the FITS header (List of Rules) \
for the spectral axis (velocity, frequency, etc.).";
FindRAAxis::usage = 
  "FindRAAxis[header] searches the FITS header (List of Rules) for \
the Right Ascension coordinate axis.";
FindDecAxis::usage = 
  "FindDecAxis[header] searches the FITS header (List of Rules) for \
the Declination coordinate axis.";
FindSpectralAxis::xhead = "Unknown header format.";
FindRAAxis::xhead = "Unknown header format.";
FindDecAxis::xhead = "Unknown header format.";
SpectralAxisType::axisx ="Unknown spectral axis type.";

GetTFIELDDec::usage = 
  "GetTFIELDDec[FITSdata,FITSheader,coordKey] returns the Declination \
coordinates from the BINTABLE TFIELD entries in the FITS file created \
by CLASS. coordKey has to be either \"CRVAL\" or \"CDELT\", to get \
the absolute or relative (offset) coordinates of all spectra in the \
FITS file."; 
GetTFIELDRA::usage = 
  "GetTFIELDRA[FITSdata,FITSheader,coordKey] returns the Right \
Ascension coordinates from the BINTABLE TFIELD entries in the FITS \
file created by CLASS. coordKey has to be either \"CRVAL\" or \"CDELT\
\", to get the absolute or relative (offset) coordinates of all \
spectra in the FITS file."; 
GetTFIELDRA::xcoord = 
  "FITS coordinate fields have to be CDELT or CRVAL.";
GetTFIELDRA::nfound = "Could not find coordinate `1` in TFIELDS.";
GetTFIELDDec::xcoord = 
  "FITS coordinate fields have to be CDELT or CRVAL.";
GetTFIELDDec::nfound = "Could not find coordinate `1` in TFIELDS.";


GetDeltaRA::usage = "GetDeltaRA[data header] return a list of R.A. offsets 
stored in a HIPE-CLASS BINTABLE.";
GetDeltaDec::usage = "GetDeltaDec[data header] return a list of Declination offsets 
stored in a HIPE-CLASS BINTABLE.";
GetAbsRA::usage = "GetAbsRA[data header] return a list of R.A. CRVALs 
stored in a CLASS BINTABLE.";
GetAbsDec::usage = "GetAbsDec[data header] return a list of Declination CRVALs 
stored in a CLASS BINTABLE.";

GetDeltaDec::nfound = "Could not find coordinate offsets";
GetDeltaRA::nfound = "Could not find coordinate offsets";
GetDeltaDec::xhead = "Unknown header format.";
GetDeltaRA::xhead = "Unknown header format.";

calculateAxisValues::usage = 
  "calculateAxisValues[FITS header] calculates the physical scale of \
the {RA, Dec, Spectral} axes.";
ObservedCoordinates::usage = 
  "ObservedCoordinates[spectrum] returns the spherical coordinates of \
the observations as specified in the header MetaData, usually in the \
form of {R.A., Dec}.";
GetObservedCoordinates::usage = 
  "GetObservedCoordinates[spectrum] returns the spherical coordinates \
of the observations as specified in the header MetaData, usually in \
the form of {R.A., Dec}.";
GetCoordinateSystem::usage = 
  "GetCoordinateSystem[spectrum] returns the applied cordinate system \
as specified in the header MetaData. The first four characters give \
the type of celestial coordinate while the next four characters \
specify the type of projection. See (Greisen and Calabretta, 1994) \
for more details.";
GetAbsoluteSpectralAxis::usage = 
  "GetAbsoluteSpectralAxis[header] returns the explicit list of \
spectral values as specified in the spectrum FITS header."; 
ComposeXYSpectrum::usage = 
  "ComposeXYSpectrum[spectrum data] converts a spectrum (in the form \
{MetaData, {y1,y2,\[Ellipsis],yn}}) to a list of {x,y} data points \
with x being the spectral axis as specified in the MetaData header.";
RegridSpectralAxis::usage = 
  "RegridSpectralAxis[ref.spectrum, spectrum] performs a spectral \
regridding of the data in spectrum on to the spectral grid specified \
in the reference spectrum and returns a new spectrum data object with \
updated header Metadata und data points interpolated on the new \
spectral grid points.";
ToVelocity::usage = 
  "ToVelocity[f,\!\(\*SubscriptBox[\(f\), \(0\)]\)] converts a \
frequency f to the corresponding velocity shift using the radio \
astronomical convention v(f)=c(1-f/\!\(\*SubscriptBox[\(f\), \
\(0\)]\)). The frequency f and the rest frequency \!\(\*SubscriptBox[\
\(f\), \(0\)]\) have to be given in the same units. The output \
velocity is always in m/s.";
ToFrequency::usage = 
  "ToFrequency[v, \!\(\*SubscriptBox[\(f\), \(0\)]\)] converts a \
velocity to the corresponding frequency using the radio astronomical \
convention f(v)=\!\(\*SubscriptBox[\(f\), \(0\)]\)(1-v/c). The \
options VelocityUnits and FrequencyUnits allow to convert non-SI \
units and specify the units of the input variables. The output \
frequency is in Hz, and can be changed with the Option \
\"FrequencyOutputUnits\".";
SpectrumPlot::headx = "Unknown FITS header format.";
SpectrumPlot::datax = 
  "Unknown spectrum format. Provide a y-vector or a list of \
y-vectors.";
SpectrumPlot::usage = 
  "SpectrumPlot[spectrum] plots the spectrum versus the velocity \
axis, such that v=0 corresponds to the restfrequency as given by the \
header key \"RESTFREQ\". To assume a different rest frequency us the \
Option \"RestFrequency\". By default the x axis is given in untis of \
km/s. Use the Option \"VelocityUnits\" to use a different units (e.g. \
m/s, SI, cm/s, etc.). SpectrumPlot accepts all Options from \
ListPlot.";
BaselineDegree::usage = "The degree of the baseline polynomial.";
SetLineWindow::usage = 
  "List of line windows (masked parts of the spectrum) to ignore in \
the baseline fitting.";
SubtractBaseline::usage = 
  "SubtractBaseline[spectrum] performs a polynomial fit to the \
spectrum data (provide the Option BaselineDegree->n to use a \
polynomial of Degree 2) and subtracts the result from the original \
data. The RMS of the fit is written into the header (key \
\"RMS_____\"). The result is returned as spectrum data object. \
SubtractBaseline accepths a masked spectrum MaskedSpectrum[spec] as \
argument.";
MaskSpectrum::usage = 
  "MaskSpectrum[spectrum, {{\!\(\*SubscriptBox[\(v\), \(1, \
min\)]\),\!\(\*SubscriptBox[\(v\), \(1, \
max\)]\)},\[Ellipsis]},\!\(\*SubscriptBox[\(f\), \(0\)]\)] mask one \
or more intervals {\!\(\*SubscriptBox[\(v\), \(1, \
min\)]\),\!\(\*SubscriptBox[\(v\), \(1, max\)]\)} from the spectrum \
(replaces them by Missing[]). Masked portions of a spectrum will not \
be considered while doing baseline fitting or Gaussian fitting.";

SpectralAxisConfiguration::usage = 
  "SpectralAxisConfiguration[spec] returns the header information of \
the spectral axis in the form {type, CRPIX, CDELT, CRVAL, \
(N|M)AXIS}.";

AverageSpectrum::usage = 
  "AverageSpectrum[{\!\(\*SubscriptBox[\(spec\), \
\(1\)]\),\!\(\*SubscriptBox[\(spec\), \(1\)]\),\[Ellipsis]}] returns \
and average spectrum from the provided list of spectra. Available \
Methods are \"Mean\" and \"RMS\". The necessary list of RMS's is \
either pulled from the spectra headers or provided as a list to the \
Option \"RMSList\". The result is given as a spectrum data object \
with the header \!\(\*SubscriptBox[\(spec\), \(1\)]\) and the \
additional key \"AVERAGED\"\[Rule]\"Mean\"|\"RMS\".";
AverageSpectrum::xlen = "Spectra of unequal length.";
AverageSpectrum::xrms = "Missing RMS information.";
AverageSpectrum::xspecax = "Spectra have incompatible spectral axes.";
CalculateRMS::usage = 
  "CalculateRMS[spec] returns the RMS of the povided spectrum (or \
list of spectra). CalculateRMS accepts masked spectra as input.";
SmoothSpectrum::evenwidth = "KernelWidth has to be an odd integer.";
SmoothSpectrum::usage::evenwidth = 
  "SmoothSpectrum[spec] returns the smoothed spectrum of spec. The \
default method is a moving average (Method\[Rule]\"MovingAverage\") \
smoothing. Other methods are \"Hanning\", \"Hamming\", and \"Gaussian\
\" smoothing (requires the additional Option \"GaussianFWHM\"). \
\"KernelWidth\" and \"GaussianFWHM\" are given in numbers of bins \
(not in physical units). The \"KernelWidth\" has to an odd integer \
(default 3)! The smoothed spectrum is padded on both edges with \
n=(kernel width -1)/2 Missing[] values.";
ListTFIELDS::usage = 
  "ListTFIELDS[header] lists the descriptions of all TFIELD keys in \
the BINTABLE header.";

ListTFIELDS::usage = 
  "ListTFIELDS[header] lists the descriptions of all TFIELD keys in \
the BINTABLE header.";

TFIELD2FITSKeys::usage = 
  "TFIELD2FITSKeys[data,header] creates FITS header entries from \
BINTABLE TFIELDS. One header per data is created."; 
TFIELD2FITSKeys::nhead = "No TFIELDS key in FITS header `1` found.";

HICLASSQ::usage = 
  "HICLASSQ[header] returns True if the header is of the type HICLASS";
PureDataTableQ::usage = 
  "PureDataTableQ[header] tests whether a header indicates a data \
table that purely consists of data (and no Metadata).";
HeaderKeyInDataQ::usage = 
  "HeaderKeyInDataQ[header, key] tests wheter keyvalues are written in the \
BINTABLE TFIELDS.";


IntegrateSpectrum::usage = 
  "IntegrateSpectrum[spectrum,range], integrates the spectrum across \
the (spectral/velocity) range.";

IntegratedIntensityArray::usage="IntegratedIntensityArray[spectrum,range], integrates the all spectra in a cube across \
the (spectral/velocity) range.";

calculateCubeDimensions::usage = 
  "calculateCubeDimensions[header] returns the range specifications \
of a data cube from the FITS header in the form {min, max, delta} for \
each dimension.";


PositionsInCube::usage = 
  "PositionsInCube[header] returns a list of all spatial positions \
contained in the FITS data cube described by the FITS header. It \
accepts the Options \"RelativeRAOffset\" (True/False), \
\"RelativeDecOffset\"(True/False), \"AngularUnits\" (e.g., \
\"d\",\"m\",\"s\"), \"CoordinateSystem\"(\"Celestial\" or \
\"Image\").";
PositionsInPolygon::usage = 
  "PositionsInPolygon[header,poly] returns a list of all spatial \
positions contained in the FITS data cube that overlap with a \
geometrical region described by poly. The data cube is described by \
the FITS header. The geometrical region can be any Graphics \
Primitives that descibe a geometrical area, for example Disk, \
Rectangle, Polygon, etc.. It accepts the Options \"RelativeRAOffset\" \
(True/False), \"RelativeDecOffset\"(True/False), \"AngularUnits\" \
(e.g., \"d\",\"m\",\"s\"), \"CoordinateSystem\"(\"Celestial\" or \
\"Image\"), \"ShowGrid\" (False or True).";

extractCubeAxes::usage = 
  "extractCubeAxes[header] returns the axes desciptors from the FITS \
header. For each dimensions it returns a list \
{crpix,cdelt,crval,naxisi,i}, where i is the index of the dimension. \
The lists are in the order {RA,Dec,spectral}.";

PixelToRA::usage = 
  "PixelToRA[i,header] converts the pixel coordinate of a FITS map to \
right ascension values. The array coordinate i can take real values. \
The default options are \"Offset\"\[Rule]True and \"AngularUnits\"\
\[Rule]\"ArcSec\".";
RAToPixel::usage = 
  "RAToPixel[R.A.,header] converts the right ascension to pixel \
coordinates of a FITS map. The array coordinate i can take real \
values. The default  options are \"Offset\"\[Rule]True and \
\"AngularUnits\"\[Rule]\"ArcSec\".";

PixelToDec::usage = 
  "PixelToDec[i,header] converts the pixel coordinate of a FITS map \
to declination values. The array coordinate i can take real values. \
The default options are \"Offset\"\[Rule]True and \"AngularUnits\"\
\[Rule]\"ArcSec\".";
DecToPixel::usage = 
  "DecToPixel[Dec,header] converts the declination to pixel \
coordinates of a FITS map. The array coordinate i can take real \
values. The default  options are \"Offset\"\[Rule]True and \
\"AngularUnits\"\[Rule]\"ArcSec\".";

ToPixel::usage = 
  "ToPixel[{RA,Dec},header] converts from celestial coordinates \
{RA,Dec} to pixel, i.e. image coordinates. By default it returns \
integer coordinates, i.e. the image pixel closest to the given \
coordinates. To allow for non-integer pixel coordinates use \
\"IntegerCoordinates\"\[Rule]False. Note, that image coordinates are \
stored in the order {column, row}.";

FromPixel::usage = 
  "FromPixel[{row,column},header] converts from image coordinates \
{row,column} to celestial coordinates {RA,Dec}. By default it returns \
ungridded  coordinates, i.e. positions not corresponding to the image \
pixel in the map. To return gridded  coordinates use \
\"IntegerCoordinates\"\[Rule]True. Note, that image coordinates are \
stored in the order {column, row} but while celestial coordinates are \
store in {RA,Dec} order.";







(*-----------Example data-------------------*)

exData::usage="Collection of data FITS files."

multipleBintableQ
Begin["`Private`"]

(* Implementation of the package *)
$datalocation = FileNameJoin[{DirectoryName[$InputFileName],"ExampleData"}];

(* System`Private`$InputFileName seems to be backward vcompatible *)
Unprotect[ExampleData]
ExampleData[{"SpectrumPlot", "BIMAChannelMap"}]={Import[#,"Metadata"],Import[#,"RawData"]}&@FileNameJoin[{$datalocation,"IC342.12motf.chan.fits"}];
ExampleData[{"SpectrumPlot", "HIFIDBSPoint"}]={Import[#,"Metadata"],Import[#,"RawData"]}&@FileNameJoin[{$datalocation,"1342256463_HRS-V-USB_HifiPointModeDBS_HPoint-CO16-15_tag_level2.fits"}];
ExampleData[{"SpectrumPlot", "HIFIFastDBSPoint"}]={Import[#,"Metadata"],Import[#,"RawData"]}&@FileNameJoin[{$datalocation,"1342246023_WBS-H-LSB_HifiPointModeFastDBS_DR21-H2Oplus-1816_tag_level2_corrected_average_1342246023.fits"}];
ExampleData[{"SpectrumPlot", "HIFIOTFMap"}]={Import[#,"Metadata"],Import[#,"RawData"]}&@FileNameJoin[{$datalocation,"1342245386_WBS-H-USB_HifiMappingModeOTF_HMap-N-SOTF13CO5-4_tag_level2.fits"}];
ExampleData[{"SpectrumPlot", "HIFIDBSRasterMap"}]={Import[#,"Metadata"],Import[#,"RawData"]}&@FileNameJoin[{$datalocation,"1342256469_WBS-H-USB_HifiMappingModeDBSRaster_HMap-N-SDBSwRasterCO15-14_tag_level2_corrected_single_1342190806.fits"}];

ExampleData[{"SpectrumPlot", "List"}]={"BIMAChannelMap","HIFIDBSPoint","HIFIFastDBSPoint","HIFIOTFMap","HIFIDBSRasterMap"};
Protect[ExampleData]

(* Patterns & Tests *)

singleBintableQ[header_List] /; Length[header] == 2 :=
    (MemberQ[Flatten[{GetHeaderKeyValue[CleanFITSHeader[header], 
      "TYPE"]}], "HICLASS"] || 
  MemberQ[Flatten[{GetHeaderKeyValue[CleanFITSHeader[header], 
      "ORIGIN"]}], "CLASS-Gildas"]) &&
     TrueQ[Count[
        Flatten[{GetHeaderKeyValue[CleanFITSHeader[header], "XTENSION"]}], 
        "BINTABLE"] == 1]
singleBintableQ[_]:=False
multipleBintableQ[header_List] /; Length[header] >= 2 :=
    MemberQ[Flatten[{GetHeaderKeyValue[CleanFITSHeader[header], "TYPE"]}], 
      "HICLASS"] &&
     TrueQ[Count[Flatten[{"XTENSION" /. CleanFITSHeader[header]}], 
        "BINTABLE"] > 1]
multipleBintableQ[_]:=False  
classOriginQ[header_List] := (GetHeaderKeyValue[header, "ORIGIN"] == 
    "CLASS-Gildas") && (GetHeaderKeyValue[header, "CREATOR"] == 
    "CLASS-Gildas")     
hipeBintableQ[header_List] :=
    (singleBintableQ[header] || multipleBintableQ[header])&&(!classOriginQ[header])
MetaDataPattern = List[a__Rule];
SpectrumPattern = _?(VectorQ[#, (NumericQ[#] || MissingQ[#]) &] &);

MetaDataQ[dat_] :=
    MatchQ[dat, MetaDataPattern]
SpectrumQ[spec_] :=
    MatchQ[spec, {MetaDataPattern, SpectrumPattern}]
MultipleSpectraQ[spec_] :=
    MatchQ[spec, List[{MetaDataPattern, SpectrumPattern} ..]]
(*MissingQ[patt_] :=
    Head[patt] === Missing*)
SpectrumArrayQ[spec_] :=
    MatchQ[spec , {{__?SpectrumQ} ..}]
SpectralAxisType[header_?hipeBintableQ] :=
    Module[ {cleanhead, naxis, cdelttab, type},
        cleanhead = Flatten@CleanFITSHeader[Rest@header];
        (*number of axes*)
        naxis = IntegerPart["NAXIS" /. cleanhead];
        cdelttab = 
         Flatten[Table["CTYPE" <> ToString[i], {i, 1, naxis}] /. cleanhead];
        type = Cases[
          cdelttab, (a_ /; 
            MemberQ[List["FREQ", "VELO", "VELO-LSR", "VELO-HEL", 
              "VELO-OBS","VELOCITY","VRAD","LAMBDA"], a])];
        If[ Length[type] =!= 1,
            Message[SpectralAxisType::axisx];
            Abort[],
            First[type]
        ]
    ]
SpectralAxisType[header_] :=
    Module[ {cleanhead, naxis, cdelttab, type},
        cleanhead = CleanFITSHeader[header];
        (*number of axes*)
        naxis = IntegerPart["NAXIS" /. cleanhead];
        cdelttab = Table["CTYPE" <> ToString[i], {i, 1, naxis}] /. cleanhead;
        type = Cases[
          cdelttab, (a_ /; 
            MemberQ[List["FREQ", "VELO", "VELO-LSR", "VELO-HEL", 
              "VELO-OBS","VELOCITY","VRAD","LAMBDA"], ToUpperCase@a])];
        If[ Length[type] =!= 1,
            Message[SpectralAxisType::axisx];
            Abort[],
            First[ToUpperCase@type]
        ]
    ]
VelocityAxisQ[keyword_] :=
    MemberQ[List["VELO", "VELOCITY", "VELO-LSR", "VELO-HEL", "VELO-OBS","VELOCITY","VRAD","LAMBDA"],
      keyword]
FrequencyAxisQ[keyword_] :=
    MemberQ[List["FREQ"], keyword]

HICLASSQ[head_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    Module[ {clean = CleanFITSHeader[head]},
        If[ HeaderKeyExistsQ[clean, "TYPE"],
            GetHeaderKeyValue[clean, "TYPE"] == "HICLASS",
            False
        ]
    ]
HICLASSQ[head_?hipeBintableQ] :=
    Module[ {clean = CleanFITSHeader[head]},
        If[ HeaderKeyExistsQ[clean, "TYPE"],
            GetHeaderKeyValue[clean, "TYPE"] == "HICLASS",
            False
        ]
    ]
HICLASSQ[_] :=
    False

HeaderKeyExistsQ[head_, key_String] :=
    TrueQ[Count[head, Rule[key,_], Infinity] > 0]

PureDataTableQ[{head1_?(MatchQ[#, {Rule[_, _] ..}] &), 
    head2_?(MatchQ[#, {Rule[_, _] ..}] &)}] :=
    Module[ {clean1 = CleanFITSHeader[head1], 
      clean2 = CleanFITSHeader[head2]},
        Which[HICLASSQ[clean1] && GetHeaderKeyValue[clean2, "TFIELDS"] == 1 && 
          GetHeaderKeyValue[clean2, "TTYPE1"] == "DATA", True, 
         GetHeaderKeyValue[clean2, "TFIELDS"] == 1 && 
          GetHeaderKeyValue[clean2, "TTYPE1"] == "DATA", True, True, False]
    ];
PureDataTableQ[head1_?(MatchQ[#, {Rule[_, _] ..}] &), 
  head2_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    PureDataTableQ[{head1, head2}]
PureDataTableQ[head1_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    Module[ {clean1 = CleanFITSHeader[head1]},
        Which[HeaderKeyExistsQ[clean1, "TFIELDS"], 
         If[ GetHeaderKeyValue[clean1, "TFIELDS"] == 1 && 
           GetHeaderKeyValue[clean1, "TTYPE1"] == "DATA",
             True,
             False
         ], True, 
         False]
    ]
PureDataTableQ[___] :=
    False

HeaderKeyInDataQ[head_?singleBintableQ, key_String] :=
    Module[ {clean = CleanFITSHeader[head], ttypes, tnum},
        tnum = 0;
        If[ HeaderKeyExistsQ[clean, "TFIELDS"],
            tnum = GetHeaderKeyValue[clean, "TFIELDS"]
        ];
        If[ tnum > 0,
            ttypes = 
             Table[GetHeaderKeyValue[clean, "TTYPE" <> ToString[i]], {i, 1, tnum}],
            ttypes = {}
        ];
        MemberQ[ttypes, key]
    ]
HeaderKeyInDataQ[head_?(MatchQ[#, {Rule[_, _] ..}] &), key_String] :=
    Module[ {clean = CleanFITSHeader[head], ttypes, tnum},
        tnum = 0;
        If[ HeaderKeyExistsQ[clean, "TFIELDS"],
            tnum = GetHeaderKeyValue[clean, "TFIELDS"]
        ];
        If[ tnum > 0,
            ttypes = 
             Table[GetHeaderKeyValue[clean, "TTYPE" <> ToString[i]], {i, 1, tnum}],
            ttypes = {}
        ];
        MemberQ[ttypes, key]
    ]

HeaderKeyInDataQ[___] :=
    False

absoluteCoordinatesInTFIELDSQ[data_, header_?classOriginQ] :=
 Module[{head = CleanFITSHeader[header], tfields, ttypekeays},
  tfields = GetHeaderKeyValue[head[[2]], "TFIELDS"];
  (*If only one data set,
  then the coordinate offset is taken from the extended header,
  therefore,no TTYPE variable is necessary*)
  (*which TTYPE holds the RA/DECT?*)
  ttypekeays = 
   Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 1, 
     tfields}];
  MemberQ[ttypekeays, a_ /; StringMatchQ[a, "CRVAL" ~~ NumberString]]]

absoluteCoordinatesInTFIELDSQ[data_, 
   header_] := (Message[absoluteCoordinatesInTFIELDSQ::xhead];
   Abort[]);

relativeCoordinatesInTFIELDSQ[data_, header_?classOriginQ] :=
 Module[{head = CleanFITSHeader[header],  tfields, ttypekeays},
  tfields = GetHeaderKeyValue[head[[2]], "TFIELDS"];
  (*If only one data set,
  then the coordinate offset is taken from the extended header,
  therefore,no TTYPE variable is necessary*)
  (*which TTYPE holds the RA/DECT?*)
  ttypekeays = 
   Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 1, 
     tfields}];
  MemberQ[ttypekeays, a_ /; StringMatchQ[a, "CDELT" ~~ NumberString]]]
  
relativeCoordinatesInTFIELDSQ[data_, 
   header_] := (Message[relativeCoordinatesInTFIELDSQ::xhead];
   Abort[]);
   
freqInTFIELDSQ[data_, 
  head_] := (HeaderKeyExistsQ[TFIELD2FITSKeys[data, head], 
    "RESTFREQ"] && 
   GetHeaderKeyValue[head, 
     "CRVAL" <> ToString[FindSpectralAxis[head]]] == 0)






(* Header related functions *)

CleanFITSHeader[spec_?SpectrumQ] :=
    CleanFITSHeader[spec[[1]]]
(*CleanFITSHeader[head_?(MatchQ[#,{Rule[_,_]..}]&)]:=Which[
MatchQ[head[[1]],Rule[_,{_,__}]],head/.{Rule[a_,{b_,___}]:>Rule[a,b]},
MatchQ[head[[1]],Rule[_,_]],head,
True,Message[CleanFITSHeader::headx];
Abort[]];
CleanFITSHeader[head_?hipeBintableQ]:=CleanFITSHeader[head[[2]]]*)
CleanFITSHeader[head_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    Map[StripHeaderComments, head]
CleanFITSHeader[head_?(MatchQ[#, {{Rule[_, _] ..} ..}] &)] :=
    Map[StripHeaderComments, head, Infinity]


JoinHeader[head_?(MatchQ[#, {{Rule[_, _] ..}, {Rule[_, _] ..}}] &)] :=
    Module[ {h1 = head[[1]], h2 = head[[2]], duplicates, newkeys, 
     newhead1},
        duplicates = FindDuplicateHeaderKeys[head];
        newkeys = "p" <> # & /@ duplicates;
        newhead1 = h1 /. Thread[Rule[duplicates, newkeys]];
        Join @@ Map[StripHeaderComments, {newhead1, h2}, Infinity]
    ]
JoinHeader[head_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    head
JoinHeader[head_] :=
    head


ListTFIELDS[head_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    Module[ {clean = CleanFITSHeader[head], tnum},
        If[ HeaderKeyExistsQ[clean, "TFIELDS"],
            tnum = GetHeaderKeyValue[clean, "TFIELDS"],
            tnum = 0
        ];
        If[ tnum > 0,
            Table[GetHeaderKeyValue[clean, "TTYPE" <> ToString[i]], {i, 1, 
              tnum}],
            {}
        ]
    ]
ListTFIELDS[head_?singleBintableQ] :=
    Module[ {clean = CleanFITSHeader[head[[2]]], tnum},
        If[ HeaderKeyExistsQ[clean, "TFIELDS"],
            tnum = GetHeaderKeyValue[clean, "TFIELDS"],
            tnum = 0
        ];
        If[ tnum > 0,
            Table[GetHeaderKeyValue[clean, "TTYPE" <> ToString[i]], {i, 1, 
              tnum}],
            {}
        ]
    ]
ListTFIELDS[_] :=
    {}

TFIELD2FITSKeys[data_, header_?singleBintableQ] /; 
  HeaderKeyExistsQ[header, "TFIELDS"] := Module[{
   head = CleanFITSHeader[header], RAaxis, numdatasets, tfields, tpos,
    res, ttypekeys, numDSET},
  tfields = GetHeaderKeyValue[head[[2]], "TFIELDS"];
  (*If only one data set,
  then the coordinate offset is taken from the extended header,
  therefore,no TTYPE variable is necessary*)
  ttypekeys = ListTFIELDS[head];
  tpos = Most /@ findData[data, head];
  DeleteHeaderKey[
     Thread[Rule[ttypekeys, data[[Sequence @@ #]]]], {"SPECTRUM", 
      "DATA"}] & /@ tpos
  ]
TFIELD2FITSKeys[data_, 
   header_] := (Message[TFIELD2FITSKeys::nhead, header];
   Abort[]);

StripHeaderComments[key_?(MatchQ[#, Rule[_, _]] &)] :=
    key /. {Rule[a_, {b_, ___}] :> Rule[a, b]}
StripHeaderComments[key_] :=
    key


FindDuplicateHeaderKeys[
  head_?(MatchQ[#, {{Rule[_, _] ..}, {Rule[_, _] ..}}] &)] :=
    Module[ {h1 = head[[1]], h2 = head[[2]], duplicates, keys1, keys2},
        keys1 = h1 /. {Rule[a_, b_] :> a};
        keys2 = h2 /. {Rule[a_, b_] :> a};
        duplicates = Intersection[keys1, keys2]
    ]
FindDuplicateHeaderKeys[head1_?(MatchQ[#, {Rule[_, _] ..}] &), 
  head2_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    FindDuplicateHeaderKeys[{head1, head2}]
Clear[GetHeaderKeyValue];
GetHeaderKeyValue[head_, 
  key_String] :=
    ((Flatten[
    Extract[head, 
    Position[head, key -> _]]] /. {Rule[a_, {b_, __}] :> b, 
    Rule[a_, b_] :> b}) /. {a_} -> a)/. a_String :> First[ImportString[a, "List"]]


PutHeaderKeyValue[head_?(MatchQ[#, List[__Rule]] &), 
   Rule[key_String, val_]] /; (key != "COMMENT" && key != "HISTORY") :=
    If[ HeaderKeyExistsQ[head, key],
        head /. Rule[key, _] :> Rule[key, val],
        Flatten[{head, Rule[key, val]}],
        0
    ]
PutHeaderKeyValue[head_?(MatchQ[#, {List[__Rule] ..}] &), 
   Rule[key_String, val_]] /; (key != "COMMENT" && key != "HISTORY") :=
    Map[PutHeaderKeyValue[#, Rule[key, val]] &, head]
PutHeaderKeyValue[head_, 
   Rule[key_String, val_]] /; (key == "COMMENT" || key == "HISTORY") :=
    Module[ {pos},
        pos = Position[head, key];
        If[ pos != {},
            pos = Last[Position[head, key]] // First
        ];
        If[ NumberQ[pos],
            Insert[head, Rule[key, val], pos + 1],
            Insert[head, Rule[key, val], -1]
        ]
    ]
PutHeaderKeyValue[head_List /; MatchQ[head, MetaDataPattern], 
  keys_List /; MatchQ[keys, MetaDataPattern]] :=
    Fold[PutHeaderKeyValue, head, keys]
PutHeaderKeyValue[head_, 
  Rule[key_String, val_]] :=
    (Message[PutHeaderKeyValue::xkey, 
    Rule[key, val]];
     head)
DeleteHeaderKey[head_, key_] :=
    If[ HeaderKeyExistsQ[head, key],
        DeleteCases[head, Rule[key, _], Infinity],
        head
    ]
DeleteHeaderKey[head_, keys_List] :=
    Fold[DeleteHeaderKey, head, keys]

FindSpectralAxis[header_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    Module[ {cleanhead, naxis, cdelttab, axiskey},
        cleanhead = CleanFITSHeader[header];
        (*number of axes*)
        If[ (HeaderKeyExistsQ[header, "CLASS___"] && 
        Flatten[{GetHeaderKeyValue[header, "CLASS___"]}][[1]] == 
        "herschel.ia.dataset.TableDataset") || (HeaderKeyExistsQ[header, 
        "MATRIX"] && HeaderKeyExistsQ[header, "MAXIS"] && 
        HeaderKeyExistsQ[header, "NAXIS"]),
            axiskey = "MAXIS",
            axiskey = "NAXIS"
        ];
        naxis = IntegerPart[GetHeaderKeyValue[cleanhead, axiskey]];
        cdelttab = 
         Table[GetHeaderKeyValue[cleanhead, "CTYPE" <> ToString[i]], {i, 1, 
           naxis}];
         If[DeleteMissing[cdelttab] != cdelttab, 
           cdelttab = DeleteMissing[cdelttab]; 
           naxis = Length[DeleteMissing[cdelttab]]
           ];
        Position[
          cdelttab, (a_ /; 
            MemberQ[List["FREQ", "VELO", "VELOCITY", "VELO-LSR", "VELO-HEL", 
              "VELO-OBS","VRAD","LAMBDA"], ToUpperCase@a])][[1, 1]]
    ]
FindSpectralAxis[header_?singleBintableQ] :=
    FindSpectralAxis[header[[2]]]
FindSpectralAxis[header_] :=
    (Message[FindSpectralAxis::xhead];
     Abort[])

FindRAAxis[header_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    Module[ {cleanhead, naxis, cdelttab, axiskey,pos},
        cleanhead = CleanFITSHeader[header];
        (*number of axes*)
        If[ (HeaderKeyExistsQ[header, "CLASS___"] && 
        Flatten[{GetHeaderKeyValue[header, "CLASS___"]}][[1]] == 
        "herschel.ia.dataset.TableDataset") || ((HeaderKeyExistsQ[header, 
     "MATRIX"] || (HeaderKeyExistsQ[header, "EXTNAME"] && 
      GetHeaderKeyValue[header, "EXTNAME"] == "MATRIX")) && 
  HeaderKeyExistsQ[header, "MAXIS"] && 
  HeaderKeyExistsQ[header, "NAXIS"]),
            axiskey = "MAXIS",
            axiskey = "NAXIS"
        ];
        naxis = IntegerPart[GetHeaderKeyValue[cleanhead, axiskey]];
        cdelttab = 
         Table[GetHeaderKeyValue[cleanhead, "CTYPE" <> ToString[i]], {i, 1, 
           naxis}];
        If[DeleteMissing[cdelttab] != cdelttab, 
           cdelttab = DeleteMissing[cdelttab]; 
           naxis = Length[DeleteMissing[cdelttab]]
           ];
        pos = Position[
          StringMatchQ[
           ToUpperCase /@ cdelttab, ("RA" ~~ ___) | ("GLON" ~~ ___)], 
          True];
        If[ pos=!={},
            pos[[1, 1]],
            {}
        ]
    ]
FindRAAxis[header_?singleBintableQ] :=
    FindRAAxis[header[[2]]]
    FindRAAxis[header_?multipleBintableQ] := 
FindRAAxis /@ header[[2 ;; -1]]
FindRAAxis[header_] :=
    (Message[FindRAAxis::xhead];
     Abort[])

FindDecAxis[header_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    Module[ {cleanhead, naxis, cdelttab, axiskey,pos},
        cleanhead = CleanFITSHeader[header];
        (*number of axes*)
        If[ (HeaderKeyExistsQ[header, "CLASS___"] && 
        Flatten[{GetHeaderKeyValue[header, "CLASS___"]}][[1]] == 
        "herschel.ia.dataset.TableDataset") || ((HeaderKeyExistsQ[header, 
     "MATRIX"] || (HeaderKeyExistsQ[header, "EXTNAME"] && 
      GetHeaderKeyValue[header, "EXTNAME"] == "MATRIX")) && 
  HeaderKeyExistsQ[header, "MAXIS"] && 
  HeaderKeyExistsQ[header, "NAXIS"]),
            axiskey = "MAXIS",
            axiskey = "NAXIS"
        ];
        naxis = IntegerPart[GetHeaderKeyValue[cleanhead, axiskey]];
        cdelttab = 
         Table[GetHeaderKeyValue[cleanhead, "CTYPE" <> ToString[i]], {i, 1, 
           naxis}];
         If[DeleteMissing[cdelttab] != cdelttab, 
           cdelttab = DeleteMissing[cdelttab]; 
           naxis = Length[DeleteMissing[cdelttab]]
           ];
        pos=Position[
          StringMatchQ[
           ToUpperCase /@ cdelttab, ("DEC" ~~ ___) | ("GLAT" ~~ ___)], 
          True];
        If[pos=!={},pos[[1, 1]],{}]
    ]
FindDecAxis[header_?singleBintableQ] :=
    FindDecAxis[header[[2]]]
FindDecAxis[header_?multipleBintableQ] := 
 FindDecAxis /@ header[[2 ;; -1]]
(*FindDecAxis[header_]/;Message[FindDecAxis::xhead]:=Abort[]*)
FindDecAxis[header_] :=
    (Message[FindDecAxis::xhead];
     Abort[])


(* Spectrum formatting (functions taking data and header info) *)

flattenCube[data_?(MatchQ[#, {{___}}] &), header_] :=
    Module[ {head = CleanFITSHeader[header], deltaDepth},
        deltaDepth = Depth[data] - GetHeaderKeyValue[head, "NAXIS"] - 1;
        If[ deltaDepth > 0,
            Flatten[data, deltaDepth],
            data
        ]
    ];
flattenCube[data_, header_] :=
    data

findData[data_, header_?(MatchQ[#, {Rule[_, _] ..}] &)] :=
    Module[ {head = CleanFITSHeader[header]},
        Position[data, a_List /; (Length[a] == "MAXIS1") /. head]
    ]
findData[data_, header_?hipeBintableQ] :=
    Module[ {},
        Position[data, 
         a_List /; Length[a] == "MAXIS1" /. CleanFITSHeader[header[[2]]]]
    ]
findData[data_, header_?classOriginQ] := 
 Module[{}, 
  Position[data, 
   a_List /; Length[a] == "MAXIS1" /. CleanFITSHeader[header[[2]]]]]

findDeltaRA[data_, header_?hipeBintableQ] :=
    Module[ {head = CleanFITSHeader[header], pos, RAaxis, ctype1, ctype2, 
     ttype1, ttype2, subpos},
        RAaxis = FindRAAxis[head[[2]]];
        (* so far only for CLASS-FITS*)
        ttype1 = GetHeaderKeyValue[head[[2]], "TTYPE1"];
        ttype2 = GetHeaderKeyValue[head[[2]], "TTYPE2"];
        ctype1 = GetHeaderKeyValue[head[[2]], "CTYPE" <> StringTake[ttype1, -1]];
        ctype2 = GetHeaderKeyValue[head[[2]], "CTYPE" <> StringTake[ttype2, -1]];
        (*Print[{ttype1,ttype2,ctype1,ctype2}];*)
        If[ StringTake[ctype1, 2] == "RA",
            subpos = 1,
            subpos = 2
        ];
        pos = Position[data, a_List /; Length[a] == "MAXIS1" /. head[[2]]];
        (*Print[pos];*)
        pos[[All, -1]] = Table[subpos, {Length[pos]}];
        pos
    ]
findDeltaDec[data_, header_?hipeBintableQ] :=
    Module[ {head = CleanFITSHeader[header], pos, RAaxis, ctype1, ctype2, 
       ttype1, ttype2, subpos},
        RAaxis = FindRAAxis[head[[2]]];
        (* so far only for CLASS-FITS*)
        ttype1 = GetHeaderKeyValue[head[[2]], "TTYPE1"];
        ttype2 = GetHeaderKeyValue[head[[2]], "TTYPE2"];
        ctype1 = GetHeaderKeyValue[head[[2]], "CTYPE" <> StringTake[ttype1, -1]];
        ctype2 = GetHeaderKeyValue[head[[2]], "CTYPE" <> StringTake[ttype2, -1]];
        (*Print[{ttype1,ttype2,ctype1,ctype2}];*)
        If[ StringTake[ctype1, 3] == "DEC",
            subpos = 1,
            subpos = 2
        ];
        pos = Position[data, a_List /; Length[a] == "MAXIS1" /. head[[2]]];
        pos[[All, -1]] = Table[subpos, {Length[pos]}];
        pos
    ]
    
GetTFIELDRA[data_, header_?classOriginQ, absrel_: "CDELT"] /; 
  MemberQ[{"CDELT", "CRVAL"}, absrel] := 
 Module[{head = CleanFITSHeader[header], RAaxis, numdatasets, tfields,
    tpos, res, numDSET,ttypekeys}, RAaxis = FindRAAxis[head[[2]]];
  (*so far only for CLASS-FITS*)
  tfields = GetHeaderKeyValue[head[[2]], "TFIELDS"];
  (* Check whether CRVAL or CDELT values appear in the TFIELDS *)
  If[! MemberQ[
     Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 
       1, tfields}], a_ /; StringMatchQ[a, absrel ~~ NumberString]], 
   Message[GetTFIELDDec::nfound, absrel]; Abort[]];
  (*If only one data set,
  then the coordinate offset is taken from the extended header,
  therefore,no TTYPE variable is necessary*)
  numdatasets = GetHeaderKeyValue[head[[2]], "NAXIS2"];
  (*Number of DSETS,i.e.SUBSCANS in CLASS*)
  numDSET = GetHeaderKeyValue[head[[1]], "DSETS___"];
  If[numDSET == {}, numDSET = 1];
  If[numdatasets == 1, 
   res = {GetHeaderKeyValue[head[[2]], 
      absrel <> ToString[RAaxis]]},(*which TTYPE holds the Dec CDELT?*)

   
   ttypekeys = 
    Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 1,
       tfields}];
   tpos = Position[ttypekeys, absrel <> ToString[RAaxis]][[1, 1]];
   If[NumberQ[tpos] && numDSET == 1, 
    res = Table[data[[2, i, tpos]], {i, 1, numdatasets}];
    If[! VectorQ[res, NumberQ], Message[GetTFIELDDec::nfound, absrel];
     Abort[]]];
   If[NumberQ[tpos] && numDSET > 1, 
    res = Table[
      Table[data[[1 + j, i, tpos]], {i, 1, numdatasets}], {j, 1, 
       numDSET}];
    If[! And @@ (VectorQ[#, NumberQ] & /@ res), 
     Message[GetTFIELDDec::nfound, absrel];
     Abort[]]];];
  res]
GetTFIELDRA[___] := Abort[]

GetTFIELDDec[data_, header_?classOriginQ, absrel_: "CDELT"] /; 
  MemberQ[{"CDELT", "CRVAL"}, absrel] := 
 Module[{head = CleanFITSHeader[header], Decaxis, numdatasets, 
   tfields, tpos, res, numDSET, ttypekeys}, 
  Decaxis = FindDecAxis[head[[2]]];
  (*so far only for CLASS-FITS*)
  tfields = GetHeaderKeyValue[head[[2]], "TFIELDS"];
  (* Check whether CRVAL or CDELT values appear in the TFIELDS *)
  If[! MemberQ[
     Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 
       1, tfields}], a_ /; StringMatchQ[a, absrel ~~ NumberString]], 
   Message[GetTFIELDDec::nfound, absrel]; Abort[]];
  (*If only one data set,
  then the coordinate offset is taken from the extended header,
  therefore,no TTYPE variable is necessary*)
  numdatasets = GetHeaderKeyValue[head[[2]], "NAXIS2"];
  (*Number of DSETS,i.e.SUBSCANS in CLASS*)
  numDSET = GetHeaderKeyValue[head[[1]], "DSETS___"];
  If[numDSET == {}, numDSET = 1];
  If[numdatasets == 1, 
   res = {GetHeaderKeyValue[head[[2]], 
      absrel <> 
       ToString[Decaxis]]},(*which TTYPE holds the Dec CDELT?*)
   ttypekeys = 
    Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 1,
       tfields}];
   tpos = Position[ttypekeys, absrel <> ToString[Decaxis]][[1, 1]];
   If[NumberQ[tpos] && numDSET == 1, 
    res = Table[data[[2, i, tpos]], {i, 1, numdatasets}];
    If[! VectorQ[res, NumberQ], Message[GetTFIELDDec::nfound, absrel];
     Abort[]]];
   If[NumberQ[tpos] && numDSET > 1, 
    res = Table[
      Table[data[[1 + j, i, tpos]], {i, 1, numdatasets}], {j, 1, 
       numDSET}];
    If[! And @@ (VectorQ[#, NumberQ] & /@ res), 
     Message[GetTFIELDDec::nfound, absrel];
     Abort[]]];];
  res]
GetTFIELDDec[___] := Abort[]

GetDeltaRA[data_, header_?classOriginQ] := 
 GetTFIELDRA[data, header, "CDELT"]
GetAbsRA[data_, header_?classOriginQ] := 
 GetTFIELDRA[data, header, "CRVAL"]
GetDeltaRA[data_, header_?hipeBintableQ] :=
    Module[ {head = CleanFITSHeader[header],  RAaxis,  
       numdatasets, tfields, tpos, res, numDSET},
        RAaxis = FindRAAxis[head[[2]]];
        (*so far only for CLASS-FITS*)
        tfields = GetHeaderKeyValue[head[[2]], "TFIELDS"];
        (* If only one data set, 
        then the coordinate offset is taken from the extended header, 
        therefore, no TTYPE variable is necessary*)
        numdatasets = GetHeaderKeyValue[head[[2]], "NAXIS2"];
        (* Number of DSETS, i.e. SUBSCANS in CLASS*)
        numDSET = GetHeaderKeyValue[head[[1]], "DSETS___"];
        If[ numdatasets == 1,
            res = {GetHeaderKeyValue[head[[2]], "CDELT" <> ToString[RAaxis]]},
            (* which TTYPE holds the RA CDELT? *)
            tpos = 
             Position[
               Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 1, 
                 tfields}], "CDELT" <> ToString[RAaxis]][[1, 1]];
            If[ NumberQ[tpos] && numDSET == 1,
                res = Table[data[[2, i, tpos]], {i, 1, numdatasets}];
                If[ ! VectorQ[res, NumberQ],
                    Message[GetDeltaRA::nfound];
                    Abort[]
                ]
            ];
            If[ NumberQ[tpos] && numDSET > 1,
                res = 
                 Table[Table[data[[1 + j, i, tpos]], {i, 1, numdatasets}], {j, 1, 
                   numDSET}];
                If[ ! And @@ (VectorQ[#, NumberQ] & /@ res),
                    Message[GetDeltaRA::nfound];
                    Abort[]
                ]
            ];
        ];
        res
    (*If[VectorQ[res,NumberQ],res,Message[GetDeltaRA::nfound];Abort[]]*)]
    
GetDeltaRA[data_, header_?classOriginQ] :=
    Module[ {
    head = CleanFITSHeader[header], RAaxis, numdatasets, tfields, tpos,
    res, ttypekeays, numDSET},
        RAaxis = FindRAAxis[head[[2]]];
  (*so far only for CLASS-FITS*)
        tfields = GetHeaderKeyValue[head[[2]], "TFIELDS"];
        (*If only one data set,
        then the coordinate offset is taken from the extended header,
        therefore,no TTYPE variable is necessary*)
        numdatasets = GetHeaderKeyValue[head[[2]], "NAXIS2"];
        numDSET = GetHeaderKeyValue[head[[1]], "DSETS___"];
        If[ numDSET == {},
            numDSET = 1
        ];
        If[ numdatasets == 1,
            res = {GetHeaderKeyValue[head[[2]], 
               "CDELT" <> ToString[RAaxis]]},(*which TTYPE holds the RA CDELT?*)
            ttypekeays = 
             Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 1,
                tfields}];
            Which[
             MemberQ[ttypekeays, 
              a_ /; StringMatchQ[a, "CRVAL" ~~ NumberString]], 
             tpos = Position[ttypekeays, "CRVAL" <> ToString[RAaxis]][[1, 1]],
             MemberQ[ttypekeays, 
              a_ /; StringMatchQ[a, "CDELT" ~~ NumberString]], 
             tpos = Position[ttypekeays, "CDELT" <> ToString[RAaxis]][[1, 1]]];
            If[ NumberQ[tpos] && numDSET == 1,
                res = Table[data[[2, i, tpos]], {i, 1, numdatasets}];
                If[ ! VectorQ[res, NumberQ],
                    Message[GetDeltaRA::nfound];
                    Abort[]
                ]
            ];
            If[ NumberQ[tpos] && numDSET > 1,
                res = Table[
                  Table[data[[1 + j, i, tpos]], {i, 1, numdatasets}], {j, 1, 
                   numDSET}];
                If[ ! And @@ (VectorQ[#, NumberQ] & /@ res),
                    Message[GetDeltaRA::nfound];
                    Abort[]
                ]
            ];
        ];
        res
    (*If[VectorQ[res,NumberQ],res,Message[GetDeltaRA::nfound];Abort[]]*)]
  

GetDeltaRA[data_, header_] :=
    (Message[GetDeltaRA::xhead];
     Abort[]);
     
GetDeltaDec[data_, header_?classOriginQ] := 
 GetTFIELDDec[data, header, "CDELT"]
GetAbsDec[data_, header_?classOriginQ] := 
 GetTFIELDDec[data, header, "CRVAL"]
GetDeltaDec[data_, header_?hipeBintableQ] :=
    Module[ {head = CleanFITSHeader[header],  Decaxis, 
       numdatasets, tfields, tpos, res, numDSET},
        Decaxis = FindDecAxis[head[[2]]];
        (*so far only for CLASS-FITS*)
        tfields = GetHeaderKeyValue[head[[2]], "TFIELDS"];
        (* If only one data set, 
        then the coordinate offset is taken from the extended header, 
        therefore, no TTYPE variable is necessary*)
        numdatasets = GetHeaderKeyValue[head[[2]], "NAXIS2"];
        (* Number of DSETS, i.e. SUBSCANS in CLASS*)
        numDSET = GetHeaderKeyValue[head[[1]], "DSETS___"];
        If[ numdatasets == 1,
            res = {GetHeaderKeyValue[head[[2]], "CDELT" <> ToString[Decaxis]]},
            (* which TTYPE holds the Dec CDELT? *)
            tpos = 
             Position[
               Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 1, 
                 tfields}], "CDELT" <> ToString[Decaxis]][[1, 1]];
            If[ NumberQ[tpos] && numDSET == 1,
                res = Table[data[[2, i, tpos]], {i, 1, numdatasets}];
                If[ ! VectorQ[res, NumberQ],
                    Message[GetDeltaDec::nfound];
                    Abort[]
                ]
            ];
            If[ NumberQ[tpos] && numDSET > 1,
                res = 
                 Table[Table[data[[1 + j, i, tpos]], {i, 1, numdatasets}], {j, 1, 
                   numDSET}];
                If[ ! And @@ (VectorQ[#, NumberQ] & /@ res),
                    Message[GetDeltaDec::nfound];
                    Abort[]
                ]
            ];
        ];
        res
    ]


GetDeltaDec[data_, header_?classOriginQ] :=
    Module[ {head = CleanFITSHeader[header], Decaxis, numdatasets, 
      tfields, tpos, res, numDSET,ttypekeays},
        Decaxis = FindDecAxis[head[[2]]];
  (*so far only for CLASS-FITS*)
        tfields = GetHeaderKeyValue[head[[2]], "TFIELDS"];
        (*If only one data set,
        then the coordinate offset is taken from the extended header,
        therefore,no TTYPE variable is necessary*)
        numdatasets = GetHeaderKeyValue[head[[2]], "NAXIS2"];
        (*Number of DSETS,i.e.SUBSCANS in CLASS*)
        numDSET = GetHeaderKeyValue[head[[1]], "DSETS___"];
        If[ numDSET == {},
            numDSET = 1
        ];
        If[ numdatasets == 1,
            res = {GetHeaderKeyValue[head[[2]], 
               "CDELT" <> 
                ToString[Decaxis]]},(*which TTYPE holds the Dec CDELT?*)
            ttypekeays = 
             Table[GetHeaderKeyValue[head[[2]], "TTYPE" <> ToString[i]], {i, 1,
                tfields}];
            Which[
             MemberQ[ttypekeays, 
              a_ /; StringMatchQ[a, "CRVAL" ~~ NumberString]], 
             tpos = Position[ttypekeays, "CRVAL" <> ToString[Decaxis]][[1, 1]],
             MemberQ[ttypekeays, 
              a_ /; StringMatchQ[a, "CDELT" ~~ NumberString]], 
             tpos = Position[ttypekeays, "CDELT" <> ToString[Decaxis]][[1, 1]]];
            If[ NumberQ[tpos] && numDSET == 1,
                res = Table[data[[2, i, tpos]], {i, 1, numdatasets}];
                If[ ! VectorQ[res, NumberQ],
                    Message[GetDeltaDec::nfound];
                    Abort[]
                ]
            ];
            If[ NumberQ[tpos] && numDSET > 1,
                res = Table[
                  Table[data[[1 + j, i, tpos]], {i, 1, numdatasets}], {j, 1, 
                   numDSET}];
                If[ ! And @@ (VectorQ[#, NumberQ] & /@ res),
                    Message[GetDeltaDec::nfound];
                    Abort[]
                ]
            ];
        ];
        res
    ]
      
    
GetDeltaDec[data_, header_] :=
    (Message[GetDeltaDec::xhead];
     Abort[]);

Options[calculateAxisValues] = {"RelativeRAOffset" -> True, 
   "RelativeDecOffset" -> True, "RelativeVelocityOffset" -> True};
calculateAxisValues[head_, opts : OptionsPattern[]] :=
    Module[ {
    crpix, cdelt, crval, naxis, strings, axis, naxisi, centerdec,
    cleanHead, leftEdge, rightEdge,  relOff, dec, ra, spec, 
    axiskey},
        relOff = {"RelativeRAOffset", "RelativeDecOffset", 
            "RelativeVelocityOffset"} /. {opts} /. 
          Options[calculateAxisValues];
        (*check if header consists of simple rules a al KEY->Value, 
        or if it is KEY->{Value,comment}*)
        cleanHead = 
         If[ MatchQ[head, _?hipeBintableQ],
             CleanFITSHeader[head[[2]]],
             CleanFITSHeader[head]
         ];
        (*number of axes*)
        If[ (HeaderKeyExistsQ[cleanHead, "CLASS___"] && 
        Flatten[{GetHeaderKeyValue[cleanHead, "CLASS___"]}][[1]] == 
        "herschel.ia.dataset.TableDataset") || ((HeaderKeyExistsQ[
        cleanHead, 
        "MATRIX"] || (HeaderKeyExistsQ[cleanHead, "EXTNAME"] && 
        GetHeaderKeyValue[cleanHead, "EXTNAME"] == "MATRIX")) && 
        HeaderKeyExistsQ[cleanHead, "MAXIS"] && 
        HeaderKeyExistsQ[cleanHead, "NAXIS"]),
            axiskey = "MAXIS",
            axiskey = "NAXIS"
        ];
        naxis = IntegerPart[axiskey /. cleanHead];
        strings = ToString /@ Range[naxis];
        {crpix, cdelt, crval, 
          naxisi} = {"CRPIX" <> # & /@ strings, "CDELT" <> # & /@ strings, 
           "CRVAL" <> # & /@ strings, axiskey <> # & /@ strings} /. 
          cleanHead;
        (* RelativeCoordinateOffset->True, forces CRVAL->
        0 and will only produce relative offsets to the CRPIX *)
        (* Do RA, Dec,Velocity, separately*)
        (*declination*)
        axis = FindDecAxis[cleanHead];
        If[ NumberQ[axis],
            If[ naxisi[[axis]] > 1,
                If[ relOff[[2]],
                    crval[[axis]] = 0
                ];
                leftEdge = ((1 - crpix[[axis]])*cdelt[[axis]] + crval[[axis]]);
                rightEdge = ((naxisi[[axis]] - crpix[[axis]])*cdelt[[axis]] + 
                   crval[[axis]]);
                dec = Range[leftEdge, rightEdge, cdelt[[axis]]],
                dec = {crval[[axis]]}
            ]
        ];
        centerdec = crval[[axis]];
        (* right ascension *)
        axis = FindRAAxis[cleanHead];
        If[ NumberQ[axis],
            If[ naxisi[[axis]] > 1,
                If[ relOff[[1]],
                    crval[[axis]] = 0
                ];
                leftEdge = ((1 - crpix[[axis]])*
                    cdelt[[axis]]/Cos[centerdec Degree] + crval[[axis]]);
                rightEdge = ((naxisi[[axis]] - crpix[[axis]])*
                    cdelt[[axis]]/Cos[centerdec Degree] + crval[[axis]]);
                ra = Range[leftEdge, rightEdge, 
                  cdelt[[axis]]/Cos[centerdec Degree]],
                ra = {crval[[axis]]}
            ]
        ];
        (* spectrum *)
        axis = FindSpectralAxis[cleanHead];
        If[ relOff[[3]],
            crval[[axis]] = 0
        ];
        If[ NumberQ[axis],
            If[ naxisi[[axis]] > 1,
                leftEdge = ((1 - crpix[[axis]])*cdelt[[axis]] + crval[[axis]]);
                rightEdge = ((naxisi[[axis]] - crpix[[axis]])*cdelt[[axis]] + 
                   crval[[axis]]);
                spec = Range[leftEdge, rightEdge, cdelt[[axis]]],
                spec = {crval[[axis]]}
            ]
        ];
        {ra, dec, spec}
    ]

GetAbsoluteSpectralAxis[head_, opts : OptionsPattern[]] :=
    Module[ {cleanhead, restfreq},
     (* assuming frequency axis!! *)
     (* The next is a clutch assuming the specifications in all \
   subsequent BINTABLE headers is identical to the first.*)
        cleanhead = If[ MatchQ[head, _?hipeBintableQ],
                        CleanFITSHeader[head[[2]]],
                        CleanFITSHeader[head]
                    ];
        Which[ HeaderKeyExistsQ[cleanhead, "RESTFREQ"] && 
          GetHeaderKeyValue[cleanhead, 
            "CRVAL" <> ToString[FindSpectralAxis[cleanhead]]] == 0,
            restfreq = GetHeaderKeyValue[cleanhead, "RESTFREQ"],
            HeaderKeyExistsQ[cleanhead, "RESTFREQ"] && 
          GetHeaderKeyValue[cleanhead, 
            "CRVAL" <> ToString[FindSpectralAxis[cleanhead]]] != 0,
            restfreq = GetHeaderKeyValue[cleanhead, "RESTFREQ"],
            True,
            restfreq = 0
        ];
        If[ FrequencyAxisQ@SpectralAxisType[cleanhead],
        	Which[HeaderKeyExistsQ[cleanhead, "RESTFREQ"] && 
                GetHeaderKeyValue[cleanhead,
            "CRVAL" <> ToString[FindSpectralAxis[cleanhead]]] == 0,
            calculateAxisValues[cleanhead, opts, 
               "RelativeVelocityOffset" -> False][[-1]] + restfreq,
           HeaderKeyExistsQ[cleanhead, "RESTFREQ"] && 
             GetHeaderKeyValue[cleanhead, 
            "CRVAL" <> ToString[FindSpectralAxis[cleanhead]]] != 0,
            calculateAxisValues[cleanhead, opts, 
               "RelativeVelocityOffset" -> True][[-1]] + restfreq,
              True,
            calculateAxisValues[cleanhead, opts, 
              "RelativeVelocityOffset" -> False][[-1]]],
            calculateAxisValues[cleanhead, opts, 
              "RelativeVelocityOffset" -> False][[-1]]  
        ]
    ]


splitMultipleBintable[data_, header_?multipleBintableQ] := 
 Module[{ clean = CleanFITSHeader[header], remove},
  remove = Table["DS_" <> ToString[i], {i, 1, Length[clean] - 1}];
  (* Ich weiss nicht ob "DS_0"->
  2 bei nur einem BINTABLE dataset Sinn macht!!, 
  daher setze ich "DS_0"->
  1. Um die allte DS kennzeichung des Datenfeldes zu erhalten benutze \
: "DS_0"->i-1*)
  Transpose[{Transpose[{Table[
       PutHeaderKeyValue[
        DeleteHeaderKey[clean[[1]], remove], {"DSETS___" -> 1, 
         "DS_0" -> 1}], {i, 2, Length[clean]}],
      clean[[2 ;; -1]]}],
    Table[{data[[1]], data[[i + 1]]}, {i, 1, Length[clean] - 1}]}]
  ]
splitMultipleBintable[___] := (Message[splitMultipleBintable::xhead]; 
  Abort[])

Options[FormatSpectrum] = {"RestFrequency" -> Automatic, "Offset" -> {0,0}};

simpleSingleSpectrumQ[{head_, 
   data_}] := (MatchQ[Join[{FindRAAxis[head]}, {FindDecAxis[head]}] , {}]) && 
  ListQ[data]
Clear[FormatSpectrum];
FormatSpectrum[data_?ArrayQ, header_, opts : OptionsPattern[]] :=
    Module[{(*pos,*)RAaxis, Decaxis,(*posRA,posDec,*)coord, deltaRA, 
  deltaDec, crRA, crDec, nRA, nDec, offset, 
  head = CleanFITSHeader[header], naxis, genSelector, cubeDim, 
  headDim, i, j, restfreq, restfOpt, freqExits, grammar, singOrplur, 
  numDSET, offOpt},
 restfOpt = OptionValue["RestFrequency"];
 offOpt = OptionValue["Offset"];
 freqExits = HeaderKeyExistsQ[head, "RESTFREQ"];
 grammar = {{"Spectrum", "Spectra"}, {"Entry", "Entries"}};
 Which[
  NumberQ[restfOpt], restfreq = restfOpt,
  restfOpt === Automatic && freqExits, 
  restfreq = GetHeaderKeyValue[head, "RESTFREQ"],
  True, restfreq = 
   GetHeaderKeyValue[head, "CRVAL" <> ToString[FindRAAxis[head]]]];
 Which[
  (* sonderfall simples spectrum, ohne pos. angaben*)
  simpleSingleSpectrumQ[{head, data}],
  naxis = 3;
  nRA = 1;
  RAaxis = 2;
  deltaRA = 0.;
  crRA = 1;
  Decaxis = 3;
  deltaDec = 0;
  crDec = 1;
  nDec = 1;
  offset = offOpt;
  genSelector = All;
  head = PutHeaderKeyValue[
    head, {"CTYPE" <> ToString[RAaxis] -> "RA---SIN", 
     "CTYPE" <> ToString[Decaxis] -> "DEC--SIN"}];
  numDSET = nRA*nDec;
  singOrplur = If[numDSET == 1, 1, 2];
  outputCell[
   "Spectrum formating done. " <> ToString[numDSET] <> " " <> 
    grammar[[1, singOrplur]] <> " found in a " <> ToString[nRA] <> 
    " \[Times] " <> ToString[nRA] <> " (R.A. \[Times] Dec) array."];
  {PutHeaderKeyValue[
    head, {"CDELT" <> ToString[RAaxis] -> offset[[1]], 
     "NAXIS" <> ToString[RAaxis] -> 1, 
     "CRPIX" <> ToString[RAaxis] -> 1, 
     "CDELT" <> ToString[Decaxis] -> offset[[2]], 
     "NAXIS" <> ToString[Decaxis] -> 1, 
     "CRPIX" <> ToString[Decaxis] -> 1, 
     "RESTFREQ" -> restfreq}], (data /. Indeterminate -> Missing[])}
  ,
  (* standard FITS *)
  True, naxis = GetHeaderKeyValue[head, "NAXIS"];
  cubeDim = Dimensions[data];
  headDim = 
   Table[GetHeaderKeyValue[head, "NAXIS" <> ToString[i]], {i, 1, naxis}];
  RAaxis = FindRAAxis[head];
  deltaRA = GetHeaderKeyValue[head, "CDELT" <> ToString[RAaxis]];
  crRA = GetHeaderKeyValue[head, "CRPIX" <> ToString[RAaxis]];
  nRA = GetHeaderKeyValue[head, "NAXIS" <> ToString[RAaxis]];
  Decaxis = FindDecAxis[head];
  deltaDec = GetHeaderKeyValue[head, "CDELT" <> ToString[Decaxis]];
  crDec = GetHeaderKeyValue[head, "CRPIX" <> ToString[Decaxis]];
  nDec = GetHeaderKeyValue[head, "NAXIS" <> ToString[Decaxis]];
  (*Print["HERE"];
  posRA=findDeltaRA[data,header];
  posDec=findDeltaDec[data,header];*)(*pos=findData[data,header];*)
  coord = {GetHeaderKeyValue[head, "CRVAL" <> ToString[RAaxis]], 
    GetHeaderKeyValue[head, "CRVAL" <> ToString[Decaxis]]};
  (*CHECK:Cosine correction for the offset addition of deltaRA ???*)
  offset = Table[{(*coord[[1]]+*)(i - crRA)*
      deltaRA,(*coord[[2]]+*)(j - crDec)*deltaDec}, {i, 1, nRA}, {j, 
     1, nDec}];
  genSelector = 
   Table[Which[RAaxis == jj, i, Decaxis == jj, j, True, All], {jj, 1, 
     naxis}];
  If[cubeDim == Reverse[headDim], genSelector = Reverse[genSelector]];
  numDSET = nRA*nDec;
  singOrplur = If[numDSET == 1, 1, 2];
  (*outputCell["Spectrum formating done. "<>ToString[numDSET]<>" "<>
  grammar[[1,singOrplur]]<>" found in a "<>ToString[nRA]<>" * "<>
  ToString[nRA]<>" (R.A. * Dec) array."];*)
  Table[{PutHeaderKeyValue[
     head, {"CDELT" <> ToString[RAaxis] -> offset[[i, j, 1]], 
      "NAXIS" <> ToString[RAaxis] -> 1, 
      "CRPIX" <> ToString[RAaxis] -> 1, 
      "CDELT" <> ToString[Decaxis] -> offset[[i, j, 2]], 
      "NAXIS" <> ToString[Decaxis] -> 1, 
      "CRPIX" <> ToString[Decaxis] -> 1, 
      "RESTFREQ" -> restfreq}], (data[[Sequence @@ genSelector]] /. 
       Indeterminate -> Missing[]) /. {a_?VectorQ} :> a}, {j, 1, 
    nDec}, {i, 1, nRA}]
  ]
 (*!!!!data[[row,column]]:=data[[dec,RA]]!!!!!*)]
 
FormatSpectrum[data_, header_?classOriginQ, opts : OptionsPattern[]] :=
  Module[
  {pos, RAaxis, Decaxis, coord, offset, head = CleanFITSHeader@header,
    restfreq, restfOpt, freqExits, specaxis, specCRVAL, specCRPIX, 
   headrestfreq, numDSET, numdatasets, grammar, singOrplur, ttypekeys,
    numttype, newheads, scans, scanNums, singOrplurScans,restFreqList},
  
  ttypekeys = ListTFIELDS[head];
  numttype = Length[ttypekeys];
  restfOpt = OptionValue["RestFrequency"];
  freqExits = HeaderKeyExistsQ[head, "RESTFREQ"];
  If[freqExits, headrestfreq = GetHeaderKeyValue[head, "RESTFREQ"], 
   headrestfreq = 0];

  (* Not used --> *)
  numdatasets = GetHeaderKeyValue[head, "NAXIS2"];
  numDSET = GetHeaderKeyValue[head, "DSETS___"];
  If[numDSET == {} && classOriginQ[head], numDSET = 1];
  (* pull out CDELT values (offsets) from the header*)
  (*ASSUMING same rest frequency for all spectra!!!!!!*)
  Which[
  	NumberQ[restfOpt], restfreq = restfOpt, 
   restfOpt === Automatic && freqExits, restfreq = headrestfreq, 
   True,
    restfreq = 
    GetHeaderKeyValue[head, 
     "CRVAL" <> ToString[FindSpectralAxis[head]]]];
  specaxis = FindSpectralAxis[head];
  If[GetHeaderKeyValue[head, "CRVAL" <> ToString[specaxis]] == 0 && 
    freqExits && NumberQ[headrestfreq], specCRVAL = headrestfreq, 
   specCRVAL = 0];
  (* Not used till here *)
  restFreqList = GetHeaderKeyValue[TFIELD2FITSKeys[data, head], "RESTFREQ"];
  pos = findData[data, head];
  grammar = {{"Spectrum", "Spectra"}, {"Entry", "Entries"}, {"SCAN", 
     "SCANS"}};
  singOrplur = If[Length[pos] == 1, 1, 2];
  
  newheads = 
   DeleteHeaderKey[#, 
      Flatten@Table[{"TFORM" <> ToString[i], 
         "TTYPE" <> ToString[i]}, {i, 1, 
         numttype}]] & /@ (PutHeaderKeyValue[JoinHeader@head, #] & /@ 
      TFIELD2FITSKeys[data, head]);
  scans = GetHeaderKeyValue[newheads, "SCAN"] // Union;
  scanNums = Length[scans];
  singOrplurScans = If[scanNums == 1, 1, 2];
  outputCell[
 ToString@GetHeaderKeyValue[head, "ORIGIN"] <> 
  " \[LongDash] Spectrum formating done. " <> ToString[Length@pos] <> 
  " " <> grammar[[1, singOrplur]] <> " found in " <> 
  ToString[scanNums] <> " SCAN " <> grammar[[2, singOrplur]] <> 
  ".\n SCAN IDs: " <> StringRiffle[ToString /@ scans, ", "]];
 
  Table[
  	If[freqInTFIELDSQ[data,head],
  	{PutHeaderKeyValue[newheads[[i]], {"RESTFREQ" -> restFreqList[[i]], "CRVAL" <> ToString[specaxis]->restFreqList[[i]]}], 
    data[[Sequence @@ (pos[[i]])]]},	
  	{PutHeaderKeyValue[newheads[[i]], "RESTFREQ" -> restfreq], 
    data[[Sequence @@ (pos[[i]])]]}], {i, Length@pos}]
    
    ]


FormatSpectrum[data_, header_?singleBintableQ, 
  opts : OptionsPattern[]]/; (! classOriginQ[header]):=
    Module[ {pos, RAaxis, Decaxis, coord, offset, 
      head = CleanFITSHeader@header, restfreq, restfOpt, freqExits, 
      specaxis, specCRVAL, specCRPIX, headrestfreq, numDSET, numdatasets,
       grammar, singOrplur},
       Print["single"];
        restfOpt = OptionValue["RestFrequency"];
        freqExits = HeaderKeyExistsQ[head, "RESTFREQ"];
        If[ freqExits,
            headrestfreq = GetHeaderKeyValue[head, "RESTFREQ"],
            headrestfreq = 0
        ];
        RAaxis = FindRAAxis[head];
        Decaxis = FindDecAxis[head];
        (*posRA=findDeltaRA[data,header];*)
        (*posDec=findDeltaDec[data,header];*)
        pos = findData[data, head];
        coord = {GetHeaderKeyValue[head, "CRVAL" <> ToString[RAaxis]], 
          GetHeaderKeyValue[head, "CRVAL" <> ToString[Decaxis]]};
        (* This would be for absolute coordinates 
        coord+#&/@Transpose[{data[[Sequence@@#]]/(1Cos[coord[[2]]Degree])&/@
        posRA,data[[Sequence@@#]]&/@posDec}]*)
        (*offset=Transpose[{data[[Sequence@@#]]&/@posRA,
        data[[Sequence@@#]]&/@posDec}];*)
        numdatasets = GetHeaderKeyValue[head, "NAXIS2"];
        numDSET = GetHeaderKeyValue[head, "DSETS___"];
        If[ numDSET == 1,
            offset = 
             Transpose[{GetDeltaRA[data, head], GetDeltaDec[data, head]}],
            offset = 
             Flatten[Table[
               Transpose[{GetDeltaRA[data, head][[i]], 
                 GetDeltaDec[data, head][[i]]}], {i, 1, numDSET}], 1]
        ];
        (*Print[{pos,coord,numdatasets,numDSET,offset}];*)
        (*ASSUMING same rest frequency for all spectra!!!!!!*)
        Which[
         NumberQ[restfOpt], restfreq = restfOpt,
         restfOpt === Automatic && freqExits, restfreq = headrestfreq,
         True, restfreq = 
          GetHeaderKeyValue[head, "CRVAL" <> ToString[FindSpectralAxis[head]]]
         ];
        specaxis = FindSpectralAxis[head];
        If[ GetHeaderKeyValue[head, "CRVAL" <> ToString[specaxis]] == 0 && 
          freqExits && NumberQ[headrestfreq],
            specCRVAL = headrestfreq,
            specCRVAL = 0
        ];
        (*not used so far, probably wrong anyway*)
        specCRPIX = (GetHeaderKeyValue[head, 
              "CDELT" <> ToString[specaxis]] GetHeaderKeyValue[head, 
              "CRPIX" <> ToString[specaxis]] + (specCRVAL - headrestfreq) - 
            GetHeaderKeyValue[head, "CRVAL" <> ToString[specaxis]])/
          GetHeaderKeyValue[head, "CDELT" <> ToString[specaxis]];
        (* If new rest frequency is set, 
        we have to change crval and crpix values of the spectral axcis*)
        (*axis=FindSpectralAxis[head];
        If[NumberQ[axis],
        leftEdge=((1-crpix[[axis]])*cdelt[[axis]]+crval[[axis]]);
        rightEdge=((naxisi[[axis]]-crpix[[axis]])*cdelt[[axis]]+
        crval[[axis]]);
        spec=Range[leftEdge,rightEdge,cdelt[[axis]]],spec={crval[[axis]]}
        ]
        
        *)
        (*Debugging :Table[{PutHeaderKeyValue[CleanFITSHeader[header],{"CDELT"<>
        ToString[RAaxis]->offset[[i,1]],"CDELT"<>ToString[Decaxis]->
        offset[[i,2]]}]},{i,Length@pos}]*)
        (* Now each spectrum header has the center position (CRVALi, 
        CRVALj) and the offsets of that spectrum (CDELTi,
        CDELTj) in the header*)
        (* Die ersten numdatasets spectra nehmen den ersten BINTABLE header \
      (also den 2. header)*)
        grammar = {{"Spectrum", "Spectra"}, {"Entry", "Entries"}};
        singOrplur = If[ Length[pos] == 1,
                         1,
                         2
                     ];
        outputCell[
         "OBSID: " <> ToString@GetHeaderKeyValue[head, "HOBSID"] <> 
          " \[LongDash] Spectrum formating done. " <> ToString[Length@pos] <>
           " " <> grammar[[1, singOrplur]] <> " found in " <> 
          ToString[numDSET] <> " DSET " <> grammar[[2, singOrplur]] <> "." ];
        Table[{PutHeaderKeyValue[JoinHeader@head, {
            "CDELT" <> ToString[RAaxis] -> offset[[i, 1]],
            "CDELT" <> ToString[Decaxis] -> offset[[i, 2]],
            "CRVAL" <> ToString[specaxis] -> specCRVAL,
            (*"CRPIX"<>ToString[specaxis]->specCRPIX,*)
            "RESTFREQ" -> restfreq
            }], data[[Sequence @@ (pos[[i]])]]}, {i, Length@pos}]
    ]
FormatSpectrum[data_, header_?multipleBintableQ, 
   opts : OptionsPattern[]] /; Length[data] == Length[header] :=
    Module[ {split},
        split = splitMultipleBintable[data, header];
        outputCell[
         "Multi-BINTABLE HICLASS data split into " <> 
          ToString[Length[split]] <> " single HICLASS BINTABLE's." ];
        Flatten[Table[
          FormatSpectrum[split[[i, 2]], split[[i, 1]], opts], {i, 1, 
           Length[split]}], 1]
    ]



(* Spectrum handling (functions acting on spectrum Objects) *)

Options[ObservedCoordinates] = {"Method" -> "AbsoluteCoordinates"};
ObservedCoordinates[spec_?SpectrumQ, opts : OptionsPattern[]] :=
    Module[ {head = CleanFITSHeader[spec[[1]]], RAaxis, DECaxis,  
      absolute},
        RAaxis = FindRAAxis[head];
        DECaxis = FindDecAxis[head];
        (* in case of CLASS-
        FITS files an additional CDELT is found in the extended bintable*)
        If[ MatchQ[
          OptionValue["Method"], ("AbsoluteCoordinates" | "Absolute")],
            absolute = True,
            absolute = False
        ];
        If[ MatchQ[
          OptionValue["Method"], ("RelativeCoordinates" | "Offset")],
            absolute = False,
            absolute = True
        ];
        If[ absolute,
            {GetHeaderKeyValue[head, "CRVAL" <> ToString[RAaxis]], 
            GetHeaderKeyValue[head, "CRVAL" <> ToString[DECaxis]]} + {GetHeaderKeyValue[
            head, "CDELT" <> ToString[RAaxis]]/
            Cos[GetHeaderKeyValue[head, "CRVAL" <> ToString[DECaxis]] Degree], 
            GetHeaderKeyValue[head, "CDELT" <> ToString[DECaxis]]},
            {GetHeaderKeyValue[head, "CDELT" <> ToString[RAaxis]], 
             GetHeaderKeyValue[head, "CDELT" <> ToString[DECaxis]]}
        ]
    ]
GetObservedCoordinates[spec_?SpectrumQ, opts : OptionsPattern[]] :=
    ObservedCoordinates[spec, opts]

GetCoordinateSystem[spec_?SpectrumQ] :=
    Module[ {head = CleanFITSHeader[spec[[1]]], RAaxis, DECaxis},
        RAaxis = FindRAAxis[head];
        DECaxis = FindDecAxis[head];
        {GetHeaderKeyValue[head, "CTYPE" <> ToString[RAaxis]], 
         GetHeaderKeyValue[head, "CTYPE" <> ToString[DECaxis]]}
    ]

ComposeXYSpectrum[spec_?SpectrumQ, opts : OptionsPattern[]] :=
    Module[ {y = spec[[-1]], x, cleanhead = CleanFITSHeader[spec[[1]]]},
        x = GetAbsoluteSpectralAxis[cleanhead, opts];
        Transpose[{x, y}]
    ]

Options[ToFrequency] = {"VelocityUnits" -> "SI", 
   "FrequencyUnits" -> "SI", "FrequencyOutputUnits" -> "GHz"};

ToFrequency[velocity_, restfrequency_, opts : OptionsPattern[]] :=
    Module[ {vunit, funit, foutunit, vunitconv, funitconv, 
      speedoflight = 2.99792458 10^8},
        vunit = "VelocityUnits" /. {opts} /. Options[ToFrequency];
        funit = "FrequencyUnits" /. {opts} /. Options[ToFrequency];
        foutunit = "FrequencyOutputUnits" /. {opts} /. Options[ToFrequency];
        (*vunitconv and funitconv convert the input numbers TO SI units *)
        vunitconv = Which[
          ToLowerCase@vunit == "si", 1,
          ToLowerCase@vunit == "m/s", 1,
          ToLowerCase@vunit == "m/sec", 1,
          ToLowerCase[vunit] == "meter/second", 1,
          ToLowerCase@vunit == "cgs", 1/100,
          ToLowerCase@vunit == "cm/s", 1/100,
          ToLowerCase@vunit == "cm/sec", 1/100,
          ToLowerCase[vunit] == "centimeter/second", 1/100,
          ToLowerCase@vunit == "km/s", 10^3,
          ToLowerCase@vunit == "km/sec", 10^3,
          ToLowerCase[vunit] == "kilometer/second", 10^3,
          (* anything else*)
          True, 1];
        funitconv[unit_] :=
            Which[
            MatchQ[ToLowerCase@unit, 
            Alternatives["si", "cgs", "1/s", "hz", "hertz", "1/sec", 
            "1/second"]], 1,
            ToLowerCase@unit == "ghz", 10^9,
            ToLowerCase@unit == "khz", 10^3,
            ToLowerCase@unit == "mhz", 10^6,
            ToLowerCase[unit] == "thz", 10^12,
            (* anything else*)
            True, 1];
        restfrequency*funitconv[funit]/
         funitconv[foutunit] (1 - (velocity vunitconv)/speedoflight)
    ]

Options[ToVelocity] = {"VelocityUnits" -> "m/s"};
ToVelocity[spec_?SpectrumQ, opts : OptionsPattern[]] /; 
  HeaderKeyExistsQ[spec[[1]], "RESTFREQ"] :=
    ToVelocity[spec, GetHeaderKeyValue[spec[[1]], "RESTFREQ"], opts]
ToVelocity[spec : {__?SpectrumQ}, opts : OptionsPattern[]] /; 
   And @@ Map[HeaderKeyExistsQ[#[[1]], "RESTFREQ"] &, spec] :=
    Table[ToVelocity[spec[[i]], GetHeaderKeyValue[spec[[i, 1]], "RESTFREQ"], 
      opts], {i, 1, Length[spec]}];

ToVelocity[frequency_, restfrequency_, opts : OptionsPattern[]] :=
    Module[ {speedoflight = 2.99792458 10^8},
        speedoflight*(1 - frequency/restfrequency)
    ]
ToVelocity[spec_?SpectrumQ, restfrequency_, opts : OptionsPattern[]] :=
    Module[ {speedoflight = 2.99792458 10^8, f, y, v, vunit, vunitconv,v0},
        vunit = "VelocityUnits" /. {opts} /. Options[ToVelocity];
        {f, y} = Transpose[ComposeXYSpectrum[spec]];
        If[HeaderKeyExistsQ[spec, "VELO-LSR"],v0=GetHeaderKeyValue[spec, "VELO-LSR"],v0=0];
        vunitconv = Which[
          ToLowerCase@vunit == "si", 1,
          ToLowerCase@vunit == "m/s", 1,
          ToLowerCase@vunit == "m/sec", 1,
          ToLowerCase[vunit] == "meter/second", 1,
          ToLowerCase@vunit == "cgs", 1/100,
          ToLowerCase@vunit == "cm/s", 1/100,
          ToLowerCase@vunit == "cm/sec", 1/100,
          ToLowerCase[vunit] == "centimeter/second", 1/100,
          ToLowerCase@vunit == "km/s", 10^3,
          ToLowerCase@vunit == "km/sec", 10^3,
          ToLowerCase[vunit] == "kilometer/second", 10^3,
          (* anything else*)
          True, 1];
        If[ FrequencyAxisQ@SpectralAxisType[CleanFITSHeader@spec[[1]]],
            v = 1/vunitconv (speedoflight*(1 - f/restfrequency)+v0),
            v = 1/vunitconv f
        ];
        
        Transpose[{v, y}]
    ]
ToVelocity[spec : {__?SpectrumQ}, 
    restfrequency_?(VectorQ[#, NumericQ] &), 
    opts : OptionsPattern[]] /; 
   Length[spec] <= Length[restfrequency] :=
    Table[ToVelocity[spec[[i]], restfrequency[[i]], opts], {i, 1, 
      Length[spec]}];
ToVelocity[spec : {__?SpectrumQ}, 
    restfrequency_?(VectorQ[#, NumericQ] &), 
    opts : OptionsPattern[]] /; Length[spec] > Length[restfrequency] :=
    Table[ToVelocity[spec[[i]], 
     PadRight[restfrequency, Length[spec], restfrequency][[i]], 
     opts], {i, 1, Length[spec]}];
ToVelocity[spec : {__?SpectrumQ}, restfrequency_?NumberQ, 
   opts : OptionsPattern[]] :=
    Table[ToVelocity[spec[[i]], 
      PadRight[{restfrequency}, Length[spec], {restfrequency}][[i]], 
      opts], {i, 1, Length[spec]}];



Options[SpectrumPlot] = {"FrequencyAxis" -> Top, 
   "VelocityUnits" -> "km/s", "RestFrequency" -> Automatic};
SpectrumPlot[spec_?(SpectrumQ[#] || VectorQ[#, SpectrumQ] &), 
  opts : OptionsPattern[]] :=
    Module[ {cleanHead, plot1, xTicks,  
       faxis,  
      fticks, data, rest, vunit, funit, foutunit, restfOpt,
       freqExits, restfreq},
        If[ SpectrumQ[spec],
            cleanHead = CleanFITSHeader[spec],
            cleanHead = CleanFITSHeader[spec[[1]]]
        ];
        (* check whether specY is one or more spectra*)
        restfOpt = "RestFrequency" /. {opts} /. Options[SpectrumPlot];
        freqExits = If[ SpectrumQ[spec],
                        HeaderKeyExistsQ[spec[[1]], "RESTFREQ"],
                        And @@ Map[HeaderKeyExistsQ[#[[1]], "RESTFREQ"] &, spec]
                    ];
        Which[
         NumberQ[restfOpt], restfreq = restfOpt,
         VectorQ[restfOpt, NumberQ], restfreq = restfOpt,
         restfOpt === Automatic && freqExits && SpectrumQ[spec], 
         restfreq = GetHeaderKeyValue[spec[[1]], "RESTFREQ"],
         restfOpt === Automatic && freqExits && VectorQ[spec, SpectrumQ], 
         restfreq = Map[GetHeaderKeyValue[#[[1]], "RESTFREQ"] &, spec],
         (* no restfrequency in header*)
         restfOpt === Automatic && !freqExits,
         restfreq = {},
         True, restfreq = 
          GetHeaderKeyValue[#[[1]], "CRVAL" <> ToString[FindSpectralAxis[#[[1]]]]] & /@ 
           Flatten[{spec}, 1]
         ];
        faxis = "FrequencyAxis" /. {opts} /. Options[SpectrumPlot];
        vunit = "VelocityUnits" /. {opts} /. Options[SpectrumPlot];
        funit = "FrequencyUnits" /. {opts} /. Options[ToFrequency];
        foutunit = "FrequencyOutputUnits" /. {opts} /. Options[ToFrequency];
        (* If more than one restfreq, 
        then there are multiple mappings velo->freq, 
        therefore we deactivate the second x-axis*)
        rest = Flatten[{restfreq}];
        If[ Length[Union[rest]] != 1,
            faxis = "None",
            rest = rest[[1]]
        ];
        (*{freq,specY}=Transpose@ComposeXYSpectrum[spec];
        specX=(ToVelocity[#,restfreq]&/@freq)*10^-3;(* converted to km/sec*)

        
        data=Transpose[{specX,specY}];*)
        data = ToVelocity[spec, rest, "VelocityUnits" -> vunit];
        
        plot1 = 
         ListPlot[data, FilterRules[{opts}, Options[ListPlot]], 
          Frame -> False, Joined -> True, PlotRange -> All, Axes -> True];
        xTicks = Quiet@AbsoluteOptions[plot1, Ticks][[1, 2, 1]];
        fticks = 
         Apply[If[ #2 =!= "",
                   {#1, 
                   ToFrequency[#2, rest, "VelocityUnits" -> vunit, 
                   "FrequencyUnits" -> funit, 
                   "FrequencyOutputUnits" -> foutunit], ##3},
                   {#1, "", ##3}
               ] &, 
          xTicks, 1];
        If[ faxis =!= "None",
            Show[Show[plot1, Frame -> True, Axes -> False, 
              FilterRules[{opts}, Options[Show]], FrameTicks -> All], 
             FilterRules[{opts}, Options[Show]], 
             FrameTicks -> {{Automatic, Automatic}, {Automatic, fticks}}],
            Show[plot1, FilterRules[{opts}, Options[Show]], Frame -> True, 
             Axes -> False, FrameTicks -> Automatic]
        ]
    ]
SpectrumPlot[spec_?(SpectrumQ[#] || VectorQ[#, SpectrumQ] &), 
  restfreq_, opts : OptionsPattern[]] :=
    SpectrumPlot[spec, opts, "RestFrequency" -> restfreq]



Options[MaskSpectrum] = {"SpectralAxis" -> "Velocity", 
   "RestFrequency" -> Automatic, "VelocityUnits" -> "m/s"};
MaskSpectrum[spec_?SpectrumQ, interval : {{_?NumberQ, _?NumberQ} ..}, 
  opts : OptionsPattern[]] :=
    Module[ {int, vunit, funit, specaxis, data, restfOpt, freqExits, 
      restfreq},
        restfOpt = "RestFrequency" /. {opts} /. Options[MaskSpectrum];
        freqExits = HeaderKeyExistsQ[spec[[1]], "RESTFREQ"];
        Which[
         NumberQ[restfOpt], restfreq = restfOpt,
         VectorQ[restfOpt, NumberQ], restfreq = restfOpt,
         restfOpt === Automatic && freqExits && SpectrumQ[spec], 
         restfreq = GetHeaderKeyValue[spec[[1]], "RESTFREQ"],
         restfOpt === Automatic && freqExits && VectorQ[spec, SpectrumQ], 
         restfreq = Map[GetHeaderKeyValue[#[[1]], "RESTFREQ"] &, spec],
         True, restfreq = 
          GetHeaderKeyValue[#[[1]], "CRVAL" <> ToString[FindRAAxis[#[[1]]]]] & /@ 
           Flatten[{spec}, 1]
         ];
        specaxis = "SpectralAxis" /. {opts} /. Options[MaskSpectrum];
        vunit = "VelocityUnits" /. {opts} /. Options[MaskSpectrum];
        funit = "FrequencyUnits" /. {opts} /. Options[ToFrequency];
        If[ specaxis == "Velocity",
            data = ToVelocity[spec, restfreq, "VelocityUnits" -> vunit],
            data = ComposeXYSpectrum[spec]
        ];
        int = Interval @@ interval;
        data = data /. {a_?(IntervalMemberQ[int, #] &), b_} :> {a, 
            Missing[]};
        {spec[[1]], Transpose[data][[2]]}
    ]
MaskSpectrum[spec_?SpectrumQ, interval : {_?NumberQ, _?NumberQ}, 
  opts : OptionsPattern[]] :=
    MaskSpectrum[spec, {interval}, opts]
MaskSpectrum[spec_?SpectrumQ, interval : {_?NumberQ, _?NumberQ}, 
  restfreq_, opts : OptionsPattern[]] :=
    MaskSpectrum[spec, {interval}, "RestFrequency" -> restfreq, opts]
MaskSpectrum[spec_?SpectrumQ, interval : {{_?NumberQ, _?NumberQ} ..}, 
  restfreq_, opts : OptionsPattern[]] :=
    MaskSpectrum[spec, interval, "RestFrequency" -> restfreq, opts]

Options[SubtractBaseline] = {BaselineDegree -> 2, SetLineWindow -> {},
    "RestFrequency" -> Automatic};

SubtractBaseline[spec_?SpectrumQ, opts : OptionsPattern[]] :=
    Module[ {x, xlist, poly,  maskedData, baseData, rms,
       residuals, polydegree, interval, specaxis, vunit, funit, data, 
      normal, restfOpt, freqExits, restfreq, pure, arg},
        restfOpt = "RestFrequency" /. {opts} /. Options[SubtractBaseline];
        freqExits = HeaderKeyExistsQ[spec[[1]], "RESTFREQ"];
        Which[
         NumberQ[restfOpt], restfreq = restfOpt,
         VectorQ[restfOpt, NumberQ], restfreq = restfOpt,
         restfOpt === Automatic && freqExits && SpectrumQ[spec], 
         restfreq = GetHeaderKeyValue[spec[[1]], "RESTFREQ"],
         restfOpt === Automatic && freqExits && VectorQ[spec, SpectrumQ], 
         restfreq = Map[GetHeaderKeyValue[#[[1]], "RESTFREQ"] &, spec],
         True, restfreq = 
          GetHeaderKeyValue[#[[1]], "CRVAL" <> ToString[FindRAAxis[#[[1]]]]] & /@ 
           Flatten[{spec}, 1]
         ];
        polydegree = BaselineDegree /. {opts} /. Options[SubtractBaseline];
        interval = SetLineWindow /. {opts} /. Options[SubtractBaseline];
        specaxis = "SpectralAxis" /. {opts} /. Options[MaskSpectrum];
        vunit = "VelocityUnits" /. {opts} /. Options[ToVelocity];
        funit = "FrequencyUnits" /. {opts} /. Options[ToFrequency];
        data = spec[[-1]];
        If[ interval === {},
            If[ specaxis == "Velocity",
                maskedData = ToVelocity[spec, restfreq, "VelocityUnits" -> vunit],
                maskedData = ComposeXYSpectrum[spec]
            ],
            If[ specaxis == "Velocity",
                maskedData = 
                 ToVelocity[
                  MaskSpectrum[spec, interval, restfreq, 
                   "SpectralAxis" -> specaxis, "VelocityUnits" -> vunit], 
                  restfreq, "VelocityUnits" -> vunit],
                maskedData = 
                 ComposeXYSpectrum[
                  MaskSpectrum[spec, interval, restfreq, 
                   "SpectralAxis" -> specaxis, "VelocityUnits" -> vunit]]
            ]
        ];
        xlist = Table[x^i, {i, 0, polydegree}];
        poly = LinearModelFit[DeleteCases[maskedData, {_, Missing[]}], 
          xlist, x];
        residuals = poly["FitResiduals"];
        arg = If[ Length[xlist] > 1,
                  xlist[[2]],
                  x
              ];
        pure = Function[Evaluate@arg, Evaluate@Normal[poly]];
        (*datPlot=ListPlot[data];
        baseplot=Plot[poly[x],{x,Min[data[[All,1]]],Max[data[[All,1]]]},
        PlotStyle->Thick];*)
        (*
        Print[poly["ANOVATableMeanSquares"]];Print[Show[{datPlot,baseplot}]];
        *)
        rms = RootMeanSquare[residuals];
        (*baseData=Map[#[[2]]-poly[#[[1]]]&,data];*)
        baseData = data - pure@maskedData[[All, 1]];
        (* remove all parts with Missing[] *)
        baseData=baseData/.{a_Plus/; MemberQ[a, Missing[], Infinity] :> Missing[]};
        normal = Normal[poly];
        (*Print[rms];*)
        (*ListPlot[baseData,Frame->True,Axes->{True,False},PlotRange->All,
        PlotLabel->Row[{"RMS:",rms}]]*)
        {PutHeaderKeyValue[
          CleanFITSHeader@spec[[1]], {"RMS_____" -> rms, 
           "POLY____" -> ToString[FullForm[normal] /. x -> #]}], baseData}
    ]
SubtractBaseline[spec_?SpectrumQ, restfreq_, 
  opts : OptionsPattern[]] :=
    SubtractBaseline[spec, "RestFrequency" -> restfreq, opts]

SpectralAxisConfiguration[spec_?SpectrumQ] :=
    Module[ {specaxis, string, head = CleanFITSHeader[spec[[1]]], crpix, 
      cdelt, crval, naxisi, axiskey, type},
        specaxis = FindSpectralAxis[head];
        If[ HeaderKeyExistsQ[head, "CLASS___"] && 
          GetHeaderKeyValue[head, "CLASS___"] == 
           "herschel.ia.dataset.TableDataset",
            axiskey = "MAXIS",
            axiskey = "NAXIS"
        ];
        string = ToString[specaxis];
        {type, crpix, cdelt, crval, 
          naxisi} = {SpectralAxisType[head], "CRPIX" <> string, 
           "CDELT" <> string, "CRVAL" <> string, axiskey <> string} /. head
    ]
Options[AverageSpectrum] = {Method -> "Mean", "RMSList" -> {}};
AverageSpectrum[spec : {__?SpectrumQ}, opts : OptionsPattern[]] :=
    Module[ {meth, rms, rmsdat, specdef, spectra},
        meth = Method /. {opts} /. Options[AverageSpectrum];
        specdef = SpectralAxisConfiguration /@ spec;
        If[ Length[Union@specdef] > 1,
            Message[AverageSpectrum::xspecax];
            Abort[]
        ];
        spectra = spec[[All, 2]];
        Which[
         meth == "Mean",
         {DeleteHeaderKey[PutHeaderKeyValue[spec[[1, 1]], "AVERAGED" -> "Mean"], 
           "RMS_____"], Mean /@ Transpose[spectra]},
         meth == "RMS",
         rms = "RMSList" /. {opts} /. Options[AverageSpectrum];
         rms = Flatten[{rms}];
         If[ rms === {} && 
           And @@ (HeaderKeyExistsQ[#, "RMS_____"] & /@ spec[[All, 1]]),
             GetHeaderKeyValue[#, "RMS_____"] & /@ spec[[All, 1]],
             Message[AverageSpectrum::xrms];
             Abort[]
         ];
         rmsdat = Table[1/rms[[i]] spectra[[i]], {i, 1, Length[rms]}];
         {DeleteHeaderKey[PutHeaderKeyValue[spec[[1, 1]], "AVERAGED" -> "RMS"], 
           "RMS_____"], (Total /@ Transpose[rmsdat])/Total[1/rms]},
         True,
         Mean /@ Transpose[spectra]]
    ]
AverageSpectrum[spectra_, opts : OptionsPattern[]] :=
    Module[ {meth, rms, rmsdat},
        If[ ! MatrixQ[spectra],
            Abort[]
        ];
        meth = Method /. {opts} /. Options[AverageSpectrum];
        Which[
         meth == "Mean",
         Mean /@ Transpose[spectra],
         meth == "RMS",
         rms = "RMSList" /. {opts} /. Options[AverageSpectrum];
         rms = Flatten[{rms}];
         rmsdat = Table[1/rms[[i]] spectra[[i]], {i, 1, Length[rms]}];
         (Total /@ Transpose[rmsdat])/Total[1/rms],
         True,
         Mean /@ Transpose[spectra]]
    ]
CalculateRMS[spectra_] :=
    Which[
    SpectrumQ[spectra], RootMeanSquare[spectra[[2]]/.Missing[]:>0.],
    MatchQ[spectra, {__?SpectrumQ}], 
    RootMeanSquare[Transpose@spectra[[All, 2]]/.Missing[]:>0.],
    VectorQ[spectra], RootMeanSquare[spectra/.Missing[]:>0.],
    ArrayQ[spectra], RootMeanSquare[Transpose@spectra]/.Missing[]:>0.,
    True, Return[$Failed]]

Options[SmoothSpectrum] :=
    {Method -> "MovingAverage", 
    "KernelWidth" -> 3, "GaussianFWHM" -> 1}
SmoothSpectrum[spec_?SpectrumQ, opts : OptionsPattern[]] :=
    Module[ {meth,  ysmooth,  kern,
       width, fwhm, ydat},
        meth = Method /. {opts} /. Options[SmoothSpectrum];
        width = "KernelWidth" /. {opts} /. Options[SmoothSpectrum];
        fwhm = "GaussianFWHM" /. {opts} /. Options[SmoothSpectrum];
        If[ EvenQ[width],
            Message[SmoothSpectrum::evenwidth];
            Abort[]
        ];
        Which[
         meth == "MovingAverage", kern = Table[1/n, {n, 1, width}],
         meth == "Hanning", 
         kern = Table[
           1 - 2 0.25 + 2 0.25 Cos[\[Pi] k/12], {k, -(width - 1)/
            2, (width - 1)/2}],
         meth == "Hamming", 
         kern = Table[
           1 - 2 0.23 + 2 0.23 Cos[\[Pi] k/12], {k, -(width - 1)/
            2, (width - 1)/2}],
         meth == "Gaussian", 
         kern = Exp[-1/(2 (fwhm/(2 Sqrt[2 Log[2]]))^2)*
             N[Range[-(width - 1)/2, (width - 1)/2]^2]],
         True, kern = 
          Table[1 - 2 0.25 + 2 0.25 Cos[\[Pi] k/12], {k, -(width - 1)/
            2, (width - 1)/2}]
         ];
        kern /= Total[kern];
        ydat = spec[[2]];
        ysmooth = ListCorrelate[kern, ydat];
        ysmooth = 
         RotateRight[PadRight[ysmooth, Length[ydat], Missing[]], 
          Floor @((Length[ydat] - Length[ysmooth])/2)];
        {spec[[1]], ysmooth}
    ]


Options[RegridSpectralAxis] = {"BlankValue" -> Automatic};
RegridSpectralAxis[refspec_?SpectrumQ, spec_?SpectrumQ, 
  opts : OptionsPattern[]] :=
    Module[ {refhead = CleanFITSHeader[refspec[[1]]], 
      head = CleanFITSHeader[spec[[1]]], refxlist,  intspec, 
      newyspec,  crpix, cdelt, crval, axis, restfreq, checkInt, 
      blank, newhead, oldaxis, axiskey, axisrefkey},
        refxlist = GetAbsoluteSpectralAxis[refhead, opts];
        If[ FilterRules[{opts}, Options[RegridSpectralAxis]] != {},
            blank = OptionValue["BlankValue"],
            blank = 0
        ];
        If[ OptionValue["BlankValue"] === Automatic && 
          HeaderKeyExistsQ[refhead, "BLANK"],
            blank = GetHeaderKeyValue[refhead, "BLANK"]
        ];
        intspec = 
         Interpolation[ComposeXYSpectrum[spec], 
          Evaluate[FilterRules[{opts}, Options[Interpolation]]], 
          InterpolationOrder -> 1];
        refxlist = GetAbsoluteSpectralAxis[refhead, opts];
        (* prevent extrapolation and write 0 in the overhanging frquency \
      channels*)
        checkInt[x_?NumberQ] :=
            Check[intspec[x], blank, InterpolatingFunction::dmval];
        newyspec = Quiet[checkInt /@ refxlist, InterpolatingFunction::dmval];
        (*prepare new header values*)
        axis = FindSpectralAxis[refhead];
        {crpix, cdelt, crval} = 
         GetHeaderKeyValue[refhead, #] & /@ {"CRPIX" <> ToString[axis], 
           "CDELT" <> ToString[axis], "CRVAL" <> ToString[axis]};
        If[ HeaderKeyExistsQ[refhead, "RESTFREQ"],
            restfreq = GetHeaderKeyValue[refhead, "RESTFREQ"],
            restfreq = 0
        ];
        oldaxis = FindSpectralAxis[head];
        axiskey = "NAXIS";
        axisrefkey = "NAXIS";
        If[ HeaderKeyExistsQ[head, "CLASS___" ] && 
          GetHeaderKeyValue[head, "CLASS___"] == 
           "herschel.ia.dataset.TableDataset",
            axiskey = "MAXIS",
            axiskey = "NAXIS"
        ];
        If[ HeaderKeyExistsQ[refhead, "CLASS___" ] && 
          GetHeaderKeyValue[refhead, "CLASS___"] == 
           "herschel.ia.dataset.TableDataset",
            axisrefkey = "MAXIS",
            axisrefkey = "NAXIS"
        ];
        newhead = 
         PutHeaderKeyValue[
          head, {Rule["CRPIX" <> ToString[oldaxis], crpix], 
           Rule["CDELT" <> ToString[oldaxis], cdelt], 
           Rule["CRVAL" <> ToString[oldaxis], crval], 
           Rule["RESTFREQ", restfreq], 
           Rule[axiskey <> ToString[oldaxis], 
            GetHeaderKeyValue[refhead, axisrefkey <> ToString[axis]]]}];
        {newhead, newyspec}
    ]


(* Additional functions *)
 
outputCell[text_] :=
    CellPrint@
     Cell[BoxData[
       FrameBox[
        StyleBox[ToBoxes@StringForm[text], FontFamily -> "Verdana", 
         FontSize -> 11, FontColor -> RGBColor[0.2, 0.4, 0.6]], 
        Background -> RGBColor[0.96, 0.98, 1.], 
        FrameMargins -> {{24, 24}, {8, 8}}, 
        FrameStyle -> RGBColor[0.2, 0.4, 0.6], StripOnInput -> False]], 
      "PrintTemporary"]; 

MultipleGaussians[amplituden_List, centroids_List, sigmas_List] /; 
  Length[amplituden] == Length[centroids] == Length[sigmas] :=
    Block[ {list, x},
        list = Table[
          amplituden[[i]]*
           Exp[-((x - centroids[[i]])^2/(2 sigmas[[i]]^2))], {i, 1, 
           Length[amplituden]}];
        Function[x, Evaluate[Plus @@ list]]
    ]
Gaussian[x_, {amplitude_, centroid_, sigma_}] :=Gaussian[x, amplitude, centroid, sigma]
Gaussian[x_, amplitude_, centroid_, sigma_] :=
    amplitude*Exp[-((x - centroid)^2/(2 sigma^2))]
makeXList[deg_Integer] :=
    Table[x^i, {i, 0, deg}]

Options[ImportSpectrum] = {"RestFrequency" -> Automatic, "ScalingFactor"->1};
ImportSpectrum[file_, opts : OptionsPattern[]] :=
    Module[ {raw, head, restfOpt, scal},
        restfOpt = "RestFrequency" /. {opts} /. Options[ImportSpectrum];
        scal = "ScalingFactor" /. {opts} /. Options[ImportSpectrum];
        (*
           scaling factor: multiply the raw data by scaling factor
         *)
        Which[
        $VersionNumber >= 11.3,
        head = Import[file, "Metadata"];
        head = If[ Length[head] == 1,
                   CleanFITSHeader@Normal[head[1]["GENERAL INFORMATION"]],
                   Table[CleanFITSHeader@Normal[head[i]["GENERAL INFORMATION"]], {i, 
                     1, Length[head]}]
               ];
        imp = Import[file, "RawData"];
        If[ NumericArrayQ[imp[1]],
            raw = scal*Normal[imp[1]];,
            raw = scal*
               flattenCube[Values[imp] /. Missing["NotAvailable"] :> "None", 
                head];
        ],
        $VersionNumber >= 11.2,
        head = Normal[Import[file, "Metadata"]["GENERAL INFORMATION"]];
        raw = scal*flattenCube[Import[file, "RawData"], head];,
        True,
        head = Import[file, "Metadata"];
        raw = scal*flattenCube[Import[file, "RawData"], head];];
        Which[
         simpleSingleSpectrumQ[{head, raw}],
         {head, raw},
         hipeBintableQ[head], 
         FormatSpectrum[raw, head, "RestFrequency" -> restfOpt], 
         ArrayQ[head], 
         FormatSpectrum[raw, head, "RestFrequency" -> restfOpt], 
         True, {head, raw}]
    ]  


Options[IntegrateSpectrum] = 
  Join[{"Threshold" -> -Infinity}, Options[Interpolation]];
SetOptions[IntegrateSpectrum, {InterpolationOrder -> 1}];
IntegrateSpectrum[spec_?SpectrumQ, range_List, 
  opts : OptionsPattern[]] :=
    Module[ {deltaV, interp, thres = OptionValue["Threshold"], dat, len, 
      sdat},
        dat = DeleteMissing[ComposeXYSpectrum[spec], 1, 1];
        Which[thres === None || False,
         dat[[All, 2]] = dat[[All, 2]](*/.b_?NumberQ/;b<
         thres\[RuleDelayed]0.*),
         NumericQ[thres],
         dat[[All, 2]] = dat[[All, 2]] /. b_?NumberQ /; b < thres :> 0.
         ];
        len = Length[dat[[All, 2]]];
        If[ OptionValue["FastApproximation"],
         (* Trapezoidal rule of integration *)
            sdat = Select[dat, IntervalMemberQ[Interval[range], #[[1]]] &];
            (sdat[[-1, 1]] - sdat[[1, 1]])/(
             2 (Length[sdat] + 1)) (sdat[[1, 2]] + sdat[[-1, 2]] + 
               2 Total[sdat[[All, 2]][[2 ;; -2]]]),
            interp = 
             Interpolation[dat, 
              Evaluate@
               FilterRules[Join[{opts}, Options[IntegrateSpectrum]], 
                Options[Interpolation]]];
            If[ MatrixQ[dat, NumberQ],
                Integrate[interp[v], {v, range[[1]], range[[2]]},
                 Evaluate@
                  FilterRules[Join[{opts}, Options[IntegrateSpectrum]], 
                   Options[Integrate]]],
                {}
            ]
        ]
    ]
  
Options[IntegratedIntensityArray] = 
 Join[{"SignificantRMS" -> 3., "RelativeRAOffset" -> True, 
   "RelativeDecOffset" -> True, "AngularUnits" -> "Degree", 
   "CoordinateSystem" -> "Image"}, Options[MaskSpectrum], 
  Options[Interpolation]]; 
IntegratedIntensityArray[cube_, range_, opts : OptionsPattern[]] := 
 Module[{
   thres = OptionValue["SignificantRMS"], dat, pos,
   coord = OptionValue["CoordinateSystem"], rms},
  Map[(
     rms = CalculateRMS[MaskSpectrum[#, range]];
     IntegrateSpectrum[#, range, "Threshold" -> thres*rms]
     ) &, cube, {2}]
  ]

Options[calculateCubeDimensions] = {"RelativeRAOffset" -> True, 
   "RelativeDecOffset" -> True, "RelativeVelocityOffset" -> True, 
   "CoordinateSystem" -> "Celestial"};
calculateCubeDimensions[head_, opts : OptionsPattern[]] := 
 Module[{crpix, cdelt, crval, naxis, strings, axis, naxisi, centerdec,
    cleanHead, leftEdge, rightEdge, min, max, delta, relOff, dec, ra, 
   spec, axiskey, coord},
  min = max = delta = {0, 0, 0};
  relOff = {"RelativeRAOffset", "RelativeDecOffset", 
      "RelativeVelocityOffset"} /. {opts} /. 
    Options[calculateAxisValues];
  coord = OptionValue["CoordinateSystem"];
  (*check if header consists of simple rules a al KEY\[Rule]Value,
  or if it is KEY\[Rule]{Value,comment}*)
  cleanHead = 
   If[MatchQ[head, _?hipeBintableQ], CleanFITSHeader[head[[2]]], 
    CleanFITSHeader[head]];
  (*number of axes*)
  If[(HeaderKeyExistsQ[cleanHead, "CLASS___"] && 
      Flatten[{GetHeaderKeyValue[cleanHead, "CLASS___"]}][[1]] == 
       "herschel.ia.dataset.TableDataset") || ((HeaderKeyExistsQ[
         cleanHead, 
         "MATRIX"] || (HeaderKeyExistsQ[cleanHead, "EXTNAME"] && 
          GetHeaderKeyValue[cleanHead, "EXTNAME"] == "MATRIX")) && 
      HeaderKeyExistsQ[cleanHead, "MAXIS"] && 
      HeaderKeyExistsQ[cleanHead, "NAXIS"]), axiskey = "MAXIS", 
   axiskey = "NAXIS"];
  naxis = IntegerPart[axiskey /. cleanHead];
  strings = ToString /@ Range[naxis];
  {crpix, cdelt, crval, 
    naxisi} = {"CRPIX" <> # & /@ strings, "CDELT" <> # & /@ strings, 
     "CRVAL" <> # & /@ strings, axiskey <> # & /@ strings} /. 
    cleanHead;
  (*RelativeCoordinateOffset\[Rule]True,
  forces CRVAL\[Rule]0 and will only produce relative offsets to the \
CRPIX*)(*Do RA,Dec,Velocity,separately*)(*declination*)
  Which[
   coord == "Image",
   {{1, naxisi[[FindDecAxis[cleanHead]]]}, {1, 
     naxisi[[FindRAAxis[cleanHead]]]}, {1, 
     naxisi[[FindSpectralAxis[cleanHead]]]}},
   coord == "Celestial",
   axis = FindDecAxis[cleanHead];
   If[NumberQ[axis], 
    If[naxisi[[axis]] > 1, If[relOff[[2]], crval[[axis]] = 0];
     leftEdge = ((1 - crpix[[axis]])*cdelt[[axis]] + crval[[axis]]);
     rightEdge = ((naxisi[[axis]] - crpix[[axis]])*cdelt[[axis]] + 
        crval[[axis]]);
     dec = Range[leftEdge, rightEdge, cdelt[[axis]]], 
     dec = {crval[[axis]]}]];
   min[[2]] = leftEdge;
   max[[2]] = rightEdge;
   delta[[2]] = cdelt[[axis]];
   centerdec = crval[[axis]];
   (*right ascension*)
   axis = FindRAAxis[cleanHead];
   If[NumberQ[axis], 
    If[naxisi[[axis]] > 1, If[relOff[[1]], crval[[axis]] = 0];
     leftEdge = ((1 - crpix[[axis]])*
         cdelt[[axis]]/Cos[centerdec Degree] + crval[[axis]]);
     rightEdge = ((naxisi[[axis]] - crpix[[axis]])*
         cdelt[[axis]]/Cos[centerdec Degree] + crval[[axis]]);
     ra = 
      Range[leftEdge, rightEdge, cdelt[[axis]]/Cos[centerdec Degree]],
      ra = {crval[[axis]]}]];
   min[[1]] = leftEdge;
   max[[1]] = rightEdge;
   delta[[1]] = cdelt[[axis]];
   (*spectrum*)axis = FindSpectralAxis[cleanHead];
   If[relOff[[3]], crval[[axis]] = 0];
   If[NumberQ[axis], 
    If[naxisi[[axis]] > 1, 
     leftEdge = ((1 - crpix[[axis]])*cdelt[[axis]] + crval[[axis]]);
     rightEdge = ((naxisi[[axis]] - crpix[[axis]])*cdelt[[axis]] + 
        crval[[axis]]);
     spec = Range[leftEdge, rightEdge, cdelt[[axis]]], 
     spec = {crval[[axis]]}]];
   min[[3]] = leftEdge;
   max[[3]] = rightEdge;
   delta[[3]] = cdelt[[axis]];
   Transpose[{min, max, delta}]]
  ]

Options[PositionsInCube] = {"RelativeRAOffset" -> True, 
   "RelativeDecOffset" -> True, "AngularUnits" -> "Degree", 
   "CoordinateSystem" -> "Celestial"};
PositionsInCube[head_, opts : OptionsPattern[]] := 
 Module[{positions, inside, limits, ragrid, decgrid, units, conv},
  units = OptionValue["AngularUnits"];
  
  Which[
   StringMatchQ[units, 
    "Degree" | "degree" | "Deg" | "deg" | "d" | "D" | "\[Degree]"], 
   conv = 1.,
   StringMatchQ[units, 
    "ArcMin" | "arcmin" | "Min" | "min" | "m" | "M" | "'"], conv = 60.,
   StringMatchQ[units, 
    "ArcSec" | "arcsec" | "Sec" | "sec" | "s" | "S" | "''"], 
   conv = 3600.,
   True, conv = 1.
   ];
  (* By Default RA and Dec Limits are in Degrees !! same for position \
coordinates! *)
  If[OptionValue["CoordinateSystem"] == "Image", conv = 1.];
  limits = 
   calculateCubeDimensions[head, 
    Sequence @@ 
     FilterRules[Flatten@{opts}, Options[calculateCubeDimensions]]];
  
  positions = Flatten[Outer[List, Range[Sequence @@ limits[[1]]],
      Range[Sequence @@ limits[[2]]]], 1]*conv]

Options[PositionsInPolygon] = {"RelativeRAOffset" -> True, 
   "RelativeDecOffset" -> True, "AngularUnits" -> "Degree", 
   "CoordinateSystem" -> "Celestial", "ShowGrid" -> False};
PositionsInPolygon[head_, poly_, opts : OptionsPattern[]] := 
 Module[{positions, inside, limits, ragrid, decgrid, units, conv, 
   coord},
  
  positions = 
   PositionsInCube[head, 
    Sequence @@ FilterRules[Flatten@{opts}, Options[PositionsInCube]]];
  inside = Pick[positions, RegionMember[Region@poly, positions]];
  If[OptionValue["ShowGrid"],
   Graphics[{Point /@ Reverse /@ positions, Red, PointSize[Medium], 
     Point /@ Reverse /@ inside, FaceForm[Transparent], 
     EdgeForm[Black], poly
     }, Frame -> True, AspectRatio -> 1],
   inside]]

Options[extractCubeAxes] = {"RelativeRAOffset" -> True, 
   "RelativeDecOffset" -> True, "RelativeVelocityOffset" -> True, 
   "TabularOutput" -> False};
extractCubeAxes[head_, opts : OptionsPattern[]] := 
 Module[{crpix, cdelt, crval, naxis, strings, axis, naxisi, centerdec,
    cleanHead, leftEdge, rightEdge, min, max, delta, relOff, dec, ra, 
   spec, axiskey},
  min = max = delta = {0, 0, 0};
  relOff = {"RelativeRAOffset", "RelativeDecOffset", 
      "RelativeVelocityOffset"} /. {opts} /. Options[extractCubeAxes];
  (*check if header consists of simple rules a al KEY\[Rule]Value,
  or if it is KEY\[Rule]{Value,comment}*)
  cleanHead = 
   If[MatchQ[head, _?hipeBintableQ], CleanFITSHeader[head[[2]]], 
    CleanFITSHeader[head]];
  (*number of axes*)
  If[(HeaderKeyExistsQ[cleanHead, "CLASS___"] && 
      Flatten[{GetHeaderKeyValue[cleanHead, "CLASS___"]}][[1]] == 
       "herschel.ia.dataset.TableDataset") || ((HeaderKeyExistsQ[
         cleanHead, 
         "MATRIX"] || (HeaderKeyExistsQ[cleanHead, "EXTNAME"] && 
          GetHeaderKeyValue[cleanHead, "EXTNAME"] == "MATRIX")) && 
      HeaderKeyExistsQ[cleanHead, "MAXIS"] && 
      HeaderKeyExistsQ[cleanHead, "NAXIS"]), axiskey = "MAXIS", 
   axiskey = "NAXIS"];
  naxis = IntegerPart[axiskey /. cleanHead];
  strings = ToString /@ Range[naxis];
  {crpix, cdelt, crval, 
    naxisi} = {"CRPIX" <> # & /@ strings, "CDELT" <> # & /@ strings, 
     "CRVAL" <> # & /@ strings, axiskey <> # & /@ strings} /. 
    cleanHead;
  (*RelativeCoordinateOffset\[Rule]True,
  forces CRVAL\[Rule]0 and will only produce relative offsets to the \
CRPIX*)(*Do RA,Dec,Velocity,separately*)(*declination*)
  If[OptionValue["TabularOutput"], 
     TableForm[#, 
      TableHeadings -> {{"Right Ascension", "Declination", 
         "SpectralAxis"}, {"crpix", "cdelt", "crval", "naxis", 
         "Dim #"}}], #] &@
   Table[{crpix[[i]], cdelt[[i]], crval[[i]], naxisi[[i]], 
     i}, {i, {FindRAAxis[cleanHead], FindDecAxis[cleanHead], 
      FindSpectralAxis[cleanHead]}}]
  ]
  
  

Options[PixelToRA] = {"Offset" -> True, "AngularUnits" -> "ArcSec"};
PixelToRA[i_, head_, OptionsPattern[]] := 
 Module[{ncrval, axes, racrpix, racdelt, racrval, deccrpix, deccdelt, 
   deccrval, units, conv},
  axes = extractCubeAxes[head];
  {racrpix, racdelt, racrval} = axes[[1, 1 ;; 3]];
  {deccrpix, deccdelt, deccrval} = axes[[2, 1 ;; 3]];
  units = OptionValue["AngularUnits"];
  Which[
   StringMatchQ[units, 
    "Degree" | "degree" | "Deg" | "deg" | "d" | "D" | "\[Degree]"], 
   conv = 1.,
   StringMatchQ[units, 
    "ArcMin" | "arcmin" | "Min" | "min" | "m" | "M" | "'"], conv = 60.,
   StringMatchQ[units, 
    "ArcSec" | "arcsec" | "Sec" | "sec" | "s" | "S" | "''"], 
   conv = 3600.,
   True, conv = 1.
   ];
  If[OptionValue["Offset"],
   ncrval = 0;
   conv*(ncrval + (racdelt) (i - racrpix)),
   ncrval = racrval;
   conv*(ncrval + (racdelt/Cos[deccrval Degree]) (i - racrpix))]
  ]
PixelToRA[
  i_, {racdelt_, racrpix_, racrval_}, {deccdelt_, deccrpix_, 
   deccrval_}, OptionsPattern[]] := Module[{ncrval},
  If[OptionValue["Offset"],
   ncrval = 0;
   ncrval + (racdelt) (i - racrpix),
   ncrval = racrval;
   ncrval + (racdelt/Cos[deccrval Degree]) (i - racrpix)]
  ]
Options[RAToPixel] = {"Offset" -> True, "AngularUnits" -> "ArcSec"};
RAToPixel[RA_, head_, OptionsPattern[]] := 
 Module[{ncrval, axes, racrpix, racdelt, racrval, deccrpix, deccdelt, 
   deccrval, units, conv},
  axes = extractCubeAxes[head];
  {racrpix, racdelt, racrval} = axes[[1, 1 ;; 3]];
  {deccrpix, deccdelt, deccrval} = axes[[2, 1 ;; 3]];
  units = OptionValue["AngularUnits"];
  Which[
   StringMatchQ[units, 
    "Degree" | "degree" | "Deg" | "deg" | "d" | "D" | "\[Degree]"], 
   conv = 1.,
   StringMatchQ[units, 
    "ArcMin" | "arcmin" | "Min" | "min" | "m" | "M" | "'"], conv = 60.,
   StringMatchQ[units, 
    "ArcSec" | "arcsec" | "Sec" | "sec" | "s" | "S" | "''"], 
   conv = 3600.,
   True, conv = 1.
   ];
  If[OptionValue["Offset"],
   ncrval = 0; (racdelt racrpix + RA/conv)/racdelt,
   ncrval = racrval;
   (racdelt racrpix - ncrval Cos[deccrval \[Degree]] + 
    RA/conv Cos[deccrval \[Degree]])/racdelt]]
RAToPixel[
  RA_, {racdelt_, racrpix_, racrval_}, {deccdelt_, deccrpix_, 
   deccrval_}, OptionsPattern[]] := Module[{ncrval},
  If[OptionValue["Offset"],
   ncrval = 0; (racdelt racrpix + RA)/racdelt,
   ncrval = racrval;
   (racdelt racrpix - ncrval Cos[deccrval \[Degree]] + 
    RA Cos[deccrval \[Degree]])/racdelt]
  ]

Options[PixelToDec] = {"Offset" -> True, "AngularUnits" -> "ArcSec"};
PixelToDec[i_, head_, OptionsPattern[]] := 
 Module[{ncrval, axes, deccrpix, deccdelt, deccrval, units, conv},
  axes = extractCubeAxes[head];
  {deccrpix, deccdelt, deccrval} = axes[[2, 1 ;; 3]];
  units = OptionValue["AngularUnits"];
  Which[
   StringMatchQ[units, 
    "Degree" | "degree" | "Deg" | "deg" | "d" | "D" | "\[Degree]"], 
   conv = 1.,
   StringMatchQ[units, 
    "ArcMin" | "arcmin" | "Min" | "min" | "m" | "M" | "'"], conv = 60.,
   StringMatchQ[units, 
    "ArcSec" | "arcsec" | "Sec" | "sec" | "s" | "S" | "''"], 
   conv = 3600.,
   True, conv = 1.
   ];
  If[OptionValue["Offset"], ncrval = 0, ncrval = deccrval];
  conv*(ncrval + deccdelt (i - deccrpix))]

PixelToDec[i_, {cdelt_, crpix_, crval_}, OptionsPattern[]] := 
 Module[{ncrval},
  If[OptionValue["Offset"], ncrval = 0, ncrval = crval];
  ncrval + cdelt (i - crpix)
  ]
PixelToDec[
  i_, {racdelt_, racrpix_, racrval_}, {deccdelt_, deccrpix_, 
   deccrval_}, OptionsPattern[]] := Module[{ncrval},
  If[OptionValue["Offset"], ncrval = 0, ncrval = deccrval];
  ncrval + deccdelt (i - deccrpix)
  ]
Options[DecToPixel] = {"Offset" -> True, "AngularUnits" -> "ArcSec"};
DecToPixel[Dec_, head_, OptionsPattern[]] := 
 Module[{ncrval, axes, deccrpix, deccdelt, deccrval, conv, units},
  axes = extractCubeAxes[head];
  {deccrpix, deccdelt, deccrval} = axes[[2, 1 ;; 3]];
  units = OptionValue["AngularUnits"];
  Which[
   StringMatchQ[units, 
    "Degree" | "degree" | "Deg" | "deg" | "d" | "D" | "\[Degree]"], 
   conv = 1.,
   StringMatchQ[units, 
    "ArcMin" | "arcmin" | "Min" | "min" | "m" | "M" | "'"], conv = 60.,
   StringMatchQ[units, 
    "ArcSec" | "arcsec" | "Sec" | "sec" | "s" | "S" | "''"], 
   conv = 3600.,
   True, conv = 1.
   ];
  If[OptionValue["Offset"], ncrval = 0, ncrval = deccrval];
  (deccdelt deccrpix - ncrval + Dec/conv)/deccdelt]
DecToPixel[Dec_, {cdelt_, crpix_, crval_}, OptionsPattern[]] := 
  Module[{ncrval},
   If[OptionValue["Offset"], ncrval = 0, ncrval = crval];
   (cdelt crpix - ncrval + Dec)/cdelt];
DecToPixel[
  Dec_, {racdelt_, racrpix_, racrval_}, {deccdelt_, deccrpix_, 
   deccrval_}, OptionsPattern[]] := Module[{ncrval},
  If[OptionValue["Offset"], ncrval = 0, ncrval = deccrval];
  (deccdelt deccrpix - ncrval + Dec)/deccdelt]


Options[ToPixel] = {"RelativeRAOffset" -> True, 
   "RelativeDecOffset" -> True, "AngularUnits" -> "ArcSec", 
   "IntegerCoordinates" -> True};
ToPixel[{RA_, Dec_}, header_, OptionsPattern[]] := 
 Module[{x, y, positions, raOff, decOff, unit, nearest, integer},
  raOff = OptionValue["RelativeRAOffset"];
  decOff = OptionValue["RelativeDecOffset"];
  unit = OptionValue["AngularUnits"];
  integer = OptionValue["IntegerCoordinates"];
  positions = 
   PositionsInCube[header, "RelativeRAOffset" -> raOff, 
    "RelativeDecOffset" -> decOff, "AngularUnits" -> unit];
  If[integer,
   nearest = First@Nearest[positions, {RA, Dec}];
   Round@{DecToPixel[nearest[[2]], header], 
     RAToPixel[nearest[[1]], header]},
   {DecToPixel[Dec, header], RAToPixel[RA, header]}]
  ]

Options[FromPixel] = {"RelativeRAOffset" -> True, 
   "RelativeDecOffset" -> True, "AngularUnits" -> "ArcSec", 
   "IntegerCoordinates" -> False};
FromPixel[{row_, col_}, header_, OptionsPattern[]] := 
 Module[{x, y, positions, raOff, decOff, unit,  integer},
  raOff = OptionValue["RelativeRAOffset"];
  decOff = OptionValue["RelativeDecOffset"];
  unit = OptionValue["AngularUnits"];
  integer = OptionValue["IntegerCoordinates"];
  {x, y} = {PixelToRA[col, header,"Offset"->raOff, "AngularUnits"->unit], PixelToDec[row, header,"Offset"->decOff, "AngularUnits"->unit]};
  If[integer,
   First@Nearest[positions, Round@{x, y}],
   {x, y}]
  ]


  
(* Example Data*)
Unprotect[ExampleData];
ExampleData[{"SpectrumPlot", "HIPEClassOTFScan1"}] := {Uncompress["1:eJy9WVuTG0cVlk3IxYRbIBUTg2kTCA5lCc2stLcqyjuSRquJdbN6tN5UcC0jTWvVeDQ\
j5rJm80Kooij+Bc+88cgjL3niT/gPQPFKFVXhnB7trdWzkidUtmxta3r66/\
OdPn1ue28UDCY3C4VC9Ap8tHkUT96+8u18bpB4jL4KA2p1+m3z6iIxsMOE0Z/\
C4EPnxCFNy6a75AlzSccJSXmTaPpudXNX3yB10yZ6WdtQYNcsu28dcgJDafarMOgahxa9u\
jEvoETfgI8GnzE/4oHveDw+VWCbh7bZbWTJ/V0YdJxTMg782OE+\
cZ3YiVgcSUCv4ftWx6QfSYLQr8BgaNfp9+\
C34XkIwCLihIwAGkyQGASU0F7Hxb3uPrUHXQkOp3r7Vp9opTJ9gLtOGREPvMA/\
JlEccvgF0p4wPwbWZAbCjxhJIuaWFNu06pQewY+\
kPlSrEBnnSZPHEemHgZuMY3LAQlSnAqveNgSYJPIdGExh0XjKvBJ3SgsVlhaA9Dsw/\
2s0jZDNQxaB3E6s3sDqNnsoLP06SraAJC2raUkvi+\
P7qC9ZozilliXEFFKdUbJP54xYLmpswseq3XFlfWAadk+6FvRbyI6PPSeKjuIg8KLS/\
FRobp/5LHTiICTBhMRTHpF5up1C1oZJ6xLuEkVhil1nxlbgpYoC0xl2ZP6vCP4A9R6+\
44OxJHA5YuLEsQP7uCQOViF3eg2z3TU6Cs0O/Wd+\
8NwX4J3ABbF9lHZNcERo9gYdwz5Q3CC0dlTqwvhQBQsYMgnCmaNUqmHLCngXBuhiimWtqJ\
ft8tYu/NPLpY2dnXK5TH+\
ApxwyYQDioq6hatyl2KvJ136xk14sV4vliq3t7Faqu5pe2t7RtrWqmKaxE8Yvs83Rl7NNc\
ckdqrfRK6Vqebtc0ehtdKO+u/Ym1LSX/QS/gcK+\
hUaezEZMXJsMbytOlx6VVQB4S1qNIa6uT7nnkkaKMeGX31VIhWGAWj2Vw61ZXduotc3/\
TxRDxDWjGH5bL4qJ1Rpv/n4J+3xWF15dMduv94ZdW4RMxex+OntjeVYEvaZlthuUv7E8/\
SVFMZQCYjj4JPm2o8hl4aD9y24TrGP94EUK6uBlOyOPLUxrzQiG2u8oDhkH9Nvw8fFTcmH\
6zm+5bPavngFoEsIeSEnflhHGU8f3mZeJoquuz90UpR9EXCh+\
HAShy3282BqJxo4n5yrncBsvCadfD1fJutwAR+PgGSRRcyeEc43hdBQgdYz/\
kqKE42gOzMfCoTVD9puE+ePTVJAVcIMDoy3BhYXFj/\
ALINcFYjCZgGGQPbCICQvhETs7DhU2hFRbhf3pH+4aIih93PrkMnoUszn5+QJQvg+\
ptOBolNLe++ueCNAg7YClNoIRlBwKg3sA0BAtID+NiZalVF3cl4FRLBb32zRLV5J1hUcP/\
vPZW7+M9uhNsXuWGuRl5yrOXoZccyxDKhtpPDLr11KRLDv801/+8c9v/\
sxcRUVetiaVHMuQSiUtwuzeIzOTSEUJ/e+HK4iol60k8nLLhBt/PLS6vUPVur0/\
Z6gbvWqtbXQfSf7i9n8//zy9O08xRj9LfSL3TyCCulm+\
8TwFGpgZKVBW6vj9gjJ1ZGcpjGKjfcPqWh1jX6mmFw9pMRWecpeNHMiujrH+\
9NgJJNbOfO5xSD7gAe5xzCFOkvcVe/QPzHaxTQfKPV7/\
uwhvuEeQhOCiADoYQ35BJmEwwwRuHkSO7LHOYBX1FZ5F6Lg8oD/\
Cc5ZAY6yyViHbJqRZ9V5fQn6zICoXVP6TVlEzhOAcK5hilIxQPcVozsZxGBzNA88Ji/\
hIkTXSuiHlIvyP78Dj26keRBKA4cAnfFEOslBhqHRYUyCJEHXnClIyuh4ML0uv9qFZtxWR\
qjHQNfq1C01iFqMsydpmfSi3XoScyaIkw2KyE3hsDGtUMGKR1ZUhUOvlaqVSKm9Uj4a0Rt\
8QM36mKOZhv0eHA3PZ3D79xa3X9tL4HT0llh+z4zC9LIr+hyjfl1opwmp/t9vfo+\
8jzCMw21OIhDMC/+dYaichK5Ey4ROS+C6bgJyyCYjAZVIbc4Al8O0Xb978VY3+\
pLCItwMWxSTix5Bzg9mexV4R0oX/UOXZ/ZZBJfZpK+\
rHBSk7u0CMnvN4PCXzKfgJVV8JXbDRzMw97hSW84MUMZ6GwXNVvo+\
dqky89xZntAQnBCRuEmY1SJ6Y1n5LmcgI4HvXAz9n/Hiq6gqk/DMjfE7+mXhflH8mcB7+\
aLDga3uZPhxwf4i4MxIVtafEWASG6KrvVShBaPUgC/PuJcyDMwd+Je1U8K+\
ZUIM1m8uYLx7/\
7V8PRWkPV6DGnBlhkwkfc1SCug305BqcRaHTDMLnTuhmQ4lABbdd7ZBSnu+\
kWEY8C6I51Hl8TLCCi8CVqIJTb2hTq5GJ9u4y2iXfpDiEVq8GeJK/\
uHXrRl8EUIA67wAGo4iFJ6nHvDaa2NhE00SupDWy5vUV8xsilG/r1U1TegWf2w0L3sCX7+\
MrH2ShVFbsUhWtPX3TyNijKgLBfT17h80VO2yl8zKJ8/\
ntFfM718yr6suLMkaESmxm8DhxVUdv13vtoSZMRtVfqAdeMlOFGBszC03km5fX+\
ckM7a3UCJKRxzQ58ImVw64le2dxAi47FgnQOV40dSCUJj6PS0P4yGKvZ7FPyyoPrPU68np\
O8npu8rLAX4S8VKalCZthGyJpwnZWmo8msyz6Gznpbyz9QeWMftMLnFhXshcVoiSx+\
EMB1B+iIYJBRCQ8fOYcs3XzHUGkkpNIJfc5ykzwW+uTXMdYVSjlrKUv5KuxY+\
772I5cFHT8InfN0kg1p0aqmRqhoiOq1gjS2FRoBGIVJsotSAXI/\
aH9ARnloLKZk8pm7sOVqeAlhaIy1+\
luKU4XCswDw7Z6ojFcnwZziM9kvmhQZqlhK6catq6/\
rNkHuq1wL3arZ4uWBpZPIZYl0yAmgOOuSDMEhe2cFLbzUMCDlClgefwo1zHuKPoMyKkh8t\
RzbYwDz11bHTs51IGsZFnysULF7qxS7P8AIki/UQ=="],Uncompress["1:eJxMnXVcFl3TxxcLbFQQA3UVWzFA7FgTscXGWhPEwMQEF7tbxIJVsRsVA2NVUAQRGxP\
XFlsxUBTf59nveT6f9/7jXq+LvXbPmfjNnDkzc8oODvAenk2SpAk5/vO/DiMmTLT+\
0SlgzLDhOf//18Nz//9P4/\
Nd7OQ9Iq3wufGSElwww23xuWE2//mTIkvWf5tdrzX77zXvruvWtdi9G/+\
96vlv3vzv1Uyfb302HLdY98ntZ1v3mVNfWd8rbu2sq2nrZf1dbb/\
xqvWcOi2SrefEGrHW5+LHk6xr2WLW3/UWG63fyZ3SU6zf56l21/p7+bLWVUkext9H/\
71lPfdE2B3r76NK3ba+773a+\
l5aUsz6bBTzs8alRBywxi03rm9dpayABOv3LVwvWfddD7GuUtLLeOta6lei9b2Z1/\
q9cbM/86p3/IE1zuBP1tVc+856vx5+3XqvFlOF8bZQrfHL1Ufw+\
zIzrd9L2Zsy7o7XoOO8LOjqNoLPIytZf1d+hHH/\
p4cWvZQepnWV7y6P5z2jL1tXn4nWuNUehS9Y90Wlx1i/\
K7LkovX56ujz1vOz2cVZ97c9bs1LLXfCoo8+oCbzuDLoofX31sY9a7ylw6y/Sw8aMd+\
5paz5SNcaMt/nGtfAttb9crbh1lU/XhN6z+yBXNQpfxs+XrKuSkhr5GJCT+\
RrxGTrqg2vaX2vTrex6GcePsfvCv5Fzmo2tOgit3ZHHsfdsPinbfCHj3bfrOcYdbMxrhH3\
rd+rj07xO/eJyI2+h3H9cmYcTV143/\
bj9637dx2z6KDeK4H8PKplyafR0ct6j7loIHJsNGMcbRfCp8ScPH+\
LaT1H73LO4qdWJ9a6Tz8xE7l/1IZx5lOsq3IuN/Ryu4Qc1C6UzPPd+D78Bu8pk2k9T/\
3gYs1POeVrjVu+4A9f9t+z6G/262JdtcWRyGGHAjx3/XTGeckd+dtziOdtrs19b86iR/\
1eW383FhZHn1vWsuYrFwi05M7Ql1rypuSwg+4rohlns1/wd36W9Ty9yXc+P5+HXDcIhx+\
jdYs+slHPorPxpaMlX+\
qOEswr5Tvy0DkO3AjZaMmrXPq2Je96aqEryFlL6++mUQs56XzHopsWvg69Pf/Pupo/\
Xaz75YbO1vj1O07M61tD8ML/g/\
VebdFZ5OxrYfTMYSn6XBP50Gt5IA8H81nz0bemgQdPeY7x5xJylHM7+usB/\
Yyoapb8aLNPW3RUYgItukn1Q6z3qA+vWeNSPip8LpUP/ii/\
rXGZaQvAwb7RjOPvDPDNxtbSb7VoH0uv9UMVeV+/\
5tZ9xrEN0DlPbetqBM62nqO5Rlh0l4YGWHSXmxdDPwZlIA9vIq37FOeK3NckD/\
f1OsL82tbm/\
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\
50W7sUFIWctf7N/LeZhrr/\
tLz8Q9mrOO9q7vzvtc3wItqveHLtDToc9xH2Gnep33Y9sR6bv8/\
vLfZYUtejbTc1veK4Qb9kr9C7859ocswD+bx5rY1Ts0tCT0LPon+2WWA8xryZia5I4+/\
ZyBfCYPwdystg89T7nLtVJn3OGcg31NswcvQ/eC4bylwc3kWdmJ+\
Vd73DruiTxsHP8rFgIN5n4h4UQPGs9QeeQy5IvynWeDajkn4F3ZD4Gsb03q+uuY5/\
ubkg8jNqB7I0dvD6JnvAd5TOBj927IHedX3INdtxyH3TbMznz5D8ctmPcefGzwQO9L5Dvj\
ZDjpJSfjbSo9V4OzlRPiZ4yn641ca/dxS2rR+l+sdfJg0gvePEriZE3nUeq1j3fB6E/\
wIceT5QzKQ7zhP5hd8DrreumPNW7/2DbmcUgg7PbE1+lIAP8R8sg2c3oZcmYuui3VjX/\
h8LAscaDIDu1yNuIa+bwh8HXMF/oX+\
gL8tekHPzILYd5tW4GvlvdjHPe3h44lu0OlUPcZ14SG/X7qHeV+qjP65dhT+3Cb40+\
Az9nb8UIvu8sAW2OdKp9Gz+BHgUiR+uzJmNvO87I+eNhjLPB7Xg57xdviFsY3xj0oVBZ/\
av8VOTsA/kl5+gb9HiJdKp6qDN7GD8DueLoYOto6Mo1M8z6mJ3kmNvsC3lQJnGvlZvzP+\
doGeMUuQs+n4B8qbKtjXhGjk5/xQ5LvOPvTj1CHkxdcO+bmKn6S5DUTe94dZ+q+\
718bu1nuDHOnQ0xjgb/3d7Ml6VB1hMN7LH/k+dzfruXLLbdi9UleRoxDW4/\
KdUfBvBesWs34F9Hf3KdZtRerwvSdyI/\
06g316HQpf9xZlPTx7DPwonMZ9V8Ado0su7GiNnvhrv4eAf3J9+DHE2xqn/\
O2a8PPHY9c6FWAe2Y7xPOkr8nLdFr31nIpclBZ+/\
JBJ6OOPOPjhEoy99cuJ3PatZ9FB6eQDvaPckc/IUPD38X7GKz3B/\
r99Bh493wfOLtyKH5aHeKxW6zbri1gXfp9cE/4sm4f9HFMOeQ8+\
wfunDoUfE2Pg89uJ4Jt2E7nI9Oe+cY6sZ+yXI7en74MDEaWs35lrT1tXPXsX7ExoP+\
Z9ewP6PcoZuSmmIUfVnPHPgkpDtzTi38aFKdij9MvMr2Ae6N+\
b9Zc2pxZ26NoinvvK84X1nMx93PcqgnlW7WfdZzaKBGdXv4MeDwPRyzj8U/\
1JCeRgUzboIgUi1z4doUu+0Tzvx3fwfsU/\
9HlHEfSxBn6DWj4Be1EvAf692YicdGW9odYuBJ6uAr+kuvfhq+Nh5H50W8Y5V+\
BCzhq8zy0X85K9wLuBIg7hfwC8maDxvF/YD2XpNss/Md3KIJfXfhFfWdoG+\
bHzJ47T9Cj8qfwdPG7CfNTiQ8V7iftpC96CmwUM6PC0LfatUUH4Nrw9dv7GSOSu231w5SP\
rHTW9FnrbQsiTSTxOH0q8UKoy/Zz1/San49Zzuuy39i/kuAZWvER5nB29rDoK/\
zTfDuzJh5+M79kP+LV9J3hyf4Z1lQakWN8bzz+BLxmlWK+WyIG/4hfK+\
DuOwX8ObQNdPv9l/Xc/HzgaVQx6L3LH/u30xq/dWgI5tu0D7mSLgb+\
O95jXvSbgaEAn5PBBdvC3e5jAgRrg++2x6HNSO/B7biTfm2uwO4eb8/ugK9jb5E/\
4paWwX/o17IFZ7gnyeGUQ9sB2Ezi8CP9VbxbFungk8RVteHbk+\
Hwn6LThJPp7ZS36NbwMv5vbBnt+uhDy3Swv/GzzHn42JR6s/rmNXf4Sjd8TUh/\
5WqvgP67fiPxccoJ+RwU/153n+bGMQw85h55HTELObEsg92VtGfeEt6zzc+Xi/\
nXEV9QOrN+kD5Ogz+X8fF+7JXT1qg0uN3zB+\
mFOSfB29Bfo2ikKfJvdHj3sU936bNhMe4Icf4ZeLxejnx3WgHMVwVk9cS/yoAxgvPkago/\
u/aFHn9HEU476sV8yZRL4dysXdqKEPXqXjJ+lr/MErxY+g24zu/D+\
4qzD9f7bhJ95Bnyp0R3+eC3HX3CORO9dfyIPDSbzvquliTP/K8e+\
iE1x7s98zPXleN5XJ8zy81WbC9ZV/vcTvSrfAbz/lR06NzrPe1ZVQg6LXYQPTx8z/\
pbJ2OFa/6DLi2HQ70tl6L5xH8+/\
l8V6wj4OPLzyHDrsL4p8HiJeKAelIWdzGjPO1rOwWwW7P7PuGxTBuCKHgI8TH4JHKaPBjb\
Mh+J1DboEL7keRg8nIj3qoglj/xWM3f71kff6xFOuebu7Mw/\
kSeDuTeKaZqyX2Qmd9ZgTU53mOP9GjJj5iP6UldmbreeS5AnZT2lsWOkQi/8Z3/\
A7DHzti3l0JnaezjyAfKII+z6uD3OnCPnzcAr13bsNPHbMd+\
l08A463esN4ziSC9zUrQI8FYn93KXZQqoxfIiUXRv7vFn+GnLKeM8eown9fA34pyI/\
RHf3Xa/0BF2/PRo/kZty3wYn1/+D6+\
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\
7YneUbiJ+MSga/+i6Hf5J/fzoRbjYXzGWwu/\
c0fC77Cz2A44RH1KM3djh6uzjGr624NcOO+R93y7sjUdD9gG/TYDeMb+\
QY3839G1PTeTL5T5yk8q+lvqsEvG5hezzm32bCf0Hz8wvXjy/TnnkcNtZntMR/\
1beRF6EaTcfnHIajF3u8g279Qb/TH/xj/fEnuD3Uj745FIW/\
rkuJD53F79Y7VtO6F9n5Cv+M/w934L9zam5sW+FVuC/\
PC2H3AwReSZrWd8qX7cwj5HgnLnFF78/Zgh4XOwc+27OQVacRq/\
clTzN1bPI1523njhJlTnQp9YI6J5rEXSsvAw70zs3ftxn8E9KXY4fEjgYPSx0lvnuJB/\
XjA1nvnFTyGft6wS/3Usy3soy6xq1zEtrXAcuE++I2AjOxLBfpna4BH9mbWYdFkC8UU9g/\
Wq+P4nfu64p9sWffVO99AL83gfD+LvrXOQv7gV8i60GH/\
1Evm5x7IriHUxc4N4y6Bechn5dv8+4t+rIxTcVPswsjB83vS55ZV5v8FfdnNGbJ93A+\
xbNiYdMKQZu2PfAL7gyAXyXq4FXOdgXVaoFoBchL8nb3XGVeG5UouW3660qWXxUYj3JU95\
HfrpW+5X1dzUEOZU7vmSe0+ewbr7REz84Xwxx7uvlka+6zjx3O3FdVSkD3VXy/\
dUB4LP2fj7+3VD8X+W2H/Z5aXv0tx1+ozpkKfkc7oeQ2xoXGccX9h3lb6/\
BhV4adukweTrSZvwm/fcE5K31Ufi48ho4X24135ecix6lEKdVc47ET155Gb+\
25E5wPTobejbahnXn0vbo8Z5Y7t80Ar2b0B95Wt6W5x1k3WcWYX9ebUT+r/\
abfFPtcTDxz3se5GM2uQq/AsT6rzDxVt2OPFfZoaSYv1gPpizl+r2z2McJhU7t+7F+\
PtYM/b7+FJxdNAL5TMYfVO4FIpfNXrFP0LUr9nvsKnBY6wn+3TmMHbiaE1z91Ab9isI/\
0XtM4X4P8qv0FmP53cN0+HSTfXXtn9gvGD4EP2dtAuMtt4LxjtqO/\
YvfSHw2O3mA8lYdnMg2knHvG49euPfA3vz4x3NM4jxSUSfWE6vXIm9pzdGP4j8t+\
60Ut7f2x+TIuczbjjoP9RZ5adLDs1b9jb6qF1f3w+QRJdUhX/1uN+\
5rvp590jy74Gf9ychV9gvYlfoiLtLtG/qcGkDctTf1OcoG8hLko8TF9OqXGMfBNhYfpE/\
rnkHHa/hPm3tiBwIf8fyDMdjZizuY33Ifsd7ML+wa62KlG/FTs+Ub/M/\
ixMmNpCLQ80F37Pe3pcyjRxfijz7R2C1vBZzNVp5xbT4AvizKIB86nvxyaWRF4unbmjLOx\
hGMb2t3/Il9LqwnO3eD/+\
09xH7KJ7Ev8x35C1xGnN2lnPVe3ekScZLqffm7tJbx2K7GXsUE4x/dXMHnGfGM0+\
sDfulU7KR21Bfc/GrLc895WPJgnHLAfp5ln0yb/JQ4i+NEfp/\
9l3WfVM7ztfV9H5f31jjuj/9s3T9x/g/ruXvNX9Z9DTb+Q44uZFP+\
e02MyPnfq3nkta1i8Stv7v9e9YE/rKtqzOeat4/df6/anU/c/842h/\
V52wEb63dLBvy16OLRLcMal2v/b9Z7dspfreuliC/WeJz7frLmtb+NNU5jj+\
Nb63ed8lrjl3Ytwr4vZn7yK+KOytPHyOGvNPjejXW21Oogfpt3Zei8XyXutWIY/\
JPwwxWP3tAtBD6r48OJQyUQf1ZTz4PPzsQzjWU2rK9PZcD/yeRPS8o7/\
ENv9tmVCf1FXH4y+5J311h5XPLPE9Z6XB6bYfk5RgFf/LqW+P+qw1DsSQb5R+\
o66piMzVXFe0ajbz0+gmNL2YdXDxLvkJuz7tSeTQEnw7aDZ/9YF5olqH9QBx/\
E3qz9hh9nMwD7UXYauLjXB39hBPsMxkz2uZWo7AI/P+E/PZqD/\
mwfIvZn8rJeKdEZP2GjB37328boqx/rFsXbXuy3izz3psO5T36AfSr9WOy/\
lWWcgWI94DYYHNvZW9QPsK+u+7D/oI/\
oQ3wvdyR2vdZo9L7FAuyZ0wnG15t4gOIXBn8dFsLPY4ext5/\
wA5UpIg72i3koNcgrV27OBg9sn0DP4cRtzbqPsCcNyF9T523EPqQvwC7kYt9Dcmcdq+\
bCrzerYC/0A6exj4VHcP+oLOjyMBv2udUXcLjCHeoPDrJ/oZYjDq4fYr9cKkQ+\
iDb8GHasqQv+no8n/F38E7n3uSn2pSYhH32boif3O3J/k72sG5+0wt/d2hW/\
4prYF20s9jnTbvCceon4W+YG/F/fJezDZ+LXSZ0DsSuVDov8RPZd5er4A9Jy1jP6oD/\
Iwa/dzH/qHrEessUfyaiD35dLZ5xt49CzIkHUA/b0ge+p7P9oM23xpwZtZrzN4af+Vob+\
KaznlH7J0DOI9Z6+\
hrxq46mdWO884z2ll2FXL1cjPjfVIB7hRD6HsaoSfruMH6jmdIEum5vjP/Wlns4MwO+\
WfnwG3/zLM86sycipG/mA0oqiyFtGL8a9zoV8wm5NeG596mi10yF8P3ML+\
rMMf9yM3wIedGBfXc9Lvok+dCPjud7amoca6s36qAFxYi2wNHrqUJjr85zM5/5Q5lu+\
IPz1p17SnHcEPalXHDrOnowc1y/PfPZ4irzPucQBci46Bx9rU4d4ROT5ZvzFDzoXi/\
y9wD7r3sWQg6o/oNM66sEUR+KD0l3ylZXhifhTrVYhD/PJY9XD5jEuqT58+l/\
91Xniw7pTCOuKKjtZZ+ylrlhansB+\
v1ScOqYPDcC7AxlW3FRNX0397qvO1lXWqbfQingJeQqFLp8rgpvlt4r4eiPk/FoO/\
KHmLdCzvqLe9MpY5vGY+L/kXRV8nyL29X7tZh/\
tZqTIo2e8plmL76tTl6aPqE4e5PXX4Mav8tRjrqKOyWxBXr3c4Q/\
4VsJX5EnfgR7bB1Kv0lLUh+\
bygJ8vklkv5nmBnz9zGnQptAT96CPq0Nxjoa97IvpalDignkx9ibmpMuuJtbORi6IRyEH5\
OKve2agx0LKfxo5/ln9rjAk8a11Ttlt5RkZwcLQ1jgM2zKfLAut+\
qXlV4uCejFtvRf2uumQx+fXTh+\
63ruUOYpcXMV6zRQ38ZJX6VblfYehzZw5x2iXkbxnfRb1kBfYFTF/qkpQrEdi/\
DJGHUN8Jf2RyDfDnNXUr6l3y11SJfVntXFPoF7AEu9psBXK6j3ooZQV58dJi1jvauBxiX5\
19c9ntIPK0W9QHr60IHzoR/zc321p+h+aTg/rf/ZfAi7Wsg+UNZahv21wEOg17Az8qj0e/\
S81ALgdSz2NuWy/yNuuBT7/toEPuY+\
CDV07uq5eKfxEq6kM7XefvISUZb8wW6Lg1DLksqVCnnMefa5tM6mo96lL/\
F9YFu9HyG37wL1foksl+ruHVGPw+cgA9O7AVvetKPYUxjDoK8wz7tkbYKRFXQT/\
lweuIEwzbw3qoVjuR75cGvcJ2X2QcadSBewZBF2cb8PTCX+oQg/ajN+\
8usZ69IIHLwa7wPYR6XenyTfybftSZSh8LgrN/7/N3pyb4NYtZr2uyDI6+\
SkGum12zcEdqddjSB/P4vEvoV0HyhCYlMv+D3eFjRA3ylPdO5fltyTfWGgxD/\
12nEz9L9kKOyqGnRqO7+M9PqF9RPr+CTqnEc5Uqn5BbxzM8V7/IPuvvMOYX0BEc3xDAPP+\
NAcfSRT3xvgKsi+ti5/X65IkalSaALynk+\
Rv1FmHvvMeinwWzg8trDhE32ucGfXuLfguVZmLXlNXIXWnqH7Wl5OlLmoa9dgwU62/\
ynOUbJRh3TurKpFeToGfVHeBKqRrwRW7KPB/q/L2dG+/N80rkJVdg3M03Qa+\
tOZC7rpWYV/Yg6Np1j8jD2wre+FSHPovLi/1ZG+i75hN6emiIpde6S29wy5X+\
G0aDKHBken3wKIh9bfNAH+\
Y1NoLv5T28598R5LXSDugzcCL2ozf5BWYF9EeLJn6v53mPf9VZ7MNM90ZO3lBnoYQnQY9Z\
d/Bz/uFHyynXsFPn1zOPg2+Rt9QZPPcx9WzyD3fw9QpxS13ke+ov2B8wg+\
hzoL8ag5yET8M+niBOI73Ihp36JPDmF/EaOVjGH/\
E5gB7WXIxeL0hBfpeTx6l9Zd9ece7LuvB0MOOpvBz+SHu4Tz/\
FNSsn8rugEHLpFA8uvnCEfq9Hgiuv27Fvu2AwfTtSHnBf6GrkbnNx5n+\
iCOOyay787hnESZo/FnV/\
fdHfZzXAIYV8U3PMUOSq9yLoWkHDHnbcif8zYQfxlO29WRcuID/\
R7LqC9VBr1n3GtDToerYvclv1OPSLpL5G8TNYf4+\
vyTrDnjxT9Sp2Xhp4BfnJQ36slE3kDTTezHxSfJCnKguhXxfqmPTVFcHvcdmwk3dn469OG\
sD6ewz+gxpdDz6mloGue0Vd9d7R2J/ipcD5q/\
DfeNuU53tuZb4R98GztR3he9Gj6P8UURdU2pN1VJEV+GW1BjGO7vfAtY7UHciSG/JQvTX+\
8SR/4kazkvj9qHHsGwwlPqNeHQV9s3ZBH0fqoeUu5KerD17D543Uycr750Gfk3247huPfg\
3uKuoc9iMH9zLQx6Vxgl8tec6GL1x/niCueq8j+nFc6EdMN55bpzN8PY4/qccmor+\
jCoBf69xEXkQg+i72NQxn8mTMR72Itw7/QxzP5TnPfenA8+7dxn97GkU/BPtxjHvAL/\
RlyCbRN4e6C6nMdvQvtDr2Iuwa8eJBA7B/Dl6sh4/lEnnc+\
FtyLHqqX85CDjygm3GMuIF6/TK441IF+gUUxQ+0qYoeOefAjzcT6Euy8TX+R8IS/\
Ooq6LcZQB2bsTSW8SUfQR7qb0OvdhTCHxnUDf6WnM44e3WG/5+bIm9bv2EvjgxG/z/\
SD0EfKvI5Pq0jrpDrGfv5y96jdyv9uN5K4VrxPPtAl6/gZ7aqSdz/loJ/\
NLQidJm9gXEP1fGLeov4jfIR/b5IHa+Wh/\
wIMy95CubWMvB5LXUl8uBlop6TfDBz2HORn7mGeZ7kPq3gDp63krxJo9tE5OOvPXo09y7+\
6ED2/8wZwn5WXAde/HMDB5eS16i9pp7QLEr/Dr3Je+KjftRt6PdE/\
4ZFa4jjdGAfwbjgD96ns8+sJ2D3tQixHrRLJJ7RMxDcadSUdU14d+jr2YO4dPBL8LcI/\
qru2gM96FIEO/d+O/K5Dz7rz7/w3jus56UeH5D3DqIequtd4gclo8X+PX2ZjCLU6+\
mN8GvNhCbYn10qcb4lnZGz77Pwc59vhT8fxuMv1WA9bIaQN2qW24Gf2h9/xKx/\
Cr9xXQh2YraKfryOYXxnW4CbH+kvYjiKfiOnPzG/0St4rtwWnDpC/b85fyX09y3A+\
NfTj0cvtRK5Dv3K9zW7sL/6AHmWRv8jXv7cizj4md/ErcZtgB+\
Xd4j8Mfpx6ANZT2h5N6Nn81gP6yepB1UT7EV+\
Nes5Iwu7rl4x4N8j8hz1Vc15Xg7qG9WJEfDz0GlwayzxI8mzBe853gj5SyP/2fw+\
HbxaHwM9XN+iV6+bMb6Da3lOqZf4o7Nc0YNj1GOb90V9tGM+\
4mrr10KXp7WQg2E9iXMUKgZ/hiYQpylSBX7MZH9a/URdtbq3G+uMO9+\
JS76tCj38mK9RQsRnTlNnJm8E96XnJnz1/oNcjSVfX194Ftx5W534kbKQ567/\
LfyvKORk7Wbs2dQH0PXdY+zJZvoVyVXop6JW+yTqAIXezaBu3/\
ziBl2WTICeGWv5XLgh47GbxO/HuqNHYU7Q6VVXsf/Pfo15hTwd/\
ZaoC9i7n++3n0WOeol9yifUFZg1hV9anLwy6V+ytW+iXSYfSH4Ug9+\
xuw1x0QTiFloZ8iZlLzt+X5n8UrlZOn7wT/pmKS/mgrfTsJ/SWPI6VYdg+\
DBzAjgaQn6SIfIB1UJx+BFDT7Df5wf+\
61km43pRm3jhfPpoKCn2zLNoOPbCpwd49oV9BE1+JeJoDcCFDPIuJQfor1XNI+psNoA3K/\
Mjj4+ox5BPu7KvF/\
gBeYggX8tc1RJ9zRfM55Dn5F2VH8Z4lFtcl5CHpSykrkPdUJVxeONv6tlro5d7brDO6f+\
Z5/3+xbxHVifu9aI4+7nLjoPPsfS5UwoIe7nnJtfm3eH3HvJOjCb051CqlcT/\
HjQGeZ89Hjm8JPb9+i9GH80pXCvFI79ff6JHKw7gB02cJ/Iuma8xeQV6+om+\
KnrLnfgvDcmLkfPkQD8C6LNnhL5Bno+\
T36G5irzLMPpQ6O9XIS9Oa9HPExnIZ3JvcChcgq9Ba+FX2nnGW+AU+N9yLHQb2J/vc+\
zlvpmZ2MO5HqLeCn9abiTjxw+KQc57gM/qlJXw6Rb55mqhJ+DMmFTsYs7P7G/\
mvIJ82OlcfdP5vVsj5vdC7Nc0EnFZ71Mi7498WWl5cfD/+zTk+7MHchbdk/FsJn9edd3I/\
uZ8X+RhA/KlHRd1vTYVmEcJO2u/3IxhnaOsJt6vtmnPutyWvFoli3pePdMb+\
3VV1B0nk58il2+DvZ1LnY/eiv0xpQ19JLS2j7CnT4hrmx+\
6QtfSg8FLE33SRqF30pBB6OcOkW9X+Qh86p8IvRZ2gX5VhiH/u+mHoZaBf1LT/\
uhXXifotccNPlQqgJ6Vug/9AseQ5zcce2ykEE+SI1YjV/3oCycVfA9fNxcEd5I9kdfHrH+\
l7cewU3/D0ZMq7EeYjuSt6Dbk+UiJ9BFQN5IPZz5ivWlWLIve+\
a9kXXi1Iv5pGUfmvekDflsT+ghq179i5ye+EXEg8t+VRduhm1EZvgQ857rzEM9pw/\
65MtyFffZXx5CTgWKdKh9FL9bRJ89oTp6mOlLkW23+\
Bx5E0IdRmk2cy6wvcHTJSVF3mSX6FLwEp2wHgX8F3diXjuO5ugd4rjwXfTJsRN7CEvJJjd\
//4w/8VE6NEHZG1AduQ5+lNOIaamERL5wp9inemPCzUArPz5+IvSsP/7W61EPov24g/w/\
oc2Z0PMlz5ou+ZPVOsB8wbzD7OGPBNd0lH/TdVo35nq+LH9t9CXRohf8i/\
aSOSu1JPEfqTr6e9vkV681j5JNJf52gexT1gFJgC/\
ybCSIPZjzrPbXGLuTeG79bbXEUum0sgR3y227ptbLCh7w5l6rgwo/\
JrHfWu4AHMY7oXf5g5u1+imuFGfhHu7qi1xVeML6sUvDF5gL2JdINPXSbij5FFcIf+\
jwTva0i6ouaCn66qTzXqSN83GsLft3uwzrqDX0K5QXEF/Vfh5G7FyLf1KM4+\
DxwFHrZdCB+ijd2Uwt9CD+Cx5Cndy2WvN7aL6BDShfokp6fz9o/xpfbA/\
p0nQ39doh84KfB5Idk9rd+\
Z1TO9cr6u88n67N2aLaVn6j93mZdjYBG1vf6FNN6jvYpgXGMXY2+3XuIvq0fyTxq1kc+\
ao6E7o3yQudTQ6Fn/droS/QL6/nS5j/WVe1fk/\
yWQuTVmJHotXZmL3aiiCfPMUbwuSn1S2qOAcjpnnng0iVRb9tKxHF7kndllCf/\
WV3RAz9vmgfzuNIJ/Nj1hd/F08fKWM+6Qm1Qks8mdTZanSXwezX4oa+jz4y0nH6teqYH+\
ns9ned9JI9EPUpfADVPXeSjnBPXhtSvme9fYV/z3QZ/PPqASzueC/vbHvlMHv6c9/\
hjB26vsT7LM+rwfZuDyMu1WuDD0n7geEwA475XEz1JzoRfNd6ynliRyjojB+\
tCzYd9Qa00/rx67z5xo6piXz3hC3avpuiP9Bd9Mq8WAxdftod/23YjH5dYT6j53MAp2+\
rY27Su4MJ3kSdYcTVyP+\
Q68hIBXiiZh0SeyFP0KBd9SaQJD1gPPDsNP50fIOeJd8mbcr4Kzg47iP30aI09ffkefn6j\
vlXuRV2FcQl51WuQb6uvr4bfMjKcOJUf6xnj7W/kKvYG/\
uvzwuBr0ffsu42bSZ7PmXvWPqa8qyvx+qOzsIeFFeTV2UfkmV1DDo5MZdwbczP/\
bfQbMsLGi/rDZuDMLPKg5KweyEHJ5+\
h9cxvsyAMDPetAPqhyn7oEuXMf9OWPyE982oNrz5W87zt9qcxU8qDlJTbozZp/\
yE8g9ZfKvUyRxz1D2N/TjGNlX8bvCU6YDjXQ5/tDoPPCjuixbTP4lOsZfzdFvWc1e+\
blexq+vvcjTyKgM/zt6Ah/crREv86jz3LJA/h9SiXs4R76Ohj334O/UUtFvspnkb/\
dnrhBFnFzbS95RmrP+6JPYCz+0nz8A+Mf+ZF6yxOiTpg8O7PtdezDn2noSW/\
8KqkS9QLydPr3qT/o22AELED+3lZiXbQTf0jy7QgeXEAelfLEk7UGGnr/\
7DTymRUs8jKKgGMdPoDLUfT1kmtSn6sepR5Kf0680Iy8A327old60zje/7efWD+\
MQn8fd2U+E2shZ6J/hjQaP1H+\
2Zf1rRP5ZkZOUfcXR52kdh26an3pv6nLEejJEOImSoHLrJ8cloLPmQ48fwD1xtI/+\
lFJ38l/VBaxDlZsqGPWe27g+7O+zNc9L/SrM5r3nt6I/Qyhf6fZUPQpsCeeKQ+i74Nsv5/\
74qkzMSNO8PfrttDpeh760lQtg111KG3RW33sgr0dHsl9AyrxuzGLeK7jZHBmySj0ZWcCd\
DlLnpGRyr6mMpV5SZ/wX6SYe/gXBcW8+6bD72OiP2WQqEtp20j0t2mG3ry/xrjiNjKux+\
WQi+P4OVKrUPyzwTmt/AnF6yzx/eeFRd7cBfZBYvaBs+\
H0VTTtWiE3qdR1G4OC0NuAqujhRUf8iNHr0fsVeUSe4T7G6dUNvf3M+lAPmwsexKVy/\
76L3FfgEfMJH8Dn0vV4z4WmPK/beT4viBD9J+zRL9df0D1RZhzaHnDKl/5OisjXNFZ0Q/\
9bV0be7+JPqR14v1mlkFiv7mFcHqJO5cMBcPdOB3Bh1gJwezn19Xp76mDNTvORuz39kKdq\
ok9rMeRAOTSZv/8QeQ6XMrFjJejjqW4Yjb3tJWGPXUS/\
ksVJjHsrcQGpKH1QtbysM7UedcAHe9E3ufU49NEYBx7mdaPOZONa5OPDV+TtGn2/\
VBmc1b7nBr+LDAHv+5Rh3C+nglsuNqJf0xKef20R91/8gV5tht5aXvIqzWhhz4uL/\
sDjqT9XQ9mvMNpS56l8OC3q0dAjPR/xYPkrfSoM+3Teo5L3pGcnP1J715urA32N5DaFGF+\
v04zbsOV986mPVmIfQdf1/oxzaQXolkmcXJlJ/bF87z5412Ei8Zxfov4+sS/\
4Kx0mvvChIvOoUovxhor+JRUvQ9/ti8EF3zrIU6uXjKsz+Y1y0l3ify+\
Io8qhrLPVVrPAwyr0HdScqCvR2xcgfvKT/FVtP3xQ3RZCx+MZ8HH9JPha/\
Sz0idyE3t4hP1M5Kvihl4Svfa5jx0piZ+RhyIO6FFzVc2O3lYpHwOM58YxntIi/\
OIi4XBf6uGhjyHMytmzi/mf1iRf4ibyKBr3wixSN/uib6PutrKwFvfqtBCc23GK9svkc+\
FblHuuYXufBM68ejNeB/qzK4NOirjaC9VbQUOgdtgN+lB7M3xeEc3/5f+\
jdElEfMnUp85j1XeTvUt9jdGW9KF/H/pnzRB5TOv2sJZfsYt3XlPt+00dMrlce/+\
HvUvZTbIi7mL/ZL5KqkIdg2FdDThtURp7eIJeGB/0U5e438cdy/IIfO76AV2GNkPcg+\
hRpLZ7hdxQTfWrz/iVe4yr2039zv2k3i+t7+v5oX6kDkhYwP8VlM/pYjbi5/G4y6+C+\
BXl/SZH/W4l+HOrbgsIvhF5aq7vEfTJEXnIR+kZpHajPVbw+Ex9w78S64oI4H2QN/\
VeMDpdYP804xDx2PUTvZwl570x/PTOIOmh9puibsSIX/\
OvWmPs9GKd0FL2QeyDv5g3qJPWNzfADm2k8J/sS5Oyvin0aVw95/EMfDn0leXbSM/\
ox6bbUT5ofFFFXPlng7wX0se4P9geGkietrivOeDaLeriV7xj3a+IY6lInEcegHkAfL/\
I9oiciz8USuP/WS+bXORO6v8HuajNF/cnE9+jN6rfY0/b5eP9nkb9dQ+TvNm5CXl82T+\
bTuBRysIi+uvr7DvAj1zPslnEbv6vcdXDIdRl5AGGi/\
10MdeTG3P3gdraj1C21nC30dyt8a+IAHl30BleDyyLPnjuY3+whYt0/\
QtTpk7evRAxk30TvA26GL7LiVvqzEfgtE9rhpzclX8p0IN5ixBMHUgvTV8GITwVvfoi6j3\
kp6NvVtfBlqoTd9InEXmbhv8gR18U+93niE9PYF9H7gCum8wXihvbbkPuHwq8/\
Vg75WiH6oRVojd74tQAvr44TcQbit+o39s+\
N8l3Re5dZ0OXYGeT4uPDnO5KPo7s2JE93SgH86pDT4NNh+h9pkVfIC7nVC3513cr6/\
jJxEjNd5T2OpcDBfp3Qs0UL8QPqXBY4+4PxvemAvAfSb1qvJ9ZHmezzSk9qoCfnRd/\
rz5wboR5KBf91+oAY0+lPKunsi6ltqcuRbmHPtX8D4fP4GPIuGncyrPvytiNP+FJzUY/H+\
QjqpsuM67g3eh0j4taurfj+QXXRxwX5VW0ToFdfcQ7BziH8Lg/zVr/\
TJ838yzpJaU4fcqkT5z3oOfoRLw2gf7UyHVwywt6yHn0v6jVTiXeZawvAv5XfRH0L55rIX\
iK/s3UN5GdiHugwBf9OP/UEvmwV/bPfTxT7kuz/aauKIIc7vwg/ZDfyWJm+LMpn+\
uVqffCn9de7iK/E94MP+QPQ/zTGo9dtAD1e009DC7kF3jQizmpm0tfEcOWcFKWyyCc8Q/\
2guZ58Om35W/jjuox9x4Or+HxnFuv55SvBrQns7ymu+JnmauyyeRT9NR/aiHw4+\
l2Zm6pi1/+I/nKO7IPJnqJuK6gZ8zLJM1N3lmE8i/BX5ItRrLOCmvA5gnWW3q8+dD7P/\
pdhL+oOP4t+EnleMM5twt9rt459j241sTttiE+qA9nXkbrvxN9wJI5tntf4e5njPO8I/\
aT1H5yDZpydBD6fFOdw/DkJ3aLpQyN90aDz39Xc168n/kTtt8SjLhbAHn1m31N7eg6+\
HlzD/tTgteBkVqYVf9KO7CN/9RVyJx/LDj+8FxGPrZXC+94l8r4PjuhpHvrHS4/\
yggejxjCfZSfhUw/6bGnO9E1QSkciPy2rgWNPBwv/fQp2Ztde/MXGxK+\
09KvI89dmgg59oXv1g9iVEqwP1Cf0d5Sfx0OnCdXhtyP9dqWT4Ixynn1eyYm+\
qto78jyUFy3xe88Vg18riDcano/Q72Kcy2FkQl91z0fs3gfsuuFIXob+\
cqrIL0rh9yPoh2yIvrPasLPIUV3Go9rDJ8VH+F2DV6GPUbbcd68D+l2HfB719jVw/\
iz1s3LTEOxWHuKo0vpg8MURP1QeRB9obd448pvrgPv6twfwL5m6bKPtYvy1v6Pxv2T22+\
SxIv74Cr/L2HALfg0X5x91pF+i2U/01ytO3qfZi/iZMox6CPka5wAoZ+hnaran/4F2S/\
DDD3nUE0VcaU92kTfZBrvkN5fn3KY/hFT7O/\
7OvUDGtSwYPW3qiZwto87cGC76MC7ciNz4YbeMKdgbbdc38GFxKDizRULOIsvAB1/\
q35SJ9Lc23KmrU70+og//6/e1eh/+9lTyY6VuUdAv4TzXePLVpQw3kSdQB/\
k8Sd8po10V6B9HXxajYV3oMnM08twOO67M5iqF0BdIL0BfWjkdOisFJjPfbAWJ9xiD8WPO\
e+OPjqBvg7r1CvMPJ19Kr9EJeq9JFnaX+kxpPPVWcpsQ+D6yNPZPEfkN2cjDlg+\
Tzy7dAsdMt2LIwXJ35LT2NOj2vJmIe4q6LI+F0GViAM/7+gY9Pk38RN+\
wVPhz5EubjwaKeD997M0G9EE3ZepCzWL98NdPvcJvuxgA/iSdRj4rUP8hFRzC/\
RVrgPfvyW+U4wcKfpIHLf1+zPu+0i9NaTbHit+rY+ljbFTbbH1vJHJuitp0Bf5VlZ+\
iP4KoO7nqx3u64T9JNTm3QbpK/xWpLHEPrST7xuqYPMTTnFi3yDP9xPqadYP+\
WNTvvbgE7rQin9Rwmk0+i7Mn9HGlj6ZcgPpbYxL+lLEeuVV73hF+\
hqh7yUUcynxOXE8t4AjfB7eATynhvC9yE3HIzaKPegf6U6lV6T9phFPPri+\
nT74yJhN5TRJ9Bo5zDqG+qg70rcc5jmrFgoxjAPVDiofoF/\
F7I3h9jvp84wrnBBllC0GPu8RPzZP4cdKwcP4e6yj6+2Tn/\
YNN9P2N6B90BLuuhmRnvjcbgieXiP+oOUT/76RMxuXQnufFd8PPvEG/\
ZLP2AMbXmX79Wthe/OtvXVj3n6EvgVHqAzixbLzAOfwzaUMDsU7vhbx8wW/S33F+\
nXE5Cnuxg3iNVnGwkNfS4P9u9tf0f/F8f8wkj/TsGOpfnCuAH2urwK8Ft3hOiujba0+\
83dw/hvGk0R/EfEGcxmwq7MN96ivNiqzDjHs/rPixOWOyAX/irXojzdvmuPXcsT+\
p47x1kLrJGeJ8m3TqUvSrydSZHKol6gTpN2ZUKSFw5SB5UgmcW6Ysnoxfmu8I48jNet7sk\
YI8RxYEVzZ0R9/324KfXemfZHxmPS3t/kh+\
3nHOvZVGHsNfcaZPrfGBfWWjltivsRH7NLvrId/fAuHfEoEnscRxzPOFqe+\
yu8l4f1Nnpe4j3qMXTQUXQ/vwnBjy5qQ75NFJkeCzdiOO+d9aCJ6W2g9+eF9g/VmJ/\
X5tXTif61YhLvcjCLwYmom+Fhd50TWId+ib2PfTP+\
FHyR5jsXNJ5CObXvT3UAO2IPfl0skLnhJAPPoP51IZXRtBl9O54cOfF6LunX0NKedt5HmU\
ONelj8jfac/5GVpl8nuU7l9Ene0q/IienOOrzaCvinmB/Hq1InmgWuxk/\
r74LP7Yu07oV33wXf5Ul7jpU/\
aX1KIivl39OnZ1FOdPGROpJ1UXx6FfIi9DiQ8U8TbyvrWy4ejH0avgwU72lbVm5HWYbsvF\
fuImoT+iTrzTG/ArkT51asn14LA/\
54LoT0W//HPUReprz1PnmCaTfxNbkr8nkfepHqePjrzvidi/EXGg0iuwA+\
70Y1QiRZ5QiXT43Ja6A2NobeQ8iXOa5U572O8pOQ3cbfUD+\
3UulHXsD87llTqSB678tRHnKXDOpabN43eHp2L/PkZZ6wipvziPqSDnQGi+7Gebfy+Am/\
bk4xuR5UT9FHmW2gTskO6TRf+oba5WH0ppXBbrumIbkefYqyJPn3NX9ftvsMv1qK+\
W3F7iLxy8S712IfoVyafYL5GLtGc/IugjdsmHOhVtJeeHKiN30G/\
sAufzSUdb8vvn1D0aparh5+zj/C3tPfsvZrlRyO+d18SzR96En17U68rl/\
oo6gOX4IxL7PMYs4ob6pqfI79ti6EdV+gDLEdR9qTn/QofW5NPodtSrGems06W/\
Z8W5w9Q9ahV7UadTgH6t2l36NsrZqScy/5GfL8eyHtQbX6H+d/Fk6gUvtmL+\
VYOJC0Z84hztkXHwp0cs9cE7qP+Vh5HPp4+bCJ2bCdwwE5Dvt5y7pYe+A/+2XGc8lcg/\
UXuK+p4enJelrhiOf9AlETncmkSd98Yu1NuM6QG9lNzYobXzkNMFtclHcaauUzn/js+\
fgzgnOGAa9Bop8h6LDWE89ehjJkXnFnV2Iu828gl+8tT8+\
MXRZ5CbGM7Z0H0vQt8JOnWff3+\
SR9raC1w6HwT9XrbGDvgcFnXaDZnnEuo75FPUPcqDwFmzg8gfHb2A553zop71zy/qYRxE/\
dIfzr/U0+gvoc6oDt9H2dCfIM4fe+xbAD/Abia45wxfzfX7sccDY0T+50jixB+zgy852d+\
QU8W5Ohu8eM7qTOycH+cbayXCqZcyAiw/QBr/5pT1nHYDrDp8s/qfk9Z1+\
QxLjsz86IWZKuoxHSU+R9fEfyozDXvah34TeunO2OU2y0X+qTjvcHyGWL/Rl1ZOoa+\
J5kCfYakf+67qHHG+8gdxfsQgV/iQzD64Hr8GuVXF+\
bPXVuBvvec8Ls2Pulm9jejTEkMferkFdS/yFc4j1Xa3E3V6nGso+1InLZcX/\
aSuiXNaEw6JelN79MCJOitpPOe1ShPE+ZZlOZfDHEddjT7hIvjWZAnzLnIB/\
VAnEtc5Gc1nzww+T3cAtwJFHWH92fhDozj/XX/P+ZnKO+qutUpi/\
y2GfjdmBv1e5Ln04zL6aMjPyRvs140R+1mF7oh9Huy5WkzEp+\
5zHpF24y56fohzdMzQSPynAvQVlpaLuu887HOaKZyLLVdlHa5vFX3Ky1F/qT4T+\
9rvtuDHzCuLXRR1ZvJf8k6MZiLeW9Qfub2RQj3foH30DWiVjB4/Je9CvX0U+\
343mPhvReo85R3kx0tJ4vzJI7uhwzv6cyhJH7BjRV+\
xrhjMOktJ3Y//MYd9IMnrAvb8NOdxSL0dkasBXZH/KM7Hkmc5QS/\
fEOS5L3SSaxCfM2rTb1XfWRV5LlQKv8WLc3ykkvN5zhPRVyRA1KUcf8946zlA3ybivWmi3\
+JhUTfaJS/nrD+\
4zvnsTcci91mcZ6vkZP0vJ0EnOYy8QTmZ8yOlWWdEHrQz9JyajBws2kWc1HMn/\
vWY58yrCHFafV0GfnYc89GWkw9u5hsIXf3d0LPbL5HrozI4u5W8crNneeI0l2ygQxjrF+\
nRXvToQorI16AeWxnwGnq4k1et+BVk/D4z8AenUwdhzl7BOCqS96fnKwxeX96AH7qIc+\
LUr5zzasb2Rz93U1eq5MmB/DXsgp3+wzlO8nzR16Dfc3D45AHwvbWIh+XkvGrlb0mR1y/\
yZh5XYd/p3Sb8vJX78aeC4KeWyrkiWkXqs5TqDbFbSeCo5s8+\
lPzzN3EFl4H0E2xAnojmTt9F7Qnnk6rfnuN3ycQrVY1zgPTy8cjBLNEHeQnnoJrVOB9Mns\
x7tF7ZiAfcew7OfA2Fn2o6n68M5XkdyPOQo6oQx/k4CH1fSZxMsyd/XqlNvZjkST6s2oM+\
8vrv74zDReTdPjrN/Qns40sa6yNjLuedmfUKMf7G9B808toLPToj8rFFn+\
JLqVxDJOQnifokZTrxCNNEHqUD9M+\
RLmwH5weK80UWif5mtvSv1JbFoB9Ru5nvrZWiPor6PCnzFvzPNkacn5aHdUFD6h6lt2eR9\
yDOQ1VOlhR5hlli3XYYen0rSryuGP3cdJeL4EXqdN7jt5nnFdqDPJ4T9VDrnmI/\
ygXi3zjVRb+DOHdGDqHOWflKv2nlnRfXSeI8nFrguXy1A/E+lTw2PYn6Aa0J+\
aqy9xtw8GY8+l5c5OE5cZ6KEs55DbIm+iKeqgP/qlLnor6/x/\
wyf0HXucQZNZPzPrX8jbBPUznXTM5cJeqPwDF52USeFztO4BXn9Zh3yXdUXvuLOBL8Vzdy\
XqP0sA5xFJV9Rqk6cS7Nkf047SPnYqkm+7lqz+LI2+fpzMuB+\
iKlxBzRJ4J9K73cOeT3FecxqYUPsW8ezzknRiR80Bzpky4dYF9PrfZV8JNzqOVT7MvIhdo\
SF/Ggf4Y5jjwsbavoYzxVxFmiOO9J3y3OoWpOPos+ah38WucGPf6C+\
9I74mma40ve58H50Nol8me0UPoKmnV3MK9s50Q+KXWt2mOxL/I2FTmoIvI70/oT/\
zx1i7zFQ++I4/aez37PyGoifziC628D/cnoyP7ncPJA5NGcp2qsngb+\
vqQfktkFekgPOe9Z+0Zfd/3RHeTrTQHiiInEPY0WnJ8m5SOfV+rZGPv0vjX8DaXe2uzP/\
o12ivMp1MP0/dcDqW/Uz29hX+LyEejUkP0l5eVvcZ5NFPkFN+qKfcgn8D+B/\
q7SbpHXfbg9ceGq5ckTqXWJcST0hq5POGdGq0SelLKxsEVH6bsKvm9sAN2kP/\
D1bz7mG74MOR1aEDm+Qb92pcRv+\
NLAE7ltJM5VX7tRxKXy4lfkrAK9zhHP0hPRK13m3EvtGfF8KYB9XnN7AcZRpyf5oEtFPu3\
EU9jbwqK+eg1+jDTHRfS1aEA80O8J9qP/RPQoO/2TtW/UsWpT6c+nnM6BH+\
45jPu9OVdF8qS/ozm/OXZ0eiXok6cwfFj4GjwIuIndffEOO3SWeJuyvizj/\
Cjy2GPFOTj3D6L//USf+1xL8Ke6z8NfXJfEuqMFfWzMHJPQHzf6HxlPRb/PpBj0+\
jt5Mdot6p/l22nQcYwCHnhzfo5+iDwnKZ78ELUv+\
eNa1HjwawLrZbNlceR9YUHkaWQqv3cR50DfaCvyh+CP6rQOOvSayvzuZFEfVGIo9PocBh+\
/kOejL1iG3sYmglvveJ55pC3417cwctFgN/5fYlHGU4l8O3NEa+ThdVPeU9Ke/\
avb9C00Sgs7shs/wSzcn3F6se+\
luKchpwfEuUfNyIPRzgdiH6tVEvvbrLvVRiWh93jOjVC3zkeenP+BW2vx66UrceBfQ/\
TF2DYAPnS1h4+L6c+\
pNfDB3woUcaUrxBHlY5wnrd8hTiv3vgZdWo0W50DRj0KNdoIPkSIfYhR4Z3SpC74ttYWu0\
7rip02k77u2vhu43H8u8pI+TviNnPtk1KB+USspzkFfxbn08oIe0Hu6M/\
RWqBuQW29inIvILzeaRYNH1wohB9uRC31iNPrweB11FpOKwpeNJr+/F4ZcTmC/\
Qjq2AP5d/4w+TZiPHH4rAz0L/K/OibwHde5ccLRCbhHHXwO/\
ToLb5gfy8hTXClxtGiEHc1dB7xfX8S9G4c/rTuCMNuoRcpOTvszyXVd+16I212eiDuxjY+\
reYibRd9i+CtekOq8YnwpepD5C3yZ4wa9759GDVdW4b/\
9w63fGH4c31rh3qPRhDkilju55Z8YxRPS/SKROSm1UCb0IesH8npL/\
rL4S8Rm1NvRZXQF7ElNH9Bmi3lBtCQ4oU/AnjBPz0OdK/8C9H/ORpxvnuT+\
yLfTKX13kA7N/aS7PYn6P3iK3e0R/GcdqPDcP5yqrEnXKxh/2MY391Acar/pCj9qKRU/\
lLvVp5ub9vL8YeXRmhfJc697B7h+1Y7xrliLv4fmhQyGDedbjvFi1FnUiWiT5LkY1+\
v7IOnhtFCuIXK6tzu+b5gKvEvH75amcN6a+wk/QvIUdbEC9p1qE3+\
lenFcsjeIcI33CNPQt5yTsaIsM7GYK+9zGmObQ8TR5u1Kq6ENdsDD25/AjkV/\
LPr0edhB7PToOutQ5wfeHL0HXAfT9Nj9R92T2ngJf3mXgB28irmC8TkbPblP3L08PgD9Hi\
Iuo29wY3z78abkWfrj2YxJ4UGES/OrxkTrMIieoG8g5FT1PFnV0TvDZvEhep9y1KM/\
LUwJ6fL2CfFYh7iubn1hnuxfld7X6IM8V11p6olzsBr9fbGM9W45z582C9KdWNzhAt9plw\
a8M8mT1WtQR6Q3FeiyqN/7JicLC71oIX+\
qznyM3EfkH9zifRp3BvqhynPNE5E53RL0QebeaIvb9uldHXqaTf6Qv3I69cGH/\
Sb2xEH8lpzhneDHn60r96RtndH8j6sLwc5UFC8ChgtT7GAGib8aUHNBzF+\
cQyvtC8SP7UI+g3hbnhrRcgZ5UzOD+CGHPv5HXLkWmc91xRcS3hoBry+\
nnYbbpIvKSyHNVJtnBZ/+O1PneacXnyJ7gYLEi4n3H4VvYYeTM7bWwBw3BV0/\
yJbWu//CHjrRDLy95iv3py9jTjUJOD5PvZdaLxu7ZjWQ+X6iXlWanIz+\
3kQt5Ef3bTRf6Sygx4LAyw0/UmbKPZ47FXsur8UfNg+CU/\
uQVcnCePGTJlzok9UgfSw6NtRHIo5YATk4V58W2HkX9lz/\
5vuqbL7zvG36O2o9zhE2Num11Jn6IkfAMHDnLORV6GPnzRhP267UVu4lDzBbnnZ8NFXWpt\
UWfuLD/1Q8hR5+om5f/ch671h351f6I86CLEH80vaiflZ2WI6/\
eFfHbxp1Gv99it40l1LFpvzkXWNuI/\
6H4N4TvgVf5Phv1V1qZ5qLfwh746DIeOk3qAL4PWk7d+NfX0Ku4C39/\
fAs6RXPurjyplMAf4Y8U47wesz/5gmqLznzffRJy1zc3z3fnXAXphqj/\
eSLWj6E7oefFPshFryPI1QXWm5JzDWGvqMORHLFregp1AMou8hGNqaz75LEBjHckeWPaHP\
rLKaO9kOdhZ+BrMx/0y7Y3dIulDkHO4Jwzowh9//R06jrkH+eQR0dx7vz9d3x/qyH27+\
wF+BGwTdQts++vZM/JeFzx36WKEnzp+QW/LYTzNsym5K/K6Qr4Wb2cqK/gnBvpI/\
mM5iTiCkoC9WWmu+\
iv1ZD9QeUHeaOSQf9Is1Z10ReO85aULBO9OzcVvuTIAb8PNgUHwh3h09F+\
8K9fIealDUQe37Zi3I85B0PbwzmaSv1Q9Ka9I/GBCqL+/\
0oy9y9Igg7FnXnPHM6BlyvIyH1V5MmYngB/\
D4Ez8mdRP5R1Gbyaml3ohaiXOEdetjmL8xL0NOKrWk36q2kuKuuoB3WJJ2VcZJ/3BP2/\
jY+iD1AG/TAUW1GH4/2Q+XTF39CSxHk0yReQn9ZFkJuy+H3SHc7v03dQR6t8PIXcro6w/\
Ea9e+406/uG47HHa8kfU4PFOXP3p0CPZ1VZF9RLYv6DsRvqV1FfuvAL+\
JLeBvn9zXpATyCvVP5N/xCjZ0H0OYqrer4juFEzD/nBye2F3fAFX+\
oij2bIIPhVivpwdYKIU39nf860Je9JWkjdvPJ9Ed+3T+M9R6hHN/\
qKdYqf6Puh7YDv5jzqPJ3EOjRYxLHrJDHeI1PRn38LoZMN/\
S2kRvxdOTbHwnn9q7911XqXxV+sg/zouzmPVY05iv7FZkKfXOi31HU642p+FntpK/\
LJa1J3Lc0SfUnO2nB1bQv9V+VGHzaCU+pkG+EHBSOfsuhv9KM7+JdEHoTcRNSR37nO/\
s3PQ8w7sxE4UE/U8a+YLeJZ1MmZfqJe5W8szy0o/\
I4Z9AfRKuFXaUlf8XPWkd8vbWG9ac71h15ek+GLDP4aD7fy+zzgkTKffGt9OPECaZ4E/\
wY+AJ9HduD9NjPhw7zxrIuml7Lk2Rg9DH50ecN7H4nzyVfhXxqBMcIOT2S9/\
IVzFOW2dcHZoRp6dZb+Cdr5WPy7N8QfjKf38Ac9S+IvB1NXZObD31AOP0ZPugg/c+\
lt5nOW+ISUy51rVfIE9V30YdOy0Z9BVTj/\
UysqznWc9oXPXoOhT7YJyEub6sjxOM5F0pdQn6AHl2cfI1rsdw0PZzy9P7BO/\
AlO6LPo12K+rIYcFfoD/wuKOFC2P+j1NeTNaPQRPpRIgp4B09GP+\
zXoD1KCdZucJvostu0t7NF2fr+\
Y9YP0ejJ24o6oh10bwPgXZWN9I85HNs8NBC8L03dIXRfKONfgP5qpPsxncpbwn1hvKdVbI\
Sd/OadU6k8fCL3NKvyHKM7plE9vgO6rhiLXpj96WcYV++JGvZl+\
j3NulM63BQ4g90oJfxFvnM48a5Bvbj7z5n6HDOS8rPArF3D+uOIr+qz0ov+\
d1G4NdHcvy32BI/ldL9bTRoEN+O1VeL5Wpi73xQ5iXTV1mRgPfTz1KpwPLm2CP+\
rtEObfmHWAWjQae/iFvF+5aHlhHzdB9xGfkKuayIeS9Uys/xdCt3wi7/\
AW576Ydcdjn4I4X0XaRx6/XJt4i7STOIL+QeyHF6G/hrFc5/stOcCZ9mI90lSsA2cQ/\
zETy4OjJ+hrKQ8V5ya9icJPtqmDn7yevrDSyo3cd+22iFdwnotWnT6WRiD7wmqdx/\
iHj9Av9dMWEW/CLugN9sKnduHEZ35zLpaUH3uoZrEPoXwGz6VNxDOMI+\
7CTiIH6pISXFejD8YT0XfAbjX7yRW3kY9xg3P6lAVz+\
H0geKL9Yf9T8SRfRfLifAQztyLyCakzVUPBIWM858ybJ+mjIvVkP1ZKx0+\
XT43Bzj4dwXjd6Lekt/UAZ770xR67VHsNfbBrxuKP4Pd1sd+\
wB39VKiz62Sbbg5fO3aDnpDti34d+9LqZyLq2Mfkm2tMy+P018MPkDcMY55o9yPNM/Hul+\
QPRV0TU4R1JE/FScc5us9L4EQ7sbxvL6JtltqUex1joAN5ce4J8ec+\
DDplL0PMvIn4yr54Yvyu4EZ8L/HNh/aAO4HxOKYzzcZTYTcQJJou+\
ZbLJewrQV0BaGwDf7/4AJ9rTh0+7z36P8aYB9597j/2x43wvqVAhkb/bFDuj5wPXiol+\
I4+pjzabkYdrRg6Aj8ND0IsTNtCpzDj8r0v/8BdPwE+\
9vsz1GPEw5TD7vfJuzlFSx9JPV6pPXZn+qAl+aHbRl7njLZ77gv6CWj3mreTei/wM+YC/\
N6kFctlZnPOcif+pDsWOSDfpDyRvEOdEFQJXzcO/GddR4vzq1dvg2tBa/D1HTuiZk7wd/\
fwn6LievA1tm+iLEHaXz2V6godvO7MO3TARv2FbNHrdC/9K+ieDk1nifMv1p6DjD/\
IQtNrDka/gfNhp16bYg/n4meaZNdbzzVngiG5zk/xA/\
x3g69I0fj88ifk4if2T0ju535v9IMWXPj7mIQfkuoHC33+\
eBB92iX6Wj9nHUMfsY7xLBmMP4wKtc+6UezOQb1/WH+\
blxfDF5Nwlcy79ovUHfVjHPdTYv1ck4f8R35LrEg8wnenvZaTTV1P6noI8tCHerUcGC/\
6K/rL2os5kU0XkJcMTvmXfgp4/4dxBuUNX9N2HujN9dhz6GUK+\
tOTLuevKk5bEXboXE3X69JNSB4D3Zgr9HKVqSyz51r7GWVe59mri503zgXvvxL5PuujvoC\
BfSin23dSip1mvFphJvspR6jW0U+xDmk+RZ21na/jh3A8/Yhx+i5ROn165H+\
egGMfIk9Jvss+qTBd2o/c55hfH/pW5SOhNV/pAyjN3izjrPuRlL3Q2WxO/\
Vf38sE8ZRZHnareRQ9kWeZ3JPp16LZPnBfxi/2P+FfJdY0qLftbU80qu5EdrP+\
lDo5Uiv0JvR188+Xd7rgM5f17V+\
iEH4dTHyWWzMa5OgejBZzfkMWMg8tl6DvPvvos4nO9Lsb4lz1wq68987kvYmS/\
Il76POiW1J32dDHt39uOK0HdWvhsLHt7DrzTeIX/\
a73bop5YdunzBv5WfijjcuqfI7x3yZ5RHFZjHZOy4PnuhsOvEA+VX4LlRmDw8o9Qg6HyC+\
j5p6k/kMHyriOcUEn5LHj6PZ59Iq0r8UvlI/E+JO8Dzx9FnVq/ei98tEPOewHpE6sk+\
hflgnJDbKuybB53lHKPCw6kzdaD/ttGa/eP/4At0Gc36Vi87D7x8tx58CyJ/\
U5sizmX1pF+DkV3Ufx87J/Zt6kLndy3hVx/wQHoj+obF489rD1bz/BL0fVFCcvKc+\
9gJNaC/qIvFT1I+QVctjfWQ4sP8NYn9dc0zk/fc6M/8vz/DPtkugd4O8/he2AEp2BW+\
7sgCN3qUYzy18iMPadHgQ+\
c24FAocWh5LP0mjXP4Ncq3sejFZs5pMr6RX2RMZ52ifqVewPj7DH8gsYmwz3WQt/NO+\
E8XJGu/ThP5duawhiKOSJ6CPBf/UDpJf1SpI/35zMLJjHtEGJ99okS/\
NPIP9Omizi3DG71tlSjWXVP4XaWryGkA8mvMZB9HPdBO7J/\
Qf1HeTj6fMrY8eldxv8DP3Mzj+hz0sgj+\
mb60CH5rTdF3aht9iLUl7sjvOPbzlO9RvL9iDPx/g79nhnxmHfasHvZXZx2rhwv/\
2isLXCgn+oLFiz5k5cLQW431j3mhOTgzeYd1lbdcZXxfXmN3lv/A/\
n9bDy4HHIJOTtTTq81YX5lV+sFPn6/4i89Fn8KbxYjHHG1CX5DeA628X8WD/\
Hit4zroN476VyV1oKgTp9+v/n9UnXV41srz9oO7uy/\
u7p6ixYpTvAGKe3EOEqBQpECBokWCFi9WoEgJxd3dUtwpDqXA75x85vte1/\
sP4XmaJ9mdnZ2dnZ257z6V4EcYEE/kzDmyNVzqh2vBA21fAIfN+gCupsp0hXmd+\
Cv9HjTaXb+04KzY07G50dezu3nPB/Lg9YqcD+g3hqEHD9biv43Zwvx8il2yk5E/aI+\
uKeeCxInt0eCdWcHgHdrxhT/zbU78l34nWL/fvUYvrrxk/5mnJHEv/T7xgH/\
gSda6o4e2Bzw12pMtzNMg8pfsANmPXiOOZYWO5fNE+O6Nn/BAO73Yjxn5VjCuq7xZF/\
OD22SWIM/JzAt+nVlfcFGiwN01R1LHZXYVvOTIXqz/Peazfj3nPM5Mswi/\
KEDOd37g95plB+JvxYxnvRnfl/1uijFSd9qTvKfX2DHtYiTy9S1AvLYp5+fOwoPIp+\
M5xnEQ+TFaAvx0LRt5SNr2NsTpVuxnPz3/C/75p+7Y6fse2J34wayD7+\
D70U9Wx05We4d9LTWT93qJnTbuYUd8wYXWVlAXblw4ynz22oQdWwOfk+\
HVDr2Jt5f5sWwz9ng2+f9WGvKJnAbgmqpAX84H2g6mnjNgIPGBt/\
jZeh7WVePxDPatj4jT2BNz0v4uftipBOQ/GNXhm9UH9GD+\
RvlgD9pPEXwZcFaco9vJh673HZ7MzfDGWcebMD+Ex1pfQt2pkVT4av+R55aTfI2N5F9aS+\
BPsOpmI58nJbg4xgX4j7TyCbBPBvzJ9oVzwmNGnpC1h3oTTX/N8/\
vDV6F98mUdOXOUPPUVramzCevurt/GOPgC1Yw32NW3xNOt0XvwGzqdQ19rc+6kLx2D/r/\
7KzxgM3YecfXdw32e433DrdsxfHrCRzRjhvAhgattvhJchXPwnlvdZbzmf5D2kT9mqSrMf\
5N8JNWAuKbVDF4FtTUVdmdaIur3rlI/ou8hbmfO7EI/npI/\
Yj7n3Fj1Jy9O5RjCvPrFeao9OgN2wteHcSl/if6/4vzFbJWQ9+0QfB7DZBwyCE7uT3/e+\
xD8H+Ofw8ybY+DAayMKsL8e+5hrDXAs7E+CN1GxL/\
pfPUpwXIQn0FhJXHXhEebJozjyoeZ+Y1/5k/xh5/gGxv3FFfTku/\
BNzfqJHZooeCtJ4B101tIOVWsdz7kh5zUp4CUy83Rgvd4r+GpB4F05jRpxX5k3xOv+\
3uVz4BPW096CY/ka/\
AtrMOdvht859GJsVnBb5o5A7toh7FXsTPSwutS3x4LXZRdOjv9eIRH2NXY//osv56HWEDm\
XnZ8e+zqTeKZTnH2gfUXqbqYKjtqyrMixbBT63tYbudTIz3z1z4D8l4Dz4TQkH9mqmYB4X\
5c97GeC6go+FHjTVnHwFZ0Dwptdl/iU+ZpzMWeT4Jh1yoed7E09n/lxHfZh8T7O4S5Knf/\
2y5K/JOfV6cFbs+4ck/h0FO04/Y31/m9W9PH1GPQrgnbY3+D1NmuG8/\
csKbG7DQdjZ18l5b1NKlL/6X+YPNVGubFzOnnjdudj/G7Ve+IL4efQ1/7DpT73GPV+\
18FRNDrq+LmJWee1zEnw8z7Uw96eAEfUKAI/\
g1PiCPryCn4oZyc89GaOGOTzvaTEf6gj1YrAc6ndLOq227gDjoEtuMTm537M08Vz2Y96go\
NqjybvXAsuir32H+bW6+pLRvC+ZauIIxe6hn0bv0ny9+QcdjH+u/\
6RvCzjfWL0ZU4t5vnQ8YKjxXmw2krc1TyMPXP2wiOtzYmHfpysRn9yPRM//yX68iY7/\
skG4bmeNxo5TwtmPnke4n3GFvRyP/srczz7ZafHOtat/E+\
w3ztv0u5v5AU428jLM86C52OOgIfJiIRnRm+\
1QNYPznstTc6R5p9kPs35JvEM4UnZU4j4njf5IWY38PKNr+Dv6V+\
JD9gdyWtzFvzCfx6KPI0Q9kHarC3sX5I/cONJ1viu7vmaefMS3xcq4342TurEm/IMdPc5+\
ir8QePbdOI4fSfRntGBb9zv4/nFINfLH93vUx57734/ccVn9/vG192/mwGjPrm/\
fzbYvTotnrr36396u/cZj5xvbj+Spfnp3nd653f3Pk+/WPf7lH1+\
ufe1rP8Lff3jfm90T8/18Bj3qr/0+\
utez3kl0P9rj0elRP9dzeNPkv531UJepfjvav8qnPa/q7F6dPr/rsrrVkb3/uX+\
Wdz7qq3O5v69+Nkc/12dh6dzut/riXK7v/f56F61aT/yuH/3nqvc77Nmz/vfVX9/\
yL1ag365V3t8/nzu549l3M/qZA73fpVyZS73+4CY7G478y3M6n5/\
s0Jm93qgndsuNbST207t8li33faG2qnc37X9kcx9f/WSSdz2Oknpr/cRt/9aop+ae9/C+\
u7VCezvysdavvO3e/02JM7Vj5WlkXOG3ozD/izuuNg5x7rjZIfecMdVP3/pg3v/\
4WfuZ6uar/tZjerkjrN+s7N71QYtRA+Kt3jn3hcx19UbfXEzV6+0loNd/bGT3nI/\
W8nmkV+1sQDnEzlrcW4xK4+rj87hdOhra0/\
0e00arsu9uL9re56fbThxwQ3kGatF4JTapwRf7ex07MaUy/y9J/\
bcXEhdnXYWvnVV8yt1Ik2kbqbJeu7Pd1n2Gw+wTzM7sy/yBz9OS07+\
thVMXp3qQ56oegRfmpMHPDdnJXwn5i/y2Kxt6/EfrG/UDxrRwv85Dn+4gfij4+\
BBVVfH4W93SsH6+vEb63YJ8u/0kk/xJ3MST9MLd2d/\
cfMfnlMXvEx9FTyc2jz2PdqgLewnsuLHaBPAs9ea58Nv/\
tESO5sAPB3rTnH8zq878RP9VtC/3PBwaqoY9v8t+wxVRnjQW98U/mH4PFUKzs+\
s7dtoV9cxrKvt/scTiH9p54fnyjxI3rrdmudbPvHxd1ZNZJ14Dp+\
CdkVwJ4rn4boSXnS9Yzj7lpl7iZecHiPr7kn8zv3Uedu5qJe0S5DnawQcw6/\
ZEst6MSIRevKoC/7PAHjBVI6Vrp9uNqghcbj2+NMB08CLSraWvKtj/pz/RX+Q8zTi+\
HbypejD/da0w7jAujsxNet76hLgSOz3ZD09VIrn/OyKPN/BM+\
AkTsq6s4p6djsBeGrWRfRSO2jhN4ztLPsT1nd7MHEJvdc25F/am/csuA1+\
QnrwCtRLznX01vL3YsGy7yIPUf+\
JX2BPpC7QmVGBfh0WXpD18IQY4fTPetIJfTtSTXARGlLnk7Yg/lTT4fh3Rn/k1X4Jeh1/\
CjgXcz/hN745it+05Qj1l4WTcH+p8ujhPPb7+nV4CY2GGdCDnZ+\
J49fawnNCmvDeDfCwGsPGcN75GPwGvcNPeNA92rPPqhAr5+\
7wKpkzfuNn1KSeUyUCx0PfexG5PCqFf/C2vKsv1lhwNBzPNuhrKOd4Vk/wWuzPHZhn1+\
EJtXsL38nXTPQjVPiOp08Cv1EPcfXOGcl8t0vAN2pYG5lvp9BnuwI44sbsROhX+\
ffIKTYt45SlKHYoVWHq/NMXwb/xnkk8YxZ4MFZbX75PPoB+9nuBHfLJwTUK+\
6CdACdD3QEXXmsAj4EqFcG+pICJ/Ba0ljxsm33DQHALzFLge9tp/\
Jlvi4QPcjp8yPZ8wQPuWkDO5fHPbQ/\
qk80I8lec0cJHfRScPWfbY97XewnXGOrarFFx8GoWnw5OwBLiEfplcASNqMPE/3+\
DP6jKFWXefAN/1zmwFb2pH9/dr1kdOhGHfL0He19wOvY+BP9b3QLfQe+\
FHbCbkHep7wVP0HQieH/YNPapWznPtW7Dr6CC4OM1csPLZT0qhH9aH94h6+ZV7E/\
hi2471KR97HcCMoKfEziDOEg5+Imd5r7MwznCF92e+gr1dZ/\
g9Xjw2TeY9lf4Q78zpOQccgK4h5oGPpF9hTou86DUUdwmr8mc1B770RrebTuoDvrUmrpTv\
ZPk66Sl7lFZ4GA5KqHUwZJnZSwQPIi8Uh/yTvCtR8BzZGUEd9LIRVzUmkN9tNpO3eD/\
OwermwF9vAE+hf0mAfrUCdwZ27MWetYgGn2v1E3qutnvaXNaMJ/\
zUJdjlLuFnQsGR8aacgb7V/gz82KX4NU/\
gJfGugEPoh13QvLSetCuKbfwO96nFHsteJEFkJfqB0608QX+\
JH1yJPvBokvR5xjwGK274MkbSfzJZ+jZmXhmoTsS95f8mNqb2WeVZ7/njAGnWi9MPYG+\
iv27EwsPoPpRhfnaWfheR4EH7Hix71HF4PFwrlGfpQ1LRjy6UxzjGk4epZl/\
O39PV5z9UaOZ+DMV8vGce+DXm/\
NvsQ6se8A4t5K64k7kSzklmB96gT3YjdbEKYxByRnPHlOk7pL8YrMxcVejJ/\
kkZik5zytPHq1d00a+gwKwW/mTsi+MjEB/Nl1FXuHUeSsdu6RH78B+HOjDfJI6Wm0f/\
D9WkVfo+QSJ44zag736C+6qlXMK+9fidfBzk5Mn4Kwmj0GlC2BcfImrmenu0I+\
2jJNZgjwUaz/xZetKYq63sjBOWSZJ/cAAvn+xGn9rouRNf8auqGj4LRyHOm8nA3gN9o0V+\
I91FzEvJyvme36px8uTkXGJAwdYO98M/\
yRlJPvt6dmZH7fq87424CcbO0OJZ7bZjVxDqQuxVmrYcf8kXLcKfmdL6pq0tuSb2aXw/\
zVf6v10vyvokTc8s2bTmuhDtgysmynGuvELwwMebHu6L/\
ZtHDgC2kLyUZyaZ9hnpxrGeYAHee1WogPo3VLqifQk8JXrD6OZx/k5F9Sj4d+\
xNXjKbKcN+ruEfGOzAvnb+tXvyGnUVvTI2Mx9ecEZNmOEB+co+e9a/\
qvoQRpwvsyZguubjfMAZzXnXGalT8ybUqw3Whzn+P/\
2lL9fAvddO0Mesn4T3mQrVvBAm8HzoGbBq2HlC8NuJK9E/5+nx06lp/\
7NKpeTuPnbMOQd0g57VIg6T+1SYbGfL/\
FLChcRXF7JxzxAnFRVkvzo33mkXdSPWdHkbzodNfRwdgPmxVPyU5xAcBKNi+\
Rb6DngFTcmUzdhv6W/RgP8RO3gYcnfyYzftLg79jUXOFNqdU/aO514ozUHv0/\
LvZznDKkr+TRc9XzCE3kV3gizGPglKlFd7GarxFIfBY6pWT+K8ben81xv6gmdzJz/\
6WvBg3bG3McenulJfDJI+EXXgvdo5lvLezb+YJ0pA56j7i/7n/R3mL+\
Hwam2vMBFscJySnx3Fu3uyPmLqXXCPgXCd21UWYS+9WKeW/W+sm6eSMh6XJlzW+\
eB5Gcensl6+EzyDD0O8/vLybh2og7RsbD3ThJ40dXldKyX047gFyxLz/iYr1iHJgnP/\
Wzi5FqHUPRoYT3kseIGf//Jea+e4Dl+vA4O37/rLO/zgjfW+U39h/2dq15T6mJt/\
Cn1jPxO4082+uebiflzm/pE65bwSdbejR4WKU1cLywT+y+\
ps3BuLEbeO4lnqwvU7arz8AnZF1Kwvo4EV8EYVBa9WDKOcW/\
Wn34dID9Nuw6vrXEUPE7tGHmB5row/\
OAD85FPwbzY4THXmIc74Ee1LOqXjfGLaNf7G9i7WdvQgwltkfcz+Aj0VKd5Tj/\
w2HTfWti1yvCHGwc4rzQ7rkbPWsKz5uw5Tz8nc35qn3tCntseyftJA66G+\
Rf8QZUaXnStdgb2R4GvhR/hAnbsY0HGeyn7Lq0TvJL/\
bqAlrykcvWsDzpZeE7w1qzD7CX0G/AUqyMRfKX9Kzg3moX8GeFYqeRz974Ue2+\
UFT6kreCFaq2ysAynhyzKSy/l1kcTMmz9SV5oaPDRVCb4qIw/nZNo74R/xAtfT3Cv5SZW/\
yfnqHsZ7ekee3w3eWWPLL+7fOoBx6yN8ix7UOZlhkn/\
XReqZN8FvpmKuor858JusjuR5WbfOsV4eAkdbL56C635wAYwmifEX5zUmP70R9f5a3Y2cT\
/wZQf1G3RTE58Zq5Hksm8a51gHqhvWqnKPbtS5KfB5/\
1PjwgOf5lEUvetQkv2HxHa7rrmDXdy35/+qQrGr4sUa8TOTTfbuA3Z9FnrBVQeLrWQU/\
poQn5yjpqR+yBPfA9BsreazEQ8yW8AHZFb1Z37xv44dNyQA/bkAR8ihegrNiL/GifUt+\
04/BqflcdRXtz7eCOOdJvlfRnB+Y3uJffViLPVrIfsRuMJf17hJ8hva9o9iHR52Zt4/\
hG3A8yDe0n0i9YVPOIZ2tRdEXnXHXq1no6zb4CfV0z5iPj8hHVVPr8LshHWnXxXXYsRDwC\
cypDZkvPSQf46w389jpiLw3jWWdfdqAcUh6lXjvnemcQ+Rv9tb9ft03zh2atye/\
Kl9Z9OXqSPezXa439UCfbvD3mS/BXdjSm2uTYdw/\
5QVx4YPLWNetbdjJrWuY937k7fzPH7Tag/NkadQtWb5if6p/\
YDx235M887Lo1YAc9GcSODz6UvARrAWrsHOvfZFXbuSrVaXOx4zPea+eC54uvYnk/\
6Shrt/wKIw+dmKcDQM+EfWHfZKeZKbUT2Bf9ODe+EUph2L/UjRnnz1S+\
LvTExdyCuclfhNRF7tfhHiNteIgfw+7ymefPhJfzcr4Z0EfjHrEW+0n3qzLKc+\
jLx7JaNdT8pFVJOfC5rPcyP8658nO3ufYtSPwuhuJwVHXvoKn71QEV8L2Xos+\
jRmNvdr1ET2eSp6KNuAw9um68K+FhOOHnqde2nopfHkrV7L+3cSfdgq+YT9hUzfnTCLvw/\
hdS+LP9N/xAb9F/zERf7fJafQlXkL2lwskftUJ3B/rfS/B+aoj+\
2vw5s0tSdkf3fiBXZ8Ljohagr+qeTGvtfPkOdv1Ekqe0XfkWl7Oby3qaa3L+\
9CHLzlkX7EQPfElv8m8Ca6msWIf8cdgL+J49duw3geCl2atPMs69Rd5O8mo33budUL/\
boKrZy6FZ8eqA7+nXRg+ZGc3545acHve16iI+AuCK1KjEHZhL/Vo6vNM7EJ+/C17D/\
E2O0DOqWOn8bs18I9buaS+5zL5e3pG9unaU/\
Kt1FHiHfqnfawXuRknPUuk5CPIPEkEP5158g7vrXsNPWsEzolqSf6JEf6Jfo4eKvUZxHlU\
DLhferjwjS2ET9vIepy/vxUe1+BSYifZDxnjhEd+\
Zyf2CT3II1XRn9GvTsLTfPQ2etYxiOvhW+\
zLisi5QUd44vQ2zBd7x0nWmyI32R9HvUMuA5GndbAe1xfwSjrt+0q+\
yGn06gV133oS8HGM7+BoWfFLo18Fc8k5CLibprfD/\
mDEVPypMPaXRhS4P3rHEN63EbloAZL/PIF6Xu3cC/RjwSj8pjFL6H9QJeS9BTx4+\
wh5zM4lznW0CZ7oR2d4e83y8J04p0YSzy4IT4RRQngviwbSn5LwstmvUrF+\
x0ldngaOgF4L3AzjSAD2ZRp1B0p4GfW3xdGPd+RJ2BH+\
tOPuedr9Hd4lfQI48tpheEnMiltpZ1X8MTNlKvYlJ9vT3rPXOD/\
I4EfcNrYjcdud8FCp2gORUzg4Snafftin9fPQt+u9WS8KglOivWceqlTwzTsx2xgnLQ/9/\
Cg4ZX3hn7LvF2FdyiU4MH/\
PIWeNPAL9qsStB8K3ao2kblGvSP60WVnqKcNlv1PeZJ5mLc3fd3dF739vwu74gjNoD/rD+\
F7kHMX4I3zPscR9VCPqhlRf9hnOC3gIVIDEe6In4iflO8I4WuDT6Y/IQzVHw/Ntj0uN/\
lTOxTjMrcJ6cEnyWMaAI2ocDyOu9bkH4/BCzgd7+Ese4QPGPZnwJ98TfNDFklfWBh5v8+\
kC5uFlf+bxT3B1nQ8tsadn4Kt1XuA/azvB87MCycOxa1RAP+\
rVZByXUAeqOkmctAY471pR8Ca0i1IfcuAlenGLfjvncnF+fpu6KstHeNuvVWVfsCMN+\
tqPuL+edbXgyx+nn2vQHzMt+LZGpOS3NRO+\
jL4viC9FDkBPY8mX04fFoEdrPLhmg8fVSQ7fsjqzlfcHgENle3ZmHdywljqG7j7w8v0El9\
zMAT+zPpZ4se01lP1tSfJsjWHgApnz2S/pfVOid/\
Oou1NJqL8yCrDPVOtYD42pyNtYsJXxXUU9jjaMuJvdnHigYVBvYB57wPlVlCY8QpIfVQuc\
VNUrOf2YInU32QV/9EII9jGiEvO8OTx9qoVJHMGnEvvUJ+\
BIqaPEvfTuIYJbQ92MXfUrcaY/8EEaA+Ch1lrkYV5NwB7r07aib9vAcVPlwIdTvh/4/\
QX2p2aadbyvCHj3WoqJ3JeUOJB+SvatibKzDszeSJxiXVXm/xz8dmtIOtaRPuAXWEffYu/\
TyDlMC3hLnSx50IdQ6lWNiekYLwM+LXsH+KLGXeGd7ck66xRl/\
berjOO9yyIY3yXXeZ5D3aa6JfmkDxPh14ZWAF9D3ad/hYmLWFu9iD/87E6/\
QmVdW0SczMrCuaJmZ2A+VscvVMNPIbfI+/iP3o3wa9YwzubOtfh5+jDsyifWSX0D/\
r5utcKvG1NUztEFb7rzJO5L34M4VTfwRVUy6gWckvgXRoDgPG1nfVLJKtD/\
DfDtaOPBJ3A8OffUlpvMk3zwztk3CjGeDalPVmN5vnos5xP5fNCX/uCgGa/voh/pw/H/\
nxM3M0rnZ3zCA/CbjmIv9IXYKX1wT/FfqbvXJzbFDhdhnTXWEadShQbR/\
sWcyxqnRzBftqVlfdhaAnvw5x/wr8eBX673k7r1g2fRs3pdGLe2rxinLLvo/\
6UoyecXPPHCX1gXDlEHZrUAp8fJCc+LNZhzEacReHNWQ85FjEj8DXM5dU32Sjkvqu/\
F838T33Yy7KMde5thv+suQM/yUW/nLIe/QX/M+ZqV6xvXLfA8mykc7HNq/\
GOjs9TPjQUHXs8Bbq0R15P2daeO11LgQulbZd1pUf1/+\
LqMR93K6OXaJehHHupPnePMK6sy67sVRDxejc4sOCN78JMOsp6oAgfo3//4plR75m/\
qZdib1eeZLxnhsTW9wO8184LLrHkIzunoFsR7DpDfrs4lxX68AxdSL5Kf9/\
8Gr0yr5MW68mwhdrJpGfIrSi0iv2Hkc9aBDl+Rd8YT4o/x2V6en/Zt741+PKpK+\
8bF0r5E+It6jwbkRUyh3t68kYr1LlU/1oO0kqcw5zx+\
YEbwSZzugpvaFPx5VW2q4BAdF31kftmRn4hDhm1nXbveiPk0pyv+\
qYqhXRfZt5slx2AXm8EnY7aA30sbzPmeuZE4lbqMvpuzwa2z54O/5Ey/hzy6w2tgP7rHe/\
IMYd5s4/zTWreB/\
pb0Zt5NEb7FAjOxQ38bc80Kn5qV7Tt5AF1DmY8lhX90IvWD5snFyLsFcWJtCXW1etpT8Ad\
Z6+l3AOcv1ua39LfibMb7C/X+9q4nPDep5H8fB/\
9alWpKe4c0wS6ta4l8g3MyTp3BS7bbw+9q1YY3z+\
zLuawaXwa7mgXeGO0PuFTO9ljyLlqBu2ta4Hebr4iPOomusg/+\
yP7QmMG5tlUDvio9YYDk62OHtPAa+Oeva2JPg54zP4fSXi0/ODz69HSM8z/UvxkG+\
qAli0UuT6iv/9cgYreiqANVg+Lk3BdeCOsYeYOqG/E8K95e/IyZ95F32Rjs13rq/\
exrNvMtEXXpyk9wBIIkPmWj53of+A6061OR88tn7C8fPWIcau/\
CL5pXGL17vJTnxH7B3n9ALxxtHX5WKTlXGR/Nvu8meRFm6x/kQbwvST7J3E7k/\
5USPK6yg7DfS8ROFnxBPxV+sTEGXHYr1TL0O4vYwTfgzSurGX7ilnGy/mxlHtWZz/\
h2Ih9SZYF3UqvWHHl16sc6PZL57zQJQS7NRZ/\
OevOc0ezT1ZF4rGsr4YFzluMP6gE3xc9PJ3ktRXnv5hSsT+\
3AndB8wRczl0k9y8LF2Iu2b1gPt1NHYC3Drhud4H3TQhuid32IR1neMcgjiPwAq34v5k8G\
iccE+vL9QvwK3b7B+ucD7pMWJTibwZ3Q90TEGc1v+PfmevDzdF/yZrWEm2lXIPXn+\
qDfrBfXjjPuJ7rR7zkBtK89PJOmQzzOKgWep9Noi8SrJY6SU/DRL7O/UJMZZ2NbbTlH6s/\
68JdzUidmK/O/WHvkH8J+0V5GvZ0e8J35sKsW/sY0cEKNR1I/\
13AK61ttqb8Ib0D7HlYmv2pGbdaJ73PAT/gKb4tRn7oFc9khxmk/\
59JOAH6t1rCT1BOXxs4WaMS8aN2P+TWL+k+7abDU58XSzzTgcln38RfsGZWk/\
o56JGvKFcE1h/fGaVWf9l5bBB9Xt9zwOX16SbtGIXctB/XTZlL2N/\
bE76zPW6rKeWAY9u0V8VxrV3PBzVrD/FjEeJs38HOMjjOJKw+\
nPsI5cws9u0xegz2SeiZrlfAw1ZbzNGcncn3Zh/bFwYtipZxFXteH+ox/\
CfDPtcdzkfui6/C5JzxFO2a3QN9Oo6f2hoHM5xcOevRnOnY/CXE/1Y/zDFUbXhvDI5qr/\
0PscBsHPTlJvE4lgbfXagJ/\
jtO9MH71q4LsN5IUlHic4NaduYofk4lzRaugnIc1hr9GW9CGdaka8jSbLUEPylTBH/\
mRGvldT874N+\
zGPmOOgxxrwBtoJjyGXMYd4Hfjqec0y6xhfWkIf6oxnOfbo2axbncmzmF1GMc64UEcTy2p\
TnsWkU9mvX/L52zwZ6r5ydD3YT0Z9zrwsjsWeWRK5xxfu9gD/\
U1Bvqv2Hj1TgfDGOL4D0asLXyQfrAb6/NrgnCIXeGbOFXgddW/\
4cOwRW9CTBuD16sYZxuMO8VtjmOA+tiuH/AaTB29fBNfFWNmAeWTnRV+PbYSv6CDysJ+C+\
2vega/CjrmAvrc/ybzJD/+cHh+8diekEXo1eipxpmWMjzZQ4rDhuRin7OApWOkfYU+\
7gEfmJCwk5+XvsV+3Bb/YD35K237D+cPDFfij0TMZ/\
1PYe7sXfCbaicTY8Xb4X3pn1ke1ivw8p2Vd7PsD8O7Np+ShmLVYz61PDen/\
cPgx9SE7qVN92gr/JIrzHrs6uLf6ovTEE0qSR26mV+\
yLe99m3c2t856GFZlPx8hbcxaDu2LaEme+Ci+1/ekV+W4v4UU2LPisHHMK9z0SHJss+\
ItOhZfYr7XDeb7N+mz/AX/\
fCNnDOPcmD8CcQN69tRO7okVdRo9ewFOkLtfDn5lehd//zYWe74c3XU8LX4n9yAO9zH4Xf\
2VGXZ57NA9yTCP8C9OJn+k+1FU64/zBD/hnBPZ4YQT72rhcyG0FvC7mCXjTtGnCS/\
dC9tnz4M/RWoOfZq8Ar0+\
Ph51WSagLM7tNY97qxCmN3fDCOPu64Qd9G0z86kEk127zeM9h6iud0yOwJ2EjaFcncKHUP\
vigNZ8yPGc5+adqEfl72grOZ5ycFyXOCO6L6kUc056Tg/Z3hx/ASjuAeeDnyf4/Gv5eZ+\
B9/OjH1O8akz/\
hj3ucJA95ITyumt822ve1HuNTtiDrQoUN7rqn1UtN3GdPbu4buZP8247nmfcrN2M/xlH/\
bCykrkbb+Y5r5XjE5yNq8/lgC95zwh87e5v5qeenLsUu8xf51SJOqu6WQm8H76f/\
K8mntKtOZHyivQVX7Bv7m+G18XdrNsEe9oCHWG/\
0k3Zewk8yxoITa2truK8I67NxROptZ7Ae2wE29skD/kG9J/FzO2NjxudBA+\
SfW3ASbcZJq0p9vloCv60Zj7x+6yF1p9YI+Aat88ITkWkt/\
S8GbpK18CN2q75Je4s7yDfmNP19TR6zPrQqfv/Gu+\
S3JkhBf6MWMk9anxAeHngk9bfwOqqFI4Uf9omcm+EH6hEdeN9NBb/\
6prT4Ea3Jv9ZbJmQ821xHf5pSh22kBAdJxXBuqAVR72sk3YP9eQWPvHZhD35N64604z04l\
UrzQm6fSyG349SjOHnLS/445wxmU/DZnJsSb48/gOdNLAlvVnAC5PYcPnndi3xOc+\
gn2pcNvltrA7zv9ueS2O/\
mrGdWwero43POk4y5Crk0CUGuB7wZJ81iXDsR73NGwVvt7CNPyyg+G3/\
h3CTsZkV53reE2IUi8J3aw57Szxa9GL/\
Qy4zHF3D77XScVzohx9GXhuf4fPsj7fKMYzwSTKB9f6aTP9stKXLwaMf8nZqPepIbFdGv4\
R7YySqsv4YPuB2mIfmldcGNVvP2sN4uFz7ye5w7OFnG8v7T/rzHz6Se4cxAeE1PUD+\
kN23C+MTBf2hc+U1/81F3rQ15g9z2kpfrJGD+OfdYl9R19EO/OBp/PBU89EboW/\
p7BP45uxfxP73OA/\
Q9aYzENe4znu3gpbMf5KDdFfi7GfyB8ehMnNrpCJ6QXpv4rWXVx09Jzn7CyiF++hD41pwT\
XvTrdxXs+dnurLsXemOHPMV/1M/jd/g1Y7+XlLiaHkNerlWU8TXC2E+\
ZvaiLNpPAE6ZHpuD+kX2xHx1WIfdvCRnv0UOJ53U8T/1D+\
hPIaSjnHkYv6hK0ddSJad4lGMcx4GKZI8CX0a5Vxr5kbUz9TX/\
hlwtxsBf78G80//7EF5JU4f0NxyPnl7+w83Gip/\
uFdyAUPAd7FuNqrwOX0T4NbpDRnniHtkHyqhq3ZHx7wgtvjLuCPT4Pz6GdbhKfvWNp72p4\
hJy3cxn/+dQdWrfkPPL0bT5HwLunl5bz5gJV+b5oMn53cS9+\
dhBxMWsquDLW4d3YwXql8Odmdmb9u/RB8GTI41Z/RzB/fwgvYFgX7PD5V+\
Jve2IHDPJqndeHuPYEV8TqBM6I8yodeABzhyHXE1HUgXneoO5OH42fl7I2fqYDT6A+\
Wmfd9L6LvnWH39lsQfzXfJcNedT+jh9SID5yqHuWftbyw75FHqQ9Vy1ZT+rQ/\
hng1Zqj8mIvPc4h/7ud0f8gwR04OYvxufkBvfSKz3yofRi7Pbsg+\
vcP65lRQupP7ULcP7cy+4n61Bc6b0fSzrPLaPdu6rasn334/\
JY4s2HC165G8n6nETg8WtXq2JMozomc09RvGp92sI7t9sNOToA30ohhHVbZWBdMj23IR+\
EH6we/IZ+M2CHDBBdHlSAOou4QN3O6wTusBRbifdlZB5QH+z89OfzLakAF/LICL5jXa+\
4gl2xT2Y8Hk9+lbVjC/HiVAPvwaxXrXu/B6GWqKszTzPfQ4x7gElrPi+\
PHHoRH1jm6F7u8RscvnPcNvZsL/oTRJh/zYeAr5NgNP0xZ4KTpj8BR03u+wa96Br+\
aVQneU+0l+fAqRUf2XXtC4HWvOtLln1bR8eEBrj8EfQ6ri/\
yzJ0UencCJ1ZoR3zVGJcZuLV4mODvojT6XftpDfBmvcPwTw+s+\
49M7gOtk8gb0kDWsN7XggdHPkG9nLPDFz4wkD9mu1pX5f6O++K8n0ZMk7Nf0tasZv0zt8G\
NiZzJvQrylXqQkv6/yhHhAgTjGPTSIer/t1LXaVhfGO8wPv3t9Y84FpsVz77P/zOdzC/\
LmtQjqWgxv1hu7ALgeajjnNXZhT96X4Tnvy7BG+CP6sh56DmE+zQygX39zMt/\
Sso6oXQnQh5FR/G5TffR6BzylTvXn2M8lxD/\
MNfCGG8kHMv5vZzGOH28wfmmI65lnqePT61dl/lzrJXk+\
1PmYuahz1M9S32SN4jzUnMf6Y08/\
Sj33xQtSJxRCXefvHOhxkqOufpnBN8GZm17P1TMjeNAx95r+o/s755/\
p7mdVbRZxrxFDsauPezIeX67gt3z2Zl0rT/zcmMV+\
2AmAL9BeHcN9Jwdgh7ovQH73kmAn2xdDj/NR72zuKM/83picevRin7EzSeAB0fsR7zTu+\
ZG3kaybe59TMKfbTnVwvasHTofnjM/aNK48rM2v3Kvx8Ag4VbMPub+3jMboy/Vw5NP/\
HX7JxTz0t2xP/LWrXZFn+lacK+1C35yfd/AXfxTk8+Ll/O677Ltf52I+e1EHrrLMd+\
XulJnIenhqD/qzLJOcp0k9eGl40dXtHehH/RPYh9ST3edZjz8wHyZWxK77BjP/\
04CX6Nxkf+MMgx/e2kA+\
lFYpFeM3kLp462Ub7NmXPdRjb19Bf855Yh9jkxFvKZ8eee7czHP2VMderMzEPDsznvlXZT\
Hy61IIfKFeCV2cMOt7Wsar0i7W43zooXX1FPhQA+\
DFNrPn4H1vt6MXHeGZtko1YByaEBczlpZlPqZqKfiQf7mWkfzFW/glqmosv+\
ue1r1qgS2R28AxzM9knJ/ZJjz1emgW5HdtJ/Nw/Cipxw9CbkWCqasPHQHfuI/gKS0vdYn+\
vqQ/hRrCg1yD8VBjYjmvsHOjx53ruXqg5cmGXMYn43eLA1x8CLv5dNv9+99CO92/V0y/2+\
3vy0yR7n0VI9yrUSoQOe8Pxf85EodencGeqZ6CG3KAOiV9NvFwY/J8vu8azDjPuMX+\
5nZG9HH0Q9arAVy1/e2Y50vBkdNuJ3DtgzYr6oj7nOIFD7pXY+Zh93dpnrJ+ZT/EvHy+\
wv2d2egecagxa5FLas5bzWtPkc/6MPzAvLxXDSrNeMUHx8NOF8h8jmJeKY/sPH//JHd+\
Kmsy8y7xLdaJAcRLnIdj3HHTulNHbm6r596nl/zl4giqiO3Yzbf4X3rum8yrzk/\
BzVtSH9yO0cWwN5+Z9yrtfXcc7ReJD7l/7+/tXq2WKfe737/\
cDt7U2MSufJz7U7e5v7tZjOcdO+I+X/3zyJWXU3OEK1dnYB7eU6IQ/cnQgDiTk+\
iAe01RyG23vWsJ7R+9yf29Vu+F+z57Qr8Itx2T6rvf2z1euO/XB490/671jHP7qw/\
rQfyi7Gv3PssjHuPUeSHrxMO02OEml/Gf6hdyx1vr2tftn1Mh2tVTZ5+\
HezWHnaBdq9Ngv4Yzb5weA912W/EzRXB/6A73Gj8j+lK0X5h7//0W7t/1N+\
OjavtpWu4SvVv61Gmd/d+\
vypUpW65kmYoly1RoU7ZqtQoVq1WoVKpK1bJVylb0i4yO7pd6V0bd77+Wpp2Z2Xb/\
8z1tB/cbK110Ub1Xsn//Nyzhv/807TtsuN+80cfaqPCMR/79+5/\
eUyeOOdIz3n9vVf91TbOLtaIIph/\
FUsbP01yTbqGoZnp8kh33ZgeU9GZ1imzmPaHYNjlkr06V5ATJT24miPyK4gxnPOQGVp1mF\
HUkgyzGmVyb5KWZVzk0L3dMQLcB+dUfA/\
Kj7MQcmuUhOV2Lo7hFywiZiF41lN8XHcLv8wqZ3nbIbvRHSXDyzsuhaQfIc1QjQLVVYEuK\
oW60FDDhTIDUHntL0VTCaP5e1x/wrUhI+Qx/ilWcXBQtmXkecyjlAxmY8qdI2kpn4aQ/\
pAheNSVpyzgkZPM3CKZo02MlCWIDRVM9GgqI2TP+\
3gDyCiPvB4Iv36SIqATJbtoNyBfNSYM4nMsBCLY9KRPj+2Ux8s/\
GOOgJugiJxXySkSp9QY4tJ5AMEC+a954Tctlpu/hes2jf/LmAKw47xe+\
XUQSsWj9k0xUIWJ1WzuAwcPtE+jeKoisVJGRCuyCjc+YkQr4zatDOJpA1GRGQHljZSzGu/\
RPx+5SAUKhW+\
Wj3dEhezHpBtDdIihOEJFQfdZh2r04DyatvTUCZtyZGHq8hdTO0QPQyElAep/\
VvkgZWFiQpbPcwAZt7z/2lSYa19o7kPXVJBjGOUExqhwho7AqSEUwNcjXzB2SvWh+\
K8Oy0JF+o2eV5T/JFyPdpIYrT5g/k/lGQs/7rHSCHkbTT+\
ErymZ22Be8Zl1PmG2Rb1k1IybS+62n31wHoYW/\
IQZ2qkejR7EA5DPlO0G8Bh2pm3zyMUyRkpPbZcDlk41BCPWP+\
2yUJEprjIS9U93mfVpdiK/sF4HXG5eeMV7uEtDM+\
pDtOQFfGdbGQ9o2gHc7JtLy3IuQcRsP6vF+\
D5FGVoQjKiKb99lYBTT8OWIcxBBIiJzkkbkb7lBz+hgUzj57kRc9+\
U6SpdV7HvLn0Ffk8oFjWXjqC94+lqN1M0Rx9GKKwGycB67OOfaffpyHVM3JxKG/\
fFDKdrTsIbhafTTu/\
bJDkEMiM9O1zuS4DlMVWgElrU0RfvpPkp2X6K8W1FWhP9ZNSrBMl82o1et9sFHYzc1nklj\
o+/dvcGD1blIeiyXxCpjSN4morAeS/quMSrpk7kCR5vwrz/soSSUZFz+wKUlxdVEDBjzK/\
jCckGatNu7ErKSQpsQpgq1YGQMhVm6Xow3Ob533szbqzZhsgcwNnAlJ3fyjrU/g83l9lB/\
p1UtG+d+WQk0kRrPPlMvdd+8zzJ5OEaZx9xP35IQGz7kjxgL+\
A7Q8n6VbFANatasSjXV5FuP825G1WJshB1KnjPHf5RymaqIycXrbGvq3G/\
lopsiCXAWVo19SVzPNarGfqYSYB6U5KeyNInjXPZmAeD2C9caZSJKr3AMzGvghYiWq1XIp\
VpzJ/fYehJ20Zf30VpNYqVoq3QgF5sc7O4rmjZZ1sOh75GRNkfIvRrseA+\
jgzm9Cup1nwCy4loRj0dm3srOd9SEOS+VF0GnMMcrkID4pIVV36dxa7by8FxN45M4BrO+\
ah1qOezCfWBecM5B/2eyGp3wYZpW0noN2xFP9am9czD5rVYFy+MS/tZmlp7xBIPsza+dH/\
24nQr+1nIc98MBC9WnWIcdrPeFpRgfxu7g/alaU710Xon5EuGc+\
JBTxUHdrL74bk5XfHSG41f9dEnnlimL8PzyGPfVKsmz6X+\
BsUFZlt8EP0E2eQ771vrGOvf+KnXPhDO45tRf/\
GYA8sD8h29XVSDD0b8gHDG71XOyN5v01yufWH+eI8KMFz+60DNP8bZDN2W+\
SiTlBc7MRg57RVB7nGQkqgDwAE1TzQH73KkQC5FvDH7gw5jh/mwfzVJ8yXIu1Y5lfE/\
8YRUiHrAWRsqnoQ8zsfxeLGZdZjbRnzUN8xnv63C+R9V/H3jFSzJAmc5Gj1OiW/\
m3ANPdmVGT3t1IXi6P4XkfOIxqxbB56j390T4heX9EafGw7HPu2gGF1LRhGg1gtSAPvjC9\
4XLMWBZUOYjwNlvR6An2f8qYF+d4Yc0+zaiPHoCQm541UUMNiQcry/7lOKsp+\
8Qs8MivK1klORewHI3Y1yFuvS1+\
voZRwkPvprxtXqw3PtKsj7X4eAfqQGBNRa9Qc98H3O54J9aU/Zr/\
SzTjHGYSmkiGZoPubX1Te0t9Az7p/CPLHSpmXcP3shv8u/\
ALXNkRU5F4GMQiWgGNwJgmTWGo8fqj+ErN4MJqnSbPSZdpxg3+LUf0M7+\
55Er6o2EfInIT+uw37DnpkRvS/WS/QNkgjtBFf78Vs+v6xN/6oAyqFWnCSYkqq/\
JONApujUxL8zTCEXPTBJxs9AHuOzy3i1Rf4DkKPxIh3zITKU9ybKxvxKmZr7dg5mX9Q7Ae\
O8tCLjlfiye3XaQa5hXDrB/\
KjWgnm//wH612Mz41ozM35Krpf09zskruZ1SR45fIXPQSO5/wX7ISfrLubhuMnY1/\
FVZL4J+W/ldlxTQQpnlhiMfLuelnmOv6cGAR5hrgbMwfYG1MDuelnsHH6mNf8449wDskDN\
pP3qbU7803OAC1j7zvC++eH0f1NK5u9GBXjy1MPo0/NFYrev0f4Ua3huMx/0PHo/\
fkbrDch75TWed2MH9sMH+2+sS007Xnujn0kyo7dr+rjvU17lAUvoWornpWnP8/\
oUox1hUbQrMjF2u54n4xd7jnnoO5L7N71DD2oB0qc1hCzbSkayt2NhN5z8DuOYJAv9q2gx\
XnlSo//3NotdFzLRWpCjqb0tmBd1Hfq5H7I18yLzUrv/Cb1cXJNr61ro29S/\
3H96AvffYf+nRh1lXLt0pN/fv7t6rspmQl/nx2CvJlRg3R/qR7+/ZMU+HHpPvz0b8/\
uA5sgx9ALyL4LfpfsURS/uQ+KmdUrOPm+RgH0lb4vcHkxEDucBkbDHFsf+\
BK3ieXM2Mx9vD+V9b27yfcxQ5u0ASLNVpjm0s4Yn/bhRD3tVfyHj/\
vwZcvEnydtshTzszI8ZjyLBXNeK3nxCn60cgGCp+HHcn8phvg1shfzLCOl9FHbT+\
Ad9sBbv43N18ROvMA+0UT/Rz+e3xC6HYI9OcLV/T2K8Vt6i/RUjXPkaZ88wLp+\
WMl5hyfh8+Br9Dd7Cuu8vpNIZ+6JXH9bRr3W/0efCsTxv3RD0+mU0/bopYHmbWtK/\
NqzHamwv5P5SyD4zDuG+t+z/jMkUHWufI+\
jHltfYrfjHeE8NwNLNL90Zh7XIxemBf2Kts9GTbBR96T67kU+umXy+iV03A/\
0Yty49sCchr9nf9ZtJ/46+5fkze7jvda74uu+1On1Bj7sxz1Vq8WMOd0A+\
A1IwPjd20J7KXdCv7UJyv7g1h4sLAVVUmwElMcxysq+ai7zWSFLrJvZ/KvlO/\
JGUnRmf3++Rf23G1SoN2I8R/\
QE72AO9NfqMpv0tn6EHzfCX1BGK94zsy7AjZYRkrvQMt59O8cquH2QEZMO+bXsg/cvC/\
XOEtLfBN/rrcYlx8r+H/k5hf2n8MxN5V1vGeIbtZ7yWVOO+JK/Rs4xdsIOts/L+\
nKXpZ0n8OXVR4m15sT/Gi9b0Z85C3tvEh/Hoc4LvF15FbydD1qZNysf+\
pydgl1Y27KaTLgn2Yhd+od04AXZy7CTum3ifz0lyIK+dQrId1Jt+\
HYmjPQcfIf8fGfETX1Rg/BMQZ3Nm5qS/ER9oX20/9Eaxnqt0WxnHggUZ12l3kUulh9z/\
j41+zFgk8QH0Qr8ooAE6+z290lT0PKWsI57s2/\
WrP7k2W0E7tpfCrwjaxXroUw374NxDnp7orZNU7EpXQKasSg+59sLfdUJZd7TP6J/\
zBv3T5hHv0VcybkaXCrL/hhTXbgFJizWDuJadFj/fqMi+3lzpIJdql/Gb8rx3r/\
qhXui1ArzKurUa+SRnH2o2WM7vT77Av1hUh+fnC6Tfnp7Yu18FWGeSF+Bzu33ME/\
02duzvZ9r3PoDfX8U/1uvjB2mbo+h/fvEPdgpZSzz0wurYl/\
b0MZHrceyEdR6SLr0QyeraqcLszzJBtqf3WsO8z7GIcb0KObVd9T7z43tL7ODRANpZuTv9\
2vwdu+vMRx8bF4ZUwn8L8ynBTnkO/oM9dBxyc66gt+Nq076L0fTnIeuMVqIy+vwphs/\
v3jD+69sgjzwil7WQAloVoliP7/xFby5B/qx6iF3wuUA/yrEem/3Y19ojxE78A+mOehvM+\
B+NRI+yP2a86jVgfqho7FzG6uiH/wzk8eUm9ki94L0HajCPPgm5WhXAwuyUhXn+\
xbvor7kK+/LjLvYisgP9OUDcyLmEn61yil2fsQ070AiSTUuJHsaLT7/vj2E+\
DGqGHatFXMTa2YB2rJqMvKv+Zn0YnRc5P8kkf49Fv3pXor2pIT1zjpZGXmcaMc6V8X+\
tW9dln3kTfXvA+Ybx8Tz3z/2An3XPH3lFrUAvNkv8oG8G5PAP/qGzl/\
ic3TYcOWqH0Z8UtRiPPNKfATlp93WD8VnRmvnpA2idEUzRm16eeLV1Q+J/U6vx94P5eH/\
T44yfZznmec5crPMH5rHe9m3Ie86yzzMzvGBcz0IOb9WHvNp4ix9gbr3FOJXBvlh530rRf\
0viwCvYL9lSnK5GmMjn1yj6d81EHhcAQ1GDIT11hol/VQZSeKfzZ+TbtBrzoyPxMlWjO/\
K7zO/MlsS3tHMlmF9H8B+tsSsZ73L56H9UH/\
oxLDl2PP9m5Cakk1ri4tijfcQTDaOn6MV45BAG2aQKvEc7lnWkfZOYj3YY+\
uT4leaqbRQ7Hl/iHEmw3+ZIPv/1ZZ6EH6S9IVMZ93rYS6MV7dY6YB/UzCjkdeQu9m0X+\
3CzuYDDfRawoIwB3N/Wg/6nKMw8iT2Bvp/Zh/\
6uxv6qpcQZrDhIqw0v4h3WrLX02yiFXkypiT3Lc5HnhqxjPMM+833kAb5vkQY7ki8Guc/\
nnNN4AZihle0Q89K/J+2ewD7Y3DOJ9gWwv7RGnkH+688QT+\
1dlv53MBnHoFE8d2ch5Pf3LHrWtznXcPZrmp8pfjPxKqvMR943kXMmPT6g0fYEyM61GVP4\
fhN6oAoWxk853hy79BJycDU5gHVp5VlZn3vj14Vff8O8yONe9TFNsQfzW9Hen5AhGZV3M7\
4/E6IPDyRet90P+XfCfzCT4h+oXuynrNvV8BvPsG9yGvXm+xp/RG+r8vuGrBuq/\
ib0sMF47NfBTYzPIU+3fc6EJW67Va2+2IOOC8Xesx46L1q796mgry7pjdmmo/\
vZzBqIHSnqh93bVs99jvke0EOr7kjIcBII+\
dxcQDCdGsSJjcwPaH9x9k0qS2Hev6Us7R0h/ukI4v/6OtZNw+8b4128Ev0pLfv8SR/\
Qm0aHeV4T+mltPsC8O4hfq8peRP7T2cc7Gc6iHynPih3sx/o+iriBkX8614zFmDfbH6A/\
nzehz3oSsVPEb41o4n76ZeJwZhU/nvshFv1eRLz6X8df/Hzsh5atFc8duIbnNI/Bns+\
VfUVhzp20j7xHL3EPvUhUFXu9nPXNqaRo73biRE6COejDVOJgxvBevEfsqVMIMkunBO3WU\
l5m3lmQYzmNOB8xlnvw/sVXuJ6Q8+32nPcYU2ohjxtB6GOqG9jTG2JnNgbhn5XYyzya+\
EfsPudq6pTEv28MYXxifPh93llcg7G79sv34j9eZryHtGH9/DFF/\
CLIaNWkd9ij5fi7WkQV5FK8Ivf7zWdepmF/o1VmnTbusQ6p5/gdKgQ/w8n8F3u3/\
g3z5hp+k1WJfA5jwiTmQVxZ5k34C1l/ZvG+\
afhh2hr25eraWOxgjRWMy4xR2KvaSdznaD4j3Hlk91uHPjZKz/OHFKQ9ifE79Zon+\
f0hAWN+eQz5Pmad1nudRl8aVBc5S5xlUgtIqI7th/Ss6XTkMSc1ejuF9UPbNx95Tsf/\
tZNG0b7SrFPmp0SsL9ll37k3I+OQm/NXFbIYPQ8dwfs/3kAvq8s6XXcX/\
WhBPMJ62AQ9rlZW5J+L3w09yH2HORdQp0oihxk7+\
fw2Je2evgu78E2ev7wXvwuSdbRKKsZnCPt+7VRT3teIOIzznX2XMZx4vvMwHv2bnof+\
rQPs15iB32iPk3OE2vgXztP6zIchY3jvqyroTbVbtPMycUFt82js4g30VwX3oH3TicPrI+\
Khry9l33VGSLoPdMW+zopD7z5cFfI64qDm5cX4eY+fcL3fCP1ZK/\
7j3RXM083Ec8wLvZlvfwCTNxNwzmQuyiDnlvgDeiXmv50ecgDV+zH6/\
ACwTe3HYc5bDsWRF9QeUEM1sgv5A3HEyS2PiozbtHbINchmvD4vpP090W9rNvebT2uh3w3\
yiZwG8/6b81iHbwPeofJBVmMcFjkGov/mwCnMw8orGPfM//D+FZXEPxf/\
5qf4O2Ft0JsKxHWsMfhPtjdxTS2v+MtPzjP/GyZknHeexp5FA7pvHmf91Stwnql/\
5PzHOcq+wCjOPt2JTc77WgDqrB8njm5lbEu/7kL2bnlCVqrGSvz8Je3Ty8Ygl+\
7ko5hH2J85jQBXtecC3qzy+YjfVZ3v60Yi1xOQk5gNOLe1Pr2Qc+\
da7Dsep0PPYjrQ76SBEr8knqdXEfnUWsa6sG4i13qRtGcOINj6J/b1es9TyL87dte+\
wnw0r+DHmIM4bzTXYveNF3UYz8TkN1n1lmLnxhLfMT7LudNN7LMTTXxVLeJ8yXndH7nVi0\
KvFhK30+NqI/fKOu28+pB9wLKS6P3Rfry/kTwnEvvtdOP8Vg+ZSj/\
78nsnBjAQtUbOiTJyXqOfBdxQ/1qZcdDjs67nKYCfmWIQepAZ/\
8zYQbxXrciGPfPBnqk2yXnOOvI17N+XeP6ZaeiTon/OCc7FjFOXaO8fad+q9rznx3We+\
5D4tN20Bs8vWJD2LeS8wEnLvlMv6s+4/1MSPbiaDlDrl3fw/y4mc9cPrdw6F/\
RajfvNuqUO8p6QvKwrtZ4yvrOGYi+eMa7GwtISr4Lk0DiVkWuNvLR3WwXe/zUl8zhK/\
OHZ2HPrCPEJ531S7Fw6Gd86EehB3YLcf/s543reC7nvFtLZ22Kvp3E+\
aDwVf8Mrguc3DkXfNzen/\
Z4mdqQicXrnKnEUbTvxBmfkAfSpOP6Mk0riLydK0o6Cd3nP5Toybu9YD8bXYVwL4VfpiVr\
LeTb5KvqWghL/Jf/LOYq/ZXhClmONLcR7H/dk/Ne14Ll5ibcalTby/oi6rEfr2Jfq89g/\
mcPZt6rjnPMY2TYhh5/kU9rjmAfqYXLe02oO19dxzJPUHYgbxnEOqofdQp/uyn64UW70+\
zfxKv0U+2Pjygmek0fWy7HEK/RA/GD91Qbm/XEBi36Yn/5mIS7g/\
JH45sbXxPuqkfdjXziJ/u1bin63vUY7ThP3MwaSb6LVJe6q/y7O+xeTL6W/Zv+pJWe/\
aFQnv0/v+AC5vJ2P3dsq+55eq939kR2Hn6YGnmMfcrcLv1+9AruV7Dn9iOV8Rascin+\
UtTL62YR8UDPtLe5vngh7ctjknHI4oOLab8iSrVCJH1e8w+9tQC7NA0+\
4vwh5Isb9Lfw9IrO0g32o+kQelTkyGeMVfYr+V0+J/qzDnjqtd4l+yrnwqkHI/\
zV5VfprIaM5BEmHfQvwde04eYDadOLUavIB5kn/rBK/kzjIQ/w9u2IF9HfWd+\
zzi65cPTgX0oaQH2KMW8q+rvBk9LddbdaBeJCiq08CrhpEXqMR+IF2Jg2X84IrEicATNm+\
WJ754TsP/bs9ROxjT+xcdomX3WuJvYmZxv0ViAPp/0h+8RiJl/lsp5+\
vsHNO9UGM1xP2w1rIWvrRaCntT1UCORST/MI3JdCPatWwH9/G0s4MgO8rk/\
xYM5o8OvsV8TSz8zT6l6s+7d99RPLCJC76hLxPPfdx5ot/Uvz0DcTfnZ2f0O/\
IssincQB6vLgoz0tGfFg/1ZL37Ackx7gr+el/uBrDBKTMesTnrMQrje4CEtphIO0+uJT+\
7iQ/Vzv6BHva/jXrTNur7FNSowemj+x/s8xDfxMdQk4lZ9KuCUGsA4XX8/\
s3vsRhshxiHWqaifHcw3m1OfoMen+YvEh1+\
inyfsv80OTvRjLiCOo946XNJT5rtMqOPviQL6/iy7nMjDmsF6/\
EvjrEy83A0qwbRV9ib0JboW8hHRineuwnTU/WHedMNZ4zg7x+fU9u1uHifRmPSxrPjSiK/\
EYCJm+XHYKcr3Iu7oyX8U1Kfodesinjk8aPvBtvxssZInGJMPLcrdW+2JfsWbEL33oil+\
Y/ec4j7Jvp/Zj3n+uEXqS5zHzuTxzXyOHB+7VuPCeQ80M7kHxY635f9C7/\
DOT9lHMWPRrybvMveUZ6Kt5vjyYfyLlE/rT+Qvz9a6wPRoYF2Jv4t2l/\
eSEx8Z6NfOe3YhzmJkX+b/KwXmRdg12a4MH4NuH8Tfe8gZ7tI9/\
GiDgpz5f8nXof6d8LSE/MhoChOnYb7O+uJdgDn4aM+6EHsv/Ej9aSUS+hDavPdaU/\
dvMS8VE9Yhd5UVGcR5jtyHOwRk3G7jVPgbx3SLvNoejJwwS0/wvt+\
tcQ8ruuF3hvQfajxoGb6PXEmaxrb9LhL4fKOdVY4ruaFoH825m0Ix3n/7Yf65V+\
mnMNq1oq5tUT8vqM5B95Xq9cyDl9qJw7OoxDri/\
oT452yPPLTfT3EXn6KiIx430C8Ei9JfpkryaeoLQb4jd3Y/5fgUTFeXuC8T2M/\
6mm1yLOq21AnnP4vdGpBvNp1xzaM66D7JeJe9ul8QtU+yjGNclUivJ3Dab47dBHWefqM1+\
DQ+nPvJfMz47k8aoFJej3g1rYtcWcB5gHviC32cnF7+A8SN3Sacc+4lBagSXEVX/Pxe+\
eDvmMU528IMdjO7/bx3m5PhK/yjkzkHYlkvya6sSptLz9+f2+d/x+siF5kAeJY/cN5O+\
NiIMY73pyn3Maec06RDviH8XveU4dhj6ZegprM3Ui1uHTzLvla4gf+Xlgn/XX7KN3E7/\
RapXi/VfuY7cTvnXJ2M0M67lGVnBJ2LWSge5VDUjokrNbv85A1j6mNeTuP8a5V7U3mUv6b\
szX3avet8on9/ssP92/629Tu5/1eTPdq9U2xr1PKzb5i/\
t5dNBXt78XfdyrtjHYvSr923f3ujLpL/f5r3/9du/3O+OS0hvTv8T/7+\
qEl0r839VudscltbebjnJJ7u1haVzSeyOqZ7r/rmp9VPr/ruas+Rl0V/4lMrq/L+\
rF9fAR93vHPOfep+e03d/paRa4zzG7T0jt/u5TRAr384jFSd3nX/\
knkfs7q28C9++jxsdzr/37u+00Vwf8xa50ddtvLP/x0+1vqoHu1To6+Ifb7/xrv7nfr/\
jp9l/3GO3Kx7xyG7lV6o0cE9z4xHyOY7zabHGvhncuxqleB67Nhrjfa7nHMI61H7r+s/\
FK9pN9iMOblU9zrpLEl/X3FmRKekbiOMZZOV/eLeQvJYnra+cK8PdSnM/\
a9WVdKdYNO9ZD8hEasG+0s2Th+R0nYscfRXM+ONsL+3sAu2n4k9ei+g1kXj+\
XfMQPxPO0VuixXeMp9nDKLN5XwYv3jyU/QJ8cxPq+SNGOSemZr+ebMr8y/\
pR1LBd2RdY7rSp1AtY0yIK1D8Rt7Gfko2m9/Jl35XbwnAtXaV/\
11nLOQR2Q2Yc8CDWf82Ktm4H8QvtyXdFF4nWQktpXJX7biLiG8576MC37Bta3ggq/\
35u6NPNlYvz20ruY7wUSMo5nFjG/E+KvWb3XIMcPy9k/\
elJvZyR4Tz1PL6nPWgCpmX0TO6m/YP9vphzD+FQkv1il6Yfcvhfivp/ZkF8W6k+cg+\
RL27d/IY8V5DMayTiXd/yK8NxakGkavYmPOX/\
RN7sEcXG9y1706hz7SlVF8tUyQBZl2bJfXoufZO7fAIjkobSS70z80slXQ+RLPZG+LYT+\
NCff1vkoccgOnJeamTfy3vyyvy8ieVd9hBwnlPop63R7rpnYt6pr1CPZhznHcqoS73QSUF\
+pnYGc3A6mnsuuEM6+M+IIcqiI/6/dlfw+JaDiifAbTe0o4xNMfoQ5fwLt/\
AWIujpA3NO6no35VoHzNlVC9DeE8yKt82707GqIyO0d7emWWuo2P6C3Z8OIo4VSh2YlIo5\
kV2IfYQ1g3TMf1ePzlfvMu4qc01s3INnRluFXGatbMq8+EQdUBvFvfS/xV2MLoL9GCKRb+\
kUh7fIl39ZJ8YK41yvZLzUZKvapMP2LE7DkAD/yE18P5nmFyZPXZ1Bna+amXU4CiW+nIc/\
eySXr6SLqisx3kAc60/FrjPFNsCP1xe4ZBZC/GoC+\
ThNwzQ6zeP6YnbyvMPVI6gP5f1ZkBn6fgnxZ1ZXze+vjMdr7l/isfUzy9U4yb7Tx+\
KvWJcl7XLYAf6+rF/bvM/k7xmvqNlW7gbQjKBv376Luy/\
lOPa7RCPBPqxOkMfrJHoBXtV1F/bHZmLrYxfNl/0k9qRnO/\
Hc8OT8w2tEP8yF5eyotcXTtBiDlmj8kf84J8i5VbAztHV2IcWxK/ZOWrRj3TSB+5uT/\
iL0LEzs8jPpUPX1Nrpv86M/51JJ3Nor3t77JOKYS/\
b4q9eGx5J3bBTkfNb5K3O8J8W7jMueG5nbI9cwh7fBjD1Lnqn0qCdjTzADAE3O15/\
m5pH5l80F+N7QxetiacxRH4sRaJakDi3zOeU0vyDfMD+ipNWm61D/kR95ec5h/\
uclft59nxY7Fcp/q9oa/\
72G9sQZOAfwuEeCv5kfO153XxBm0OPYTKjoaOQwhX1ddZl9rdCDv2y4v+\
eiPOM82JwIKab7Yjt1Ms4T4kQfnOM5BA//Tm7whqx2gx0bUUuzDsbHY+\
47YS3sgZBVa0WvIIy9klOYN6rFN5xH9LUU+h21D/\
qDuCznlReIa1nzWRevjDMZn5DPAZJtsJd/\
kIvrtlKiBfUtziHZ1oY7N0oh7GhLvtgYIOHOixgLif5H6xPC2zINxkNiYWT8L2cUKwHQWB\
AMm9Xqo7LOlrql1M/z1HtQ1Ow84t9IuPOfairxPu2gO+uvBum9qTyU+\
uYP2ZAOcU4VT3242pg5f7UrBc6W+wGySinX01Bj6OQiwdruAwX5uNCQojt8w2p+Z+\
nttcldA1u7MAWQt5wAhE6jGtXVt5J/\
EANQyAfUGTjbJ7wnJzmcf4q7GdvI5jfjEcbWZkOfZmQH7tWd0BFTEvy/r9XnIa+\
079RjHb5AHaykBITeq3EYPI8hHNp/ewW42po7XVG2w91cnsV7UqM78KE/cwoijPti+\
RHxCz/UEO1yN+KVWczh1/zk2Id+m1K+\
oPSVp3znA8Z2qgwFn8YLc1byEX6olYv3WAoQM9C3ntnY466VztaL4meL/rezCPB+\
JXdbi9eL7z5wfOBGQKWktstC+\
qdhflWEM49emDmBCHpCfW4kyADJ1OKGAij4AjKqPkAyHbeT3qjd6nv8betroF+\
NfaBh2fyJ1stoq8oLsVJyLW/3JS9VeEo91FgrYZbzmgNZoGwA/\
PH4Ke7lC7NmVKpLPlYvnNimNfY6RuvUa7cB/qFQGOQ/pI/\
GCYYznoJ7YyYoVmcfLhVylGKRyTjf8TuMt+AlmSQ/kVa4O8emukNobdWXdCCB+YBUAl8K+\
zLzU3g7ADk6SfNEpGdHjO9hzeyykvuow+WPapTrsI+KPwF/\
dR16Q0ZH6EnttVvRgIf2334I3YFx/I3Xa7DfMIpA0q+VVqKsIX8c8WC/\
xqYTp6d9t9NlcyrmEU1H8xTPsH9QW8iaMld6sw0XBuVDN2Y+ZjRITF2i7nftu1cSvDS/\
AfffDafdY6gfMAlKXVYY6PzPzHz7PXMx9QZxHqe7kuxhNO/Kcz5yXOpnY/zl5W+DnLCX/\
QGV8jJ90rzlyPENdiTlQcCDaAhptzp/ButxK6huCJb75WOJwnnI+\
No96a1WR8bIU9QXWSdZlK+\
VS9CEG0lnrAnmoziP0x3xamc9TiEdbSSOJo5mcg1gJqXuy15Pfrup0xH41v868ygFYu/\
W8BnbnKv3Q2kJKrs05hX1/Iuf3Z8gb0IsJLkTZfNwXcY/n9wFfxnrShc9vyDeyw0/\
xfXLqb1Xu2+j1JPxZexrnudoE/B2rTELJN/OWebaa3x31Fr8G/8YJBhfE3oB/\
r4WSn6r3zM3zB0o+f0r8Cfs95yFOXAfk9vZ/JEf7mW/LRF5T2H+\
rmoyTyvgOebfHPqoVxM+t1fhd+prqtPMhdbFq9gGJq/cW/0fOU7azzmnrKgN+\
nAtSKW2Uhd1rW4t5lgs7axdbw7xZ/Yq8aV/IZoxGoejD3wbsfy+Px/\
6tWYWd2AkOgpaNc30jv0m/9HL4KY2YJ7p9lPdo4CpoJ7E/dth78IQsi+deZX20zsn+\
eK2Nf7HlBe16TtzB2AG5lnZBcA9mUSdiLGZdV1kh9dX7sR5oH9sgp0xczcxJuH+J5Eu+\
Il/KfMf+0+4OCafRQOKoFucpzkr8S30T50TmI/\
x2FYZfZ2ciT1HzviX575BZqHHkQ5u9wUlxslL3rV1PKXkcgnPj1x457uVczdnZCnnE4xze\
8fmAnrQhD8ncGCx5C6ybVpo22K/OfdnvHGR/qX6Tv6CygUOgLViDPc2Jf69Vwy9X+/\
FD1Tup6y25Cjs0YCN2Kdljrt+ol7f+Sh6aH/nHelPyi5zowsipLvPaWq1xf6I3/\
D0c3BPtzCfkfQJcHn1epMQbrjF+nwG3de6zLhl5sOe6P36Tdhl8A2M75/\
FOD85XjHF38NPvYme13eRx6kGMp0qB3XOuSX10XvCnrHrn+\
X7Qbtpfp6zENySPcBznw1rBCOz1deq7rAtdkf8Wzm2d0tRN63/\
fgT9zEtJsO7PsK6LEDsyJFbL7FYxHKHlr5u3utLMX9QGWPpH3fd4q44Hfa9TjPM2c8pB1r\
jl5uypxEPp2uRv3pQNXx6z4jn429sFfuDWd93xHjloWzjf0GWWwk4+\
zo5cfqZ92Tm5kvLYISfO5W/hFT9Zhl/ZKHW+Wpuj3hjv8fin1CuZe9NPYeZz1NWY8/\
YkmL9JqQL6A1rOY+DeQ+Dj1iFOYXswXs8Uw7o/\
aRv8Wb2VdmpkYvb1LXMDaTZ6D1moe43IDskIzKfmG1mzJWxnN+Y3WBXunbyW/094m+\
RF7VpFH2Ie6Trttc+Rm/INcy7BPsOdDsmiOxA82KxKn1P3bov+/mkv8lf2gHYp+\
GdH4t3b/E1L/AT6Cce4P+h1aCXmvfci+WhNSnlOQWui5OO/SrnPOb/1YQL9+\
50de5RvS3zN/ec8zyQO6eI7vM/xGPh8Fr2CUjh2J24k9n0SektVS4o+\
9OLdV54h7qVXsr6xNY/BPEpQRvSiH37q4EHJT4CkY74mLWA8kfyTpX/p9UPKu/\
4CnYhYJ5P29sM92+oT4bS9Yx9Vs8mItxf7J1Doxvi2JY1hfZD8xHLw5e0Ym9LQiem8PJ9/\
W+Mn5u9aeOjVnH/Pf9uL8W3U+S/\
wzYxjvT0TdsXMLHCVjOfV9TtNFcv5KPqVxIQfj3o26eCcJefj6t3bUGUdRn689TyT5vdsY\
vyPL0I9Skm+SkTpp6wj7EbWbdcyZMpp5H4+\
4kHMX3AZjyyfk0Hcj41SNOj6zGHkzVivqy8xD7GPsi9T7mjp5BuZ1zpOtBcSjzchVEncCN\
8FMybmekws8AKvGLMatTF7m84Qwzs8CiYdbGX15Xt9X/\
P5TdcbvHnk9Rh6pT0j4BXmliEAusUcZj5fkJdpJ8Nf1wBy8t/\
op7gvj3NhpQL2BlYi8fH3fefZz/9Fd/Hf9Dk6Qk60R471zPePZezW/Synnihk4rzR/\
HkFOG/CLtO/k9arfsl9/10zWZ+y0ZiJnzWs4ckvB/\
tCaIDgr6fvR33fg2qj7gqvjRz2PFZ9zZSMd/qwx9Tv9SyP1V+kuYT/\
9pI7uHPNdG3ue5y4pSDw7cWbGYTbrln6Kug2rOP6sXa+jnP9PQL9/\
apzj3srLOWimgbwvqCz++BxP8m+PTSbuXmEqed/lz3L/02Wcj50Ad88Yw/\
rv1JJ8z0TYB6MT+xlzguDC7MvBPNDaMC/\
MSRInlfkXfwbzoj154NrI8cxfi7i0Eeyg95WH0L69aWlP+/\
XoWcXBrMOh1E3psexn1Anim8ZoqdsuKf6YmZbPjyvKOcMVvv9JPpeZk/i5/\
lDs02rJx98XJnH2gu77NU/sux7A+YRT6hvt/cp6rOcAZ9OM/\
5M8oP13qWfKl59z7h7I0yo9mOctL0/\
dU0wE3zfPiB6MmS72mrwCY2ZZnveUehQzJzgm1nHyodV84vK6/2zuKzxB5MZ+\
07hanr//PcTzzi/m89BU6EM39mdmtOCHniJ/REtP/\
Y7hCZ6F9vcY3w8OkXFILfnANu9VcXLetsI9b9XXhnC+nmo/53GJOc/SFkid1IQ9tO+\
X4Ipcpd7Jzk2821r/hHUlnLiUegY+lnGYOnhnyiraPzIAuVv40VY+yRO6Qt2jszA/\
7WxOvpM9hPNcR/bL9iZwm9SJo9gLX+ahFX8Pz/\
GnTtysCM6nlpP5biU20GdPcJCcyk34viR4C05hcGL00eitEUf9oTG6B/\
57O3An7FPnJS8P+Tr3DZEv+ZK2wr+\
27pIHZPkQPzY71UNeW6gvsN9ukfUT3BztB3FdsxX5JeYQ4sVOP8HnKUpekBoJTpQ2jLoq/\
TjzQVtDv7XTdelXGPEWOxl4E3Y28HCsZZ3R1/3gCOm/\
JG83iLweW9uLXiQf5eZvWwnrohfXB3Beu3U09q0OeXXK2sA515UE3NfqFPoTQ766lop8cu\
NkHfJcRpHnokKbcv/T/OSJJ4nj/fVy8/zWW7GHFyPcv+\
u7lrlXLfVt7F6FibznBHi2TkvqdOym4diBuamxh9v+ME8f7JB65wDqtbYuek9/\
8rh5H86wIm4egjMwjDyRBnfcz1pyL/eqbnq7V3PNS/dqX7jzEX3+\
QJ5D7FrySTzyuXkQmpbIzYuwlgeSJ3G2uZsfYnVd6X62s49w/26ca8XnOoXcvzt/\
xrlXbf8vfv+8P/kql4q57zFqfOYauPgT8pXve34jv6JxBveqL5pH/+\
qUdK9WXCrXvjkJHzOOpT1deToTntDfl53Jw1g9kPv6jyJ/eY2/e7WSPaEuzCfS/\
Z19bTvPz7uB55iZGc+Zi6gHjd/W/d4I7sW19hf+figv8g8sj119sIj17FQS8p+\
Wv5I6E8nrjUc+hJ5gJP7wPPC4NG/\
wdu3U4PjZr8FjUymoK1aVqSdx5oIPaI5oi92OpD7ZduZx/T+\
azjLgiptpw0GLu1sXd3eKBKe4uwSnuLssTnF3CVBci5ciwd3dF3d3/773XNM/\
LHuec3Yjk8lk5p57no5C7jKS/2EeES/2LoN/\
c7dLIGdF4IPTSfthR355wPdHkW8T7IcPzeRGD5lJ2EVuAHgs13AG63rT3zyn+\
VDaUw3cuIokeOYf4PhMbYn/q6PYJ884N6g78HKadfj/\
3OY0jL9KyzrpEY3xDEtcx1ZMAP6tSWnanQU8sBeN9ukWi3leEfrhh8vIeD/\
PwD7elvXot2RduVgLWF9jb7CPdDhEP9bXoF+ltjHe64V3JPdo8bfCk+\
P3LMX7vUH0tzv991PfQO9Mj4Y+OEoesto0k/GfAg+C+sb+\
o2YJn1OO0XLuAZdj8qRmnLeSl+GlAPenG/xkPk+8R64qRUVvVACH6beai3443Q75fdyX/\
b7EPORyLbxN3gXJm+km8YV4jGPwiXORiul4z94qPO+\
p5KWeJQ9DPQDXGMztxv6VFLyfXo5fJ5i/FHm8Cx+d/zt5HqotPDTu907sr1+\
v4684Jv7ejT3Z//uInMUB52x6pEePPluIHuwAbsWe6MN6Kiv7aGv2Hf1FeKKy4GcOsn1FT\
vqA01TPwRX6G3MwXwc95C3CYPRKG/YRswQ7y2v+lee1yI2c3SbfzxzzGectZdg/7oJ/\
tlvBpavi4Ort1mKiB+DzsLHr8N64J5HLWYy7tyw2fo/jNzg/bQcnr+fgD9KrwH0E/\
3Du9SrgR7QJiOvb+\
sIrvFrydtJm5rmxJD8hIrxA6nZzsYMpRh50P4ncXd6DHZpnPeP6byX0QwfwzMF7xjX4jh3\
hp8Se8orEZP08Au9lYmPn2bHkEwfP3rMf7snGetjCecDrAX9mkG89+\
LjY6EdbQPKmFHk0Xlni4P4e+CxMS/Ajtusb5PTCN65G8sNPE882ucgf9aYdZd+N+IN5/\
w2+RLX9vOBrb6Jfsk1hnV4g31pNph/mKXkNwaqC4LZT/GTewldAf5zMSPsbd37Oui/\
JfjXydehexS8NvnPBIPbf4rnBY355+xo5mgTOM+UdvtcufKi9/gb48XRZ9J6OiJ3l3/\
zEuO+3jGeRw+xz4YaFfu+OZGW/SvaFdqaDv8hkuEI/\
vvVhfdYZw3iPmor89hiCvsjfivl6RJ6cng1O3TUchj4vg9/Ui0P+l5+FuJld9gb/\
y07sYXNAcAX/lmf9rIQv2KWfx+cNljHeY+T8kiAq730p+c7fyGvwujZkfH80RK9WPMv+\
3aEI+3CrW6zrw/BM+SfwD7gjknddDX3mX8cfaQOJb7X5jNxEQn5dG3COOt4Q7P6cJ/\
BDZRN+xAHC33tdzm+rODf5tZbw/VfEQVRS/Jj6Erzw3iX8BsH+F+LPh79X1ya+542rgVz/\
wO+gznB+tZGw671ikt+X7Ab+zNVSh0Hwz2on+TI2IThj3Rh71b+PHz6oBT+\
hTQLOx0WFl0W9Hoh8nMO+\
sOHusl6Pku9lasZiv8x1Fz0wCJ4VJTikoFdH2rs4mvAqkQdkl/\
4r5wvyAfy3yQSH2o35HhuWdX/zOXZw63vMzyz8M94jybPbMYNrV9a1t60N6zUr+\
MvgSUTW4+m47A8VNPbD6vCsv6NVWRcDsJuD7dgdOgN5hTo+uC71BX4erxN+KP0a/\
iyvDP5lmx5etSA8vBFeW3gUfR88jXq3WPwi5MnoxZvEz+\
SJfx9crtuYgXHYupLPP79DPscNQw53su+riXsZ77xXkcdTrF+VAL+\
hu3hT9DDnpaADPIp2VGnGO+5s1vuxEczzmiSsi6PwxQTNyPfWESUvp/Y1xjWlyMXX/\
rTjKPrfNidvLIhamXm71hO7qnIH2tW1L7+/a+inI5/H5RhBO8KTN+API6/dfsWvrCcnpp/\
P4FNy4+EZ1oXIK/KGtUPeDpJHrE+Ch1PRt3OuTB2JcW4pfDnLBef/11Dkoe5y/\
CAHeiFnm78ip2/Io3Xb0QMqD/ElP15B7IAl4KdVT/RBsARcZzCOeL69j/9U7Yf/\
RVWCr1ptEZ7YJ/iDvNvr6cdO4lxBePIb/+NDCSIj32aXJ3IPP5j75TzP/QU8hMlOPMJ+\
IF6oe+E3NI3wD7gLVnAFW5Dv6VVpZ0Vwf1421rduJnbQGvAHNj58ul4PeAP8L/\
if3LyOtPf0Sr7fRHickmxlfk8gt/5G4RWYjl/\
GOyA8cjtZ57Z7MuyjHhNZp2fErj9YBnkK24H5mAOfhLcN/4+NwTr1prPuTSrqBuh/\
4Hn2ZN7tE4kzTCN/yrT5wv6Spy16cP1a5K+I8LrdxA/jTcGODSrWoz0xjkl+\
iNRDWAWvu82RlPWa4Xf6nRs/um4h8chR/fm8B+cRexk+\
BlvwA79rR36Lzkserj8Ze8s9xC8efIW3Xc0ZR/sr4Peyv16nnxfgGQlKkEdmFhHPcfs49+\
mz8Map0vCsBMMZH3sHfijdQ/jkR+OPND+EFzM2+a6q2QR+vxC/t140Uc4Pwl+\
RkHOqKT6K56eANyx4St6eyd2OddSB9ezuHBPcl8QhFsCP4JfBD28zgH9xk+CD8OsLz9Zw+\
qkrEdeyUZ6gH3dJ/HFaG/Ts02TEyX6C7w8+wSvlO+EB7/Sedl4BF+4dh9ff/\
2sK7XjAvhJs60+84m/hmy5A/QA79SjP+29/z7KO343D/6ejwV8SXAR/G0zlHGT+\
ms36uFYZfbpN8unjw1fs52Lf9KrjBzV/98V/\
1CAfdnNeizxUlvj0yITE6R734HyUEXyot4D8Q3/\
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\
PQPmoKbidfOMtL7LidW9hXS8xB/\
vLzPFPkMfOaAr6NYHJy9sPT4LNtY8GxxczNuNWtzDoY1pX+d5vK/DwnTu2FhT/\
QVSCP2PySArttahvwv8fKkz+1ZSL74ddynKeXLgndq3hbucZlPHVKqXPVS+\
rzXMBu8zsVZlx8+\
LjUMalLeAIctVoCL7orj96xhZPRr8Y70JcZpe5JDOrf2jFSx21bJtbfAeHTWJAPf+a+\
KuAjdkveVD5wMfYg/I5qbAKet43zv/fZR6/\
1KMj6tHPJ725FfkrQUXAOa8kH8fQ81knahsjbcs5FqqPUBZ0Jvj7oPZ/\
1Muwi6yd7LdbbMKnDWBP7LsgJ7tq+XoLd9yt4cr8y9ql/\
tiT28Ut4rM028itVB8bTv0adUmeK8vw/wZN4F6kDaubj77Q/\
OMfrPwSvvZv4YBBH8qmaSb5EDMlLSS35L6mQH90AvkK9GvtT//aW/nciL95lgX/\
XdY3NvP2kbkTQl/qnQcMTvD8MeSJBSvjXdR7qANiD8DOoTNW5fsuNXD9tjH7bB/+\
ZrSy8IFWo+\
2yq4Zey0eGdCRZRd83PFxO564o96GqKntjXH7nM2Ah5WZNb4nlir0SEv850gFfO3oC324s\
Fr44eDS5YfZH6Fu3uEW88eEXwlCuY/zvUZfamsI+Zk/\
hhghhn0JvfwG3onnk5dzyQulnp4Zn2x85lvgeCT3ebdnBuuih+\
tYnk63qxkvH94cyfmdhU7JPh6Kt14LfM35wPgqHb6V+d6Jyz8uDHsSNlf74E/0Dg4H+\
wayxysUp4WF+\
ST2DXYG8FXahPrg7Bp2LiiL3Yironusx87Khi5HX5bfEHey3nSxyZukjBevL39CTy54MHw\
k/aS3DVQyZx3UUcRmWg/pr7IDj7reTleZGwi21O8knVxHGM+0/\
OGcG8m8jBd3gLveHwStt/JA+\
sHH4Ce4O6bt4p7GBX1QPHMRqchjnKPmxuS72C1MJjeZu4l60HD2CwJK7kF+\
EntS8lHtcZf5BOLbxZs/GbqJPgLdUW8IjeVomfpSFPwP7LuPqTiffqOtRZCsqUE7/\
hbv7ugUMIlm4Ru1T440qk5Hw1jji9Xo9d5T3Gz+C3o+\
6tOU98MtgueYqPIvH5WuE9fkK8w3+F/AV1qSflahO/\
VyfY11104f84SrzAWw8PgtdO5PY6dTq8xf15XwP4+uwxia/OJ36rytYW/\
04c5nGa1JPJijy65ZsF95gFP1Fx6hrabk3EL0scyz0mr8N/\
zPq3CzIwXvXIo3TDqCvsvxQ+1vuvBBeDnAW3tjLPa4hHqJyZBD+QTPzp4p9qCh+\
72dmDv5sMyM+PZ+xPqjFykA09pQtdY78+LfWlVlIf2qwkD8mLKnztm4vxvIP3eM9yyU+\
KtpVxLSu4qd2/8Z5CYcAlnYEP3EsrfI8Kfih/MHUi/\
ZIHxM7rLDwZ1FO3aciXCtaD69JFyY/UkW9JPAd9Z29Qd8Ys+8L7qpEv4+\
14gtxnLCN4HerbePfhedQxqI8VBOIfbYL/zEREDnXPRfS/Avymandj/ALzs9C/hZXoT/\
dr2G+fu2Bvdy3HOe/VWs5fi2Zgz+4lP8ePK/\
WADDwrthR8Sd4OeOPMyvHIZbHj6PtOnKuCfuAtvDGsb/8ndZC16oNcNRRcXzHqvwRHhO+\
n7Cj07sJp7HuvejDuwhtrqxOnCGYQZ/I/XeDvPThH+\
euEl32d5HuElTysLE84L1y9yrzNOMN+l3YKcvQUf4c/+\
izvz1qWfiSVOP45eNLsze7I2x3491RY8oZd8yzcZ6TunakLz4mpIzy9fcWPvyAp8l4B3N1\
/daTMEYkD/CwnuNUu4F2m1wanfmII41isIe1qTnxJf3zB/NcqyPVwFeR9a1uJK1L/\
Q72DF1Z9XkE/4mAHeP2kbmtZ6qwGV86w/\
sdqwf2gN3RDeGRcz5v091fqZPl5V4PfqzkFvGTaIeAVV0bnOdMfSTzyC3J+rwi4rm/\
CSx6Z+ire3NToCW8Pz8s0Grzlmn/hXby0gOfnbwH+M80m5MkTPv04FyVeJzyw+\
eDJU33BKasCxG/tvM3okQ7U+/Hew5PhfwdXYDdTV1WV+8Y6HE77PXWZ9ZsZ/\
JI3nrwg0ygO4/NN6vScY7/WJRX9XZGf/kzbSDy7uZJ9hbi4XwlcRJBF+\
MrKci6wq8Ej6kXw2qhH4Nj13v08N8pB2pOT/cnbC0+hiXlNcOFbwX+urc58ROiI/\
oiNvWyjkb9vywhfeF3yXTwl+Ky4+O1dPPKJzB78YnpCCq7r4NFz9aUe30vq1djrTZGj/\
uwvbo7U2e5OXELnyyE4+iXo+bzxkfNj1NO26SQufAL8uKvIfPmvI3J/\
grx0e5n903j3wf2cBZ+vt1LX0xaIKzg35sGPCc5CHxTe26uCi253QfjwA8Y1yXnh415N/\
HMCPNbeNeoAm4jga4Nd4M/MUHDs3jd49vwRwmOf1Oe8k4w6gN5C8KbmFbzb+\
g087l4HeIe9geTZBZ3Gsb53gwf1KoKDsUWoT+gVF767JsIn/\
5J4b5CXvDK3iXOSt5i8AJurKfL8iLpK+\
u485mnl78xTZdn3XQvGyYDDdUtaMz5lWjGPyagPrFv+hn6ZJ3HzNdTtVfG+kZ+\
VIgY4zc7kper7+GnV5UmM40x4NtW4p/R3NXmeavUriW9MAN83vSHyUA1+\
5v83iEUfcW9LgkvVO6gX7sUhP8ZsFNxa+Ya095TlvfNH8/nCKcjFUvJIvDXEs/RdcFeuv+\
AJP3ehX52KIQ9RIiCn2c9hV/Rm/1JO6uL8eQK9WFNwZQn+\
FXzlPXBzteIgT7PgHdQ3NOO3W4sflnwDMyAO8tQd3JFrSp6Pui14/\
mzE4ewKeBJcEeqIBemFt3UqdrrKuYf+ZITn0TtNfoWuQV0/\
l5O6djrXEu7bnBB7BTvJPgzHPn2PPAr/wAzWa7tq2C+7jjM+\
xY6y3pacob3mLf08T16dLoXdqo+\
JPbiBvJbgSH7GMV9z3h9I3qwPP6T6TXBZSVoIjoP92EsJXt6tFd6RjaxjlfcS7Zsdk3wxc\
4B9Zl588sXebg/hiP1ICUP5aF6LT+wno2YiF/\
uu045x35HLCJ2YhzTfZTx2Y1ekYf9yzxKhX6uKHT40P+09hdy73ItYRxvHIj9LJW/\
w0gvhEU7LOI6YynraD95MHf2b8Z65hXH8txa/X3+c8dwei9/NBLdrI16lndXx6/\
gDajGudcGJmsvw7+uZ5NebNuDMTC3h+\
x7DujKr2B9UmOzoweHpeV9f5N8s5FzkGsNjHmyNRPvqlWB/\
udKN67natGtbacanSDbyH772ZN5npWNdNiFfRG8i38Jb0QB7+\
D75fLrdMfr9siLtmYx97NUATxhkkvO1T908tw1+fJ2KfFizmXwKtx+\
9HvwWAbuqGfZ2MPoh9omSfPKz4E2CMMRfbeketHdqe+azj/\
AhD5U8tWsfxX91nvEf9Ij3XyE+qkttpH2FLXL7gjyJ4AY4GX80+dn2D/LiVNh+\
yGF31pfNWR15/kmet+3yE7tnaDbk5+tV4WfPw/i9+Bt5e4E+1n/ukXPPUub3+jPko/\
JtPi8Pz7o/lbryKlJ51knTwqGrPvSV9TGfcTTFGXevB3zsqndC9MP4l/x9NH/3jwk+tAB+\
kSBxEzkvkj+mWzj0f5c7yNv2zsjH1VaSpw6uy39xXPxP6fh9OupvBV04Z9jm5HXak8Jf/\
Rp9qtbBq2GWs6/7Lgff24J+cFVXMj650AvqJetSbUzBeGYgz12VAm/\
vlg0WnHRj2lVN6hz9gR72osCbbd/\
8IngywTmMIL9MT6aei91HPpW6XYnx6vknvOJnLrFumjRG/\
jew3oJ1I1lHybsxrgvAm6mbf6IfpuWk/\
b2rkBd89zN5tplYT24vflD9r9RNXVqIdVTiJOM44T5yfXcE62zWI/\
Jxpvdk3is35Pn5NrB/9QN3Z1KBN1Lp0fv+WOxbc/cweiIJ+RzeHxuEd2Ek999b8/\
dsnAN06X3I7ZxDtDeF5DVeg8fZiyW48yyCa8nDudpklroBy7Cf/\
JtSP9XeYx0epL53kE3WXWf0uupHXpGLgfyrvcixzkydSJdC8OwPB9K+tAvpX4FN9G+\
HZXyawFPgt03A/HcCl6ty4ecMEsVGv7anPrv9S/wfrYqLn+sT43inOnI4ivxV80b06+\
9bkO9hhxiPiTl4zmvqfmgbH3l9U4X9rNlB7uMfQX4moF9dF/KYg1LUYzT1WK+\
qYlPW35eIkn/N82x28k9VVexR1Yi4qC5Nnp4/ELyELiz4zOuNaOdv59EbBd+Q7zZ/\
POt5xGzWXR3y7IJR1RjPW1EZhyHgEYKoT5CvZ99D8uteZec5sx+R/\
5ZlaCivzn7dT357izLkeWf4zPifxf/op42AvGzC7+PdbMz9R/wuJiM85aYD5xxd6hzt+\
T0P41QlK+NS9gHrbpfkH3UVu+K05J285xzndpVHfqPDv+FySn1nka+\
gOPWNbLHRrNdYwxiPul9l/d/i7z++8ZwWE3lPl77Yz+/OwoMR/jvzkwB/nE3zO+\
3qkI7fWcm7KEf9Xr93JuTlCfh4PxN1QO0J+AuDqPjJVHb0S3AdPez2vcBeCI/\
fy86ROiy7l4v/HntLDSzMe3MVJ897fm/\
k8GwM7KLq4LZNpNrIZeePtPf3EuKXm4C8VyKf0h2AFyCY8IzxOfpAcIy7aNdh8jBcrMv8P\
sIw1lMD4gvBaeK19gN8V/\
5P2qvj47fxov8pfuEvtCeZwf7rVR45jd5VeGtmIDcFySP032JP6RTkhds7GRmHVcJjV/\
8D43Oa/Hx/BHaXc+zD/jslebD479zySYz3cs6r/tpLyOd4zmEqDHaVS/uM9v5OPq5/Dr+\
pTpyQcfThfwnOnxJ7p7LgJnuLvSz4/43NkJfSwhczlToVKuZQ5DH7LO63ZUb/592F/\
BVnHvXTRIzP+JOixzkHB/3xH+iU1KPwI4JLd/WSo18yc2410/\
BTmiTw3OhP2bjG7cc5uBN1V7zm8NraUezz5jw8OC7G3+\
wD3a7Q3gH4wbwt3eDFGeOF5tH2T8R+lbw1+nn0S+RobDrk84/m9Gdzdj7/\
XfShHc38JDzH89bnQg7ftJV9QPiZPuKfMp1fC45KePwzUAfOW5SF5y6Sfa9vE+\
bleXbBQ24Xuc/E/rtmF/IWDhybnyyh2JfTGN+\
Hi5H7o6JH8jfnuQXZX4MXi9iPHjSiPkmzoszf7zuxO3oKH8457D/\
znHWkWnWinSuxh3SRYoxDVqmTGU/q3WyB78Jb25Bx75MJ/bMuF/\
LQBD4Ek2I4z3lzGXnvRJ6dN6g79mNhxfeW4Pf1Ik1EP7SJRDvWDGdeIjVingoMYR7G8jvX\
YyX7xArqJwexiP8F1fGD+EPJ41G1sHf9L89YPzPZ902GC/L3p/xuDvJhEjXAzn64g/\
VXdQF2ScJKtOsU/hA/\
DfWIbQzif3qU1IVd1pP9L81BxrsbeHTbJ6ycF4RvJNst5FL3Ztwav0HfHSrE+J4Gb+\
atgB/HrZjGehhJnVw3Cz+QPx1968YWZz9cMYHn7u2PnmzA/qZ7UR9aB/Bb+s1+\
p511kGPVU+p7nSd+pD8IP1dVzmHm13Zc5/\
xkvHpIXkyRkui53OSH2mVSn6kCfgK3QPh2PuL/cTM+\
MI4x8KP6o6QOcQb82jau1DVX5FfYG/j9VE3myeuTj/\
6mQi5Uu9bosUjwQuil1BW3UeIyPqmpL/1fHrLfUHjIBoGXVZEqoifiHMGefVaX50eui/\
0wfSX6JzI8l35xyXOLJLzPdcCzmPq/\
Mi4pO9LOXa8kTwQ72atwkucXu8j9dPKEbQvimMFJ/F5+9FXI/R72I/cee9/\
9WMe4JV3BfhqXc4pfUer3Fb8u+AzOoV4q9IfT5N3qD/vRZ9FiYh8Vvoa+fIAfy70i383m/\
Y7/9IHUhWhVSOSNfH77nz+oTHP26Rb4NWwzzl1BTs7jwdZszMtD9k3/fjb0zaVE/\
C4J52H3/g3yVh8/hd3A/ho0JY/ZG0N+kDss/qdZMs8py9Ke7gVYH6du0+8/\
yzMOCv0W3OBc5V0BB+o5qQdcnvOJm4s/3MxgPtXizrTfyfm/\
KecJ1Z54v1MXea7eznroVFH8Sm+Yj2XUSzPlwKEGTcW+\
TAvu2R7k3KK7D2M9fmrxHy6VayrwSV5X7Hzdh3wzl4/8Jq/+\
NPblg5zDTOZoyFOMwsJLAa+F6Yr9piZWEf/OObGT2tLuYvAsBMvhjfEj4QfVa9Fz/\
jbwMqpYe7HH8Pfr1OTd6g3gGoM5wgealvwwPWY+\
55zPD5jvsTfFvmdd6aNr5LyxQfAeOWnHLKkLmT45595VWbgujMr3nuKnDKpSl9krtJv2zi\
vB+kiKXenVIX6ow0i90yvEX0zeAnL+BofuDiMvrhH5BrosdRfdbYm/RyR/R+\
cBP23OjuL5Odvz/BwWeS3H+\
vHrvEGf9WZdmUvgz11ccP6ukOSVVSKfOCiG3yVoi52u6lXkPgX8I7pzMt57sjf9fgguwcv\
yg9+/k/ynJkWZ/1wz0BulqtPOesJTeUR49/pNoz+DOYf44qdzT4X/\
5yh2RVCnDPtg8abo1yrkTbuD8PSYh9Q3dYt4nlsjdf7a/Mb3d8OvpHKRJ+\
c64bez37bw90jgytQn5DGogf9S3SjM54teYA80hUdJDxF/\
WKk87DMvpB72AvLzXX7k0t7C3vIfHWDej8SVcw960GQAjxDcgw/ItMaeUs3hIfGicW/\
acw4L9vWQOGNs4VUivuqFJ59epZe8zGSSZ1xW6jN2dfRrwA36E4F6jOoqdRDcsQnIT+\
bJtHPde/bRzoJzaQu/ZZAKfaGvwufh5frMvBQ6Sb8bXkXuYjrs2gnDhI9zDJ/\
3HcB1jeAXpsBDFwy9Sz9f4mdSR+QcPicO81AoHZ+\
PX8vv4vTj83X8Lui1jH2sKX5rf9puxsnVQB91T8B1z0zkMiZ2pTt0AHs0vfgVM82hf0WpH\
6uaw9NjG0reZasE6IN762nH7RScd3efYX2F+wHvR44U8MidRL/Y0fCiBFXzYq/\
OfMi8hZE8vlHkYwYXBV/+ROzHn+R3BgcbynnqMfqqPnhZPesxv8/1hOt5eID9NPiv/\
JV9kaeycVnvV6hjqtrW4O9xxB/YYyn21izyO/0oxLXtA4lX3ziOPX2U+sFux1T+/\
kbOF1nwZwbDOPd57gp6pnB52r3/jsRTBD+XBX58034q+vk2ebA2j/DlNiFOZfODX1LxyT/\
TpbaI3mrG8xvhZ/BG5KB9wy+hZzYbrj/knLJP+CiuHmSdFITH2p9O3dAgEfrZ/\
UM8SHXCr+XvYR838aOwTyYkjqr7V8J/1P4m54BM+eQqdvOKa1w7n2Od9mTd+\
WuokxsoeHfsY3Cc3l30rE5FvpKqJXyeCyQv+xK8YTY8/hfv5GrGoXk57L5/\
RD7bPUUfjmrD/G7dT/9bEp+xuQ5JvALeHVVwI+1ZQF6OPxT/vmo9SuI7tZm34+\
QP6XxRma/Fki+TdjR4vDfgFPSImWKHhIUHMRfxlKBWL8a/InE+F1XqMFUBD2kHkj/vP0/\
DuNaKznp6hL/TNhI+tuF50PPTqXtqzoxgHb5g3QdzO/K75n9wX7Uo/\
duLP8vuOMU10ibkuGF03lsfe961Ev7S0uxT2sPOVnPJS7Cf0/O94uhLVU5waB/\
hXVY7qTPkt4fn076D/0UtQJ95s/sgF6UV+mHiFc7vj5FbN7kb36vTgX5o6r+\
6jUPFz7OaeV3CeNlG+P1MhU6c00bEhsfr9TDkNLvgAjuBqzIp8afaqZyX1OPkfK/\
MeIlTgf/TncmvcpvhZ/Xu7eOc8QJ+YbM/qeBy4dNQ0YXP5wE8PX7627RvRHLGfyHxb+\
8X1qUdkwq9OxGeUH+Kj7wMOc04bJ7M/Bl4W1wy/\
JaqBXXj9UzOuToadquxBeifjsbzb2En6i1h+V2PZoxn6oWMb2ri4kEc/\
HoqCfEiP2G9l8xHePaTjgnxC2TIyvh2wo+pVoA3MNWJY9n3pfl9VHhU/QmSZ1hD+\
JKGgTvwWmNvqYjw6HjPiKP5X64QB3kG73VwQfj+hk9DT6bHb2fGsb70b/Amq/dSxzg+\
OGzVHX+CXzQcdlevI+yb2Texvk1t5HXvA65FsbfUyCPo0QEZ6X+3puyPMRhvLz31q72+\
FXhO6izsoxsmcr5f3p3vRY/EuDcmTm7vgpf3quajnVXmIm+HPjCuOYlv230xmceinI/\
dhp28Zxk82CapxEXDzqA/7eH/VF2+sN6KCS5oenj0dYvDjG8N8P3BwV348QqS9xFkJm/\
Fu02dTTM4o9Q/IB5r8hP3877mZ708uIXcdMwjcXHxW9WgXr3fh3r2Kgz47SAz+\
Gb7kXO0aYbf9//3efRKDcEVZuMc4ycCh2Wiw+Oj68If4faQ96UOUl/\
U87ALXBj4uf302GXq1y+0Yz78B7Y8+2KQ6AJysJS4rJuUmX0xh+\
RZPITvUS3Bz2kawPOimj7i+udL3pt1IvOTTOJBjfHb+q3B/\
6gR5Puq3ODn7F7w1F6X5fTzAPuofk69BbNK8MIfeY4eJ3jcw5uQ78iC3znLucPVf8nzc+\
KfVJeuYbeWIX/V1BQerdTCdxwlFe2dyD6jK4KD0FvB0/iZ4AXxU2DHu0fCH/8K/\
RrsDoe8HezGfU30qGkKjtOGpd6AGQb+0bWJTLtfg0fSD8AN2Wbil5jZneef78rz4kt+\
dcI86NMi1LUKcuKnNW/\
hUVFDOB94TTiHej48Gno9drPyqYuqcxGnMhXYr01YcDWqX0zmuUt9wZXekjxl4cftL/\
URIoLbsadY78GURKy7olHRb6s/I1f3smJf/1hAXkDRaMh7Z+\
FlmEt9eZsW3ge1UPLzR2mRM+HNCEfdK1N7Ce2pSZ6jukb8XI0WPo7H5AGYl+\
TF6Fjg8e3MhdRP+ziS5zcbxHh3WYx8bOB7fkLyHcyZ7YJDAedlVsVC3+\
X5wfmjSkv62xv73B7A/+O/AifoBt9hvBLlAIdbQPjZe8Dj5ceSPIZ+\
jHuwUngOnxTmOQfhGbeXqYulByDfti78hOYx/\
KjeKPCwwTLyW9186jIFu6gjapbhR1ad4T/\
1Thxm3ccgP0GPkbpbb1KA795DXWsvLHoueEt+s/eyGHphicRd5gg/y5b/eDhisP6u5xd/\
djvGdy24SBuB877KuYL+XaXuqC6J/Wm3wUdiYqemPRvhQTLj4WH095H/\
YluDI1JRwTPp2vs4T44ey/ltGfEUfzU4HDeoBO+pTf1xuxp+VTv/d/TgZ/\
yMtgg8xeroRfEbwzsTHH/L+/KTZ2ASD2f+kgpP6Dv4Rkxl/HWmmdS9/U6dW/\
0TnsFgFuvarkG/mmolaf9P4rkqOfUBvIb4kXQx4tf2qtgbFTiHBQWoA+\
TNAjceNKPuiV5xAf3WifoSpgt1hdQkzi3eceF9KQM/ohq2QfwOI/neNv7u5QPP4+\
pQh8AWPC3zNxt5rAMPg2ks+TBDmV9vRxaeG0f4Y2bhR7Nd4N8I+\
lCHw6SG98ak6YM9FHEHer9/RvpbebnoEcFNzQqD/\
VtossRrBBdT4hhynCoC7TlIHqvpJHV7LwlPRAbiRPaulXNnMcmDI/8+\
iEydPNeNvH1bhbiKc/uY51HUJ1etOC/7Cvvf3ZT8hMO7JC8xIf1ddZV+\
jiOe7v9SgXhP3xXYlbsFHz2B/U6nGMT+2lX4BfO8RC/fdthLOauDewnAEavE2D22ck+\
JMxF/CaLURL+3on5OEN1Hn5zdyTqYP5/9v81v+B9GcA1yGvb9tf2xrzqVBJ/\
QbD7nqszESc3TMOi9+/g9/Zdl4AV+lR/cQulG8PnHqsP94UKhq+59FTxDhG4hvnzbpgO8+\
vmOhe7dr9x7DeO+Y95iw78/ofMH5Cgb13d3PjAO3+HpH9DxS+j5+ti30H2+\
zN9D98cnha7qXtefofvClZT+38/ynQhdvULVw/zvaub1Cfu/qx4QL/z/\
rn7s7BFCn2c8EzF0HTozUuj7hcuFruZkjSih658tov7v6kp+j/a/\
q832Jnro868DYoTubdhYoeuBKrFD14i14oTen+J76GrzNYwXem7MOvFD733/\
hmubHQlCn9drkPB/V3XnS+\
jqT2iaOHSd0yJp6PPHZ5KFnrftaIrQ8z7m8ULt6f0pdA3mLUkZ+t6y0qlC17inQ1d/\
3IHQNWj6iPtsu0NX0+R76OqWlEwdev/\
bU6FrMPpCmtDfc1ROF3rPljAZQt87fCZ0tUP6ZgzdX0oauqpHw0KfB9NepA+\
N64zWoavfcEvo90GLWmlDnx/7GXq++TyI9i0tHGqvTnf/19D3Em9LHrrunBnqry5aINR/\
L166hLSjRmi8vLnn44a+F+N+aFxdxnuh8Vb/xGDc14YPzYN+3C40P+6MCc2bGVs9NJ9+\
zMKheVbpmoXmPaixNyQHKma50NU0+hIu9JyLg0JXf2TTsKHPc5qQ/\
KhK6ZGr9vNDcqZeRwrdq7+P/gjdz3weksug4revIfnO+zh0df+mDl1Ng+\
Vf0V9ZQ3KsbqT7FJL7d31Dcm5ftUTec4cPXfWUyayTKI51dOgW17yK9fXWZ/\
2FG8O58EhXzqN1+4lflfO1S3GM+2YX0Sd/S52NjrnZ3/dNwi/2A5yK1/Us+\
9RU8V8sgM9aVR2LHss0H71cFL6+4F9wX/4t6j54s8Ojr5OTb+1XkHj9OXDp+\
hQ8n7pFc9rXSfCbmbEnTIZC7C/r1nFeDcagb5fBJ63X/McbuJC/P6C+p243Fd7CbTNC+\
fTuTUB++pca2KHtV1LPuvNb7KXDvbAb+qxFX8akroL67Tl69CP5FjoJ/LB63A/0+5/\
g0Gw+8P3Bl8T0Y3cBxmNpGeyHoe/ZR3bXZv+eLXkDE2Oi/1cRVzUJsAuC/\
eR1qX2N6c8dqdeaJj924zHJpzgOr5MXpx527VXww24sOEfzBZ7/YBDxFPcv+\
VbBYOKULobUI9xMvR2XLAd+uSvESf0zwidyF37y4BLnDDcFv48ZdRW7ogp1JE0xOT+\
cpO6c7tSaeapCPT21QeojF4A/ys28gP2xGN41vY38YPcHvMz+r9Qv0m+\
w00yaE8jRhLg8LyF8FTbcWOpJls3M/EboR3vkPKEGS12malKfLkc8sQvJz/CaCa/\
Wp2GcQz5QV861kXqds/An+3dS0H9FnSQbj7wTb4HwTI7uQd77j0/\
Y7e37wt8QG15Bs1CTd/gyDjwkv/WmXnjm6Xy+eAPz3RA+\
FRcRXiWv9xGe0zMDPCZfhsNTWH8g9nIU4eFYDo+\
q97YqcrISXpsgNetC3c0HX1jOaPA9ZesNX2sv6lAH0SSPZwp8KP6d/NgVujDr+\
cFI8Ts2QN7jCL/vM3h6XUWpGzsfPi71WzmetwteMN0lOvNxgHnxjsIj5K8nXzV4Cz+\
cPQ8/spv8HrtqUG7W7+VDIT4GXcML8Z94kTuGxsPP+\
wS9cGII349XnH7NEX6nr5Px30wsxziXhzfAlu5NP5PAj6GepyRPtPRD2vsjB+MXfh/\
tmQrPoH4Fj4C+Fxd7s8Ir+Dm6/wtvR/HX5GG+rwpvxo/B3J8ID3/O1Ni8Z/\
Q36iNPD0e94uq14IkKT36qd7cI58axxZi3e/AKm5PR4FloAm+/\
S92Pv6dKjlyMuMZ9S3iMzOZ8zM+0RIz3zabw3/wNj417I/ZvZnh93Qvkxo+\
YgXE5DH9J8P6y8AKwHv0npyXufIrfRZJz6z3hAd8ej3FP14v3HgMHFJSGF9gWg/\
dCG3j27EPRf0OEL+DxRcmzJi/b/QGfTlDpBeeMhJdZ520N/\
b1OPQOdGB4vk1HqPYwS3qOuE9Evg6hDaE+TR2mLcS4IdFTm96DiuZ3bsE7SjON+\
ZXv4YeaOoF9jwRu5g/AK+FHId3XXE3PvkZ/mh8PvYUvIeXPqd/aN3eDD7B45H+zDD28+\
sx+qluTf6FgLwHO+e0IcoD3xQBvpsuC+yONwwUf0+h9Sr2U69b/cU+\
rReInhFfEXTmffiES8za2VOi2/c251peDl11+kvkJh6hi78VLXrBe8zF5l+K/\
MGHhD9DOpEz9JeIma4V8NOu1FX8TIyDw2Xsb3LgsP213wIeZJKYmTS92B1cLvuRocW9ANf\
IorInWBzoAL8gdJ3YgK5XnOdeILQTTJW7kNrtzPCk7eDIVfzo9BvoU7AB7KXsEfa/\
eSzxA0I5/c7sdvaQdRZ8eey8hzF8djf61LnrutdZvzVPtltLMH9ZpMV+\
wK3U3wfZtPIQeJanOdQT0Jb77wUOb3kZsn8I6aAuSBu+Lg1L38NxnvJ8Tr7ZH93L/\
Cz2kLSL2akXJef0bd7KDvLeQ8A/HJoAb5ZnrZ38xHIXA2QQJ4IWwW/I+mBXkLXhTiXsEP+\
Ln8jfDaewOoL2rCZ+d5lbvQn6Hkx/sHhfd7NnjCIAv+\
eBOHeJSfmnhOMO408YEpWziPRivCOthFvW0VOSf9iZub8e8LrtN0knrDEfAL246luBr80v\
owfJteykro0znwZJvWk9AXV/HHeynhvdVtxb5oD4+s+0wdGvP2CPNzU/BmKZsw/+MHo9/\
6i33SH3+p20P+hKpDXptZOxf7O9Ye7L8brGMXvoPYw7UZ12zt+\
V0M4m8m93rm8yN5sfqu8OiWENyPxh+jF0qe2A74Hl2TJPA0bdmP3oqZE72+AP+2+\
wDuySQviVyVBkfvOeGJfzkEeZhEfY9gjOQ5ftyKnJX6k/\
bOZJz8GmdYV1NbsQ5Hr2Q8vj3neT/xd7oF1Nvyr7HO7QrywtxqeOmNbsa+8B594f+\
UvNjNxAf11yu0Zwn6VV+l3qodRJxAVaXeo/l6XHB24M28L+T3uJ+CNy4B/0QwHr+\
Yl0n4IwYzjiYS69EcRn/52cBHeHvkPFXjPPNTtzPtTi729E/\
hA5gHDihovZv5LC08cbvwFwaFwM0E1TlnWF/yJUaHBd+4MhJ+nizivyr2gv7vIB/\
U3CIe75reRi4fDkaOEi/H/l+AP15vYHz9SJzn1P1ofP8F/\
jt1nziKSUB81x8NLtM1OIjcJhtLP6ORf2Qqkjdr/5H8s8P00/\
yKP9O9lXqsV2dI3HAr700q+\
Rt3yYMNJhIHta0u4SdLP5zz68HX7FdrI5In83Ig45DQoGcT7aFdMTPIuYb1448nv1pVX8H\
7IsKb4BaS7+S3FHzuBp/2Rnwm8U34dILDo5CXe+\
DN9P6Z6Of48C2bXNRX0lFLsI4WZmadpyA/3fuTulMqHPnnXgryH8yjHZyXMzSX/\
Ujsjw7kCfh9jmLXHICPLbhHfpeOjb8+OA9eUzeXunFHp4k/szffX1QW/bu0ldg/8PDpD/\
DFqifn0BNt6VeQjn3J3aqMn+DaD+\
Q6EXhfLyJ1WtWxluiFldjlQWzqEZvdXzkv3ISXJoh7UOKAJWl3OOKXZu9N5LoQ69aWBcdq\
U7+W+AX4ar8zPL4mDucDbx58It42+LJUH+\
pi2egZaP8T9hM7ZRvfPwFPk3oHTkbvu8v9JXh81DL8+\
zoref02MvET913iNufgc7ZDpf57dalnOmwa7R4EbszfeUj86+Bjve5SR/\
mPnejdjWeR75HEDXTXvewPAXaUWkZejUsBX7C+i371Loo9uJ56nebIKOS9IDhq/\
90Vzu0nqBOs4yxBnn+SXx0cXsJ8Fib+5EUWXoVSzIOuCJ5cT8HeMD/gp/AXkhdkRkh+\
WDPw6q6OtGct8XdvlI8+yrmN9pwviF5ZAx+Vn01wOrUKoeemUi9K7ezN+mzM8/\
Sga7x3e1HBFYIzUtfeE4fdKnkfBy4JzvYo/ctyjveWm4ZfOi/+Kf2J/\
I2ggOTvPAwL7uJmWuyIUpGxK3Zewt+dOC1+60JHwZP0/wZufovUox0Wg7qy1cJR5/\
VAfvzh06viz25ZgXqz+8KH/NXes27cRyqFPzvVa/A0kcJRr3Zz7dDnQb8O+\
Oly7OTzSUPAr6S5h//t4Tf+\
XuM577mTlDp7TxNyPbmVOMCmKLTz9WL87GknhK6uVevQ303piDw/\
2jPaMb95qH3BltXU77s5D79hzjI8d+Zgvn9qFu/f9YD7FC/5/W/\
499WsuLRrSxHeXyMj9W9b5wk91044yLhtu8/fU8l4Ps/GeB+LAN6/cGv8XAWrMe6t+jK+\
ZQ8zDm8V731K3o/\
dGYHzzqmafB6hGf3tyvfVhzXM856kzHusCIzDiOmMz7D9oXZ5U67Q73edmNdX/+\
BPffsP31t6CFzR0dzc95/A79btI17R8Tzj+\
E8b7jckC13d4nyheITuvYg6wmGHUle4QbqQfPjxK4We4198yvidysb9vuq0p0k6rtV+\
MH5dIjFP9ibj/vw081EzBu3Txfl8xQjG9UYsPm9G+\
9W5MsjbtOU8b69lnuKsod5w86uMc4XbjGP37zxnAvKt7t5kveS6HRp3sya5zBP4M/vPI+\
Zvh+Ck/37Cunr/kXYOf8g8xS3G94vBa2Qz/k2c6iD4Npc2tuC9iLPpVuTheGGl3ufCq/\
g5YsBjb0Z3Y7+NC749iPIEvVMAfe7ugBd0/\
whf1zHqQXnReb5rTt0ek7UgergcPDHqcwmuXyQuvWcOf3+\
bkf0u5jn2p4JSB6II50MzRM5R1Z+h9zaDP9enh2JPhR/F/nEV/hbXC/4vP+\
gmvKycV7wju2jvKckLukHemfuBveQKRcYvUK0Nz8kJn6M+Dt+\
1DoSveCF1Evx25KfY9OB6bX/yB9QecP7BB+HDGNCb/aBIa4lz92Y/\
SjyA67h5wlObmvvPNbFb33NuVH9clH2buiD+cviGzAzwJWol/\
A5eQ7HzCwsPTRLsMBV5AHq7Bv5plV72S8lzsZtSMU6JNOe023Pwc8XCf67/Yv/07sNb7m+\
UevEDwY35G6QO5A/J85pXhX3Vu831xnU+PzKSeWt7HDth5DX2vRzg/\
3R62b9rUPc8yCD8i3VryHzQb094MuxzcNZqCnaZnyWz+J2ZD3OVc75NyfnIa89+\
a85yHlB1ibt7zZry/e8duPZvwrjO6S755qfxM6RZgJzcrkx7d59EXqIklnw/\
8mL9W9TtNf0EV7mReqW6DngrOxYcoNdiGZ+fpT6hKkl83Y0DN6cb4u9XL/Ef+\
Z1LcX0TC7lIi11qfkvKuSYO61O1EjnZTt5oMAc+\
HPO8EnbBU9ZdcJtxcQvCyHkSfeCXe4k8PnlGno7wnnlR8TsEEalDY/rAJ6y75sW+\
viV126LDW2Qs+Ux+Anj39bjpyMs06irrZPAw+t/a09/\
18PLpInJue32b59enDrXJTB0bs6UW7Tssn7uPYh9Sv0ZNA0djy4g9nZF6iGoYvD/eZOF5+\
TmY61jxr4+U9fuIukjeLsHlHwW/Z6bD9+ClAr+kNoBXDxaKf+76feQgdyme94O4i1cG/\
1eQC/tTRejL5zGlznln4aOouoL+TCFPRxfBjxyUAOfgL4av390WnvhG5AmpFeRX+d/\
wKxk9mHm8S75L0BW+h6A7fKRBipP4K16PZVyqCj6uMTybdkIOWRfRxC8o/M5NkTv/\
kei7MFJ/NB11q83xCfx9IDxL5jnnM323L9fGkifVgjzVYOZE5rHmJ+\
a5Bjg7F5M6P0GJfshfRPK5dTjy4nXFzOitf6gP4G/Dn+3tII/SzCIf2/62jn3z/\
DjOuznIH/Pm1mI/q7Of5/yIgv4c9wK7djJ+W+fIg7eP4Ffzf2H/8GvDP2OWdqWdDSIj/\
6vBT6qPHRjf9vCUq0nMv7oFztjNfYTe2iv6NLvUPTwg9UwjC19AE3AmNt1ywffCJ+hlgN/\
YjaYuo3+f9WVHgoPXsz7Qr27kKeiM0ehHWeEhaUZeq9kaRuLHwqvc6wZy0kX8Kvl4jvqbP\
EfXnjwufw78MfpWUtGHxF9d1FjSD3BBqiB5JMGesfw9IO9WaXhwzHXqr5iz8It7t+\
EjV5c30j+Pq3kdg/E+BX+BvoR/0m8huO2aEQSnh1/F/3qP8+\
NtzT7YGX4Z23wkceQxefF33l/HOKyH99BvQH60N0Pqe+aFr1TnRT+\
6m1y9KMyfvgaPty7cGjldgb3hbZf8vdrwr7kB1HtTrTzWUapjtK/\
6NNk3JQ534YLEg3mvq5CUcZyUjHVbCZyxyQZvt9sp9dWWhmV+Owo/fYDfMqgIT7G/\
Hl4V9UbqnF4Zz++rxeK9TeEtD35Qd8eNl7p30Thvq/6X0P998SvaefjR9GRwiTYP+Yj+\
Vfpn7hVkHItIPOF3/JBe5h60s7TwOk38l31gHX6rICVy7j+LwverUI/\
CjADX5lXFHnFh8YOrOeQRmFqsY3UG3K7Zhr3m1/\
tL9kXkwwvLuTx4R11PfwB4NdeGfH8blfN0kFDwfI715S2Ez1O3oc6qen0GvdxJ/\
CPBOd7znDiAWk0+vq4DH7A+HZnxGMW8+O3JE/WyC9/\
nTvw8QYQmsr9Sx9jvNJdrXOwBU596wbqh4L33Ml6uf07J3wMvqmoID95UyevtCE+Kq/oV/\
0or7CqThzw5/f01evEleEjbAn9dcBt9520VHoAEWdE355APMx5+\
YB03AeP3TurpVsAPpQcL38mx7NxfkjrVffFDefXJn3NDyesP3hA/MvfJq/Q/HEI/\
dcLPrdazv5th+Pn91JHRJ63xm5g88DvbUnOwI3+pw31d2SemzhL9v0DiLBZ/\
x6Fx7BPDFuKf+ws+F39Jcc5lWS+wP8z6JuuJuthBVOwB8+4nn0clT8ybs1niZ+\
S7mHgH6U+GCeB+2uKH1WUvoT/775G8GXiibdGTjNt39K95P1LsxlVcUy+VfLaTPG/\
QKdrXHvy3Wk5emT5B/rvLx/6gjsPjbMqCD/JqsT79XvBZe8/\
Yz1UHcEBmMvdBfPhYvPnY8TYdfmWvHDz4wc+oyGdYqXc0KDvv+4id4Y+ug3780UHwuvw+\
OLmF52UQPrkd2MF6OPaOPkHczYanHrG3EfySS9ND+AakTslz+GBUu2es6y1xuPYDh+\
3fIr4dlIAnJxgDb43b9ww5mEEejvcZe8mbIPmIUw9zzSP1ev8h/9S44eiZmeAB7EJwF/\
Ye+sOtFx6lU7voV0b2Fx0Zu0NtbUB/elNHxhxqynoazLrUbSYjv2HIJzKV4ddww8FTu/\
WfGe+O1CVWvclX8mdTB0XtyMg+tIo6HK4k9bb8R9RfcGU5twZb2T9VJfiRXAbh9dGlhf/\
lPz5bqVeRywNfkgfefHtf+HXOUpfbjzyZ8YpG/4Jx7EuukPDJJ4If2nSS/\
NKEw8C9p5M8hT/xS/jDyCcMUkm94X03+f1b6igFX+fznI/\
wH9iNmbjPQx6LL34BdzIrz3snuIt+bRinnoyfdxb+d3WCOhPundjhj9bQnySp+\
Dwv5wazGBy3Xsm+7i2Qc2LPBchNYtlfJsKrpzuuw66JC39/\
kHkV15vU6fSLSd2IdfgHghf4QUwrzkHB+CbM3w/\
Oq37jRcjvgxqs38f8zqz5yXqLfUnObwcFHzST7+2NTnvSsl6C1sKvcaYq693Bb+\
gsdoo25Iv7mdkvVD/\
haWlFPpxpcEDsjL9pX57oxGkKUUfBXCHP3VtMXeLgdWL0Y33h7VnLPqdKcX63y8DTByuIo\
6pmtNO1JZ9RjWae/S9peH456mgFtcbIvs98Bh5xSU/B96yanZHzPPaf+Ye6SW4G+Ab/\
JbxEankL+t+kFHr4hPi5RxeV8w15tG4k/BXuFPHrwAhv4P4q6PfZddH3g7/Srs3Cm/+\
Q87f3HR5h1094Zm9xbnGZhddhwT/cHyB+bh6jP/VS8g+86+CG3EWpk3LpKX66svuk/\
gv1N/zzkZDf60UZj9rgyF2Fk7Q3NnFzW/YI49sPv4NaTt0KPYT69Oo4+\
XPO3Ubeb9xknB7FYB7/ke+Xp66KHsr5xIUVvt1Bkq/2UPKIf5Kv5o/Ly99LCc/\
tknz87u4Q5GLUD343IxPfG0mda7uyj/i9sAfVmHzsE98uMD4liEe5JeBl7eq46LPosn+\
lBueoz8u5/xE4Iled9erlhodTJ6ZOpmpNfroKE4Z9dyZ+Ka/\
1dzkXSd7kln70KyH5Zt7tJMxnVuTQ3ZI88h3EsbQPrkVdOk97N7TBDg+/\
gH4vvw4ObCB1dlyB7ew3qyUu/qfw8n6XfPsLWvy5krdlqHcZRAU/ZDoz3/\
oxOEsd6zh6POYm9Gc/\
4op6Xx36nVbycp4LD8IH4u06PPNhd42V8wX1Cl1V6pX6n2ZIvZ9cPPfjQPB/zQ+\
F8HN69RPqQ2jqpHutqcepBn+Q87Tw5rQlv8XPiz9XnezE/D+RuqIDTnLdQX0yVbqi+IUs+\
0mGNBJ3lPzyQ+VZbwvBBXtdxvP98vAX+7WUnO/BK6iL8Ofr/cRZ3dcsyFcK6l/\
6W0ZxrUS9eVdP6lTVxJ9i5yLvepfwUW6pwHU99XdUO/KL3FrheagNb0+\
wqBP6YTbnBJWFuqruE/0Lokq9s0+G8T3Zk3lbTh0xV0bybOZhhxkr9k8V/\
Ap6L3lvNqvwgguONngLv4UNE9CPePTXFkwo+\
2o8nvuirZxLHmJfNMEPp3ZLXtZxcIauGecUPw74Za0lr/oYPObeJ3Bgfpw6yFXkHvR/\
LXw4dqDguVPAe+OeUAfHFoaHMciBn8zOp868lwi/g9oEPs7fDO9GMF7qtt4T/\
sNzsv5rCx72C/4GXVr2/cMTpQ4A+AAzCv9hMGQd/\
XpLPpWNLfZOHeqE2yX022vFejQDqaeh4mPPubHUZVLtqWdkioCTsCm6MR5NPjEPg/\
GvufnYTUHmPuiHxffQd/VfYGeWJG7g/SN4vFXUczdbxtKO+KfknC+\
4tyHkLarF1GMzC6nzYYcIrjoB+DfzjrqQuk9jrnMmIN8fcxEXiDECvXQeu9K0hFfZDmf/\
dU7qY9+IxvpoeJv1fnY0eOGuyJObvoHnfs/PfGXk3K6WgZfwbycUe0vqkw+\
KyD44k36YSfgnVcyOjN86+JnUBfzgqhZ16cxzh/wVJ5/OS5pL8CfUVTAZhzC/\
QzPT3mRyvUZep//3IrFrwAHrWSXAhfem3qPNS11jlY66Gv5M/OT+\
1NqMwyzBXxYXHrE3t1gv8agbb3uRX+uqUe9O19/D9WEFxik3+\
Bg7TXhfloD31Cu78P6c5VmfRRaiB4fAr+\
o1BbfnXoP3NcekfsNB4jP69SKu8e6wn2cgb0Tnh69ER5d6zmt2U8+xzzjaXUT4ZGKDW/\
QLYo+YuuCU/YfUv7I50LeqdX30bhV4vdyDotgNK4QfOamcyw8cZT9Lv57zfBvqCQS12rG+\
AnjPgvPURw/y4292Vcg7Nu2+MI7VD3IObAnOJ7jJ/qfiX6dd3jHW7XHOoa7MN+\
Tw9lrWe6dTrP/W4GSDPwT30yoS41OUuln6Dfytaij6zZ4hD9o7Ql6G9+\
Qv8NGL0KPBiXfUdwwLLtuYKRJPw09or1JvIhgj9RKHyLlFUTfNLgefH3SKz346aRnxxzx5\
aH8yWT9lhSd8PX7CYAD4XL1vn/itrsh4w6cUFJf6Ajeoo+C/Rx97Af57/x75we5pe/rbH/\
+83iN1zRsTH1ExJU4wCf5Ir20hifuiX1yyVox7zA20M05WxqWU1OmaL7jDh4JrvC11Igs/\
YN2lgL/Si9IdObsuuNlnwj94knrXuh318vR62a+9P8WfuZR+rIrCftEyIG/\
g4gDuK5ykPcN/pT130OP2BHUPg7aVWI8DKqL/1i1AL32mLp8dm4txyUpdJNcX/eCvhH/\
TtcPfqnNFYBzPgJPyXu1CnmJIPOd5ZeS3N/\
WNzU7qyJpP1GFzw9C33njw3LoocW0TReoBj1pNOzZyPjKJ4OvU6WW80uFH945S98qdJa/\
L7845wX0nHmG7YAfYp9QfMyXvMX51wK0G4eMxH0/\
r8r6vhbAHBldEb0YvxPgWa8hzOlLfWL+W+sNdx/CcdrtpxzPN7waRl+PlIC/\
HRD3Mepon9Y2T1cOuDcd5063tyLraQv68TtobPfWc+Lr9V/Lw66xhHax/Kvsc+D31q+\
RnlGQ+TaRZ7FNbqCdv0mDnBLk2YVfemMu8NyXPQjctxbjEBN/svokfSvIm/CvEg/\
w81BnSXeBt9DP04T0rq5E/NZf7oL/UzbzOOVMVn0ceS41N9Psh+7D+\
qxHvLVcZOc9UXuRLzkV74A/xv+Jv0B/IC3P/UL/aJKSOgNcE+TD1Ja9kM/aGfxN/\
iaejMi5T8WMES8mzsH8fEfmkHq/ptYT5uYJdFhTjnB1sh7fMuyJ22H/\
4kkpSJ23YKcah4kz6VYx6x0GeT6yzmOcY163E2bxwnBdMLuxs/+\
0T8RPCQ2avCV75KvEpr0YFwZvIOWoQ+\
4FuFUnW6yiem7wL8xWf8fb6FqR9RbF79TvkPfgjpeC8qbcZJJY6jA/Ao/hDwXEHt+\
awP7fCn2mmw6/hNRIexVfoy+Aydc1V/DXoveXdeJ9PvpPZS305+0H8Sm/wv3upsO/\
VWuwP74nE3/tdYXzuxac/qfexDn/JybhKflLwjjw5M3UfeZkvPNbRnHbI72D2T/\
tU6lxXXINcNSXuHywSfoLGnB/sJuxXF7k7/RsMbsBFJl6vspJXpuMvpD2Rs5G/\
1asm63v8UP4elzqI6g7nKrUQfew0PAdezdQ8N1FE5qdzYuyovBHo327wK16GDjxncYB+\
X0ZcW0Vm/HRk+GlVYvSXK8k5St2gvlaQFPm0S5qjv6LGZpyrNOW549Px99b1+HtW9KM+\
8gF5PZmH/iRrQj5ak1XUw257n317Xi3kbMsO5jdVY6k/ybndPCIeZ9tIvfhE+MO9PKxv+\
3GL5FeQb+XSC09nkoPI00Gpv7KN+q5ea+rCuaNSx+kXzsF+ffBGZsYq+\
lUsAe2f0J9x64Odrtrjb/X6RZP9lfppQUHqi3rrmjIOdY5L/8nPM53W8/lO6iT7+\
7BzzYyeyF3kcMjdUKkzn5Q8OPuCfTrodhg5SRuO370UvX1a7L7ftjJeJzLyvvsVQnl97s8\
/qOv9xwz052zq9bnq6/n+RHhXgjtST3EC8VuddCz9/eGjX2aAVwgGCV9Uptby/c+0c+\
IZ3luZ/EE9jjxOl0Hqcudfwrilv8vz0lAf2btQkfYMacTfm+zjd81j0s9C5FMHDYtT/\
7vBSfIUM9xmnoqz3wcRmiG3M/5lvd9MQv9Kl6ff/Y9yXqn2Arl2X3l+xqy8LwL4b9ee/\
J1gdHPkY9819MwQ4sx6/Vvk5GsV+\
lE0DO1OxXq1vx9k3EpyznDj4PHwZkgc9hz1JO0R6sab2e+R/\
979yJf5VpI64HHgm1RLBjLOs/GHeyWRB338A3Xbc8YJza9qRd17M0LqZf/\
eTeqoJmFeslB/1F4bj75LHYPxShme8doJ77pecFn8yzP5XdYs+\
KsO5SDPuX9Yvn8Qf6yXBPyBXQtuJfCoX2l24Q8Jnkr93TPgKoNfGG8zhfOlarCXfS9bL+\
blTGzybH+ih1VD8of9GaL/byagHX0T8/ckVXn+isX8fsKxUD9V/\
hbkuxYXfsCeRZmXbeTdBsWo762rEHf223Eu0qfJt7W/lEVPlJbzaIdZ/\
G65pf1D0dPB9l3osU7bsdcevaH/PfsxT9vAL7qJ1VkXh4oxv/\
WrMk8HhjDeU3zW0XT8WX4X9Ig3cTP9P865x27BrnIfj6IvDm8jnzbFqtD60C2jhd6j3uRG\
3978yHxn+Ts0jyY7esnWmUP7+zbg+w1OMm67Z4Z+pwcY1l3vUqH5sD+El+\
nPs8jr4tPsL8vYJ3TzYjyn20Dk1uWSfTYbcv7wv3rv+\
C1dTOrrqk7kNXvpxe97rhzrsOYE5P2b1AF+xjqxH7+yf/\
TuS//7T2Geh61hHnLeZ9z7RGTdZy3OOm9fiHbuYny1Rx6yOlue8avylvVRrCdyVYF8fL/\
QIOZlzDPxqz9gPhZhd/vRktDf/l9ZL69L85z7dxj/I9fZPxrJeXVTGZ5/KxHz0mQ5/\
YkTg3xyVZL3/iLnk0bkNess4JLsVPHnfEvO+kkY8Lt0wguYdijtTZsQeXu+\
GHlbnELy61kP3i/NqEf8dTvzPa4EcnGGfcRf/iv3Rc6F5MrLtJVx2rmbv5cux3PeMD/u/\
EX6l7EevBcdSoeu/th7jEPWkTynQwG+n3AOPBlv/2Zei3Tne/cThX6nD6QJyZ2Kz+\
cmbT3a0zYNv18qOOLZUo/m14bMz47F9PO3P/nexKPkUT9cy3MWkJdoo92+\
TDtjhtrln23O/tIiDP1MeJJ9Od9W5CccPIz6RFyJJ0ueUPsAfoXvl/\
hexGH8rncixjfpdtbVxXXsP3N38ffWty+E+pu90aXQ9yrFDd37MeKh35KtPht6Xrruoau/\
PUroqrc9PBdq//kStLNAXd7zr5zrt7yh37euIl8V4VuwY9GXwcfuyMP3J4xzuCWMS7zIjM\
PLHfx9T2faleA47Y//ljzO+RFC3wv6reLv58adZ9ynhu7d+1mhftjxF0LP96Y2QJ/P74d+\
aj4OuagxB16FXmXY9wox3v5w9j//bDfm41wY3n/rHfMYzqJ/Nu5knJZ2pP9nC/\
C90cipHaeQr4JlkaPx3+EtuLyY9TeQOIGZ8xvyPLQA1x6F0Uv6T/TZ8cnofX2R+\
erVIXQ1LWufZz57Ie+H/1+eu/7/cSt/\
62pNStRI8v8f5cqRM1fWHHmz5shTM2fBQnnyFspTMFv+gnkL5szTNevjfXPKboinu/\
6vhcNHJ3D/+4+bEqde6BOv2K2MulXk//9ft/D//0/\
FP7p173q9RTV1InGy3f//9xSLU2XQu1uG+V8jvf81UXkzy0K+\
0Ocik11PSB7axaWz9w8wKH/9yyYwcw6di7wSoZwxBGEZ7iE8kz/\
wee3HTEpxjDsX1aH03ifj8zOixNo3l+\
CQbGZHUXpm6VFIQ7z1PC9pQ5RzeSGvSFiX73WZhxI/3zckRObEDYQ7zwQm/\
ZeGGLODNP27Eod27t6EMNw/w+RnKEw7w6bg84g4H/1jkEF7R27w+\
6uFEc6qSUPCEXR5hTDFKcLfL67mOTP70c+4Qej79mRiSDMqR2DzWb2ERb+qN8qvGCQ2wR/\
16WeipTzXl0U0AqHUE7JjvBW5glBlfMpiGBEDJZh3HYsyFULrF46HcLYBvK07YkS7ZjXYZ\
JfuZPNZjhMrqIoz1PstMv0eWJHxbzBF2s0hx4uC0eWdnIqQ14vFJrmTYuv6MZu7q3uH379\
hMzEbOWSoR7XFuUywPbjahu8P+YF8xYRkxMzz6N85lLB/iEO4ScbmGuSYTv+\
iYLTakkOZvxkbUZZZhHSmC0auvSWke1MJhgRjMIZcMI12xVrMeyNOlfduYt5yHUKprLkVI\
nHxp6zg80sD+HxeTeQhfD1+n2yr9BNj1aXtS3vHVaK9SxOxeS1qy6Zz/CzrI9d45mXLd/\
o5H+eY/5Agit/+KdduCuUVcwfGViM2J5UjDe95i/PAVGN+/BQp6f+\
lCGxGGQV8OweSGfPJYx0NmIvSvV8JOTvfDPlMxqHLj+YhH/E6M6+\
VFvO71zHp76HkXLNNQF6qt0ROZuRHOVYYL87f2Mx3lCfM09qEyHfb7MjjT3EmVmTeVPR3j\
GMJjOFgcA7ku04FlPMHlLf+\
mYlNZsp3SIqSYJy6OCMwssPvoX99HzFvNzh02puT2Lw29Wd9D1jK/E+qy/suX2ScS/\
2LPny1hu/vwOlmpg1mnNdW477CM56fuidy+6YR41m8JO1SZWh/\
zdMYW2X2IQ9hIfu1Kizj/IHglF63h/\
6vFf36T2X0Y5uGPGfVO9bNKdaD1wDwmlqOs9S9u4ict8G5ojJhhKiWGM9+/\
hqshw9yiPl4X8idIPFSX4ciJ5fu0M8B05ifspd535uVyN2ue8x/yRXM/\
6dHrIcJ55mfihO4DpmGvtzLerBRkqOXfORR3Zfg8jucLLY2IHc9mP3CT5ib9ub/\
j2x2DL9LGon2vUPe9Ukxsj8sYf7f98ZIuHed8UtTmXVzfiZykuox7bsyinHuUxg5rSZGYd\
RO9Dt6Xebn37bovRdxMJJmXmYec7ZgHZeuw7ztRS5U4tHI67c/MGrVLg5J87oj/zPW8/\
dqsRn/3RN5X1yCOarSXOZn8To+d414f+5fGM+K/9D+\
e7sgZ3rEOHtDmzNPsdYyTtuXCwkRQRe/Twnmbfh5xuH5Q/RoJpyoQeP+\
zH9UjPdgKSR03k8h812Dc0Nd+\
5N5OwxZsg0nJNtjcAZ52wiimQaDkctKN0Uf4OzXXRlXf4gUOTICki67mHZ2JBlK1W6IHny\
3h/6+YP9VlzryedYfjHuKDMhXt0Wsw3jzGaciyHEwFb0WDP1Me2Zm4pA0gqCsWniW8f77K\
89bSVDe+wMQi415FWPxVFn03KZl/P12O/RsHYpX2VUCkhxJsVazsDby0SQ+63J9L+\
RyInaGt6wBesCdRv+Vasz45MbZahdD/u7KUfzSXO8rzkX0s+09Efm5mvoy/cbYtVH/\
YrxTz2b+Txnec5Eg+v/\
RdJbhVhzNFh7cLXiwhuAa3KEhuENwbdzdE2RwdycEhhD04O407u7euLv7vdlvfb/\
m2efsPdPTUl1dtWot744E+\
aZM5T5VCAbb6ZLkjUXwTL0lyau6kGTyjgBOssWnYBc7kITwwm9gXv25lPfrNZ/\
5OgeQrW2Qlvc5TpIgWCbJntWIoNlOMm83ApoNmqdjHBayH6iBJLXMVsBrNkMikgAdIEfxf\
34sYIkO/E4n4H0WzmGerCIJ5X7dQv+1qc/heesZxj8RQWKXZDT/n05/+\
6VJxnj5AaF6zZg/wekY+I1TS2EPho6i3cs5bPrfw7DntffRnkHYB3/\
rVr43Qdq1jvdXC5Lynju64c/ez0l/TjnG/7+LmOx2EXOZCyjFzzKd91a7mR+\
n8khSG7Ig9+CxJG0QC1AX6V9vC++pwwSckQyQcfCXkHMUFL/tD9knlkjR6+\
9LsBdbujGvEn6g3QcJDtvwd/\
h9q8L0Yx3AFm7sZZ4zGdKPoDlJR38qpFHmFWCQ4OFdWZeQ7LgPIvrUjn5ycbHf7hCgOO8w\
YHJXnaCBV7YHfkW/XczfoVmYZ+GWsP8O+5X/r+lLu8uJ3/SC+a2Sj2FcEyxiHkdeil+\
fJhH9sBrSD3OE/ckokm4uZSvW85NGjF/vONjtAgTT3KFa3KcW5wjXIS/zoPcM+m0yyZ+\
gDIdOdZwkkL9C5klrggx+Kua3GgAJnN54QPwaSAxtKtlXh8m+\
vTEV369QUPa90ux3A7Gr9scO/p8d0HswgiSQ/wh/zAaDaH8xn3NhmqsEBYpY3rdLRb7/\
5ijzISX+pd3YinnS+l/8ldSAgrxGgMX//0UZ/zYkvb1CkIe64oA5dOdb9M+Li/x+\
bR7xg0Wk57yAddNC7qdvSHI6RydJJvxFvz6R5MPZRnweQLGY/\
16SpDvohyDLCfpjOH5k4JXl/3cBP/\
rHIdlU4yBxcrkAifutJJhSDFCEPhpFQA2IqAWjsRdqKP642YdogT8rKvO5F6AK7zgkl37m\
KLSz+CPe27Hvq1YP+V6Ek4xrdZIX3q9SdP4U0J2aTJGKSg84z00U0vr+\
W3jPljFk3UBC7s69o31LAVOZ85BKBv/il+pECWnPBda5v50ksDN9JMkImNU0myHnwwq8x/\
Aw5s8PyDbV/k7cZxhFDW4lJKQmVU8BIVPEZl+\
TpAvGCFiwJiAVP8VN1s1FyEZNuos8dxxFD8Hb8CTr+\
yM65u0CrKyeAX7TRxE7NlM85ttwzuVq0Fz229ddeZ/skrSZPoZ2/AsoRnmQ+OjRnN+\
9tyS1dTySUPot50TTYTLnjndVWScNctDe3GNYF/\
vTyb4HSZrrghiD6veD5PAOIfXbMkH8TgExRMR/MjP/oR+jAf43r2+\
LvRWwyXOKym3YX7zHccjtvViA1Uxs7L5tv4/3OoSIixePYg3XBtCCN7884zznD9Z/\
OkmK5gZU55votC/eWuzpduxT8LI+z+uHP2O+\
Q7oaZMfe6XkkYczk05xnVpYjXjBQSPknRWB+Fn7KfGsJCFIFL7nPeta/lzwb/\
XAH0I3qdIP5178W45wAEI1tW4f12XgL4zCQIKzrw77mtaZo078QGdDQE/YdL+\
51xruWiJtcqy3JfOaZnRyeeXaWJKcrCtmdGn2T55Yjya0afsXevsSuqOzYYbfiC+\
t7yRixtwd5v8cUM+gm+KN2XSHW90tAq94/gPH0z4CIgpOsA3cbEgL/2zr647PsJ/\
chB9WDBnNOSw0pqcpMMY2qkYD73qcISGspNi0IGalO94r2RAOEaXsL2erbb4znDPrf5ZW4\
0vvM7MPXsjEv2nOeMvOwv6oIYFy/FPuePgipqy75C89XFIebkuxzun1i+\
qUG8RzvQRH2idpStFJzL+NzBNEcu/YJ6ykS/\
WEOSFymWwnuNxzwjXv7Xc5JgPvdcOKWXrhq+OmZJZm+\
6zP9daE0zx8JWZmXaRHj4L8TOxONdm0ezn0rEg/RzUiGqgWL2L+\
Px2Zcm1Hk4GWHzEx1lCK9NnKu6EacwXuXhnXUl/O3+ziO90gnZGrlOd9547Ly+\
5W8t1uYCzsyNAPFHR03QG4zFTC9KUnRRVAvDuO9DnCKqYFf401oxjweTfzIjaGoxtzDzng\
x8RtdO0SJ7OwBzK/\
qrYhPHhnGfGlKct9Y9q9ggyS5p1xgvbgazIsn2DvzQsi4z15iPj0qw3hmmkh/\
PmiBX9G2Mus5fXLsxqNksr8AqlZzKDb2SiKC7L+\
k6CxoB9mFGy8g5G3EHfQhSDTsM5JDbjugFdt1M8/tto7+3puFuPPDkditUkK2Ox6yFe/\
ZINbNVIqo3Tz5+7ZM4u9wfvTicm7wS+\
Smnw6R1FOpKU6067NzrrkBaa9fWEgfDMWF6oSQt+TbwPOqiXhgwrYU38QG/OLXgyzA/+\
TYT/cOoX/GQQ5ollWm3z4BqvF/5vznPeScGTRm3QZpKbbRBxCJ9Xf34r2nEcdTuYhL+\
Xk5B3mlsReqAfFbNVP8HJWSdT9fSJL3EC/\
U4UvynHYjGNeFFCn6ywCTqOHpmbdvBPyVCVCkeQM4018AubiJJsX9pykW8n6l+\
EBFE9L0Rvt43/6c093Lc8y7RLK/\
bBKQe2QpLp8OWMIlf8577rrNeD1ugH1IGJ54TrGvzMOsNVmvy8RvmfCW53/BH/\
Sai7jpRkj/VDKKsPzZFMn6tRfy3BKQCLm2gOBtLyn+aUWxuyq8lP5P35hxuVKG/\
j7dj3HsAmjPOwO5jQ43GVB5SYrrgnuIswXNIFNQw6bQ/gorOc8m4X3cEsAELh9k7jYJ/\
qnzAEH6ZxD3M3U4v+uq+K127O/sd7tScx5akpFzSpLoch5KSD/+K/\
vJkCXiz52X4oi27AfNTtFve6To6RdEgVzSPfTvPexMcLYf5+Uht4nLjSD+\
EDwENKGrS5HFeCkK6i1FAPMhtbWJ2N/NPYrC/\
KX453pGA9ZjaoqqTTbIHvVLQPbeQ8gy3Xmxy7vIwwQbBTxo2M/snzfxL/\
KUlHnRjefP4bxtk5Gn8Wqmwi4sp73msIA6FlOsG9zgfqoV9slcG8j+OkrAF/HJn/\
mRRcxhvdjREhShBLdIAut+gBX0a8RWg+2A4lx3isFsD+yl93MK+\
T3zxa0Sse9BQmr9ELJLs5niVD8cn+\
1aIb8YzXnMXmK96WTJZL6sZP7cZf8N0kle7QXJfjV8H/O4Snver8Vm3rcT+\
6iJG5v585x9xdYTUu/\
YIlIXJzKg1mVCWrX7I9dpIopaDXC4Hy4F4xhvEteNxPHcW0A69jHkqv5BQHymX1H2ucHxy\
QutBSRja1TBD6m+kXZkQPzKa0ucLajan9+vqi5xIOaJzo54lz7B/m7TriF+\
XZ28pyolxdsZiae6ZxX4fcq8xOFm1aPfkq3jfJ+6LvO+CaTP5hzr1GuUhHk8lOIvN+\
Uh75dD/NQvxBlMAfyS4IaI7q2G/MA12c3zp0GuGrTiHOoPwI/2oyDiG+zEH/\
LjCdg1OeBpL3Ix+r86ZAl+1KLMu0unef/75Clsb0Qr/\
bq3sFMPAKMH1SDbsX9B0uUNgETelVhLMcX9lHxvcT5pB8X6xklR6iVIj039phTPbGD/\
tPsQpbTnrjF/\
t8p5aRTga9VOyG7XQo5v13LOV3kqMe8vQ7JgEop4SHbO4d571qsLD1m3mU88Ro2kGNLLRH\
7BTyb5yoScf9wXwPHBTvwFrz7iIG4G/ekfTYVdWbyC+VRb/\
PNnCRmn3Jzrg6QUe5plvemPktijIBd2Vo84wrweBEmZl5w4kH0l55XL+J1+\
5S6su6OcQ1QS8r5e/UXY0Ri1aU9T4jX+3xLPiiL797EMzPNps3nPKVPZX55nZv/\
8QnGJa4U/ZyunIU5XMoy/71/Cc9rGoV9HM4/dLeIW3pHxtO+nv7n+goii9yoi/\
XlB8ArTGtD/Xn7a83gd/8/N+cDUJf/idWxCu5r2lHin+JUjz/P9taxTfZNzn/\
8D0LMtimi0r4iHBGvwb92dQfR/BIpbVA/8Z9MUkg8VnmJivzZ5UPuA+ElQfxfxhMPrOS/\
Gmcz+Nhowrv5OnsI1A+StOkegvRX5vR4hYKJF+JX2GCBIlxARnCAL81+VJi+ooyHSoV/\
42JMaUfk8GfC4+14fP/kkxcamC0VYphj7p+sJaN+0yM/71+\
stfhVFIf5yQM16MvuXrkh83XrE0dQJxP1MQ8h41aT5FPuu7i2kd9ihYJOIb94QkojbFIu4\
MMQr3UvI971omvlS6wzzsBvnCv8ZeSbVn/Xh78XP9SeSB/JfZ+J3OX/\
GLpQ7xPiNZR8xm4nTmJkleK84gBx1Qtkv3vM784BiNz8tRX3eEMhwTELsoP+/4vnSFC+\
6BpDd+Zk97OQ7/EXbkvyYmUTRrVkDmZOfnnlsr3I1VZ/ib/30Gv/\
5e3PWT9ce7CdzBbyUDjCydxzxEi/\
jHsbjOnE6c5N57l8R0s22kFy4xZCGB5mElOtjFCkuhJTKt+\
v53F1Ab5ZiL5uHeF8wuxrPrQnI1h34jXV54Q3tjSTiSBHxX01awK/\
qDv6bKibrO9oCiTedZX4NT814lWU+\
u7IUo9tsnAd0LPwGvxPxaxf7y3nmT1zAZpfIf5lTkLB4uyT/MExIDjzx0/veY/\
6fofhbPYvLOiwJ+F8fAK/\
hVSdOZxsgdm0rENdxt67Qr9HDpAiBIjeTGnttW1CM6F1Iw7w4R/GB+\
xPxJ1VVRJynOv6eUkQ+N0mx9ElA46on5zTX9Dt572TET3QYfqKbRlzWJCZ+\
qxsxj1VHRE3tPM3fO/dgH4osopXNsBPut4HM+8tbsb+\
5KXbVZSnGCDJT5OQNwz7rhICp9QdIDvQ/Inq1fijrObUUE6auzn3n45+oEr+\
xHpf9y3ypOUniK4h92eGA500/QPIuNyJPJjF+mBkr+8AYOWdOwt6r6sOw89nY/1wh/\
AW9C7Icmz0t43w9A/\
1ZT0Q4x46Qecj7uREHuW99xKaD5nGI58VoSbvfUPyjikDWohdzjnHjAP/bxMQx/\
UaQ2Ll9HnboCMVrKhU4Ip2N4hjXAvyJ7VKe99gjearamXl+Icnn5btG3irfdPzBEhWIs/\
atAk5g0TP219fsV2YpxWNBxBLkt39Iked2QI8qo4hJHWEfDvYwXt45ihZMDsiR1Pr9Umwl\
pDgJReT7H/adIHsq2lWyA/iY1ecoSvgzFetyy0je81JC7OdOSEz8wpBK+DuJ97psiJ+\
bTz6f+5JXCCZDQuLKTaG/u1Icq2dALhoM49ziVZH46D0pApyNndVjKWJUcelnt+\
kfzpFbmrB+j4ZjXPfN5f32Q96mZ6/CLxyJX+\
bnpfhRRQeXo8c0kf3tEvO2FkW43m3ISoOdJXnPlrOxa5Mpugnqyn5yS0hh3hI3dfkW875h\
xAGCphQpuK2QQLvvkL6oDojnmMiMQ1BtLv0Vl2I9t+e05OleYpcmAGbXubD/\
psxk5nNT8FT+wRn8/VjfEP7SG09Rg6si8y7rSNqRDDvml6Ad/rKe/P0Y+\
QRTmDiLl4A8gO6DmJl6zb4UbOScE7SlmNe+IP6gfjkh59zKjMvjEszjcuTNvM6se/\
WxBv3ck6tJQ75WPZTzWR/y/TqdkB+mId4TRMjHvFhFXtiftIJrNvLnfuuPsp9LHixuE/\
qtR1biGmUED3YHf9NkAU+\
pMhMfD1IK2Wxf4tY60TX2u2vEcc1nyct8JG6kLooIXEHiT6bIQOIoM8ln+\
hspRnKjyNfqlogvm/QLGe8/IEs2iSIR961bic+fd3I+\
rgjJmBsKOUzwBDEkrzFk1yoe8UaziCIvd4pztvlVcKAXv/OeV8h/\
utXgGvyDQn6SHj9dbWWfVhPI2wVxKD7wbws+URdn37xAkZuZ2wA7dBWcp8pHcZD+\
nbh50IQiLn+g4PDeecyn9hKv/TKU+dBViotPU3Tnt+1E+6tDBuYNETLSA8Sv/\
QQNuFaVOPs5xMZMCfJKqkg8+uEgRX1+GvGT7vbivd7VJW7xpA733QP+\
Vv9lWJePEfdUqYh3mX8Ql9fvKLb1fuOc4PWlKErF+ET/xngpRWkiGlUZO+JN+\
of1XfwN82kCRbR2N3gQ7xDnetOQ/L1KSn5cpWD/dXGusp80H4jdaX2d/iwbn/\
aehRzVrLjAPImIiJcrAsmIjgteIojFevAWge8xiv3Clqe4z+\
s2RIrEEC0P0n9gHj7JBqlFfPwd8/VP1scVikttY/LuLr4URV/\
ivGEjcG4I5kqeIMxnPOvs5/th+JPB4O3gxDsRr/cLvAQf1a8Y+87rvPidBYnHedHxI+\
xfck69VZB5VzIK82Exz1Mf+2PvD0IGZzbUIO5wQUjfs+\
SQOCrFXX5VyEf0yhRCFoVYvOlRiPe6cUT2W+avLgx+QlnIHLxhxP+\
8HBTvqLmMpw1HUaTXHxE9vc+w/71KzHNq4F+61eGws3+Aow26XgQ/\
VwH8sFe9Ev3XF3yOugn+VHUgP2yf1MAexEY8zd9fQ/\
xPSBnMMLGvLSmGNAPxR4P4xFVcA869/nLO2WoLeUH/SBj9+\
52iduuBS9AdNoDzU1dC46djbmC8slwFd503HH9vVgx87gnIv4K0T7ivuSZ5JIrwdYvREvc\
oLvuq4CjfUkQTLKGox075ynl3RQvxe4SsYjbnF/8VOCW9nHylnxZRpuAUeebgGMV4/\
oGs9McZyUtMkaLZc+C/zfB2zLtt4Oi9oRVo/+\
p3zLNavI9fNSL2YgD1Ge49eUj7jriBaSf2MNMO7EFywauNqUK7Isdm/D9SnK4tpMgqd0Z+\
H0PI51tTL2A09s3fjziRHck+o26T33FFS2GfG28F33CJde5FPUD769Hv/\
krsSNBtEvt07mnYsQXgJP3Y+NGuSSw+5xEc/CPOE+4wdQd25y+CfzpOO4pyTvc+\
fWc9pBRc8NT49GMOKUKrjQit6QxO3KVsRzFR3JP4nXs5B+\
pWMyRvyj7uCjYVP5j15sdCdNOUhswyOAe5qkrQVdbNYe4T4wM4j2IUTXkR2ZdceciI1WTO\
K/pPISdtyLo3W4TUoQv+hj5dg3bcEPHnKuDrXJW0EmdKTz8uekG/\
5gHX4PfMKPHwwpz31uVkvUyvSRwrL/uYOsl5XaVDxMv06i/\
vB07LDgIv6leWuN0tIeleDl7dju7AfHyNHx5kbol9i0m8SZUfLUWyiKwFRUW09Ai4OVW6k\
eTTvjH/nghufXBj/KCm4D7sygb8fzD7ftCR+e52dmSdXYJU1j+\
FWIX7PRHvkV2K8DuJqGIjyM1dGdoV5MTvd8skzxybfJeqSX7aL0X8xZaXuHNqyPGDNRPYp\
zJXF5GLZiJydyxEduwyOsSnShWABHl+\
DUSDdDhElOa9Rwxo8QVEbqLkQYzmynPEbkr0QYyo1W7EcprLteAZxIIS9EL0puxqRH9GFk\
IcqJOHuFH86O9C99veH3Eff2hIrF2PGxkSb7fv5n1lXjz9EWrH9l/C6/9+d+\
BbSFzeP2xDovNu4rOY/129/HdC4vTBwzYhEXvz+z8hUXsT55eQyL23vVGS0P9/\
aR26uklHQ3+3le6Evud/y5Xgv6uONPCn0Pc79Od+qeIhdt+\
rASL3pXeGxOx1uBOh9ugRD0Ii9fZFp5BIvXtbLdRuu3zgZ+zOR96vUjPe9+\
4voaur8FNIzMicGkC/RX5Ifx+rzOcDdRCTGiuf/0CkS+0pRf+\
WDA9pdbsFiG7lDguNpx7WGFGgL1Mgjb7VClJQO4f4pIsOWebejOyPm1sx31JCSqp2bebzN\
Ej47WYhq20ICYbbih/pioMXdE8Ro9XPROy0kpAWVSYOESRahr1KjCimqkcRszcc/\
1r3ApcU/IYIn/sDEkFz5gfrdAckUuoRdRj2FDgZ20TO++vIw/mNiZObnMS37F/\
kGfxmnKu9KJzX3PquxBeSlccuDMpN/\
PEWcWSv53TseDzNvrwTUgo3A1ym3oq9C6Juxr58lmLwXn3xd8O1w54lGY0/FLcq6/\
YgeHp/Wwr2/5+rcZ+f8xFfuDkN+\
9n7LHbw6KBQEaZZdp16rt4DiTfcFP80MaTQal1G7MALcNv2PnULOjn1HnrJN97vfBTsRtH\
z2PmIkDKbRhQf6x7Um3kNRRSoVxf6p+Ibvle8Ev5wu7ac54Lf8Ac2ILKtrtUBJ/y6GM/\
L2VrOy+Tzg3AzeW4ucLG2DHEk11NE0QuAyzA3UrNfRRFyxQGdsGszRLy9AuKEOsoK3qftc\
8k7/MT9pnIuU5chx9F39/AeP5h/9rycN58G+IUX+Z45sYZ8xc/HiTt9mMV7SLwriAq+\
UNXawvczcE4LnpD38rLcIi57dSX1U7H64af9RB2inUxdodr/\
hHqavILXjCP4wjHbGYdbnKO9PHN439/A76tao/CTRkAW7Q/\
qzDq8Mpd1uB5SdJ0J0QJ9GrEY85X6KPXyFe2MV5n3bLJf4n5dad8NqbdZw7xRx4Yzv1Pg3\
+lhxIPtP+StVGRIvfw3guNYx75qV9H/\
drr4h9khJTFrqccxFyjqN3shUwheEk8J9Bv8tZiP+N45ERUaIni/\
TIjxus4ULXvvllPkvvxRyK92EYZRtF30E/\
Ow4wDWy7z3jGewhnX3IDvfq9ec7319QxH15qOM1yDynMG4g/Sf/57+XMI5LUg4j/m1Ny/\
F4RvWUed6Mil1eTcgxfGng9fQC8FfBf+\
CC1BnStFvdZ9hN5ZDQuniCYna6qUSpwBvEiSBPEd1Jq7gVYHsJdj+\
jTxb7lf4cavwI3W4QviPq+KSZz/6knrDR89C76lmS93vy3Yhu+K9zcZ9im7G3+\
ycnfG6DKlCkH4Q63X3cMZtJ3hZN17qB3IgLmKK/s19u/dlXJpfpB1/ER934Q/\
Tj4WwJ659WeoXJ0v9cinWi7eQeg4vJ3Vgxkn8dBZkaKY8eFCzOAr93EXi9+\
moE1aHOfeqnZAj2NeHsFOd2L+8LZY4wkTEl/xDxBFcHeK4ps9mzlUfGjOvKl0i/jwcPLE/\
jHzD/0QJ7MUkkG3k2E//L53KPNtGvNHvXibUz6bljNBV1+oRuroDezjnp2uAfY/\
djN9dJo5j5oCz9T3FubJ6a8Zpp5BgbYB0wnWk3lgn6ibnGOJT6h15eXXoIfm0fiPA/\
X0lPho8BGetd+ehH/9+zfgH0u574RjPFeG5/96oXNtPYpzGzaR+\
NMUm3rvR0tA60FefhN4nWPOJefCsKfvhlKrEPecmYb0tb8W5OMoMSAZu0+/\
e0IGQRQRTQ2QQZsFQ+u3MQsiePs5jHpd4TnxkQhPWeZ2WkDQsnMP6Lt+av1+Uc1leIR/\
Usg+XIT9ufpBvD7JBJuQVHka/34CsIfi7Fuel1rWwm+VP0o/eKO5ffQzfi36Vcd36C/\
v2rbahq2e3hP5uV4KvC9anxC/6V8SCVlHnYtsKviYB+\
5jJDz5d9aJeyGalzsUO41yuekMe4UqC07fDqQ9yS9ZKffpf/L9Fbc53Tupw/\
qKOxrxYwPg2IY9ipkPOZUed5P1/a8J4/UW+yJWCNEX/y/\
nY7RQcUwLynu60kKr9w34X3LhDf/5ozX4X+\
zLtWFwhND5BiiIh0g9VfUbo6hlIObz4W7BbbXLIeXE//XZuFfbvcjfanasz63TCLOJDe6h\
X9SL8zjzM8xf2Jw92Oeh3lv4sQr7ZhHvC+9WmDtjMwC/5/\
3MLdq7hZ9ZnbcFXNNmOXbnWnPc4n4j368C+pYb1p90PRkM28pTn6fiQlQSbIIcLsoC/\
skUb8rxn8D0EKZNznzRyXr7YR+rGwUXpQ+\
Np55d8rKctFYkLlLmOv9ge3Ko7mFnwCiISkFZIlgoKSdC9CfRnCfxre3UjzzuRj/\
unJj6uGuKHeXPB0boh1OGonbTH75iCdh8Dr2EjJ6NfaqZgHTamfl7HI2/rHYdnw6s8k36/\
i31Wg6uwrm90xE4u2Mn/JyPy4NZI3qM2JJhmHPwTKiv1+\
8Gbjdj598Sbdc3axHk2RaAddcJjn1PLvB1cSn5PnYZ7g1/i1XrJfd4IuVI/8Cn+\
NPC3XvzSfG8fOCDzgDiF++UK9i5VJ+bx2ljYgQT1WPdfo0KqUvwQ++2M1sL/\
Qf2yXiZ1Q0fwy00ZyHWCXxmHoCjjZWdByu1icf63T4X0a9wLxuMm+\
HuXgPo93Zt91osGbtt2i8g87ImfYBodwc4Oac96HPAs1D5VBXKxoFZlxvsY/\
CaeP4N1Vus21wIJJK/WUHAxiI3bDz14/hziIyYCOKDg326890jmq9o8g+duG0s79+\
GX27AckjenTloNwz9w4eSc15o8iI0qpPiPHmCHhxbC756Zin4vBr+\
C7k2cyt0FN66PIuqgxiD+aq6Aa3ZtIYd2j8FtepVqcn5rt499ZmUizj2pa7GOt3/\
EvhjZZzonYL2uWMt+\
3Zp8kEsUmXmZ5ybnvDJ1pD2y7pdlZB4Uwt670Y9YNy13so5HgrP2Igm/wbUMtK9pf+\
679iLr6tNO/r4fURk7Xc6JzyH1ciPBf7jknCPUY+H7SNsYe1ilBXb1ykrs/+\
HEzCu1jvvnoD7MpkqPnS1Zn98tZrztgu3sS4/JD5mznP9UI/\
DAXip4C1T87NjHK52YD0ngqbBrsL/B4z6s61fkZ9zW2tjFRE/5/Yt77BMRp/\
H7LuDHjZJ69QWv8Yt+DIJkqpzFXq5lHvpZqZcxlR8zfw4K6fBiwR1nFrxCtLHin3SlX+\
omEXzdAexWCSGzmiT8M8nF70squLfcWRnfOJI/GABu0A83S/\
yxNvTrZOyzTgtexa80h3FN/EzOT+xTJiwX77u7Pf5ozfw8r85Rzt+\
rr9Pemh7rK3YO9sGKy/GvthL38DZslvlwkfdvnJzxmQ9eX9UGX+G1l/F7J/XsXyBl82e+\
p93b8vKef+Xnvd5voN25BM8flXoqMxpyQTsXPIC+wrnXPKS+XHcDr+X+\
ETL9r9RxuOzgBM3GPVIXnY377wYXps9twi8bA+mdeh9P+\
rkW7zeuDOv3Efu031pIC7NCzu5lIH5i8qWkvalYV/YyfAD6yw3GNcznfTdInV93qfM/\
yjzSHdhX9DNIwMwO4UVaz7ryws3GLhTaR3vybSbO00FwAN3ysZ4uj2MdVAcnHiSoRb8lY9\
81U+G98tL3Yv6Fx68NloCT9CLn5T2+\
CwnlpTWMVwr8Fl0NHKztPAm70rKX4Dll3u2JLHjWlLzHbuaziU2cR6c9wDrqg90wYwZi/\
1bMkPpxzkPeuE8Sp0cMVfeTfN5GcPj+LPgsvEhSd5nzJv3XJwP25Nxg1rn/\
jOc1Yx65TcLzUOs2ebSrF7Hv61IzvxfAo2W6sv7MReo0zJnj9Nsz8OyqM/Wy+\
iJ2WDenzl61R3TXn9pT4mljZN5D0u7NIO8YfJX6vUMJBOf2nM9RyGfbRuRTzUjyd7rKJOb\
pk3e06/o/zItW1E8FX6iz974zn1w9cAn+FnhA9Jc5tP+58FDEgyTf/\
Ew9kGpAPlwfhDfAj08+zGYVPLgl7qD7Yj+DWRNZtxeF9D8xedxgsvCKvfAY93w3OP/+\
TrzSRgdPqzZL3v8vSP79a6mI314Fl2eukIc2j1vQzqdSF56K+k1bWXAxi5mftg58Ir6NS/\
80g9dHjSKOYfvkwL6F7aMfA3io1AfycO4p7+/FFzLvVcIH8FMD8YeoD3e1wCXYBYK32IX/\
6qd/S79ckPjyNMhz9aoB+C19wZ2ZQjV5j8jE2/\
RmcAZeUqlj6SnnhnxP8BeWdcVvetWL9r0nL+v6w0OjyhVjPZYCZ2U/\
Icri9UPsyiSnvssexx+yeQzra0tbnrf+Ks/\
rN17iJyKiHP0n9oeDkOHqzUVoZ4XsjFMSREN0SxE3mnuG/W3ySq6XmnG/h4J/\
TCLidBtETHoT8RVTlbpyEw2x1GCU8HjsEvHcQUulbgISXT2ZuGFQhvi0ylGc/\
eAmom8q1wver3sfxikf+\
4x7wbnYFWLf8OJInjJ3JuzqKCEDF7Lc4PNu1l12cGPBbXBAJhJ+\
iM3Peds7c13y5NSlO6kPDQrcwh/PDM7I+5FG7CTxUf82+4Q+\
LLx1zwXX1FFwkv9CrhtsEB6jHpK/2Ef8UiU/QzuGQULsXQjH/vawPPY/\
EmTtTsn5MkVf7NwY1oV+Dqmwy1BVcMcrmL9/xMGu7IWvwoyHD8l/vI12Z3mBv92yI/\
tabeE1GI2Iuy6cg34pBAmu3lBG4rjwY/h7yMebDYi3KRFT8odRr6qbX+PavZnMlz/\
53WXxrzdClut1Au/\
rDpJPtkOpQzNpwPPqweCKvRZi14oQX1J90zEftkMe7lWCND4YMw982yipi8nZQfC59/n+\
DuI+QXOpi9iLCIcv+5NtPYQ61EaIVpkM8DfYPSLSMIL91P0rIlT/SN2f3C+\
4KKTcieVcuxxeKVMGkQUVYxv3u0v+SHUj/mubMO/1kRnMu+/SnnSIBpu8+EXmI/jMQN/A/\
0zeGjt9TnhBkom9D4hjqtvCT1EKe6Z3wCPlVScP5RcUnODf1Iuo5bnYZ5sKr2KsR/\
TfYcGjRKYeUUUA/\
6jDEIO1QxB18ZIi1mOXCg58uODTNsl8yTGLdXAPPLu3g3F2XRHjNFZwS4OEx6s//WwjgC+\
0KU8zD7MTR1EDOPd7DwVXVIy8kr60in74eR/zbDd1F/+rt9C7RfzuNuditfsK67T2P4x/\
PXiKggce399D/l6XoP7J1Rcy7tn4w6os/I1qM/hBu0/IVe9TP+\
KuQu5vIg4DZ1XoJHVcS0Uk7Qh2xaWlzjDoKnxKHv6VzXiL5905xvdPj+\
B9miHW4D9kX3f7BR+zEjGQ4ADiWH4MRNyDvOwvZiTnKV2S/\
GsQFbtuOuMnmF7sN14XEUl6RF2Wbkr9od+SfFNwR553GtyCa0QduekI/\
ia4RX2G35NzjR3Yjfstpz5WXxFRsZ+m8B6PwI96ReDVMQWExyxzDPo/pdS9TIT/\
wk8MzsPVhf/CvAaPbI9RF+rvhucjaAsJvCv5B+fBjbGJAyadjF0pRP2qq4MYj0l+\
H7uYED4iXV5Ewn5A/uy1hRzdVaFewv4BztrOAZ9vEsKfYe7EAI86CvEq//k91seFe/\
w96Qjy3JGoh/AEv+rSIqJqGpam/75Sh2B6i9hfvAxcb7Bf+ePYP/3z1O+pF+Qz1L/\
gS2wYdUjekGXk/0chKutfq0/dYX3E+PyNiJn7xe8ikj3RC+\
EI1CnEUU0aRGP9pFfYz5c0FxHvaIinJu0YwhkEP6aBK5iZCZH4TAdCOITgbgPuN3cReJMz\
qcArHN0Sugbl+gq+JG0IDxGUOgROImwLOIm1DUP4Cb2vwIfQ/5vOCV111zWhq+\
eXC11tnB2h7/kR74buo/LeDuFO9Jq/uH/\
CzaGrrt4z9HeT7gU4lrn7Qu03iYaE2m12WnDHky4g3t2vHv2WOIz1G2Mc4rxX/\
6VfG75GBLp6nNB91Ipj3GfZG/CN9WaICDOioF60pog/fnbcP9JL+\
i3FcMar6XbGIyJ1m37tJOCv/pnJ/dpEBtdxZA3j84n6GhdlDLif/\
ZFp75mW3C9Gau6fqBHiuCnPMP9aThb7jJiVShywPjsgCqwig580FeGFsKcf8J5JWnO/\
qdHZp6YJb04S4k/BAsHVvX4h+Hnmt79IcJW/wF/nBiFWZB70x+\
5mL4q9egUvno4Fz1AwF3yD3QCuW/\
XjPt7YT3zvLvUTQeVHUucOD4XXGby2GvgHfpWXnnNjqvT458ezc97NwD6q366lPbPAz/\
rtqRM1yeGp9cOJWFl1zocqI7hr+w68ZjCzO8+9gKiSNxpxRRsTHhV75y77Rawr+\
FdFG2NvdpynPfPgmw5O4SepWfBouO8jsR/5hcdkKDgBm+kUfuPJpdifZfAjujHUsXoV+\
5AfGTeVeFBv6m501FacRz6Sx3av2c90BfCb+itxSXOe/J9OI/yjr6h7M2PZP/\
zsiKYpn3oHJ7wwQYbyrIu/\
xzHf84oYRWv4XXWczRJPhifO648oiptAfsmMom5FfcAv8tNQDx7kRmRBlUGUzi8kdQ7J/\
xcnBw9q8w4H59Z7o8xnETX7PSVxmRrhOWemJ36tK1IPbmvAAxbUQ/Q6+\
GUC83JXNBlXRAf9LjnZL+4hXqLd//iY4NXxhQfUtpXPrRCRDmIgAhdMJA/\
uvmVn//rmJA5CnZkqidi2u14ef6maiDr824zvbxkveZlv+L31p0m+nPxsUP4e/boL0V/\
3QMR/usA7ofqAowleLWJ+dYvJOL3uzO/XsR68ZJ3phwOnWAfxxI/s/4J5+z4m+/\
GC1IxTStm/WxFH1JHYn7yfXzE/qnD1euK3u/4fsE+r62JvHlAHFyQRUd6z81k/uwZy/\
7A8/H4dYjV+OMmH5heejNGIvZjB8GTaMc2xT1MTYR8iIVbrGoBv9fs3knO24Ly7/\
M37xpI6gLicq20l6k/dw2i895fOkgcSEdrdcn7v2I/Pr8GzeQnhDzBX0rB+\
R9NPNtjEtRP19kEPcDuuGv6XSyv8fr+C41GxOvC9KuXZ1z3mk1qO3fSfsN97+\
XOC84yI6LmOOp7+7fxO9nv8AK9a49D+YV9UDdnzIHkL9pGnG9jX4t6iTrb1d/\
CjqeAjcEniMi/WdJM6IPgLXNqN3Lf2r6H76eaF+LxrHs/vInwW2arQzl/g3w02UE+\
o7yO65f3Uh/2u7CvaPwWRNfVExM16rCTu35v6QDNoPuN9SPDYa8lj62/\
wpbke8Nd4BZZJHg+/PChB3aIuP4z/PxUxpOLxaO+GVvgvEeLBP5VtN/\
0yjvmk5w1nfuZE9MpE5ZzsavzNeuhPHE8dJQ6on8CbF2wUPq2E5PP169z8/+\
h05kdj4RvKTx2FF0j+KPUF7jdH8vS9OIeZ+6uZv2m7835Va/I+Dt4rLwyeSTeeeKe/\
hfOcVxfeKr+n4PRPIJ4VKPYVk0LwWo9EpG+\
SiA5lb0qcbgznUDWYev6g5Vrhg0ZUzu0TftAL4Lvcfepu/\
K8p6IctEvftA09DsJI6BFUCkSaXFx4wmwvRPZMwD/OiL/X29p8ktO9peuL6j0TMuecQ+\
jM8PBxB5p/xO1rvZN69wl/wysODY6dQD+IHEbEHW+GD8PuMod1V09DvsUZLPBB+\
GrsGPzwYhx1VKaSuPi08Od5F8LT+xHb4TSeEZy3fR+7/BN5tc+\
NX9v3eyZg3j7Px3LbUk9h+\
1AcG5Tk3B2Hn2b8OkbcyNckL2luce1V49gm3iPhUsBt9CD2aeepfmkB7r2Nfg2vgdO1k4W\
/ORzxIn4VXw7+DXTQt2d+9NdQ5qI87GJ8VybBLLThf+7Pxd/zkL7H3WcWvSkfe1n6E/\
9htEZHhN8I3WvwA107wyLtVYYIvqCX5cep3/bf9mAcTyQ+ZjNRX2J/wY3Qn1onNQf2K/\
tCb9swVcbsKW4gbDBCxIE1dvnq1mf9Phx9Gt5a6+\
3vn5JyHmGtQivWqdjylfwvAW2fWUFccZIbfK3iEv6sztsNefO6CHQ0/\
iX3uNnwNQVCS5z8Hf+BP/cp9phC/ciMQ6/\
bXgqv2n0u8OLqIyx0UPpbm4CHVUhGXs4h6ea86ES9ZmJLx+049VXC6g+D14DN2KySOVRM/\
Rg3Er9JpwYXoSJKnPyV5x0KRmb/\
Tqcfxwot49z70FdyzS8SlJ9wnz3sUvl9vKbgR25Xzt0smPNcP73Lduoz+nRbweT5+\
je4Hr66KfoN1dfEC6ywc4mP+b8J3dfsm7YrWlnE+\
JKJm24XHpgd8Ef527IU3LBrX3S957wIiBj+aeai2ID6o8lZhPr69znvFJI/\
vJZa8YTfwC0EF7KH/BVFdFYk6c/9gKezN/cvMo+ubeI9mcdmXwyVknlShXktPF7/\
rJP6Q5+HPuS3kn1USqa8pLnX4ZeClU4OF7zWe8DcMYH9zubvw3tfhh1LbEBPV3cXfyjiC9\
bUKEWy37hbzZdo8+qf7Bu4zZCZ2Ls5Urgueyv+Fr20J+Sf7C3U35paIfVYSu/pVeBEU+\
5MtB27YBOw39vpb+uVzW86zzePhd4Rh37y+Q8jDTIrIea4WfrOXGD4yu574WDD0BOvwJ+\
r0TBl0YvyP5OvNdfAttg3xS7sInnJdBH/DG4iYujedeKlKlZHnTaxLXqwq/BKmSV5+\
14w8U1B/ucTRwJf6zbC79u18rp0lDxEnE+\
syJ3Fybwr5dr2YOK7aRxzeVZM64DoyLxaA13SVEE/zZ+\
Xkc1Phwa8DDt3fdpbfNQJ3q7XwSqdewzy8N5bxOye47jWyX8fE3/Xz5+\
f92hfi74fhk7Zz4Gvwd8m5eA1xXT+y5JX+IK/ld0Q83Z4twj48rZaIw8NPazPhL+\
nb9L//Bb4uN4F8tBY9GpVY8CfRKzLOp4tI/Fn86BPtJJ5wlX7rd5R137KhnFelvrkzYr/+\
C87Z3mny8G4mukw6B/\
Fw20v4IgYjkucP3SPnceKtLoeIx31pyTwaJzjCsvhtejl5J3OEfdtWRMTPXSwCzipCe3Bh\
E9uQ738o/OpjlovfJ2KdD6hTV2WE/3EePKJeTMGtFRW+\
owvU0bmNkid5KLzneSUPOg08n4tSALxs1y3Y8eTwO5tMgiusUon+iydx98ib6L+\
o0eiHgsRh/SvgTl0xqcdL7bCPvQ/LOAoPRV/2KZWP+mtr4RNTM4X3IXkt5uFPkj+PAu+\
cekdeRp+FFyjYKryOM3k/9S4XdkUL/\
jfmcPDKPTV54ueC101RjPdIQtzUfy3nwgvsb6YqfL/eAM5/rieijN4i8aM6sZ95v8bnPr+\
y31l/Cri3y+wz6qDwqj4nHqC7i/hxEtaJ2UAdjXdE6j7TEe9XBeBHNh3QgdEXwVfpB+\
BKbNfu4ifBc+FHl/m1pTr9J3wa/hDOx95l4svBj3nYv7ffWAd1enO/PeT/\
vASiJzIAHTPdl3iJ6wCPuTeO/K53i/O+mwdvltouvFeG/ISuRl2Deyq8QSOoH/EKW+\
b9CPIEKrvoWN07JvtqFvonD7glP/s67OnsSPTTOfxXMxo9rqDyaUTo/r3EOv0Nu6+\
ijef33dArCLpK/KghdZOmDPy4ujR1NO4NOl0u4y3s+EH8G5eDdWe7cB+\
bsSfjGxNeQnVhI+1ugD+pUqBbZJ6uZvyTo6NjyoP3UcXgv/bvNxOxRxEZ/\
kFdp2kNz5zNL3at8jn28823GK82T4m3ZQH36JXax/\
o18ATbItQxe3vA27g84D29jZwn3clRrNtG1DH5SckPm+ea8+QK6nz1M3iI/YVPmFejZjO+\
C+V+X+th58pbeX/OWeoL+\
5Zdhb9t1ggv7jdwzC4OfpDac5BxaUAc2B4V0WgND6ONAW7Abyu8D01kH5jTlH5qTr2BXQ+\
Pnl06QNYTfCKqn/DtxEHEWt/9m/7ujMi9fxt8gT/nd7Gj1K2r5Zy31J/\
CTxcGv0MQbwT3CaRueDF5c68I9QDBgXH03z3yQLo/\
ouO6DO119fi9WwxezC57xr4QJvv9THAjrhx1/N6Yr/R7W+FPjT+c+Vx3K/\
fdStxS9UAc1a8dUewC8QBzIRbtSA8uLjhEvYwZxO+D9ehkqf1tef9N4NPNNvC/\
akh15ndNeKBtUXjXgnH4D3aU8PTtRJdEF7zBvOydkTjyXOrog2hLmGfdq9GvkwW3XgweW9\
OE+eWdFz6P5NQR+eNv0f/\
r4jHeYfiBXgbwH36Y4JivoxNkiwsfwVn4RPUriZt2EfzmYM5ldjg6kK6u4KNfkb/36+\
HfB/HBcbsC5IuVD2+0ushnMw99BZMBvj+v9xTaMQc+dfWBc5/zSxH/\
Sr2L8cmCyKcZz7lHz53JOh2GP6HqRcJeR8Ieug3sS2o+\
eX0dG95FtVX4DobFlvi3xB8uHaefFsFrb3/As+x1qy127zb4tyYFyW/2og7T1spE/\
P8uorPeiyvwiDxqz3weCr7TtRZerl7/MD/e/GB8fn1Nf17JxHx5KHmLDCJ+HUXOxzvh+\
whewsNkuoWjv8eht6buw7upFp1gfHOjg+aqJQ75RWo7693V5Pzu/2bk/YkreG3h/\
fbWcd7X2eifYBt8B/YePM5+E8GxTJd601Ob2Ae6ZsDP+\
Ft4isbOlPMS5yNVmnlqczMfXVSJ1y2VupsM+Mc2cw3m85fprJfVsu+\
VEBHxuOBLVQZ46IJt5LH900mYT9XQSfJe5MN/mTeOOiVL3sd2ryz1LFWwp/+\
gC2eHLmW87Czm4RERmV8MH7GNJfput9APsj8QezZBT+\
7TSPQAOpXg99508OnTq1BXlWoBcdVslUP1VrpUEvzUs4c47x+gDsW79RQc0mLq1/\
wBkfC70hWXOh/iDjaP5KMuoA+pkyHq7heQ+\
rmBjHPw7SR2r2HL06HfV78fer4tEAv7UQFclSmxnH5OiJiv7d2auqrtl2n3mizYscGzyPN\
H6cv3B5Ev8GeL7sz8YbT/VPfQ80xp+l8HgtuP/\
Yj98cJI7FmTQ9SRbESP0WrOf7pOPL5XMRvx2eeCE64Djl31Ki18jYkZh/\
DwN3mJwEmpupInfJRA8Hno/\
nmRpR4pBvVPJl5N4id1B2NvYz5iHXdCZ83sh//BrnuBn9aOc5efYzH9O3Yy/kBL/\
FdVhfOLLk59kE2XjveJ0w+/ZxE8XW6N1OHmkLj2/emM727wHK6OxA+HwgNgN8I7rnuje+\
vcFcb7IThj1Re/2yUXPGw54XNum5PfD4nG+xa9Q79lI87iFQLv41ayzoJ/\
2Xe9VUVpx0nygEZ0YvwHreWcgI6ejlqO9yqPf21bEtfVKchfeZu6SN2F3H8M/\
pXdjg5ssIT91WtPvFYF1CWZE5q6qxTtQvPQJWb9+/04J7ns1IfqT7nJ97b9k3k2ugd1ku/\
L8V71szI+O4XH7PB54lrz4EUI0mP/gxXwyXgKv8EvV4fxzkwe3SYVHYfl+H+\
qd3Xmb739vO/QStj52z7zNFUx7rsQe+etF93WD9QNBflF17gQuHU9B/\
1fnUHm0SjOiX4l7KTeKryPc2i3XRqP/bHscNq3mjoWu0jsRJb2rJ8+\
1HP664jPuWx5mRcZZF1EOcH+8w94cD2gMftb1aTUKTlH/eCHiNSJnk0m97vH9+IvY/\
1NQ3/RjDnDOp5FfbgrNAk7nHcM++U06j68OeBm/aQtGddNwr+a6iY4y3YlsNvvcp4Kfa6/\
FbsVJQv3XTWcddt+COfsd8IHlZZ5o3vt4vyfkHoYr90L1neZwsyfMlKXcxa+ziANfAP+\
ONEz+5SMffq38NxnxUPeuwv8YS7GW74n+WSvOv6hWs1+73/\
i3KHHVGfdLcfP8RsLH84F6oSCVT3wnyrKPj8jKfftQ72x94G4rj1L3tj0S8o+\
dpk8ujeX9e2tlvjNJXg0bRfw0W4lfq8t7NNf6Xtz7WPwM4/sxd5liMb3o1yg//+\
h3krvpU7P5MFfs2XBkwXecMFFJJD7UY9phpfm3DMcv8xvAR7ZF10nmxVctZ+F+\
eyqgDM2c8AXBx/z0+8OflqbZhz+92PBVzcTHsYXT9hHx7fAPy4QYE8yHOc+\
Q2Ljz2Vtgv9RieeZ2cInPHc49Wtlv7KeR85jPWdcynjfqs541zuAP5dsAe83tjbv+\
yQ8vARdqFs2G6ewX2+6CX9wqxTUBTVNyv5ZX+z/viH088ZPnLsLx6A9PW9Tr71zMP5C+\
oX4BTelXj6N5PXSsc+7VuIHd8Gf1D8Vw56EX0Nd+dpkzPvS2CP79Tv7TR/\
iuf6NgszPctT1+WfQfVCdC0qcnvio/YS/FUS6Q7+WH8v+tfY07zt/V8g+2GdlWXf/\
1MCOXLrHvC5LXNRfKDxpHYX3O1pu7jsB++8WNGfeNwzH38PXwW85WgB/qh7xa6+\
J6DNd6cf4toTHwRREh9WMhEfNf059tN5DXY8bj1/\
pv6ZuSc8Ch29qdmJcDl9hHmVPzbyrRn2d0vCl+\
DNEVzip8E71kPXeHH1DtSqrPMdj3ztajHHZa3iPI2Wwl5UYF9tV+FlmdmA+\
DIX3zB8Kn769JDqbz0Q/ZAm4FH2EuEsg9WN2Dzy8OldVnp8kN+\
vydA7GqRi6Kirm79itv5nv+hB2y58v+blNsh+cPIZfcFXWWUzRN+kAH4z6hD+\
g7WzBZxVmfqZS9Odsya+Wp55IZSKO4hWGR0PVLMQ6TST6j+vhn/Zqw6PhpcuK3V+\
enXUU6wL1vEXX47cvjs++0QV9Me++zIsFEqfd95H1PGU+\
73MDHL//SuqwV4teRynq7LwlRYQnMDx16Jmysv4/\
RRVcAPuIuzaF9i9BD9INEpz4dOptvNLw/OtV4Mm9/qJz1KUb7fiMPoirL/\
iaN5Lfm0GcyMl4mxG5BNdLfsjvInW/3zmX+zM4b5gbn1j/5U+\
L30D9vN0L7ttq5q8tRf2yzVlZ2kdczQyUeqHt5LGChMwDPys6PbYAfHy2t/\
Bc2MXM39XHsE+JWZem7y7sUey99HNZ6vj8OIJ3Ww0uyotmyIe8IW7p9RO+\
o7LUW2uFDoT9S/Rp+uE/uWmcQ+1m+\
BVtPeIOxmuCPW5xjPXUkPWk61HPYbcIf8wq8FeqgejG33pIO3cSh1DvyPeYM+\
SDzbKfua4Wfvvn6NT675NKvFX4e9ZK/c5TiR9WAt9hYseXuA68T273SfyTSKnxZydT3+\
3FJ1/lJySfZuNfZHyOCc/eG/iLzMGqzL+s+AemHPq5quNd8fe5qo03JE6GvraXaSHvtQf+\
Ut1L8Gq5yUPrOeDDTM8YxLUff8aPbAveya1vSD5p2gHJpzdl/D6AfzHLRC+\
jKvlIL0x4lh+J3k4j9GJ0SergbKzR2MGC1OfqU8RpbBrwKP530cfr/\
InzW2XhHy6HrqQK1pGvP4VOmesLLk154CxVM3gRzLPUjEfhy5LPErtYBd5ts5Vzm7dL9HB\
fka+2DQSn8x79Cr3sHHGg5GPIl446ir3rEBd7mj8O+3PYauxZhdTct9oTwUVR9+Gfqsf+\
kgv/2NuFTpiuD8+Rn574v1cAPWa/\
F3UsfgT46f35wgcfTeoFhPfSlJY673jCt7YO3WWvCecSu5r8oveVejjPih7XI3Sp3J3fBD\
dbFjsVTfH+MXfxfkW2MG5/RmX+rZuGH3M3M/\
tjGal3TAkfu7eScXJH0A3yVomOyueW4nd15D3eojPttg8lfpSE/cSLxO+\
9F6Kj8BRcfjBR6mtGgvsyN4hvmAzw/uuzEv/bL/oq8agHcg/Qw7Qeuj3BVepHvHu/\
YzcnFeK9JJ7hr4nCuSL2G/5fJhP9l+s+++Vu6oa9vuw3QUd0S4KfwA/aZOCmdDKpJ+\
rTivWlwfHZPxhXN2KlxJ/J16hpgnPez/wKmkaXvL3wgUdBd9A7M4m/L6fewTYW3Ycbx/\
neDPiz3BTRaxtHnNrrJXWo54gv2PyDaf+87LxX+avYrVK7xF+HR0QLz4H/cCPvk+\
Us66JwbdZFwVXUWfxZC/uxFb5xHfWo+BXMO79QfekH4of6FHF2V0nqcSI9ZN4UPSd5a/\
ia1QrsghW9Mf/iTfCT2y+A5+jwL7/7Q3SWy0kdbjfR36iGnr05R/2hSgN/\
QLAD3i3dlPpvna64+G2iAzS7N/5D/dvYE6lHNU/Iz3n1JS7zBl5kHRk77kVF79dsGss6+\
1v4d+uQJ/besK+53OCOvQnwPpuh97lfXdHr06LnNuAo4z4MXvyggeCj10RhPNbBw/z/\
53Du034BcY0Ecejniu1ofxZ4bv168Keasei9+ZPQK1Bd4Zezm69ht/\
Ogd6b3FGZc58xmXc6jvlQNpC7NVCUO7EpRl2f9m7zHbvjldVTwv247+hhmB/grnQG92f/\
h/7QWnbjt1F+ZGuSz/c0NqbP4Ae42aH0NO11OeLOvX8OuDj9PvKcP+nD+5RbEISZKHPZX/\
ET/L3DkZqLopjagzsBeR2/Mu4vup7q5h8/\
d0cVy0ci3++X68v218QUnAp5WbVgFnnVzPtZD1UPgaj60YN6uvcq4TUWH3twdxH5RGJ4B1\
x4/SPflvOrdpO7bjEfHQmchvuTnJB+uH4DnVCnnYqdGwBtvT9bnnJyf/I/7/\
I73L0newK3mffUmmc/lInJe/Bs9OZMUnjnvGPkb0wYdXTV8E+N+\
PxP1SZ3AjapZ8ICoBHlp90DwjX4R7L3agf6xm/\
CB8RwKD7oqPp15UpD6Tf0rdRx6teCKyghOIIrw+cZGj0+168q4NDzA/\
Vahm25Owu9pKx7GjuWHv9dfkAQcY2vhFZgu+L95nEtt11nip/Mc1YV8vX8AfIHNC2+\
SV5dzottNXtnkisW86AD+yS2X+ueMYXy/ofC1ZesAHiXsDOeJsaIzvQ0/\
zXxDN0J9QsfPvATXG/QXXbWePfAbFxHH1Jk/\
cP45IPZzgtR59hUeGiu8H4sFH59P9NxSktf2m+KfqFPo5JranO+\
CfvAj6zD40tw00TmdOEF0jagzNVGFDzwOetv2keT7FlDfpJ+\
Ax7KTwKF5M8EpeZ0LiN8s9mCD6ANUJw/gVsFfFnxhH9TpxmM/7oGHUiuI6/tz0OXRF+\
AX8BfCj6fO5sWv2ggO08vYgnYmyMb4vJ9BPVnhLODMe/no3/buL/\
V2ZajX2vedfS0JuPNgP7g6VRZeWi8Teqd6DPX/dpbg7F5Qf67LoxepY3AuNmNEz/\
FvdGX8FvupR/vrJc///QS4/kNrwOGf+0AdRe6E4LmaUO+rR5O3d/3gpw4OwM/\
mMoNb9f6mLluJrodug16N6yDnxRYnuaYRPc81jNf/6gKMlXheFPxtNfgn7NhD/\
IwgDftU0HU84zmUenRvBTheF4a/F9z+Db/kc2zsnp4HTiTnCN4vfVH27Y7NqZ/\
ItI76hVm039Wjzt8lmML5fmY1xrfjVvzlhIJzvsp5WG0XfdCP4L3NZuHr2/\
VI8oGiW9kTexDMEN699xVox+sR4Idzw0+luiemvSOnMg5DsS9+JXD3ahG4JK/\
WJtbjS3gSXFV0sN0q6m5UWvJE/iD0dnyp9w/qMh+8iVLP/2UY+92sS/RnlZ+\
4ZmEdBAfkHBUff8b7dSbrtAJ+s+4FbtQtFr3DnqKreRB+\
FLVN9CZnfMaPqlmZcXmLDkSQJyHr4rhj3ueby/wpBC+7msS53z1sHhonf3Q+1s/V9/\
zuqNQTBeDTTGWpVzmHDq4rAQ7F5EgOvnQlOtr2Ink5Va8q15uRaOcJeJW9Q6LTlaIWeG6D\
Lo//N/xJarPoZL5F596V4dyqWoJ712268/wDSxin4C/sd6eZxHM/ZWdf/FN0e7YLb+\
pn4Q+ZLvj7VxPF7wHnqfsKL9EP8FjupvAFZKJOytV+IXpKe6RuX+\
r2csBHYLuQH7KdiQ8Ep0Xffqvk8TtQ92KbX2d+XkI/wtvA+\
jTrxC4vo67EOw1eLXgn8ZIG4NL0KdGtjUIdk7/9JeMUrSHj8w5/Xk2Ywd9rlWXe3+/\
O52cFmQ+rVjDOvXvi31RMjt26P4BxKfM79TpvBef8mjypbsI5R/dpgx+\
0nnUfRPzKOH9kH/V+XOb83OwV59Yb9fHnuggP0Q3hI9w5lXl7pgjvE17qUxJIXjR+\
MonzovcVnESnLYiUgPNKLqnfKIAej50mfMGvwfW5Wk3ol/wS5+qKf+\
R9lDqpZrWpv35cHl73pdR32DLzsGNt1tM/ZUcSL4kL7lq/\
Jc5lxoHDN3XBOdswcIJ2Yhrs7LdP9OvHz+xHe8J43yLRsZudp7NPbBe/KQ+\
4UL8160aVPkx7f4FvK5gWkeffoV5JyzkouAYO168F7t12xU7pJOBh7CnsuB4lujmX0Slxq\
8mXqvPU+3ilGjGuI8Clq5qXJV8puA3XHnv45RjfLz0YO/9jAfOlbVXec9E9+\
ncKOoo2DByIF/1v/IKo6I5576j3sJHRJTUFBMc2Cfy63l+G/nkOLt9MhB/JxcxA+\
1KAj7b1GjM+0zkv21v4e05TZ6tqon+k49TleQ9Z9/6EVvRHFXTH/\
NzLaUcszm1GiT7uT1ewdzlXyjlc/\
JeigivbLTjQbl3ozxLoG6tKxINV1ynYpU3UnbjzogNa/YTgGXIy3pHQa7e/\
NGFdrf3BfGnzgnr4ugmpD7yzFXt9nbpD13w847ElsehCsd69XPD221ai19nsC/\
agAfX0epjUh30El2qbk1fxf3TDb+\
teivFPSF2Ha9SX37euF2qHt7Y3dX6r3mBPZg5kP4gQjeff3M68nnuKfalqRdrZ8gnrciDj\
5X1CH8pVBtdoy1L3rI+n5pqKcfa33ZZ1iz9sy3P+N31/8B5JwUlbBe+G2lgaO7t0D8/\
9UYn5+UV0ZdezD9iC1NkH+\
QrQnvyck4Lt4Jv9P0SXb0o94QGGB8z7HVyWjbqb50zknKz3b+P5s4Q/\
JflF5sd30T9tFVnimxL/q5ODefhzK+zQwsL4iaUf0K+Pn9L+\
nOjKmh75mTfNj0kdQ3ve48Rd2lEXOx3kf09/nX+Kf7qoHPZoWR/\
WzSPqRfTuWXxv7kKeXzA7PBZxN/\
H98Ph97schxrdMStZ7JHQwdO6utHcF89V7SV1W0LgN59VbUr+fFpx8MIK4n/\
m3tJz70UtXSSSulYl4mI60V/yW33jPlB/\
p14Hx6YeK5M38WxY78egr6ybGYH73AR0kVV54FhYe5f0GZQ/V77oEA+\
iHRgOYf9MPi12KzDxMgy6Muof+n84kftQk4e+\
oTR2s6kAdSVDvb9q1Bv8s6JaA67dZUldUgXVQjP3BVw+\
Y36c4h5sZdxiHmnJeUMQf3U1w1l5p0dX0p8j5nXp0rwR5THe6Mf2Ul/OO9+\
Jn5k8a6qP8GoeYZw0z0i9RiJ+aTcwf/yx1nv7Xzex/W/rDg7Ec3UvbSuZX6TD64Th+\
rpteGV6Nmpl53jThMXoRn/f8KTf2IOWq0HxRt+\
tjt5qUYD0mFD6KzpxrdbFyzJPk9J8pz7nQHafuwcUtTnsq3qc/9+\
Pne232MG9KgRcPWnXg+2czMl8Tw2tk5sJzZcJhr3W+f3j/HujRq0iCf/yKHfA/\
TRK8GfZL7+zI9QF12cGf1Nf5MYWvrzw4dnOfeaLyPOb+v8KL5rLCB+7NJy+\
vM1OnEtQZyDzeeRT9md5PQtf/Pzhg7yNTt+6Hpy7eRd3C/MolfKAz0bO0X+ABVR1L04+\
NJP6VtwD9tjoX/TaD+5lsnej/WNhd9evvjMttznleB8nv9aMeQ0/GLwtuCl/\
JXqmvjSpx6l0SV34hOO388n7jFc95InViqzIyzxNyHvUeVOXz5TGs61+kvmUc+r+\
2VS7akVHOB3uesK9vhg/AO/iF/29oyLlfRaT/T7Tm/QtznnC3Z/\
KeT2Q8JpN3Mq3wL7361GHor3EY3zyNmNeZ2EfU/CKsj0Nh2Mf82EmvVALm9bWr+\
NFzt2FvLsfCnh76Bl/An0/4fLUHdvnxVn5/\
4jTPbU9dlo4Ir4y7DO7WzIAHRKXHPwuunWa+/LKMc8XNUnz/KTgK1YB6HLOSPIN/E510/\
0pZ2TckD9MIXUg9Ngr32XKd+dPyIvPrC/\
NBneF9zK7uzMcENenXvfAwmQbUR7pF1MV629Ad8QT3a1fAz64njSSueeAc7WoQB7u9crbs\
+zOF7ysq8yKHnJ8Tl+bzswT0W/6y5A2aRcGuxFtFf5RKyXt+LEE/FpiDvf4svDzjfiX+\
HSbx4M7EjfwUX9jPqmOf/Obi59YlHmz/xC/yJwpvaBfmVTBG6vOyo6MYPBPe2HuiT3KO+\
hs/JXHKwAePpg9Sb28SEwdXednHTMe6zK9b3dmfvk3m7y/QI/\
PmC//GTeKqbvefrKdmm7kWsbT3KXhx7zfy7P4PcP96Cfxeuk4r2r9sn5zr2d/\
sDPLl3krw56ZcK9bl3J3Mi1xN6N+dhRmvCdflnAhe0V+5gXb2yy37puQPFo/\
hOfvgCXIvhLcgHOcdt5B9wz6vR3+OSMe45RW97vvoy7tyYp/vRaCd94RPoqnw0/\
4L3kyPqs7/073m963fMt4jxF84sJR2JojO+nvUhXWZOSt+bV94aFRr/\
FDTHN5GfwI66KYkusdevNG89xnxFxMJL9T8urz3POJ6NkEK1tkszv2ultSXvJe6sITg/\
FThmJwPG/9F+3qgQ6RPlhPdH3QH7c70+KNtwQOp9vCs2AnvGJ9dP4keGXX/\
xpyRuBH1IF4O6sWsJt/obyU/aZ725Pup7tAvpUvIebUg4z1OdEGrr2Yd/\
oqd1eUmsw5HTedc2Poz9xl3l364ITqwERk3XfgVcZr2xLFVEuqszOA3tCP9Dt6jVwXs8M8\
/s3+VR4dTTxR9s8LUm9sK4BtUceKaav8x5lWszKyvig1od/NHtKso+4a+\
WJm89xD6xUYgDqfa4t/5heFv0eee877NsAu6Wleee3Uffs4zqcP49C/\
5mzzE773xwm91AR5T80nq2//iHGiykPfQObvRzj83YQ/bCP/Twsi05zz5F+\
9YRs5jOxgvlZy6EbWA85Y6kxO/J3oB7Nfv51lHbdbR7iv4/25HHIlvwT/sUpL/dEfR+\
7X5bzMvkl/iPme+sA/cI8+hdy4P+\
dFeGHFgt3kJ7xNV8A45aLd5QNze5QfnGUyl3tVcrMc+efgn5stf5KHMhM6M+\
zrijsanrjWYLfnrBcIPNBwd0KAzvJvuFvkH14y4n/+\
UvKAbnYBrBvKbKgp5S7eJ8ffPofuhWmAf/TxfhL9nDu/bB/5gv3pJ3rtAD+bvNPJ5+\
jB55qA57TODiT/Y5fBZBit78T7trwkuBhxjkH+B4GMlnnwWvTYT43e+X4p8rnqJbphZI/\
nsY9GJW+cS/bmjyRj35pwv7Fp0YXXyXczPqRnFL4KX1PeSM/\
4jczEfPhNXNbvJfwWbOWe546+YVyXha7LLwde4spy/3c/Em+2to+zX58ljq0vCd+\
uLbkH0I9i/rehC2Avwiej0xIdclj+Zr20WYGeGce4I+owRHpqlrK/6EfE7aqfluRNEb/\
4k69yWqEu7ChIn8iPKuS4F+Xpz5xDj/j9evCXEf1xu8gn+KNF9SZSXcahWknEujj30q+\
KHmoXkxYM5+Leu6GvGeTN8Ero4unrm4R+Sf4Snw/txF32WVPB022PgQXVSdCn8Ifi1/h/\
kj/ziWdn//yUfFLSmPt7PiE6LHdyBdsyFX8WPRHwxuH+OfizWh/\
7pDj49ONiJeGzZifgxA+HxcOIneUsvM59bUP/\
tGlMfqMahl6UC5nfwHryen1j2u9rwbatX+Rn/HG3o97pSt5IL3lJvwHTat3Y87/cxN/\
MvPDx17jQ4FZ2sLfahYGH86bFir07BN2T/5VzglSS/4j585jllqVf1+4SjPWHCI/\
savg8bkbiL6xWJcay2DbtWcDt+bc2l+\
Osr8ad0ZHQylYJH0i6pg11ofhW7vA2cslcIe26fCo9UOeoGXUrqpu3Et+\
Qpfh0NjmFtHfbtGjeIh1Yib6Ayw1frEsxk3XZgf/\
Y3pmAeHpU435xsIR5Qd31LiI8zmFoKf/UKfL9+IuJ6dlgv+uvnCLxX7b3sX6MD+n3QHOz+\
W/JQ1kodTHf06JyLwvwrdZ/z/dX3+NszA/qhY2HJ58NT52Zy7vZfoE/\
uzrEulPIZ9zaO52c9yD48Lj/zdnNJ9r3K+K06V3beuyt1n6YDuGj/7TL8hxYHuH88/\
G0br3toH/LDU+fsWqIPFHRPhJ3MJvrin+DLDPLUo90LKsv8rEB+uTw4zWC/\
nBdLJ6CfHhOP1QVH4A9lId6tZxHntu05J7v9wrv2e0nmZ8YMEpcBF+\
3CP6I9ifELbUz83OAJeQc/\
Ffw2ek951u1F0aFPJjpze4nnuA0HOK9U3Mi8zQHuQfUAN6V2R2Qf/WkIfsSfnC/8+MSZ/\
T7EBfydcj4LR525txA+JnVL4usuNfPp6Xv2t+fUJ5qwbczrQdR1uWTwiwW/\
H2aevbvEe7Qjvu/lGMLzH2KvVQTR37mEP2BuCl/xOPgX7XXhn0/3nfk5qCP2+ERi+qV+\
IuZlwumswzXip5eV8/169Hm0gbfOOzqZcd0HLiWIInWEA4gj6n/I3/\
oD0uMfP56BfYgJn7ifOAvv1zUdn0vXkrwl7dIRsFsmFXlA03A++J8v1B/\
YuRHAp10gb2gXk+\
8NXAGJOzZgnNILP1eiqrTvIXWX6jj6uv5GqdfIgL6cygbO1XQjDmPjtGNdfJLzZau1tOdp\
HfaPjpd5rwLoenjxR4P3HniD3/cSntq1kj+8MJ/xCWNd2wP4D6YC+DjvO/\
EGfxQ8jG4EOqtuB7pnbqfU5y+\
mXsq0B2dvoqGv4y2kztf0In7vSrIf2N7g49Rh8n7qBPV6wZzqkr8pDf6t4zv6ofko5mft0\
fI8wdt8307eZQe4+OAP9EDt4NKSV63Gc55yTjLNxK/MAC+tF5F6PK+\
n8DzsF16oL4WwC5PH8/lwC/yXe2mYJ+GwU2on/OUqHvbGbyR54yvp0TvdUhvcvT+a+\
rVWGhzQpALkS7f/wj59RnTRE4qe3ALqUvRXeEyC8mV53nh0VNwq8vC6E/xjbik82/4K+\
DldmYngHTL+TH3KHyXoj5+GMg7LKtLfJ+Bl8+ploH8GcNXnv7Iev+C/2t/hvQ2y/\
OA93wlPcZzIklcTnovI1Em5q+\
Tr1UfOM0GmFNjH9OiB6XPokvlrhO9uEHz9ttJK6g2P0F5VQHQnG25jvc39g/\
dKhc6qPdmbPFaDgsQDqjeR/OS/+\
JeOuKw9i93zJqMvow6FAw896X2oPtHYs6GrO7sd3H4H+LzsaPIspj/1JnoA/Bne+32sn7/\
xv3TZxTwn7CDr7zX+kwm3gP0hD3jAYNRA7ES+jtRb3csVmif2t+o8d3RmyTfMwT7WCU+/\
ZBVdvz3XuX/klBLfEn37m+Qt9SJ4UfUd3lfnR/dIpYN/2pQgn+A/\
Ev2JTpx3vE7oReiWovNzvCn75cxYgj+UfH1Hzve6H7yHNgfft+eEJzkKdcJa4sL+\
twrMt1PoCvglJ9EPX/HT7Qt0/f4X17VXRIdJob9iq3an/Yny856tiQ95yckz+\
bHI07rBnD/MD84DtjjndC9bBfCaBTPSvhbk74PG8I/6s8GJq/7US/pr2Q+NO8l6jC3z+\
iv4O78K9Yz2b3RaTdG+zMMrO8BjH4YPzORbyjrolwo/voDskxMuYkdqwvPlht/\
AvnZcKvkMeNjUPfR0XA7sggoH35Df6ibrca7oRZQ8iV3YA8+GabkTf+\
O74LuWkefWyzivqw/wHKp74B7VeuaL3ZVU4jTCQ5eqHPYq/hWxJ3WZTw/AGXu/\
UNfsFPxtbovkT2pLff1H7Ipfdiz2eR/6od6O/LT7bTj8qvgViX+9n4LdGbUY/\
zPLHuIFycpw7ZI5lCcxu87A6z56Gn5RhSPYqVzwmNpUsfCb+h/\
FT6tWAru2bT159QJ7Q361bvGS+3UqBs9vplHc90Qdzp/J6+DHRs5JPD9J9BAPv/09b+\
jqpsLLb12RED++n+ci/P01chMvKXycvM7TLCH/3d0pB7/+\
l9ohXn1lRrwJXcNOhXj4ddM8IV5+N7Fl6OoVeBri9TdHV4V4+03umJ9D33u/+\
0uoPVFqfw19v8jlb6H75Brr6f8+P5gQLnQdNCB86Ho7W4T/\
rqpnp4ihzw32RvrvGiQsECV0jfEkaujv0RNF/+/qx9sb7b+rfVol1n9Xr9Dr0FWn+\
xI79PfTo+KGvvdX23j/Xc2lwj+Ffp+hd/zQ91cnSxj6ftyZoav39V6i0PPne0lCz+uyl+\
vXiklDv9MnQlfv2L8/hz6/jpE89PtJjVOEflfxXMrQ3/d1UqHnN/\
NShz5nuRG62o4b0oTaUavVL6Hr1IxpQ/9PODotzwuXPnT/\
dNVCV1Xqb64Nn4euNlyjDKFrgngZQ9/LGCNT6Pd3r4Su9s350DVocTh0VR1Oh76npmXj+\
3Enh37vn9gQup+uMTRdqB3profao9a2D7XP3bobar+rdTdV6HfRT4beL/jyJFno+\
zPSht5fR28R6h+\
vWO7Eof//2jbUj27yfvo3X6tQf6tCtUP97y1tGRqP4On00PiYCPFjhr6vYoTG08XuGRpfs\
2Nr5NDvDq7hunVUaB6oWueYF0WYH2rqrNB88ZYUCR96/91lQ/NJXev/\
IzTPrt74HpqPOUfzuc7e0GevRK7QPPTSLgrNT/MtZWi+2pKzP4X+nvlQ6Grm/\
hO6unALPoZ+P79SaL6bPefQoxh1JrQuvIbPQuvF35cEfYpRw0JXu+\
VIaN3572Zzbdw8tM78vD751DbdQ1fdjHyqvVSDfM/\
atnzeFBm9jeElWdffOmBHXpUlTnl6JvaoNTogaupIzlnx5Vx6qwL2Nwt1kWoA9XruOfgu/\
3AG9rvI5PFsRPJdnhoi8R3ynvZ3wWO9+Zl9rg15NX9aNe67QfSTiqObbceJ/t/\
FqTznovAMTqVuM5j+GH95cGz8/Vy/w/9S4xT7eH543cybJOy/\
Zgrnza7EFe1HePjVXsnvbCrLOeUY8WlTsi/2+iq4F90f/\
vhgreC9Y3OetVulLjBhLPbbb8IPkg7/xw2W/X8Wfqt68Zb//0X9ThCB+\
mMv1iLeY7vUAUaA18+ME1x2LHTpbBXq8byx6JO6z/BDeqtFjy0BOE+VBP5qLwZ5O50R/\
pZgQAf8yiGcJ/Qf7Etu7jHOY7XR/ww+UYfsxWzAvj8LHTs1c4joig5ERzlfI/y7T/BQ+\
kfrcH758JnvFxdei+roL9te6E64m9TPq/+j6awDsubehz/\
sbrH1qNiFCDY6FQu7Hltnt9gdM0FU7Ead3d09xS7sVqZgomI3+\
v6++1zvP877Zvd2znWuTk+xQyrI3PH9zCkzP0qe6DTJ++9I3ot9kfiiXRE/\
oxpNX0qVkjl5xpo14It1U+wl+iuYjbDbrG/McdAD6QOhRVcEHs/\
pt2QUWcrnHvSvs3bnRy+ZIfUaa7AzdG/8Wc4Fqf+TeTmqGX4/5UtegT0iJ+\
d3Cr1YhTHnSe2nzsr06Mk5BZHnYPU5xjkFPeW9Wen36tz0Ez/\
sbugjk8wBfCX1A6WZ8272aIH9lf0q/UVKMP/S6vUGPa73ffSTOVIPvJI6GH0X/\
gk7d1X0tLNH8AN07Sd+RdZt9kIfNX7Q38HuSL6HmSMEfBxKv3DjPPq2OUbmTxUir1/\
bJHNb3kNX1nzycNTH0ehTV6krc0rCTxwP+vU7TfCn2YNmom+mfMR++tAHyvo2B/obeV/\
67Hlhjy18RF+LpMx9U2kaQFca/\
MSMx97X7jKvwRzAHDbtnsxv74Ndb9ydAjyPSZ5IJuKveimNcy8zA/\
3rPnFOZ6PE7ZLTt0Xzpi+hakE9uBqJf0M9fcZ1ocxpT3tH8oOpq7b20E/bOVVd+kN/\
47me5AtZH+oDl6qbgOcR/Dbay3bwiXrMEzXa6Xy+iP5sXbPgcxOlX1TUVclrrgOee82C/\
rO8Ic6fYCHPOTRO9FniUWoNeeZOfh/Wu4O6SjWb+cx2P+\
aCm8lygdd3yG8xNfLrtWbMLzU7Mn9Tm5OWOHBNif8dYs6cmYL5m84q+qRao/\
B7OhpxKSOMfrza9CvgU4j0gbog9YPX8OvqeZjzaJ3vh3x5LX6jZ/gLHXVI/\
HX471Rp6hWMLNCnusMcE+fmO+yD7dQ7OjOpszCvUh9mdDvM9VMx9Pwq5CUbz/\
FDmJ7QtTVD8idqMrfMmncBudyTugq7M/mfRsu5yJtlzKGz2kqfAg/\
yJfTB2bCDAojzaAtb85448mS19uSd6a3pM2+Uusr9HuT/\
2Cn8kPt1mNdulpB6lSDp26XXBy61TsBnijEH3uiFX1wd7IEe0YD8ZhUi9vlo5qubn4mLmS\
/PcW5/qNez28v82mrEA7QNzMtU3vgFjAre0Hsp6lmt9thbap8OHKZLfV174ljOSfpM2Rp5\
fyqevHTrzi782R22wNfWMG/SXNycc25N/bk16w1+qrWN4PNHqf9USbIhf4bAB+\
0G2Fv2by/st29/oUMv/G/mfepqnfvs1/CiLlPvTJ9tbSP9VPUd0l8yF/\
WC6vA36DyX5Ps4krc7nTiQPscbvIggz8uuh/\
zXR1BvaQ6jz7LVcAZwPEJfDLWxuPST6wXeVpV6+NHSXz+4IXg6lPmsdpOHrPvTa/\
aRryz63FDklVGY/pjaRJmnsFXmOTn0D3eaY3fbo/ALOyV6cg5DlnMOX/Lir/\
qFv8rIJnOoo4Tv10nHeR6mv7yayLxErRXxfWsgfXwNh77IRiD1Cloqic8uxG+nxV/\
nOQ8lf7ETfiYthnnnKjgh8EnUQfIs/gD/3rPh54VysO4dQv8l8bvrTelvZftSz2B7kn+\
oEuGHd0Lor6IFoGfahb+hX6/1J6518A3xlrzJyC/\
JNRg7PhPxFyfUE3ivpX7VSk8fLnskczxN+zt0uHMm+lSjtdRvFn6PXjMQ/685pDh0+\
YI6CqcseRvadvQorTx+KpWb+VrObvwsahd+DxVzXfJS8KMaR6m3tt+tAj8HTYFvfCrD+\
l8ux49Q/R1wyCJ1wkuYj6KWEk91amRjn0O+4q+YzhwM8+YX8PZkSuRb9QHgZUAG+\
EpT6rPUWewK9bco+NQ3hnMaZIMnHT+AlxtlrlCMzO/+\
Sr25szYH52NIH2ePheyzzhnJ15J6tIWpuP8UdpAWjrxTs2QObGb0TnvWbd7nsZprF8k/\
G0f8wdwp9TLrKoAHNwqAX2voD2BFzoUP36zBfWvx46iMkmc8iDkMagV9R+\
wq0kfgCf3xnVIytz7sp8SHidtah8gj0luSF63/Hya49/06JvUC5EGpo6HYjVmZ2+\
R8K4i9OJP8IOWznfUlI4/PvDFF8PUDfPDdbfxWq06D19t/ct++2/\
z9QUre04O6MfNjYvCy1mn0parJWU8vmWe26Dv7SEV+mTmC/\
HWrfyfW8SGH5AMJnPNSH2LEJeB5ceRvq9XveG+dIeBTMPMqHW/\
88Koy8st8R78w3Ze4gh7N/BTtCPNoVBPsKMNT8itSE4+2DgVBpx+\
pV1SDmFPovKHPgurwGPk+\
jDm8Wlf6OZiXyKtwinMe2p448MFhHqM9IzXwecv8bKsi9bzWmj7EKV9Sd6GHn5E87RfsM3\
4rz3l1A7oaMhA+u4y5T9aQKcj9vol4b/+\
l4O9D6qucQTK3dzF6it2ReKZKyfxBvRb1c9pv5i5q1QuIviB1m0v/\
fzwNfV9tnYo8CSKf0Iii7tPKnBV8Pgf9WK3I19ZzkWereueH312WfsvjqEvRPuzinJbPAd\
8zJwROK5qAf9EjiWdHHAJ/L1fn+3jJt1nCHFb7UGfwwY/+\
Oeo58klV6Qy85jYBTkvIFzBOkMelroXw92QDmG869LvrB9VqJON9xQvCD/\
Ogh1lPybOwTvtIfhr582b6g3z2fgT9P2aemBmUkuduWAo9vvnItfxo6qX+Ue/\
iDKRfjBYm/VSOMqdT+0WdrPP7L37dDtQnmDOoI9E+XGH/5n6uT7exz2ajXD+\
R6taO91yn3tnMk539+p6XvGypn1hKfZSdljmo6iJ83PE5wnumncLPtLIo80/\
9uuGHSnscf/Hnn/itDt/imsGL+qsI6jethUGc46pC6FcN6pK/\
unI0z9t4gHms2kDmtbZu6frPtPWR+J8TRLrf22Mj8FsHVHU/694D8Ut/b+\
n618x5W8g3OXYA/1veKzwnnnmw5qZw9+\
oUa8uc2L4V3Odoyd65zzV2OO5nJ10bftdpHvfNz8Pn8Dnu361T8dw3rhB/97nF3/tmwN+\
XwIP3rP/L91458JuvLMffY7zcq7bBk/1lf8U68szk8/iUrLf6Dp5vvuW9MTl43i787/\
ZxD9fv6JRP516NJWnxQ7ZaxHteFwUOqcq7V8OrMt/nWwHcorfw3uy+\
cs3ONXki5vZuf8g5rygPXcQOca9WjXDiCDfKufcbXZIBd2MU77v9h3XOf8wc3pVrWO9pi3\
3XKMbnLgncq1GqFPBq3w0/qcd11rlpGvd/i3Gvlkcid3924q3u1Rw4l8/\
t2jFHeGob96plAh5WgzB+P3uoux773wLuv1SJ+MQdw72qdBV5Xuq/\
vMdoxXkNqADc2uwFL/de5Xlphrjr1jPnZh8FQ7j/+ybgurcz+HoOOJnzOgOfE3l5/\
sVnnPOcfdx/JA37XruY5+\
8DTmprCvf5VnNf92oWttiH1xrWc7E71yX1wY9FO3jfUOc9516X82szhXOb0Ad8+\
hDLewuA79rmtcxtDh5EntLTn9BvzVTEnXrnox6tbjP8vh+\
pG1SvsOOMOJnPOoh8Ca3GbfwO3ufF/yhx8p/kb+nP6L9j/+\
mEHK4gc9BOUZfqfKoqdgR15LovfQGcksx7Mme8Rx+qKf270vxEzkcMh5/\
mpK5KbSEPxu5HHq3qcQh52In8aHMj+YvaIuKPajf+EDPmoPiRDvP96Bus7yr8X/\
txjd9bzGU2HpOXaByW/PUOySVfEb1Ws/MiJ2tSV6Bdot+NMVD8tVeZW6p2wn/\
14MLw33fUf5jrx6A3D2Ous9WCfAozzXR+f3Mvn2Uuur2DOcJWOfQKK10R4BRG/yaVifl+\
zjrqB51LnugZP5n7ZeYmz0WlJ9/\
Q3HUcu6bsTeBbmzwueyB16fqQLJKvl0rqNWRu6lLy4O1m5SVvUPClRSWpp5I6mmwSPz8VI\
fZ0Kb6/FY4e+JjPTjLiGHYYfda0BcxjdLZEco7fgJN9MRn7uEy+gFMuFfcXIG/\
faUSdl7F1jMhz8u+tfTKnrQB6qZb4PfKveRyf87xAfk+gPthuDn5oAdSfOZPpR6E/\
Bg66vpvnZaWPhZ6ffELt/lPglOYZdPRM5jaOz8DztumsZ5XU449IyGcT/c5Muw08Ej+\
6VZ65S6og+ZWWN/RlLKfvj/GavnF6EvxSZixwUOWoR9TqkkdvfEkH/JqfZz9VyZdXz9B/\
9NMj0RtCY8HLsX2A/33J33OkX1JO+maoFvT3UkHkfesrZP7qdPri2I+n8f2cCeg9Y+\
qBL3VvsZ8uU1jvK+kz3l/qjmtXQi/\
btozfe9NnySxYAv7Sgb6TTmxj8L5AbZ5Xif6TWjfRRxdLHsZe+lo4RZiTZKWX/Hc/+\
qbrw5g/aJ6gXkd/L/1a7NroRbOwT7RE/YQ/yhzoH205zxcyx/xYCf5+j7wb4yV1rvrVw+\
BF0hXMXz/BXF5jK987F+iHpuLIBzTLkzdrNtzGejsQ51EdZC7yNOpNrVT0T9MDyFfW+\
uIfNlbg77YbjGN9seCBsZe502o99S9qzjHun0HeqbpEnMkowjwKS+\
2Bjxeibk3zhW84TxaAt7W3s47f2PHmcIPze7WR/dQmf96YSN2LMU/\
y6bMyt8OqLP3bVtFfxEzK74zTN8HTndRD2DH46Zzi8HkjF/Er5zfzOJQveaR6YDee+8jg/\
mDsKLsWeSJW3u987h/Peo9C93ZR9qXNpv5T9SKvSA3C3+Q8Zi6V88YT/\
bntavjnGOqW1fEKvO8J8sMcI/1L2kgeyTvxBxQAL9RP/LZWvPQdXyV5Wx1G89xj0n/gr/\
RJS4O9bXQn31QvJ/1Ljhzjd28OcM57qFeyQ7dw3pMeIB/CeiGfY2Weem/JG03nD92cwh+\
v/suBPXt9lPgX5dzMT8Cl/ybwMqecSyB9hK3cTSXPljmCdnHwU4+\
ZCHzbhvE5FXV4Kpx5zVaxJLxvalfshYgA/BDVqBuyxhHX1Rz4lL4N+\
8fMgFzWDakLuXZG8sCoJ1CJ6Xdt/\
GRehvpAvbO1mH6sWslc4O3n5PC76FT4USbS10KbXQg77wp1qlbGHsCzHfWmRhB+\
ZcsLuWDHPMPeHivzlJffIa8rrAt9VI8Hkg/epBBxlh7EU8235Iuq/QXhx4moQzb7Y/\
eaPtI/6iLxcCfBX/yJda9Dn62ChH6J06iW9F+1ljCPQjWVeTo5SkFfnXYArw/\
40Y1u0IV5ifpR59xr+FIb+myoM/SxMI5JnUf1txLvZw6c+au25L1Rt2wckv4E9cQvcQk/\
hXGB/hRW/o+ifyjwIgn9N42e+M/s+\
YnZ9y7Bs0JdOK8d1M3bSaVudj7zhp3OHYDPadFbc5GvZXllRp9ZMkb6AvwRupA+Cg+\
Z56r6Uh+qjaO+16pFnMj63B588iDuaVRH3jkZJF9//wbkxQXqFp0JrFubQT9oK6o17/\
naW+4nn1TFM1/FLoefU3uJn9YchB9VXybzX+/g/3Iy41cyL4FnWnb0K/\
vYWOJfZZgjY2nICzXUB31m5TjkVsni8KGh5K2Ze/GXqFrgt+qNPNcHydzP/dKv+\
azMO91Vn/2NAj+NXPSRMPsz79zMDjyNc/hHnbDmPN+yod8/4IHTFP1G654P/\
PpZFL1zxhj00gULOLcmCWXePXWnduI5XHfuZ72rH/GcD/QdMPrmB24tqb/R/\
pO6jH3MI1MzpH/4E/IUnWrUzTmpmfft5CQv1jCIQzlf+Wx2agMe/sbvqVeVeotr+\
Fl138rU6Ualw99xfA/ntFvyYi+\
IX83vFXj2JyvwyZkDOrPoQ6YGIe8tg361xoBS4M0I4pHmPfRl63IJ9j+M+\
hUrtCxw8m8ncqYm7y9DHbvxnc9asumcx03yBo1K+GmMZRHQ3X1/9nUYPDcf0J9OZaeuU8+\
B/91WxNOM/dLX4lYK4OxHfZoxWepFno8T/6H0m9lJXrJl05fYrs/\
8PPsrepzTFTqzy2HvaZtkLlwg+qq+XOIVr/F3Oz7bOY9r9M+xviJXdR/\
ib6o89YZ6Gebg2KNt4tjzmZ+g/2bujdNa5N005rKpaPJfzUDknrWwDte18Xw/BHvG8qU+\
VRvEfAP76DvO8T5z050D6ClGFenjFMx8a9VS6iNLjuI8M1Ff6TygH5LVg7pidW6qxJt3gg\
/bya+xih5DfiTC3jV60w9H1WCumpNc+hwtIg5lph7AfVnJx9Y3kC9q/\
csAPoyjjtxeRH6CeYX8LzMtdK7+\
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\
ugOeqInmQ5gryNYwVkmeanLiEdpk5Jk6d81I/\
nZf1N6OPmJGKuKV9kLml6jLnqJURffZsbtazk/xj49xt/HkhteiDlbMK9QydZe7FF/\
LNjMvSf+cj8RhVoB50VB19Q/ehLtVJUUXy7Rawvzti9+c/hfzTk7N/\
nwHiB6fvhxr6BjmfmHx8PUL01h/4b9Ri3uvsYJ/aQPpWKpUX/XrfSeCWFP+EXUX0tWHEE+\
yF9Pm2SlGPbnYvyf0TewP/pOT/2XdlvluSd8DxO31W9Uu3pI5F8ghNzttKvxX+04m+\
gtqz4iIvZD7hLOlbN0v6QLxiHq/\
REDpwJivRZ5j7oz9BTjlF6fOivtDfX0vzGvvOk7pOa18Wvh9xgXrXKJlXloJ+\
WOZr4O3MLs26dZmX2lHW9ZY4k9GR+LRRgD7YTo638LVqP9hXP+YKaV8kbhOE/\
9ZZU4XzKokeoQ+jPlXzkfPu3Eb8afgNVRx0aAyTvOsQ4gT2I/LPjT/\
M1VAX7gJX7Qnnkhy5p0KDOZ/h4fIc/EzOE85Vq4M8NdIzZ8oMhN+YG8irtGR+\
m7WWOnM1v4Tk0dGPQS9HPa2ZUfSUW/48ZzH2qT6O+l0zhHp/rSB97NVp8c+\
0IG5jvKUuwJxLvqM5fInIaexXO98Tzn068xXM3fQbt0ul5fxuPkCvvIHfzeg1geftFLz04\
ndqo+iFDcmv1r5Knm6w9J8Mg6/qa+iL4lwCPlbermKnEe81D6D366nR5/RFMic6AXXb+n+\
Sl96deeJa6rro0+8b0OdgXlbwsQbzCFRh/DeaH/zYuPSd9b9jfpT96B/\
8JUFu5Io3dTyaH/atlrUyeNuZfip2p53Ucy16DZ4vKM/\
vbhcUPxt5mrZNv0RzIX1R7JMSFzD8kJ/RzK3WD6wA7p3Jm1YliatpvfD7WgHkc6vHUh+\
UIgPrzy95Ct/xW+h9wsTv+pbfrSH/0+wic02WST+\
YFkdZX80rvPdZbln3Mc4vk9QvrEaO2ue28vsc5F+\
YveEPzj70CuMmfbLMDcgB7TN6qJOfeWFq1v+ve5e52ftzgP8rBZ+PYRep5/\
RxMTv5wB82M8dSeUAP9tkoiU8wj1ivxdxRey12q+FD/\
0irPv24jLnSzzwN9TLGSJnfvFbyuTcwZ8S+T9817Q99pMxZf/\
h7CepY7GMyR24sdo05Pkz6qIxHb19J/ZKdR+p1Nq/\
mmos6J2M584nMWsHgVWLyNp3Y3vDPNR7g0a2FzLuIlXmI95k/\
qs4tBU9eSL77Xvpp6y2Z22T+h91s3aIPvtNb7IFx0m98H/4ylYu51npK5gU6c0XPao/\
dps4chZ7ytif+tAC4WEekr+Jm9GrzpvQNVFUlviLzcwsdBU5x0ofr10foMst46sViZrG/\
jcSVjVTwC7WAukY73gv4NthBXG/+B+zUTVU532DsGt2pCZ2/YC6yM5++FWog+TnWXpm/\
WYL5b9rCxDLn/q87b1oZUcyjP9OCPm0PhlMXN48+Mk4d4vTGdvQG+xz6hj5mH/\
rJCeSVtT296P/0o7NyMXfBvitz/brg39OisXON5tSzmXfriN5JPNu8gr/BqEB/DbOV9L+\
Ia8M6WgtdbafvlVLkqVj9pD9JgMxTSy/zbHfTH8UcHMZctaYR9F1p4cs+Ukv/\
u2DmsekvsWM0T+CsLbzM+aXoBPxbfuV5mcpyfs0uYgcUoP7NuoadooLxfzqFGrL+\
aWLXesL/TV/p3/SMvAdTkbdhTYTfqa+jhY4zgB+x1Kk6eyTv/Gw8z3kg9Vad6Ktmf/QH7+\
o/gy93WAkeT6rD7/\
s15nkR9BGxLtHfw169ls9dgtnvZu4z3zPf0l6In9q6SV9d5yFz5fUs1Mfpr6E77eEk8YMg\
H1VUCuBrz5L5oWmAvzWXdQ2vC57lHkw91SH2qadH77fW0yfXjiffy/ghffZTMy/I/Iu/\
2VpF3Nj+KvM+LmFH6n+w+9Rd5qbqtaPxMz3bSj+\
m9Bmgn3joTBso9b0V0nOuwQ7XTVNYf7mMwDcWf49WFng7TirqgSft4jkVZ9HvxHc8/\
XtSMQfazpYC+i/kQz11FH3GtEzELwyhbz0F56L1ot5QJR8IfT+E7xoZmB+k9fkHnn/\
Bf6E2JePanHiB9oE++nZd6sCMQOlzuBs+p3kepq65ZCH67+SeQJ+TpWeAS3BV+LE/\
87BV9gjOaW5p8C3dcOjh6RG+95kG/8gUCZzXUndrdRL/XH34mn6IOWfWoczMldhK/2LbX/\
oiFZd54zb8U7u2EL2rdin0meXMezdjqJd3alAvoc7783n2Wfx9SUdQ7/tyMO+\
tm4b1HbriznlXJy66fNAOS0n/wlXrgN/Vsqy7HvNolRoGvzuS2v29/u69e57O/\
BDmeXeLc/mo9TIXc+8TLwa/g47Cd1ZWB4/SZaH+atwD6rJ+hru/d6ZloD/\
WrSPUt2aCX6sic+A7E3aw7wL4Z5zUEt+v4gldDvPn86yf4MnE+eBl7Rrg4zf0ZGce/W/\
MH9CVFUG/bj1rOq4BMi/wE/1Mtf8vx86Xoz5l7FL4wjX62OjmO+\
A9mDniZjPmKJonuRqjNPAsA/kgaqj4dZ/Tv9Y6z/xbbcAP9peHPp96nm3Aqwf+\
YKWN5v1xFp9X0d9B+VJnZ7RnTq3qAt+xuh2HHv+\
GQ2e10CvVklvgQ9229CfadYB9BE6Frzyh/tuaR36bU0v8FzXFPi5IXNU8yzw6NZL+\
gPY84gNW17LI6/VfOee69P+\
y7qIXOTlugxdd6ZtgZuhD3fhMmY99dDrfn8oGXd8cDp2srAledVtIn65y9Nc0C/\
yBzv6shH49XsLXnudw8dEITgR+7mnCOWUJAd5NIqGnvdnhUxOaQHel38KnQgJ5/\
r09rHfIWuh9CvhkRUQJ/ZO3YfVJCzxryxz4ElnpK/C2vvt+\
eyzzI5VZkPUsinHfY67Y7H62Lh93P1vjnrOeffSB0/tC785W/B7OiDnwi3UduS9yP/\
jyh3i1YcLHVbkp8K1+0dBD5j/AZWg11jN+BHX/vcZC/1Wrs75DV/C3eEpdb1r6fpmvE/\
Lcjfs5jy/jeX+AwzmN9AOuJyQOO2wPfPZmFp6TQPyFl7DXzM/M1TbGFoU/\
vDXc8zPLbHDXo2dOzzlsueDyKTNQc9etCtMfw76QFj1u8h3wIvyK+3cz1X/\
Qe7ohvGflAK5nH4Ffc57xvohy4FGkwXXPH867MfNWjc/\
UoakKnLPeYyrviY0EDvWH8f6yj+kn8aoT8C8q8bVPL5EXRRzglJh+4+\
pmRub35t3JfZ6Kc4lezvo+RPCc+SO473I95tx1hP+pbgp6WZeWdV8ZBT+evkvkju/\
9qoM03ajWo0nH6s2y/99XPt6lfUp4+5Xw9m1eukJFX7+\
Kfj4ly1aoUKG8z6BlH9ZdNndn0gf9743pQj3t//3HnpehtfuNqhpVRO+e/P/+\
NzjR//1Tv9fgIYNmZ/lv8ugk+U8M0owVvWb2HV61m8f/3q7+txTNaLnvkguMqOtu8zyz/\
TqEwvUR7mf75K6L7ub6fT8OsCqcdjdxJtF593Pj0u7vtTbrQILOP6+7n/PlcZ+\
jktdwv7dmHuL5uwrQpC95CRd5jYDCBE1CDJT6RYZ7v5GuLk399LJX3efV93KRynjS3r06x\
1u5f9ey/bvivjfnP3cd+gD2oZo2ZP1h+d31m/lbuH+\
3R0y44K5ne8pz7jVkhfu94RF82f17aFF3X/phjf2M7AESJV/\
lrlfbfi4SZFnkvtccNRt4da3mXu1iK8643w9bethdR6Je+93n5C/\
gfnYmnT7lfg4ZwjoeVnPXZ++bCzwzR7OPnKnOuu+ZlO84SHTJ/\
b35IpLfLwnn3EbMddejF/nknou58x/\
nlPUgv79e3j0P1a4u8I5rQLPCO2NQJl7PgJlUl2SB/8JAztPNMLZOtXR/rx/\
9AnOe0BklYNYxiN2vAHAp1hWi93vG+a/5yz5qh7r7crqPcs/\
RTLeec85uo0Qsy0iTo4gAzj1nK/c52tf3LnzVhZLuVeu12P1eP/4ao6/\
tPZhvh53gx7867vkZt4+552517Av+nOezM2uc+x69w3L3d8bS9Zzv77ngQVwoeDywp/s+\
a9hs4DqkAvsJZF3WkWr8rowfys+d1e7vVcIRLrzVuTQX2Odq8PJLO67zO7vnYwe+\
gZ7Carp4opIWYr2P77nfa+Vruc/TvHq7+\
3Je9KWJUuF7Lp2YBW8hjEbeYz1RJdnf9uzue41k3d3f612Xu3C3G+\
W5CP5lvsE5f3DXb05vDH20CnT3rXLNdH+vnfvA9cgM96rPrOQ+R+3p6MJDVQgDrxK1dv/\
uVK0FvG4fcv9uRg114eU83ACdDrjL/\
q4f4f17Yfp6eDKEw41c7KdpP4TBwjLg091rwP1wRvf5hsNz1Py7nGPNH/\
CVN8XBu5wfrnIOeYHjhFDoqthmftc+O/\
iT6yTredXCxRczSXf40qA68Jc1adx9GIfruudjaf4H3eeMPwBfmOXH/Vk+X+\
UcO7nvsS4Eu3/XXpx2r+b1Ci6dmnt6uPB1isxwv7f6zwBPkx4H7nlPcPUDz1QsTg1nI+\
drro8FvlPyQB+v+rjv1fu/gl99SAEe+D+\
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\
i13aAHpz7iFPWpeGPq8VBT/\
qQA9myHz46hXkqd6yDfwtVwx082kW9J7sIngR2p8g3YgenGPlleDl5cXw/zGjcLKm98BJ+\
aYt53YqBLq6ex37KGgmfDtBFPiTsAPnOfYD9w3OwvvXYM/oKaA7+3Ag/\
OIYzmA1pyD8K1lSzmvBNvD67RroKV0of2+QBrnZJRy9ZSfOUvP2KOj48G34hif4Zvh3d+\
Ho3L/rwte8g5zW0+3m+cXgw07QZfZjjOb8+uA8VlXHcb6r40T+A3d7FfJK+/gMuMX2AJ+\
y9he7YxnrDvrF7/acgl7Pd8U/dZWggbXED/uq73P03Ohg6L9WCZfvqlut0QtqNoRfnt/D+\
1PWhL/mQ28zi6+BXksshr4zxILnp9D3tEpZkcdrJkNf7avDV4yNyMWXIegbExR0U+\
whfK3aU/Z/IBSn9cedBImuzkDPOnMOen+ZD/6bQuzHc4OAc238SLq/P3rcWejPPJ8F+\
I6G/+vlkY/G4c5i/5bnvIxV+Dm37sJfmXo9eKSdhx/u3Yy+\
9QB619tjB6tbWZHTmz6i75b/hpz4ndPVn1STGsC31mnb/XtsSvxx5Y5CV2MGoq+\
nPEdSas2eBGlmLkIeNfeEn1abyPs6wj/0kNqcw6JenPMg/MVqeR/\
4sumHPMm0HDpL34LnPf8AfY0ieKryPOZ5RZeBp4Pf8J7EYfCL1veQ61NyIJ87HsCPmAl/\
gd2uG/QdcRv8nB3F8/Ph91Dbz+\
Gf6tcKOFeJkXPIRhCqEc3L9a4f4F9X0NfUrIXsw6cu13OP2O9g5I+\
xJAK++Lkb32d8hB6ULyX8zinL+\
mKPQvchm4Tf2PDdSwN5bjX0MC0Qv6uqi11gNk3BuQ6G72kH6rrPdXJdxk/aMBv+\
tfHx0MuOCPAwHr5uNcFvqMp14/lB16GjE7nRd24jz521y8DTfr/A73Ge6BW7ekKvDbGf/\
49ahB7HoHc9WII+OStW+NJerr8+g9dLioMXL/ehTyUfAj3eTAX/\
6LEfvnuZYYJqaDWSFJJugE/\
lvAdfOdOY9QzBH6cacM765gFcq8xjf5MvAKeQOZzvlSe8J9lM6PREZeRoarEbUheDTuLCk\
TM1NmNHX+7JuaabBl9ZVQF+MPYdQbKGs4Hj5yHg054c8K2whPhVBuPX1IsdAW9XdMIPl/\
ALz5v5Hvs5dW74xO3KPG8yflPdVNhR1/5hB/XLBb/6eA18igKPbJ+\
30G2QL8G4ZUNELvwHPHa/xC+eWPQ5B/tBPzcOeZlpDed5KQfydHwT7On26ONa/\
7nAr8wn4LoJvUktUgz5ag1fd37vhI+f34ifMEk6/EiLwsGvOt1ZR4Y38NGy6eHjq8/\
znqHdWcdmwYuwwfDxYynBh4vY3Wor8RDj+ln4eT7iZXa+uVzVbvzHxwKR/2Pmc+4v5vO+\
HzvhY5tPgB+vtoJfl+DvzsnH6HdGK+yNZCTRWL/Hs8+\
PN9F7WoWiRz4nWO34aySvfA6CHn5WQT9ckJWkkxY06dW74T/S/JB/9vrKDEkoPpC/\
V5Qkvo2FsLP+DAZvzt6Bjr0voteVbUByy8MV2E+e0IkTvQj8vpIW/rMhBftoNxA+\
XIX4kHOxO/u9eIPnhc6Vodz4Ke07fdFrmvVEr1v9DLredgv5uOgd8qs2/\
gcnXyifE98ELzdtIVi/rzd6b71O+Lkqb3T1PXMn+GKeLAT8b2cDjxPFA3+F/\
DR8IsHXw3XQH7q/gW8+SQn8h3yB75vB8N+gz+Bhq3rw/aLLkJ+X8EubT4n/mFPTir+\
NuIJ+OBo8TNoLPK9kwX+OLYeuLlYmeD43AcHvy+hp+snb+A1vF+X+p+\
iFZutIzvdjSvhI8is8f6Wf+GUmcn5TSPZzBgAvp+ZR4P/uJHy4TX7sxIXxnM/\
lkvDLA6nBy813gVsh+Il9vzj8ybso+JAjGDh0wn/\
3f4TIeUwahN9u2FP4xbZpJAUszsD3GTTk4shqnGN3knLU7tvos/XLo+d1vcZ+\
T3cHj18lRh/0+49z0hJyLmO+gxe7D4PnD+M4t6IG9B1+hvMc25h9vlsDXnnS5NoIHA5/\
sOBr9kb0JvtzGPw7+jT8bElq3tfIRJ/40RQ9wB8915wyEvivLw9dXC8HPh8dyXqneMF3/\
LDD9C0W9kCRunxeXYr9VcPPa2zwRf4uj0Wf+r4aPuT7HPl9eQd0dwC/ipasCHgcwzA8+\
2wR+MVeGzpO0h56HHsePXX1Zd6zZBhyPWwaeJTLB772CD6ub03M399mAp+fdcZO+\
rsPOdDuH/ua5c33l6eDH4v+gUcd8JurF/gz7FPFoZepPvyuww/\
4ZbPBwH0P9ov2twZweb8ffE7Yjv0O5dys1PvhQxnfgof7y/G8C5yHep4ffP0dinyIhO+\
rI+Gss3gA1+AI+H/oVZ776hjrGT8Jer8odoHnZM49VU/sp+/l8AdfQj/\
XEvQH7gM8gcvaWPaRrLZ7n1m6MX6JIPIvrDSlJB6Iv9dq/\
ITf2aM5l3X43R2fn5x7p3z4W25m4Bz6tRe/QDB4k7wQePE8ALrzzw09nh1EUlva+\
dBfjeLwmSK5wVOtGfK5fWrwdH9D6GlPOX5fiiIN+0slkpdC0vF9dfBcjd8CHD9vQg/\
4FMY5NLrG+g4XYZ/fSiBXPTX0jprV3audJxR+ef0tcN+Vnv0khX/oUS2Rd/\
nygse36oMXuXoBtzuRnEvLdZxD+\
6rQTXxF8DwDSZPW8lbQ670ASfKiiMVINgF4rSyNHjaA5EErwR+S2eacgv/FzIZesyxBn2/\
QiqS2BHPRE/Pf5PxCIqGj36/h93ER4MWnAvhXq+0E3/Jths5iL7KvviSba0FVwN++r+H/\
c966dpVq/8qNt2lda6AX3msG33kJ33XOHyW+kegW61xCUpbzzOS8Z9Tg/\
lJD4ZPBybjmXkqSY4IOyIecWaDbt2PA+xNJOb/\
xxHVUnKcMxzrAfqNqnHSfn7c1eFlAcY538N+ZHzfDn1Lsxe+8z+BzkzPgQ19/\
9IphxHlV70Ws8/FR+HXr9MC7ahznU+kU+z2HPNSfwme1bw/QL1Pkw06c+\
g78MgzouD70aQ1sAz8ZVQJ++BN7Uc1oLfCU5gIdsI+\
0m4M4z4Q8x7yyGToJes7fs3TmuWlLkrTnVxK/RyXiuk7+cRIvv+\
3CyRy6lbhDlZro8flbwk/uxaCfZUf/UZda89z7XaDrBGngw7P6Y29OLIVfOuMk8mAaL8G+\
CFoNH62cmHNKS7zRepCH769d4H3piJdpT9BjtZbIKe3IcfHv4j/R/Yqz/\
oRt4BdjBnJelUQ+lLzBeh8wHMlajf/GeoRcM+dLHKs7dqntUQn/ydAE+\
OGGjYMfNDkMn8usIz9G9EavOER+mhHgC7xXEmfSarcDXvPZl/\
7mLvJgHPaBNnkZcnObN3xp2Xnw99YJ6PZIIEmYo1qjH1xDblg7akM/\
VfA364GnWO9j4b9ZvYjvJiQ+\
oHcmj8KOXCz5FNinzjH2rV2awfcFHoD33cj7sv4SRzAa5YW+\
muYEb7pCF87j8siXz02Qn7c8wdODv9nP6szo26HwGVXdG77duiz8uW4B6OXDE/\
hoi3F8nw0/mzYsCfrWz1/ImfsU91jp+wPvf+fRT1vkINkzJ+tTIcQt1elt8NuJkr/\
ykXiIMTEcut+yCrkbWBr+J8VCxte02HfFs/K55ELgXrgN/\
Pa0xNsvkNembT6NPInvDN2P283+W7/k/EcvgW+\
1sdEnl09jvVdqip00Fj6xTPiw3G9l3iz6RTx4L3agvRU/kfmK+\
Jjqb0se5VnOqRvJt86Ry9gRic7xnk81eX+10+Dt+QD09oIknRq30Jes7rmAk4/\
ouwt2IZ8yleFcRlWFzh4nh/5HngGepQ/y/p3/xN5Kjr4aUYtzWIBf2qmB/\
9z4toV1Dp4IHiSTooXKn9F7U24Tv+Z08LA//izjlDf24a2pPH/\
Bfuyk7Bd478QK4MGIaNaTuR77PbkMfdOD4hVnN/EJu3w3zjtwHnBod1vsLk/\
4b5IxJN//ec19K/H7OuPRl+1M28Gv4uS52V2eQk/R43l/YBXkzY+M8J0QhoTrq1ICPy/\
grdpDl9px8njUuZast0Ie8OLONuT4qqmss2ARzjUYua1/+\
A7fzCRxsGkJ4DeNKnGefuTdmNebso7QjsCrbQj7Srwb+7NeEz4XrsD5eyj459fs/\
D4l9G4vuQf87jJESo9aD35lXw6dHGe4tX77C+fdfil5bjsen3A/H03n2sNaokf4Z+\
PIOzAfzZR8ieKyj67kZWwhj8qMgd8ZX8Rv/bINfPfBN/5+WPx45YTv+\
yfhnJZO4hwSiR8lFUnzZp9Q+\
FduipnUb5N9thgqcTvxz1w5ijwqK3pywc74tzoe5L4uvtCFTyB+\
rAAHPlkQOakX7CtDJHXOu35z1nN+EvxjEP5Wy+OA+P1akBfqf8iVy/\
qxguQPPyVPRH0lfqOmkWehaj5A7nV5hJ5hr4DPd30ofs8Q+\
EbULd574i98pvRj8PCyA91Vf0tcbRn2pDNhAnb86Cr435N+\
lvzVWPYREg38JkxGno7sz74rpsYf1b4Odmopnmu8jkOu5hC9avgH5GEH8lWNT+\
S7OmNr8fyT8+EP2wZxTePBufaOQb7Vm4ieUkfyntvoyMN7L/\
EXPxoKPT2F7rWB3pzzHOw3p/kL8Olua+IDA8a4eqw5feox8CaEc+i5lHOdHgFcfs2EL08/\
BH7VnEwekRbJ/ibcAN75P2HfLMfvoDXIDN5dT4XfNCX71kv8BM4JCsP3/\
0WKvdcfuLZjGKc91xP94MUn+HEb7DPtMHqUMTGUuMEH8EctbYD+MuCZ6P+\
x0PeCVHyuaLJO73bQRe8/7HP8CvyuN4+B//2H8r4r1/FX3/iJfjLlGkU0+TPx/\
epLyMHT5MfrQRmgi0vtef6jYuSzJIsBbicoEnOmoqcaCyii0OeWg5/FNsYeb9gd/\
NxOfM66hj2mrSjDelcXds/L/BxOvukXf/KdT71zz9XWxE8Q2Q6+\
8uAeemPWLsidjtjjRrQ/cD6AHm+N+gp95CDObp1ohRw+MZM829zkwTtee8lHe16RvLf+\
2aCT7cOgv58BUkwl9nSPrMi1WxHYRa2C0N9TEyc247vw9x9LOJ+X5K+afTlH+\
zX5UOaxbMgjLQ30kvsA9oRvNeAy6wn0rOdAPm2VvD2fD+I/\
fA4fCHyGnZmrJfrYXvK69IGtkW/FzkGv3bKDFxXxb6sVwMXuthI6T98UvB5TF7/\
C0S3UO6hU8PF3V4mHvEZuOxES19jQgXXNfQ7eN5iN/\
tICfDWmn2I9Caay30HEPdRNyXf5hD1ghOwEvhULQnddkiInrx5GXr2ZBp10+emuzzr5k/\
XsvgRdD5kGnm4KYb/pJX/syxfkc3nsVSP9WOzwhORVGFW3896hJ9DHDi/\
nPXvx36nn5GM49yS/NmUi+F6FsdhJPd5ybpHE58xaxA3NNP+AfxL8X+aQzeJ/\
DCDuna8kfHZwSuTT0+3AsXAF9IevJXnOoRu8t/ds8gWdKjb01NSVx9bbcPKW88zjOVv+/\
7mDZ87RDOBdgiToZU3J7zEflOe6oS3wv5CE+\
MdG8jxVniDgnlz8ExMc4DxV4vjPv7HODkmBW8Ux0E1pkzinT2nwqtlP7Mfn6IFW8+\
TiD5rBuo6QB2RXyY4cfbcD+thYHf9Q3tHoNz0kPyJgBfuM7A28s+\
FPtuwY1lsHPdPKGHSW93hwXhE/WX/Rg/CN1o2glybkCegpxc+\
QpBnx7HGryOPJvgg77vAX/\
Ds3ehAfiaEJqu0dTlFu5ZnonXWJw5vPRW9PSrGzvjI7TQXWz6I4r4oMD41myLYRWQo+s1+\
aNofTRMgYzpAGrTjNNlQYRax6nV98HkqzSafvJ5pJJaUZtR1Wm+E5gQHf3PtSF/\
jjritsjTs8Xl8Yz7D5L7VS/u/qVDYYWu852h1mb53OmOl/V/PSVPdqV13kDrs3Q+q6Q+\
6tJZNTu79/mT+5+7yKzdzn6SN68fzZz92h81rrH+\
6QH2PLeHeIj35oHc0jQ9bSxOnGCJoElVlEk5V6G4kvXDoDH/Doilzy7YN8CYxH7iRdCn+\
4PwW+n4LhoU4nyfdIkxG67vgJPndpA3Jv80SKjHfVJ170+\
jLytEEd6CNneujiXzP4xybw0LqJX91oSDxFPSwD/t9IA71dTQyen43d7d4/+\
o97dRZlQG4eTy56TyLuN9OhH3Q9i13RTJoB9HSg97UrwT/7NPmKAy/id/Sugv5/n/\
iycZb8L6f+HOi43Cr0isLt4bcrJH9yWxb034BiPHdmOfhk8Bz8Hg+\
L8PxTo9GbEiR26870UndcfmPtquR+bzwOws+U/Th6bZOa+EXvf0f/\
q1eF91zfhv9xKfForTDFwFZGB3n3uhF8ttIA9ls0J/\
bmhrXwyfHUIWmdkPda4hfYZX9Ks7+tU/HPLGM/9thrwLnOfOTAWz/\
kzxv0EyfkMfyiHPUMzqRE4M+oGuCJnRk9uXsG4JiI5+k1UvD+\
EkPQFx5QF6gKrEaP6UBer10xgt/Xao+eP2Mi511d5OmCBtTNbUIvsm54offGRaPvZS5O/\
disfMiFVn+5vw78XauwGPgp6ibsRF7I20P4Q52C5CnpDcqit2Q+\
JH5C6nusRNnA62jigNo99Dp9yxnyGzK9Yj0HFsJ/25EXbnhVgv/6N0Rezjwg+\
THEVfQj09Dj5xWB71drD/\
yyRKG3XB3IuZrE4c2IBKyv9nfg2lv8n8ZS7stNnZiqjN9ZvaH+xplbCn/\
zwczw6wqrOM804neI3wt/KDYcv/Mn4vBGgTuc0zT8ZuZs4vUqSS/kSa6R6CE/w8W/\
Sd2EVWQEdJdZ9KZe4IEdNgQ4TiTP1LarAsd0jTmHQfipnNTQlT5e6gDjqUPSIskDszt95t\
z7njzkrjPHTvf8tXRlwLNAqUvt0hR7Rl0krp4rn6uXaaOnHnGvFVsCn//IL9YfTycvpH8f\
9JetN8HLyRfx8w/P6L7P8X2OHjFMg26XlEX+\
NTspdWvUEZsRF8lfqoQ94Xw3qQtpUZjzSnMCuN6aAF5kttCzu5Dfp654Ycf4fyaOPrgG+\
yhNPMpe6Qt+Jk8E3C5IPchn4lTa6Wuc0/5jUk+IX1IPygu/TtsX/n+5Ef6W/66y/\
jH9eE6BBcQHXpNHY/0J4f1DClHn1W8OeWuDB7p8zRh7iPrAOhl2ute0G1w+aE05F+\
5e19zHT35hCb/PGgP8xku+a86brPddYejzShB4P7AfdHGwL3RjfKe+\
Kbise45mkbbod20nAM+1DE+2Tfw9xsdU4EXQM54zfxl+\
k5Am8Jlk79znOaeruH4HlWCce05O11zuOTu9Pu53vy91zP2s3+wOn4+\
rjDwolhu8qULdmj5T6oCPJkBOdixIk4PFNG1Wv+LZ/+FdxAm+5iQ/q94/PvefTL7XP+\
oCrAHpgf+WYfC1Xb1YXxFf4BaUDHyqXYBzGF9vu/v9i00b3Pdmq7HK/\
f2kWuTf3rnKORw9CF6W6ct6KhbFv72nEnh6DzxXDZsjtzIlxc7UysD3c5HnoS7NYt1bsnJ\
+eaPhp8OpH1N5yC+yNnwH7iOUuw4r8t8u97lnI9zP+sG94J/naPB6+\
R6e12IV9FkKf6Fpk79khEle/6CE/G5kNs5rnzbIvV9btfTE/56fQNvrfr7Oc51Z1D+\
qBzbrv1wMOX5T9OPj1MGqurngP2Mt6vxzLsH+\
Xd9O6pp82Fdj4feb8VurgNVSL0D9qfXQF3qM+nHAva9AkKvf2AkeuJ/1Wie7/G+\
d1twLLp+xCy10+ZZWIpb41N8vrMNrI/x1pdR/vKpHvnXZhi4dGB5LwN/\
Z14HXHeoTnOXC35YMRb6P5jyM/eQrG92xu4ykN4DD/YfI/daTkQ/160k8+A721/\
Gh2LXP9hIPnUj+mgroBx2myLfP3UfXiNXuNeX+Te4+JvzkvIO2cR6b/MG3P+\
uR6yvJT9Uzkbegp1mMXyl0JXzmQC/e9ymA8588Ery/GuT+XW+\
41eXvxhPqiK3NKYgLndLAZ4+F8P3HSV37Tx96irjkuh7wb/M8fLVSUX6fsS58/lQ4/hS/\
qvQbGFjcPTc1bfkC9/PYIu57Lf/v0ME7f/\
SO8vfQX0rFcP5zQpAr2wohBys9hl94TISvXhf+fSkAOb+SfDk9FL+\
G87gv551gGfrCqNP4Pb02IMcSJ8P/N/Afv5scjn+mWGv41OkK1KmfeIze+\
eKG1AXUgV9tIH5m6sTTnBvr3f1a26qDh8Pqodft03luvNQDr0kvdS9/\
kEMG9Y0quBzrur4Q/Nhf2ZWfWvAQPqe9CN95tYjzNupiBzSbgp/iloH+\
MEjqsn5WY30FxoPHpw6j16aiaZMThp/\
bbLKI5y7wgc8cwd9qvb2FPyELTXUchT5n1itPnDnxWOgg5hZyLzN1fPrHuS5+\
WRGFgXvyr/hPfj3k3MLJm9e/\
S51ZqZbwr9W7hX8RbzYe3hR9XPKw6w6Br7xBz9IHVCTOnT4GeXxS/\
PlZXoMvHsXR1195Ej/oKHlDW1YjB8bEA5+MOTmfthbn3SG36IH38E+u9UEPLAGeOoVHAu+\
2Kbh/tdTnp18K/vbKDd4NHwZ8/am70Xtif2knpf4npi16RgH6Xuj7fgCvo0eRH4mp/\
7OTj+BcQ3vBz5Kdxy7JacCXK9PUxzzeFH56nv4MynwCnm3Rscsiyklc7pfos0PwV1lr8Us\
3ngI9hKWBL5bogJyfdAd/3ecY9GSp+9J34MfXv1AP4/\
inBV4r8Ns6V8jrNq336OdrFoJXK0PJayhBXr9KRB6c3eAU/\
o2sqaS5F30rlIF9Z42laZGxN4/U2a3nPL4ih4zf9KvQei+EHrfTN8QKTwJcPM5yDs+\
24gequBc9+S344Hj/AC/XNgd+23eA17+Ij2gfSuFP/\
BoPnjZ9iB0dQN2kukAc2j7THXxq85l1pT0AnP904X3ZS+\
Bfbz6auFj9Lsin6cRl9JBA8O8MfWj0edQrOl3JX7VmkB9hvcBOtD7j/9Kcblz/\
HJc4Nn4urZ3Evc5Sp2in/Mz55K/IftPA97WN6Klqxwj8Uml+YF+nuoce+\
GwNfKp9D57ruQ751uoO+LrsOPE6Ez+\
CUbArdPZpOfkF5n2e07Kx5J2FYHeU7gT9tB2DHXDxBvtaT76DnRZ/q9M0G+vN/wk+\
uvAc6+tXE/reVR68Wp2c5z0vi/6mnXTll5MwOeeTdy9w7ZsMPDGeYH/\
lHQz8nybDTl01GTzoST6BbQyUuC18RHsXR9xhzVvkbpMX5M+29kdP/7cV/\
E56DHkW4UXeurUVe6zCIuTtY+\
q1rRHk1emxF3nf5c3osympl9CjWmDnpF0FXpV6JPuYI3n2ReB3uZDz/78e0DTXgm9/\
yDczk6DX25dLco4Ja+OnuI+/wvxL/w+79DjorzF9Y/Tygu/t6AdhTIsS+hjDPm7gD7dy/\
2M/RwZiF5eSvMI+jfh90An8NbvwL2l1Cwrf2Iy/dOFK8LNUKHpLB+oJVF38O3bfzRL/\
lyZawyUeM0f66mS5iZ3bMf9a4NrP5WdGpSec0yMN+yPDPfA3vDD0v8Zb7CX6LugfF7C+e+\
Rd6iv3SJ7aOOySkzWB10Pyte2qZznfr/2xR3K/AE/ONQfPdxdCLzlAnwbH5xZ87051+\
PQj8iiUB3WS2i/iyFr8QleuOtn3I/9O9EBvyp0dv/\
Os9a7daL4Rfew8dYoq7jP6ahvqzK1hxCXNmMnI9b1XwZOAq+\
S5lKBOxbpbFT5ZCjvXfHkAeeVL/ouTlnoZFUIegZlQ6rcfJUYf/\
g0c1Qnki2pEPxCnfxnu+7GVOO9U4t+qWwKJ42LXWobkje9dAP8oTj2A3gR/\
nFlQ4nMaecJq2TDO614H8jBWTMS/HXoCv3vcWfD1e1Gem/EvdFL5FeeVLRx9eMMw8PYH/\
QPMu4kkT1n6C42R+LXkCxkrhyKf05LXrL5JPXpL6i9MD+w7uwJyXj9L3rM+tSzfF/\
7BfWnJEzL8+4An1+\
g7YSdPIPXGmYBr13asP8U58KB7EPJPx45ytkZAN3sLQtcZqXfXRp1mfSXecv59AuEzx//y\
/uwL4XuXyJ/TE6+GTvewbuPpcOTDyjPY3WtfAr8Sfbge+ojf5k4y4jIxnXlvz/\
KsqzL5DdqsbPCTBMSvjGX0V9Amr4fub9DE1BlAvbfREj+RsYjnmG2Pi101E7z1+\
Mv7PtIPyUoynP38og7FuNMWfffUR8m3TQCfCSaPSY8hj1UbNxy+sYb8KrX4oeRNUPdt/\
DedeE9z8i2dAfOoT2rfEr4ZeAW9ssNo9DSPJdj90dTJ2JVDwctS5djn+\
QLozx70S7MmHIHPlCdPyOlFnZbdrw38afYC7IihsdhJvQsh51KkhD+szwGcXu0hTmj/\
BO5J6Iugl+Y9jv8F4kYnGZJr3u1K/\
k1u4lraS6lr86nB83KTD6gmU0fp5KSPg3EPO0Vlz8l5hFJPr8fQ107Vvw8+\
xZIPox6Rl2qXoKmlvrE7cmFZNuD3F33U2dCdvAWPQOA1pT7+1Rt5wRtzLHS+AHvb/OFAr+\
fJA7W3FQF+T6m30Re/BG+qhYpfjDw2dcSf97aGr6hl5Ac5mUZJfWs/\
1jvnCn6KstQFm1OJ8zidR+EfWHPqKOdzCj9FGsHHe9Rr657bpa6H+ht9fU/4W5Eb+\
N0vXkJfbREAH0lTD7j9TAc+NpzCfk6iD5qFq8A/a/XC7ni7wPUPWMP2oN8EeEOPYVK/\
fvwnerNPC/TMOs3ghx3zwpfrSN5Z1QTwt3ur2GfqptB9h+7g4Qv6G+i+\
lbmvD307zCUF0LsmElfRJ5OX4hyiP5ganhL8Lso61Np18IUX/7DDj+\
DHVi1e8t4pzYG7J3To/M0r8ftg5P7NFuBZixKc+\
5yF6FktLPhgzSLw0efkR5rt3kBvKgj5Z4tfcD71v07tTqyrAfXe+\
lrkrvGJvnuWb2343o7q0PE/4tQq20rwK2oEcKj2Dfk/iT4NzlLyfJ0f9CkyXucAry7lRw+\
aCt/Qht7n+8HIZ1XvMOu/0BH41HrGOp7C1+yqM9j3rAH4ext/4Zy65QduWUYSN/\
mxmPzRio+wN8eX4PvcyaCbbgXBI6ct9tz7v7z3T3bgFaHTrygT8XLtYxPJB80OXo1IwX7P\
NgW/n0q+3FfyNK1xaYiPviPOaO26j7xMTd9I+8V+7o+\
hr5CZohR8OB382fDbyP7O5mQdUemIr32jnl2LpA+GNnoXenq0+B8kbqGl8MBeOn6fc/\
hIHxgjGLvC2Ub+pDOqHXw+Qz74Y23qjE1TmtTWWg+/SUz/\
AeWVCb43MzV2ry39Lb5KHUVQYuJXEQfgO0eJY1hTiNPpS++DT3k8sLMP4Xdw9ki9cyB0p/\
JQ/252Xgf+/5J6nq82+r8j+TFVLOR5ixXA75X0x8jXCHvyK3l7erIQrq+\
m4TeYm5PnDsBvqEreBa4795F/MGcT51iHuivjykHosVwu+HYNms+aE2ugh3dNg9z9/\
ge73GsUcA7pgFwc2Ij9pkvI/Z3QT1Re5LB9ATllZ6VZscp4mfWsmAR9nKVe2fG6xLl/+\
g08nX/4l3/eljoPf/jVYPqpWEtWoj89vIP8eEFdkPONOJq97R3n9IY6Y/sG/\
XO0AYXgM53JK3b6kDelVYvi79Oljlz61mrTC4Inq0sTt8iXib4IWROQX6FeIGc9evP3ftJ\
Pb1AS+MlM4o1Gqq88J/Vd8Oa0gd+lflLOv80QzmMG+\
oxW8iB8LStN3Z2H9ONzzlBnanimZ93v8RvoGv2VVCz59I7fAPIeOnxlfVmn04w/\
kQxLOrCbYYhncjH0qGE8eRR1HrjD3PTPxd67z9nQ3M23MIqlcD8r7xiGvT08yTV6NMOTnq\
dk6GoMw9btwRXw80wrT16gdxzwiV9NnZeWmHyWlkPJW8mWhHygqh7gd3PigXqBXFK3+\
BR6+JSV/T0tSDPomuTdm2X3gMcrJU97rTTz704et2Nvx/90hqEdZuYW5N2Yg+FDI/\
PRlDljHfSTapmkTv0PcvXQAuqf3lDXpH5VQJ+Nr8u+3mxCDt9uAR+\
ug19BL7sCPPoZDt96SB6zVVj0FGsEcqRbIxlSPZX9RGVEb8smeuSm8siX/\
OSdO3VoPu0sUuh9dci/\
d26Qz2r27oE896AfkzZ7OnThXRl5kDUdeNquDPZu6mHoYz7kOaih9I+xvlE/\
Z8cQf9SeUj9kbpQ81kf089Hbrgd/PQexTukPosYH4q/ZR56IelgePvEWfdvYQzzQrFQF+\
J1sBlzDykBnBdKTb3PwHHB5WA64bEuA/JtInbAxaovA/yPw2En/\
Pj2V9KvMpiEPq0kdzMJq6EmTniK3Jor/sWwe+FAS/BbW/hIyJIt6bO3cF+\
7bzP12qWTQXTvyKo0c9O2wqr/Fb2LR70+rS98557j0aRgtdfxlz3IeFzcBv+bnsV9ej8J/\
lf0celDAetY5PjHn0GsW9/c+S71yem+GxjwJga5e+gOHGtKkPKAkceDPDOUx/RqQj/S+\
JXrOEPiMGZ6Jczm6D7j/zQRd5NktelcY8mVsCHhrjQdvh35iqEH0CJ7b1x+\
6mJGI3xXjPOzN95EDESOA777F0oeQvGwzkuEB5gqpG1DVobcx51lX8jbUDTaDvp1s0m/\
xPXVd9qrCyJsaS5A/\
WfFv2NHf4AdrGF6uFRmGX2QEzfuNopMk77Mr8mUAfNZsLfym9Bjg6JMDPeCh9EP0q4W/\
Ixq921o9RvThztxXgHputbwa647pyTCG/jTVtwq2h16CqZ/S006B3yxuBx/z/gm/90L/\
Nm9u5/uRFvstTr2jPWcJcuDkIa7Vakn+Ev0RzK+h8I2/\
3aHr3PTFs66jd5vtqEMykgTD975Ogm9HPyZuvyYCPcpkPXaj9JKHK3V3G/2x/\
6YnRc6MYYih1iQjn793gM8H3AWvKjBsSX24j5z67zvvL7hC9OXG6MVzpoL/a+\
k3aHdATzfb3gCPztKPzikndTyF6yDvNjI8yln4jueelb5o32aDt32SwTeWoueZWeqhx3aK\
A35FpuEPOUf/H1uX/oax8Hej/\
x701nH4o8yXDFdQh5sApx3k59v6bvBtL8OFVGeGYNivLfSN+\
9Q5mfsY5mE2CwSOU5Br9jf6E+qzoQvHpt+xebIVdLiuC3pd53/\
w0X34ybQ//fldevFre9PP2PACv7X5EdDHQoZuqVPS1/NRDfSvMiXZ/+\
tw6f9dWfSWJOBTKexzJ80r4jAZyP/WajSH71eibt6pxbr1pvQJcYo+\
hD90YaiK1nMPcri7zbCjs2sZatmYIX/GgJPkWc6vx3kVJX9Hd9qCD+\
uGoY8O3obc08hnc7LSX9h5IPGMOuJvu88wI7t/Cs7lxH8SN/\
qDHd5qlvi9f3LuRatBz1Xfw698xY4OkXh7EvyY+hL82c702+idg+\
hToP2QuErPeciFdtTtayc2Ap8JbaHTpquID971Ir5SivxnPbQA+Yj+8/AjVMU+\
UwUs1++t9V9EnKK7Je+njkr/byLnMJO5DfbSf1wD6VNgr9fgO7W+\
sv9Mh6XP0ATw9oLYFT7B2GsdBhHnioqGX7yKAp9GUreivduPX/M3+\
eD2xU3AoXYXwdOS4G/txMCxPX4me5A319ptidOcwM7WHn2Ejl62Is9+\
0STk143SrOdlPeT/Z4a3mW0Cue/CEPjAePi5NqkP+J+cvs/W8iTkm+5NwHlEY0/pSwvBF+\
4+Q4/I8ofn7lyH3Tw0OXxn3iLwKtsu6GDXcs5vUnX0ibclpY6WPiRGxjHgy4cZyJH+\
AVLXlhY+fKUd+l05+gOpY3WlT9An8C7bfujOoxL4lII5CVY8+V2Olwy7qyR+\
2IgG8LOcX7k/J34xq8RY5EouhslrJVdDT33WIb/LtoauPMj/\
d3bzPGMO8l2dljh5ffLfnP4VwON48NvYQ59Rcz99qU29CnL03ls3TuekJm/\
BSH0XO34yeUPaDPzlRvJ9/D2yEPGu8/RzMz6KvyCOfEm792T4VOxK4DA7HfKiI/\
qx9lT6wtRg+Ja9qh94nCeb6IHUWWhZqa8yitRGj6h7HP2+\
Bv1JjTMF8OtZv8iXmZyHOHof4vRaG/ooGfnpN6YdZr6BHvYM/+\
3hAvgv4nOSX3K4JPhS8Df7aX8dODaUOPbOhFL384u/+0pd2ST6eage9KE0+\
pI3Znwl30RVl75H09H/tb/Qh/FO/BT/8D+Y26Q+8WIpkfPSb3xLM+\
jlFXElbXtK4NmavpBOwRHYR9Pop+WMoe7cuUK9mNb5EHR48Bh0PYw+\
2arGcd7Xfzz266upnFeqe+BZFH2HrdZTsYv+tQEeU+YgF/\
PbwMvDE7037TyJA1wlfyc1cXerNvX4WnB+qZuT+GOU1OW8pc+rObY79lZUsORVwF/UD+\
q7VYXLIpf/8vcyB5EXtvT97EZ/FeMp/Wz0x/Q5U+PJMzCfTuI5DbeiL72nj7AxhjkM+\
qOFUjfOOWqhx+F7mxfAd0pTN2+\
uJX5vhNKnQzeQL0a2eaxr6Sf4dxxxWHMcctse9Zd9l41Dz81zQfom0d/\
L6i1DqZrTn8s5R56JWt8HvWNIPPZfQtHzupJ/bH9hXoFdiTiwaZJn6TTDj6Ft8hW/\
chx0WfIPf28EPmuNKnG+xQvjF591FL9Y7hbgxVH81+abA+BbLHXhpkV+mO35U+\
QlfjOremXOM8iffXnQN8oYSN9Yc/Qx9J7IZ/CLpOjXVux15F1Vhj/pGZ7B307u4/e1m/\
F9l0Pc35v6WGdMbfjxFuLBWuJr4GeSHugRwbfRazYwJNv2II6hTVsKP+pCfMh+WhS/\
wsfZ4MPZeOL/oeXhE+ts/F3RGbFTQwpz32fix+bA1uB54/qsr/QI9Nxi/4+\
q8w7o6X3//yF7y145kreZEbJzrIys7O3YI1F25rG3ZBM5KFtJtnCSTfaOnGzKXsno93E/\
7u8fv38cr1fndc49rn1f1/MC11673Ql6MEPZ10RwU8wz0q6c/J79HL6ddRvNOA0n6i/1/\
VdkPYk759F1v4v8QLUReRtmAHgwRmtZl3bBgfdEJfGck+\
SN2fWbse6V5nGeGZ9A3lhUOeL4hyQu2HvwjdQdGdnXIWuYb89ozkniyAfUO/vjRy8Zwvn+\
KvJV7GmZed++xczvDLho6nnivlY6cPHU6yU4t4luBP1eq0J8rw74ucpd6ga0TpxLG27lGH\
diE87lnrQlj3jZLezCj1fhY6+/8jwPnKP/+XHQRcePnEP0jeX3wYnYb6umk5dQluZn5k/\
wHs11ss5x0XDkk39j6LK8xLmZ8hZ++lOH5+uf4d+M8K02D7wyZdMUvn99Ffk+\
UuLx1zoNHb4kXqX3PyTjSaP/L/8BfXE2Pftf9xDyXeoTIwdxVeUddQqaFzjcRucyMg8R+\
1spKnGjZ1bk+d+JX+vj96PP924nDnQBnEg1lvocLcZb6uG6vNfrBnI4cR/\
yquNl6NOLPC0rHjxgtWxb5O71NzK+Tp2+kqphBz8PRQ6X49zAyH0Xeuo+\
BXkWQBzIbp0Felyym+9DDjEff+xle3069FYh+\
pHo5YhLGM9fEd940RH6W0ScTKlG80zbXeICz6Gexpgk8QC2HOFaDf2sXqdOXN1VA7kxHzm\
kVKSuVj9M0zjFOZV1yEb8Ta9ambj3D+qxrUfEAe2S6dEbb1KISyTKupIH7LPtR5NPu0c+\
6CVzMnGVHvIc2PkF59wVyCtWf2WnnqTpHPL8l47h+\
dVMKW93UH9or8JO9M0PXQWSP2RfOYJ8+0AeiV0VvC3Tk/NwPZ3MbwsBr9H+\
2pb5LQFvRD3Zl3naFt8XoG7YTATvzzrfBL86UPo3Fvaz/hrca/Uq9rG5gjxcxcrK+\
VtB6uRNax7n+SMkDvoq6pbURfSdMFwt/N+F1KWpvWohZ5vQ383yGA49/gLfRlmBH2z9/\
irP2YtDt9mWQDen8auMHL+g11vUE+\
lV6dOgWOBS2N9knxBLnt8NlucKMeAO2ZEu2PP33ssmjoegs809oefD5Lvr8T+\
w75Z3IJ5ThniZdoX4r/GePBFtfq+D7Os86oQ6jcVu7UUfDWPYDuwrP86ZzUzrmFdP+\
NGcC+6U+h38UePXcfitB/VPZmgE+t+1BfL2L/\
VWxkHw2LTp0i6O2sR8N99FD5YohDyudRn72LMx6+\
5PPbYWC46EVjdQ4oTMhd4qb0GPvPWHDkPluaAncRHzOjh15jhwq5UPfG9NoY5XLwPeiR5L\
noziAO6VWe8J5/C+hXn+C/\
BcldMNWecbZWXzXeIEymrqt5UZTnIdoRMtGzg9ausinANlJt/beki+\
qTUxifcWIz9PXwTOiPIGO9YIpA+\
BWTmJfLSOvuibe73Ytxf5yMO8OY585rHeyMvQZORW7kfYD19Gyrwv8HK0QNlEPRW713CXO\
DQl9khcfvxepfkH2Xz2G897/oD4Zn2aUyvZQ/CjM86Bzh535PwwbTz5DaWc4K/\
zk6GHfeALmlnAxTQXkn9u+VAfZk5wRh791xT+3/iJOFWiC/Zhn67o+abYp2oIfcnsPa/\
4nSrzqOyvMk5MHZ32l/x9NZJzeKVND6nXwT+0x0t/7NJc6CzzEepX67QTfq2aM5Z+U3f+\
UofVNYD6ywK3sXt+liUfdEIP8m7ji5I/kiEn/DFd9qHLsI/6x2EJ+\
JspI7C7OtLfzexxEnr5U5/9Py7t0xdHuR5rgvzNPh1/7DL54KYNbps1zsROmw9+\
hjq6OPTwE/wE45AT6/\
DuMPz6gT6Jxi2Z7xYHPowxSJ4bNQbfU3NDz1qnJW586inixwWCGc8WR1lfRz8qw+\
kR65zvPvTqhPw3NmDvGsUnoEcf4v+Zt3y4v/xlcPzyDxb0rN16RZzsqyPn5aX+\
xLBeY6lL+TUR+7oUeD7aSuLEytdVjOMc+\
Q9afXD2dUf635jqCtYvReIe7v0q8wTxq6zcEr/Tpv7U+L0YuTNyDnLXOSd6bBl+\
nuGTDn81/UrqL/JRt2Ps7I8cmTmIuuit1I0p5/phZ65DXhmP18i4PXFldQX4VkpCN/Yp/\
C55Y98qUwc3qY/MT/dmXhr54tqEDZxfzJtB/\
GddPuy5Fp2wr5cNkX3uiGMZToXRS2eoqzSsIMb1lviHcVjiCf304pwqfwBy/y+\
4XPZW6ES/94n9bTyIOP4tFRyF/\
jHUEw03sDcOF8JeSfeD9XGVeIGz45GP9aRdk3sCcugzTZ+1ioHInxVzOd8d6Qo/\
aMSn9dT26PXh5Gvoz+YgL3M/wR+YXQd74GU14t3D6fNqd++CHP32A/t1uoyjFqIvlTUW+\
rQs8PDMnUuhg345qbf5VFvwv3XhCtcO0ezv8RbIiYp7Bb1a+Yh7msHgBGj+Ene/\
sCt8fpNzM7MdcV873XTqFcvSp9Dshf41SpM3pJwY9v/bTRVzYU/\
64u9aweCcmYvBw7ZKyf44m8jnsxfTR0r9Qd648syb+VUfRFzr62/G7etG/\
dJacJKUwN3s7/Fy6LEilVjfdxKXZDB5VvZxzp+ME0XhP8+N0Ec8+\
6WeJW5izAIvTSsGnopSA7tZHfkQP2ofcW9tO/FGO0dn9GE/8jW1XPQ90E+mkE9bez/\
4Jvums94ViHsZs2l2bTlUg/9HEldTDFkv8v0i4z5Lc3KjLXxkrYZelZ2jkTe70yHvR77l/\
V3zw3cbwXVQ8mZFjuegTlP5vgK5sPMV9mKPPNBn/F/stivIQft7QeRY4EJZL/wHfthQi/\
c3JQ9f0y/jD54M4JxtaVHmFXsKeyQv/RqtLuglu9US+Lk5frlZbL/sL3sS+\
yk39UDWWPAGdLsJOD5LtXni/v+uRIj3Bd4U+2+G9aI+4q03/\
DaIOjhtpc05Ruoc9OLqxuhrf+oZtEwX8c9Gv2bdtkn/\
6Mxz1j8L9rU2fCvzXbjhCPT9NhL+Hg7dXDom5WYl5MrHRDE+I/wG/ZU91iFvg4pAz+\
uToWc32Xw9vyf2+sSf5G06U5dtzA+m7m/bVuqrHzjw3vUm6xg+\
CDp3Ki5xLIqL++yJCdRFdgJPVb05nH3rXAv5lpO+kdb7ONn3lDinnSxxbVqBL2Y3AH/\
BypAm85Xo96mexS81ngVgJ59ehdwfSV6jmh4cDmMV/ZPVg9L+\
C8TvVRKKUsf4uy105TAQOd47E/H5erI/67bW7Eu/POzLyrzIoRXEsezz4KjqI+\
iHYj2dyv1+9LvT8+dmfZovlPEY2Z8gCjwj6yb5/\
tZz8DC1FHCK9T2Z4TNPmqhbIeD56H7B5MkVkn1Dk2SfwvWp7Ntu6l/sO9R/2NsioO+\
K16G/VvWZbzUNuyEmHD48p6E/BxA3Um4OJS4/V9LF+znQzYG/\
6KtSTuAQnDok6NGedZTPKSHkzaaORx+0esl8Xei/Y2vvhZ9l+\
DhQt7LAk3ra0DbQ2XDy//W9bagfTniL/Op+h/Hf/Azd3elCH91Id+azyJk4U0pf9FY4+\
cnWEAP+mJeJz73x58xocHW1BsQF1A3EJ4xQFT3Y3Bk67QU+ilo7HD9503LkY5dfyNs+\
FWSdLvmAdtkryKsRsn65tTPPd6fPuK1OZR5Oqw+I8Tjr8MuhSqxfsY/\
YQ0euU981pC7xh9HbiD+kzeS+2JycK5XPw7npVQP5sFrWfY2+zj7kWoS9kaU1cnUl+\
fjayB0yvuUKXTp0wt6eUYX5DP4L/cQ9gq6u0H9YO1ac51/OiR/\
zmHNaJZU6MbNqUeLbrxbht+ygv7Hd2pl9WruI+\
Zy6gh2bdxm4FhdqE98s0ZV5uvjCf82pNzeWgqdhTXuLvj/cgHWdtw99YuaBfhwbQE+\
D5Ljqb0YulJA4ZqHUQ1uDwWG0vYoiT7/4cr7sMQA5uWYy855XG3r3lfkDLakv0l1zQR+\
xF+Cb8cepEzwyX+Srq1lWgWMQ+\
5rnvJoh7Ye82ENTBmAPjylGf1D1MvQ8jH5h9mny0M077dg/y5u698uXeJ/\
BuahxGtxfM3tj9Hdf+kQpPcBZMZ6S32v1w580imH/Ky70B9evtMIPmbVA0KEWmAB+wG5X+\
OkC9bBKFvrlWJcOIF+ftkGev6PPkdqQ/HN971fopif9gvSeLeCTHrLOrGZJ/LDt2GmK92/\
m+xy8X9VNQR+1CcO+zZOOfOu/XTk/iO9JnE+hH5cSFww/RL8hXt/\
Nxr78g91szZP4OuXIB7IG4xfYL2uyfh7UR6pSbyiPX0PXxxTkeCL2lbWcfCNlAH3C7JHgH\
hpBHfj92rfM+\
8FH7IbR5NnaMeSlmmepZ9aDqHNQRtIPyHTGbjOc8QuNTW24Th2LnfasFev9UcqPePpbqQV\
v8blCAvNakh/743Im4lglc+wXnw9cFHaq5v4cupxM3aqdZxFyv1lj5EYd8PHsoCqyfuIc+\
rcn/XPNishLdQ64qsaa+3yegh2u1qBPjeVVk331IX9H3VAdO/zEW9Yhuh3rfBZ/\
wJiQgh3UB5wF61MP9PlyGY9NWgY9l9+\
DvGijotdViRd1VOIwbeKcWzm6nfjIkgycE44Cr0+LJi9CLTxT5n+14H2ZiMsrca9Z74/\
gtVrPqLs2hoVxLhVKH0AtN36xXVHm6UaAv28H05/R6EGfWjX/Nuyx+he4RkYw34bg+\
xnrdeSiMlT2v42Cj8aeRk8diGGeXfrjT154w/y+3yMP5Nwb4kwfZH+\
AGvI8ftVu4jHvi4O7M1/ijWXiPFDbS1zOSuGcVUkiPm5fJo9F1Tk/NMZm4/\
5G9KE2W9cgzrzkHXlepzJxTlOVfiz6c5P5rx8PHxRj3ooTeA9KXfAmjEXgy6gdTiF/\
L91m3supYze3jcReP+1M/traD8y/1x8Z11/C+97K+NUkWa8+knpiZZkr/kYT6sfVOl7w/\
zjOSax6DZj3iDPQRcvtxC2b3Ef++NOX0b48nPyiPHewg9f9ZPzBu7h+kefBE8HXtc52Y/\
6NzsJH3q68r7zsZ9iPenQ1lfw+fZPsyzHRV/pXdaGv+dSnGn7y3HUp+\
VzKEBmnbkzekXo0jve2ZX2MqsSn1EmcV6m3wIdVC6Ygvy+9gN4330cvlpE4PyuroI+ngZ+\
sjh7NfbM34WdmlP3dOxJHUbYSpzcWYt+YbWPh673009b9iL/\
pseQ5qTdZV8uH8wt7eC3uq0N9hZX6jv0JNrm/UieeV436LaMe/\
Y6tpfGs2wvqiKydQTzv3jjy/nbLvl1HybcyPM5zvVeS3495xPovLYQd+\
yAr94fT10f9vZ75LJ4B/VjkKenzZL/Zdyrfr9rA+cGxE8SR2pC/YKeBe2FFk2+\
v9svCNdwReV2U+iQ76xrOIZa3hZ/PpuHnJ8n+fHe7EG/OAI6wGZMO/\
o52kX2l6TOmHbnKOqZeJF7XuDN8c53zM+tUaej8pDwvnA0Ovd0Cf946J/ET961GzrhI+\
s0k674Ky/6jE8GF1eqTt6zUq8+8218jL+bb2kTGl5X49y76bugFvXlPWc7FtdmJsm8a+\
ThayxDqP3flwU687YI+\
7HCR87zlR2S8tguft98hP6Jee8aRWIl5dRiJns6xHj67R96xkXcpedvxMs+q1GFhFyqu+\
znPdiCubhfiPEUZP4bnZXsk6wPod2nOW4t9taKwPE8CF0QvSd96fX065E8d6lSNCImXM7s\
/ftpEzgH1uKvIAyf6qllB5A3pSfSJsE6Qj69nkP0KW8q8urIyrzuHzLvNRD6p6Ue/\
A80iX9Nu+ZN4/GFwmO3qL9jH632xT/7EcA7iH4F/9MOX8VaAr82A1vDR+\
TjqSqZSt6QqnNOaPYnn6OXOQsd750GX7vR5UVaAy2+\
eXI999ol8EMX3MXRyqQL7n568CV3rhN9/tCz2dk7qBI0X9AW1YuiXaq1ED+\
pHZb3VYM6r9VkSt8Kk/5PiRTxfuyfx+j3+\
cN8giTO9jPuVtznRJ3XJOzWOgsOhWaPYx5gI+\
Kn5YvzxH6vh496fyGOZ5EJc6QVyR42NIN509wT3DXCHv0t+Ih9jPnV+\
thNxKaUsfU3UU7VYv/Vh8tzgNHQe+TwR+pjOe/J3JW/\
BMTN5NvpL6hvq3WCdyh5Db5zgnFUfPhw7v4rsZ1R8B/Kg0xjoJlDq1z/IH700cknPT/\
20Ovk78iqJcx/tHXaDPYe6SvX/8v/20t9FDyXf1nJoxjqWmogeGU8/\
HL0Vck09A16M3f0I9DeKPEvt63v07f/VsTy8wbzr5iSvwIF+H3YjzjGNWPqkmhewT/\
TNf6T9dx550TiIOH9gAeKCZagnUIfIPkvFsKO14sSZ9epjmG9AS/KwWgZiJ96n/\
7M1Uq7vA/K7lB6yfm6k7C9djnorzccHed3nGnkXH85AFz27k0fbhPoWY81P6G8qfUWN8zL\
v9vYCxnWTfjhGfg/2sTf5WVY7GR+tRz24Gfsc/zOPN/5Kp2rYeR5f8H/\
dLmOHzfuKPEwj39sIlefhtyS+yEDiTcanOdhDucDpN2OLkac+fAL0Wz8I/\
ZxI3q7dk75ddpobfK92Yf0egR+te5aF7w9P5zxsP3WGZhR11vqK88jnPAPJe/dZ+Aw+\
aQJ+8fys5MH/LMM63mM/tGnIS/\
VzEHS88gjjjaiMHrrSAvn1M5Xrf9S7ms1lv6OwDrKv5Xzkkesw7L4Y6p30/\
mHQ0WL6Ylq7w+HLetTJmR2/Yn8PPUJevg2+pP1pD8+Lz878OtD/RHek/6rdxp19fE2/\
SytkIHZUC/LzlLzQv9pI1sdWpl+E1oj+lHbsQ/j3q4HcuOaJnH09Fbo+\
SV9cZXAWxrlD5q+Okn1XncDdMX2y4X+4/EFfTD4L/zo3ZP5bg9HX6X/\
jf2fKyT5N8YKP3pP3qM6irtx+L/NdOnRnf5YXRe7k3gL/9RjHudSnseSnl2/J9+1l/\
aF3sjzPboEcCKLvir2WuhBzG/\
jCaofmrNNV6ou0lk1Yr9yTed8UeQ4yiv4idp4RyInnW8CNmHoTf7cMOI3aAPhQmUfe5f8M\
Buil0hbGtTYGfrnIeZHWgriJ2q4NdJZnLNeF+ZDXLeuw3r/6MB/nEpKuyOPSA4hXWCs/\
kpc4gj5W+hqZnz5hEfOqeZp9LPSVdRpH/1plliP8eE/iFtVHDxqNgvA3O+I/\
WqVlnuwCzp/Ns9S9KflT8HtPtiGe0dcXOX6kM/Q+iXxKvVsv9FqnBdD3iM6CL81znP/\
a0X7ozVr4YXb3vsip1nWQg/vKwf8n28Fn29PLOu4O2GGfwNW3CmB3aW2lH/\
B5G89Zn1HmV4dAd53gf6vAE/Tm45es21VwM+w8eWWdmdT/Tzg3Mm/Ogg8eDWJ/TvVj/\
ebIPNTe4D2ZGaQcm8u5lv7iMfRwOw/nSfPha+\
PQOOgt8gPr2WUS6xPEub964yzyvBL1dtqZB4xvB31WlCT4yPjRBtz6jhpy7Q19nO1VC6Dv\
yvQrtPvLc/uY09DdtA6ML2wk+/OHOly9GXgDau6K2MFVahJnjKVuRfHJCh1MoV+f2hE/\
QunE+bXyF/9En5QXuvwBLoUxgf6j6gPZ93lEOeRNGjg8apfB+\
ENP6VeiXyDfXFu9Dvno2U/G7ciP0L7JvPYFy4jregUQ763jSN7HpSxyHOQ/\
6meLcZ1PXyZ1YSX0VuUTjM+qBn2cKsx+RLRnH/Jdgl48bPLy1vWDTy+TV6O3k/\
28plHPoQ5lXa1vr7HPnBazr22X8v2Oiui9qtvR6wsOMq+YnZy775uP/\
G9F3w17Zw72YetL7JUo6FmprzG+n7HkHZnuss6tE+/\
LPx75eDcOvZmGHaHXAedK298PefhM6o9lVdmP2fQZ07OgB4w9TbAP8y6VdWb0NbGu0xdKz\
d8HPp1cmM89H0rcL1lHvf8K8msXddjmbvqKGumnYC+NBm9Ru0Wdsjm9s6x7vY19/\
KYlcnAf9Xj24b58ngrOkOp/\
Gb4o4QSfhVVhHZ1uY//5UherVQ8lDtcPfCg9ZQjzDymNX1HhG/MdlQz/\
f6avmLWSvHh9HP0FtHD6C+jHurLOKzZDHy7wgeFBHydD4pQoN8nDMbeRd2+\
8Ih9GK1KW9agWyfg2gz+n+QVi7/aR+qfQCe6fAa693ZY+1/Y75LkaMRY6eziX+\
tfYpezX1AnItxXsr9l5EvMrT72k4ZCCHOt4H7lR8Af6ZJjsH/\
9axlkWFWY9F0i7oCp9ZrXICIlfc5px6THQVSr56kqpC9gFgfS7VMqAT6QtXYNf/5j8NnN+\
KnQ6n7oFM4h6ET1mIPZ+UGHyIxqeIL4ZQf6L8t9T9MUdztOU2uSlKC/\
wC4xv4GEbti99OkYUg+5atmVfc0egF7f2hI4mFsG+\
CiXOYzf5wDo3iEaPeeRivQogv7WSleH3DfWQs3fpu6uvljg8Ds35/YOd+ON/fOG/\
EBnH6diIfSmQF/ozhiMv7y7CbsiMntE/BLMuM51k/hD625rYi/e1fy37fheE/\
obRd9yS55hm8Cji32ng59n7XrNeY8h/0XX699gNg9iPw+l57qkr2J+3ZV/\
HLyOgg8aVhf7WSo/n+mgNdJcyC7v7+mnG7fQNurTwW6z1DalffvSE+uUTCwWuhfKY+\
SrFx6PHBi1nHFPJI7HzDGQ8gb+\
wy7LkRV6N8MKOlvWrVj3ZZ7kTeLfqiGjm162BjAfR79naR79ZpVpW5td8OOt7uwZ6sZWFX\
rmVW9bFHEKO5XyE/7g3WIxT9VxO3b8r9T1aHeqotfbYLerYNbIvWE704+\
m68Pkw2d918mSeJ/W9mTwT/2BEZr5ful7W77SGjr+\
D62zuKsn83GTfqYXUe9sh88ErOLMYei+L/WjUA2dInXEdufzjC/\
N2WQ7dxaRK3A7JlwWwc6yV4PQYXntZfw/8f/O5N/LjF/gB2qUA5uf9BP7OlRl58vc+\
8ynQFP5uGIU8vjiFdRpDfYnRjLpv8/\
019LDrRPRpyiBZF4w9ayXuxA7ITJ2ltkj61U9kXxlH6vuNRZNZz4+\
y3325wtgXX6g3t3JJ3KTKxBn0tPLkMeVyIC7fDJxQM5vUN3GvkBul6CtvOhPH0rfS39X82\
xE7udAizulbJWPnpEPO2H3WM48BxJf1u+g78wjzVcpzbmCmDpPx0GMyLk6/\
MGV2F84t0t9FPrSTdl0p/Bm1bTroKkD6E4sLIMfzFUcfTx6LnZYR3Brj9iH4q2J19nlab+\
SdB/gi9i3kkjp5N/vSMZHxF6kHHf13hH37u5F9uDuFcfWW+\
al7AmW92A7uu4wdp6Zlg47K0F/W2sF77FzEAZR2laGn28ns8wHwHfQWa8GXuRhC/\
Xr2Z9hhLW3kzcCHfB+FX2iXlHZO23De+4Z8fu1nVvZjEvm9Sk/\
qCo384CkqXkOhi5fEtZRpw1jHjuADGlWoZ9FqZsR/7lMTvyP5Fr/\
PnQS9DJb5327D4bd99L3V3hHvVRLBZbL+FEIOtx1JfLfIKqn3Z0DXESHs/\
y1wMO2s0o5f1YbrRejcbjsQeZJEfEtfRz87+yz1NWYzzoX0NbnRH67kS1ufqSs0fn/\
F7kjKgbzqQj2nfTcOfqpyDTnQaQT0tB1cCLPDGOzX8rmRP8smQKdNopDj0eAJKefAP9Gm+\
RLHrLGF9TqPHWS3t6ATozf4FVE7sF9+wO/m+hyyDu4zdv6C8eJ8yXz/\
lrjZxiDs3211xHuNuG7Qx7H62GcFnZAf4yuiH5qjt/VyI5j3SPqY6Iu/\
4LdmmI79edEfOjxMvNaIoU+kHkSfOjXagXn4cb/pvgX8qp/hjGO6N/\
KwHP2glfhlrOu6pdCBhVxQE6lbU85U57mLpB9YBbvAbifxBeqCK6a7g4dg9zvGul13YJ3f\
gNtlJTaALh0bYyeNx+40XRcx3onyua6yzt2Nuhal4nsZX3gJ/8ezHurti8iVP8Xh9/\
5p8EemqujjPMuJQ/4oyj6NCUC+fQKPQalSCDvIPxuf7xFvMf90R/+E1ZF+hS/\
z3pKJ9WtSnOuvqvjX0+jTptbIih22ORG6LH6GffpbF318k/iknknWHS2fipxfzXmM+\
YXzRGPhTNaj4nbm3eILcjRjAHQwcx3jM2uzLx+HIf/nrpJxKRnPfUi/R/Uj52yaF/\
gEdkQ11usp9aBq1trYT5vZN604+G1GR+rCFN8c+OfHciE/M1Zl/\
Ccj2O92p4irddrLPJLjWEdZD6vueoccfuLHuctCzre08dCP+fs+\
63CTOnG78Bz48dQV1r1MB+y2vl+g831/4atF9NnWbhMv0sP4u+lM/\
Fn52AA5GSvxrc7nY1wPOGexXeiDZn6ohf5fPJT3lZY4ZpPAK9J3UQejTucc3sgAPVljTiM\
ninA+onXfB3+uXinrmqdz3t/zC3ImtRjPawB+gfl3JvtylH6FRoLsE3cOfWwlIY+\
M5pyf2fNyQ4/p32MXfTvCc6PmYG+FrcDP+NIMfVCEc3W1v8SVGUs/\
YKvEJRlXaAJfXMkEXa4fA9+ensG+/ZeE3zqGOJ9Vh74uVrQj+nTZAO7Lgb+\
kP6fPoJUxhr83Wi/Pce8xrjDZZ/go/Q2UuHHYP6Uusi4bS2EftYFfVNdyAq/\
ONGsKvDq922nBd+bNJtjpxwdw/Ut83ZC4sup78G5st0LIm+r10Islvcmv6Uf+\
sV0ZHG31OufsdsnqfH+AvkJ6G4k7ENyQc4hh9eCvS/\
hLyqIW8GPaCZlnUZ95R7ZDPuwDf1FL6g+\
fpMvJPsxNwd7KFyjxBGsSd2x7EXuidSboccFv9EB6iRv9Ff9Kr7AG+\
kmgr7lRGjwAYzv1nlrSBHlOSL97LTPnIVb0Ifyci4nQ0UnqOLUQ+hqpZTm3VVNbEg+\
4w7mgnr+WxAlrDH20zsi4Z8l8nUv1WKfbQdBVdYm/OTWO9XKnb6fawxN54rOWvJ227vSl+\
LaF/IyQKcRPv12H38aAm6Rnr46eO3Ac/3NZGvIgrw/6pZAD8jVrbeRWJuqnjTSpn/\
tehC5mIQ+1mDLI5wTwy4zRX5F7ZfFvLJP4nHVgLucT14Owmz+\
0ZJ7pf7DO9zjX0ApLPKyxH/BTftE/UU2P36dmG459n3sT9NaZ+dkD8AuUA1PhS+/\
S5NsEDpD1+X9Yv0fkHym3A7CrpqXHv/2RDf5q9YL7p4RCv3eRb8qF/vDr1N7wcWgG5Mau/\
cz7ajnk8Wv6xFvJEzhHG9SUuF4UffvU6fgb1m/\
0oulTDv164w3zSB2Ffq8OrpD5vgV//x4KHSRMkzgfW2TcM5rnbY2QuBSPmWeXMlxfU/\
9m3KW/jbGacxvlQDhyLVMq9me4jBOdwt81o8dgZ5fhnNLY+Ap9ckbWabedwOeuvYg/\
3WiAP9oMelArFYOfvixgXQOIv1mT6bdqxBD3UMa5so4NZD+EFPpqqklTWO+\
Vsi7sHPaH6UAdvrKb/AH11S7uy3yS9wXPQx5uol+\
J9oA6QDXLcuztyxugy7H0N9WSJA55bfC47SXgSVrJZxnvvW3YezV8hdxU1vTD/\
74zD7uhXwx+zuQs0LFbfZkfVpV93E+/FmMMuNnGlDzwz4yKss4ePH7jrgd2z6JF4Nz9/\
sp790bIODH+pN4tHjpfUwj6negBX/\
2kDtyMiuZajzwk287Afg2UeM4twSXSpxZH7kzAv9BOy3zIqw04HyoPro221Q/7+\
8NF5PYF/C676xbqMwsnk9/+5xJ5K3el/1MF+8w+JeMNPYhPK4PJc7c6FEL/f1nBOjzNy/\
W1H3a7fZ/nPPoNP9ahvtRQpd/argn6ssFQxu2xBLs/mPwX+zT4MnZJN+\
Ige7FHjVD6NZpB/thZX65zvSnzmueRR2YfPIb+\
DAKf0QryZB6dk8njiSDerLcYhJ2xLAq6V9rLc9Xi0H0ocSHNwv4wnb3g40rgmKo5oxlnBH\
jo1kEvxrkY3C69SGHsNO8F6NvGZdC/lbFPzHSy/\
20YuKXaZfxdc4iUUy2uQncJ4LcbJvUypqczemks+ID2VvA5tMOy/1LLvciXjzbr9/Ml+\
5eTumCtKvWN2mjqInQvmdcxV+L3LlyCHVF8IfMYT/zHOoc+U28WlfVyyDvT/wP7/\
9bmvkvd+P5FInlI2WZCL6/bs54JHtLvp8+8OgJ6MWZK+bshF3Q+6jz3r8mMfZxGvMp+\
BT6pNhp8QfP+M+TCVfIj9b25qd/qcYb1qU4et/4VXFhjPf3G9OO7iQvNoO+O2eE89s/\
hfuxHH/rI6esyU++1qj/5poElJZ7vf8xXJ05lh8h6yXGHJa6RxKWeIM8X/EpgN0SlYU+\
8w37ROsD/ao122Mk3YmXeWlWBx2875Jf5n+\
Cym2HkD5paGZkf3BK5sUX2pffdjR0evYH1PTCN8cSRx6OflP1Xh4Lvrz7xoL7gFXnqegh9\
6KxVj6CnIfSLtfO+Ih6eU/bt7neVc6tfyHN9isLvm4IDbxYHH97YRPzIWsg5rLH/\
DPJ54wSZ5+\
eGHH3OeqhtNrHPeRVRd2bsDCdO3v2YqGuz4qkv0yuMYr2iJI77qSTqPp6uZz/vy7oED/\
KGlBY9mVdV8LzUOPLpzLLUCRpeNaGPueDBaG/\
oQ61teCX60Vi3OMc0C1ZCzgQhB4xBst9ELeK09jjqEvUx0m/+WQQ9lQW/\
yHgPLqTuEMP885HXZX4AT94o2Y34SR1H8qhLv5V6cZ+M/32R/Ub3MN+wO8Sr/\
LpTx3SoOfVFtd9DF2E++MGFZf/UAOrkrPUvJf5YX9bjN+f4Vl15fvqqAeNvtpFx/\
vWBTr8mUT/yJ4w62Kyn6YvqOZy6MC/qr5SP9KEw5oxivUq7k/\
95gjxUK2Q3fB3WGj7x24weP0Nekv3zEn7sqkHYqXeJC1oFZ8s65Gfky3g7UIf65SH1AnPA\
rVe32+yLzB+wrh1F3weTX6rsesB+2MWZb9VyxIlGp6AnC2HnaVVOy3NmjfH4XJJ/\
P4wc2peD340ir0fv24b9HDgEuewu+0yM6YNf8ZE8Vrszda9mxxDswoHEuYwO4A4rYyW+\
4ZoHMh+FuhJ9UAD89ukeetqkrsYYgl9m3aHvrbI2Hv7Mi92tfJZ4WEfSSTuQ+\
kVtNXa4WZi4thFwk+c4YDerBe7wnq2sg746kfVoQR94bdMAmf/\
tjb1UlninGhMGfb5ehT3+\
jD5lemvqq9UPK6hnfreDuqNnfsjbUPq52tdC6ds3fDx597d7s39t17Iv7f6gH45yvqAsey\
vjg/WRz1v/yPjkDeIRbugLfQh5LequIexXwmv04ar0Mh9pKHTlUI3z/A6y3uCr7KOyMgl+\
yZcbuR5FnaQx9B5x4vMnGG//74I/7MttsfOWJLAP17AXzNbg7usvOjHf3i1ZR2/\
i6VpkJHQ/sDL0s24d4z0FLqw6D9xf02M1dmabA3y//RPz3ZyI/\
LW2IW9vkc9i3mR9zHPkWyvXyAsyosAJUYKcuC+zzJfyJZ9E2yHr6etK+\
nudn7jyumT8jkY/\
8UOPgYehHLyLvgim36HWX9oHR3X43K8PdL2AuKW9YxPjfnoef2R4NuIBT1cQ7wiT/okf+\
VdqtWrY8zfHEv+YXwS7+/QHYYebGSeC+9+qj7D/jR57xWezeiWB22+8rCBw/JXSTgLXX7/\
b4p143t/x9AGo81hcdaUOfQAOVxdXpXbxT+Lvc6t+Ft+PKPNF3FdK/yquraqKz4b/\
4u9iXH2Hi+/V3U/EZ6WM20/xngnbxNVcNC5VPG+Y7x/xfcl+ivbv+spTXM2/ien/\
XY182TL8u2oh8zP+u9re7zKJazH3zOL+doXE1c69P8u/q+65Kdu/q3ryeHbx9/ddc/\
27Klc65BF/L1TcUVxLLs8vnp8zpZD4+7QNxcV1b5Aqfl/6c2lxX857ZcRztsT9J77/\
VLKseN+5nuJq3YgWV2VMtnLi+5bx4rPar7+4X2vyzUV8P6eSeJ6a+\
1Ap8X2zVuI9euF0JcTvO88tLK7H/+YT938/LMZrj3fMIX4X+03MT9vbXcxXW/\
BTrIe5obVYH+WMyXpdmpVOXN2Hso4eSWJ97Z0VxVUtPfS32KeuD36Jfei0X+yDWe9Rivj+\
7NcfYj+mLP0m9tEzUOy75bGG/Y8e+FHsp+sp0S9C69pOfLbm9BRXtWczQU/m3drQWdAu+\
kRscpHxvHWC7pQ/qvi7faC6oFM17zxxn3qrEPG+Fs58H+\
Mvruaw3Xxud5PPLvuIsz1ZwPnOjQKcr6xvCt+qxH/NjMuQAzmS0I/N+\
uDvtiJvwcpbGXvqU33qrbPmFHaWMSYrdai722FP9Q5BDjWk35C1D5wIvWkR5EErqY9agot\
td4tGz7twHmFp9I02vOkna3rNQP95S78q10PstcX0pbF0medtU29kaEWQz770wdEKg4Omv\
z+AfmxzmOsIA3265ZzEW6a/jpoITpZxfBR2b84I6pHfzyev0lP2l59Y+JC479w12R+\
9DfPfXAe9XKw58syjtsy7R56p96jf0Woexu8qewB74Rl9+2yVvEUrlLi41hg/\
0tolcfeyg19ufHqEPdM7XNif5m1P6p171cD+\
2jpVnkOCh68Mm4UddPe0GLedq7GoAzUDD2BP/urMunn1Qe/\
WccFevHUaeyzLNsb50EKv5sgO/RyWeJOrMuLnTZK4DMHgxVu+v8GLcSd/\
xShJvxrVn755lus+6imNK+TjutKHXesiz2c7xeP3bv1BPpJPeuKhR7+\
AIzE2mf0qRd621WsY90+lrkZf9w27I/Mp9FIJ8Cj1HMQzjL3Yt/\
qEZYyrCvU16iDym5Xb9JdX1sp6/sYR4BBMGgmOh/th6ud8/\
bhuy0Bcsdh38hG23QaHq1Rzxt9jP+s9Y5Ds/10F/J1d46jTOUhfNOviG/yae/\
WpZ94k64qD06iTrHGDuokqR/j7S+r+zTJVmV+D6rKOtw/78ZB+zXpO+nDYkW35+\
z5w2fWT2Id2a3AX9VZb0MsJnBPZs8FZVTeC226/pa+\
HHeUOfXXmvNt8ynmN0bKvrKf7D764/Jf8ipobJM7NOPbFfxR+n0Mf/\
Ii117A//9N43iP6ZuvXDlE/X2E7uCxNZxNv7tIRuvogcYEnhWEPzQXP3SxOHp5ypR7+\
zm0X7L+e3/\
DD1si4ZCJ1gXa6BD5Xn4s9v5a8PSU7daTmUuocrVT676jZuyNf2uxjnb3iiaf14hxI2ybz\
qp+lk/HZa8xnXV/oz+c4ctCkn58xkfpmtVtZ5G3NsrJuS/oHl4iXGx4St/\
KbAl17UHemXpJx+JdbsK/Hd0GOvKQu1/5D3yT1B/FEuwPjMO0f2N0HZrA/ccSdrf/\
IL9PnEH9TulO3bh0vj/32bA12d48AnteE/GVlnKwHaEVfcSsT+UZqCfI1rAOyr/\
GdOsKO1zYtxL6PpW+qfknWW/fYRj6wMZA85vBG1KPOagI/\
fAfP3shBfZihgGdhX9eho1nroMOPz2U92W72bzvxRdUHvH1Nn846exLPUu95Qj/\
XMvH7MgfZpyvPofuBc6njO9qW590Hj9E+F4jdugu8Tq3nbuTYwM/UtXf6iN6s7Ql+\
m6fNfq+czrrNPwPd5crKOf9Ef57zZxJycQv583YA53CGoyd6MYK+WkYB+\
kzpVYZidz8rhR+gk6eqngS/Wk+gjsLOlovnNyduqt55ih9+\
Npl1n1yCfbhDXpc1azJ01krGzZZTV2+uegY9TKnIefvtYPR9ffJr9GzX8EPch2J/\
FCTfTZsILoA5TMbT/YmjKt5XiUekSHzd0Weglw/UtdhaKvHyY8QDlBmf5PmiD9+\
PbQufx3DubPuQD2G6PYaOnc8g30ri5+vT8Ve0x63Zh/\
OcW1utdcadK5Lzxk9BMk9I4uKXkefBwRvwU0r3Z71dduHvPCEvWqsv65C6zsZPLEp9nV2+\
PH7LIfqyqZ/xh6yXyfCVyz7OUU4cxs9xxu9RrSPk2Twjv0cpSv8H+\
xH4xloj4nrWd9kH1f00/l/PK7I+XJ4n+Ui/8Q44s/Y7+g5ZtW/\
AR18yIpdndmD9PpEfqaic31gFJX5ADPn2ei1w+bTd1A3rBZfLeo5+\
su4Yf1i9UwN5OgV9qSbTR1qLIM/DCLqLffD2J9dH5J+\
oWcEfsNaTp25GE6e35zpw7nFxBOdWI/Lj/xXPRZ5Zv56cf6Y1xM71fy/\
zzFJ4XhbyEc2Qz9gzK6tx/\
1fizPrPUcQtHvbDf21M3yS99VLofHoJ6CIEPFJrMedTWho4gNo96t+Np+yDtagnfH6d+\
ljlxWnOI7LFsr9dX+OHLwPXT3XDD1b95jP+MT7Y80td8W9vDoGO2hWE/zuDa69XMtAPW/\
thrwUmMu7wspzTtUmAjgZwfqaWu0xcaBv4rcZhibPSGVxkc8499FpaG/Y1VvZvLk3+\
hnlL9hNypY+\
lqY0i7rngL355kaKMz2pKvKVSMdZtwRzovvok9PTywdDh3K7E4fI0Q55dr8vvti2F73qC0\
680Jc/C+ohfoxQdil0xCT2uLKVeRPt2AP6oLfvhbIYO1ANy/EOIQ2tDO0Efy2V+\
S0X6bulPZB7MCOo2zEKcT9t+s3mOYwn8kUXIf31wduSuQ2HkVM2G0OcT8gy07oXh75/\
0G9e6+6OPT5xCTo/shhzMRb9GteoC5MnX7/gZo5xkXrKMP23OiF8RlEHmA/\
2BThb2Ja8vZDv7nNmDfZ1KPpBywF/u917mE0m9nlVxIOuQbi7yzGMc58l1ZV+Rq0+\
IB7mAT6Dm5TzW3Ei9rZH7EvLCmTwHtRP1QGZcGn6p8hU+86lHfCb0MtcutaHrDpHs+\
69A6MevFvQyPgo6ra+\
wX0ngoOh1JrOum915jsNxrvEVWIfEC8j56tRjK2n0hTDOVmcdslPvpQ/Yhf64ajO+\
2uyT5hTK+jzshjxsVlbm8Uo88RTqk/\
UmzfEr34KPqqWBL260WYbevEpejZ1e9gscxjmzMtqHOFsaeeLaWPwlowd4rMqYc6z7DPoT\
miXLIq+eIZ+VkeSXWqnEb9XJ5bDfypMHaKXlgc6XV4ZONlH3YI+ReZ0D6EtsN/\
HEznxZjvjvifHM0x2/wMhCH159B/XSylHZ123gTfhv9H7GO3YAdtRb+\
sEoPWtj55UH59OuSLzfzob9oL4hj8/8Bj6x2hlcC+VFNdYv+ArXVhPhg83UGZm+\
VdHTbxZAB9ePM6+l01iPgRV43gbyJe2O5PlaRcBlVVXyLswer9GL1cuyH7ES13U4OCxa+\
3jWe84t6KyoJ/xQQoFOrxFXV07fZZ9v0N9F/cl5n71TnkOnx36xf97i/mXdWLdsNuNbFS/\
zh8nj1nPsYD47yavWxsq4qz0Iv3K3Tl7MEPAj9eBy8GH+8YxrRAvG+\
Yu6Gr3UCNZp0ib4sMEM6iK+yH51TR/JvojN4bs+o2T+WD1Zx0u/XPNJBHTY7wXP/\
9gVvTKnP3w5gv7MelhGmXcbzD71Ho5enl0K+dejCudJs+hnrZaS/\
XDOzWbdPoLrYCx7zb7XjsJ+77YM/\
zSSOIQ64CL8HnaSOG9mk89J7rKeag52WLlTvK9HevRJSRv9UagufJ8tA9d6Mn/v1zHGP+\
k7cvTvI9bpYkbxHqP8K+LSJ2/JPm4DWI/gSyIOZ6cuoB/swR7k/83qS5wu8rT4XkvvmiR+\
190SV7XFBvrRBt0Qfze7xYirEtJS/F3v9Fn83TLL8/eyb4gf5mTexghVxBGNg8/\
EVf99gnj3ryzct3YU9vce7Ah1z3CJr1SaPJV4nqeMTy+u2sNj2FNZkok/\
5hsi3mt3nsm4BviRR7OM+Lru/ZP+udN14ukV63BfYpIYj7I4SdynlSBf3Og6jPd3ay6+V/\
uuZh2Hk0eklLvEuvf4AS5AYmHGE1+Q/U0YzvVVA573ArrXy72GT2s25/\
dH0AvmUehCS6nKfN90YPyX0sT87P8qsn7jTrBfM3Mx3oc5iLt6b2Iefnv4POsw18plWK+\
uzVnv6YcYZ9Ic1m3FNdbD6aaI7xrJEVxDXcS+av39ksV1ooP43nyUhzhw2YViv/Umi9/\
A9zp/f7GD581yp+/ws77QWZ08YjxWo6uca5wuzPt9X8DvfbrBD1HpkT+pNeX+Xmf+\
V4qJq948O/gLFwsz/4V/2J/CvZinUoQ4c+kE3jesGfd1uMF+\
PKjCfnyjHkDPkoJd1kvKoSFSLnxrifwZzbpZN/25dpsGPZfOyXNnXOLcx301/OWfD/\
39gzwdPaUIn3+nwx84mcB74+mDYX5F36pbP2OXH6K/kTaOfi32IdmvMA/\
4mFZplesBcLS175s4/886AD3c5Q3yaIOsR+xHPxT7IOfJeonmrHOXROTI5JLsQ09P/\
KrBk7BjDkQhF4NvYi9PucB1i4V8dX3CfQOJN1lu1JFqPvXwJ9L8kWcfbrIufz9B5wsfcg3\
4gb/pTj8HpSL9ii2FvG39VFfs+g2p+GftnhFPPE4el+aYQeJd0C/D+\
jwCvXZpMHpgPPgY6kMX7Kpk8F+UZgeID2wm/8hOcMTO30NepjJH1nMWo85E2cA5rua+\
Cz2wmfwyVZf2668Y1nnoaMYbhx1iz3GFjs5JO1L2+\
bCjiDvobvT5VSpiLxjPqGcz8r3F7z65kfd1kvVzbaZC/4uHwMfXuiF3GtfiOdHYn9qQ4/\
gV3WVf9/fz8LemVmGenf+wj6He7EOxfHw+\
Qx82vQX9y8wG4L0o5zXilRV6My8P8H6UlZOwx2f3ZT8ey3h8jZvo+a4Sx8QrG+O/\
LuOxhw5y/4yF2OmZdPRt5nes0+IrzMdrBt9H4feZvr2w+72C5P7gPxoDirKeVUvy+\
411qd9a2Ag/PLg869kF/AprAec9VgbyuS1P6jLVYuBWKO7gBdjRBfGT9mEv2eno46aOoQ+\
GdpW6D7um7Cs+hLwgvTP1k2aBwry/IOfZyswY3pMe/DHjpR9+XBVZd96V/r/Wc+KZpg/\
5ULrXAtb1/VHWO0OAPD8oJevGB2Hf56VPtrYlCTu79krs4wES1zSyLXZLUfD8rB/\
X8QeO1uLcZnxPcQ5jeZUDB/JaKucG5n7kT2fwQgw/\
7GHFHf9M6Ua9gN6PvmNahezYk1m3Ek8ZSt9g23E09B13FL9Gvw8fNQWvwGznznMT3dinat\
Q1K87Ujerlbks/OA255LQW+29ZD+jF4vxe+\
8C5i61QV2NMipV1EuPYl1mtoJ9q2LXKwDfEFwscw07NTl6L3Xw59nY0dUxmE+rZzKwy/\
tJ7NX5HCvnd6kUph7bSn90q5UWc1gU8X9snCrt4QjLrtGYd9N10HvyQM5L17NsDfzBoAHb\
GmTDsoZNVsOfuOiMvqku8pi7tkOubyRsyzpZB7tV25vNncIWsT/HQywWJaxKTj/\
l9k7j6ccSz7JO1kedxnVnH6l2gl4eD4Av3itC9aznoe60vem0AuAF2w2CuRzby/\
SVZ15FnGHG1Ab/hk2zkk9vf6H+u+u5jfCPBA7OrlZdxDuSIeY8+50pP5LuST+\
JWOx6D3gNWS/yvfMTNt3/Az/SjbsX+\
cEfGcULZp67kcyrhofy9t8p5yCeeq7hTh2EMXM48rjaDfl6BR6IdK4kcqCLxHHLJ/\
pRro1inHD58H/\
4Ke++2lHftwEmyh9K3R8nOebGZ7RZ8XmAhfkP8BvykIeB9qNvAN7X7y3VYLuvNL0g/\
eRtxZb3idvRt/yHQy60w5G/\
22sifrtQZ2r1cWIcNnGvpadSxa7lkvUsqOEtWXvJfzVIe0OW9N/BjC4n/U+\
sZcqbKNfhKw45SYvALjd9hrF9t8MvU25+\
huynkA2tXT3IOd7ci52S9erHvY1hns3AY9sHl3+zP60rgVSfOBof7jIrfnkQ/\
CFXxJz6xmfxPtVI71vNlA+RFNRmnaEg+\
gd2APHllAfgM1g7iEoZfgsxjoi7PbDWSddqwArnS0oY+yq+Hz78Qv7Z7sh/q94rwR/\
0E1tWDvGHr1TXyqNZK/JCP1ZGvE2tDty+K8Z4o8vrUhrHIvRdxxKnKgcNhPe2H/\
fG4OvTRg34S+l4VuVocvBH96FnG+wD/XUuQ9Rkhd6C3llHYm7tqcq3HvivFZrL+\
n9H35rTp0FPrfNjb0cvQt8sbSX7n3NRsuxJ5dFr2n8tUBHp704L937tC4l2A22N6Lpb5Hp\
+QmxecGH8N+sZpA68yzrWc79kbFxHHn9+Bc65NnFcaj4mHqNNCmPfF/fCjLuPZn4g/\
qllHw1cTbsg4N/\
WkxoPf5BusH8C52Uzim1pGmVe55wZ65idxR3XyZOyOUOLh5hD0uzULPDVtO/0TdT/\
OLY0OpbAf4stK+5E+1lb4Mdan1Xb4Ipz+7/\
pW8HK17eDyGIvys2972VftcUn06N8E9Orrn8y70QP2sUYccbKqO5DfZ5Lho6vESdRp0Jf+\
7ZasR64CvzgfZV+Cz2L3ZJqEPtw8Ar2+fwe/s6bjz+aYw7q+2IRc+\
EDdvlazPHpnaW7GMyNMxl1rcN+S7+ixbPgj+jUXntMMvFbrPXrd/\
MZ5nh3aleelP834CuyCz4bG4rcUp55aKZuJ8e3nHNpo/\
BX5dwN8LmNxKeSxg8b4m2diX3NuQ06tASdWj3uI/b5gL/\
bGiYPwnRd1Jtb10vBj9zIy7ukDfccir63DMv7e2I3fF+LvevX8yIUHnZn/\
0zvyvI5zMusy9oGeQ54bD+PcT11LHoHVpAx0lUx/DfN7JPbfEfB+zPsnOf+YJM+zb8k+\
wN/3Ql9HtsJ/\
6cGf1c48gm6myrrDSvR9NVc1knUrAeTx722KnP0RCz76UOorlT3U++su1NmqDegHom6NIK\
67TuJFZcD+su8uZV6DlqL/GmCfGw3PQzc9Jc5Tcgno8sJz9HZwCP6x4w2Jh8b5p+\
KUQPxTJx5m5nwKPSwjbmrcGIxcvwp+t7Z8BPno6cdxbj/\
EDbruQD9QS7uEXtJ8ZB6F7GdY3BF72cnCrv1E/rfWvjXrV/A7z2+UjDzqSp6ClgSekfED+\
lUU+lqo9032oR+4s2oU+lePhc+UHJxjaa6y/8fxaOig71Psoeqyn6bahnXaTj6GsUnnd+\
GyL2StSZzLu11hf+ZRl6G1pn7SHNiH+\
ItnXeIZcZvhv2HpkI++nDPaV6UfEEB9mJWeOlL9D/Fs48M35PSoKditzzlXN2ZfhZ9+/1+\
/5Qn4FVYbiWNAXpDxeh3XpfRfUsMqMd7j5HXbx4+\
g38udZn9cpyG3P3LupIZNkOfK2EX247WMXwHfSw3cx3UdeGrmYXBBDb0U87p2Hpzi1rJ/+\
0MviZ8m8fD6yjjItM2s2wXiF2bNJN5rybrbthPRU8pZ5N3j2uz7Q+\
pK7BbEhe1yq4hDzZuLHdwLvaFXAZfd3FRV4kNeRm5kAa9FbXIGfokcBp1Vb8f45xdAb7fj\
vMTMjL9o+/WHP1pRL220IU6tx8g6inSVWedCtbi+JS/OKhuJfHkL/\
9gqfQmUUpyzqlnWIo+DtmAXhr9BXpfLTTxs+2/iue/\
BAzZr1uTqWBV6KLsbeX0E3Bij80fW9x5+g/6U/rlW53j4ZKTEH063Ej7JSDxC2b4E+\
X6QuIaRtyH7UboC47oJXrGdzoE8jy0f+TzQi329lIE4yM+\
O2IefLeyIFDfmeywEfny9Av9wmQf9UTJvo95lzFH6EN0Bd976I/\
WCugS9smUs9kBp6ZdfnoFciZ0M/U7tjp3xAvxQa/0axp8V/0gLGinPL44RT0sir8HOsB+\
7ohx4YbaWiH5wvEo+/5Mc7Oc78G6NA1t57niZr/LZHXsk7hb73LoSdJpP4sScJD/F7oY/\
qWSbAb2bi1hXB5Vxtf4Peh7IuaLe7S3jW0q+jXq9O3x4+Rd6uTz8qa8EZ0jNkybr/\
lTsoLPbZB2MrLMuSd2oXvod/PUA/CbdBTwH43YR9GU+\
8DesASnIvxR5Xv0G3DQlPfXH2kDsLK0WdT7aKfZX7VoZfTaDOjyz+\
D3yfL7Kulf3cPRjOvDirWaFZf0g/RXMw9QBG9srwr8t5ToekHkt4VKvb2WfDT/\
wG00n7F57aQvsogfu8Im1mv1/hZ1u7KCfshrtL+\
vSwTlQzn1DXo06j9y0M6Of1wYiX0csYn43wXlSu1eWdRv1kSODwQ/\
RU8EhNJuBq2SvknkAQxLgr3XOMp8rEfvTJz/rOgf8dnsBeJ/aBHDDtV6D2TcX+\
k3qm55zf7Ssx/H6Dd/fnIc+e9wP+7PET+\
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\
vOcOHL8G9sNMlId/uj+Dv+\
agv0opeZ9zbf0G3QUWlHIEetDPO0O2OHvBnr4bM98hA9ODHPch9iddiHAW/\
3xgIzrLyljohPftzmedB/xIlhLpz7S/n9EaQH9dh5A2YkfKcahzxWK1Ud9bVB7wK1ZG+\
b5Z1lPPfsQXpO/zWFTk2DRwSRSvNOn8gT0GfR12jegs+MFtfhp6N78zvM/NVDm7h+\
UNfs05l+rCOw5iX+Y36IX0nOPxGyTXQTcbbjFcFL9LaKvvsvkY+GpXos2S+\
wr41qszCTs7JObueLqvMg5yOflgUTNxhexVw4hJlP1q3/uiDgwd4zwL6cqj/\
jUbfP7rPe5ujp/T+fZB3hU/CP6H0t9QPt8cenQXenRINXRr5FiE/s2ZjHbNO4/\
2Tg6jj8gmgP200fRLtvMtZ/5z3kftrb+C/Vp6NXGu6mnFn7AsfV5iAfXaHfTHa3UK+\
L6KOy+hOvo/iOwc51gf/XGlJX3DtOHEeZQl5GOpN+NG6TNxNa/\
kJPZlAvzN7rwvfh7WX8aD5jKMP8soIg6706Aus57GM7GexTPBF0WeyPu44/DJsNs+\
ruQ593gL8Rj1zFtZxAPlV2p0cPK8C/Gj1mAWf2vnxl/t8R86u3Yn8GQPOoRr1h/\
yJipNlf/pu1I8OWEM9qb1AfK8eXMP63jrGPNzBRzQfV+M53YjbWKNkXc4++lBaDd7x+\
9eP6EPsmJk64Av0i1S90V9GG3CNtRPENbUEWU/\
daQDve05dqB3SBnr5S5xfzTCQet3ItdDFkm/U9R0MYF69OXe22+\
7F769MfzKlPX0G9SbgoRsb8rJeG2T/gh2BrGfLqthF5xdRVxe1CfrplA0+yjMOORdJ/\
wq7ygkZt8d+s+cvwQ75BH6h2XgB61JW4gwuk/bbwz3Q1b0T7Hdt+\
n5bIxazvptKIGfXEfcxP3C+ob18B/3VrAIfFN0OblDxF9QT1gimXnoC5+\
6Gfxn0Rce72H825wn20cfEYaKJkyr3Izgv8caftx374sc8IG9KWUdemuLijn/\
bxI31KYjcMG685fu3zuzH5Lboz1qfqeMeHwmdNQT30wzl3FQbaaGnNkrc1nzgOhp/\
l0LnIQXRLx9OgVvl7Ym8iD11TDznVNkocZ/7xcPQfXvw54oWZTy7t+IfHAJvU9u/\
UvobHhKXoDjrvuQR63nvOXX6U6EjK199+NzlN+uYj/NVZQb8bx2RfVR/BSAnJ+\
fAL6tCnwKt3VLkSHRT1m/YEN5TxF/y0RP2w+\
EJdd6z8bes7vC7uXc59FMNfHZtHX2K9ahL6IM9WeQ5iBfzrHCZOuc9eagT12z4rtAQrq1P\
CNwY48875H++Aow/cAZ07EhfPqUBOMN6roYybt1Wnv8MpP40gw4uUw/sVKVzC+yfRW/\
gjzPgYFmH+rJ/vo9kXbyrrFf+RTxjpSvxmLPgp1vet+DTPNQj6TOoB1S+huIneMC/\
Skvym7QjnDtpo28gZ9P9gH+XtgT3J7gQ/ezaBFKPWvIw+BPh2FNauz6cEzT7KONWB+Ev/\
Tvr6ynrSE4Tn9J83yK3JlIPbht8b+Xj3Nb+Lev8u6TnOt6DOvueCwVdKvn9+LyVOIpy/\
xnyspkzdJdhPnTqf1nGnfCfldngbdpHqDdUG9F3UJ/lz33Oq2V8bwzr/\
buJrHuty35k5fzH7Aout9lD9ptOfMm+Ne+Ifu4u+6kkd4B/DmcFv+KIF+v4/Y7sM/\
2EvMM2N+i/rI9jPnvwR81J3uiL2tRrmq5zBF0qHXMLujEOJgh61RrmAo/\
gGvuk29vAjQysz+cTA+inHYIeslvQ11w7C76RFoq/a9bID1/\
UXYu8rCf7XedqzL4MnkYe0pgw8A4yjBf4a3rGz1vE3z9KvIkvP3juTVnPXmM8388E38Jce\
5P35aKO2nKRfZijwOs2xw+V+ZxHsX+82rF/\
YWuQ//fI39JajOb3d4ZAJ9VLgdvgGS7oxCzRVeDTaZV6wK8LfyOfPwchd3O1Yb75S7LPtZ\
yQtwPXsF6+49ifQOS+9TMC/\
A6jAbhXC9vjpzergr3lNZTz9feb0BsrV9HnbucG3p9Ug991ewduXnkLfLZRsdDzPHfW+\
1Y12Qc3Dr6aPBN50WXkBvH98ip8XvtE0IHVAPwOI6ANdOBhg8+RexRy/\
M4ccdX6P4MuK8h+YXvAO7DWsv/\
at4XowZgt9AHLlpXPn8Cdsb5Av2b39cjJ5FXokTPgYShf6SNnuEichhD40Mzvwb7k6weeR\
p7cQu+o5/Pw3vHB9LtOWML6Dr9OvyIrDvt1xdQrDUcrVqTXEO++jTsW/\
d9XblWrublWrelatUananXq1qhZt2bNyu5Vq9epWXt09pR5f47uz6+N/vemOQsLWv/+\
Y61w7C6+URs+Ka8NzvqPiDP875/Ww8aMHX081m/OO8vp1GjlY//VOz/ObTgo3b9RqP+\
G9D9hH8BmBZohYjBeKQcZfO+\
9YjIOpYXyVDa83SoGf9VpD0weEAIzfQ089W8EmTxniPuvN90hPh9aANOkC90s7ktz2wkTt\
Q3793c7qu36f1cl2RKbbI/NDsjPecAFtehZ+\
2HCFivFdUb4fDGuhOQd4v6pHcUiKxfuQHRDroircUZlvHEdOdQ9Vv6IeJ7323Bx34o9Yhy\
a72Wa1W8sALhNae9T4vO1NyhHYxlJJQ6fMIKd7whiVj+k3yb+\
PjHRFN8fAVzC2DIAYdHrScS/eemZDu//dzUcNwX9u5pD5kSI+949A8yxR3aL9+\
4W41DqLODvlzqwDi/iUZ6m0y7x99XvF4jnrPpiivUr1Eusu5r/\
KeO50VtcrYgX68Vzf3kKY8cYlZdDqbnlME7cAesw8/\
QS62OYhQFrnFlKjMuodnGjuEY6LhLzbflY7LvarKegBy1f23CYMyfJ5UdyHxXj6z0b46vf\
VLEeymN/nucVIMZvT++7XHx/qBtGWFp6jP9bp2G6K7VY/\
44FoQff3mI9tN39xHwUh6tineyfBVi3BpMp5p/1XtCv4nsPuuzpKuhL0xx2i/Uq7SH2Wy+\
cl2DjqV0Yv59yiPepma4Lerc2GYsZ70xBr6bLCbGehuG2Qvy+kttAsa+\
Xh80T98fUEuPQ83uK+7U90KU5cdIycc1mjhV//893nbh/\
6mpBv8aKwhv43VCxLsasFuxT96/\
TxX39t3UQ15cRYj7K0GyCzo26YwT9acV6zRbzu9VvoeAz/5bjxfOyp4r9UcJixH7oZ26K/\
VFPHNkufpc/RbzHHn9RgLoaj5IOiHHGjhNXK/MX+PPGOvgj+/O98MvI9az7V4T85RLie+\
tQ+03iGj8JOXHbkffuLw7o4IwglHjqbJywOxfEehvtV8Gv6a+egA+\
awMfp0lAWeiRNYk874Wx+qS6+1+sliO+tR23Fuulji4h9N62Z4rPVyqG7+F3/\
yFCxT0deCz6xzn4X+6H6rmIdahU1ocet8F1oMvQ00w2+\
1z8KulV7egLCNHmzeK52XMor3wyTxPNL5kMers0i5q9fqhYJPZXhuT6TBP9bo0etE3waPi\
hSfO65cvO/q/H0/GrxnLmrxXiMK53FupidAHsyluUS77cXZzzI86bzOe8m5m1/\
6ybuazYzSLx3Qz2+79RQ0KHeJa+4Kkm1kKPzCwMmW94V/\
hy8HSPY6zggTXmLouRyjBTjN3c0CxOfd7faLd7bLRDwryXdxPjUlRcoMjl0UshXtfIaQdf\
qAYKhyvkGKOeYkvwuk5TDP+KQBxX/E/dbT/esFt+nWxMqxn3gt+B7vcg49iUHxodd/\
Cbr8nKq2B9leUOx/mafioI+9e5/BL0bAUeQI+tyA5o8qDpBo+1FAO31cmO8rR2F/\
lIyNISO1wWK9THPxyPvTobD3x7zkMcdz6JP1nwWz9ECTiH/FncVcsIO/iJ+Z9RfCp+\
1aQHdeizFSH1MkNDsGIjcm/0DY+GTC3y1qSHybMEnkgfyXuT9/eeJz8q0OIyiiP2A+\
pRaKJ6jVu9PstKyCoKP1dyLxP7pOw+x/\
9enivVWBx6CrzPvFvLIdpi2Vnxe1Ru6f3JZ7KfpFI1xlaUE6zWzLcbw+\
evs55IWGDPp4tEbHu8E39tfqrCufi+Q+3u8uO/\
KIILjXWIxkpusZx2NPRjRrr8xiuID0IsJ75C/EXFivEa770JemY9LsY/\
mJIymvePQt48Nwdfm6PVivuqqtuzL+l/\
II8dF3FfhvHiumrGo0Gvmr4sTxfOmDBX6zLbOCT4zrzaAbr4sFvM2q2k4yc93YdRNygid+\
IQIvlBC901gv+sPF+8pthS7ICaLWA/zXQmcSfd07GOsF3Ix3zrWtcN5+\
PPeIWG3qBVuiPdYheawHhWS2Q/\
tEuO7HkEQYDNBG82GP8wjJ1nnPKkEUUoUxbj2x6jVE1vA327YTean09CZtybWSVuygnlXS\
2Wc44YJOlav5uXwvn0CQdvCs9iH2W5iX7T6t1jvqpZ4rqYu47k1M0OncfH7ec45MT8z9h1\
0/foW4HrV1mHnTF0nnmfFm9DVhEGsX/P1OB/fV7IOrd6ityLno+\
9qteNz8TXid0pCZdbv7UD0Tb/NyLuX+\
8Q8rRWvhFyzll7hd2snIO9dO4v77Ww1CCInROLMereG3oYGoH882lGksvEw8rhyTfTE/\
c3Qy4/6PLdVXuRejvbwad805OK7i6xfvxDk1PcH0IGaVeyv3msfevDAI/\
RB5ACCMktbSSdnmlgvNcdLPnewALtIYr/tFYnsS/wl1rNYJ+jv1CGc8PHLGVe+\
Taxzrcqs2wr43QwmqGmuI1nLTO2CE5V2Fmd3TE7eV+4i8ryZD/JkR5mVp/5dSw7Cnzj+\
DjDAIXNwRo/\
l5VC54Hno3yEUe65DHOvc8TP0Mmsi80jRoJPFW7AXTmfFWXXshPPpcIJgZrEavMfXYPzrg\
7k/ujtO8lmFfWn/Snyv9/vLtcYbQY/603pi/ubTXsixG8PY39f+0EFcGYJCwwEHVIN0/\
ADvktDzw77IhUKtSNJrZpHUFHUTv6BGBiEnzIalpv9bHy2iLaD6y1yY3/\
vp2H9dg8V6WuEf0DcfN8DXHerCf8P38vzTeWRyahfes3AQ89wRiLO84Bj2WmcnoVeNz3XE\
/KwXjoy7TU78nsyFhH1kTnIK/ndVSxUVekx3qcF69B7Den6RYKybg7HHHiaK+\
eoldjKOhCLQZ73njPtLevF7PWqomJc+4Bj7cWaeWF8zvw/rm3W44Du7xgTk+8pd0PX9O/\
if1/oI/WRENxTPM3xroC/LrxX0pee9eAD+6yLsBXvrZ/\
jhbCmCLUnLCVZ6EQy1MhDcNVOuEEwbvAsn/GUtggr+dfm+/Vbs7G57Wa/3h5FrT/JCp69+\
c50IuKVpVyKIM/wVcqp0BeRC/WronRF70OvTH7CerziMUDri76iTO2OPxw9Ev+achf/\
jVxb/uchl4TdpNW8L+8gIHbxUfP+5mdBbVlJH/Be31/g/TqVYj+R0rE/\
yU4IYftC9lfIbeZtYHn46T9MCY9U1gvxD12BnnQBsV3k/\
EDprvg798WwjdN2nNHIvSx9AbF12sr+VUsR62dfOEhQZHcvvW8ciz3K0E/\
PVu33kOmMQcr3+FehsdFHsOP0rz820BLp3LsLhzfscBOm6XkWO1moN37quIFjlr3H/\
xD3SXuTwUm/SE/upYn9Bd/qrnGJ9tNyZBB8bjgfhywYL4NfdSVL+1MavzTAU+\
8b3rvi9Nk7Fj9wvg0fvj7K/DhPg2x4rGP9/o5Abh2agf/\
JugC7e7Zb2ZSRyb9gJ9MYjQ9xnTMcu0z/OhC7WITdN5+zwn9d4+\
LoYyVb6i8e896AEgW26Fjpr9pkgt88s6DbXPoJ4nXMy7guDsa97d+Wwx8eNIOEL/\
BCtgQt8cWskcrNwL+hzSbigX6XURdmkbDTrrkI/2pRr6JWoeGF/apsPis/\
ayEAxPzXQTXxv/tYXiPeNzcb+fz0KfT2vhH2wbAX73W84+7u/LHbq2aUE8bqksi6ed/\
Ajj7hidw79Bt2F/5R+qA92Z6dqgl+\
MtlfRk8W8hf1vR64W9qNxtSN2Y0Ap1r3XAeTbqnb4OytdCMJf2y3mr584gb07Jwd208Z8U\
l/dhS6HtWG+Wbrw9+eOoaxr/NJT/8azqKKQ0+rWvmJ91AXd4Ndfv6AP517/j6azDKui+\
9r4gI0d2OKIIjYG2Mqo2AnYAWOhIIqIgclgg9iJog6K3YqCgY6KYD1252AiFgZ2vH/\
3b95P5zpwzpyZvVfc616xif/6tVuDPhAXafEtsbffu4L3uo4miWq3lvjkdxtwx7UO+\
Lnax8DfH1ogj0cGsL5vZHBC/w1CvrWd5Vj/63Fcf3Y/SPXvJC1kpwskV5PrIu/1z4rvy/\
UrgGecL6NXZw9wP8sduJ+kG/zux2nY14/wOJo8m/tsImPftfbs3669+\
PmijS3ccgk9veDH/hzeB78xaDnr1s8q+ipUFNyb1JF1/HIA/\
DecuFT2OQqeXxGFHWyykn18/BM+ItELvJBUHf/e4QR65pOKP5tXm9+f+\
4bP536HPrh3xz9e/oSdbToA++oXBG5/kgyfU6u+iGv0obKw38rDK+DUJw+\
xr2Wqor9HidP1k/AgZmBbkiFqE/xkkXlCbiX/7xHopQxej7KFH4m7KNZHdXkmXqXe9/\
DL7SeQZNlbFF4m4Tf+sXtP4tLhjsR9QWvEfSkHiyMH9YqxbhW2gLf8/\
UgWv2oPX7uHpLHaxIp3TtbFPldJFfIh/dkr7s+401jcj9miD3g3LZZ1+huA/\
k56Slz1o6VYf2PrGNbny0Puy6sLcnObOF5Z81j4O6nOIPTlNrynFL6MffoTwzrObYj+X/\
5KcqoIQ9kl5z2sw90+4Nab/ujrhy38bkwVcFlDeHD99XHwx48w8btyW/C23vUQ+\
7L7IfdX3YO42j8PeuAPX2mkrmefx4XBkz2MF/yUGjxV8AeGd2HkyfMFSYgsL+xzz1/\
grT3L4KurbMLOPv8Krxm/EBxTl+S61DKU5OVMhsNr/RkSItvPwF/\
cDGV9T62Hf2gWSNzW6i/yUbYqerhmFvodZsU/scQp+nBP/OW5AL5f2A0/\
eysQOT2dyv6vy4AfDnsn4nRt2WritlmH4M98ksR+\
K2FX8X8HmrLupWezT72mcb3ig4iTGlaFDw3OBO/Vc6dp685p7EzaH+\
zagMH4hethyEXIIz53fhJ8Q5n+XO9eKq87C/K9XuQFlHxnBD+kVB3CPsTPxQ9+\
oGhBep6b6zT3wv73GI2d+QPeUVZ8RE861cAvz3qP/at3gSRvxEx+b/QG4r3QQqx7yZ/\
gliljsHtTLP5pvh/yG/ZXyKN530fYE9WpG3Lr017YA6VgcfBgmg+8et/1FMGGIS/\
mkrnYwXEF4A8ilxFvLV+O/2+Ff5GengU/3hgt4gnjawsh78awwdiRJdhv42BR1u/\
lYfDKgv6sVxMnK14/L3Cs4ZJjlriuPFO8lz+fi2Of8oDzfaaAHy69Bp8s3ouf+Uj8KpU/\
iF1NNbEvuxjarf0tT/HeiI4k2wrJJDsjVnBfw4rjb14dwV6EdxTPJS3zRT4rH+\
H6EfOxu2vKWElritOU6PfoS7PCPN/xGP4/6hv6fTOdda3TAz/5uT/\
Fgg87Y3ec7sAXJedFvut4EfcW6oe/9aWYSVniiVyVX4kdMf3J+1w5L/\
gldbTXcvH95Uus6/SAd89VG39diOIp5UMyeavIichnvV/cR2Rl1vW6Vax/dyG4ofMB/\
OQt8Jcc24rrdCC5L/9RsI/rZ4DrWxjCvuovu6D3Tz3BY+WrgufLXhH+\
Tc4sIORT298Vedo2mn05RJGP2SmZv2fO2sDn9oIXXw5Dztt48VzVLuIXnPNjR3qOxa61S2\
G/HHvy/qNVtHGgGjzOio7cV2kryd2qN3xadnf0rLYb+nlsMvHo09bgjQSS+/\
LFfOjNGfJUxqI/\
5KMuNYHfrfGM9c0xDNzSb7zYT3XQT5EHVZIqoN93KQows9Lwk62W4kf7dLMOUWNYkVk8H/\
vT+zE4YkJO5KvGF/xFXLzQQzncad6Jf59/5kKc/OQwuO7xKfTO/TL3ea6ByAtICx13/\
fu8dtlbvNd+GMQbix6Cl/y/w+sFwvspheeKfTPWyFH/vic7hG8Qv9epMOtvf5/\
1Uq5bPOA79Or+APzEw5P4iSpp2K39a8g7Pk7GfxWPwo7+nUn+\
seAXCyd5gDcqHGd9nerCW0ZZTZg7m1A8sfA/\
irUndWddq9QgvokPwX70zg5eDz7A54604O/uTYkf+ufjulOaEd9umwovkI1DF+R9O/\
HfFZ+jbwfieb6CV3neSUno020/eMPCq7HD5YeARz8sI/53wk9oBzjsRa9BUYy++Dr2/0t+\
cF3P/tjhvsnI05k36NvKz/iLcGfi1l2PuC+XDPDu8FPg1tLu8EM97xHPpZ7hd4ZY/\
uwDPIfy47yFv7FL8ozp+O+9JZHvND9wc38Lf9sVRZ9fNyBv0PQV/Pl3Z3iRzBh4p8rr+\
P38reD3LnZGjlsWJP4fkcb9HOK6ivsQ69CIY+z7xbb48bCR/G4Ny99WsQ69qcfzK6/iiC/\
s7NGLuAvI1dgUcJBPZfSkegdwTMtGYj+U1R7Y30SbE+hbceTTvwh2KFc17G+X7+\
jx5C747wO+/\
L9xGtffRNGqeYrDerQRg8GjhRLIn157DW6ZM5D4sOt17F1oNvZlPPk2ObQQOOm5HUUwthQ\
Hy9/O4X8HVkAvRmEfZe0V9v7OD/7fMJN11jmExXDugx0ush0evi88nHKSQyzMtGPYl/\
IjiVcW2gh7q3vvE35Ia/MEPFnnB/oXlMeKI1qRl3joSD7JjrhRinMFF9waw/WG/\
YXfmngAPZ2XQD7xcQT+4+gz9H2mC78TmIy9ynGXuGrpL4FfzHD+b+\
wtTnHX1x7gl6Q3yMWF3+zTMTvsaPAE5ONLe+Q85Sp5wQq38Cs9xljx7y3W//ID7F1dR/\
SxgxUvF/mAXv3R8DM7sT96BS/kKHkj+zBWRx6yF8LvfFvOeyeK9uTufvjH5otZvzzNuK/\
pz1k3j2XY/W05sDs2+BlzYlnsWMoIipHWcFivWjaC7z+mrkK5egkc+60R8cmsL/\
BQ005jR8aYiezPcfR55np45bhHwj7pF0ZYebA4+\
KMvbcCtng7kKRdwv9JX8sD6heO8vgrkepEj8EuzXVj34Vbz7qgm7HteDr+VLh+\
kWCvJjeLA9U953hMn0dcj7vhXjw7Ej3Xt4FG/2nK9qNPsQ7ts2N0bHvA038/it75kAwd+\
SsLeFnQAh864jd+vy+GgUott4O7TJvIZ+Yn7f5GT68wpjf+\
88An5e1mI9ZkQJfCWrtzHTqSEELc9SUSfDhvgwiLD0MOW77Brv7yw944bwIvtLF4mHn5BX\
6aRn0++Y+VvaVrQazVjX0c5gruiOLRJnnMYe/HCj/\
VtDx413s4mzi7M4U3asrf448blWIcH6I1yZjl+PaMb+PRQSez/\
4Krk49aSd5XGdyVvmncHfsK5Fus73R5cGNUSOb93yTqMuCT+Mngt69wqnd+\
NXIz9WXuNfUichPz++IWd/PyYom+jNnnGiqfF+pvXEvEzTuB840kP7H/Ry+Dtje/\
ga4vBV6i25BvMsGIijyevHABuHGrLunW0Zd3kH/iZhW+xQ1axvpJ4A7/\
g7Eccex79Vv5UZT+q32AfwneyPtt2si5HW2An8jVnfQemkp/uNUngMs19iagLkvY9Win+\
37QAcW6KJ3j473zsTpvF+K+3Fq7+Tpyn3T+OvI34gX6dLsP+\
DW3Huru3EHqsZDUjPzP3HHUZvt/BS3Zl2Qc7Cf12v8/6nj4Mzo2mvkS5J4k8nXGr0bZ/\
r9K0x9v/vWqjPVag/1k859BI8Jz+\
g7q0bCHweh9nY2e8LZ7MifvWCr8hT3PcxO60TYMvzbTuJyaK/dvWCX7ieg/\
ez7MOmfv1jHi90CjyQpWpe9FjrXjGeRbFrKXfUnR9Yz1/r1gGnF+J5zRnUdypXbOag+\
cU5/UdQ/aVgeSBZOkNdqfQJ+JMGx1cGE8zqvKB+hvFpTh6m/0EfFWueshlp1Due+\
Zr5LbLFXDD05b4rYpt8M/jPyD3a7rwueuXsUebq3Efx4hz9dg/7PvRPuTnqw5EL0LawrP/\
Z633p75cr5stzz+WQ6u0gaWsfE4i97WrHvij4gD0aXEJ7G8Z5Epzhm/\
Q51ckb3P7PLhuS0l4uv/awUfdK8m+uNmgD07DwaOBy/n72/\
ngjXmH8bsLamNf3hdELurBg0lj7sNPtSOfr2wEt6kn2+HPvQajv3mGkv+\
YdJV6wx7ZwasVGmFHYlqxHj5W/O5ZiLxEr9bEAX5j4APf3yevttHKey9/\
Bi7dXxS7HfQJXuk6eS050Q5c3bkS+7vpC/fZnfVS+sAXKeWpy5EK/\
iTO30gRvVrgDL//5zK8uBSGPYlqj5zvLAleTniGfe2ViB5U4/\
BsvTBNM6rzOuxB2iFwb9Qg5GZgK3DhS/JSZsoa5K10BvYr8Sx2+\
kJD7NzaZuCob9yPMuU2ctFpD/I2wBacFnKF628rgh8bRvxj+\
lAvKHuV5PvDnmOPjh9F7jrNwS9uz2S9aiyAz2wTIOySurkN9ZMr8uJfDjTFDu7cTR5tYAD\
8UD9wtNngGHr/iHyN9GuM4LP0394ifpV+7hX1rubmDFFfox5YjH/\
6jr2WjuxAn46uQM5e76C+YXNX6kEuKPy90Ap4344/2O89c7Fn46lDka/UwJ/\
uyAVuDbVDb7JdIZ8sk4fUJh/j9wtVIj98dwZ+\
6moNXmfkYj2K52D9dtIkoO13AJc29Oc5c5WCP9ZD4Zn7zaBeekx38fxyPPVhal8H7MGAF6\
KOUFl4hHqhBVa8dOQx9uY5w0Y0G/JU2gEOW5cGcIi1cf8z9207Bh4+H3WV/3NA3O/\
OpuSVx4CP1GTqDPQr5dGftAfg1diRxDtaBfi0h+lif6XkidPF5/\
50Hydeg7NRH9GcumY592L0/t4moaf6r3B405ODkef3EuuzvRTxnvt/wp6Yc6y65F4dqZ/\
MXhHes0kL5OesPXj15VD0oOlu4v6FVnNHAZpG9SNbBa8rv1uy+\
9919IAZ4nrKQTvyM3bL4JefxJKvfTyGvPhnDvFTLzbB7mRmsB9DWD9l70fsbam9xHNJ17C\
TecEZ0q6v1J+nfRLrrl/KzvodH8Rzfm+OnFRojT2qtgU/0SUFHLXuKvIRflzwqNry/\
7DPS6sLPZNS5mJXzk+l2chjCs1kg8YSjx79hP3OW4P3J2yR0yfd4S8STpPXKN0Iecvcj1/\
1O0kz1sCGDCuYax1uWCCU5qIz6ehFHl+um2MR/HIb6vYMfShydySTfXEHv2npk7FHR6/\
AZzvHUPfZ/wF5074Bgf/\
2xZiaXeyP3KOZkDPNfrSo79Y9QqmPOD0NnGAzBHmws8UfbXuLXDjPxj7lh99Vy5HH1DdeI\
d4KvAmee+tIXDrICzlca1p1VkeQC/vz5P/GfyVu/vGZet9mNcFZI3yJn+\
NDrOEeP9nH7OWtuCYn8rCZPLp0fgnXX+UHzprVD/zUi/\
oYWbd4gzdlsLPdgrBfoaOx11d3gHdm/AaHN/Vgf3PSLK31HApfX6Uhn/OnmU96Xgm+\
ZuJK9P52oLAjZs7n4Mgyla3mF+IL4/JS/\
PFF6gDUfTQRGvmGYxeGU2clq17giGlnyLOchueXuv4S11XmOhIXxGOvlNXF4IfSj2Gfpm6\
mKarqCngWj+as55AKrG/1HsTjf6jXMzYWwk+\
t34E9uUP8bA5YSHPb1BLghVKLqWuqaNXjDHkNvpqVxH2tGo596feBeLikrxX3WLj/\
6zDyQZUM1qv3Nq6bocOHnrAlz+ibJPTRPJwyQshr5ogEIafFnVaJV60+/\
MDZW8QngVazfA34R3ky9Spy3Y/kGXXwtn5ynOg/UBrQD2PU18Ezj9pQV9eiD3rl/B/\
43ysTnP57wKF/v6vlHXLs36vyfsVJ8Tr9cfy/V+\
lqMXFdfU4Xsb6KxxHiw7ZNic8ylqGXa2XqMK89B4f9+\
Mk6RRQgjtqgEN867cOvf7bDrvQifpOqTgW3uzAcRX7QG/l6XgHc4rIY+\
yZZw4MmFMUf93kmnldqMZY8YW3ysfKX2+ComD/wXglB5HdC1rAOgcQd+tJC/\
P8EeUAzuTRx9/o54MUiG9DnlkHrxX6daEMeasMC+mlM6tHULQ/\
Rt8qZrHviUexs3C7qETrvEHlNI9ZP9PkYL6n30YwC5HMGXLPs3i3sYIM0/\
IhvC5rJ5ljN7r/XWcPC+1mHwjzBb9UfB5470Bf7unM1cWLf1sjfKy/s2Rv4QbV+\
SfBZPRfigYqD0I9MFbk7dZzruXijJxOGsi91GG6k32WIreqewiE972Rx2LzUU/\
kuPjdwszjMXo3PyCZe3/vnFK9v8uf+92rk/iFetRtKLvH+2RnxOa3Gpb/i+pfTv4nfP+\
rzSdzf/WRxSL0RP4FhtcW6gqez4PGV3b3I5x9fRt/JpezUuedZAa81f+dKIc91Wwt/bjw/\
Sxy+fYKomzNDg8T3tKbFwYFf4dWUoq2wkw7B+\
OM8dzciF6Xhg0ZlsO9lryOnngOI94dd1XifIvoXJJu9+\
IELxcBtpcB18ogj5GHPHyMf0OwvfuX5MvyTXWn06PAAmtPHrgQn5K5Bf8TGeeCqVvRdKBc\
3g88HzEK+LzzDbykF4Aea6uhr2m/sr2dr9KV0Z/BJ5FD8Q1gT3j+ET5Mj5iKvr+/\
i1662ghd7lMND3H/+vYHi+tJr8pZuy4nna8SL5zYeZxsovrfu6ZZ/66/\
nfR0ifudldfqwVu8Xdaaq34JpYp92LsSeNqAuSIulftysMx5eLQ2/\
a6yZSz7vxnR43WfUSZt/sxG3BkUJHKeNcw8S77NeThPvR+pCf+\
UF9agjcT2Jnmc0xM8mrsbeDazE86blJZ8TXwLcfMAP/\
5PQGb9d6Cdycr4Jf59A3l79ek3kr/VsC0XfmLqz8yLW4zp2uvFJ+EvHlla+\
4jj2p4gCjrvpy/5mPoQHv74IOxGRl+e1pf5NMo5hX5UF8L0Hp2OPC73mdeAHcEGEOVfI/+\
c2FcT9RpJn0vZ2JY6pAh8qTY0j35S2GX8T7gM+6ErTreqaAe/\
frhdxfERt6jEfpNN3eaOc6JvQat4Sz2+0suH6uTgcRm76Dl7rSQ9wQafb+N/\
gpgK36gl1Rb24Gp7G+r0H98kTfagruH5ZyIui1kPvm80Cj6cMRh9PVINHz9YD/clO/\
KC1WmDhV+pBpSYMh9ETqBOWw+i3U2a4sD8LroEDtLL4H5uBXMf2JfVKd+\
aDv8eHIgepc4jfHm0E9/RhWLCccRs5fZ6XPiz3U6L/U3nQQvBqekhd/\
P6yeuxfgSrEWU9TyR+2vAD+37CE/NW74UJuZTdX6xCMosRDHePpd/rxn6gDVP7kwN/\
mOoV/G5EFLrrybp34/fF/qe9ZYkd/07nJ9OumDuNza1Tw3D1/\
7n9LqoWbq7gKfa2xJkm8hr9J/vdqbispnkftniX6D7VBMaKvTW/3TsTnRr9DAl/\
o56aKfLH8d7WwB9LqWKsfhjhI6dgSXJe9NM9dcRp1avuC6E9bix2T858Rdlx/\
OVnYcePbLvJ49Z4iFxfIh8jyWuzi0VvYhVVR8MPp5MHl/VngiKbewl/\
IWjfq3zd3QF62k7cxdrUC1w7oz77eq8u+fwXnqf6liAdDOxHHJdUVPK/q1Lw978vOEK/\
PE3ieVRXEuhnlPDaL/fCuf0KsX+Vvor9T3UpdsZarEHbluR88fZIj+lOF/l+\
5SQv6eWs3FfsuDfk0S1yv2Dfi9IHp2O9LM7GPw+\
rR7zVwnJBDWS8i4nG92DVxP1L2s3vFfeXtfAg5DRWvss+DieLvNhdFn6uS1J3+yf1ThZ/\
TTnqhN7/D8QPdsvADtf6Szy5YFt7TWIQ9Gg5/ojY4BP54Wo7+\
uHnNhJ4oC84fEHJ18YKI74xa2EUlgTjWdLkDH7moqpBfrekD/OOoBvixUzuom+\
qQKfyuOdCVuLjZjtniOo0PCp5E7T2D55jZlP72lwOxS8XK03/Y+\
b3oo9V89i4S67P9TIx49S1LfU0/B/xh8AO+N7En+lOU+lOtnjv5wqD57OcX7J7+\
4b3FT0YSt/R/jH07+13U7yt5W+IHP5/j849iyQtfiSC/dywOXBG+\
far4f59Y9PxObvjeU96899WFvqkno06L5yi14Kx4bf/9qFjfkTHo9yrqktTh+7EnUZOE/\
OhNKuK3xq8X+mzWmiLkQ3mYn/ih0zr2qdQo0Z+sjPMT66hfmwd+aF5KrL90OQHe/\
04d4qdauYkjbMeKOgopsvFGsa4ODqIvVmp9XuiLsbAc/tHxD3m/XB2Ixz4OtepDT5D/m/\
MBvVh4gn69ut1FP66xq/xyIb8fN2I3fnbCj23JT5zR7QJ6W0inDrZva+q/\
O2QI3C59qo1eLXOGpwqgn13t25/n+fqOfkS1NvKydRf6f4b6AvU48aM27eo4sQ/\
JfYSem61HiedVazTh/sMXwZd75iAuvzaFfteaofiDnjL5ovnZ4PUWMTxHv6yC+\
zNeEj8cr06druM07N2babzvDk9kuieCL6ZLc8R9tFog9lNd4kr/\
8bhhApep7u9E37jsehc7sjmXkCM9Twp980YukR/\
6nx1mXsOT3yKOlYZliTyRETwGe17JYah4/ssDuc7TcvQN+x6grnP/S/D0sUPY3XWvqT/\
43ngm69OQeqOvI5Bnxzv4rfYHyXfFu4i4TB/Zdoi434ZhFl7EzujqCPyx3w/\
qEZaG8Duj14vvqStuzha/M2Sl6LfWOnjAI6bIS8X7r1liXoVabndL8fmHtUeL5+\
zePFL8zvVz9At+f0X/eBL1EcqoueJ35BnPWPeWd+\
eLdQt7Ia4nL25MX9X7HPQ3XywKzki9xX0deoEf27WWeRVrwJPmgdETxO8neYs8nVbrKnVc\
Hx4z5yCU+mep4j3sQyH6zKRcb7ifJs2opzO7gXvSUomDe26AB7tFHlM/\
0BM5P2Xlo7228PdD1Nmowd/5/vDmQn606nWo/9GtPupA+GyprTf63pH8r374ETzw9wT2/\
VIx8vQlwbtyb1M8j5HshX9LuAAuXc8hLlLQOPT2/\
ieLt3Iiv3tsC3pWex38UfXqxLMhb4nHuxSkTuUJ+Sf9CHV/\
0h2rrmnrcPIxr8PxM0GZ6PesitiDq+QL5HZF8Ffl4I81++/4534twAOK1f86wJs4/\
FoQ8Vn3fuCZAjm53/\
UzhP7oztnFPqq9LrGuVwKwdzOm4Re0qfDIBeqJ9VErlkIuMvfwvL6t8OurE8CPQZ3Ja6VE\
w7McmEmct2kHfw+9gx29XljIgSpJAm/Lr3LDjw7LT11zfnsxV8X84ISddaT+Uz9iHR7Z+\
Av8htcL+OAOMfjBzu2FHkoVDgq/\
LckpweJ94D3s18R44uUH9N3Jp8n7mrV24w8OfwbPjDiA/u0PEXGb7uFLnrXxC+\
Ev5KmPxf1JuemXMO2zIS8/Usmb9aafSS20FP/reRnepld97MHo1exXk7bEk2+xs+\
qUctjjD/CtZt2v+MfoU8hNTCfWL24s69W8PvYo22389b0Xwg6YixKZg+I3ArvjSJ+/\
ktMRucvzifgt6RD653kOnDYmljxKWAhyHNAMefdph33Z7zBYvB9xHTldmIZc7RsEf7nqkM\
DTSlod8Mfdpsyb+J6XeR0x4H09WxT+KSsC3nzvZIFz9LxPDv57lQ+OWCvWf9Am+\
Kv6TmIfteJ7tH9/N1qNsfgWD+LTVIV84K8Y4mq/MCEH5oQR5GNXegg7qf+6Bl/\
evzm4upFs5YUngI+GORNn5Mkv7LAUdnui+Fy/cOFn5NW+ou5Uy5Ue/\
u9VifEjjlpZCN4ynvkeRp1uqvh86YUCv2jbV8Fn1j4g5qyY0wqIv0sJNekzu1UH+\
bOvj36t/oD/rT8V3GBLHkurSD+l3MKROrfatkIO9VZTqF+PO02cMuq88K+\
y9yWBs41lB4T/VDxnBPCchYWcK3ot6jQmBsDvK7sY2rXgJfntedSN6t4PsJdr3jAvpp/\
nIHHdBVPGnBD3cQN+vs5iK04nPtC6LcA+TIulnnOTRh/oH/\
pjjHs3iM9PZKMOaxPDd6WOruSpE3ahh8vq7RS/V6ot/dwX53HdI9TLSuubUy8RWJm8d+\
lp6Nn9ReCmbJ3wy+/\
98AfuJcnzrLb6Rs4kMjdHqQjvkW0hcfHChdjvdvTlauVGErcPzkYds72tWF89ylfgD7lBH\
vDx/nPYp4p+Ar+pQ+PRx6nVseNxGcQf2mz0LNPiyzotIJ9XSaWecKyVD7pM/\
6ZcuDm4ONdVgU8VN18hl8bBEkuE/AW2Wig+lz+EvMi86/Btw+jLV3eFY/+O+\
4Nj5zWbKa73fiXxxcYv4n71swOxN6M2E6fOdhPyYN4PgOdIdAM/\
2YeIenIjfSN1OF0Po28VqYPV0qnflY6OIB/g5wZv2qkkfmrqZPIy7a0hbW/hm2T/P+\
QZgsijaCs/sk9Gcdah3nb2cUQP8LNzADjlgQ14Yfs6fmfvPuohZxD/qJe/sh/\
vf4r5NLLSEzv+uQz7LpE/kbbFEmdfpV5WL5JInUXsO+TsnEHd6oY35If6PYG37hyC/\
7y4Bz71UUvu450EvtDLwpcV6U48lTUDuYomT2KMaUucrQ4Q+\
ywFbRT8gv64C3HtuCT08vot/MDjePJ4kxKRk2scJmlo1fCTI2qBd9b1EPjfiC1LX9/W3/\
jTzZ/Qv+25WO85+ahzCGX+kpwaSPxcqSR6FlSB+o851nyHyfDU0nH6DqQr8ayfQwD+r2R/\
9iPnN/jAK+epX/ht9SF7cX3z+Vb6b39TP2I8mY4/fD6feLY/dXlG+8Hs935r/kfgIuyWA/\
03+hPqRFWXPLwv4Md95TD4/flNwBMH/gi5NU+\
1Zh5TPvCeUYq8vXSoDfd9ZBD5SMWTfFhSbfa/Pfln2S+\
A6w95KHCBdj4SPzjgFPniS2uIRy+FU09wkMO85B7rqHMZv4B9PL2IuT62TfCbd+\
pbww3vwOsdsvplKnbjPv2PglPejmOdc/Yjj9W5Avt0fCzrPGkB+7uE+\
ki5SwnyPsnfWMcG+ccKuTg3EfmPOYNfXHSFOOKX5R9b3CCu/\
9kBXrYA80fkI8n43zmVsAuPylGfNsaPPIkTfVzqdGsYYoBV51HBFblp5IR9Wr4PnDjXm3V\
oMVLoqXx0BTzKlmfg+\
fa7yQO6bLbqc7ayLvkOcr0L27DXLRXkZzV5NGXPSuzvyyTs0VCGIiqRXtjbFRZP/\
Xo2cvnoPfVEedshX/YDmTvVFz+\
m1v2MnF29jb5PH819bdOxrwPWElekpRHvBZdHbxTq08w/1BNLr60+/\
Bar0JvhMrhZ8gRPbgydL64XkJ888y36vKVr09nH49SFyvdagWMbWvXNuTXsbe7v2J+\
5J4jDlo/jPmdYffMJ9bnfbSXhG88r8BB9kuGjH6vIyTqD/Usta/Xp+yL/\
bxNZ97//8Ty7w7mPJzyv3pM+E7XMVfxck1Pc90EP7N5qi1853pd4ufUxhlL3aIj8/\
IVHU6Y8IH6sYyPwpfy1G30fG+\
fgNwqSlzdGFqPOKGU363jhJ31sRabhn7owT0E3W8Jvz2G+o/SgILzHm+\
ge//RBvtYDP7iwG/FxgabwePMX4LeOOJKXtPdl/\
sykGdRhJZbD7tZhGKhRcDN45PcF9OdpG/bZC1ykRmbi9+/\
MghfOQ72tNNINO9BgEPpYLxK8lO8WeGy6YfWnU9dhPnfGb34Lgb9+sQv7Lu9FTy+\
NpT5vdyvksko8cfjKUHB4yjh4nXwMrTVH9cPfNtgMX3KnqcC7Wv1BxNmzVOQxIoTrZqefz\
ciWjv+Ipp9Nn5kOD3ekLfJSrDX6lZWKvWhYmzjm/A7iiTOnrDp3ndfxZ+FV+6bTx1LeB/\
scZ9WFeYVwvU+zeN55+\
H1tEP18UlOG2EslP1DPEVAVfdBrsX7tnmAXFzOXyRzSkfjl6CN4nd2p8Bj9T+KnXpBfk/\
YTR5kzApCDTj3x353Jr6verL9at6hVd0+\
fummcZ79fDATvjqoNrihCvkbNvIB8PWbOjhE1ARx4i34x8y79TMZH5gao1a+\
SN9yrESdshR+RFtxC/8KYKyK7RKC/\
VXtjhyqNAje0DASnlMFuqdvLU197i7pNbVAMvMTthtjfKzmRp5ab+d1ob5FnkD2HMy/\
C9uIUfu+mhQ9PoofBtuhZ4UDyVlOxI1JP5tHogcu47xhf7GodD/xaIHhDf3cI+zXND/\
2KsObhdK2F3PXK4v4yAyx8tpB9uDKTeGbEGXiPNPoY9JH5kQcbB+zOF/q1jZM58VfNW1F/\
dQV/p1W/jx0rfgh7lzac53kL3yI3noMevG5DPX96Rfap0Xb8/\
KDl1lBthqfL7TuRP5P6kdddlYC9sHHH77ynDs4cHUnfcOpf+\
uMrcoiZfoJD6uTEUIacR0RbQ5w5JEy6U4Y6jUrTmZN15wKHFGzOxvtvyfDtC+\
Btzdv4O32kPXGJ4xZ4o4wU7P9ReBalFH0QmoM3erSlPb+7eSJ+dDWHoKkPmVugr2+P/\
pW4x2Evv1ZQ537DGja/bhHf2/\
mRfpw8//G8Nzm0Q1lGH6XkonCdkBIcPrIigP7Jo9ZhnDH9OIxg+DMOmdj+\
CbyWmzlZepVq1CFsHksdS7F49KkUh1srA49ac6voE1Q7V0U/GjTEX/udAleMWEEdy+mH+\
KcWbVjnFdS7SS3diNNjAgRvIRc/K/\
RAWz6beqmI5lznFocjKDn9wHelR5MXruEDn5PfGf5z3Gbw4RkFHjorGj5lfyNw555Vlh9g\
nqV5j3k8+s0l6MWoY9i3cOqQtU1dicue2sDrbwvGHsi70J+\
DjsQPl15yf22tdaw0gPqH8eAKI4v+a9Od9dOOWYcG3oT3lPauxB7+eG3NgXSm/+\
ZMf3jA962xXyWaEZdXZq6cUSmG+370ErtUkj4Z7WxL9PLGSupY1T/\
o2c2J1CdPr0MdzVjylro6GX+wtQR+\
5dBlcIMb8zL0c87YBwdP7MHHPMhXJPVGxunjPMe6Rfxe66X0aSSewL40/\
ordznzJusgc2mTW9ea+nrvBF7v+Jb87mT5J8z/mEkvRLvjXT2XQ+24NsM+\
v6XszDwXANzrNglepb1j1B1HMQ4x7Rd1Bpdu8f3UYv/jai7jt+2rs7pBoa+6aM+vxEZwo/\
5qDvHqvgLfdEgGf0rsf+FF7BQ+4eTR2rv5lruM7l/\
05FQCec85mHZaSCz0tPRK7F3sSe3mYOXn6fPCyXEbi929YddrZMljvUqOxjx0uElc7PUWv\
1oViJ9Jvghd21CTvGX+Ruccd6XuRLzaiTjHPfup+l3AIjrL2AXGRp2nN2/Lmedv/hu8+\
M88aWo99UZZmUD/cdgH9goEB7Gsp+ghl38b483b0H8rBA9C3ahPQn1oM4dcCp/\
McG6tynXG9eK3syvPaWYdu3ypqHbrG4ahqfw7FkW3f87lOfalvPnMPPfyPeYt6u/38/\
VtB/v66IPofi/80x6jcx/yJ+KuND/DrvtSJmE86W3169A9rD+5SVzKL+iZN7wt+\
y3Ma3u7vNavf1IU8hvYTvLI4F/0G06hvV8pR16cXKwfO8WqHHt+\
gD1Jz2mnN365q8VoW3nxNP5OUxpwfY8At4olMCdyYnfp7LX4Ffkmm39dwXQweeFmdzxdF7\
/SCk7n+smHYpfsWTpsDnpJcR6O/eW2sQ2ToS5b6eYCvv68Fb+4YgJz4dwFfL2C+\
rXExkued2ALcUKUBetN9CPbTjX5spSKH/EkO8D7qUuJT/Xka/\
OaGhujPIuZXSF2Gw9tGraQ+cE8n9McrGXvkZsXfA+pwH3VbgWuW4Z/kzdZ8nc/\
05cnuc8BRR2T0cccW5KVAOvo9y5/7XP8SHHSJfky9yhTWs34nXm3C+J21Q4jHPVZg310s/\
V3OnEHDtwrxZdErvK5Jws5eZw6H3OaqNS+0Ivo0qxT4JfAuh3csu4f8Zz2hfuPWElH/\
KlVIpE45VxFvsT4FwgX/qVeeIepN1Llh1POF3hf1FWp5T+\
zhf1vB05vBt3p++qb1Ke3BA9mZ86tPvYE8PwumLm1Mdvya01MO2ZrJoWzqCw4xUrsd4PtX\
q6IXMjhULf+EvM3T69acM0tO21jzCFbPtw53oD5aj3sN/hsH76AFxyNPy+\
HF1ZhEPreNQ4fkOvv4XCtr/rZPF/\
JwJ1Zb8xMuEQfbWX1vGnyoVrqbNe8GfZTuXkceekVxP2+aYJeDvfHLj6aRhxo5inlgT4+\
iD4OseQh3PmMfVgyj3qtlDP6pXjfqSkcVYu75h3f4/al10f8dVfEjagxx/7CJ/\
N7oJPQx1xz8yCGddTlaFrt50Qk/HByHXRm8B/\
v2NoP1KsMcXMOzBfFCPQU7FBuKXDegXk1fF87+lfbg8B3PPexj91/\
0u4xnzrt6Yz1ysusV/FKXaPSkKPk9JcHfOlRmD/00jzgEUJn2Flw5tRs8WNA+\
8E9CH3Cz7Mi8u+9ViEvkflx/7UDiooJbWYeWodjnjYuRwx41WQdPDl3RO2YDn3W/\
An6b1w58USaPyF+rbw+PFHqz4oSIY42z8ORmKvGgebkKcnr4BPUDe5hzrg4cBD76sZW8X/\
sj8DndB8OHNqSfX3GEt9JK9MWeF+zFehWnf1T/Cg5SDiWjF3kvwPusbMl9u10lTmkym/\
cXmUeh+zIXQi9Of7beRQEXjHRkXa8V5JCeDcivedHd6kuOoV43uw3xpMtwC684sv6DI7A7\
EeWIQ2w4HFWx2QJ+O87hVeZwDlfRJ3Xkecv2xC88p99KqdkbO97eCzy16S72OHU/\
eKbQMvBGSfyNVM+VQxOn0/cqBz9iDs815hqaZTqAlwrvIq7zsA5Jt+\
rszTzEiXIJ5k4pTn/wb0vnUSe7bTY8n7PVj6M4YM/y68QxH7E3mvtR9vsA+FgeA2+itZ+\
Jva3Codt6TmtO5kFX8hrFarHODTj/REmnbkHf+wJ/dJc6eP2/LfzfJw7c+Qu/\
bC45y99XMBdfSd5BPbltb8HzSokv6LssxtxW/U8la65LDPWzdtRV6UusOtKXwdRD+\
ISS533TkfxGxf3IQYK9lS84Cm6zoY9aS+lo4fE4/HTHptiX4o/Zt6+u8MQbotgXX/\
rVtawD9In9uEG936wl8IZ9fpPXr16fOu2I0dYckOnEv1M5RFxv9Bq89cgTfN+\
DejrpJfyaOciJ15ud2Kdg5l5pQ66x/l1PcL/pp7EfqZP4vAP1pFrAe/\
jps1PwQ7Necv39Fl7tPRu9ulSY924XwVv9rbmxQ23Ih9eMEbyeFhkm8vOqbQL83lr6KOXd\
buCNvda5A3e+sg7ty8L/K9nZ12eDRR7EOFiWOWq//KiHWzeDfGReKw75E4z81q+\
NfVskcbhnS4O4+th99MpzJvY8jnWUhzXAjockEw/WGinqp/Qia+\
DZU53gnX4wz0x94Et8sPCPsHPmlXUi32mWakvd/ccCwl7qz8JY375zkZPKvZDXPs/\
pc42MFPGjFjicekE7X+rPP+HX1SZV0IcW08Bf+x5RtzHwqjVXHT7b/LQfvXS5hN0e3Q+\
7f6cG9enF0tHfHkH44xxDkZ9allxMqUX+ZBdzuY3yHFalndkMvv3LYVnqA3gkow71d2ab/\
cQb5dzAMQODrPrwvOjzOQO80oi+JGm2lfdbfQP8+qQsetiIuSPq9IfEqQ5bsfMN34GHw/\
7jfp9XRe/yuyHHLx9jtyokk7fzuQlvHcr8buPZf5Z8j+\
PvH36JfTR8f4n5ocp9P5EH0T2XgjMet4A3zpNLzBtTS+5Txd/\
bDqTPLf9U8qftniIHjWNFH47W/i31kREcIqiE/aY+YHJz+Jbm2GVZro+\
fvM9cAO2vI3bsSz7kqfde/EBqLvgJO+Y0SRmx2MuEm+Sjv/\
5hfsWGhfQN1C1BHj3qGnn1UX3AZ5UPWfU/feh3TR1N/X/IJPDJ6AWsn8acG/\
lSTfxq5bPwB2HW3IZIS67s6EdVt+2c+\
u93pfitAicbQXXEOiixRalfDMxg37dW5vkSh4D7vA9b88eZtyvVLE/+68dm1tV+\
MHFgFdmqTyE/Lw1qZNlVdw5J1jg02liwlDhh6HLi68rd0YfS5E30VcxPlZxKMd/\
6dzTrOyMWPLjzE/b8sSPyNrwldaeZzLnQnyVir6OYJyBF2WEPG5Nn0G8UACf+yWnNR6D/\
ROnKHGo9fJpVP+2AXJ1lDq05lvhJ2VgD3u8zhzNK70+BJ8byfXMAczDV+\
Q2wy6UGM2fgQ1twa0NrDskGRwtnMt/\
XHMccSEXmEEKtTn30NfAOeGYC9ZvKZHf8iwu4SxmcC7t+8zrr2+wm+GDWPWsdK+E/q9I/\
JTViLr+Wjz48vXMF5Ha2DzhgWmnijbAUnsM/DXyUzuGlahUOIzTyR4I3xk6w+\
J2J4O4itqxX4drIZ/If7F6GiZ3/yjx06dB1cK/eiDqlni2oe/KEZzJtl4s+\
IemtLOq6jSkXhLyq6zqIem+j/K7Ef6/6yBWir8moyDwusx3rYVR/j5/o0d+Kt2Pg/\
2rsYN7jAtOS4/n4+0Ol6BPNNoz6A5tG9AUPyGedC+OKXW71ljj1cg4OE21tB98c+\
xycvi4SfbzVk/rFK/hJefVM7qeyHXatagj9D3mT4XH7z0HfnBzwXz5T4f160+ehDMf+\
GoMfsV9/ydfoA/rRh7WqD3OGfhWl73x1S/oLjh2mfifsBXnEv42Q+wtzwMfXV4NvH7Du+\
qv17JOTN3Zk+jXssdqRz/+x+rb7TEFO3fKT33qYgp+8vYf9C6buyIz/\
QN3eG4tnrfUeP2KHX9ArMxdG39AMP293kTzuFlfqvdKpt1e20b+u+\
xbCHnapAa4MOIycXn0Hb162L3Lcnf42uVlz+nT9zrKvPsuxx6u6EH+\
lo69SHLhGKTqXuUUj03nuuvTHa3WZjys3Wocd8boAfu9Hna76ORQ9+7Cb/cy/\
HnvY057XdoPRv11WvPqX+Zn6A/rSJdth1NX55iJ+P5SGvQ8Mseo/toF3y9SkvrMP53KY+\
4qyH5PpI9CuDmFdQmPg897lwh4+741/q5ZmnQ/wnn3ZkUvwJ+pLBz9xH23tybNmKyD+\
ryZ+A1cX34meeAxEfpZ/\
5LpVLLmZ84H1cz8JLxtJPZf5pD7x0s5wgZuMR57U43ovDRJ6rNEno+\
8pR3wXTZ5G7jULnukGeWCtP3O25eojwOXfqV9Q72wVdW7m4ljk2yOD56w5Cdwzmfpvs4Qn\
vHOExftUZD6b1BA7ZCR2pE5v91TsbU34U91/\
OveXA55OHkt9ktGL83SUVM6z0TckCDxo9rojeCpjXAp1q9F5yZN39cS+\
nK2BfNVcj12w9kmddIp9212PvH0lW+bHdO9NHN/GlfqFmcw7MG8NIl/\
3lToBfe1HeMlro6iju7iaOapFRoj6fmOTTStxPxuZC650QF9N+1H4p4+nqWe+\
cpI6pQ6HqLt+/RMclW80+YSYR6zP0U7kN7J6YO/\
r9ASP5aIeWCoexPpuuotefmmGP62an7hsLvNo5cyB1DMMWwiPULQ061CyDvH33Qies80qn\
rPqPvi84xPQh230xWn/FQIXJSQS/82ZD36z4Vwjc+QfeIdTF9HD+\
fTFK9vptzWyUugPKv8Re1SD8wPkotQpaCkWn/azNfs+ciR9elv/sI+zk6knqerN83+\
5SPx6pgRyefwu/59s5Vm60let36fv2/hEH6R20KCu9Qv9/0aDcOLqycw1MnOchidY/\
sSqp7L49jFd4BXvOqGP1XpRJ/hDFvVt+tODzIl9Fmb1O1wU9f7Shq/0Q5+eIfrSpa2TRD+\
W0mYT/ZH1Xor6Y+13AfKWBaO4f30i8egq+E9ljA15Ex/+b+\
7W4AnrMIdTdrqA3X20kf3qkgivdKABfuxzTyGnevMCou9M7vOdOrlc3bHb2b2R74xd4n6k\
O83o067UCX2JZR+0/CcFvpbLr6O+MfMx+\
P3oJPzI9DhRHyuPYd6EERhDPvXgGdEvrO75Qx9o64HYqw6LwAuXjrFued+Rx/\
W35rzGrsJeV3+HfH56Zc35IQ8jbS+G3xyYF1zgnZ/9yxWGfiz+\
Rb2d6wnirYGTyQtuPCZ4buVRLUOsi1Mn+iJnhh8Rf3emP0V/\
tVjoqdHYkfsYGop8911PHVPnN/T7uz6gjmv8T/LKtYdjR2r7MJ8mqaeQB2VkWdEfJL+\
pIepEpe6dWYd3HvgLB0f6qZt1hadp4oscj8lP3UarMuBbH6tuth3nQykhc+DXfhH/\
ytePEde+YH6YFDyN9U3hvBu5GryD4rKNepw19BFqZzaxvhOSwfGHrXOPjrQVfd/\
K0ZFi3Yyqu0TfmOE/gL73B72oj28UT9+\
ybTniohWczyL1rQeeDp6LXbjVVKyveTW3yMNIIzT6gbZGw6/\
O6kn8emUr8WnsPF7j47mu4YP98Yvm98ZvEPGp7K2I+\
mpt8WX4leAl6MMuX3BXr3rgyPHwX1KSDE6t+AqexYN5aVL3AuDCCvCu5riN+\
NnN1ZivsBWeTQ4z2J8OS8DB5nMrX1DbOn+Bc0uk+pwvqa6+\
RlzrWZw5E15vqPuIZl6x3G8D/GHgItYpcSTn5WYbLvTK2AcekobfAJfYfiX+\
Kh9tzTFrgB9zW0g+O/toocfmdHvRZ2HUzAvOWxIr+gDlcxXop5icSB6skjW/\
q6kdfbPrfYVe6IXbEw+Uvi30RXo187i4bpFxAm+YK/zpNwmqHIs8zxL7oFTpJb4nZ+\
4XdlDu4Acf4MBcA6WXDN+3tQjzarybY/efrcZOPbHh+0HMrdGensL/\
Hxw8T9zv0I30p8bR9ypv/S361aW3K8R6ab724I/4+\
6KvVclpnWdRoSdx9fpTxAU9vsC33eN8Zz29GPa1idlePPekDeDZnP7Iy+FTyHMhqz7iYF/\
kqsEocNGNl+C4p4vQ8ycFmM9Vl/yaEVZR9BcrhaKEPTCe2dO/Ep2HvqLfYSLeUCsVA/\
fM6s59XadvT35yGR5FyY69rheE3Ww4m/Vz/S2upxTuCC9h15F+\
yyrbwNMHwHdmNfqs1dgx2IeZk8S6Gjs+Yfc6D0ZeP9iBP4PHMR/nhA/\
9wcm66BPVtjeiTrrLPOr812+\
lz6hFHyFXWu0Z4KLcq4iX5vhgH89cwe8GVmb9nhSB35k9DpzqloG9e2mdu1diK/\
NXLiWQD3vH/ARNCQH/+cbP4n7rizo59S3n48h3I636hRHggN4ND4t1aXeZ/rhVKzzFPuR+\
Ic7XNntUEHPHpIfJgsfUxl0lXh3bFrmZV0vkcczcHfBvs/6K+ShGahnmyJ3/\
JuTWiJwu9ERxTqbfeakq9Ecus13olXa+Nf3BQ5sjF0YHzhEtkQ073aYMuKMJ+\
SepC3PRjGWB9JWm3uVc7Inz4LNck+iTH7yzhVj/TSfpG11YgfOJ+ydRL5WjM37K/\
Rv4zJ76bfPnVuRg6DXsT5fb2P/+qdhltQ99jE3uiHkGUkI99v/\
9AOKmvofpX91dQtSNyF37YUeu+KC/9RqJeVhK2i/mQmz/\
IvrQ9KxQ0cetHnQTeEr6PEP83yhXRPTR6mc5P8Qs1BZ7uz2MOGqpL/\
04rqmckzGsDXb3Zzp83dRe8H6HZtCP8Kqm8Ldm11n0NYfUwA5mdRL9tvqeoqxL7ung7arh\
Is7X11UQ/5fHnBR6qc1bg37eUnzFfY65Lu7TbEr/tpkymfq0YzmEHppz8wi+RbluI+\
bUqMtSiBuarwYn1R5K/fNy2eo359wnxYPzWs1h/\
18fyXlcssNM4vJsrbALmSeseYa3gsV6dKs/XrzuP8k5gC22Wed8M5/\
InLyFOobI8dRh2Dvz/yc/iO8+hOOPPqdjr12Y02hMHMtcIr8BYp/kH+nC3ppVM+\
kXL3NP4Gv9m7e4H6NxTfpqos8ypynE6mPt2QKez+8JecIczHPXhtAfqPy0ayPuf/ljIS/\
amVdCf/Q7U+hX2Ene0hgZB25KzU08XNqNutYzzB+Qxs1lvRpwjpsRXR17/99deCLXh/\
CEQfepyy9V1jp3gnMWVFfrHBajI3FUmE4eOWYu31/NOX7m+\
4vY3a6XybfdfybquPUC2YWcGZVtmUel1sNu33CDjx/H3Dpjei34tUsp7ItnPvI4/\
5HvkbsOIr8fdIP/F4bfVGruwj5cP0H+ddxYcO434tv/BapiHpneYRL+72yGmF+\
gtI6jrnHJYuLHxg/hhWZOwC/3bUOdU5o17+\
3rfQufjxL5biMSPkwpUQl9zzOLOSjtXjIPq9l8YaeN7C3Je09dTn51cBf46Bd34LWGMRdR\
ncF5Iub9Ush9z8n4Bcfx1HftoR7DiCHu1V/e5P4vzYWvGvebekepA3m6N+\
B1cyd1Zcb9fsQHdgHI1x3mYajjriIfdyR4vgjyEsqxaRZPNBo9cK7O98/Vho/tVAa/\
udyb+GIE8qc8Yp6NPLIZcf7EBuDrsfQfSwfo2zKT6aMx8zgQh/ZF/\
6Qbe5DDge3hYQclib4p2WWhWHfTNQX+65xVf5ZvBLxU5x7WvHsHaz7+\
Ueo0l88C568ZRX1COeoX9JZ7wbfnwuD5v1WGf867mbjRpib5/\
wcp1EMsph9LXgtvrTV4Q15va3tw0YRo6qoKu+LfPwaBn8qWsPIF++B7PoTD99jBr+\
vvLP7TnXN+FJsS9GekUJem3dexE/uT4d83K9TjVdG4/+9zhJ+\
XT7YSflUdW1DEb9qKLZyP2rIWfuxbKHVOWxzxn8etOTNPneAv6nrzPCsOgkMdmqHvbtQzS\
Xs+koce6cG8VS/Ow9DypFD/MOgXvJXfCvbxsx/\
1PK5D4Qm2PEWPDOpa1HbN0dskcKSx3xE51SdQJ9CvHO/\
L1UVvYulnUtqGEecfmwqPvdyqGwn6gn9Ya/XH7IbXULc+I5/oT55ar3eAOYPfllAPvq8J+\
9l7DnYs8r3AT+aMkgIHKWqkiM+\
0jqEir6UXGTed9T6GHctBnZBp8VTKm87kSwvaE2fvzkY8UzwCP+LEHDW5xhzyNV+\
WwWuYnB9o3gHvGfOqEbeOLgQP/ov5C/q0bdyvr5WXOsV549JTF+xQ9RXMJ2oYy37+\
TMBvReW07Dfz99TFveGPfs2kXz0lnPOSa47mvktyfp3+RINHz10Lf3KiDfl9Z+\
YmyhXHkud5zLlwusRcYNWmEHZ1ksn9rK3L+\
1lPrX60cPLHMU2Q73Maf7cdYNXRcN6JMc8dPBO6iP2Le0R+JPc55OYG598o/\
siNXqw4r68zqLP5GI8fKboD/Ot/Alzyg3POlf428NyNp8CXBA5h3dsvZ/\
0eVadu891O6mVaR7JvTs58fnsucNXaadg/R+aPafbotRGcQp3G4hbYma+\
cQ6bZw09pE0LJJ22aRx1ytV/Ud9lTJ2+ubM5zr86DXcgywHVuhYjjttP/I2V+\
IZ9SOpI8Qn9rbu3U+eQRz77EfvfoTtxWgjmr0qg+yIPqTb+\
wO3kG5dse5Os2dSHql43oS4UM8nO9P2AXPay5xwUHcp+FG5E/qktfhhS5DztV+\
wz2b8Jv5Mp2EvnWtJ/UodV0wN5tsebkLmRepFb4DH5qU0/41xH5kMePXdn3WvRdq7c+\
II8LOafWuEW/g+z9GD84h7oCacH/nxcQgB61qsA+PshPHD7HlTxYhxfgnG+n0eslhfELR+\
k31gp8wD/aXcSONR7PfQz4Qb605wf8R6/B7KtfG9YvKgRcvfsx/\
XbTrXOwP8Yi96eCyQOuqsPrz6LYw3r0f+tenZCDau/gw8aSb9GH2cAz+\
XMusPnLmh9zsihytJt5X2bYKuxwXJI1h88T3LXtIOt/\
aSTruHgBceh0eCOjzS7sUBDnzCr79mH3f3zmfoJd4JEd15M/\
H1ZF5C21U8H04XRIxC5kP8180hMZ8FhDdsBznewB317FDV6rN3WS8s2XfG5l9Rn/\
vic1X8Hcc5fPzLd4dIf9WXkSv/qQ/hj5ZBT7lPsA++54kL+\
X5bwHLVsJcFRGFO9V6pnUqfWt+u48yP+F1ejn+ElCL+UbLtTLSV2oP4gejrz/\
agcvWpF4S57TAL800Zq7E/ADP/SwL/\
ivhXWed1ML392uSh4u0QE8F868XmnFNOLeCw74wTY26GM657fKs/uQ71x/g/oX+\
9u85mwJXul+3MrrVgGPylOs/kOrTvYN8/bNrOXUx6nTmQPWyJq7v3ww+/\
CullhvZZE171jKjbzV3cp9GNmQj1Mr8BOd6MdR0q7Qd5MwGz0p5kqc49IMPfSkn012v0Jd\
ypwI/NI1F/ibwSvYhy3Psbu9W7H+KcNFflzZn0Y91+Ruog5EzVOS+\
b1Z9ZDL1HL46QfUa2rV8D/GtR/U6xe+iJ7dLITfGJ6GP3sYS/493rrfGn2x5zfOgC+\
ncu6f+iUL+7YVOVAmZee9+xXkaeUl5OLEAvb/\
RCTyMPcQdtonkPzPwXD2dTT9c9rjkfjZjNnU7bfwB+9uox5IK7ob/rbCGeQk2IG6K1/\
yyNJozlsyh1BXqHoN4/vpo4kD54fh5ypWRL4Ga3zP3IgcPvQFl7bl/Fn9or1Vf3AUP+bO/\
ps1X1HfEt8YuYtogn13+E4eb8FF/HDZ5vTLNSwPfu3mAb57oIv9UxdEP+D+\
P4q6MUlxxs8vzI18v+6GfVmUjv/qP4p1s/Gn3qTOJvTx0nfW/\
UJNnm8t866MPweRn9dDsG+BJ6nHHMI8Wy3nCfT8/W9+\
N5jnMWLf8px1rf3LlRt7WcULPVi/CXsYF0teb9kDrr+vq5AfPf4KzzeuH8993qov7rGL+\
vCebanfvBBOfXK6P35VIR4xA+hDkx4a/L30Xp7T3w8/2I05ZFrB5eCO/8oQB3r0JF/\
h0lvwSGbNHvBl67+A21PqwU8d3kxe8ucpcF+\
HsvjbM7mxm2nEbUobO3DpUOY06VnUVanJfYhLWlvnnxXm/\
EI9M5T8uhfzTs0C3djH6y3wW++7wjPdLkB+YvUneIbCH+\
G39mfg1zzXosdrcqBHs3X699a6w9M8s+\
zueOrIdeU5v198Dfn7qCR4stec9yEVX0O86VcOfehCfkifQ92J2ZjzY4ySY7hulePwMyFl\
H4nf88t8KP4/6Yfo11DqrqE+x2WtVY9N/7bszxx5xe8lejXWD/\
kpQdym7gYHKpuOYYcHDyK+\
mZ8g8opq66Po0wTm1ZkNFeYHO9cnb1TUELySElMEfq73f2IflbAirE/UF3i0S8HE05kp/\
D3A6vtt9JP9ejQE3Jj7IH6+8k0LXyWiB9/LEp/kGmPNu3tKnqcLfdPK+\
uzwN8WCeH5b6oC1cl2oy6xI36JZgnMQNX/016zhBu7+Eoj+VA1m/\
xbmxS7Pfot9vNQBu72POaraqizu0+OZNb80Gjs8ah34aFUEfbtrV7I/06rRz/xrJN/\
PnQBv0/sO+Sf7/Njz+t7MJwi7AE4IoA9G21QZfPuUfi7tdnvszbzv2Ptmk+BDpNXod/uK+\
PPpbtiTPZyXo88ajl8ZRz+babZGr/YEW3U6nEusHpuP/TiSKO7b7ONBfeO+JdxHKQ/\
waglX6iOfPaHuoWYUdtk5CnsSxOeNLf2x2xfGIodtOC9az3UW3tu1HXJSYgY4zEljn6N68\
/yv/iLfFe4Ku2wsskMfGnvSR7gnUvxfOXAYnJuyBDs25xD78duReozdj8m7pbkQr9pwvpS\
ytSH5656cT2vszeR7RSORw9NPuP+DvcDTrwZzjvt1+\
jeNAvewuweZMyCFtwaH3OOcDL3tSXj5Z8fR/80OfG/\
MN9b5wWX2p2Zl5P1kdezZas4v0ftdt/IQMdjT1tSPSAHvOC9k9i/\
mp9XrRB1R4aXEUf03c9/\
5qJNW7GRwSj4b8apr1DuaH6PJXyetxM8UGUJ9RcHmPMeGJPLa0b7EAbO+IF/\
HU1mPLpnIx7ycrEs3q8/td2+\
ea3nr++JzFyfSPyTTFyMXnMN9tSmFPajCHCR5TTfi2Itfeoi/\
uzAHXNv6iPscwvmVek3iIeXUBeQlnX48vV9NcF9IU/7uD1+hn59gzU05AV9ymbk+\
Sp2v4IeK88H/AZuI/8ZxzoTu5c96136Jn+vWkt/N+gRf8i0365SaxfNN3MT+PttC/\
fmcfpyLfpZ+V+1kXeRkwgb0cCN1jlLlptjn98xHkCrSNy1pTcj/\
zL5KveSaOGE3lE4Fyb9d98Q+tbHq/J464ldk+\
t2MDM7jMvZ0Ap917IwcpB4R9yXfboXdnMD5Ssa7POitY3f2238ZcfJUq8+\
ixBT0rvle8MWiQfjhxJ7IQ5MsPtdOgReIsHjsH1Y/j/\
9A7Nbe6fihnyOJvycPhRfbFMd9NqZfQspTDLt54Q96MB3ewywxiXjELxe8/49KIn5Q/\
3vL/tXyYN/vJ+JfXnmBox1/YIfm7UP+x53A7jluRB8vz+D1AOfzmCs4x1MO2AUOaHeX/0/\
qBT4JpC/OzBeN/XnyiniszjDwyvgF5DEGB4OHi3Dep975Lji8Sw3il8R3fM+\
vFOv98Dz70ZF4Te+1l/3oVI31uVyI80HaeSJnp25jB+\
fNo98vIEL4Hyn1Pft05TXxY2ImuPRmYXjZxqnkN5JvUbew+\
Ri4fkZR1nkA56AqvaZxjlWDM/ifgh2tfoev2OMx5fm/bVV+r8Nb/F7PxuJ+zP+ai/\
s1JrUnrgl7jB0odAN/kfWc60wpyJyL3rOZQ+C0Hf6/\
xlj87MlO5EkyrHOBPnyiHvDceVFfoQ74S364dwWuLxeHPztBXae26ztzFGwNePx2H8iLb3\
mCvj0aiz73ts5bsBnP70xohH25eZP45W1x7HP1/fjJK9vQK/dOljz8xg4sY56rlvwK+Q/\
pjvwvwO4ZB6l3U8c6U483nX51WdfZ/wf0A0neK3n+BOq+zXHYV633Gvz+z83wHgtWsi+\
fl3IfsR3BAQ+7oufRBeGnKs6Ej79XG3mo6sZ9PM2H/d4xn+\
vWqMr3X0eBo2wiLbveGH1dy5x/yZ9zg5Qb9GVIa61z47v7wD/m2gcu2vOU/X8ALyQN+\
8vzzHEFf62sxTkJD33Idz9kzrYUvcjiw6x+h7LMB5Ab01+thtWx+\
giJs5QRAdxvAudtKangX/Mq8w1N+8nENduwO0o0+\
6k4ZHHdBM6vM66uAyfMZz6jUo95EWr0RuR7ui1+b50Xv9uQ8+\
PMZ5xnoTfjvHWt9FLyHAb3YURsIs44dJH4+Q88tHFtH/bg7G/iyJ89eO47nB+\
qR2204i3mm8jl8mN3D8rYpb0/8G8vN/D7g8Ph+95Ew/9H7sJefxrOOgxgPpS8fT/\
f85ln9WlzPqM59j48zvsi2J9Af3Coty32d99ZPp/wAD0+cYi4cvY75GdAaeS0/\
gXseBTnBMpN/JFTa56pNk1jH+0HI/fP2+B/q4Cr1P370Je/YaxzQAP6SFuMgK+\
ICcdef2Huqb45Hpw/Gd5HjXIB59u5UaflcRr5dIbXlNUuyI/\
fXK7nyzwNaQ7roF56x7oVaUw8tGw78W5sDHHgTvh641sc+\
aeyzLFTvApa69mVdWnqCv6achy7XtMTuagTDU9yhLhEmrkGOY/\
sQb9iX3hTJa4n9rfUW3iSv9a5eg8/\
gifafMeOFX2KndzIvDelKOen6rU5l1zadB08pGqsa5n1/P3TEeY7ui0gnqvfF3tY+\
xb5grUqcnSSc6rl9qPwZ3+T8G/KKvRtRnbW9S15FfMreNpIcmDfJpMHk4fmAv+\
9hL8wph7he+5n+\
PsBzusxZing8cxT8DjzC2NPWr1BvtzuondVDgqcrGfLi96uGwbPXYvzM82JzDsyG9+\
35jBOZY7ti6mso+8I/O/5RVb9eXnuY48N+ZeSCn62liv4NSk7/\
59cAZyVB35HfTgbfBPQH7tbp7fAwfKxBqa4X7uGIo5XC3qgB++D8CfOe5CXiIfgixYD2c+\
mvsjFxbXWnDPOEdd6thP4X7bdQb3u8p3YkY2e1vrCE6tfOU9JvWSL/\
QiYgB5UmzlJPEd4Duz2hD/kCRpXJE6bmAI+tS9GnOk1AXkpRp28MqoD+\
G7QXauv6zF2bd498n2+nIOlfzvDPqVtIL4ZCO+nZ7fq/CX4DjPgAfrf/wl+osZ+8EO/\
dIFn9FwjxPrJIY9473oWvFENPCefDsRulWe+\
t5qvm3VeeXbi0xWTLH9kze1JncZ6v7bHHzT2RL5mk4fQpHJc58xY7uuiA/a5yTTs4W/\
WW63CfAUz04V830QFPHqhsjUHoj5xSwHyrIpzAXD2DOscd48X2PHH67ATY8vw94Hdyc8Us\
c69vV2Sz215Bp7NCT+nPC/I9WxceL71kejTI+u864n28FxB/ZGfXynI1aLn3N/\
3RYLfMRcvgHcveYx4KGsn+YCa9nwuCN5cbsz8F9nb4gXzlRd+UG4XBP4cvo/naMB+aEs/\
s88a/lrZsJf1f9cWvZHzMyehZDbw1Nql4ItjX8hHjrXmWlQfhp0pUZt451gEeRT79/\
hJu8Ps05HuxFP3u2BX464iH757iKfsbcjDhlSF978dz3pc5RwFOeQquKhOBeI6H3hj/\
UNR8EKnDtxX5iXkzY15IeYh5k3IlYaBX6az//rBpfjXfEPJU7eHB9BfpJGHufKE/ZLgq/\
SjH/jdNObeyWHkD7WGSfCSq2tgd4Ovs/6FpoBDEquB+3MsBu+\
7bGUfrg5EDoLgy2UVflDNHwjfdGoc61Z1Cjxp0CNxPXPuJnE9s8Ya5G99JfB0Q4N9bX8Ze\
5fEPC2jVzf874xQ1r/BBfzQNua2SPmuYH/WNCcuurma+oTsadRXVWEek+\
y8BDn8mJM6i9LOweJ3Ezoy3/ZqButp94fff7KNuLzSM+\
7frSz7ErkNvY88ir0ZwzxF9Yofcly7JnI8LJb4zbzAHJz8H5G/m8y/\
03cVxx6uK8w6vsgD/hq9CzuYjNyoZUuB08p0h99amUn/0akj1LXI1vnRdsixkpv+\
DX3uYvIqu+1YP5/P7PtkR9a/RXHkbg/8pN6pATh8TnN4jNE+\
7PMF7JCmtEUf1AHwnBeL4K+f/6F/pTW8nZojN3F1KHOQjDyT0Uszgf3uPhV/\
vfAudvFkIut04Bz4N8GWv0cx90tZTHwgDWYumd5yG/7vHOdtyt2t/\
ONy5FwtEkq8l2ME8WNxX/S/bGnsWzOeQzI5v096QF2mFHPSmov1lnW/d99ar+rwLcYW8q/\
VniNvIz6hP107oV/jtxLn1I9D/ncOpi77xRvq228sFefOKP8lEC9uf4d/\
unKNePjnDOzdOvLXUmHmpKhdj5Avy1cEve5bDLt29Rd28VYBcOb+Wdg9/\
3L4GeMc999yBa+ZzL1RBxEP673hP5WfG8A9S/ogB33gf9TvY5Cbi5vB899v4n+\
ietIXc476L2nPEHDDOuodJTc3/MnZeOLtMnN5X9Kbfa0GvyE5uMP7TSB/\
ohVfBj5ZxdxA8y/zArXGN9GXDRHYSwfwv+nwB/2pSX+\
ZdtgJ3DOcObVSvx3gSxUeXdm3HP1bznxPZfh1nrt+RbHu0uKX8K6x2ai7PlcW+zv+gTU/\
hvn7ev1j4L4461zFhjewO33m03+1rgP/DxvKOrai31eqwbwy/bolZ7PHEC/sKQZ+yR+\
C340iP6zoNYln46mrVb7/IB/sdUTgFbNXL+KK1pPhVRa9wk5lMR9OeaugN1tZF/\
U6eUSzQBx4O4LzQo3NIcj7deZXmd6rwCGlXC3/NgoeIZB5mMZ/\
nBejV78LzykFIX8fK7FvXSPAe3Eh2MPoYjzHcWfqWJdxHox8jHoVPdqaPzOyO/b1xk/\
i2a3gdL0bc7C0rmfpe2/AvD29aGvsgbcNfM1sR+KxnTvYl2Tme0vLwNNGrRT4yy+\
cQyufteaAxQ0gjpkXi3ylg9/kekX5XMxpqz5CxT7u+\
EjcNNOH9U5ZxL7IJ9m3wvHwhbVDOHet4ENRZycvA3/r1+ERNb8Ooj5Nu3+AfoGn/\
fBDv3zwb+c7g58j47Ev95lDItueFHqrj67Cfs7Oybq1cUKvEl4J+\
67maiLye9LrPeK9PKEp8tLMxA573UVOimfhv0NtwHHDd8JrtaJO0nRpx/M+\
fE99bj876lePW3Ndm9VDvyPnYa9DmH+\
khbVFbsZTz2j0zodfc53FeWszulNnGvRJ1EWo8cHUe3e5BR7ebeXna8SzzofBS1rjseCIr\
1v4ezz1McqqutTN+76G32/APAgpzpp39XcueOTaBuL6q3/wu/\
YFuN8Fj1mftdPwQx69kYfjd7FDt89Sp1mM8yf02S+pN6p8kb+/zhB8oVKtJf1/x6cSJ/+\
qQ/9VTtZPK3lkK3rcHr2z3QiOdfHFbk9m3pDZ1+qbTS3KOTe781jn3X3A/\
zyPBK85MsdNiUunbi9iOP53Zm7ijEf5kJuvI+kLaPKWfgKPLPTdxjqf/\
SR1O2qB1dizvwfgEbpfxJ5+teY/Zk3i867P0Ydf1rzI6Jr4xxHB3N/Cg8QttzbRB+\
jwiHyT8wTsWT0JO95jN3qcGmTFK7mws4utOtpLFg819bTQIyVgM3mqP3HYh3TqaZW61FUq\
1Q/DP68vQ3+He7zoy9VmX4efXj6W+eRfvcgP9rbqzutwHqRR/\
RQ4JvGI4Cv0tDvkqWPIZ6t5TeT+y3JrzmFT7tuxMX4q/\
3F495Zu6JXbYfxAvgeiT1hvMZd+/pWcf6r7zKWPrMIl9kfhnC3jRSLrV2OsmOMjaw0H/\
fueef0r+eoXOcGFIVZ8OmgTcnrlOLj/7Ez0z/8o63nwnegbUJ7mFThEzuK+\
9CXpxNkzeoM32h6kznDaXuzm/\
lpcx3MUctRkPHp45yd4ojz1nfLTo8xrq5iJH3BORN7bJYg+\
EnPrAFGvYfbpQL3oiYLMO0svSH1cw+7EkxGBzKFa7h4iPp/\
DnXmIPzkXwRhgwo9k3CUPU6Qw+xLhDP8ywTr3+Rjnbqul/fDv3feg3+\
670Ov5Xshh6nRw7D7qOozpz6kned1L9PcYoUlCXpQf3uCDS+T5jI2c26XcfMT3Z7wDn/\
Wpgp93i0N/O7cgLtzuidxcZW6u4vYMnOjGOXfqRks+DwymH/\
trJeaS9IffNMJnEWe4UPeoef3E3r3zgA9+\
2Qqc7sTcLGNRMnh3OP26xu758K4ZzagTqmDxrM2pE1Ji4QHMAwnoc8RZ9KANc8yMZXfAu5\
cfsb+VD4OLvAvip1pb9X4ZzLPSujA3UEnYTN+\
C2Y04c0pJ7PyLCuClLcx7MlXkQjpGntF8Px38cJm+NjXhIHUObYrQHzQgCTvfaRQ86bpS+\
K0+3fDf2ZfAW0X4gF+vWOdaX3NlnkSfDPyGWpX9smMOov5mE7zYkUXgyo3buY+\
gHpzDltigmLifm8fEPum2nLunPz9PP9Tr08OE3HZ4LfoPpez/Ue/\
p9gF5Ke1GPmkbvLJRXUX/NlN3r0Z/xC5WY2628vc++1OnPzhK3kKf2rKNQ8T3x3cW/lRP+\
0Q+N2whebehZdCnVguteS3hK3nvzDoM5rxkddgi9mPXbvjFKUnYi3TO1zGXfieOiT/\
JXINDO/GnMTfgPRKrMwdvT3bi6/Un17J/w8EnlZORs1rMGTV7c/6vkvkQP5PC/\
D259ArWYcsz/NaXU+CpW/AhxtxbzCGv+FvYEe1VA5G31krVZj8n+HG+\
06nVoh5XPlJezEGSVvoif9eeYd8mN8M+mJ7ISak3xCFrLyLfwdZc0IPb8aNTLrMOWUPF+\
Qzqin3Mf+nLHCbdfyBzKh65oCcO+8HJnanH0FYq1nkCEcRHWVa/yBXmOcqla4CHLzSw+\
t5W0v8bAi6XomXsbKHL5GmDygp7ZpTwpA7vxRaB74x+\
YdSJ3tuO3HzKApeOciSPGEQexyj+FB7h/mtwTKmWFs7yJG4+dVnwyvrac7xOt/\
ive9SlKhk5uA87G+xod+bvKeGDLD73OXq1KwC/UDsb8UrA3TTx/sGCF+J7TVa/Fu9/\
bsoQ6+RXVLzXHqxMF///WfCp+L9D0jPx/fmnxeeUzj1fifvZmOej+PvzrCzx+\
fllf4r3tzJtlH/XebMt979XJWRfoX+v+tdx9v9e1Xs/Sou/Dy7v8O/VOOQk/\
3s1x34Vr5qXWUG8nvrjKP4+/k9F8bkyxSv9e5VX1xJ/1/wKlBevlbuJ62nP9hQXn+\
9Tpaj4fNHbBcTvFt2S69+rtHX7X7E+Ddt+FvffOlemeJ5Nu3j+MgfFumgTe4jnNr/3fSz+\
n9CEuvP46shTNQNc29jqx5h2mrh98Sji32XH2EffV3zvEXNipAnjsZPztuI38jLHUv3ZDR\
ynWudbdHRA3pY85P3RrfDmJd6jx67zwAVyMvzJqd7EZ4PLk88M4jwa2azH3JnaPbDT0Sby\
9nA3/v8K8z/U6vQNyi4dwBlxlv255kTcMI352lLoJ3CaOh59ScHvaM0uc71xr/\
n76DfwUaUy8MufPOBN3+xkrkdENP3is79TxzmuOfW3Xk/\
I92xmbrc8cRP43GsvOGID86a00oPxczMrkQdqUYdzHKvOYn7WfJnrlKfuRl40GD1eyvm1Z\
tsg6myNm/SR3dnNvlz5v5rOPCCn/Pvj1zoiI/\
uS4RrZUih7KdeWsmSLLBPX0tijlCHFHXuTsu/btasU8ZW1utZkaWRNtmvLvhsM0m/c1+\
f31+N59Dz33s/nfM55n+194L83rkfw3B0zsA828DiZYbpVF2m8BR+pfY9ynX+\
D8Jeyy5K3STuHP/l9s9WfbRa5fM567/gxw3q/ebSlH7Wg01b/\
rbnOlz54eTTxwx3J2I0pbcm77CaPoxYdAJ6I+x/4NuYyeW1Hwf98Jpr3+\
a949fvI71Q5xnpfhidDj+mG3VmVRJ7z+gbR7+\
xEvcC8uuCA9HdW35ph627xWWj3a9JPHyH6fJtWQa6/\
nANvnNts4SXV6RnyVH0FeY7nXfE7vzBnVhkJ7pU2w78lL4O/Vd77kHq3crV5/\
YX5f0pCKv6dw13BQ0h/ppH4ifdtsBdqvRf0H85XWKeJ5cCl+8YL/\
iTRX3r9EfJlUAdhOlNXpndJIW49C7/LuHcBeflbwT9OisS+\
xh9DzpLCsPMbC9EHVvG15UfI07uPtb7fdrElB/o85hbq78qwT8FLwOVpffFL72/\
kfOjduL/kPVy3Ff168olj+P9x9M3qlW2Ie9/oRLzccQ3ncHco+7p9fuaP68o/\
HQC3rb1p9b3Kg3IseZR2PLd4PXSbPcet9x0WWvtmbgriepGOxIm8iO8Zq2xZ7xqpxCPsJ8\
Cz5XnT4ttQT5SifyY02aoL1xYdtPxNeRr5Q7nWZeoAl+bh93hVWf7j7xSP/ERLnt6GbrB+\
59B04n4B9fA/ym+AT1Njzrt5Q8a/nZqKn3foOfEcTdTzbrhCv+igpRZPhjwi0pJbY8EDy/\
9ROo+w/C+1vZin3PslemVhY/zXS+OIA0YRZ9Sa2SC3/TJ4zRN874PgCzFD4R011Lng01+\
f4FesqYzfMaE0daI9beBLCfelb6S9B/\
dZIQx9aiPyvBWSeJ6I0uDh8wOoU6swmXjmXfwVPVHBD8pmHpU0xp6//5V6d8WBuKCR2Af/\
3e0kf98hCPxR6Dnn5Qr8l+b8B8jV7Vjk2Y25J1LRA5yHl/\
DpKrafkYcMEc8ZXgw900nk191GoDcKAvFb7DqjZx2Yt6XnVSQvd6go+K9BU/\
SNuxv351eePGfhs8T7fIizm8388Zsc6fc1N04G9947TT/\
A0FbEYSLGUUdRfQf2ZP9I5K50GPXCzSfzHM6FwYtzJ1NX23g99i2jAL11BT5/9c5F8r/\
f14j+EIn1+1Sdvtj8OezbZPoN1N1byAN170G//PO57P+oFOouIu7DMzRmJXox9j1+\
ZNAo8Pbi5cRt3jA3QxsB75+SSN2x0oj5j3o8fRWa6zDsrp2Ik7V/R/zR5SFxxSgT+\
3ebfKqxcZhm/d3JcuQzB5UBH5YJvs5zx4BbAkVfTaM/iNPlMR9ZeU/doy6DZ5QBbwQPYW/\
yexm/EA/pHUIcy6Ym5/Q4cyrMtZ74t3WJU2tXXxBXsqsv4t0O+O+b07H7wfWQs6sin7/\
mCnmn2ALOyczS/K4DfSvKhyN8Xpb5bLIGD5+27RHrG878G+Nja+LNrsW4j13gZ6N+a35/\
Djzoso0TdXK9mKOlL3zI8y/dSp539TjuN+\
2KmFNynPuJ7kne69Ia8PqcVPIdhanX0yaO5BylmuCYJnnYo/0/s1/\
7JnAdlyX4VUsjiEudPAJOSZ9KnZK9F/L3RORhmxOHNpzrso9Fu5H3nEpfoPYb/\
cFSCn04xojZfF46Ev33pAfx3FrzOHcV5qHXbo1kHfI5j7o98Rvzz3jWr91scG9AEPVgj8t\
yTncS/5XjV6K3fFM4P9HUSUl1mb9iju6I/t4xlrqElpvQE1sO8/fXE9AT66Lwk/\
qRH5Zj6OfSsx8S/\
3szDTkaplJXELtSxGGG8Rov5tc1YV632rEveZIub8DZrSOselbloht5186fwFn9bXk9nib\
6peuxT81csG9z4H2UVujosaXIu+x0ALnIp8/cXEh9vdy4FfftryNvfcm/6CNmCZ50W+\
JJK5njYfTLFzwPzL1SMphfoGYVIo4UF4n/vKsPfn28D/JTh3lReig8sWb/XPLp4WL+\
c5fp4KONC8gbVEwl7nGaPnppyB3qTxzEPm98y/M7DyGeGlwMe1hfzOVeLeZdeLdAf/\
xO3kSNgN9PX9UT/oqIefRv7n2KPBkqccEk8pTK17Osi50T+7lkHOemXVPswhTqFowyW/j/\
BSWQ116HkKf3i3i+Tx253xmi/98dXl4tuSk4Qg4Avw7cgvw1OQaO2pmJ/S5IQK+\
VOg7OLwMvq+JVH3keSH5U0V6RZ/V+i5/mn8VzPPrC8x9Fb5n3R1DP4aBwLstXZZ1s/\
uH5fqOezlxMX5J0MZf7jmDOh7H8Ln83dx16NWYh7wsk/DYf9IkUlYNd8XUEF8iVieMco8/\
POFaT8/EeOTQKH0VfeTLHQC5oL3hKInntfpzzPxa+\
AOPDbnDOIOKXSgP69OVBs1mPHRHog5qN+V5P+ozNmn+xrheZ62z2xb9T+m5Dj+WsxR/\
p8px4WPV7+AcLuqBvPKjr1RNTRJ1NMOvrKeQjfyZ+\
s31P1jfwKPV5Z88ShzHou5NLB6L3YtlX3YxGb9W7x/\
OuZv6qeRb8ZU6gb9tcVhu5618IfV6OehnDEz2lPy9BHKDPYuKu8kV4b27UB09XP4T9ThhH\
fuFhDDjJMZ4+sWVt4MspK+ZbnaY+WEmgvlyuR/\
2DnNMIvVBqIH7DUHurb8S8FGf5DVLvR2Ke6wPyRu4riF+\
OHk5eLXMr52ZEe3BY4WxwxNX1xL+rquCL8K/0VV0W8xZ25RD/rpWJf1+\
2DfMxvAbh18QVpu7eMC2cbaZOga/K7E3+LOd/Vh7FKP+Y/\
GVMA3iUcnoipzOxn0roCs7RNOpApddbwJnbqMeQHJnXLf0Nn6yRQP23tE9l/\
0d8QR6yODeyDXMQTMWBOMDrwtiDkneRv4Q09E2tsuRvsjoiX2/rse9b3dH/\
qcwblbaVQT5XUm//34KJ+Sp8rvZHb0gtYgXP+FiBJ3OQD2/\
mCGqVz3H98mc4H9H0nUn2Bej5FWORk1KZgrdzOvKw5DLxzLbUZRg+Ak/\
dpH7fuLUOfe6q8b6MH3Ut35YQn+w8ic9tKog642/gD/\
fZ3MfF4sTte71Dr3zDPuj5xThvMe6sc1cN/b1M9GkmgmPlWbf53aM/I1f1fagv+\
PMmuLHWF/JyylfseB6v+iUv/Mx31JEZI2ui/9q5YW+\
njkWvBov6k3BRl9RQ9EfuaU3889ZQ/LfAUOISO2qK+vgJ6PGy8JAb/ejfVPoU57w9+\
4z8qbPAT7Xs+d76DoLvOg67O4N5yeaixciXfwmhNwQv1gt4K/\
WuxEfU5EbkRQcNZN8HtGffTnWgDsjOlrrXrQ0t/GF+\
Maw6YuXXKrfYdx2cvvpn6mZnrqNfeOsIKz4p7Um26gz+w5N8/vcu61UuNYl9f3uU/\
NuZcujFzA70sQYlk8efWwW9HzAd+3R6DX098yIt/Wn0CKT+sN0z7FyX1uiT6m3F+\
QpDLwc78P9d/+H9msei7+wwr0fDWM/V1EWrF2RwWOEayE2fcdzv69X0608xwWFXs4if9+\
rC/a3yIM/ZiuvJt+\
lfU1xFP3xcR65zBP9SXyHmFJe5yOvFfOS8QiZ6dWIacvXLP8IewschnQzh+T7+\
gVzcn4G8tZaQ/27iOnl3sNuJD3l+uQP6oz75OWMn89+UDuBKJTme+8wfwPddlrI+\
J5kXbLq64H/sYt3MReQFtEc7WZ/7ScjB4PH0HbT0hufg4z9WnF+9tIi4/\
TYX61Uf8sX6XFoZTz3Knfb0ncdUs+RHXeRo5QXM2uWtV6OFq/WqPrvC/\
9tvoR8tGdxlejH3WK9J/4iRwNwUpdYh9r1bG+\
Rqgq8lP2r79tartnweOMPWAT00qzhyN347esTxNHV1SXbsay3mmUrD6DswGt0R9VjtsbcH\
xBzTlMngDi/woLT9D/ZzHfF0qXA26xf/Gvx9whe91h29Kzetiz04Kep4T9wl/\
pcejN9cAH+iUcLfqp8w+\
1QUc7xEX20R8LmcLPiYQ66i75vSD6gvKoke6NMWXHZoLzi5RVv8D4W5gUZSYeQv8z56cSX\
9Rer83tQJVgvi/t/loO9EXE4JZC67XLE88t1J5I/nUI9s5lIHqs6+\
yvq5wAOrbN6JXZuehP93jvkoUjdXzuWNRHD6zhrozW7kvZXnbUSdg4Poz38GnvtjthXv0J\
/pyPmccuidLwPA55Uqsr9rRmGf/rrKfgVEcc7/po7cSPRHP+\
TSd6s9FTwHBdPB8wUzsfub35IHCaNv2MyYLuJy8NvJcf1Y1yU3sCP3O+L3ewYKO3mf/\
F3hlchnEv0n+hj4M1Xf26zfzc/E03R4vdS1D/B3GnfEvlSZgdyX9eccbtzO+RrwO/\
5kVh5xgMUjWIcQnleXq6EH3rmxHpH0iUjJhcAvTsiBPtKT/98Bf4dyjjo9qUkC172G/\
62ko++MF/i78t+K6HMbxPugdPbrGTwhmpcr+m0lc/h0ezv0Tr+\
NyNHasVynfA3OuSf9m6or/oK+OR474izyXQ3XcM6WeHCuq0/\
hOcOpO1V22XHuPdZxvsPbcB8X6QtRH7uz7iOnsv9L6ol85n7O4wwxz2LVVvrJp7YAVwQJf\
qTt6dQTvruBv2sHL4Z2pDK/t7Qocq0GIXdxQj+sPoNf2V3U16czn107EAvOKn8M/9Q5k/\
MzCJ5U2Rm8IUsLRd/sUeTX/l/2oyLxJSPkHs9RlTiyHoX/Lr9OAF+e/\
sJr7Br8qkb4a//5LdSjL4e/XJ4SQF2bb2PiRhXQg1rEcsHXxjwas2Vj0Yd2g/\
1uBF4yKi8DVx5LJM77a13qIqQM4rZtNoH7rgWijxd9xd7sGYx9XcO50swx1P3sswNnfe4C\
LjqTD448Dd+dXHUTdR/HVOKav+\
3HbylDP6ZSV8z3e0sfh1m5O3HkPObKmc0dRV9eZfymzTN47jUXOI9f4DFUDwv+\
v1oL0HOHi4OjBzMXU/M7gT6MY46iptLnr3dmToYqdyLeOOAA53phPvezPdfSC+\
bVDOR5LPWu6nf6b9WONdDT0RHIT8o25OrPEtS7dx9Cndbd9vBKRayD96K2o/\
BviAcZDouxV16unKscwac/sR1yNL45171I3EsZtRL9tod+SyN5HfJSjvl22s4LyI37Guo/\
4l6Aqzumog+nenC9uadEP0oo/uB69kmdyzw28wL9RnqdHsSfjZL0c2w/xnyJil3Ig30/z/\
rPzGWdP5TCHwysQ/z/wUDi3od74jfuzsWOpE3Cjhwg3qNtqs9zvYMPVqloi34/RD+\
KFnQM3Ld5EvW0pSqyP5M9WZ/4Yny/\
ZTz7f7EwfaZJvdjnMPjQzbhw5PzDPexW0nf6C17Ysy8/\
0zeiB5zjuluY46mWaYD97lqEeNaRDmKeRC7ntgH8hXINeKOkdgfJv+\
TgB5mn4QuT3Yaxb583YQ/D4rE7+YKHoSb6UY8Wca1tKZyTedXwIy4yp1lxaQU+\
acCcV2OUgp0+akP8sD15DWUBfZJS7W/IyWTiNpIz/SaGP/2BmnIH/3bEZ/\
Dx8CzWTTpLvOvQa9FfA/43osrh9xQhzi6b8IApui/1SjVOkyd/Sr+v0pQ+\
SqOrLefrDnk8I7A/8Yp71BPooeSP/z8uYT5M5bmvj+XvxqwAV5dyZV8eN8ZOe4h+45bV+\
N1hy7EnOaJvcHQn5Pj39eiJvET0zdbW5J2qb8E/\
SyYOL71gjqoiYUfkmJ9Y16seXPdJTexkncfgplu7uK/N9FNLJbAnUsmD3M/\
AXPBeyX7sfwL8l0pD4tTm/5AzWX7A5/eYC2ce7y/qe2Lww8vC26LF088vh0Tz6gn/krGN+\
LrWbBf6KJd+CGVTNPm+SlU5p++LoZ9a7EO+bvE8+jrqvvSpxLEMp11i7raYDzhwH/Eyp/\
o8z6IDyE/KIOzN+qboqfHwDikrmiAny6lbkpr78hy5IeB2J/hezQH10U/v4SOWg8E/\
xhQPUc/0kDqFx9R/awuJ/xl1ioIvvlfm3By8gB+2lf45OSoSfTxD4OsYePqkonW47+\
QY4ccyd1iq746/fzYHnNwCvjnJnTigepd5xrI9fbhGFvFCY2kR8GBd+CNlP+\
bAajaZrIN7VZ5762FwWpyIr99sQf2Y82H6Bka7YQdcP7Ef/\
QRPZspQcR6o7zZfedAP1jufuJPjMeKMZRsjvz8Fsb7GO+\
zULHgFjCziqfrhbchnnic4OCsc/6wY+\
Svjpg36dqyY07gnhOfwIw4kv2AOtXwcXlfjJn3ipg98Irqz4BPxF/xLw+\
FZkfqxD8pm5vEpY+C/UE+Xwk5NKoTdyZvFPk0TfbBPy3Kd2suxv00b8TtdbdG/0TuR4/\
0GcuZOHllbIOLlxen/0N7EsR4viUsrO/\
DjjWzmoKqO8EPJy8X82PljsaOVtxPvy8nj7wLgczL2Cb7l5Dfg7EdXsaPn4AOXeyQQh92R\
wvnzyQQHKTnkF4oEEndd4QuO/ZiG3b+\
3FVx8sgHx606D6ZfqcgW9dpD7kK56Ys8OCL4T70jqZ/Y0oV6qeypxONdZ+LeHo9HHn/\
axvo3hGVGiuyMX9fBHtBXk27Rfx4LXJpYF/317yvoYpYlnViAvphzKQU8XH885uIz9U+\
Kz0GMP9oGjbqCvjS/YL835X/JUDnuxp3sKkcfaE0/9/R3BUzHbh/urK/JQVeCZUOPbgOu/\
wM+oRfwsePK+IXdqEOct0Ab8EdSZ/H+F0eQZ/\
RPQu8Oo89UCT7Bfp8HDZnH66KQuoeiXWt2Qn72fwZ+VQ+gXWqyzn/69Oa+\
Rm8S8moOs50rwqLr+DDhF+gt7NU3mOfzgbTK3wQ9vpESx3lfxL8yuA/l/HbxoTjyL/\
PuBU8wN1L1rCT6sfyh1FWpxV+QuPgS80/Q2uEFvyfo+F/\
2uj6bAY78gjbzFnx2pY7hEv5f0jw9+wyPqnXQtl76vRe1Y75Q3nJc07K++bzDno/\
QM9qsZc97VHHgWpKkS8pUn+sfHdubcFieuYDR8hf7o+w15/\
R99MXowdcuKdg95KyX4guvfEvwnk3ju5sxpVJY+x742TeJ+3NAf+l8Nif/\
k5qF3CoiD6N0Ev9Ce2uxzrB3nu6qY51vpDXqjP/2sess3yMWzTuzLhB3EK66NQB/\
XiKOe485q8MPMR/Amhu4mj3DpDM97OF3UeQh+AUeT/H/AUPJE45ozB8p3hpgHtgL/Krsm+\
qSJhhzsGYq++NebOFxqBv6Hy1vqURdH4Yc7ZYN7vV+izw6LOoUa9vh7fu/xf2NHIv+\
HiOuoZVaADyu2IW5Wyh/97eENLprdTPBuVwDHPRoNPp05lX7VG/\
Sn6yXId2q7IvFDSoFjlAfwzZm1L4j4nQN6MLgy159zDX98wHDsVpEL2Oe7t8An85nnKz9p\
TH1UOHhLcZjFuXgqeJJ/q4hdW7AYPXqnG/a5QyVR14D9UbPIQ5naU+\
LP3waxzkH09Zqf8F/\
0UcQdjXxhl1R42vWUD5wPlyb0Xz1wZ97LXvobzPX0t8mz2nIuXhYg9wudwV/LZ7J+\
fp8EvvWw/B5l2z1wjq8/+9RjH/LdnPyVdHM5ejqTeSOK5I0/8SwK+Q+\
aiV69TH279hp8Yux4QRw64AR6+mZV5PsTdT1GWeohZAf606U2zshTA/\
gllcNFWK8qnC8zQfDY/st8U6mDP/I6m7o3bbvgyxsEX6fy/K04L7+AD/aC881QwQdxUie+\
sJr5z4p/A/zv+\
YeQ08YzWadF9FHpM7Osukz9BX0X2hvmM0pFmE9iHB5O3rlmMfqXfhbzEL450Dd0nzmBZuQ\
NcNXHg+DGyfa8vj/F/\
TliX6XsW6z33lHUlwXEhVjv5w0IS//xXv68yHrNr0IfZkIi6zC1CfHsKxJ1FduoU1UKJ6L\
/T4Tx+YJT6OFB3bGXzvCh6J1WcJ6+iL5b1Ynn8L9C/Z3PRfzi36siv6/\
hRZGzLyDHLx6j1y6Es359e2FXndBP5j5Rb5KtgKM2vRRzJCZw7lbJxF9bTKdO6ekdq0/\
GLFKKOriJPcFD43zQ++GXkL8zF/j94ELo3RZd0A9dR/\
J3Zir7qtAvqz0fzblpn46fedWdfXtI/Ee+\
9Y519ErDTuygjta4skDwXVdBvtyyLT1sPmgBrl7sRXx3ewrzxy49B5f1yqNvKrQWvzeHuj\
ulWCz4IS2cfPn49dRLHvn/OQzwykjXsH9SO5GX9JrIuXxC/FfaUI7z3oc5bUrfQei7D+\
TBzSIf0MuemYKnBB4u1Z88lT6yM/jiszP7t4/\
6RtW9HetTiTnzqm8Z1vcBPO5mIPbL7M58Z2MYc26UpNvIffV51MduZb6kfLA0cdchgg9/\
m8r99hB8L7OoEzC7ES9QYhby/+uHgtsun0bPLnuJ/kgROHQ1c4qUTPhqzX+\
XsL9D5mMP124kPje+Deer4TLsi+1KvjfpOvs6mTiRlN6NOMqxIPTjcG/\
8ye37kettE7HbvvPZp2XLkEOPJchNNjx2aj3qhv7Dp+gdyU3wlsvIv/cg6omO7AXnLSR/\
r7zEr9S9NqCfDp8Al47/SH/EKubwaiUfwlv9Ozwm6uNI5mR5LeQ8daH+Ti0Zgr17RR5U/\
XoXHHLuCHJ9byT38428vjRRwh789p14VgT8fPqnbaxDAHNNjJAM7LxDcfD/ilB+\
ZzL8jMpw+LOkuCjiXaUGEIcuGMj56BFHXWhyHfpIW7bmnMyYg36qGsJ5mFKHunzPzcjT6N\
fIWYs9rJfagzl6j1fSn/fNnjoWG5P1Ct+M/\
fss8rsadkcP82bfFos6KzvwtTItAzyzn7oELe537GpUBHbuqgefT/BGH3bvA87udRw/\
wacycaZf9+IXNBbn9pXAO70/sq8N6TNQj25Dn675jJ5qDs+TbNpgH0b1ZV/\
uReBX2ymc74HEN8ws9LuUTv2L5LYLOfagPksdT1+\
zebk++UDnleQRpj1D7u5Go3d9RJ19LfCxcdOBv+tH/6HiNonzdRQ+\
HTkUPnrz8j38kp84V+b4rdjXFv/DH027j9+4NhxcNJF+\
fdlb5GNP9eAcp4q5Mp2yue9ps8BFrl9EfK+smOOwg/qQn7pzP68v8vvd63Ae4h8i/\
y4ib3ktAhzpWYNzaQ9PoibmaSj9v9HX1LAt9W/\
zPxLn71KB9feK5HN7cIYRuJr9TilAvpuNZB0nF0OfV8cPV1fPZV0++wl8NQD5WBgBvsyN5\
vuvbLE/HRqybl94XjMHP1FqjT+jGfDkSCF56If+9POqtyXkKYe+W3XYcNarQgB68pkt/\
39H6LlS9NkaocWY37t0wKD0H69F6ZuQjiQSp5iaDv9+u9fMZe/8zZojKK/LJW5/\
KIx509HwNig9beE5jN2CH5jIHAhjGnlm2ZX6DWlcMHJebyP6pA88x8ZJcJtUxQE7ce8N95\
El6tl7FcXfMalPNcM6oveeE4cwRpH3lTOYsyR/isAunV9H/GUr8Xtl/\
VPyAz7EG9Q6ddCDm2Kpiy5yDb+r6lv6RnfdwI/yciEOfJ9+H009iH6/\
i1wam5g7IrXeLPyFTOJn97oiN8NbiHqx4ux7w0z0R5Ek7FOzIlxvOHOUpaLgFO3fJOT6/\
HOLb0D9aAPe0Joj38uwz1rBefLYc8Q8vDfMz9EfCL9xF/lo+\
XNjnvsOfpWZv5i66S930Mdu8H8a5UqyfsfT8GO+Cj+\
ol8jTPIWHRZuVw75uvYseXSbyS7ungw8yYkWd9GFRrzJX8NT1YN/dB+G/dBA8IQN8sa/\
H4D+TfCJ5jvzyYt4FeVNt9Due3/tfnufCS+JmNgX0+\
1xqy74Wvc73JhXgt8wOwF5l7eZcZVJvJeUWRf9XRa9I65iHolUlnq2msV/\
qEJPr9OXVOIz+kt48Ik7Q+QJ6/yR5dLPNXnDHb9nYzfXUk8mR71nHdOLeUq22+\
FfeIg5dtAfrXjSL+tZ+A9kfA/mU//mXeuhMH/Ss3Vsx3yIH3DlShl/\
syTnOTfsvxD8WDAePtLQDD58AD2jbQwVvyynW1dYHnHTrCn6E9B48v7wBem1SkHUdo39D9\
PHeFIHrsX/qS+I6Uolz3Pe7D/ThlRXxzVdfLRxg3qpBXM0LniG161rO8bW+6P9xHrz/\
JvgQmg1GLrqOQ591oI9JHUxfu1SiKHaiJfhKvf9a8B11Yl7gkxXMnxtyCTyS1pD1rbiA87\
BmMM9vQ/2z2aw/\
56tmIT6vy1wnaRV2SAstjn8XU4J46Xz6RLWaHjx3vaLo91MqctT1Dut3SdTnBzEfT/\
PWWM/KtdC7ng3gy3RoCK7bBT+1djqB/u8dP1vvpYqOlh6Wr9IfZVZGT+\
rJ38m33mPOlXx2O+ft0izsUep+1u0FdlvuDA+G4dSKvOvD5tY6qW+a0T/\
iQ55fTfMkXuk3Erz+\
PoXnebUBOXlShPrMOQXgupiy8IMsf0C9hQku15zJn8ujelL3GzbRup7kquJvpmciz/\
lp9PG/X04/8qohK9J/fL+\
bE3w6TnPwU2t9Ri7OVOM8znJFbw5krplUl3pQqWIW8pfxErv1+\
gL6JtgNfb21AHv54TzP18hgn/LI52nZBdTTTltq+adS+iKeJwAeVT20K/\
5HIfgitRkF4GF5LHUoE+mv14Lga5ErRPCcmdgbLdED/X+mNv5FizHIYYeJyO+NttR7+\
5XET+61kT7oSjJ9uvOP4X8lj6Sfs8RM5mz1WGLxLch57S0+\
X6MYPClm9B6ea8g1zreXF3Hrv6mrNho3wa5vbTQi3dqfptHW5zPTiYM3DmP/\
usHrL094Dk6ufBy/4eoLwTcUiL6r1Bw9n8t5NeJqcB/VLoH7FwaD44e7IN9NSyDXc+\
ZSZ3K5JPHPxKvoF18xR84uFr/0PLhJebiD9xkSdvFjK+Sw2HTwy6Tr/\
E675cjz1nDOd7OS2A8pmvPb+aDga6WOTfEPI26aEE08ssXf7FcS8+eUNbH4t40rYA8ni/\
pq55PYl+I6em5+d+yC43XqUqbW5bz+lks8qVkb8hvu99AfDUajF1xWEr+\
dosED3WWn1Wetlc1eZK3vbcWKC5nD9qJve7639IPRsqO170qqk9VHa44+wLwZ383wI/\
Wzsfr7pLvleO4H7ekv3c6cab1W1hTrd6Z1mf1DDlS7o9Qz3nZBDzedxPnPh79YDxZ6+\
lmaFa/UQs5a9frawAPB1u8MbmTtgzr7Z+zSiHqsZ7nSxBnKIC+qeQQ80akK+\
bFPf6Hn9w0EV/TNQ+\
4mho358ftmshP8ItVOJVv3meFp9RerlSYvtX53AXN9jQmrOMfFPZmr2Wg78jSBegulwxrq\
8I295DMuuXP+nDTiIu82wJNQkM8+/QkfiXKsrcgn1aWv+\
2Bt8iQBH1mHDwHEVw5lMgcqaDPyljwF+euxjXP3D3xr+rpp5Le60j+\
ktdThOfpoG2U9r1dvzXre/\
D7EyRI3YO93D7d4TvTv93da53bcdXhmQnpbfRR6u0rhPz43hr1HH5QuBj9kq3XWe2naeub\
Wh+/bba2f32TikPa9gn681885x1rfcykPb8GzMOaaLyyM/nGDn0ZpUg49+\
b3meut7EffpO4mCH032FnNTbZhDrNSP4rkHPsS/96IvUMqYCF4r/g3/vecH/\
PeYyujtu8Hgs5nwAumuh8ScpmP4L9caWHKuRDKPSl9sS1zKNor429JKxFFDW3C+630AF/\
u3o986bBN8EUcrWTwvyhINfFWmUoD1d4uqc/\
6eORK3XREGD0b1tsThG4g5tIfEHNRZtanDWV8RO+\
FbE7sXTLzT2F8LnrmYjshLSiD++5ba4P+hF9CHSyuCM8cG4DeeJ25tZMPTrbQ9jf/7zRe/\
qSvzD9QO+IeKfge+88dTwA2PDoBn1H+s82nM0K1+fKNNKvp4j0Jdb9wYSw9p07/v+\
bGvst7K4keThsyw+NrM2zWwN8XXEZ/\
5aaXlPyqrEyxeRfXSSOI5qenY9abe6KvKx8E97hVFf/BS6/vmsmB4D+qnsU9jmDcg/\
doOO11iBudo4rg/rOvuDbT4GY1m8FVpC8U867XCz8x+\
gN82FJwvfZ2BnVlJvls9NYG6iCD2XY2Hj1zd4Iee2HAGf3n/n9ivscylV034QNS/\
GgWzr0dZJ9cp2JFmR8DVR5/jx9dbzf7thG/CPEK+VPs6jnPiVJrf20S9nDnrD/\
gggpNYr5gb2P3pYdb5Nf9uA8+eFMo5/\
DoUfX8r1Non6fh09smhsKUfjbYR1j4ZhdMtedNWtwGPNurF55ff9LRexyUOta63/\
St2p25XxXr/++lDP35Hk/LhK9mTa/2+6Tfc+ly9usya/23OeLPLkpOh74f+\
eNVz7kdb79PCLf2k3l9s5TXMLnXQm+d3kveZnww+fXrb0kvyrcex1vfzf4uxvu+\
y0dJnytBb8GHUTbH0rLSeeWpS6WDOT9vUbXzfE7n7JYx1a5KdyPm+w/\
rlOFjnWz4l1iW6caS1TlqYdf+\
qz0CLD0PJmmDpR8kuij622P7IQRP2TVJC4CU5YFh6z9APWLwXitNscE5EFc59p8fgvl9sW\
fcdl7a3DZGMK34jew1p36fafx+5NnFxdW7S3LlJMz+\
X1m7Nmrs1b9WoeZNWTZq5hEwtGN3o/d4KSsiPK62NqmT8+IextNwAPml7t4Hyf2Zli5w="]};
End[]
Protect[ExampleData];
Protect[
ImportSpectrum,CleanFITSHeader,StripHeaderComments,JoinHeader, \
FindDuplicateHeaderKeys, flattenCube, splitMultipleBintable, \
FormatSpectrum, singleBintableQ, hipeBintableQ, classOriginQ, \
MetaDataPattern, SpectrumPattern, MultipleSpectraQ, SpectrumArrayQ, \
SpectralAxisType, VelocityAxisQ, FrequencyAxisQ, HeaderKeyExistsQ, \
absoluteCoordinatesInTFIELDSQ, relativeCoordinatesInTFIELDSQ, \
GetHeaderKeyValue, PutHeaderKeyValue, DeleteHeaderKey, FindSpectralAxis, \
FindRAAxis, FindDecAxis, GetTFIELDDec, GetTFIELDRA, GetDeltaRA, \
GetDeltaDec, GetAbsRA, GetAbsDec, calculateAxisValues, ObservedCoordinates, \
GetCoordinateSystem, GetAbsoluteSpectralAxis, ComposeXYSpectrum, \
RegridSpectralAxis, ToVelocity, ToFrequency, SpectrumPlot, \
BaselineDegree, SetLineWindow, SubtractBaseline, MaskSpectrum, \
SpectralAxisConfiguration, AverageSpectrum, CalculateRMS, \
SmoothSpectrum, ListTFIELDS, TFIELD2FITSKey, HICLASSQ, \
PureDataTableQ, HeaderKeyInDataQ, exData, multibleBintable, \
AngularSeparation, AntennaBeamRadius, AzElToRADec, CosmicBackgroundEnergy , CosmicRayEnergy, \
DaysSince, deltaT, DMStoRad, DMStoRadian, DopplerVelocity, \
EquivalentDisk, Erg2Watt, ErgToJansky,Kelvin2Erg,Erg2Kelvin,KelvinKmsec2Erg,Erg2KelvinKmsec, FrequencyToWavelength, \
FrequencyToWavenumber, FromHMS, FromRadian, FullPrecision, GAST, \
GeocentricToRADec, GMST, GST, HMSList, HMSString, HMSToRad, \
HMSToRadian, HMSToSeconds, HourAngle, HoursToHMS, HydrodynamicEnergy, \
JanskyToErg, JohnsonPhotometricSystem, JulianCenturies, JulianDate, \
KelvinKmsec2Watt, LocalSiderealTime, LST, MagneticEnergy, \
MagneticPressure, ModifiedJulianDate, Nutation, NutationMatrix, \
Obliquity, RADecToAzEl, RADecToHeliocentric, RadianToDMS, \
RadioVelocity, RadianToDMS, RadToHMS, SecondsToHMS, ThermalEnergy, \
ThermalPressure, ToRadian, VelocityDispersionToDopplerWidth, \
VelocityDispersionToFWHM, Watt2Erg, Watt2KelvinKmsec, \
WavelengthToFrequency, WavelengthToWavenumber];
EndPackage[]

