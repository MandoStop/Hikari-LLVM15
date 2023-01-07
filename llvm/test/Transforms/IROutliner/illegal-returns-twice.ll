; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -verify -iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; This test checks that we do not outline functions that are marked as returns
; twice, since these can alter the frame of the function and affect how the
; outliner behaves, causing miscompiles.

; Function Attrs: optsize returns_twice
declare i32 @setjmp(i32*) local_unnamed_addr #1
@tmp_jmpb = global [37 x i32] zeroinitializer, align 16

define void @function1() {
; CHECK-LABEL: @function1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 2, i32* [[A]], align 4
; CHECK-NEXT:    store i32 3, i32* [[B]], align 4
; CHECK-NEXT:    store i32 4, i32* [[C]], align 4
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @setjmp(i32* getelementptr inbounds ([37 x i32], [37 x i32]* @tmp_jmpb, i64 0, i64 0))
; CHECK-NEXT:    call void @outlined_ir_func_0(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  store i32 4, i32* %c, align 4
  %call = call i32 @setjmp(i32* getelementptr inbounds ([37 x i32], [37 x i32]* @tmp_jmpb, i64 0, i64 0))
  %al = load i32, i32* %a
  %bl = load i32, i32* %b
  %cl = load i32, i32* %c
  ret void
}

define void @function2() {
; CHECK-LABEL: @function2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 2, i32* [[A]], align 4
; CHECK-NEXT:    store i32 3, i32* [[B]], align 4
; CHECK-NEXT:    store i32 4, i32* [[C]], align 4
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @setjmp(i32* getelementptr inbounds ([37 x i32], [37 x i32]* @tmp_jmpb, i64 0, i64 0))
; CHECK-NEXT:    call void @outlined_ir_func_0(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  store i32 4, i32* %c, align 4
  %call = call i32 @setjmp(i32* getelementptr inbounds ([37 x i32], [37 x i32]* @tmp_jmpb, i64 0, i64 0))
  %al = load i32, i32* %a
  %bl = load i32, i32* %b
  %cl = load i32, i32* %c
  ret void
}

attributes #1 = { optsize returns_twice }