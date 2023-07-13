`timescale 1ns / 1ps

module Next_pc (
    input [31:0] PC,
    input [31:0] instruction,
    input jump_or_not,
    input Branch,
    input not_eq,
    input zero,
    output reg [31:0] nextPC
);

  reg [31:0] sign_ext;
  reg [31:0] old_alter;  // pc+4
  reg [31:0] jump;  // jump addr.
  reg zero_alter;

  initial begin
    nextPC = 32'b0;
  end

  always @(PC) begin
    old_alter = PC + 4;
  end

  always @(zero, not_eq) begin
    zero_alter = zero;
    if (not_eq == 1) begin
      zero_alter = !zero_alter;
    end
  end

  always @(instruction) begin
    // jump-shift-left
    jump = {4'b0, instruction[25:0], 2'b0};

    // sign-extension
    if (instruction[15] == 1'b0) begin
      sign_ext = {16'b0, instruction[15:0]};
    end else begin
      sign_ext = {{16{1'b1}}, instruction[15:0]};
    end
    sign_ext = {sign_ext[29:0], 2'b0};  // shift left
  end

  always @(instruction or old_alter or jump) begin
    jump = {old_alter[31:28], jump[27:0]};
  end

  always @(old_alter, sign_ext, jump, Branch, zero_alter, jump_or_not) begin
    // assign next program counter value
    if (Branch == 1 & zero_alter == 1) begin
      nextPC = old_alter + sign_ext;
    end else begin
      nextPC = old_alter;
    end
    if (jump_or_not == 1) begin
      nextPC = jump;
    end
  end

endmodule