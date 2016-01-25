clear
[TMSTAMP,RECNBR,Ta_1_AVG,RH_1_AVG,Pvapor_1_AVG,WS_1_AVG,P_1,DR_7_AVG,UR_7_AVG,DLR_7_AVG,ULR_7_AVG,Rn_7_AVG,DR_7_CM11_AVG,...
    PAR_1_1_AVG,PAR_1_2_AVG,PAR_2_1_AVG,PAR_2_2_AVG,PAR_4_1_AVG,PAR_7_AVG,IRCT_4_AVG,Ts_0_1_AVG,TCAV_1_AVG,Ts_107_20cm_AVG,...
    Ts_107_40cm_AVG,Ts_107_60cm_AVG,Ts_107_80cm_AVG,Ts_107_100cm_AVG,Ts_105T_5cm_AVG,Ts_105T_10cm_AVG,Ts_105T_15cm_AVG,...
    Ts_105T_20cm_AVG,Ts_105T_40cm_AVG,G_0_1_AVG,G_0_2_AVG,Smoist_0_5cm_AVG,Smoist_0_20cm_AVG,Smoist_0_40cm_AVG] ...
    =textread('G:\30min\20041130-20060302\0-1-CR23XTDLevels_0_and_1.dat', ...
    '%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','headerlines',2,'delimiter',',');


fid = fopen('G:\30min\level01\0-1-CR23XTDLevels_0_and_1-sort2005.dat','w');
fprintf(fid,'"TOACI1","0-1-CR23XTD","Levels_0_and_1"'); 
fprintf(fid,'\n');
fprintf(fid,'"TMSTAMP","RECNBR","Ta_1_AVG","RH_1_AVG","Pvapor_1_AVG","WS_1_AVG","P_1","DR_7_AVG","UR_7_AVG","DLR_7_AVG","ULR_7_AVG","Rn_7_AVG","DR_7_CM11_AVG","PAR_1_1_AVG","PAR_1_2_AVG","PAR_2_1_AVG","PAR_2_2_AVG","PAR_4_1_AVG","PAR_7_AVG","IRCT_4_AVG","Ts_0_1_AVG","TCAV_1_AVG","Ts_107_20cm_AVG","Ts_107_40cm_AVG","Ts_107_60cm_AVG","Ts_107_80cm_AVG","Ts_107_100cm_AVG","Ts_105T_5cm_AVG","Ts_105T_10cm_AVG","Ts_105T_15cm_AVG","Ts_105T_20cm_AVG","Ts_105T_40cm_AVG","G_0_1_AVG","G_0_2_AVG","Smoist_0_5cm_AVG","Smoist_0_20cm_AVG","Smoist_0_40cm_AVG"')
fprintf(fid,'\n');

for Year=2005:2005        
    if Year==2005
       Numday=[31 28 31 30 31 30 31 31 30 31 30 31];
    end
    if Year==2007
       Numday=[31 29 31 30 31 30 31 31 30 31 30 31];
    end 

    for Month=1:12
        for Day=1:Numday(Month)
            for Hr=0:23
                for Min=0:30:30
                    T = time_str(Year,Month,Day,Hr,Min,0);
                    Time = ['"',T,'"']
                    index=0;
                    for n=1:length(TMSTAMP)                      
                        if strcmp(Time,TMSTAMP(n))
                            fprintf(fid,Time);
                            fprintf(fid,'%8.0f',RECNBR(n));
                            fprintf(fid,'%15.8f',Ta_1_AVG(n));
                            fprintf(fid,'%15.8f',RH_1_AVG(n));
                            fprintf(fid,'%15.8f',Pvapor_1_AVG(n));
                            fprintf(fid,'%15.8f',WS_1_AVG(n));
                            fprintf(fid,'%15.8f',P_1(n));
                            fprintf(fid,'%15.8f',DR_7_AVG(n));
                            fprintf(fid,'%15.8f',UR_7_AVG(n));
                            fprintf(fid,'%15.8f',DLR_7_AVG(n));
                            fprintf(fid,'%15.8f',ULR_7_AVG(n));
                            fprintf(fid,'%15.8f',TCAV_1_AVG(n));
                            fprintf(fid,'%15.8f',G_0_1_AVG(n));
                            fprintf(fid,'%15.8f',G_0_2_AVG(n));
                            fprintf(fid,'%15.8f',Smoist_0_5cm_AVG(n));
                            fprintf(fid,'%15.8f',Smoist_0_20cm_AVG(n));
                            fprintf(fid,'%15.8f',Smoist_0_40cm_AVG(n));
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