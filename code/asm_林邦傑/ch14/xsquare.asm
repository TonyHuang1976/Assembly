; ******************* xsquare.asm ******************
;
         ORG   0100H
         JMP   start
x        DD    1.0
deltax   DD    0.1
y        DD    0.0
space    DB    '    ', '$'
title    DB    "    x        x*x ", '$'
title2   DB    " -------    ------", '$'
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispchr.mac"
%include "..\mymacro\dispstr.mac"
;
start:
       dispstr title           ;列印表頭
       newline
       dispstr title2          ;列印表頭
       newline
;
       FINIT                   ;浮點堆疊初始化
       MOV     CX, 11          ;列印11列的表格
loop2:
       FLD     DWORD [x]       ;TOS=x
       FMUL    DWORD [x]       ;TOS=x*x
       FSTP    DWORD [y]       ;y=TOS=x*x
       dispf   x, 4            ;列印x,四位小數
       dispstr space           ;空白
       dispf   y, 4            ;列印x,四位小數
       newline                 ;換列
       FLD     DWORD [x]       ;TOS=x
       FADD    DWORD [deltax]  ;TOS=x+deltax
       FSTP    DWORD [x]       ;x=x+deltax
       DEC     CX              ;CX=CX-1
       CMP     CX, 0           ;CX=0?
       JE      next            ;是
       JMP     loop2           ;否
next:
       MOV     AX, 4c00H
       INT     21H             ;返回作業系統
