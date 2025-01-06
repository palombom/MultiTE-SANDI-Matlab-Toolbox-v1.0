clear all
close all
clc

% This code estimates relaxation-unbiased signal fractions and compartmental T2 values using the MTE-SANDI approach, introduced in: Ting Gong, CM Tax, Matteo Mancini, Derek K Jones, Hui Zhang, Marco Palombo, "Multi-TE SANDI: Quantifying compartmental T2 relaxation times in the grey matter", 2023 International Society of Magnetic Resonance in Medicine annual meeting & exhibition, abstract: #766 (https://archive.ismrm.org/2023/0766.html). 

% Author:
% Dr. Marco Palombo
% Cardiff University Brain Research Imaging Centre (CUBRIC)
% Cardiff University, UK
% Jan 2025
% Email: palombom@cardiff.ac.uk


TE = [54, 75, 100, 125, 150]; % Vector containing the TE values acquired, in milliseconds
Delta = 22; % diffusion gradients separation, Delta
smalldelta = 8; % diffusion grdients duration, smalldelta

MainDataFolder = 'C:\Users\mirko\OneDrive - Cardiff University\Desktop\CurrentWorks\MTE-SANDI\example_data';

%% First run SANDI Matlab Toolbox for each TE individually

%Before running the code, all the data should have been arranged into
%folders named: "Data_TEXXX", where XXX is the corresponding TE value in
% milliseconds. The structure of the "Data_TEXXX" is like the structure of
% the "ProjectMainFolder" expected by the SANDI MAtlab Toolbox, i.e.:
% - ProjectMainFolder
% |-> - derivatives
%     |--> - preprocessed
%          |---> - sub-01
%                |----> - ses-01
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.nii.gz
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bval
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bvec
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_mask.nii.gz
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_noisemap.nii.gz
%                   ...
%                |----> - ses-n
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.nii.gz
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bval
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bvec
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_mask.nii.gz
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_noisemap.nii.gz
%            ...
%          |---> - sub-n
%                |----> - ses-01
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.nii.gz
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bval
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bvec
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_mask.nii.gz
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_noisemap.nii.gz
%                   ...
%                |----> - ses-n
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.nii.gz
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bval
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_dwi.bvec
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_mask.nii.gz
%                       |-----> sub-<>_ses-<>_acq-<>_run-<>_desc-preproc_noisemap.nii.gz

disp('Step 1 - Fitting SANDI to data at each TE independently ... ')
for i=1:numel(TE)

    ProjectMainFolder = fullfile(MainDataFolder, ['Data_TE' num2str(TE(i))]);
    SNR = [];

    SANDIinput = SANDI_batch_analysis(ProjectMainFolder, Delta, smalldelta, SNR); % Run the SANDI analysis for each TE individually

end
%% Then estimate relaxation-unbiased signal fractions and compartmental T2 values 

disp('Step 2 - Estimating compartmental T2 relaxation times and relaxation unbiased signal fractions ... ')

fn = [];
fs = [];
fe = []; 

Din = [];
De = [];
Rsoma = []; 

% Load the SANDI estimated signal fractions for each of the TE values
for i=1:numel(TE)
    
    MainSANDIfolder = fullfile(MainDataFolder, ['Data_TE' num2str(TE(i))], 'derivatives\SANDI_analysis\sub-01\ses-01\SANDI_Output');

    tmp = load_untouch_nii(fullfile(MainSANDIfolder, 'SANDI-fit_fneurite.nii.gz'));
    fn(:,:,:,i) = double(tmp.img(:,:,:));

    tmp = load_untouch_nii(fullfile(MainSANDIfolder, 'SANDI-fit_fsoma.nii.gz'));
    fs(:,:,:,i) = double(tmp.img(:,:,:));

    tmp = load_untouch_nii(fullfile(MainSANDIfolder, 'SANDI-fit_fextra.nii.gz'));
    fe(:,:,:,i) = double(tmp.img(:,:,:));

    tmp = load_untouch_nii(fullfile(MainSANDIfolder, 'SANDI-fit_Din.nii.gz'));
    Din(:,:,:,i) = double(tmp.img(:,:,:));
        
    tmp = load_untouch_nii(fullfile(MainSANDIfolder, 'SANDI-fit_De.nii.gz'));
    De(:,:,:,i) = double(tmp.img(:,:,:));
        
    tmp = load_untouch_nii(fullfile(MainSANDIfolder, 'SANDI-fit_Rsoma.nii.gz'));
    Rsoma(:,:,:,i) = double(tmp.img(:,:,:));
    
end

% Load the b=0 images for each TE
b0 = [];
for i=1:numel(TE)

    datafolder = fullfile(MainDataFolder, ['Data_TE' num2str(TE(i))], 'derivatives', 'preprocessed', 'sub-01', 'ses-01');

    tmp = dir(fullfile(datafolder, '*_dwi.nii.gz'));
    datafile = fullfile(tmp.folder, tmp.name);
    tmp = dir(fullfile(datafolder, '*_dwi.bval'));
    bvalfile = fullfile(tmp.folder, tmp.name);

    tmp = load_untouch_nii(datafile);
    dwi = double(tmp.img(:,:,:,:));
    bval = importdata(bvalfile);
    b0(:,:,:,i) = nanmean(dwi(:,:,:,bval==0), 4);

end

fn = reshape(fn, [size(fn,1)*size(fn,2)*size(fn,3), size(fn,4)]);
fs = reshape(fs, [size(fs,1)*size(fs,2)*size(fs,3), size(fs,4)]);
fe = reshape(fe, [size(fe,1)*size(fe,2)*size(fe,3), size(fe,4)]);
S0 = reshape(b0, [size(b0,1)*size(b0,2)*size(b0,3), size(b0,4)]);

Y = log( fn.*S0 );
X = [TE', ones(size(TE'))];
cc = linsolve(X,Y');

T2n = -1./cc(1,:);
S0n = exp(cc(2,:));

Y = log( fs.*S0 );
X = [TE', ones(size(TE'))];
cc = linsolve(X,Y');

T2s = -1./cc(1,:);
S0s = exp(cc(2,:));

Y = log( fe.*S0 );
X = [TE', ones(size(TE'))];
cc = linsolve(X,Y');

T2e = -1./cc(1,:);
S0e = exp(cc(2,:));

fn0 = S0n./(S0n + S0s + S0e);
fs0 = S0s./(S0n + S0s + S0e);
fe0 = S0e./(S0n + S0s + S0e);

T2n_map = reshape(T2n, [size(b0,1), size(b0,2) size(b0,3)]);
T2s_map = reshape(T2s, [size(b0,1), size(b0,2) size(b0,3)]);
T2e_map = reshape(T2e, [size(b0,1), size(b0,2) size(b0,3)]);

fn0_map = reshape(fn0, [size(b0,1), size(b0,2) size(b0,3)]);
fs0_map = reshape(fs0, [size(b0,1), size(b0,2) size(b0,3)]);
fe0_map = reshape(fe0, [size(b0,1), size(b0,2) size(b0,3)]);

%% Save the output maps within a new folder 'MTE-SANDI_maps'

disp('Saving the MTE-SANDI parametric maps ... ')

tmp = load_untouch_nii(fullfile(MainSANDIfolder, 'SANDI-fit_fneurite.nii.gz')); % Load representative NIFTI

outputfolder = fullfile(MainDataFolder, 'MTE-SANDI_analysis');
mkdir(outputfolder);

tmp.img = T2n_map;
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_T2neurite.nii.gz'));
tmp.img = T2s_map;
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_T2soma.nii.gz'));
tmp.img = T2e_map;
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_T2extra.nii.gz'));

tmp.img = fn0_map;
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_fneurite0.nii.gz'));
tmp.img = fs0_map;
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_fsoma0.nii.gz'));
tmp.img = fe0_map;
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_fextra0.nii.gz'));

tmp.img = mean(Din,4);
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_MeanDin.nii.gz'));
tmp.img = mean(De, 4);
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_MeanDe.nii.gz'));
tmp.img = mean(Rsoma, 4);
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_MeanRsoma.nii.gz'));

tmp = load_untouch_nii(datafile);
tmp.img = Din;
tmp.hdr.dime.dim(5) = size(tmp.img, 4);
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_MTE-Din.nii.gz'));
tmp.img = De;
tmp.hdr.dime.dim(5) = size(tmp.img, 4);
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_MTE-De.nii.gz'));
tmp.img = Rsoma;
tmp.hdr.dime.dim(5) = size(tmp.img, 4);
save_untouch_nii(tmp, fullfile(outputfolder, 'MTE-SANDI-fit_MTE-Rsoma.nii.gz'));