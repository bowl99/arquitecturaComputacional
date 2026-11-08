<<<<<<< HEAD
<<<<<<< Updated upstream
# Compila y corre los ejemplos de esta presentacion con Verilator,
=======
# Compilen y corran los ejemplos de esta presentacion con Verilator,
>>>>>>> upstream/main
# generando ondas para verlas con Surfer.
#
# Uso:
#   make adders       - compila y corre half/full/ripple_carry_adder (adders/)
#   make wave-adders  - corre adders y abre adders/adders_tb.fst en Surfer
#   make view         - abre adders/waveform.fst incluido, sin simular
#   make alu8         - compila y corre alu8_tb (alu8/), reporta PASS/FAIL
#   make wave-alu8    - corre alu8 y abre alu8/alu8_tb.vcd en Surfer
#   make view-alu8    - abre alu8/waveform.vcd incluido, sin simular
<<<<<<< HEAD
=======
#   make core-min     - compila y corre core_min_tb: nucleo RV32I minimo (add/sub/addi)
#   make wave-core-min   - corre core-min y abre la onda en Surfer
#   make view-core-min   - abre core_min/waveform.fst incluido, sin simular
#   make core-min2-alu     - ALU completa (R-type + I-type, 19 operaciones)
#   make core-min2-branch  - los 6 branches, taken + not-taken
#   make core-min2-jump    - jal/jalr (llamada+retorno, lazo hacia atras)
#   make core-min2-all     - corre los 3 anteriores en secuencia
#   make wave-core-min2         - alias de wave-core-min2-jump (default)
#   make wave-core-min2-alu     - corre core-min2-alu y abre la onda en Surfer
#   make wave-core-min2-branch  - corre core-min2-branch y abre la onda en Surfer
#   make wave-core-min2-jump    - corre core-min2-jump y abre la onda en Surfer
#   make view-core-min2-alu     - abre waveform_alu.fst incluido, sin simular
#   make view-core-min2-branch  - abre waveform_branch.fst incluido, sin simular
#   make view-core-min2-jump    - abre waveform_jump.fst incluido, sin simular
>>>>>>> upstream/main
#   make clean        - borra binarios y ondas generadas
#
# Nota: el proyecto vive bajo una ruta con espacios (iCloud Drive), y el
# Makefile que genera Verilator internamente no soporta eso -- por eso
# --Mdir apunta fuera de esta carpeta, a $(BUILD_DIR).

BUILD_DIR  := $(HOME)/verilator_builds
LZ4_PREFIX := /opt/homebrew/opt/lz4

<<<<<<< HEAD
ADDERS_DIR := adders
ALU8_DIR   := alu8
=======
ADDERS_DIR    := adders
ALU8_DIR      := alu8
CORE_MIN_DIR  := core_min
CORE_MIN2_DIR := core_min2
>>>>>>> upstream/main

VLFLAGS := --binary --timing -sv --trace-fst \
           -Wno-IEEEMAYDEPRECATE -Wno-TIMESCALEMOD -Wno-WIDTHTRUNC -Wno-WIDTHEXPAND \
           -Wno-CASEINCOMPLETE -Wno-LATCH -Wno-UNOPTFLAT \
           -CFLAGS "-I$(LZ4_PREFIX)/include" -LDFLAGS "-L$(LZ4_PREFIX)/lib -llz4"

# alu8/ es Verilog puro (sin SystemVerilog), por eso no lleva -sv: asi
# el flujo de compilacion valida lo mismo que exige Silicluster v3.
ALU8_VLFLAGS := --binary --timing --trace-fst \
           -Wno-IEEEMAYDEPRECATE -Wno-TIMESCALEMOD -Wno-WIDTHTRUNC -Wno-WIDTHEXPAND \
           -Wno-CASEINCOMPLETE -Wno-LATCH -Wno-UNOPTFLAT \
           -CFLAGS "-I$(LZ4_PREFIX)/include" -LDFLAGS "-L$(LZ4_PREFIX)/lib -llz4"

ADDERS_SRCS := $(ADDERS_DIR)/half_adder.sv $(ADDERS_DIR)/full_adder.sv \
               $(ADDERS_DIR)/ripple_carry_adder.sv $(ADDERS_DIR)/adders_tb.sv
ALU8_SRCS   := $(ALU8_DIR)/alu8.v $(ALU8_DIR)/alu8_tb.v

<<<<<<< HEAD
.PHONY: adders wave-adders view alu8 wave-alu8 view-alu8 clean
=======
CORE_MIN_SRCS   := $(CORE_MIN_DIR)/risc_v_32_i_pkg.sv $(CORE_MIN_DIR)/ArithmeticLogicUnit.sv \
                    $(CORE_MIN_DIR)/ImmediateSignExtend.sv $(CORE_MIN_DIR)/RegisterFile.sv \
                    $(CORE_MIN_DIR)/CoreControlUnit_min.sv $(CORE_MIN_DIR)/InstructionMemory_min.sv \
                    $(CORE_MIN_DIR)/ProcessorCoreMin.sv $(CORE_MIN_DIR)/core_min_tb.sv

# Modulos comunes de core_min2: extiende core_min con la ALU completa
# (R-type + I-type), ComparatorUnit (branches + slt/sltu/slti/sltiu) y
# el salto (jal/jalr). Sin memoria de datos ni lui/auipc todavia.
CORE_MIN2_COMMON := $(CORE_MIN2_DIR)/risc_v_32_i_pkg.sv $(CORE_MIN2_DIR)/ArithmeticLogicUnit.sv \
                     $(CORE_MIN2_DIR)/ImmediateSignExtend.sv $(CORE_MIN2_DIR)/RegisterFile.sv \
                     $(CORE_MIN2_DIR)/ComparatorUnit.sv $(CORE_MIN2_DIR)/CoreControlUnit_min2.sv \
                     $(CORE_MIN2_DIR)/InstructionMemory_min2.sv $(CORE_MIN2_DIR)/ProcessorCoreMin2.sv

.PHONY: adders wave-adders view alu8 wave-alu8 view-alu8 \
        core-min wave-core-min view-core-min \
        core-min2-alu core-min2-branch core-min2-jump core-min2-all \
        wave-core-min2 wave-core-min2-alu wave-core-min2-branch wave-core-min2-jump \
        view-core-min2-alu view-core-min2-branch view-core-min2-jump clean
>>>>>>> upstream/main

adders:
	verilator $(VLFLAGS) --top-module adders_tb --Mdir $(BUILD_DIR)/adders_tb $(ADDERS_SRCS) -o sim_adders_tb
	cd $(ADDERS_DIR) && $(BUILD_DIR)/adders_tb/sim_adders_tb

wave-adders: adders
	surfer $(ADDERS_DIR)/adders_tb.fst

view-adders:
	surfer $(ADDERS_DIR)/waveform.fst

alu8:
	verilator $(ALU8_VLFLAGS) --top-module alu8_tb --Mdir $(BUILD_DIR)/alu8_tb $(ALU8_SRCS) -o sim_alu8_tb
	cd $(ALU8_DIR) && $(BUILD_DIR)/alu8_tb/sim_alu8_tb

wave-alu8: alu8
	surfer $(ALU8_DIR)/alu8_tb.vcd

view-alu8:
	surfer $(ALU8_DIR)/waveform.vcd

<<<<<<< HEAD
clean:
	rm -rf $(BUILD_DIR)/adders_tb $(BUILD_DIR)/alu8_tb \
	       $(ADDERS_DIR)/adders_tb.fst $(ALU8_DIR)/alu8_tb.fst $(ALU8_DIR)/alu8_tb.vcd
=======
# Compila y corre el ejemplo de esta presentacion con Verilator,
# generando ondas .fst para verlas con Surfer.
#
# Uso:
#   make adders       - compila y corre half/full/ripple_carry_adder
#   make wave-adders  - corre adders y abre adders_tb.fst en Surfer
#   make view         - abre el waveform.fst incluido, sin simular
#   make clean        - borra binarios y ondas generadas
#
# Nota: el proyecto vive bajo una ruta con espacios (iCloud Drive), y el
# Makefile que genera Verilator internamente no soporta eso -- por eso
# --Mdir apunta fuera de esta carpeta, a $(BUILD_DIR).

BUILD_DIR  := $(HOME)/verilator_builds
LZ4_PREFIX := /opt/homebrew/opt/lz4

VLFLAGS := --binary --timing -sv --trace-fst \
           -Wno-IEEEMAYDEPRECATE -Wno-TIMESCALEMOD -Wno-WIDTHTRUNC -Wno-WIDTHEXPAND \
           -Wno-CASEINCOMPLETE -Wno-LATCH -Wno-UNOPTFLAT \
           -CFLAGS "-I$(LZ4_PREFIX)/include" -LDFLAGS "-L$(LZ4_PREFIX)/lib -llz4"

ADDERS_SRCS := half_adder.sv full_adder.sv ripple_carry_adder.sv adders_tb.sv

.PHONY: adders wave-adders view clean

adders:
	verilator $(VLFLAGS) --top-module adders_tb --Mdir $(BUILD_DIR)/adders_tb $(ADDERS_SRCS) -o sim_adders_tb
	$(BUILD_DIR)/adders_tb/sim_adders_tb

wave-adders: adders
	surfer adders_tb.fst

view:
	surfer waveform.fst

clean:
	rm -rf $(BUILD_DIR)/adders_tb *.fst
>>>>>>> Stashed changes
=======
core-min:
	verilator $(VLFLAGS) --top-module core_min_tb --Mdir $(BUILD_DIR)/core_min_tb $(CORE_MIN_SRCS) -o sim_core_min_tb
	cd $(CORE_MIN_DIR) && $(BUILD_DIR)/core_min_tb/sim_core_min_tb

wave-core-min: core-min
	surfer $(CORE_MIN_DIR)/core_min_tb.fst

view-core-min:
	surfer $(CORE_MIN_DIR)/waveform.fst

core-min2-alu:
	verilator $(VLFLAGS) --top-module core_min2_alu_tb --Mdir $(BUILD_DIR)/core_min2_alu_tb \
	          $(CORE_MIN2_COMMON) $(CORE_MIN2_DIR)/core_min2_alu_tb.sv -o sim_core_min2_alu_tb
	cd $(CORE_MIN2_DIR) && $(BUILD_DIR)/core_min2_alu_tb/sim_core_min2_alu_tb

core-min2-branch:
	verilator $(VLFLAGS) --top-module core_min2_branch_tb --Mdir $(BUILD_DIR)/core_min2_branch_tb \
	          $(CORE_MIN2_COMMON) $(CORE_MIN2_DIR)/core_min2_branch_tb.sv -o sim_core_min2_branch_tb
	cd $(CORE_MIN2_DIR) && $(BUILD_DIR)/core_min2_branch_tb/sim_core_min2_branch_tb

core-min2-jump:
	verilator $(VLFLAGS) --top-module core_min2_jump_tb --Mdir $(BUILD_DIR)/core_min2_jump_tb \
	          $(CORE_MIN2_COMMON) $(CORE_MIN2_DIR)/core_min2_jump_tb.sv -o sim_core_min2_jump_tb
	cd $(CORE_MIN2_DIR) && $(BUILD_DIR)/core_min2_jump_tb/sim_core_min2_jump_tb

wave-core-min2: wave-core-min2-jump

wave-core-min2-alu: core-min2-alu
	surfer $(CORE_MIN2_DIR)/core_min2_alu_tb.fst

wave-core-min2-branch: core-min2-branch
	surfer $(CORE_MIN2_DIR)/core_min2_branch_tb.fst

wave-core-min2-jump: core-min2-jump
	surfer $(CORE_MIN2_DIR)/core_min2_jump_tb.fst

view-core-min2-alu:
	surfer $(CORE_MIN2_DIR)/waveform_alu.fst

view-core-min2-branch:
	surfer $(CORE_MIN2_DIR)/waveform_branch.fst

view-core-min2-jump:
	surfer $(CORE_MIN2_DIR)/waveform_jump.fst

core-min2-all: core-min2-alu core-min2-branch core-min2-jump

clean:
	rm -rf $(BUILD_DIR)/adders_tb $(BUILD_DIR)/alu8_tb $(BUILD_DIR)/core_min_tb \
	       $(BUILD_DIR)/core_min2_alu_tb $(BUILD_DIR)/core_min2_branch_tb $(BUILD_DIR)/core_min2_jump_tb \
	       $(ADDERS_DIR)/adders_tb.fst $(ALU8_DIR)/alu8_tb.fst $(ALU8_DIR)/alu8_tb.vcd \
	       $(CORE_MIN_DIR)/core_min_tb.fst \
	       $(CORE_MIN2_DIR)/core_min2_alu_tb.fst $(CORE_MIN2_DIR)/core_min2_branch_tb.fst \
	       $(CORE_MIN2_DIR)/core_min2_jump_tb.fst
>>>>>>> upstream/main
