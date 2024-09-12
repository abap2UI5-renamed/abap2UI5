CLASS /2u5/test_cl_core_app_hello_w DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /2u5/test_if_app.
    DATA name TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /2u5/test_cl_core_app_hello_w IMPLEMENTATION.


  METHOD /2u5/test_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      client->view_display( /2u5/test_cl_xml_view=>factory(
        )->shell(
        )->page( title = 'abap2UI5 - Hello World'
        )->simple_form( editable = abap_true
            )->content( ns = `form`
                )->title( 'Make an input here and send it to the server...'
                )->label( 'Name'
                )->input( client->_bind_edit( name )
                )->button( text  = 'post' press = client->_event( 'BUTTON_POST' )
        )->stringify( ) ).

    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->message_box_display( |Your name is { name }| ).
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.
