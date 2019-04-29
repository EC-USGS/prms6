!***********************************************************************
! Computes daily, monthly, yearly, and total flow summaries of volumes
! and flows for each HRU
!***********************************************************************
      MODULE PRMS_HRUSUM
      IMPLICIT NONE
!   Local Variables
      INTEGER, SAVE :: Hrutot_flg
      CHARACTER(LEN=12), SAVE:: MODNAME
!   Declared Variables
      REAL, SAVE, ALLOCATABLE :: Hru_ppt_mo(:), Hru_net_ppt_mo(:)
      REAL, SAVE, ALLOCATABLE :: Hru_potet_mo(:), Hru_actet_mo(:)
      REAL, SAVE, ALLOCATABLE :: Hru_snowmelt_mo(:), Hru_sroff_mo(:)
!   Declared Private Variables
      REAL, SAVE, ALLOCATABLE :: Hru_ppt_yr(:), Hru_net_ppt_yr(:)
      REAL, SAVE, ALLOCATABLE :: Hru_potet_yr(:), Hru_actet_yr(:)
      REAL, SAVE, ALLOCATABLE :: Hru_snowmelt_yr(:), Hru_sroff_yr(:)
      REAL, SAVE, ALLOCATABLE :: Soil_to_gw_mo(:), Soil_to_ssr_mo(:)
      REAL, SAVE, ALLOCATABLE :: Soil_to_gw_yr(:), Soil_to_ssr_yr(:)
      REAL, SAVE, ALLOCATABLE :: Stor_last(:)
!   Declared Parameters
      INTEGER, SAVE :: Pmo, Moyrsum
      END MODULE PRMS_HRUSUM

!***********************************************************************
!     Main hru_sum routine
!***********************************************************************
      INTEGER FUNCTION hru_sum_prms()
      USE PRMS_MODULE, ONLY: Process
      IMPLICIT NONE
! Functions
      INTEGER, EXTERNAL :: hsumbdecl, hsumbinit, hsumbrun
!***********************************************************************
      hru_sum_prms = 0

      IF ( Process(:3)=='run' ) THEN
        hru_sum_prms = hsumbrun()
      ELSEIF ( Process(:4)=='decl' ) THEN
        hru_sum_prms = hsumbdecl()
      ELSEIF ( Process(:4)=='init' ) THEN
        hru_sum_prms = hsumbinit()
      ENDIF

      END FUNCTION hru_sum_prms

!***********************************************************************
!     hsumbdecl - set up basin summary parameters
!   Declared Parameters
!     pmo, moyrsum
!***********************************************************************
      INTEGER FUNCTION hsumbdecl()
      USE PRMS_HRUSUM
      USE PRMS_MODULE, ONLY: Nhru
      IMPLICIT NONE
! Functions
      INTRINSIC INDEX
      INTEGER, EXTERNAL :: declmodule, declparam, declvar, declpri
      EXTERNAL read_error, print_module
! Local Variables
      CHARACTER(LEN=80), SAVE :: Version_hru_sum
!***********************************************************************
      hsumbdecl = 1

      Version_hru_sum = '$Id: hru_sum_prms.f90 5532 2013-03-25 21:49:54Z rsregan $'
      CALL print_module(Version_hru_sum, 'HRU Summary               ', 90)
      MODNAME = 'hru_sum_prms'

      ALLOCATE ( Hru_ppt_yr(Nhru), Hru_net_ppt_yr(Nhru) )
      IF ( declpri('hsumb_hru_ppt_yr', Nhru, 'real', Hru_ppt_yr)/=0 ) RETURN
      IF ( declpri('hsumb_hru_net_ppt_yr', Nhru, 'real', Hru_net_ppt_yr)/=0 ) RETURN

      ALLOCATE ( Hru_potet_yr(Nhru), Hru_actet_yr(Nhru) )
      IF ( declpri('hsumb_hru_potet_yr', Nhru, 'real', Hru_potet_yr)/=0 ) RETURN
      IF ( declpri('hsumb_hru_actet_yr', Nhru, 'real', Hru_actet_yr)/=0 ) RETURN

      ALLOCATE ( Hru_snowmelt_yr(Nhru), Hru_sroff_yr(Nhru) )
      IF ( declpri('hsumb_hru_snowmelt_yr', Nhru, 'real', Hru_snowmelt_yr)/=0 ) RETURN
      IF ( declpri('hsumb_hru_sroff_yr', Nhru, 'real', Hru_sroff_yr)/=0 ) RETURN

      ALLOCATE ( Soil_to_gw_mo(Nhru), Soil_to_gw_yr(Nhru) )
      IF ( declpri('hsumb_soil_to_gw_mo', Nhru, 'real', Soil_to_gw_mo)/=0 ) RETURN
      IF ( declpri('hsumb_soil_to_gw_yr', Nhru, 'real', Soil_to_gw_yr)/=0 ) RETURN

      ALLOCATE ( Soil_to_ssr_mo(Nhru), Soil_to_ssr_yr(Nhru) )
      IF ( declpri('hsumb_soil_to_ssr_mo', Nhru, 'real', Soil_to_ssr_mo)/=0 ) RETURN
      IF ( declpri('hsumb_soil_to_ssr_yr', Nhru, 'real', Soil_to_ssr_yr)/=0 ) RETURN

      ALLOCATE ( Stor_last(Nhru) )
      IF ( declpri('hsumb_stor_last', Nhru, 'real', Stor_last)/=0 ) RETURN

! Declare Parameters
      IF ( declparam(MODNAME, 'pmo', 'one', 'integer', &
     &     '0', '0', '12', &
     &     'Month to print HRU summary', 'Month to print HRU summary', &
     &     'none')/=0 ) CALL read_error(1, 'pmo')

      IF ( declparam(MODNAME, 'moyrsum', 'one', 'integer', &
     &     '0', '0', '1', &
     &     'Switch for HRU monthly and yearly summary', &
     &     'Switch for HRU monthly and yearly summary (0=off, 1=on)', &
     &     'none')/=0 ) CALL read_error(1, 'moyrsum')

! Declare Variables
      ALLOCATE ( Hru_ppt_mo(Nhru) )
      IF ( declvar(MODNAME, 'hru_ppt_mo', 'nhru', Nhru, 'real', &
     &     'Monthly precipitation distributed to each HRU', &
     &     'inches', Hru_ppt_mo)/=0 ) CALL read_error(3, 'hru_ppt_mo')

      ALLOCATE ( Hru_net_ppt_mo(Nhru) )
      IF ( declvar(MODNAME, 'hru_net_ppt_mo', 'nhru', Nhru, 'real', &
     &     'Monthly net precipitation on each HRU', &
     &     'inches', Hru_net_ppt_mo)/=0 ) CALL read_error(3, 'hru_net_ppt_mo')

      ALLOCATE ( Hru_potet_mo(Nhru) )
      IF ( declvar(MODNAME, 'hru_potet_mo', 'nhru', Nhru, 'real', &
     &     'Monthly potential ET for each HRU', &
     &     'inches', Hru_potet_mo)/=0 ) CALL read_error(3, 'hru_potet_mo')

      ALLOCATE ( Hru_actet_mo(Nhru) )
      IF ( declvar(MODNAME, 'hru_actet_mo', 'nhru', Nhru, 'real', &
     &     'Monthly actual ET from each HRU', &
     &     'inches', Hru_actet_mo)/=0 ) CALL read_error(3, 'hru_actet_mo')

      ALLOCATE ( Hru_snowmelt_mo(Nhru) )
      IF ( declvar(MODNAME, 'hru_snowmelt_mo', 'nhru', Nhru, 'real', &
     &     'Monthly snowmelt from each HRU', &
     &     'inches', Hru_snowmelt_mo)/=0 ) CALL read_error(3, 'hru_snowmelt_mo')

      ALLOCATE ( Hru_sroff_mo(Nhru) )
      IF ( declvar(MODNAME, 'hru_sroff_mo', 'nhru', Nhru, 'real', &
     &     'Monthly surface runoff from each HRU', &
     &     'inches', Hru_sroff_mo)/=0 ) CALL read_error(3, 'hru_sroff_mo')

      hsumbdecl = 0
      END FUNCTION hsumbdecl

!***********************************************************************
!     hsumbinit - Initialize basinsum module - get parameter values
!                set to zero
!***********************************************************************
      INTEGER FUNCTION hsumbinit()
      USE PRMS_HRUSUM
      USE PRMS_MODULE, ONLY: Nhru, Nssr, Ngw
      USE PRMS_BASIN, ONLY: Timestep
      IMPLICIT NONE
      INTEGER, EXTERNAL :: getparam
      EXTERNAL read_error
      INTEGER :: i
!***********************************************************************
      hsumbinit = 0

      IF ( getparam(MODNAME, 'pmo', 1, 'integer', Pmo)/=0 ) CALL read_error(2, 'pmo')
      IF ( getparam(MODNAME, 'moyrsum', 1, 'integer', Moyrsum)/=0 ) CALL read_error(2, 'moyrsum')

      IF ( Timestep==0 ) THEN
        DO i = 1, Nhru
          Hru_ppt_mo(i) = 0.0
          Hru_net_ppt_mo(i) = 0.0
          Hru_potet_mo(i) = 0.0
          Hru_actet_mo(i) = 0.0
          Hru_snowmelt_mo(i) = 0.0
          Hru_sroff_mo(i) = 0.0
          Hru_ppt_yr(i) = 0.0
          Hru_net_ppt_yr(i) = 0.0
          Hru_potet_yr(i) = 0.0
          Hru_actet_yr(i) = 0.0
          Hru_snowmelt_yr(i) = 0.0
          Hru_sroff_yr(i) = 0.0
          Soil_to_gw_mo(i) = 0.0
          Soil_to_gw_yr(i) = 0.0
          Soil_to_ssr_mo(i) = 0.0
          Soil_to_ssr_yr(i) = 0.0
          Stor_last(i) = 0.0
        ENDDO
      ENDIF

      Hrutot_flg = 0
      IF ( Nhru==Nssr .AND. Nhru==Ngw ) Hrutot_flg = 1

      END FUNCTION hsumbinit

!***********************************************************************
!     hsumbrun - Computes summary values
!***********************************************************************
      INTEGER FUNCTION hsumbrun()
      USE PRMS_HRUSUM
      USE PRMS_BASIN, ONLY: Active_hrus, Hru_route_order, Hru_type, Hru_frac_perv
      USE PRMS_CLIMATEVARS, ONLY: Tmaxf, Tminf, Hru_ppt, Potet, Swrad
      USE PRMS_FLOWVARS, ONLY: Soil_to_gw, Soil_to_ssr, &
     &    Hru_actet, Infil, Sroff, Soil_moist, Pkwater_equiv
      USE PRMS_OBS, ONLY: Jday, Nowyear, Nowmonth, Nowday, Yrdays, Modays, Julwater
      USE PRMS_INTCP, ONLY: Hru_intcpstor, Net_ppt, Hru_intcpevap
      USE PRMS_SNOW, ONLY: Tcal, Pk_den, Pk_temp, Snowmelt, Albedo
      USE PRMS_SRUNOFF, ONLY: Hru_impervstor
      IMPLICIT NONE
! Functions
      INTRINSIC FLOAT
      EXTERNAL write_outfile
! Local Variables
      CHARACTER(LEN=150) :: buffer
      INTEGER :: i, j, ii
      REAL :: hruprt(24), ri, rmo, ryr, stor, wbal
!***********************************************************************
      hsumbrun = 0

      IF ( Moyrsum==1 ) THEN
        IF ( Nowday==1 ) THEN
          DO j = 1, Active_hrus
            i = Hru_route_order(j)
            Hru_ppt_mo(i) = 0.0
            Hru_net_ppt_mo(i) = 0.0
            Hru_potet_mo(i) = 0.0
            Hru_actet_mo(i) = 0.0
            Hru_snowmelt_mo(i) = 0.0
            Hru_sroff_mo(i) = 0.0
            Soil_to_gw_mo(i) = 0.0
            Soil_to_ssr_mo(i) = 0.0
          ENDDO
        ENDIF
        IF ( Julwater==1 ) THEN
          DO j = 1, Active_hrus
            i = Hru_route_order(j)
            Hru_ppt_yr(i) = 0.0
            Hru_net_ppt_yr(i) = 0.0
            Hru_potet_yr(i) = 0.0
            Hru_actet_yr(i) = 0.0
            Hru_snowmelt_yr(i) = 0.0
            Hru_sroff_yr(i) = 0.0
            Soil_to_gw_yr(i) = 0.0
            Soil_to_ssr_yr(i) = 0.0
          ENDDO
        ENDIF
      ENDIF

      IF ( Nowmonth==Pmo ) THEN
        hruprt(2) = FLOAT(Nowday)
        CALL write_outfile('   hru   day   swr   tmx   tmn  oppt  nppt   int '// &
     &                     ' inls   pet   aet  smav pweqv   den  pact   alb  '// &
     &                     'tcal  smlt   infl    sro   s2gw   s2ss  imst   wbal')
        DO ii = 1, Active_hrus
          i = Hru_route_order(ii)
          IF ( Hru_type(i)==0 ) CYCLE
          hruprt(1) = i
          hruprt(3) = Swrad(i)
          hruprt(4) = Tmaxf(i)
          hruprt(5) = Tminf(i)
          hruprt(6) = Hru_ppt(i)
          hruprt(7) = Net_ppt(i)
          hruprt(8) = Hru_intcpstor(i)
          hruprt(9) = Hru_intcpevap(i)
          hruprt(10) = Potet(i)
          hruprt(11) = Hru_actet(i)
          hruprt(12) = Soil_moist(i)*Hru_frac_perv(i)
          hruprt(13) = Pkwater_equiv(i)
          hruprt(14) = Pk_den(i)
          hruprt(15) = Pk_temp(i)
          hruprt(16) = Albedo(i)
          hruprt(17) = Tcal(i)
          hruprt(18) = Snowmelt(i)
          hruprt(19) = Infil(i)
          hruprt(20) = Sroff(i)
          hruprt(21) = Soil_to_gw(i)
          hruprt(22) = Soil_to_ssr(i)
          hruprt(23) = Hru_impervstor(i)
          stor = hruprt(13) + hruprt(12) + hruprt(8) + hruprt(23)
!Hru_actet includes perv_actet, imperv_evap, intcp_evap, and snow_evap
          wbal = Hru_ppt(i) + Stor_last(i) - stor - Hru_actet(i) &
     &           - Sroff(i) - Soil_to_gw(i) - Soil_to_ssr(i)
          hruprt(24) = wbal
          Stor_last(i) = stor
          WRITE (buffer, '(F6.0,F5.0,1X,16F6.2,4F7.4,F6.2,F7.4)') (hruprt(j), j=1, 24)
          CALL write_outfile(buffer)
        ENDDO
      ELSEIF ( Pmo>0 ) THEN
        DO j = 1, Active_hrus
          i = Hru_route_order(j)
          Stor_last(i) = Pkwater_equiv(i) + Soil_moist(i)*Hru_frac_perv(i) &
     &                   + Hru_intcpstor(i) + Hru_impervstor(i)
        ENDDO
      ENDIF

      IF ( Moyrsum==1 ) THEN
        DO j = 1, Active_hrus
          i = Hru_route_order(j)
          Hru_ppt_mo(i) = Hru_ppt_mo(i) + Hru_ppt(i)
          Hru_net_ppt_mo(i) = Hru_net_ppt_mo(i) + Net_ppt(i)
          Hru_potet_mo(i) = Hru_potet_mo(i) + Potet(i)
          Hru_actet_mo(i) = Hru_actet_mo(i) + Hru_actet(i)
          Hru_snowmelt_mo(i) = Hru_snowmelt_mo(i) + Snowmelt(i)
          Hru_sroff_mo(i) = Hru_sroff_mo(i) + Sroff(i)
          Soil_to_gw_mo(i) = Soil_to_gw_mo(i) + Soil_to_gw(i)
          Soil_to_ssr_mo(i) = Soil_to_ssr_mo(i) + Soil_to_ssr(i)
          Hru_ppt_yr(i) = Hru_ppt_yr(i) + Hru_ppt(i)
          Hru_net_ppt_yr(i) = Hru_net_ppt_yr(i) + Net_ppt(i)
          Hru_potet_yr(i) = Hru_potet_yr(i) + Potet(i)
          Hru_actet_yr(i) = Hru_actet_yr(i) + Hru_actet(i)
          Hru_snowmelt_yr(i) = Hru_snowmelt_yr(i) + Snowmelt(i)
          Hru_sroff_yr(i) = Hru_sroff_yr(i) + Sroff(i)
          Soil_to_gw_yr(i) = Soil_to_gw_yr(i) + Soil_to_gw(i)
          Soil_to_ssr_yr(i) = Soil_to_ssr_yr(i) + Soil_to_ssr(i)
        ENDDO

        IF ( Nowday==Modays(Nowmonth) ) THEN
          rmo = FLOAT(Nowmonth)
          CALL write_outfile('   hru   mo                    oppt   nppt     '// &
                             '        pet   aet        pweqv  2ssres  2gwres   smlt sroff')

          DO j = 1, Active_hrus
            i = Hru_route_order(j)
            IF ( Hru_type(i)==0 ) CYCLE
            ri = FLOAT(i)
            WRITE ( buffer, 9001 ) ri, rmo, Hru_ppt_mo(i), &
     &              Hru_net_ppt_mo(i), Hru_potet_mo(i), &
     &              Hru_actet_mo(i), Pkwater_equiv(i), &
     &              Soil_to_ssr_mo(i), Soil_to_gw_mo(i), &
     &              Hru_snowmelt_mo(i), Hru_sroff_mo(i)
          CALL write_outfile(buffer(:106))
          ENDDO
        ENDIF

        IF ( Julwater==Yrdays ) THEN
          ryr = FLOAT(Nowyear)
          CALL write_outfile('   hru year                    oppt   nppt     '// &
                             '        pet   aet        pweqv  2ssres  2gwres   smlt sroff')
          DO j = 1, Active_hrus
            i = Hru_route_order(j)
            IF ( Hru_type(i)==0 ) CYCLE
            ri = FLOAT( i )
            WRITE ( buffer, 9001 ) ri, ryr, Hru_ppt_yr(i), &
     &              Hru_net_ppt_yr(i), Hru_potet_yr(i), &
     &              Hru_actet_yr(i), Pkwater_equiv(i), &
     &              Soil_to_ssr_yr(i), Soil_to_gw_yr(i), &
     &              Hru_snowmelt_yr(i), Hru_sroff_yr(i)
            CALL write_outfile(buffer(:106))
          ENDDO
        ENDIF
      ENDIF

 9001 FORMAT (F7.0, F5.0, 16X, 2F7.2, F16.2, F6.2, F13.2, 2F8.2, 2F7.2)

      END FUNCTION hsumbrun

