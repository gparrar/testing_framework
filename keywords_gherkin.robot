*** Settings ***
Documentation     Doc
Resource          ../keywords_commons.robot
Variables         ../../variables/rcl/${ENV}_variables.py

*** Keywords ***
Dado un usuario en la previsualizacion de actas en revision
    Ingresar Como Operador
    Seleccionar Modulo de Previsualizacion de Actas en Revision

Cuando el usuario aprueba el rechazo
    Rechazar actas

Entonces se actualiza el estado del acta rechazada
    
