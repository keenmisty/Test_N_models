clear

[TMSTAMP,RECNBR,Ta_6_AVG,Ta_7_AVG,RH_6_AVG,RH_7_AVG,WS_6_AVG,WS_7_S_WVT,WD_7_D1_WVT,WD_7_SD1_WVT,Pvapor_6_AVG,Pvapor_7_AVG, ...
    Rain_7_TOT]=textread('E:\Data\deposition\20090920王雪梅老师\200702-20080429通量塔常规数据与半小时通量数据\67-CR10XTDLevels_6_and_7-modify.dat', ...
    '%s%f%f%f%f%f%f%f%f%f%f%f%f','headerlines',2,'delimiter',',');

fid = fopen('E:\Data\deposition\20090920王雪梅老师\200702-20080429通量塔常规数据与半小时通量数据\67-CR10XTDLevels_6_and_7-sort.dat','w');
fprintf(fid,'"TOACI1","67-CR10XTD","Levels_6_and_7"'); 
fprintf(fid,'\n');
fprintf(fid,'"TMSTAMP","RECNBR","Ta_6_AVG","Ta_7_AVG","RH_6_AVG","RH_7_AVG","WS_6_AVG","WS_7_S_WVT","WD_7_D1_WVT","WD_7_SD1_WVT","Pvapor_6_AVG","Pvapor_7_AVG","Rain_7_TOT"')
fprintf(fid,'\n');

for Year=2007:2008        
    if Year==2007
       Numday=[31 28 31 30 31 30 31 31 30 31 30 31];
    end
    if Year==2008
       Numday=[31 29 31 30 31 30 31 31 30 31 30 31];
    end 

    for Month=1:12
        for Day=1:Numday(Month)
            for Hr=0:23
                for Min=0:30:30
                    Time=time_str(Year,Month,Day,Hr,Min,0);
                    Time=['"',Time,'"']
                    index=0;
                    for n=1:length(TMSTAMP)                      
                        if strcmp(Time,TMSTAMP(n))
                            fprintf(fid,Time);
                            fprintf(fid,'%8.0f',RECNBR(n));
                            fprintf(fid,'%15.8f',Ta_6_AVG(n));
                            fprintf(fid,'%15.8f',Ta_7_AVG(n));
                            fprintf(fid,'%15.8f',RH_6_AVG(n));
                            fprintf(fid,'%15.8f',RH_7_AVG(n));
                            fprintf(fid,'%15.8f',WS_6_AVG(n));
                            fprintf(fid,'%15.8f',WS_7_S_WVT(n));
                            fprintf(fid,'%15.8f',WD_7_D1_WVT(n));
                            fprintf(fid,'%15.8f',WD_7_SD1_WVT(n));
                            fprintf(fid,'%15.8f',Pvapor_6_AVG(n));
                            fprintf(fid,'%15.8f',Pvapor_7_AVG(n));
                            fprintf(fid,'%15.8f',Rain_7_TOT(n));
                            fprintf(fid,'\n');
                            index=index+1;
                            break
                        end
                    end
                    if index<0.9
                       fprintf(fid,Time);
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,' NaN ');
                       fprintf(fid,'\n');
                    end
                end
            end
        end
    end
end
fclose(fid)