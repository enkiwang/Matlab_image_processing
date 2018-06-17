function convertData(data,label,chunksz,totalct,savepath )
%convertData: Convert data into HDF5 data type, no return
%   data: input to the CNN, [H, W, C, N]
%   label: output of CNN, [H, W, C, N]
% example: convertData(data,label,128,0,'data_name.h5' );

created_flag = false;
count=size(data,4);
for batchno = 1:floor(count/chunksz)
    last_read=(batchno-1)*chunksz;
    batchdata = data(:,:,1,last_read+1:last_read+chunksz); 
    batchlabs = label(:,:,1,last_read+1:last_read+chunksz);

    startloc = struct('dat',[1,1,1,totalct+1], 'lab', [1,1,1,totalct+1]);
    curr_dat_sz = store2hdf5(savepath, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
    created_flag = true;
    totalct = curr_dat_sz(end);
end
h5disp(savepath);

end

