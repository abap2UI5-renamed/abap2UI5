CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION LONG
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.
    METHODS event FOR TESTING.
    METHODS event_backend FOR TESTING.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD event.

    DATA(lo_event) = NEW /2ui5/test_cl_core_event_srv( ).
    DATA(lv_event) = lo_event->get_event( `POST` ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_event
      exp = `.eB(['POST'])` ).

  ENDMETHOD.

  METHOD event_backend.

    DATA(lo_event) = NEW /2ui5/test_cl_core_event_srv( ).
    DATA(lv_event) = lo_event->get_event_client( /2ui5/test_if_client=>cs_event-popover_close ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_event
      exp = `.eF('POPOVER_CLOSE')` ).

  ENDMETHOD.
ENDCLASS.
