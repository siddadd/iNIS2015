% This script generates all the graphs needed for iNIS 2015
% Siddharth Advani
% Menu
% 4 - Fig 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clf;
addpath(genpath(pwd));
MENU = 4

switch (MENU)
    
    case 1
        % Plot Confusion Matrix of HMAX
        
        load('/home/mdl/ska130/Neo_IPP/PSU/sim/HMAX/fhpkg/cns/hmax/results/256x256_CalTech16/NAR/Iteration1/hmin_256x256_caltech16_76_31pc.mat');
        avg_scores(1) = mean(scores);
        load('/home/mdl/ska130/Neo_IPP/PSU/sim/HMAX/fhpkg/cns/hmax/results/256x256_CalTech16/NAR/Iteration/hmin_256x256_caltech16_78_705pc.mat');
        avg_scores(2) = mean(scores);
        title = ['Confusion Matrix for CalTech 16 - Avg Accuracy = ' num2str(mean(avg_scores)) '%'];
        [C,h] = confusionMatrix(testCats, predCats, title, catNames);
        set(h,'Color',[1 1 1]);
        set(gca, 'FontName', 'Helvetica')
        set(gcf, 'PaperPositionMode', 'auto');
        print -depsc2 Confusion.eps
        
    case 2
        M = csvread('error_rate_32GB.csv');
        loglog(M(:,1),M(:,2), '-k', 'LineWidth', 1);
        ylabel('Cumulative Cell Failure Probability', 'FontSize', 14);
        xlabel('Refresh Interval (sec)', 'FontSize', 14);
        title('Error Rate in 32 GB DRAM', 'FontSize', 16);
        
    case 3
        % Plot Accuracy Sensitivity
        Refresh = [64, 256, 400, 512, 600, 800]; % ms
        PixInError = [0, 128, 256, 512, 1024, 4096];
        Accuracy = [78.602, 78.02, 76.61, 76.72, 74.213, 66.27];
        NumBitErrors = [0, 1024, 2048, 4096, 8192];
        Zeros = zeros(1, numel(Refresh));
        poly1 = polyfit(1:numel(Refresh), Accuracy, 6);
        fit1 = polyval(poly1, 1:numel(Refresh));
        plot(1:numel(Refresh), fit1, '-ok', 'LineWidth', 1, 'Marker', 'o', 'MarkerSize', 8, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor', [.7 .7 .7]);
        hold on;
        plot(repmat(4,1,4),[50,60,70,76.5], '--k', 'LineWidth', 1);
        ylim = [50 90];
        set(gca, 'YLim', ylim);
        set(gca,'XLim',[0 numel(Refresh)+1]);
        set(gca,'XTick',0:numel(Refresh));
        set(gca,'XTickLabel', [0 Refresh])
        ylabel('Classification Rates (%)', 'FontSize', 14);
        xlabel('32 GB DRAM Retention Time (ms)', 'FontSize', 14);
        title('HMAX Sensitivity to Retention Times', 'FontSize', 16);
        %[AX,H1,H2] = plotyy(Refresh, Accuracy, Zeros, NumBitErrors, @loglog);
        set(gca, 'FontName', 'Helvetica')
        set(gcf, 'PaperPositionMode', 'auto');
        print -depsc2 RTSensitivityAnalysis.eps
        
        
    case 4
        % Plot Accuracy Sensitivity
        Refresh = [64, 256, 400, 512, 600, 800 1000]; % ms
        PixInError = [0, 128, 256, 512, 1024, 4096, 9830];
        Zeros = zeros(1, numel(Refresh));
        Accuracy = [78.602, 78.02, 76.61, 76.72, 74.213, 66.27, 49.28];
        NumBitErrors = [0, 1024, 2048, 4096, 8192, 32768, 100000];
        poly1 = polyfit(0:numel(PixInError)-1, Accuracy, 6);
        fit1 = polyval(poly1, 0:numel(PixInError)-1);
        plot(0:numel(PixInError)-1, fit1, '-ok', 'LineWidth', 1, 'Marker', 'o', 'MarkerSize', 10, 'MarkerEdgeColor', [.2 .2 .2], 'MarkerFaceColor', [.7 .7 .7]);
        hold on;
        plot(repmat(3,1,4),[45,60,70,76], '--k', 'LineWidth', 1);
        ylim = [45 90];
        set(gca, 'YLim', ylim);
        set(gca,'XLim',[0 numel(PixInError)]);
        set(gca,'XTick',0:numel(PixInError)-1);
        set(gca,'XTickLabel', PixInError, 'FontSize', 16)
        ylabel('Classification Rates (%)', 'FontSize', 18);
        xlabel('Number of Pixels in Error', 'FontSize', 18);
        %title('HMAX Sensitivity to Errors', 'FontSize', 16);
        
        %[AX,H1,H2] = plotyy(Refresh, Accuracy, Zeros, NumBitErrors, @loglog);
        
        %print -depsc2 PixelSensitivityAnalysis.eps
        
        set(gcf,'un','n','pos',[0,0,1,1]);figure(gcf)
        
        set(gca, 'FontName', 'Helvetica')
        set(gcf, 'PaperPositionMode', 'auto', 'Units', 'Inches');
        pos = get(gcf, 'Position');
        set(gcf, 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
     
        print -dpng ../figures/PixelSensitivityAnalysis.png
        print -painters -dpdf -r600 ../figures/PixelSensitivityAnalysis.pdf
end