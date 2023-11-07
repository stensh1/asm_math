;Orshak Ivan, group #7362, 2019

format PE console
include '%fasminc%/win32w.inc'

section '.code' code readable executable
        push 5
        cinvoke printf, EnterPls

        mov ebx, Numbers
        mov ecx, 5

        input:
                push ecx
                cinvoke scanf, Spec, ebx
                pop ecx

                add ebx, 4
        loop input

        cinvoke printf, Entered
        call PrintMas

        invoke GetModuleHandleW, dword 0
        cmp eax, 0
        je exit

        mov esi, Numbers
        mov bl, [eax]
        mov dl, [eax + 1]
        xor eax, eax
        xor ecx, ecx

        math:
                mov cl, [esi + eax * 4]
                sub cl, bl
                add cl, al
                xor cl, dl

                mov [esi + eax * 4], cl

                inc eax

                cmp eax, 5
                jb math

        exit:
                cinvoke printf, Result
                call PrintMas

                cinvoke printf, PressBtn

                cinvoke getch
                cinvoke ExitProcess, dword 0

        proc PrintMas ;Процедура вывода массива на экран
                pushad
                mov ebx, Numbers
                mov ecx, 5

                cycle:
                        mov al, [ebx]
                        push ecx
                        cinvoke printf, Spec2, eax
                        pop ecx

                        add ebx, 4
                loop cycle

                popad
                ret
        endp

section '.const' data readable
        Spec db '%hhu', 0
        Spec2 db '%hhu ', 0
        EnterPls db 'Please, enter %d unsigned decimal numbers from 0 to 255 inclusively:', 0dh, 0ah, 0
        Entered db 0dh, 0ah, 0dh, 0ah, 'Entered numbers (decimal):', 0dh, 0ah, 0
        Result db 0dh, 0ah, 0dh, 0ah, 'Result (decimal):', 0dh, 0ah, 0
        PressBtn db 0dh, 0ah, 0dh, 0ah, 'Press any key...', 0dh, 0ah, 0

section '.data?' data readable writeable
        Numbers db 5 dup (?)

section '.data' data readable import
        library kernel32,'KERNEL32.DLL', \
                msvcrt, 'MSVCRT.DLL'

        import kernel32,\
               ExitProcess,'ExitProcess', \
               GetModuleHandleW, 'GetModuleHandleW'

        import msvcrt, \
               getch, '_getch',\
               printf, 'printf', \
               scanf, 'scanf'