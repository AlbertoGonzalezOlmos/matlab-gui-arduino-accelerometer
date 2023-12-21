% read accelerometer data


    

filesDay = dir('./data/day_*');

test = 0;
if test, filesDay = dir('./data/test'); end

for iDay = 2 %1:1:length(filesDay)
    pathDay = [filesDay(iDay).folder,'/',filesDay(iDay).name];
    filesMouse = dir([pathDay,'/*.csv']);
    
    

    for iMouse = 1 %:1:length(filesMouse)
        pathMouse = [filesMouse(iMouse).folder,'/',filesMouse(iMouse).name];

        dataMouse = readmatrix(pathMouse);
        [idxNanCol,idxNanRow] = find(isnan(dataMouse(:,1:3)));
        dataMouse(idxNanCol,:) = [];
        data = dataMouse - mean(dataMouse,1);
        figure,hold on,
        plot(data(:,1)),
        plot(data(:,2)),
        plot(data(:,3)),
        hold off,
        legend('X','Y','Z')
        title('accelerometer data')

    end

end


