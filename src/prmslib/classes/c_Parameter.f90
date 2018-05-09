module Parameters_class
  use variableKind
  use rVariable_class, only: rVariable
  use iVariable_class, only: iVariable
  use sVariable_class, only: sVariable
  use sArray_class, only: sArray
  use Control_class, only: Control

  private
  public :: Parameters

  character(len=*), parameter :: MODDESC = 'Parameter File'
  character(len=*), parameter :: MODNAME = 'Parameter_class'
  character(len=*), parameter :: MODVERSION = '2018-04-05 13:50:00Z'

  type Parameters
    type(rVariable) :: K_coef
    type(rVariable) :: Mann_n
    type(rVariable) :: adjmix_rain
    type(rVariable) :: albedo
    type(rVariable) :: albset_rna
    type(rVariable) :: albset_rnm
    type(rVariable) :: albset_sna
    type(rVariable) :: albset_snm
    type(rVariable) :: alte
    type(rVariable) :: altw
    type(rVariable) :: azrh
    type(iVariable) :: basin_solsta
    type(iVariable) :: basin_tsta
    type(rVariable) :: carea_max
    type(rVariable) :: carea_min
    type(iVariable) :: cascade_flg
    type(rVariable) :: cascade_tol
    type(rVariable) :: ccov_intcp
    type(rVariable) :: ccov_slope
    type(rVariable) :: cecn_coef
    type(iVariable) :: circle_switch
    type(iVariable) :: cov_type
    type(rVariable) :: covden_sum
    type(rVariable) :: covden_win
    type(rVariable) :: crad_coef
    type(rVariable) :: crad_exp
    type(rVariable) :: crop_coef
    type(rVariable) :: dday_intcp
    type(rVariable) :: dday_slope
    type(rVariable) :: den_init
    type(rVariable) :: den_max
    type(rVariable) :: dist_max
    type(rVariable) :: dprst_area
    type(rVariable) :: dprst_depth_avg
    type(rVariable) :: dprst_et_coef
    type(rVariable) :: dprst_flow_coef
    type(rVariable) :: dprst_frac
    type(rVariable) :: dprst_frac_hru
    type(rVariable) :: dprst_frac_init
    type(rVariable) :: dprst_frac_open
    type(rVariable) :: dprst_seep_rate_clos
    type(rVariable) :: dprst_seep_rate_open
    type(rVariable) :: elev_outflow
    type(iVariable) :: elev_units
    type(rVariable) :: elevlake_init
    type(rVariable) :: emis_noppt
    type(rVariable) :: epan_coef
    type(iVariable) :: fall_frost
    type(rVariable) :: fastcoef_lin
    type(rVariable) :: fastcoef_sq
    type(rVariable) :: freeh2o_cap
    type(rVariable) :: frost_temp
    type(iVariable) :: gvr_cell_id
    type(rVariable) :: gvr_cell_pct
    type(iVariable) :: gvr_hru_id
    type(iVariable) :: gw_down_id
    type(rVariable) :: gw_init
    type(rVariable) :: gw_pct_up
    type(rVariable) :: gw_seep_coef
    type(iVariable) :: gw_strmseg_down_id
    type(iVariable) :: gw_tau
    type(iVariable) :: gw_up_id
    type(rVariable) :: gwflow_coef
    type(rVariable) :: gwsink_coef
    type(rVariable) :: gwstor_init
    type(rVariable) :: gwstor_min
    type(rVariable) :: hamon_coef
    type(rVariable) :: hru_area
    type(rVariable) :: hru_aspect
    type(iVariable) :: hru_deplcrv
    type(iVariable) :: hru_down_id
    type(rVariable) :: hru_elev
    type(iVariable) :: hru_humidity_sta
    type(rVariable) :: hru_lat
    type(rVariable) :: hru_lon
    type(iVariable) :: hru_pansta
    type(rVariable) :: hru_pct_up
    type(rVariable) :: hru_percent_imperv
    type(iVariable) :: hru_plaps
    type(iVariable) :: hru_psta
    type(iVariable) :: hru_segment
    type(rVariable) :: hru_slope
    type(iVariable) :: hru_solsta
    type(iVariable) :: hru_strmseg_down_id
    type(iVariable) :: hru_subbasin
    type(iVariable) :: hru_tlaps
    type(iVariable) :: hru_tsta
    type(iVariable) :: hru_type
    type(iVariable) :: hru_up_id
    type(iVariable) :: hru_windspeed_sta
    type(rVariable) :: hru_x
    type(rVariable) :: hru_xlong
    type(rVariable) :: hru_y
    type(rVariable) :: hru_ylat
    type(rVariable) :: hs_krs
    type(rVariable) :: humidity_percent
    type(rVariable) :: imperv_stor_max
    type(iVariable) :: irr_type
    type(rVariable) :: jh_coef
    type(rVariable) :: jh_coef_hru
    type(rVariable) :: lake_coef
    type(rVariable) :: lake_din1
    type(rVariable) :: lake_evap_adj
    type(iVariable) :: lake_hru_id
    type(rVariable) :: lake_init
    type(iVariable) :: lake_out2
    type(rVariable) :: lake_out2_a
    type(rVariable) :: lake_out2_b
    type(rVariable) :: lake_qro
    type(rVariable) :: lake_seep_elev
    type(iVariable) :: lake_segment_id
    type(iVariable) :: lake_type
    type(rVariable) :: lake_vol_init
    type(rVariable) :: lapsemax_max
    type(rVariable) :: lapsemax_min
    type(rVariable) :: lapsemin_max
    type(rVariable) :: lapsemin_min
    type(iVariable) :: mapvars_freq
    type(iVariable) :: mapvars_units
    type(iVariable) :: max_missing
    type(iVariable) :: max_psta
    type(iVariable) :: max_tsta
    type(rVariable) :: maxday_prec
    type(iVariable) :: maxiter_sntemp
    type(iVariable) :: melt_force
    type(iVariable) :: melt_look
    type(rVariable) :: melt_temp
    type(rVariable) :: monmax
    type(rVariable) :: monmin
    type(iVariable) :: ncol
    type(iVariable) :: nhm_id,nhru_summary
    type(iVariable) :: nhm_seg
    type(iVariable) :: nsos
    type(rVariable) :: o2
    type(iVariable) :: obsin_segment
    type(iVariable) :: obsout_lake
    type(iVariable) :: obsout_segment
    type(rVariable) :: op_flow_thres
    type(iVariable) :: outlet_sta
    type(rVariable) :: padj_rn
    type(rVariable) :: padj_sn
    type(iVariable) :: parent_gw
    type(iVariable) :: parent_hru
    type(iVariable) :: parent_poigages
    type(iVariable) :: parent_segment
    type(iVariable) :: parent_ssr
    type(rVariable) :: pm_d_coef
    type(rVariable) :: pm_n_coef
    type(rVariable) :: pmn_mo
    type(sVariable) :: poi_gage_id
    type(iVariable) :: poi_gage_segment
    type(iVariable) :: poi_type
    type(rVariable) :: potet_cbh_adj
    type(rVariable) :: potet_sublim
    type(rVariable) :: ppt_rad_adj
    type(iVariable) :: precip_units
    type(rVariable) :: pref_flow_den
    type(iVariable) :: print_freq
    type(iVariable) :: print_type
    type(rVariable) :: psta_elev
    type(rVariable) :: psta_mon
    type(rVariable) :: psta_xlong
    type(rVariable) :: psta_ylat
    type(rVariable) :: pt_alpha
    type(rVariable) :: rad_conv
    type(rVariable) :: rad_trncf
    type(rVariable) :: radadj_intcp
    type(rVariable) :: radadj_slope
    type(rVariable) :: radj_sppt
    type(rVariable) :: radj_wppt
    type(rVariable) :: radmax
    type(rVariable) :: rain_adj
    type(rVariable) :: rain_cbh_adj
    type(iVariable) :: rain_code
    type(rVariable) :: rain_mon
    type(rVariable) :: rate_table
    type(rVariable) :: rate_table2
    type(rVariable) :: rate_table3
    type(rVariable) :: rate_table4
    type(iVariable) :: ratetbl_lake
    type(iVariable) :: runoff_units
    type(rVariable) :: s2
    type(rVariable) :: sat_threshold
    type(iVariable) :: seg_humidity_sta
    type(rVariable) :: seg_length
    type(rVariable) :: seg_slope
    type(rVariable) :: seg_summer_humidity
    type(rVariable) :: seg_winter_humidity
    type(rVariable) :: segment_flow_init
    type(iVariable) :: segment_type
    type(rVariable) :: segshade_sum
    type(rVariable) :: segshade_win
    type(rVariable) :: settle_const
    type(rVariable) :: slowcoef_lin
    type(rVariable) :: slowcoef_sq
    type(rVariable) :: smidx_coef
    type(rVariable) :: smidx_exp
    type(rVariable) :: snarea_curve
    type(rVariable) :: snarea_thresh
    type(rVariable) :: snow_adj
    type(rVariable) :: snow_cbh_adj
    type(rVariable) :: snow_intcp
    type(rVariable) :: snow_mon
    type(rVariable) :: snowinfil_max
    type(rVariable) :: snowpack_init
    type(rVariable) :: soil2gw_max
    type(rVariable) :: soil_moist_init
    type(rVariable) :: soil_moist_init_frac
    type(rVariable) :: soil_moist_max
    type(rVariable) :: soil_rechr_init
    type(rVariable) :: soil_rechr_init_frac
    type(rVariable) :: soil_rechr_max
    type(rVariable) :: soil_rechr_max_frac
    type(iVariable) :: soil_type
    type(iVariable) :: spring_frost
    type(rVariable) :: srain_intcp
    type(rVariable) :: sro_to_dprst
    type(rVariable) :: sro_to_dprst_imperv
    type(rVariable) :: sro_to_dprst_perv
    type(rVariable) :: ss_init
    type(iVariable) :: ss_tau
    type(rVariable) :: ssr2gw_exp
    type(rVariable) :: ssr2gw_rate
    type(rVariable) :: ssstor_init
    type(rVariable) :: ssstor_init_frac
    type(iVariable) :: subbasin_down
    type(rVariable) :: tbl_gate
    type(rVariable) :: tbl_gate2
    type(rVariable) :: tbl_gate3
    type(rVariable) :: tbl_gate4
    type(rVariable) :: tbl_stage
    type(rVariable) :: tbl_stage2
    type(rVariable) :: tbl_stage3
    type(rVariable) :: tbl_stage4
    type(iVariable) :: temp_units
    type(rVariable) :: tmax_adj
    type(rVariable) :: tmax_allrain
    type(rVariable) :: tmax_allrain_offset
    type(rVariable) :: tmax_allsnow
    type(rVariable) :: tmax_cbh_adj
    type(rVariable) :: tmax_index
    type(rVariable) :: tmax_lapse
    type(rVariable) :: tmin_adj
    type(rVariable) :: tmin_cbh_adj
    type(rVariable) :: tmin_lapse
    type(iVariable) :: tosegment
    type(iVariable) :: tosegment_nhm
    type(iVariable) :: transp_beg
    type(iVariable) :: transp_end
    type(rVariable) :: transp_tmax
    type(rVariable) :: tsta_elev
    type(rVariable) :: tsta_xlong
    type(rVariable) :: tsta_ylat
    type(iVariable) :: tstorm_mo
    type(rVariable) :: va_clos_exp
    type(rVariable) :: va_open_exp
    type(rVariable) :: vce
    type(rVariable) :: vcw
    type(rVariable) :: vdemn
    type(rVariable) :: vdemx
    type(rVariable) :: vdwmn
    type(rVariable) :: vdwmx
    type(rVariable) :: vhe
    type(rVariable) :: vhw
    type(rVariable) :: voe
    type(rVariable) :: vow
    type(rVariable) :: weir_coef
    type(rVariable) :: weir_len
    type(rVariable) :: width_flow
    type(rVariable) :: width_values
    type(rVariable) :: wrain_intcp
    type(rVariable) :: x_coef

    type(sArray), private :: parameter_filenames
  contains
    procedure, public :: read => read_Parameters
  end type

  interface Parameters
    !! Overloaded interface to instantiate the class.
    module function constructor_Parameters(Control_data) result(this)
      use Control_class, only:Control

      type(Parameters) :: this
        !! Parameter class
      class(Control), intent(in) :: Control_data
        !! Control class - contains information needed to open and read the parameter file
    end function
  end interface

  interface
    module subroutine read_parameters(this)
      class(Parameters), intent(inout) :: this
        !! Parameter class
    end subroutine
  end interface

end module
