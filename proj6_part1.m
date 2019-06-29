function [net, info] = proj6_part1()
%code for Computer Vision, Georgia Tech by James Hays
%based off the MNIST and CIFAR examples from MatConvNet
run matconvnet-1.0-beta16/matlab/vl_setupnn ;
%run('matconvnet-1.0-beta16', 'matlab', 'vl_setupnn.m') ;

%It might actually be problematic to run vl_setup, because VLFeat has a
%version of vl_argparse that conflicts with the matconvnet version. You
%shouldn't need VLFeat for this project.
% run(fullfile('vlfeat-0.9.20', 'toolbox', 'vl_setup.m'));

%opts.expDir is where trained networks and plots are saved.
opts.expDir = fullfile('..','data_v11_31c_AMHCD_60-60_Hor_NB_Ratio','part1') ;

%opts.batchSize is the number of training images in each batch. You don't
%need to modify this.
opts.batchSize = 100 ;

% opts.learningRate is a critical parameter that can dramatically affect
% whether training succeeds or fails. For most of the experiments in this
% project the default learning rate is safe.
opts.learningRate = 0.001;% 0.01 for the first 10 epochs
% and 0.001 after 10 epochs

% opts.numEpochs is the number of epochs. If you experiment with more
% complex networks you might need to increase this. Likewise if you add
% regularization that slows training.
opts.numEpochs =  20; % 25

% An example of learning rate decay as an alternative to the fixed learning
% rate used by default. This isn't necessary but can lead to better
% performance.
% opts.learningRate = logspace(-4, -5.5, 300) ;
% opts.numEpochs = numel(opts.learningRate) ;

%opts.continue controls whether to resume training from the furthest
%trained network found in opts.batchSize. If you want to modify something
%mid training (e.g. learning rate) this can be useful. You might also want
%to resume a network that hit the maximum number of epochs if you think
%further training can improve accuracy.
opts.continue = true ;

%GPU support is off by default.
% opts.gpus = [] ;

% --------------------------------------------------------------------
%                                                         Prepare data
% --------------------------------------------------------------------

% The cnn_init function specifies the network architecture. You will be
% modifying the function.
net = proj6_part1_cnn_init();

% The setup_data function loads the training and testing images into
% MatConvNet's imdb structure. You will be modifying the function.

% The commented out code can cache the image database so it isn't rebuilt
% with each run. I found it fast enough to rebuild and less likely to cause
% errors when you change the way images are preprocessed.

% imdb_filename = 'imdb.mat';
% if exist(imdb_filename, 'file')
%   imdb = load(imdb_filename) ;
% else
  imdb = proj6_part1_setup_data();
%   save(imdb_filename, '-struct', 'imdb') ;
% end



%% -------------------------------------------------------------------
%                                                                Train
% --------------------------------------------------------------------

[net, info] = cnn_train(net, imdb, @getBatch, ...
    opts, ...
    'val', find(imdb.images.set == 2)) ;

fprintf('Lowest validation error is %f\n',min(info.val.error(1,:)))
end

% --------------------------------------------------------------------
function [im, labels] = getBatch(imdb, batch)
%getBatch is called by cnn_train.

%'imdb' is the image database.
%'batch' is the indices of the images chosen for this batch.

%'im' is the height x width x channels x num_images stack of images. If
%opts.batchSize is 50 and image size is 64x64 and grayscale, im will be
%64x64x1x50.
%'labels' indicates the ground truth category of each image.

%This function is where you should 'jitter' data.
% --------------------------------------------------------------------
N = length(batch);
im = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;

% Add jittering here before returning im
for i = 1:N
% old1. choose number to flip, this case it is all the batch
%num_flip = round(length(batch)); %num_flip = round(length(batch) / 2);
% old2. choose random indexes to be flipped
%flip_ind = randperm(length(batch),num_flip); %randperm(50,25)?25 rand.indices from 1 to 50

% using indexing to flip or mirror the selected values
% roll = rand();
% if roll>0.5
%     im(:,:,:,i) = im(:,end:-1:1,:,i); % or im(:,:,:,ind) =  fliplr(im(:,:,:,ind));
% end

%randomly rotate the training images for jittering
roll = rand();
if roll>0.5
    im(:,:,:,i) = rotating(im(:,:,:,i)); 
end

% randomly scale the training images for jittering
roll = rand();
if roll>0.5
    im(:,:,:,i) = scaling2(im(:,:,:,i));
    %imshow(im(:,:,:,i));
end
end

end


