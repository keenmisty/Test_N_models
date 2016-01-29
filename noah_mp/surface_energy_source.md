# To find out varibles affect on LH&SH
---

## LH:Latent Heat Flux

LH=XLV\*QFX

```fortran
"XLV", "latent heat of vaporization for water (J/kg)" 
REAL    , PARAMETER :: XLV          = 2.5E6
```
QFX 计算：

QFX = FCEV + FGEV + FCTR

* 各变量内容：

```fortran
"FCEV",    "Canopy evaporative heat to atmosphere",             "W m{-2}"
"FGEV",    "Ground evaporative heat to atmosphere",             "W m{-2}"
"FCTR",    "Transpiration heat to atmosphere",                  "W m{-2}"
```
---

1. FCEV 计算：

```fortran
IF (VEG) THEN
FCEV = EVC
END

REAL, INTENT(OUT) :: EVC    !evaporation heat flux (w/m2)  [+= to atm] 

! evaluate surface fluxes with current temperature and solve for dts

EVC = FVEG*RHOAIR*CPAIR*CEW * (ESTV-EAH) / GAMMA
EVC = MIN(CANLIQ*LATHEA/DT,EVC)
EVC = EVC + FVEG*CEV*DESTV*DTV
```

* *直接影响`EVC`计算的变量内容

```fortran
INTENT(IN) :: FVEG   !green vegetation fraction [0.0-1.0]
REAL ::       RHOAIR !density air (kg/m3)
PARAMETER ::  CPAIR = 1004.64 !heat capacity dry air at const pres (j/kg/k)
REAL ::       CEW    !evaporation conductance, leaf to canopy air (m/s)
REAL ::       ESTV   !saturation vapor pressure at tv (pa)
REAL       :: EAH    !canopy air vapor pressure (pa)
REAL       :: CANLIQ !intercepted liquid water (mm)
REAL       :: LATHEA !latent heat vap./sublimation (j/kg)
REAL ::       CEV    !coefficients for ev as function of esat[ts]
REAL ::       DESTV  !d(es)/dt at ts (pa/k)
REAL ::       DTV    !change in tv, last iteration (k)
```
* 影响以上变量的内容：

FVEG ~ LAI 直接与OPT**\_**DVEG有关

CEW =FWET×VAIE/RB 与Canopy Water,LAI,RB直接相关

```fortran
! wetted fraction of canopy
REAL :: FWET    !wetted or snowed fraction of the canopy (-)
IF(CANICE.GT.0.) THEN
  FWET = MAX(0.,CANICE) / MAX(MAXSNO,1.E-06)
ELSE
  FWET = MAX(0.,CANLIQ) / MAX(MAXLIQ,1.E-06)
ENDIF
FWET = MIN(FWET, 1.) ** 0.667
!-----------------------------
REAL :: VAIE         !total leaf area index + stem area index,effective
VAIE    = MIN(6.,VAI    / FVEG)
VAI = ELAI + ESAI
ELAI =  LAI*(1.-FB)  ! FB:buried by snow 
ESAI =  SAI*(1.-FB)
!-----------------------------
REAL :: RB         !bulk leaf boundary layer resistance (s/m)
!Subroutine RAGRB 计算的
! CWP    !canopy wind extinction parameter !canopy wind absorption coeffcient
! HCAN   !canopy height (m) [note: hcan >= z0mg]
! UC     !wind speed at top of canopy (m/s)
! FHG    !stability correction
	CWPC = (CWP * VAI * HCAN * FHG)**0.5
	TMPRB  = CWPC*50. / (1. - EXP(-CWPC/2.))
	RB     = TMPRB * SQRT(DLEAF(VEGTYP)/UC)
```
---

2. FGEV 计算

```fortran
IF (VEG) THEN
FGEV  = FVEG * EVG       + (1.0 - FVEG) * EVB
END
REAL,INTENT(OUT) :: EVG    !evaporation heat flux at veg (w/m2)  [+= to atm]
REAL,INTENT(OUT) :: EVB    !evaporation heat flux at bare(w/m2)  [+= to atm]

EVG = CEV * (ESTG*RHSUR - EAH         )
EVG = EVG + CEV*DESTG*DTG
     IF(OPT_STC == 1) THEN
     IF (SNOWH > 0.05 .AND. TG > TFRZ) THEN
     EVG = CEV * (ESTG*RHSUR - EAH)
     END IF
     END IF

EVB = CEV * (ESTG*RHSUR - EAIR        )
EVB = EVB + CEV*DESTG*DTG
```

* 直接影响`EVG`计算的变量内容

```fortran
REAL ::       CEV    !coefficients for ev as function of esat[ts]
REAL ::       ESTG   !saturation vapor pressure at tg (pa)
REAL      ::  RHSUR  !raltive humidity in surface soil/snow air space (-)
REAL       :: EAH    !canopy air vapor pressure (pa)
REAL ::       DESTG  !d(es)/dt at tg (pa/k)
REAL ::       DTG    !change in tg, last iteration (k)
```

* 直接影响`EVB`计算的变量内容

```fortran
REAL        :: EAIR   !vapor pressure air at zlvl (pa)
```
---

3. FCTR 计算

```fortran
FCTR=TR
TR  = FVEG*RHOAIR*CPAIR*CTW * (ESTV-EAH) / GAMMA
TR  = TR  + FVEG*CTR*DESTV*DTV
CTR  = (1.-BEA)*CTW*RHOAIR*CPAIR/GAMMA
CTW  = (1.-FWET)*(LAISUNE/(RB+RSSUN) + LAISHAE/(RB+RSSHA))
```


























