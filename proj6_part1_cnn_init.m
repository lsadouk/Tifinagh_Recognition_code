function net = proj6_part1_cnn_init()
%code for Computer Vision, Georgia Tech by James Hays
%based of the MNIST example from MatConvNet

rng('default');
rng(0);

% constant scalar for the random initial network weights. You shouldn't
% need to modify this.
f=1/100; 

bias = 0.01;
net.layers = {} ;

net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(5,5,1,20, 'single'), zeros(1, 20, 'single')}}, ...
                           'biases', bias*ones(1, 20, 'single'), ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', 1, ...
                           'biasesWeightDecay', 0, ...
                           'name', 'conv1') ;
net.layers{end+1} = struct('type', 'relu') ;                       
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ; %[7 7] st=7


%% --------------- added --------------
                  
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(4,4,20,50, 'single'), zeros(1, 50, 'single')}}, ...
                           'biases', bias*ones(1, 50, 'single'), ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', 1, ...
                           'biasesWeightDecay', 0, ...
                           'name', 'conv2') ;
net.layers{end+1} = struct('type', 'relu') ;                       
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ; 



%% -------------------------------
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(3,3,50,150, 'single'), zeros(1, 150, 'single')}}, ...
                           'biases', bias*ones(1,150,'single'), ...
                           'stride', 1, ...
                           'pad', 1, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', 1, ...
                           'biasesWeightDecay', 0, ...
                           'name', 'conv3') ;
net.layers{end+1} = struct('type', 'relu') ;                       

%% -------------------------------
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(3,3,50,150, 'single'), zeros(1, 150, 'single')}}, ...
                           'biases', bias*ones(1,150,'single'), ...
                           'stride', 1, ...
                           'pad', 1, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', 1, ...
                           'biasesWeightDecay', 0, ...
                           'name', 'conv4') ;
net.layers{end+1} = struct('type', 'relu') ;                       
                                        
%% -------------------------------                       
 net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(3,3,150,150, 'single'), zeros(1, 150, 'single')}}, ...
                           'biases', bias*ones(1,150,'single'), ...
                           'stride', 1, ...
                           'pad', 1, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', 1, ...
                           'biasesWeightDecay', 0, ...
                           'name', 'conv5') ;
net.layers{end+1} = struct('type', 'relu') ;                                             
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ; 
%% -------------------------------        
%net.layers{end + 1} = struct('type','dropout','rate',0.5);
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(6,6,150,500, 'single'), zeros(1, 500, 'single')}}, ...
                           'biases', bias*ones(1,500,'single'), ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', 1, ...
                           'biasesWeightDecay', 0, ...
                           'name', 'fc1') ;
net.layers{end+1} = struct('type', 'relu') ;   
net.layers{end + 1} = struct('type','dropout','rate',0.5);
%% -------------------------------                       

net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(1,1,500,500, 'single'), zeros(1, 500, 'single')}}, ...
                           'biases', bias*ones(1,500,'single'), ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', 1, ...
                           'biasesWeightDecay', 0, ...
                           'name', 'fc2') ;
net.layers{end+1} = struct('type', 'relu') ;   
net.layers{end + 1} = struct('type','dropout','rate',0.5);
%% -------------------------------                       
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(1,1,500,31, 'single'), zeros(1, 31, 'single')}}, ...
                            'biases', bias*ones(1, 31, 'single'), ...   
                            'stride', 1, ...
                           'pad', 0, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', 1, ...
                           'biasesWeightDecay', 0, ...
                           'name', 'fc3') ;
%% -------------------------------
% Loss layer
net.layers{end+1} = struct('type', 'softmaxloss') ;

% Visualize the network
vl_simplenn_display(net, 'inputSize', [60 60 1 100])