CLASS zabap2ui5_cl_app_hello_world DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zabap2ui5_if_app.

    DATA name              TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zabap2ui5_cl_app_hello_world IMPLEMENTATION.

  METHOD zabap2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      client->view_display( zabap2ui5_cl_xml_view=>factory(
        )->shell(
        )->page( title = 'abap2UI5 - Hello World'
        )->simple_form( editable = abap_true
            )->content( ns = `form`
                )->title( 'Make an input here and send it to the server...'
                )->label( 'Name'
                )->input( client->_bind_edit( name )
                )->button( text  = 'post'
                           press = client->_event( 'BUTTON_POST' )
        )->stringify( ) ).

    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->message_box_display( |Your name is { name }| ).
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.
