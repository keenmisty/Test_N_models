clear all
clc
%自01层数据中读变量
[TIMESTAMP RECORD Ta_1_AVG RH_1_AVG Pvapor_1_AVG WS_1_AVG P_1 DR_5_AVG UR_5_AVG DLR_5_AVG ULR_5_AVG...
Rn_5_AVG    DR_5_CM11_AVG   PAR_1_1_AVG PAR_1_2_AVG PAR_1_3_AVG PAR_1_4_AVG PAR_1_5_AVG PAR_7_AVG...
IRCT_5_AVG  Ts_0_1_AVG  Ts_TCAV_1_AVG   Ts_107_1_AVG    Ts_107_2_AVG    Ts_107_3_AVG    Ts_107_4_AVG...
Ts_107_5_AVG    Ts_105T_1_AVG   Ts_105T_2_AVG   Ts_105T_3_AVG   Ts_105T_4_AVG   Ts_105T_5_AVG   G_0_1_AVG...
G_0_2_AVG   Smoist_0_1_AVG  Smoist_0_2_AVG  Smoist_0_3_AVG]...
=textread('G:\30min\01层整理\2010\20120219-0-1CR23XTD_Levels_0_and_1.dat','%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','headerlines',4,'delimiter',',');

Time01=TIMESTAMP;
te=Ta_1_AVG;
rh=RH_1_AVG;
press=P_1;
sw=DR_5_AVG;
lw=DLR_5_AVG;

clear TIMESTAMP RECORD Ta_1_AVG RH_1_AVG Pvapor_1_AVG WS_1_AVG P_1 DR_5_AVG UR_5_AVG DLR_5_AVG ULR_5_AVG...
Rn_5_AVG    DR_5_CM11_AVG   PAR_1_1_AVG PAR_1_2_AVG PAR_1_3_AVG PAR_1_4_AVG PAR_1_5_AVG PAR_7_AVG...
IRCT_5_AVG  Ts_0_1_AVG  Ts_TCAV_1_AVG   Ts_107_1_AVG    Ts_107_2_AVG    Ts_107_3_AVG    Ts_107_4_AVG...
Ts_107_5_AVG    Ts_105T_1_AVG   Ts_105T_2_AVG   Ts_105T_3_AVG   Ts_105T_4_AVG   Ts_105T_5_AVG   G_0_1_AVG   G_0_2_AVG   Smoist_0_1_AVG  Smoist_0_2_AVG  Smoist_0_3_AVG

%自67通量塔中读变量 
[TIMESTAMP	RECORD	Ta_6_AVG	Ta_7_AVG	RH_6_AVG	RH_7_AVG	WS_6_AVG	WS_7_S_WVT	WD_7_D1_WVT	WD_7_SD1_WVT...
    Pvapor_6_AVG	Pvapor_7_AVG	Rain_7_TOT]...
    =textread('G:\30min\01层整理\2010\20120219-6-7CR10XTD_Levels_6_and_7.dat', ...
    '%s%f%f%f%f%f%f%f%f%f%f%f%f','headerlines',4,'delimiter',',');

Time67=TIMESTAMP;
wsp=WS_7_S_WVT;
wdr=WD_7_D1_WVT;
prec=Rain_7_TOT;

clear TIMESTAMP	RECORD	Ta_6_AVG	Ta_7_AVG	RH_6_AVG	RH_7_AVG	WS_6_AVG	WS_7_S_WVT	WD_7_D1_WVT	WD_7_SD1_WVT...
    Pvapor_6_AVG	Pvapor_7_AVG	Rain_7_TOT

%制作标准整年时间序列
Numday=[31 28 31 30 31 30 31 31 30 31 30 31];
dt2=[];
for Year=2010:2010;
    for Month=1:12;
        for Day=1:Numday(Month);
            for Hr=0:23;
                dt_temp1=strcat('"',datestr(datenum(Year,Month,Day,Hr,0,0),31),'"');
                dt_temp2=strcat('"',datestr(datenum(Year,Month,Day,Hr,30,0),31),'"');
                dt2=[dt2;dt_temp1;dt_temp2];
            end
        end
    end
end
clear dt_temp1 dt_temp_2

%读取气象塔数据以便补缺值
QXtower=xlsread('G:\30min\01层整理\鼎湖气象201001-201112\DHS2010old.xlsx','W','B7:G17526');
[ncol,nrow]=size(QXtower);

%构造01、67塔的临时存放位置
temp01=zeros(17520,5);
temp67=zeros(17520,3);

%从气象塔中值补充01层缺值
for i=1:17520;
    index=0;
    for j=7194:23804; %01一层通量塔数据中整年时间段位置       
          if strcmp(Time01{j},dt2(i,:));
             if abs(te(j))>3000;
                temp01(i,1)=QXtower(i,3);
             else
                temp01(i,1)=te(j);
             end
             if abs(rh(j))>3000;
                temp01(i,2)=QXtower(i,4);
             else
                temp01(i,2)=rh(j);
             end
             if abs(press(j))>3000;
                temp01(i,3)=QXtower(i,5);
             else
                temp01(i,3)=press(j);
             end
             if abs(sw(j))>3000;
                temp01(i,4)=-9999;
             else
                temp01(i,4)=sw(j);
             end
             if abs(lw(j))>3000;
                temp01(i,5)=-9999;
             else
                temp01(i,5)=lw(j);
             end
             index=index+1;
             break
          end
    end
          if index<0.9
             temp01(i,1)=QXtower(i,3);
             temp01(i,2)=QXtower(i,4);
             temp01(i,3)=QXtower(i,5);
             temp01(i,4)=-9999;
             temp01(i,5)=-9999;
          end
          disp(i);
end

%从气象塔中值补充67层缺值
for i=1:17520;
    index2=0;
    for k=747:17762;%67层中整年时间段位置
         if strcmp(Time67{j},dt2(i,:));
            if abs(wsp(k))>3000;
                temp67(i,1)=QXtower(i,1);
            else
                temp67(i,1)=wsp(k);
            end
            if abs(wdr(k))>3000;
                temp67(i,2)=QXtower(i,2);
            else
                temp67(i,2)=wdr(k);
            end
            if abs(prec(k))>3000;
                temp67(i,3)=QXtower(i,6);
            else
                temp67(i,3)=prec(k);
            end
            index2=index2+1;
            break
         end
    end
    if index2<0.9
             temp67(i,1)=QXtower(i,1);
             temp67(i,2)=QXtower(i,2);
             temp67(i,3)=QXtower(i,6);
    end
    disp(i);
end
clear QXtower index i j k


temp=[temp67(:,2),temp67(:,1),temp01(:,1),temp01(:,2),temp01(:,3),temp01(:,4),temp01(:,5),temp67(:,3)];
clear temp01 temp67

%记录缺失
[Ilost,Jlost]=find(temp==-9999);
Ilost=unique(Ilost);

%对于气象塔和通量塔中均缺的值，用当月该时刻均值替换
temp(find(temp==-9999))=NaN;

nvar=8;
Year=2010;
if Year==2010
       Numday=[31 28 31 30 31 30 31 31 30 31 30 31];
end
sum=0;
count=zeros(12,1);
for k=1:12;
    sum=sum+Numday(k);
    count(k)=sum-Numday(k)+1;
end
cc=zeros(48,nvar);
dd=zeros(12,48,nvar);
for k=1:12; %一年12个月
    for i=1:48  %一天48个数据
        bb=zeros(Numday(k),nvar);
        for j=count(k):count(k)+Numday(k)-1;  %某个月是从哪天到哪天
            bb(j-count(k)+1,:)=temp(48*(j-1)+i,:);
        end
        cc(i,:)=nanmean(bb,1);
        clear bb
    end
    dd(k,1:48,1:nvar)=cc;
end
clear i j k
for k=1:12;
    for j=count(k):count(k)+Numday(k)-1;
        ee((j-1)*48+1:(j-1)*48+48,:)=squeeze(dd(k,1:48,:));
    end
end
idx=find(isnan(temp));
temp(idx)=ee(idx);

%写成Noah-1D输入格式
fid = fopen('G:\30min\01层整理\2010\2010tltzl.dat','w');
fprintf(fid,'"date/time","windspeed","wind dir","temperature","humidity","pressure","shortwave","longwave","precipitation"')
fprintf(fid,'\n');
strBlank=' ';
for i=1:17520;
    aa=dt2(i,:);
            fprintf(fid,'%s',aa(2:5));
            fprintf(fid,'%s',strBlank);
            fprintf(fid,'%s',aa(7:8));
            fprintf(fid,'%s',strBlank);
            fprintf(fid,'%s',aa(10:11));
            fprintf(fid,'%s',strBlank);
            fprintf(fid,'%s',aa(13:14));
            fprintf(fid,'%s',strBlank);
            fprintf(fid,'%s',aa(16:17));
            fprintf(fid,'%17.10f',temp(i,1));
            fprintf(fid,'%17.10f',temp(i,2));
            fprintf(fid,'%17.10f',temp(i,3)+273.15);
            fprintf(fid,'%17.10f',temp(i,4));
            fprintf(fid,'%17.10f',temp(i,5));
            fprintf(fid,'%17.10f',temp(i,6));
            fprintf(fid,'%17.10f',temp(i,7));
            fprintf(fid,'%17.10f',temp(i,8)./3600);
            fprintf(fid,'\n');
            disp(i);
end
fclose(fid);
