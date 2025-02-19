CLASS zabap2ui5_cl_core_srv_diss DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        attri TYPE REF TO zabap2ui5_if_core_types=>ty_t_attri
        app   TYPE REF TO object.

    METHODS main.

  PROTECTED SECTION.

    DATA mt_attri TYPE REF TO zabap2ui5_if_core_types=>ty_t_attri.
    DATA mo_app   TYPE REF TO object.

    METHODS main_run.
    METHODS main_init.

    METHODS diss_struc
      IMPORTING
        ir_attri      TYPE REF TO zabap2ui5_if_core_types=>ty_s_attri
      RETURNING
        VALUE(result) TYPE zabap2ui5_if_core_types=>ty_t_attri.

    METHODS diss_dref
      IMPORTING
        ir_attri      TYPE REF TO zabap2ui5_if_core_types=>ty_s_attri
      RETURNING
        VALUE(result) TYPE zabap2ui5_if_core_types=>ty_t_attri.

    METHODS diss_oref
      IMPORTING
        ir_attri      TYPE REF TO zabap2ui5_if_core_types=>ty_s_attri
      RETURNING
        VALUE(result) TYPE zabap2ui5_if_core_types=>ty_t_attri.

    METHODS create_new_entry
      IMPORTING
        !name         TYPE string
      RETURNING
        VALUE(result) TYPE zabap2ui5_if_core_types=>ty_s_attri.

  PRIVATE SECTION.
ENDCLASS.


CLASS zabap2ui5_cl_core_srv_diss IMPLEMENTATION.
  METHOD constructor.

    mt_attri = attri.
    mo_app = app.

  ENDMETHOD.

  METHOD create_new_entry.

    result = VALUE zabap2ui5_if_core_types=>ty_s_attri( ).
    result-name = name.
    DATA(lo_model) = NEW zabap2ui5_cl_core_srv_attri( attri = mt_attri
                                                  app   = mo_app ).
    result-r_ref       = lo_model->attri_get_val_ref( name ).
    result-o_typedescr = cl_abap_datadescr=>describe_by_data_ref( result-r_ref ).

  ENDMETHOD.

  METHOD diss_dref.

    IF zabap2ui5_cl_util=>check_unassign_inital( ir_attri->r_ref ).
      RETURN.
    ENDIF.

    DATA(lr_ref) = zabap2ui5_cl_util=>unassign_data( ir_attri->r_ref ).
    IF lr_ref IS INITIAL.
      RETURN.
    ENDIF.

    DATA(ls_attri2) = VALUE zabap2ui5_if_core_types=>ty_s_attri( ).
    ls_attri2-o_typedescr = cl_abap_datadescr=>describe_by_data_ref( lr_ref ).

    CASE ls_attri2-o_typedescr->kind.

      WHEN cl_abap_datadescr=>kind_struct.
        DATA(lt_attri) = diss_struc( ir_attri ).
        INSERT LINES OF lt_attri INTO TABLE result.

      WHEN OTHERS.

        ls_attri2-name = |{ ir_attri->name }->*|.
        DATA(lo_model) = NEW zabap2ui5_cl_core_srv_attri( attri = mt_attri
                                                      app   = mo_app ).
        ls_attri2-r_ref = lo_model->attri_get_val_ref( ls_attri2-name ).
        INSERT ls_attri2 INTO TABLE result.

    ENDCASE.

  ENDMETHOD.

  METHOD diss_oref.

    IF zabap2ui5_cl_util=>check_unassign_inital( ir_attri->r_ref ).
      RETURN.
    ENDIF.

    DATA(lr_ref) = zabap2ui5_cl_util=>unassign_object( ir_attri->r_ref ).
    DATA(lt_attri) = zabap2ui5_cl_util=>rtti_get_t_attri_by_oref( lr_ref ).

    LOOP AT lt_attri REFERENCE INTO DATA(lr_attri)
         WHERE visibility   = cl_abap_objectdescr=>public
               AND is_interface = abap_false
               AND is_constant  = abap_false.
      TRY.
          DATA(lv_name) = COND #( WHEN ir_attri->name IS NOT INITIAL THEN |{ ir_attri->name }->| ) && lr_attri->name.
          DATA(ls_new) = create_new_entry( lv_name ).
          INSERT ls_new INTO TABLE result.

        CATCH cx_root.
      ENDTRY.
    ENDLOOP.

  ENDMETHOD.

  METHOD diss_struc.

    IF ir_attri->o_typedescr->kind = cl_abap_typedescr=>kind_ref.
      DATA(lv_name) = |{ ir_attri->name }->|.
      DATA(lr_ref) = zabap2ui5_cl_util=>unassign_data( ir_attri->r_ref ).
    ELSE.
      lv_name = |{ ir_attri->name }-|.
      lr_ref = ir_attri->r_ref.
    ENDIF.

    DATA(lt_attri) = zabap2ui5_cl_util=>rtti_get_t_attri_by_any( lr_ref ).

    LOOP AT lt_attri INTO DATA(ls_attri).
      DATA(ls_new) = create_new_entry( lv_name && ls_attri-name ).
      INSERT ls_new INTO TABLE result.
    ENDLOOP.

  ENDMETHOD.

  METHOD main.

    TRY.

        main_init( ).

        IF line_exists( mt_attri->*[ check_dissolved = abap_false ] ).
          main_run( ).
        ENDIF.

      CATCH cx_root.
        CLEAR mt_attri->*.
        main_init( ).

        IF line_exists( mt_attri->*[ check_dissolved = abap_false ] ).
          main_run( ).
        ENDIF.
    ENDTRY.

  ENDMETHOD.

  METHOD main_init.

    IF mt_attri->* IS NOT INITIAL.
      LOOP AT mt_attri->* TRANSPORTING NO FIELDS
           WHERE bind_type <> zabap2ui5_if_core_types=>cs_bind_type-one_time.
      ENDLOOP.
      IF sy-subrc = 0.
        RETURN.
      ENDIF.
    ENDIF.

    DATA(ls_attri) = VALUE zabap2ui5_if_core_types=>ty_s_attri( r_ref = REF #( mo_app ) ).
    DATA(lt_init) = diss_oref( REF #( ls_attri ) ).
    INSERT LINES OF lt_init INTO TABLE mt_attri->*.

  ENDMETHOD.

  METHOD main_run.

    DATA(lt_attri_new) = VALUE zabap2ui5_if_core_types=>ty_t_attri( ).

    LOOP AT mt_attri->* REFERENCE INTO DATA(lr_attri)
         WHERE check_dissolved  = abap_false
               AND bind_type       <> zabap2ui5_if_core_types=>cs_bind_type-one_time.

      lr_attri->check_dissolved = abap_true.

      IF lr_attri->o_typedescr IS NOT BOUND.
        DATA(ls_entry) = create_new_entry( lr_attri->name ).
        lr_attri->o_typedescr = ls_entry-o_typedescr.
        lr_attri->r_ref       = ls_entry-r_ref.
      ENDIF.

      CASE lr_attri->o_typedescr->kind.

        WHEN cl_abap_typedescr=>kind_struct.
          DATA(lt_attri_struc) = diss_struc( lr_attri ).
          INSERT LINES OF lt_attri_struc INTO TABLE lt_attri_new.

        WHEN cl_abap_typedescr=>kind_ref.

          CASE lr_attri->o_typedescr->type_kind.

            WHEN cl_abap_typedescr=>typekind_oref.
              DATA(lt_attri_oref) = diss_oref( lr_attri ).
              INSERT LINES OF lt_attri_oref INTO TABLE lt_attri_new.
            WHEN cl_abap_typedescr=>typekind_dref.
              DATA(lt_attri_dref) = diss_dref( lr_attri ).
              INSERT LINES OF lt_attri_dref INTO TABLE lt_attri_new.
            WHEN OTHERS.
              ASSERT 1 = 0.
          ENDCASE.
        WHEN OTHERS.
      ENDCASE.

    ENDLOOP.
    INSERT LINES OF lt_attri_new INTO TABLE mt_attri->*.

  ENDMETHOD.
ENDCLASS.
