# Multi-TE SANDI
Implementation of multi-TE SANDI (MTE-SANDI)) for model-based relaxation-diffusion MRI data analysis.

This repository contains the preliminary release of the code for the analysis of multi echo time (multi-TE) diffusion-weighted MRI data as presented in Ting Gong, CM Tax, Matteo Mancini, Derek K Jones, Hui Zhang, Marco Palombo, "Multi-TE SANDI: Quantifying compartmental T2 relaxation times in the grey matter", 2023 International Society of Magnetic Resonance in Medicine annual meeting & exhibition, abstract: #766 (https://archive.ismrm.org/2023/0766.html).

This code was created during the project: "Combined diffusion-relaxometry model fitting" (https://github.com/connecthon/2022/issues/5) in the Hackathon CONNECthon (https://connecthon.github.io/2022/), held at Cardiff University on May 2022. 

NOTE: this is a preliminary release and as such it is not optimized and works only on one subject at a time (each subject can have multiple diffusion-weighted MRI data at different TE values). 

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
$ git clone https://github.com/palombom/MultiTE-SANDI-Matlab-Toolbox-v1.0.git
```
4. Add the MTE-SANDI folder and subfolders to your Matlab path list. 
5. You should now be able to use the code. 

## Usage
First download the SANDI Matlab Toolbox from https://github.com/palombom/SANDI-Matlab-Toolbox-Latest-Release

Then, before running the main function 'MTE_SANDI', all the data should be arranged into folders named: "Data_TEXXX", where XXX is the corresponding TE value in milliseconds. The structure of the "Data_TEXXX" is like the structure of the "ProjectMainFolder" expected by the SANDI MAtlab Toolbox, i.e.:

- ProjectMainFolder
 - Data_TE54
  - derivatives
    - preprocessed
      - sub-01
        - ses-01
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.nii.gz
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bval
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bvec
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_mask.nii.gz
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_noisemap.nii.gz
        - ...
        - ses-n
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.nii.gz
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bval
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bvec
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_mask.nii.gz
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_noisemap.nii.gz
      - ...
      - sub-n
        - ses-01
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.nii.gz
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bval
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bvec
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_mask.nii.gz
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_noisemap.nii.gz
        - ...
        - ses-n
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.nii.gz
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bval
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bvec
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_mask.nii.gz
          - sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_noisemap.nii.gz


The code will run two steps: 
- Step 1 - Fitting SANDI to data at each TE independently
- Step 2 - Estimating compartmental T2 relaxation times and relaxation unbiased signal fractions

The output will be saved into a new folder named "MTE-SANDI_analysis" within the ProjectMainFolder. Differently from the SANDI Matlab Toolbox, this code will not process authomatically all the subjects; but it will process only sub-01/ses-01. Modify it according to your necessities.

## Citation
If you use MTE-SANDI, please remember to cite our main SANDI work:

1. Marco Palombo, Andrada Ianus, Michele Guerreri, Daniel Nunes, Daniel C. Alexander, Noam Shemesh, Hui Zhang, "SANDI: A compartment-based model for non-invasive apparent soma and neurite imaging by diffusion MRI", NeuroImage 2020, 215: 116835, ISSN 1053-8119, DOI: https://doi.org/10.1016/j.neuroimage.2020.116835. 

and its extension to multi-TE data:

2. Ting Gong, CM Tax, Matteo Mancini, Derek K Jones, Hui Zhang, Marco Palombo, "Multi-TE SANDI: Quantifying compartmental T2 relaxation times in the grey matter", 2023 International Society of Magnetic Resonance in Medicine annual meeting & exhibition, abstract: #766 (https://archive.ismrm.org/2023/0766.html).

3. Ting Gong, Qiqi Tong, Hongjian He, Yi Sun, Jianhui Zhong, Hui Zhang, "MTE-NODDI: Multi-TE NODDI for disentangling non-T2-weighted signal fractions from compartment-specific T2 relaxation times", Neuroimage 2020, 217: 116906, DOI: https://doi.org/10.1016/j.neuroimage.2020.116906.

## License
MTE-SANDI is distributed under the BSD 2-Clause License (https://github.com/palombom/MultiTE-SANDI-Matlab-Toolbox-v1.0/blob/main/LICENSE), Copyright (c) 2022 Cardiff University. All rights reserved.

**The use of MTE-SANDI code MUST also comply with the individual licenses of all of its dependencies.**

## Acknowledgements
The development of MTE-SANDI was supported by the UKRI Future Leaders Fellowship MR/T020296/2.



