; Toggle Tandy joystick interface state.

        JMP START

DISABLEMSG      DB      "Disabled Tandy joystick interface.",0Dh,0Ah,"$"
ENABLEMSG       DB      "Enabled Tandy joystick interface.",0Dh,0Ah,"$"
NOTTANDYMSG     DB      "This isn't a Tandy 1000-series.",0Dh,0Ah,"$"

START:
        MOV     DX,OFFSET NOTTANDYMSG
	MOV	AX,0FFFFh
	MOV	ES,AX
	CMP	BYTE PTR ES:[0Eh],0FFh
        JNE     EXIT
	MOV	AX,0FC00h
	MOV	ES,AX
	CMP	BYTE PTR ES:[0],21h
        JNE     EXIT
        MOV     DX,0FFEBh
        IN      AL,DX
        XOR     AL,2
        OUT     DX,AL
        MOV     DX,OFFSET DISABLEMSG
        TEST    AL,2
        JZ      EXIT
        MOV     DX,OFFSET ENABLEMSG
EXIT:
        MOV     AH,9
        INT     21h
        INT     20h
