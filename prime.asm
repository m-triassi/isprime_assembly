section .data

; put your data in this section using
; db , dw, dd directions

number db  5
answer db  1    ;  1 means number is prime, 0 means number is not prime
section .bss

; put UNINITIALIZED data here using

section .text
        global _start

_start:
       mov esi, number ; get the offset of number into esi
keith: mov eax, 0      ; clear the entire eax register
       mov al, [esi]   ; get the number from memory into al
       mov dl, al      ; put it inside dl as well
       mov bl, 2       ; bl holds each divisor starting from 2
loopy: div bl          ; ax / bl  with quot in al and rem in ah
       and ax, 1111111100000000b   ;  isolate the rem in ah with a  AND mask
                                   ; to determine whether the remainder is 0
       inc bl          ; increment the divisor
       mov al, dl      ; restore the value held in al for the next loop
       cmp bl, al      ; compare the divisor and the number
       je done         ; if they're the same we're done
       cmp ah, 0       ; check if remainder is zero
       jne loopy       ; if not we're not done and must try the next divisor
done:  cmp bl, dl      ; check if we're done because its prime
       mov dword [answer], 0   ; assume the answer is not prime first
       jne exit        ; if cmp shows they not the same, it's not prime
       mov dword [answer], 1   ; if we got here, they are the same, save 1 to answer
exit:  mov eax, 1      ; call system exit
       mov ebx, 0      ; return code 0, no error
       int 80h
