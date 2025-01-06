# Multi-TE SANDI
Implementation of multi-TE SANDI for relaxation-diffusion MRI data analysis.

This repository contains the first code for the analysis of multi echo time (multi-TE) diffusion-weighted MRI data as presented in Ting Gong, CM Tax, Matteo Mancini, Derek K Jones, Hui Zhang, Marco Palombo, "Multi-TE SANDI: Quantifying compartmental T2 relaxation times in the grey matter", 2023 International Society of Magnetic Resonance in Medicine annual meeting & exhibition, abstract: #766 (https://archive.ismrm.org/2023/0766.html).

For queries or suggestions on how to improve this repository, please email: palombom@cardiff.ac.uk 

## Dependencies
- A MATLAB distribution with the Parallel Computing Toolbox, the Statistics and Machine Learning Toolbox and the Optimization Toolbox.
- The SANDI Matlab Toolbox from https://github.com/palombom/SANDI-Matlab-Toolbox-Latest-Release.

## Download 
If you use Linux or MacOS:

1. Open a terminal;
2. Navigate to your destination folder;
3. Clone MTE-SANDI:
```
$ git clone https://github.com/palombom/MTE-SANDI.git
```
4. Add the MTE-SANDI folder and subfolders to your Matlab path list. 
5. You should now be able to use the code. 

## Usage


## Citation
If you use MTE-SANDI, please remember to cite our main SANDI work:

1. Marco Palombo, Andrada Ianus, Michele Guerreri, Daniel Nunes, Daniel C. Alexander, Noam Shemesh, Hui Zhang, "SANDI: A compartment-based model for non-invasive apparent soma and neurite imaging by diffusion MRI", NeuroImage 2020, 215: 116835, ISSN 1053-8119, DOI: https://doi.org/10.1016/j.neuroimage.2020.116835. 

and its extension to multi-TE data:

2. Ting Gong, CM Tax, Matteo Mancini, Derek K Jones, Hui Zhang, Marco Palombo, "Multi-TE SANDI: Quantifying compartmental T2 relaxation times in the grey matter", 2023 International Society of Magnetic Resonance in Medicine annual meeting & exhibition, abstract: #766 (https://archive.ismrm.org/2023/0766.html).

3. Ting Gong, Qiqi Tong, Hongjian He, Yi Sun, Jianhui Zhong, Hui Zhang, "MTE-NODDI: Multi-TE NODDI for disentangling non-T2-weighted signal fractions from compartment-specific T2 relaxation times", Neuroimage 2020, 217: 116906, DOI: https://doi.org/10.1016/j.neuroimage.2020.116906.

## License
MTE-SANDI is distributed under the BSD 2-Clause License (https://github.com/palombom/SANDI-Matlab-Toolbox/blob/main/LICENSE), Copyright (c) 2022 Cardiff University. All rights reserved.

**The use of MTE-SANDI code MUST also comply with the individual licenses of all of its dependencies.**

## Acknowledgements
The development of MTE-SANDI was supported by the UKRI Future Leaders Fellowship MR/T020296/2.



