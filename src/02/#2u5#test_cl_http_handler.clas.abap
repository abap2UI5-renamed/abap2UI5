CLASS /2u5/test_cl_http_handler DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-METHODS main
      IMPORTING
        body          TYPE string
        config        TYPE /2u5/test_if_types=>ty_s_http_request_get OPTIONAL
      RETURNING
        VALUE(result) TYPE string.

    CLASS-METHODS http_post
      IMPORTING
        val           TYPE string
      RETURNING
        VALUE(result) TYPE string.

    CLASS-METHODS http_get
      IMPORTING
        val           TYPE /2u5/test_if_types=>ty_s_http_request_get OPTIONAL
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /2u5/test_cl_http_handler IMPLEMENTATION.


  METHOD http_get.

    DATA(lo_get) = NEW /2u5/test_cl_core_http_get( val ).
    result = lo_get->main( ).

  ENDMETHOD.


  METHOD http_post.

    DATA(lo_post) = NEW /2u5/test_cl_core_http_post( val ).
    result = lo_post->main( ).

  ENDMETHOD.

  METHOD main.

    IF body IS INITIAL.
      DATA(lo_get) = NEW /2u5/test_cl_core_http_get( config ).
      result = lo_get->main( ).
    ELSE.
      DATA(lo_post) = NEW /2u5/test_cl_core_http_post( body ).
      result = lo_post->main( ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
