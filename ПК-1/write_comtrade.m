Anal_chan = 10;
Digit_chan = 10;
Total_chan = Anal_chan + Digit_chan;
Title = 'MatlabSimulink';
Version = '1999';
An_max = 65535;
An_min = 0;
%value_number = 10000;

frequency = 50;
Anal_names = {'Ia', 'Ib', 'Ic', 'Ua', 'Ub', 'Uc', 'Uni', 'Unk','Temp1','Temp2'};
Digit_names = {'Пуск 1 ст. АОПО' 'Сраб. 1 ст. АОПО' 'Пуск 2 ст. АОПО' 'Сраб. 2 ст. АОПО' 'Пуск 3 ст. АОПО' 'Сраб. 3 ст. АОПО' 'Сраб. БНН' 'Сраб. КИТЦ' 'Неиспр. датч. темп.' 'Смена гр. уставок'};
unites = {'A','A','A','V','V','V','V','V','degr','degr'};
for i = 1:Anal_chan
    maxes(i) = max(cmtrd_data.Data(:,i));
    mines(i) = min(cmtrd_data.Data(:,i));
    if maxes(i) == mines(i)
        a(i) = 1e-8;
    else
        a(i) = (maxes(i)-mines(i))/(An_max-An_min);
    end
    if a(i) == 0
        b(i) = maxes(i);
    else
        b(i) = (An_max*mines(i)-An_min*maxes(i))/(An_max-An_min);
    end
end
clear maxes mines

for i = 1:value_number
    for j = 1:Anal_chan
        if a(j) == 0
            Dat(i,j) = 0;
        else
            Dat(i,j) = (cmtrd_data.Data(i,j) - b(j))/a(j);
        end
    end
    counter(i) = i;
    timing(i) = i*1000;
end

for i = 1:value_number
    for j = (Anal_chan + 1):Total_chan
        Dat(i,j) = cmtrd_data.Data(i,j);
    end
end
[file,path] = uiputfile('*.cfg');
%save comtrade.cfg
fileID_cfg = fopen(strcat(path,file),'wt'); %wt - text mode, чтоб давал возможность переносить строку
fprintf(fileID_cfg,'%s,0,%s\n',Title,Version);
fprintf(fileID_cfg,'%i,%iA,%iD\n',Total_chan,Anal_chan,Digit_chan);

for i=1:3
    fprintf(fileID_cfg,'%i,%s,,,%s,',i,string(Anal_names(i)),string(unites(i)));
    fprintf(fileID_cfg,'%d,%d,0,%i,%i,100.0,5.0,P\n',a(i),b(i),An_min,An_max);
end

for i=4:8
    fprintf(fileID_cfg,'%i,%s,,,%s,',i,string(Anal_names(i)),string(unites(i)));
    fprintf(fileID_cfg,'%d,%d,0,%i,%i,330000.0,100.0,P\n',a(i),b(i),An_min,An_max);
end

for i=9:10
    fprintf(fileID_cfg,'%i,%s,,,%s,',i,string(Anal_names(i)),string(unites(i)));
    fprintf(fileID_cfg,'%d,%d,0,%i,%i,1.0,1.0,P\n',a(i),b(i),An_min,An_max);
end

for i = 1:Digit_chan
    fprintf(fileID_cfg,'%i,%s,0\n',i,string(Digit_names(i)));
end

fprintf(fileID_cfg,'%i\n',frequency);
fprintf(fileID_cfg,'1\n');
fprintf(fileID_cfg,'%i,%i\n',length(cmtrd_data.Data(:,1)),length(cmtrd_data.Data(:,1)));

current_date = datetime('now','Format','dd/MM/yyyy,HH:mm:ss');
add_date = current_date + seconds(0.001*value_number);
time_mcs = clock;
fprintf(fileID_cfg,'%s.%s\n',string(current_date),string(1000000*mod(time_mcs(6),1)));
fprintf(fileID_cfg,'%s.%s\n',string(add_date),string(1000000*mod(time_mcs(6),1)));
fprintf(fileID_cfg,'ASCII\n1');

fclose(fileID_cfg);

clear Title Version Anal_chan Digit_chan An_min An_max frequency Anal_names Digit_names a b unites current_date add_date fileID_cfg time_mcs

fileID_dat = fopen(strcat(path,file(1:(length(file)-3)),'dat'),'wt');
for i = 1:value_number
    fprintf(fileID_dat,'%i,%i',counter(i),timing(i));
    for j = 1:Total_chan
        fprintf(fileID_dat,',%d',round(Dat(i,j)));
    end
    fprintf(fileID_dat,'\n');
end

fclose(fileID_dat);

clear counter Dat fileID_dat i j timing ans value_number Total_chan