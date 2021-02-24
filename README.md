# SpectrumPlot


SpectrumPlot is a Mathematica package for importing and displaying astronomical spectral data.

## Spectrum Data Model

Astronomical spectra are usually stored in the FITS file format, composed of a header (Import[<FITS file>,"Metadata"]) and the actual spectrum data (Import[<FITS file>,"RawData"]). The header contains all information necessary to assign the data to an astronomical observation (e.g. object name, coordinates, OBS-ID, etc.), to describe the kind of data (e.g. spectral maps, integrated intensity maps, single spectra, etc.), to specify physical units of the data content (e.g. unit of the spectral axis, velocity or frequency, unit of the data axis, e.g. Jansky, erg/s/cm^2/sr/Hz, etc.) and any other explanatory information in order to make sense of the data.

``` mathematica
Import[file,"FITS","Metadata"]    imports header information
Import[file,"FITS","RawData"]    imports raw (unscaled) data
```

Manual import of spectrum data from FITS files.


Many functions from the `SpectrumPlot'context` work on a spectrum data object. A spectrum data object is a List of the form: `List[header information, raw data]`. It has to be created from the spectrum FITS file. If the FITS file contains only a single spectrum this is trivial: The FITS header gives all required header information, the data part gives the spectrum data.
 
## Spectrum formatting

Some of the functions in the `SpectrumPlot'context` require access to the header and data information. Most of these functions are low-level functions that are not necessary for the average user. In this section we will describe how the header and data information from the FITS file are converted to a spectrum data object. Each spectrum will be stored in the form `{{"Metadata"},{List of y values}}`. The x-scale is calculated from the Metadata header upon display.

`GetAbsoluteSpectralAxis[head]`    calculate explicit values for the spectral axis Get the absolute frequency/velocity values for each data point.

The spectral axis is given in units of m/s. The data axis is given in Jy/beam.

<img style="float: right;" src="https://github.com/markusroellig/SpectrumPlot/blob/main/im1.png" width="400">

In the example data used so far, the whole data cube, i.e. the whole map, shared the same header information. This is common for regularly sampled maps, where, e.g. the absolute coordinates of an individual data point can be derived from its index and the header information. This is not necessarily always the case. For this reason we convert the data into spectrum data objects, where each spectrum is assigned its own, relevant metadata, collected from all available FITS header information.

`FormatSpectrum[data,header]`    converts the data into spectrum data objects
`ImportSpectrum[file]`    import one or more spectra

## Convert/import FITS spectra.

Convert the data to the spectrum format.

``` mathematica
In[15]:= spectra = FormatSpectrum[data, head];

Spectrum formating done. 1024 Spectra found in a 32 * 32 (R.A. * Dec) array.

In[75]:= Dimensions[spectra]

Out[75]= {32, 32, 2}

In[77]:= spectra[[15, 15]]

Out[77]= {{"SIMPLE" -> True, "BITPIX" -> -32, "NAXIS" -> 4, "NAXIS1" -> 1,
  "NAXIS2" -> 1, "NAXIS3" -> 256, "NAXIS4" -> 1, "EXTEND" -> True,
  "BSCALE" -> 1., "BZERO" -> 0., "BLANK" -> -1, "TELESCOP" -> "NRAO 12M",
  "CDELT1" -> 0.005, "CRPIX1" -> 1, "CRVAL1" -> 56.7043,
  "CTYPE1" -> "RA---SIN", "CDELT2" -> -0.01, "CRPIX2" -> 1,
  "CRVAL2" -> 68.0991, "CTYPE2" -> "DEC--SIN", "CDELT3" -> -2600.81,
  "CRPIX3" -> 128.5, "CRVAL3" -> 34000., "CTYPE3" -> "VELO-LSR",
  "CDELT4" -> 1., "CRPIX4" -> 1., "CRVAL4" -> 1., "CTYPE4" -> "STOKES",
  "DATE-OBS" -> "1999-01-04T00:00:00.0", "RESTFREQ" -> 1.15271*10^11,
  "CELLSCAL" -> "CONSTANT", "BMAJ" -> 0.0152778, "BMIN" -> 0.0152778,
  "OBSERVER" -> "tth KEL", "OBJECT" -> "IC342", "EPOCH" -> 2000.,
  "BUNIT" -> "JY/BEAM", "BPA" -> 0., "DATAMIN" -> -36.6547,
  "DATAMAX" -> 34.1493,
  "ORIGIN" ->
   "Miriad Fits: version 1.1 27-nov-00"}, {0.25327, -0.244473, -1.71506,
  1.03068, -0.879421, 0.0097036, 1.18207, 2.40512, 2.24225,
  1.33502, -0.764517, -0.546583, 0.253489, -1.92562, -0.0727707, 0.638939,
  1.08128, -0.429872, -0.035979, 0.523817, 1.42553, 0.622265, 0.397134,
  0.503238, 0.0953341, 0.0179781,
  0.95436, -0.220185, -1.06328, -0.286032, -2.28829, -0.98148, -1.91515, \
-3.48687, -1.63463, 0.316707, -0.0291452, -0.925608, 0.337196, 2.20654,
  1.8055, 0.752775, 1.67907, -0.224855, -1.72502, -1.08897, -0.0165796,
  0.357823, -0.797994, 0.336236, 0.0330825, -0.50978, -1.37767, 1.39332,
  1.14096, -0.495349, 1.43618, 0.695406, -0.549897, -0.561062,
  0.389437, -1.66873, 1.15367, -1.63294, 0.661677, -0.213339, -1.1287,
  1.00411, 1.43047, 1.47356, 1.66486, 0.83823, 1.13526, -0.631715, 1.56442,
  0.644863, 0.376567, 0.459696, -1.05434,
  0.948371, -0.197794, -1.43176, -1.99165, -1.05955,
  0.325173, -0.797091, -1.33285, -0.0542229, 0.518403, 1.7459, 0.393945,
  0.55625, -0.681775,
  0.123913, -0.0717658, -0.0439017, -2.29421, -1.09347, -0.107982, -0.105677, \
-1.03387, -0.046841, -1.18831, -0.250906, -0.368276, -0.310492, 0.769749,
  0.538752, 2.43631, 3.56858, 2.40484, 3.5327, 3.99676, 4.38099, 5.45252,
  6.47564, 7.35641, 6.46419, 6.62432, 7.4997, 6.79189, 9.3373, 7.31569,
  11.3048, 13.0852, 14.0577, 14.389, 14.5563, 14.86, 14.4369, 14.979, 13.963,
  13.4535, 13.0197, 14.0374, 15.647, 16.3528, 15.0586, 14.0929, 12.1952,
  7.10239, 9.11448, 11.187, 9.91873, 7.70704, 6.7053, 6.76993, 4.61979,
  1.44372, 2.04915, 0.609943, 0.683794, -0.972196, 1.24542, 0.266655,
  0.693843, 0.0970313, -0.37799, -0.0163991, 0.271731, 1.30639, 0.679949,
  1.80415, -0.247162, -0.188215, -0.761393, -0.14242, -1.08401, -0.197549,
  0.0135975, -0.993207, -1.1817, -0.912727, 0.153965, 1.71886, 0.251242,
  1.75624, -0.233538, -0.0557876, -1.33939, 0.578441, -1.16679, 1.01366,
  1.20657, 0.479215, -0.174132, -1.58612, -1.80484, -0.458567, -0.36082, \
-0.178281, -0.194348, -0.141621, 1.83792, -0.322953, 2.54433, -0.37536,
  0.367283, 0.632668, 0.132611,
  0.183506, -1.88134, -2.11309, -1.14829, -0.892687, 0.563191, 0.0684625,
  0.684481, 2.44518, 0.0772046, -1.08187, -1.16946, 0.204559, 1.32042,
  0.107878, -0.598194, 1.20869,
  1.21482, -0.661142, -1.93288, -1.93952, -1.15952, -0.776684, -1.39569, \
-0.524046, -0.422682, 0.975314, 1.60071, -0.925701, -0.530241,
  0.991526, -0.430284, 0.045887, 1.48438, 0.721144, 0.141807, 1.04822,
  0.95333, -1.25845, -1.92157, -0.284268,
  0.251807, -0.553212, -2.21509, -0.0738008, 1.95772, 1.34513, -0.65906,
  0.859924, -0.787554, 1.1443, 1.78666, -0.961647, -1.39028, 2.57114,
  1.26939}}
```

We see that every single spectrum now has its own, individual header information.

## Working with spectra
###Plotting spectra

The `SpectrumPlot'context` offers the function SpectrumPlot to plot one or more astronomical spectra. By default the bottom x-axis is given in velocity units (usually in km/s) the top x-axis in frequency units (usually in GHz).

Plotting an example spectrum:

``` mathematica
SpectrumPlot[spectra[[15, 15]], ImageSize -> Medium]
```
<img style="float: right;" src="https://github.com/markusroellig/SpectrumPlot/blob/main/im2.png" width="400">

You can also plot multiple spectra in the same plot.
Give a list of spectra as argument:

```mathematica
SpectrumPlot[Flatten[spectra[[14 ;; 17, 14 ;; 17]], 1], ImageSize -> Medium]
```
<img style="float: right;" src="https://github.com/markusroellig/SpectrumPlot/blob/main/im3.png" width="400">

###Data Reduction

SpectrumPlot offers several functions to perform standard data reduction task, including smoothing, averaging, masking and fitting.

`AverageSpectrum[{s1,s2,...}]`    average a list of spectra s1,s2,...
`CalculateRMS[spec]`    calculate the RMS of spec
`MaskSpectrum[spec,{{Subscript[v, min],Subscript[v, max]},\[Ellipsis]},Subscript[f, 0]]`    masks parts of the spectrum to be ignored during the fitting
`RegridSpectralAxis[Subscript[spec, r],spec]`    spectral regridding of spec to the reference spectrum Subscript[spec, r]
`SmoothSpectrum[spec]`    smoothes a spectrum spec
`SubtractBaseline[spec]`    subtracts a polynomial baseline from a spectrum spec

If a list of spectra have a common spectral axis AverageSpectrum can be used to average them. So far two methods are supported: simple arithmetic mean and RMS weighted mean.

Average spectrum of a 2 spectra:

``` mathematica
SpectrumPlot[{spectra[[15, 15]], spectra[[14, 14]],AverageSpectrum[{spectra[[15, 15]], spectra[[14, 14]]}] /. Missing[] -> 0},ImageSize -> Medium, PlotStyle -> {Automatic, Automatic, Thick}]
```
<img style="float: right;" src="https://github.com/markusroellig/SpectrumPlot/blob/main/im4.png" width="400">


More information can be found in the package documentation.
