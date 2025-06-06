# Assembly Calculator Project
## Overview
This project is an Assembly language program developed for the 8086 microprocessor using the DOS operating system. It implements a calculator with two main modes: Calculator Mode and Conversion Mode. The calculator supports arithmetic and logical operations (addition, subtraction, multiplication, division, XOR, OR, AND) in decimal, binary, and hexadecimal formats. The conversion mode allows for number base conversions between decimal, binary, and hexadecimal.
The program features a user-friendly menu-driven interface, input validation, and displays results in all three number formats (decimal, binary, hexadecimal) along with the Processor Status Word (PSW) flags after each operation.


## Features
### Calculator Mode

### Input Types:
- Decimal Mode: Accepts decimal numbers (0-65535).
- Binary Mode: Accepts binary numbers (up to 16 bits).
- Hexadecimal Mode: Accepts hexadecimal numbers (up to 4 digits, 0-FFFF).


### Operations:
- Addition
- Subtraction
- Multiplication
- Division (with division-by-zero error handling)
- Logical operations: XOR, OR, AND


### Output:
- Results displayed in decimal, binary, and hexadecimal formats.
- Processor Status Word (PSW) flags displayed (Carry, Zero, Sign, Parity, Overflow, Auxiliary).


### Input Validation:
- Ensures valid input for each mode (e.g., only 0-1 for binary, 0-9/A-F for hexadecimal).
- Handles empty input and invalid characters with appropriate error messages.



### Conversion Mode

### Converts numbers between different bases:
- Decimal to Binary
- Decimal to Hexadecimal
- Binary to Decimal
- Binary to Hexadecimal
- Hexadecimal to Decimal
- Hexadecimal to Binary


Supports up to 16-bit numbers (0-65535 in decimal, 0-FFFF in hexadecimal).

## Requirements

### Assembler: 
MASM (Microsoft Macro Assembler) or compatible assembler (e.g., TASM).
### Environment: 
DOS-based operating system or a DOS emulator (e.g., DOSBox).
### Hardware: 
8086-compatible processor (emulated or physical).

## File Structure

calcul.asm: The main Assembly source code file containing the program logic, menus, and procedures for calculations and conversions.

## How to Run

### Assemble the Code:
- Use MASM to assemble the source code:

```bash
masm calcul.asm;
```


- This generates an object file (calcul.obj).


### Link the Object File:
- Link the object file to create an executable:

```bash
link calcul.obj;
```


- This produces calcul.exe.


### Run the Program:
- In a DOS environment or DOSBox, execute:

```bash
calcul.exe
```



### Navigate the Program:
The program starts with a main menu offering three options:
1. Calculator Mode: Select the input type (decimal, binary, or hexadecimal) and then choose an operation.
2. Conversion Mode: Select the desired conversion type and enter a number.
3. Exit: Terminates the program.


- Follow the prompts to input numbers and select operations.
- Results are displayed in all three formats, along with PSW flags for calculator operations.



## Usage Notes

### Input Limits:
- Decimal inputs: 0 to 65535.
- Binary inputs: Up to 16 bits (e.g., 1010101010101010).
- Hexadecimal inputs: Up to 4 digits (e.g., FFFF).


### Error Handling:
- Invalid inputs (e.g., non-binary digits in binary mode) trigger error messages and prompt for re-entry.
- Division by zero in calculator mode displays an error and returns to the menu.


### Screen Clearing: 
The program clears the screen between menu displays for a clean interface.
### PSW Flags: 
After each calculator operation, the program displays the state of the Carry, Zero, Sign, Parity, Overflow, and Auxiliary flags.

## Example Usage

- Calculator Mode (Decimal):

Select 1 from the main menu.
Select 1 for Decimal Mode.
Select 1 for Addition.
Enter first number (e.g., 123).
Enter second number (e.g., 456).
Output: Result in decimal (579), binary (0000001001000011), hexadecimal (0243), and PSW flags.


- Conversion Mode (Decimal to Binary):

Select 2 from the main menu.
Select 1 for Decimal to Binary.
Enter decimal number (e.g., 42).
Output: Binary (0000000000101010).



## Limitations

The program supports 16-bit unsigned integers (0-65535).
No support for negative numbers or floating-point arithmetic.
Input validation assumes ASCII input; non-standard input may cause unexpected behavior.
The program is designed for a DOS environment and may not run natively on modern operating systems without an emulator.

## Future Improvements

- Add support for negative numbers using signed arithmetic.
- Implement floating-point operations.
- Enhance the user interface with color or graphical elements (if supported by the environment).
- Add support for larger numbers (e.g., 32-bit operations).

## License
This project is for educational purposes and is not licensed for commercial use. Feel free to modify and use it for learning Assembly programming.


## Contact
For questions or contributions, please contact the project author via their academic institution or relevant channels.

