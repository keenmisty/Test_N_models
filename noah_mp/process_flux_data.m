clear
[TMSTAMP,RECNBR,Fc_wpl,LE_wpl,Hs,tau,u_star,cov_Uz_Uz_1,cov_Uz_Ux_1,cov_Uz_Uy_1,cov_Uz_co2_1,cov_Uz_h2o_1,cov_Uz_Ts_1,...
 cov_Ux_Ux_1,cov_Ux_Uy_1,cov_Ux_co2_1,cov_Ux_h2o_1,cov_Ux_Ts_1,cov_Uy_Uy_1,cov_Uy_co2_1,cov_Uy_h2o_1,cov_Uy_Ts_1, ...
 cov_co2_co2_1,cov_h2o_h2o_1,cov_Ts_Ts_1,Ux_Avg_1,Uy_Avg_1,Uz_Avg_1,co2_Avg_1,h2o_Avg_1,Ts_Avg_1,rho_a_Avg,press_Avg_1,...
 panel_temp_Avg,wnd_dir_compass_1,wnd_dir_csat3_1,wnd_spd_1,rslt_wnd_spd_1,batt_volt_Avg,std_wnd_dir_1,n_Tot, ...
 csat_warning_Tot_1,irga_warning_Tot,del_T_f_Tot_1,track_f_Tot_1,amp_h_f_Tot_1,amp_l_f_Tot_1,chopper_f_Tot_1,detector_f_Tot_1,...
 pll_f_Tot_1,sync_f_Tot_1,agc_Avg_1,Fc_irga,LE_irga,co2_wpl_LE,co2_wpl_H,h2o_wpl_LE,h2o_wpl_H]= ...
textread('E:\Data\deposition\20090920王雪梅老师\200702-20080429通量塔常规数据与半小时通量数据\5-CR5000flux-modify.dat',...
'%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f',...
'headerlines',2,'delimiter',',');

fid = fopen('E:\Data\deposition\20090920王雪梅老师\200702-20080429通量塔常规数据与半小时通量数据\5-CR5000flux-sort.dat','w');
fprintf(fid,'"TOACI1","5-CR5000","flux"'); 
fprintf(fid,'\n');
fprintf(fid,'"TMSTAMP","RECNBR","Fc_wpl[mg/(m^2s)] LE_wpl[w/m^2] Hs[w/m^2] tau[Kg/(ms^2)]"')
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
                            fprintf(fid,'%15.8f',Fc_wpl(n));
                            fprintf(fid,'%15.8f',LE_wpl(n));
                            fprintf(fid,'%15.8f',Hs(n));
                            fprintf(fid,'%15.8f',tau(n));
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
                       fprintf(fid,'\n');
                    end
                end
            end
        end
    end
end
fclose(fid)
