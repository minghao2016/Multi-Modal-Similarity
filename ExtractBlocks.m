function [ output_args ] = ExtractBlocks( filename, patchSize )
%EXTRACTBLOCKS extracts the blocks from the images and returns patches in a
% matrix. whose each row corresponds to a patch.
%USAGE: ExtractBlocks('T1_01.TIFF')
 
  %%extract blocks and reshape them to flat out array
  %Changes to make patchSize dynamic by passing it as an input parameter.
  %extract = @(block_struct) reshape(block_struct.data,[1 100]);
  totalPointsInPatch = patchSize * patchSize;
  extract = @(block_struct) reshape(block_struct.data,[1 totalPointsInPatch]);
  
  %Changes to make patchSize dynamic by passing it as an input parameter.
  %Blocks = blockproc(filename,[10 10],extract,'PadPartialBlocks',true);
  Blocks = blockproc(filename,[patchSize patchSize],extract,'PadPartialBlocks',true);
  
  %%blocproc concats into a matrix, so flat out the matrix
  pixels = numel(Blocks);
  Blocks = reshape(Blocks,[1 pixels]);
  
  %%extract and arrange the patch specific pixels in a row
%   patches = zeros(pixels/100,100);
%   offset=1;
%   for i=1:(pixels/100)
%       patches(i,:)=Blocks(offset:(offset+99));
%       offset =offset+100;
%   end
  
  %Changes to make patchSize dynamic by passing it as an input parameter.
  %%extract and arrange the patch specific pixels in a row
  patches = zeros(pixels/totalPointsInPatch,totalPointsInPatch);
  offset=1;
  for i=1:(pixels/totalPointsInPatch)
      patches(i,:)=Blocks(offset:(offset+totalPointsInPatch-1));
      offset =offset+totalPointsInPatch;
  end
  
  output_args = patches;
  
end

