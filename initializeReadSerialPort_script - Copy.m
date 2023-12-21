% serialportlist("available")

% function initializeReadSerialPort_script(...
%     outputFolder,...
%     mouseId,...
%     session,...
%     durationRecording,...
%     serialPort)

clear all, close all, clc,


serialPort = 'COM3';
s=serialport(serialPort,9600);



% instrfind(s)
configureTerminator(s,"CR/LF")
flush(s)
% fopen(s)
% record(s)
% 
% fclose(s)
% clear s

timeRecording = 5;
countData = 1;

data = cell(1,50*timeRecording);
timeStamps = nan(1,50*timeRecording);
tic;
timeElapsed = toc;
disp('Start of Recording')
while timeElapsed < timeRecording

        data{countData} = readline(s);
        timeStamps(countData) = toc;
        timeElapsed = toc;

    countData = countData + 1;
    
end

timeElapsed = toc;
disp(['End of Recording. Elapsed time: ',num2str(timeElapsed),' seconds.'])
% fclose(s)
% fclose(instrfindall);
% delete(instrfindall);

clear s;

timeStamps(isnan(timeStamps)) = [];
dataSplit = data(~cellfun('isempty',data));

valCells = cellfun(@(dataSplit) strsplit(dataSplit, ','), dataSplit, 'UniformOutput', false);
accValues = zeros(length(valCells),3);
for iCells = 1:1:length(valCells)
    accValues(iCells,:) = str2double(valCells{iCells});
end

figure,plot(accValues)





% data.dateFormat = 'date (ddmmyy)';
% data.date = datestr(now,'ddmmyy');
% data.mouseId = mouseId;
% data.session = session;
% data.lengthOfRecordingFormat = 'seconds';
% data.lengthOfRecording = timeElapsed;
% data.accelerometer = valNum;
% data.timeStamps = timeStamps';
% 
% outputName = [num2str(mouseId),'_',data.date,'_',num2str(round(data.lengthOfRecording/60)),'_',num2str(session)];
% save([outputFolder,outputName],'data');


% end
