;|=============students list:==============|
;|                                         |
;|1. Full name: HADIBI ROUMAISSA           |
;|   Matricule: 232331574110               |
;|   Group: 1                              |
;|                                         |
;|2. Full name: BOUTRIK ROMAISSA           |
;|   Matricule: 232331485120               |
;|   Group: 2                              |
;|                                         |
;|3. Full name: BASSAIDOUELHADJ RAFIK      |
;|   Matricule: 232331530912               |
;|   Group: 2                              |
;|                                         |
;|4. Full name: HOUANTI RACIM              |
;|   Matricule: 232331572320               |
;|   Group: 4                              |
;|                                         |
;|=========================================|

;code:
.model small
.stack 100h

.data
    ; Main Menu
    mainMenu db 13,10,'============ Main Menu ============',13,10
      db '1. Calculator Mode',13,10
      db '2. Conversion Mode',13,10
      db '3. Exit',13,10
      db 'Choice: $'
                  
    ; Calculator Type Menu
    calcTypeMenu db 13,10,'===== Calculator Input Type =====',13,10
      db '1. Decimal Mode',13,10
      db '2. Binary Mode',13,10
      db '3. Hexadecimal Mode',13,10
      db '4. Return to Main Menu',13,10
      db 'Choice: $'

                 
                  
    ; Binary Mode Menu
    binmenu db 13,10,'========== Binary Mode ==========',13,10
      db '1. Addition',13,10
      db '2. Subtraction',13,10
      db '3. Multiplication',13,10
      db '4. Division',13,10
      db '5. XOR',13,10
      db '6. OR',13,10
      db '7. AND',13,10 
      db '8. Return to Calculator Type Menu',13,10
      db 'Choice: $'

    ; Hex Mode Menu
    hexMenu db 13,10,'========== Hexadecimal Mode ==========',13,10
      db '1. Addition',13,10
      db '2. Subtraction',13,10
      db '3. Multiplication',13,10
      db '4. Division',13,10
      db '5. XOR',13,10
      db '6. OR',13,10
      db '7. AND',13,10 
      db '8. Return to Calculator Type Menu',13,10
      db 'Choice: $'
            
    ; calculator Menu
    calcMenu db 13,10,'========== Calculator Mode ==========',13,10
      db '1. Addition',13,10
      db '2. Subtraction',13,10
      db '3. Multiplication',13,10
      db '4. Division',13,10
      db '5. XOR',13,10
      db '6. OR',13,10
      db '7. AND',13,10 
      db '8. Return to Main Menu',13,10
      db 'Choice: $'

    ; Conversion Menu
    convMenu db 13,10,'========== Conversion Mode ==========',13,10
      db '1. Decimal to Binary',13,10
      db '2. Decimal to Hexadecimal',13,10
      db '3. Binary to Decimal',13,10
      db '4. Binary to Hexadecimal',13,10
      db '5. Hexadecimal to Decimal',13,10
      db '6. Hexadecimal to Binary',13,10
      db '7. Return to Main Menu',13,10
      db 'Choice: $'

    ; Prompts
    num1Prompt db 13,10,'Enter first number (decimal): $'
    num2Prompt db 13,10,'Enter second number (decimal): $'
    binNum1Prompt db 13,10,'Enter first number (binary): $'
    binNum2Prompt db 13,10,'Enter second number (binary): $'
    hexNum1Prompt db 13,10,'Enter first number (hex): $'
    hexNum2Prompt db 13,10,'Enter second number (hex): $'
    convPrompt db 13,10,'Enter decimal number: $'
    binPrompt db 13,10,'Enter binary number (up to 16 bits): $'
    hexPrompt db 13,10,'Enter hexadecimal number (up to 4 digits): $'
    resultMsg db 13,10,'Result: $'
    binMsg db ' Binary: $'
    hexMsg db ' Hexadecimal: $'
    decMsg db ' Decimal: $'
    
    binErrorMsg db 13,10,'Error: Not a binary number! Only 0 and 1 allowed.',13,10,'$'
    hexErrorMsg db 13,10,'Error: Not a hexadecimal number! Only 0-9 and A-F allowed.',13,10,'$'
    emptyInputMsg db 13,10,'Error: No input received.',13,10,'$'
    pswMsg        db 13,10,'PSW Flags: $'
    msg_carry     db 13,10,'Carry Flag (CF): $'
    msg_zero      db 'Zero Flag (ZF): $'
    msg_sign      db 'Sign Flag (SF): $'
    msg_parity    db 'Parity Flag (PF): $'
    msg_overflow  db 'Overflow Flag (OF): $'
    msg_auxiliary db 'Auxiliary Flag (AF): $'
    newline       db 0Dh,0Ah, '$'
    errDivZero db 13,10,'Error: Division by zero!$'
     

    ; Buffers
    inputBuffer db 17 ; Max 5 digits
                  db ? ; Actual length
                  db 17 dup(0)
    decBuffer db 6 dup(' ')
    binBuffer db 16 dup('0'),'$'
    hexBuffer db 4 dup('0'),'$'
    tempBuffer dw 0

    ; Variables
    num1 dw 0
    num2 dw 0
    result dw 0
    flags dw 0
    currentMode db 0 ; 0=decimal, 1=binary, 2=hex

.code
main proc
    mov ax, @data
    mov ds, ax
mainLoop:
    call clearScreen
    ; Display main menu
    mov ah, 09h
    lea dx, mainMenu
    int 21h

    ; Get user choice
    mov ah, 01h
    int 21h
    call clearScreen

    cmp al, '1'
    jne check_main2
    jmp calculatorMode
check_main2:
    cmp al, '2'
    jne check_main3
    jmp conversionMode
check_main3:
    cmp al, '3'
    jne mainLoop
    call clearScreen 
    jmp exitProgram

calculatorMode:
    ; Display calculator menu
    mov ah, 09h
    lea dx, calcTypeMenu
    int 21h
    
    ; Get user choice
    mov ah, 01h
    int 21h

    
    cmp al, '1'
    jne che2
    jmp decimalMode
che2:
    cmp al, '2'
    jne che3
    jmp binaryMode
che3:
    cmp al, '3'
    jne che4
    jmp hexMode
che4:
    cmp al, '4'
    je mainLoop
    jmp calculatorMode

decimalMode: 
    call clearScreen
     mov currentMode, 0
    ; Display calculator menu
    mov ah, 09h
    lea dx,  calcMenu 
    int 21h

    ; Get user choice
    mov ah, 01h
    int 21h

    cmp al, '1'
    jne check_calc2
    call clearScreen
    jmp addition
check_calc2:
    cmp al, '2'
    jne check_calc3
    call clearScreen
    jmp subtraction
check_calc3:
    cmp al, '3'
    jne check_calc4
    call clearScreen
    jmp multiplication
check_calc4:
    cmp al, '4'
    jne check_calc5
    call clearScreen
    jmp division
    
check_calc5:
    cmp al, '5'
    jne check_calc6
    call clearScreen
    jmp xorOperation
check_calc6:
    cmp al, '6'
    jne check_calc7
    call clearScreen
    jmp orOperation
check_calc7:
    cmp al, '7'
    jne check_calc8
    call clearScreen
    jmp andOperation
check_calc8:
    cmp al, '8'
    je go_main
    jmp calculatorMode  
go_main:
    call clearScreen
    jmp calculatorMode  
    
addition:
   call getNumbers
    mov ax, num1
    add ax, num2
    mov result, ax
    jmp showResults
subtraction:
    call getNumbers
    mov ax, num1
    sub ax, num2
    mov result, ax
    jmp showResults
multiplication:
    call getNumbers
    mov ax, num1
    mov bx, num2
    mul bx
    mov result, ax
    jmp showResults
division:
    call getNumbers
    cmp num2, 0
    jne division_ok
    mov ah, 09h
    lea dx, errDivZero
    int 21h
    jmp calculatorMode
division_ok:
    mov dx, 0
    mov ax, num1
    mov bx, num2
    div bx
    mov result, ax
    jmp showResults
xorOperation:
    call getNumbers
    mov ax, num1
    xor ax, num2
    mov result, ax
    jmp showResults
orOperation:
    call getNumbers
    mov ax, num1
    or ax, num2
    mov result, ax
    jmp showResults
andOperation:
    call getNumbers
    mov ax, num1
    and ax, num2
    mov result, ax
    jmp showResults
showResults:
    pushf
    pop flags
    mov ah, 09h
    lea dx, resultMsg
    int 21h
    
    mov ah, 09h
    lea dx, newline
    int 21h
    mov ax, result
    call printDecimal
    
    mov ah, 09h
    lea dx, newline
    int 21h
    mov ax, result
    call printBinary
    
    mov ah, 09h
    lea dx, newline
    int 21h
    mov ax, result
    call printHexadecimal
    call showPSW
    jmp calculatorMode
binaryMode:
    call clearScreen
    mov currentMode, 1
    
binaryMenuLoop:
    call clearScreen
    ; Display binary menu
    mov ah, 09h
    lea dx, binmenu
    int 21h
    
    ; Get user choice
    mov ah, 01h
    int 21h
    
    
    ; Process selection - using jne/jmp pairs instead of je
    cmp al, '1'
    jne not_add
    call clearScreen
    jmp addition
not_add:
    cmp al, '2'
    jne not_sub
    call clearScreen
    jmp subtraction
not_sub:
    cmp al, '3'
    jne not_mul
    call clearScreen
    jmp multiplication
not_mul:
    cmp al, '4'
    jne not_div
    call clearScreen
    jmp division
not_div:
    cmp al, '5'
    jne not_xor
    call clearScreen
    jmp xorOperation
not_xor:
    cmp al, '6'
    jne not_or
    call clearScreen
    jmp orOperation
not_or:
    cmp al, '7'
    jne not_and
    call clearScreen
   jmp andOperation
not_and:
    cmp al, '8'
    jne invalid_bin
    jmp calculatorMode   ; Return to calculator type menu
    
invalid_bin:
    ; Invalid input - beep and show menu again
    mov ah, 02h
    mov dl, 07h  ; Beep sound
    int 21h
    jmp binaryMenuLoop
    
    hexMode:
    call clearScreen
    mov currentMode, 2
    
hexMenuLoop:
    call clearScreen
    ; Display hex menu
    mov ah, 09h
    lea dx, hexMenu
    int 21h
    
    ; Get user choice
    mov ah, 01h
    int 21h
    
    ; Process selection
    cmp al, '1'
    jne not_add_hex
    call clearScreen
    jmp addition
not_add_hex:
    cmp al, '2'
    jne not_sub_hex
    call clearScreen
    jmp subtraction
not_sub_hex:
    cmp al, '3'
    jne not_mul_hex
    call clearScreen
    jmp multiplication
not_mul_hex:
    cmp al, '4'
    jne not_div_hex
    call clearScreen
    jmp division
not_div_hex:
    cmp al, '5'
    jne not_xor_hex
    call clearScreen
   jmp xorOperation
not_xor_hex:
    cmp al, '6'
    jne not_or_hex
    call clearScreen
     jmp orOperation
not_or_hex:
    cmp al, '7'
    jne not_and_hex
    call clearScreen
  jmp andOperation
not_and_hex:
    cmp al, '8'
    jne invalid_hex
    jmp calculatorMode   ; Return to calculator type menu
    
invalid_hex:
    ; Invalid input
    mov ah, 02h
    mov dl, 07h
    int 21h
    jmp hexMenuLoop
conversionMode:
    mov ah, 09h
    lea dx, convMenu
    int 21h

    mov ah, 01h
    int 21h
    call clearScreen
    cmp al, '1'
    jne check_conv2
    jmp decToBin
check_conv2:
    cmp al, '2'
    jne check_conv3
    jmp decToHex
check_conv3:
    cmp al, '3'
    jne check_conv4
    jmp binToDec
check_conv4:
    cmp al, '4'
    jne check_conv5
    jmp binToHex
check_conv5:
    cmp al, '5'
    jne check_conv6
    jmp hexToDec
check_conv6:
    cmp al, '6'
    jne check_conv7
    jmp hexToBin
check_conv7:
    cmp al, '7'
    jne conversionMode
    jmp mainLoop

decToBin:
    call getConversionNumber
    mov ah, 09h
    lea dx, newline      
    int 21h
    mov ax, tempBuffer
    call printBinary
    jmp conversionMode

decToHex:
    call getConversionNumber
    mov ah, 09h
    lea dx, newline      
    int 21h
    mov ax, tempBuffer
    call printHexadecimal
    jmp conversionMode

binToDec:
    call getBinaryNumber
    mov ah, 09h
    lea dx, newline      
    int 21h
    mov ax, tempBuffer
    call printDecimal
    jmp conversionMode

binToHex:
    call getBinaryNumber
    mov ah, 09h
    lea dx, newline      
    int 21h
    mov ax, tempBuffer
    call printHexadecimal
    jmp conversionMode

hexToDec:
    call getHexadecimalNumber
    mov ah, 09h
    lea dx, newline      
    int 21h
    mov ax, tempBuffer
    call printDecimal
    jmp conversionMode

hexToBin:
    call getHexadecimalNumber
    mov ah, 09h
    lea dx, newline      
    int 21h
    mov ax, tempBuffer
    call printBinary
    jmp conversionMode

getNumbers proc
    cmp currentMode, 1 ; Compare currentMode with 1 (binary mode)
    je binary_input    ; If equal (currentMode == 1), jump to binary_input
    cmp currentMode, 2 ; Compare currentMode with 2 (hex mode)
    je hex_input       ; If equal (currentMode == 2), jump to hex_input
    
    ; Default to decimal input
    mov ah, 09h          ;Prepares the DOS "print string" function (int 21h with AH=09h).
    lea dx, num1Prompt   ;Loads the address of the prompt "Enter first number (decimal): $" into DX.
    int 21h              ;Calls DOS to display the prompt asking for the first number.
    call readDecimal     ;Calls the readDecimal subroutine to:
                         ;Read user input (e.g., "123").
                         ;Convert the ASCII string to a 16-bit integer (e.g., 123 ? 0x007B in AX).
    mov num1, ax         ;Stores the converted number (now in AX) into the variable num1.
    
    mov ah, 09h          ;same process as num1
    lea dx, num2Prompt
    int 21h
    call readDecimal
    mov num2, ax
    ret
    
binary_input:
    mov ah, 09h
    lea dx, binNum1Prompt  ;Load address of "Enter first number (binary): $" 
    int 21h                ;Display the prompt 
    call getBinaryNumber   ;Get user input and convert to binary number
    mov ax, tempBuffer     ;Move converted number from tempBuffer to AX
    mov num1, ax           ;Store first number in num1
    
    mov ah, 09h            ;same process as num1
    lea dx, binNum2Prompt
    int 21h
    call getBinaryNumber
    mov ax, tempBuffer
    mov num2, ax
    ret
    
    
hex_input:                ;same as bin_input
    mov ah, 09h
    lea dx, hexNum1Prompt
    int 21h
    call getHexadecimalNumber
    mov ax, tempBuffer
    mov num1, ax
    
    mov ah, 09h
    lea dx, hexNum2Prompt
    int 21h
    call getHexadecimalNumber
    mov ax, tempBuffer
    mov num2, ax
    ret
getNumbers endp

getConversionNumber proc
    mov ah, 09h
    lea dx, convPrompt  ;Load address of "Enter decimal number: $"
    int 21h
    call readDecimal    ;Calls subroutine to read and convert input
    mov tempBuffer, ax  ;Store the converted number in tempBuffer
    ret
getConversionNumber endp

getBinaryNumber proc
    ;Purpose: Saves register states (since we'll modify them).
    ;Why?: Ensures calling codes registers aren't corrupted.
    push bx
    push cx
    push si

binary_input_retry:
    ; Display prompt
    mov ah, 09h
    lea dx, binPrompt   ;Load address of "Enter binary number (up to 16 bits): $"
    int 21h             ;Display prompt

    ; Read input
    mov ah, 0Ah            ; DOS buffered input function
    lea dx, inputBuffer    ; Load address of input buffer
    int 21h                ; Read input

    ; Validate each character
   mov ch, 0
   mov cl, [inputBuffer+1] ; Length of input(Get input length)
     
   jcxz empty_binary_input ; Handle empty input(If length = 0, handle empty input)
                           ;If user just presses Enter, jumps to empty_binary_input (shows error).
   lea si, [inputBuffer+2] ; Start of input(Point to start of input string)

validate_binary:
    mov dl, [si]                ;Load next char
    cmp dl, '0'                 ;Check if < '0'
    jb invalid_binary_char      ;? Error if not '0'/'1'
    cmp dl, '1'                 ;Check if > '1'
    ja invalid_binary_char      ;? Error if not '0'/'1'
    inc si                      ;Move to next char
    loop validate_binary        ;Repeat for all chars
                                ;Logic:
                                ;Only '0' and '1' are allowed.
                                ;If invalid (e.g., '2', 'A'), jump to invalid_binary_char.
    jmp binary_valid            ;else it jumps into binary_valid

invalid_binary_char:
    ; Show error message
    mov ah, 09h
    lea dx, binErrorMsg         ;"Error: Not a binary number! Only 0 and 1 allowed."
    int 21h
    jmp binary_input_retry      ;Ask again

empty_binary_input:
    ; Handle empty input case
    mov ah, 09h
    lea dx, emptyInputMsg       ;"Error: No input received."
    int 21h
    jmp binary_input_retry      ;Ask again
    
    ;behavior:
    ;Prints an error and loops back to retry input.

binary_valid:
    ; Convert valid binary to number
    lea si, [inputBuffer+2]      ;Reset SI to start of input(point to first digit)
    mov ax, 0                    ;Clear AX (will hold result)
    mov cl, [inputBuffer+1]      ;Load input length
    mov ch, 0                    ;CX = loop counter
    
    ;registers:
    ;AX = Final number (starts at 0).
    ;CX = Number of digits to process.
    
convert_binary: 
    shl ax, 1               ;Shift AX left (multiply by 2)
    mov dl, [si]            ;Load next digit(ASCII)
    cmp dl, '1'             ;Is it '1'?
    jne skip_add            ;If not, skip
    or ax, 1                ;Set lowest bit if '1'(LSB)
skip_add:
    inc si                  ;Move to next digit
    loop convert_binary     ;Repeat until CX=0
    
    ;how convert works:
    ;shl ax, 1: Shifts AX left (e.g., 101 ? 1010).
    ;or ax, 1: If digit is '1', set the lowest bit.
    
    ;Example ("1010"):
    ;Iteration 1: AX = 0001 (1)
    ;Iteration 2: AX = 0010 (2)
    ;Iteration 3: AX = 0101 (5)
    ;Iteration 4: AX = 1010 (10)

    mov tempBuffer, ax      ;Save result in tempBuffer
    pop si                  ;Restore registers
    pop cx
    pop bx
    ret                     ;Return to caller
getBinaryNumber endp

getHexadecimalNumber proc
    push bx
    push cx
    push si

hex_input_retry:
    ; Display prompt
    mov ah, 09h
    lea dx, hexPrompt       ;Load address of "Enter hexadecimal number (up to 4 digits): $"
    int 21h                 ;Display prompt

    ; Read input
    mov ah, 0Ah             ;DOS buffered input function
    lea dx, inputBuffer     ;Load address of input buffer
    int 21h                 ;Read input

    ; Validate each character
    mov ch, 0
    mov cl, [inputBuffer+1] ; Length of input(Get input length)
    jcxz empty_hex_input    ; Handle empty input(If length = 0, handle empty input)
    lea si, [inputBuffer+2] ; Start of input(Point to start of input string)
    
    ;what it does:
    ;If user just presses Enter, jumps to empty_hex_input (shows error).

validate_hex:
    mov dl, [si]                           ;Load next char          
    ; Check if digit (0-9)
    cmp dl, '0'                            ;Check if < '0'
    jb invalid_hex_char                    ;? Error if not 0-9/A-F
    cmp dl, '9'                            ;Check if <= '9'
    jbe valid_hex_char                     ;? Valid if 0-9
    ; Check A-F (case insensitive)
    or dl, 20h                             ;Convert to lowercase(e.g., 'A' ? 'a')
    cmp dl, 'a'                            ;Check if < 'a'
    jb invalid_hex_char                    ;? Error
    cmp dl, 'f'                            ;Check if > 'f'
    ja invalid_hex_char                    ;? Error

valid_hex_char:
    inc si                                 ;Move to next char
    loop validate_hex                      ;Repeat for all chars
    jmp hex_valid                          ;else if all correct it jumps to hexa_valid

invalid_hex_char:
    ; Show error message
    mov ah, 09h
    lea dx, hexErrorMsg          ;"Error: Not a hexadecimal number! Only 0-9 and A-F allowed."
    int 21h
    jmp hex_input_retry          ;Ask again

empty_hex_input:
    ; Handle empty input case
    mov ah, 09h
    lea dx, emptyInputMsg        ;"Error: No input received."
    int 21h
    jmp hex_input_retry          ;Ask again

hex_valid:
    ; Convert valid hex to number
    lea si, [inputBuffer+2]      ;Reset SI to start of input
    mov ax, 0                    ;Clear AX (will hold result)
    mov cl, [inputBuffer+1]      ;Load input length
    mov ch, 0                    ;CX = loop counter
    
    ;registers:
    ;AX = Final number (starts at 0).
    ;CX = Number of digits to process.
    
convert_hex:
    mov dl, [si]          ;Load next digit
    cmp dl, '9'           ;Is it <= '9' (digit)?
    jbe digit_09          ;If yes, treat as 0-9
    or dl, 20h            ;Ensure lowercase(e.g., 'B' ? 'b')
    sub dl, 'a'-'0'-10    ; Convert a-f to 10-15

digit_09:
    sub dl, '0'           ;Convert ASCII to value (0-9)
    shl ax, 4             ;Shift left (multiply by 16)
    add al, dl            ;Add current digit
    inc si                ;Move to next digit
    loop convert_hex      ;Repeat until CX=0
    
    ;how conversion works:
     ;Digits (0-9): Subtract '0' to get value ('5' ? 5).
     ;Letters (A-F/a-f):
    ;Convert to lowercase ('B' ? 'b').
    ;Adjust to 10-15 ('b' ? 11).
     ;Shift and Add:
    ;shl ax, 4 shifts current value left by 4 bits (equivalent to multiplying by 16).
    ;add al, dl incorporates the new digit.
    
    ;Example ("1A3F"):
    ;Iteration 1: AX = 0001 (1)
    ;Iteration 2: AX = 001A (26)
    ;Iteration 3: AX = 01A3 (419)
    ;Iteration 4: AX = 1A3F (6719)
    

    mov tempBuffer, ax     ;Save result in tempBuffer
    pop si                 ;Restore registers
    pop cx
    pop bx
    ret                    ;Return to caller
    
    ;Example Walkthrough:
    ;User Input: "1A3F"
    ;Input Buffer: [17, 4, '1','A','3','F',...]
    ;Validation: All chars are valid hex digits.
    ;Conversion: AX = 0000 ? 0001 ? 001A ? 01A3 ? 1A3F (6719 in decimal)
    ;Result: tempBuffer = 6719 (0x1A3F).
getHexadecimalNumber endp

readDecimal proc
    mov ah, 0Ah               ;DOS function for buffered input
    lea dx, inputBuffer       ;Point to input buffer
    int 21h                   ;Call DOS to read input

    ; Convert to integer
    mov ch, 0                 ;Clear CH (upper byte of CX)
    mov cl, [inputBuffer+1]   ;CL = actual input length (e.g., 3 for "123")
    lea si, [inputBuffer+2]   ;SI points to first digit ('1')
    mov ax, 0                 ;Initialize result to 0
    mov bx, 10                ;Base 10 multiplier
    
    ;Registers:
    ;CX = Loop counter (input length)
    ;SI = Pointer to input digits
    ;AX = Accumulator for result (starts at 0)
    ;BX = Always 10 (for decimal conversion)

convertLoop:
    mul bx                ;AX = AX * 10
    mov dl, [si]          ;Load next ASCII digit
    sub dl, '0'           ;Convert ASCII to value (e.g., '3' ? 3)
    add ax, dx            ;Add digit to result
    inc si                ;Move to next digit
    loop convertLoop      ;Repeat until CX=0
    ret
    
    ;How it works (for input "123"):
      ;First digit '1':
    ;AX = 0 * 10 = 0
    ;DL = '1' - '0' = 1
    ;AX = 0 + 1 = 1

      ;Second digit '2':
    ;AX = 1 * 10 = 10
    ;DL = '2' - '0' = 2
    ;AX = 10 + 2 = 12

      ;Third digit '3':
    ;AX = 12 * 10 = 120
    ;DL = '3' - '0' = 3
    ;AX = 120 + 3 = 123
readDecimal endp

printDecimal proc
    push ax                     ;Save AX (contains number to print)
    mov ah, 09h                 ;DOS print-string function
    lea dx, decMsg              ;Load address of " Decimal: $"
    int 21h                     ;Print the prefix

    lea di, decBuffer+5         ;Point to end of buffer (5 bytes reserved)
    mov byte ptr [di], '$'      ; Add DOS string terminator
    pop ax                      ;Restore AX
    mov cx, 10                  ;Divisor (10 for decimal)

decConvert:
    dec di                      ;Move buffer pointer left
    xor dx, dx                  ;Clear DX (for division)
    div cx                      ;AX = AX/10, DX = remainder (digit)
    add dl, '0'                 ;Convert digit to ASCII (e.g., 5 ? '5')
    mov [di], dl                ;Store ASCII digit in buffer
    test ax, ax                 ;Check if AX == 0
    jnz decConvert              ;If not, keep dividing
    
    ;How conversion works (for AX = 123):
     ;First iteration:
    ;AX = 123, DX = 0 ? div cx ? AX = 12, DX = 3
    ;DL = '3' ? Store at decBuffer+4
    ;Buffer: [' ',' ',' ',' ','3','$']
     ;Second iteration:
    ;AX = 12, DX = 0 ? div cx ? AX = 1, DX = 2
    ;DL = '2' ? Store at decBuffer+3
    ;Buffer: [' ',' ',' ','2','3','$']
     ;Third iteration:
    ;AX = 1, DX = 0 ? div cx ? AX = 0, DX = 1
    ;DL = '1' ? Store at decBuffer+2
    ;Buffer: [' ',' ','1','2','3','$']
    
    ;Exit loop (AX = 0).

    mov ah, 09h         ;DOS print-string function
    mov dx, di          ;DX = start of number string
    int 21h             ;Print the decimal string
    ret
    
    ;What happens:
    ;Prints the ASCII string starting at DI.
    ;For AX = 123, prints "123".
    ;Final output: Decimal: 123
printDecimal endp

printBinary proc
    push ax                    ;Save AX (contains number to print)
    mov ah, 09h                ;DOS print-string function
    lea dx, binMsg             ;Load address of " Binary: $"
    int 21h                    ;Print the prefix

    lea di, binBuffer          ;Point to start of binary buffer
    pop ax                     ;Restore AX
    mov cx, 16                 ;Loop counter (16 bits to process)

binConvert:
    rol ax, 1                  ;Rotate left, MSB -> Carry Flag
    jc setOne                  ;If Carry Flag=1, jump to setOne
    mov byte ptr [di], '0'     ;Store '0'
    jmp nextBit
setOne:
    mov byte ptr [di], '1'     ;Store '1'
nextBit:
    inc di                     ;Move to next buffer position
    loop binConvert            ;Repeat for all 16 bits
    
    ;How conversion works (for AX = 0x00A5 = 10100101 in lower 8 bits):
      ;Bit 0: ROL AX,1 ? CF=1 ? Store '1'
    ;Buffer: ['1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','$']
      ;Bit 1: CF=0 ? Store '0'
    ;Buffer: ['1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','$']
      ;Bit 2: CF=1 ? Store '1'
    ;Buffer: ['1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','$']
      ;... (continues for all 16 bits)
    ;Final buffer for AX=0x00A5:
    ;['0','0','0','0','0','0','0','0','1','0','1','0','0','1','0','1','$']
    ;(Which prints as 0000000010100101)

    mov ah, 09h               ;DOS print-string function
    lea dx, binBuffer         ;Point to binary string
    int 21h                   ;Print the binary digits
    ret
printBinary endp

printHexadecimal proc
    push ax                     ;Save AX (contains number to print)
    mov ah, 09h                 ;DOS print-string function
    lea dx, hexMsg              ;Load address of " Hexadecimal: $"
    int 21h                     ;Print the prefix

    lea di, hexBuffer+3         ;Point to end of 4-byte buffer
    pop ax                      ;Restore AX
    mov cx, 4                   ;Loop counter (4 nibbles to process)

hexConvert:
    mov dx, ax                  ;Copy AX to DX
    and dx, 0Fh                 ;Isolate lowest 4 bits (nibble)
    cmp dl, 9                   ;Is nibble <= 9?
    jbe digit1                  ;If yes, treat as digit (0-9)
    add dl, 7                   ;Adjust for letters A-F (10-15 ? 'A'-'F')
digit1:
    add dl, '0'                 ;Convert to ASCII (0-9 ? '0'-'9', 10-15 ? 'A'-'F')
    mov [di], dl                ;Store ASCII character
    dec di                      ;Move buffer pointer left
    shr ax, 4                   ;Shift right to process next nibble
    loop hexConvert             ;Repeat for all 4 nibbles
    
    ;How conversion works (for AX = 0x1A3F):
      ;First nibble (LSB):
    ;DX = 0x1A3F & 0xF = 0xF (15)
    ;DL = 15 + 7 + '0' = 'F'
    ;Store at hexBuffer+3:
    ;['0','0','0','F','$']
      ;Second nibble:
    ;AX >>= 4 ? AX = 0x1A3
    ;DX = 0x3 ? DL = '3'
    ;Store at hexBuffer+2:
    ;['0','0','3','F','$']
      ;Third nibble:
    ;AX = 0x1A ? DX = 0xA (10) ? DL = 'A'
    ;Store at hexBuffer+1:
    ;['0','A','3','F','$']
      ;Fourth nibble (MSB):
    ;AX = 0x1 ? DX = 0x1 ? DL = '1'
    ;Store at hexBuffer+0:
    ;['1','A','3','F','$']

    mov ah, 09h           ; DOS print-string function
    lea dx, hexBuffer     ;Point to hex string
    int 21h               ;Print the hex digits
    ret
printHexadecimal endp

showPSW proc
    mov ah, 09h       
    lea dx, pswMsg    ; Display "PSW Flags:" message
    int 21h
    lea dx, newline   ; New line after "PSW Flags:"
    int 21h
    
    mov bx, flags     ; Load the saved flags into bx(Load flags saved after operation (from pushf/pop))
    ;The flags variable contains the 16-bit PSW register saved after an arithmetic operation.
    
    ; Display Carry Flag (CF)
    mov ah, 09h
    lea dx, [msg_carry]  ;"Carry Flag (CF): "
    int 21h
    mov dl, '0'          ; Default to '0' (CF = 0)
    test bx, 0001h       ; Test bit 0 (Carry Flag)
    jz print_cf          ; If CF = 0, skip
    mov dl, '1'          ; Otherwise show '1' (CF = 1)
print_cf:
    mov ah, 02h
    int 21h
    mov ah, 09h          ; New line after CF
    lea dx, newline
    int 21h
    
    ;Display Auxilary Flag (AF)
    mov ah, 09h
    lea dx, [msg_auxiliary]  ;"Auxiliary Flag (AF):"
    int 21h
    mov dl, '0'       ; Default to '0' (AF = 0)
    test bx, 0010h    ; Test bit 4 (Auxiliary Flag)
    jz print_af       ; If AF = 0, skip
    mov dl, '1'       ; Otherwise show '1' (AF = 1)
print_af:
    mov ah, 02h
    int 21h
    mov ah, 09h       ; New line after AF
    lea dx, newline
    int 21h
    
    ; Display Zero Flag (ZF)
    mov ah, 09h
    lea dx, [msg_zero]   ;"Zero Flag (ZF):"
    int 21h
    mov dl, '0'       ; Default to '0' (ZF = 0)
    test bx, 0040h    ; Test bit 6 (Zero Flag)
    jz print_zf       ; If ZF = 0, skip
    mov dl, '1'       ; Otherwise show '1' (ZF = 1)
print_zf:
    mov ah, 02h
    int 21h
    mov ah, 09h       ; New line after ZF
    lea dx, newline
    int 21h
    
    ; Display Sign Flag (SF)
    mov ah, 09h
    lea dx, [msg_sign]    ;"Sign Flag (SF):"
    int 21h
    mov dl, '0'       ; Default to '0' (SF = 0)
    test bx, 0080h    ; Test bit 7 (Sign Flag)
    jz print_sf       ; If SF = 0, skip
    mov dl, '1'       ; Otherwise show '1' (SF = 1)
print_sf:
    mov ah, 02h
    int 21h
    mov ah, 09h       ; New line after SF
    lea dx, newline
    int 21h
    
    ; Display Parity Flag (PF)
    mov ah, 09h
    lea dx, [msg_parity]    ;"Parity Flag (PF):"
    int 21h
    mov dl, '0'       ; Default to '0' (PF = 0)
    test bx, 0004h    ; Test bit 2 (Parity Flag)
    jz print_pf       ; If PF = 0, skip
    mov dl, '1'       ; Otherwise show '1' (PF = 1)
print_pf:
    mov ah, 02h
    int 21h
    mov ah, 09h       ; New line after PF
    lea dx, newline
    int 21h
    
    ; Display Overflow Flag (OF)
    mov ah, 09h
    lea dx, [msg_overflow]    ;"Overflow Flag (OF):"
    int 21h
    mov dl, '0'       ; Default to '0' (OF = 0)
    test bx, 0800h    ; Test bit 11 (Overflow Flag)
    jz print_of       ; If OF = 0, skip
    mov dl, '1'       ; Otherwise show '1' (OF = 1)
print_of:
    mov ah, 02h
    int 21h
    mov ah, 09h       ; New line after OF
    lea dx, newline
    int 21h
    
    ret  
showPSW endp
 
;===== Clear Screen Procedure =====
clearScreen proc
    push ax
    push bx
    push cx
    push dx
    
    ; Scroll entire window
    mov ax, 0600h  ; AH=06 (scroll), AL=00 (full screen)
    mov bh, 07h    ; Normal attribute
    mov cx, 0000h  ; Upper-left (0,0)
    mov dx, 184Fh  ; Lower-right (24,79)
    int 10h
    
    ; Reset cursor
    mov ah, 02h
    mov bh, 00h
    mov dx, 0000h
    int 10h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
clearScreen endp

exitProgram:
    mov ah, 4Ch
    int 21h
main endp
end main

;the end !