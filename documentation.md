# Documentation #

## Components:

![Top Level Diagram](top_diagram.PNG "Top Level Diagram")

# Arithmetic Logic Unit #

Performs logical and arithmetic operations on data. Operation specified by the control unit.

| **Input/Output** | **Description** |
| --- | --- |
| **data\_in\_A** | 64-bit data value, comes from register |
| **data\_in\_B** | 64-bit data value, comes from register or immediate generator |
| **data\_out** | 64-bit data value, either goes to register file or data memory address input |
| **zero** | flag for when the result of an operation was zero, used by the program counter for **beq** |
| **ALU\_ctrl** | 3-bit control signal from ALU controller, tells the ALU which of the four operations to perform |

[Arithmetic Logic Unit Source](../source/components/ALU)

# Clock Divider #

Reduces frequency of an input clock by a divisor.

[Clock Divider Source](../source/components/clock_divider)

# Control Unit #

Coordinates all the main components of the processor by sending control signals. Operation is based on opcodes from instruction memory.

| **Input/Output** | **Description** |
| --- | --- |
| **opcode** | 7-bit opcode field |
| **ctrl\_ALU\_op** | 2-bit control signal, tells ALU controller what type of operation needs to be executed |
| **ctrl\_ALU\_src** | control signal, if 1 then the second ALU input comes from the immediate generator, if 0 then it comes from register file |
| **ctrl\_reg\_w** | control signal, write enable for register file |
| **ctrl\_mem\_w** | control signal, write enable for data memory |
| **ctrl\_mem\_r** | control signal, read enable for data memory |
| **ctrl\_mem\_to\_reg** | control signal, if 1 then register file write input comes from data memory, if 0 then it comes from the ALU |
| **ctrl\_branch** | control signal, tells program counter if branch instruction is being executed |

[Control Unit Source](../source/components/control_unit)

# Data Memory #

Stores data for program and generated by program. Has a flashable ROM segment.

| **Input/Output** | **Description** |
| --- | --- |
| **clk** | 100 MHz processor clock, only used for synchronous writing |
| **rst** | Asynchronous reset, wipes all RAM cells to default 0 value. |
| **w\_data** | 64-bit wide synchronous write data input |
| **r\_data** | 64-bit wide asynchronous read data output |
| **address** | n-bit wide address input for write register |
| **ctrl\_mem\_w** | control signal for write enable |
| **ctrl\_mem\_r** | control signal for read enable |

[Data Memory Source](../source/components/data_memory)

# Immediate Generator # 

Converts the immediate fields of an instruction into a 64-bit offset.

[Immediate Generator Source](../source/components/imm_generator)

# Instruction Memory #

Contains all instructions that make up the program. Flashable ROM.

[Instruction Memory Source](../source/components/instruction_memory)

# Program Counter #

Contains the instruction memory address of the current instruction being executed. Loadable if a branch instruction is executed.

| **Input/Output** | **Description** |
| --- | --- |
| **clk** | 100 MHz processor clock, used for incrementing or loading program counter |
| **rst** | Asynchronous reset, wipes program counter for 0. |
| **ALU\_zero\_flag** | Zero flag that comes from ALU, used for **beq** |
| **offset** | n-bit offset, gets added to instruction address during **beq** |
| **ctrl\_branch** | control signal, used to show **beq** is being executed |
| **instruction\_address** | output of program counter, instruction address of instruction being executed |

[Program Counter Source](../source/components/program_counter)

# Register File # 

Block of memory that contains 32 general-purpose registers. Initialised to 0 on startup.

| **Input/Output** | **Description** |
| --- | --- |
| **clk** | 100 MHz processor clock, only used for synchronous writing |
| **rst** | Asynchronous reset, wipes all registers to default 0 value. |
| **reg\_num\_r0** | 5-bit wide address input for first read register |
| **reg\_num\_r1** | 5-bit wide address input for second read register |
| **reg\_num\_w** | 5-bit wide address input for write register |
| **r\_data\_0** | 64-bit wide data output for first read register |
| **r\_data\_1** | 64-bit wide data output for second read register |
| **w\_data** | 64-bit wide data input for write register |
| **ctrl\_reg\_w** | control signal from control unit, write enable |
| **debug** | 16-bit wide debug output, tied to the least significant 16 bits of register #31 |

[Register File Source](../source/components/register_file)