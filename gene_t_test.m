% t-test

% close all; clear;clc

data1_org = readtable('HS4K11-4 KO-rnaExpression.xlsx', 'Range', 'B:D');
data1_arr = table2array(data1_org); 
data2_org = readtable('HS4K11-4 KO-rnaExpression.xlsx', 'Range', 'K:M');
data2_arr = table2array(data2_org); 

data = [data1_arr, data2_arr]; 

num_genes = size(data,1); 

decision = zeros(num_genes,3); %1: p-value; 2:ratio of first/second; 3:final decison,1 means satisfied
flag = zeros(num_genes,1);

for i = 1: num_genes
    gene_ko = data(i,1:3);
    gene_wt = data(i,4:6);
    [h,p,ci,stats] = ttest2(gene_ko, gene_wt);
    
    decision(i,1) = p;
 
    if mean(gene_ko) == 0 && mean(gene_wt)== 0
        decision(i,2) = -1; %discard
    elseif mean(gene_ko) ~= 0 && mean(gene_wt)== 0
        decision(i,2) = -2; % discard
    elseif mean(gene_ko) ==0 && mean(gene_wt) ~=0
        decision(i,2) = -3;
    else
        decision(i,2)=mean(gene_ko)/mean(gene_wt);
    end
    
    if decision(i,1)<0.05 
        if decision(i,2)>=2 || (decision(i,2)<=0.5 && decision(i,2)>0)
            decision(i,3) = 1;
        end
    end
    

   
end

disp(sum(decision(:,3)))  %overall number which satifies the requirements

a = [data,decision];
T = array2table(a, 'VariableNames',...
    {'MCF7_4KO_C_1' 'MCF7_4KO_C_2' 'MCF7_4KO_C_3' 'MCF7_4WT_C_1' 'MCF7_4WT_C_2' 'MCF7_4WT_C_3' 'p_value' 'ratio' 'keepGenes'});

      
writetable(T,'mytest.xlsx','WriteRowNames',true)          




