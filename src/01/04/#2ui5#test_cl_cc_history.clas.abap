CLASS /2ui5/test_cl_cc_history DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS get_js
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS /2ui5/test_cl_cc_history IMPLEMENTATION.


  METHOD get_js.

    result = `if (!z2ui5.History) { sap.ui.define("z2ui5/History",["sap/ui/core/Control"], (Control)=>{` && |\n| &&
             `        "use strict";` && |\n| &&
             `        return Control.extend("z2ui5.History", {` && |\n| &&
             `            metadata: {` && |\n| &&
             `                properties: {` && |\n| &&
             `                    search: {` && |\n| &&
             `                        type: "string"` && |\n| &&
             `                    },` && |\n| &&
             `                }` && |\n| &&
             `            },` && |\n| &&
             `            setSearch(val) {` && |\n| &&
             `                this.setProperty("search", val);` && |\n| &&
             `                history.replaceState(null, null, window.location.pathname + val );` && |\n| &&
             `            },` && |\n| &&
             `            renderer(oRm, oControl) {}` && |\n| &&
             `        });` && |\n| &&
             `  }); }`.

  ENDMETHOD.

ENDCLASS.
