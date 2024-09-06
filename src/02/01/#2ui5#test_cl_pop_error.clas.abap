CLASS /2ui5/test_cl_pop_error DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /2ui5/test_if_app.

    CLASS-METHODS factory
      IMPORTING
        x_root          TYPE REF TO cx_root
      RETURNING
        VALUE(r_result) TYPE REF TO /2ui5/test_cl_pop_error.

  PROTECTED SECTION.
    DATA client TYPE REF TO /2ui5/test_if_client.
    DATA error TYPE REF TO cx_root.
    DATA check_initialized TYPE abap_bool.
    METHODS view_display.

  PRIVATE SECTION.
ENDCLASS.



CLASS /2ui5/test_cl_pop_error IMPLEMENTATION.

  METHOD factory.

    r_result = NEW #( ).
    r_result->error = x_root.

  ENDMETHOD.


  METHOD view_display.

    DATA(popup) = /2ui5/test_cl_xml_view=>factory_popup( )->dialog(
                  title      = `Error View`
                  afterclose = client->_event( 'BUTTON_CONFIRM' )
              )->content(
                  )->vbox( 'sapUiMediumMargin'
                      )->text( error->get_text( )
              )->get_parent( )->get_parent(
              )->buttons(
                  )->button(
                      text  = `OK`
                      press = client->_event( 'BUTTON_CONFIRM' )
                      type  = 'Emphasized' ).

    client->popup_display( popup->stringify( ) ).

  ENDMETHOD.


  METHOD /2ui5/test_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      view_display( ).
      RETURN.
    ENDIF.

    CASE client->get( )-event.
      WHEN `BUTTON_CONFIRM`.
        client->popup_destroy( ).
        client->nav_app_leave( ).
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
