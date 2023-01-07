; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -instcombine-max-iterations=1 -S | FileCheck %s
; These tests check the optimizations specific to
; pointers being relocated at a statepoint.


declare i32* @fake_personality_function()
declare void @func()

define void @test(i32 addrspace(1)* %b) gc "statepoint-example" {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = getelementptr i32, i32 addrspace(1)* [[B:%.*]], i64 16
; CHECK-NEXT:    [[SAFEPOINT_TOKEN:%.*]] = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* nonnull elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i32 addrspace(1)* [[B]], i32 addrspace(1)* [[D]]) ]
; CHECK-NEXT:    [[B_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    [[B_NEW_2:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    [[D_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    [[D_NEW_2:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    [[D_NEW_3:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    [[D_NEW_4:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[B_NEW_1]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[B_NEW_2]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_1]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_2]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_3]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_4]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %d = getelementptr i32, i32 addrspace(1)* %b, i64 16
  %safepoint_token = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %b, i32 addrspace(1)* %b, i32 addrspace(1)* %d, i32 addrspace(1)* %d)]
  %b.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %b.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 1)
  %d.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 2)
  %d.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 3)
  %d.new.3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 2)
  %d.new.4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 3)
  store i32 1, i32 addrspace(1)* %b.new.1
  store i32 1, i32 addrspace(1)* %b.new.2
  store i32 1, i32 addrspace(1)* %d.new.1
  store i32 1, i32 addrspace(1)* %d.new.2
  store i32 1, i32 addrspace(1)* %d.new.3
  store i32 1, i32 addrspace(1)* %d.new.4
  ret void
}

define void @test_no_derived_use(i32 addrspace(1)* %b) gc "statepoint-example" {
; CHECK-LABEL: @test_no_derived_use(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SAFEPOINT_TOKEN:%.*]] = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* nonnull elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i32 addrspace(1)* [[B:%.*]]) ]
; CHECK-NEXT:    [[B_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[B_NEW_1]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %d = getelementptr i32, i32 addrspace(1)* %b, i64 16
  %safepoint_token = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %b, i32 addrspace(1)* %b, i32 addrspace(1)* %d, i32 addrspace(1)* %d)]
  %b.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %b.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 1)
  %d.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 2)
  %d.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 3)
  %d.new.3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 2)
  %d.new.4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 3)
  store i32 1, i32 addrspace(1)* %b.new.1
  ret void
}

define void @test_no_base_use(i32 addrspace(1)* %b) gc "statepoint-example" {
; CHECK-LABEL: @test_no_base_use(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = getelementptr i32, i32 addrspace(1)* [[B:%.*]], i64 16
; CHECK-NEXT:    [[SAFEPOINT_TOKEN:%.*]] = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* nonnull elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i32 addrspace(1)* [[B]], i32 addrspace(1)* [[D]]) ]
; CHECK-NEXT:    [[D_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_1]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %d = getelementptr i32, i32 addrspace(1)* %b, i64 16
  %safepoint_token = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %b, i32 addrspace(1)* %b, i32 addrspace(1)* %d, i32 addrspace(1)* %d)]
  %b.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %b.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 1)
  %d.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 2)
  %d.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 3)
  %d.new.3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 2)
  %d.new.4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 3)
  store i32 1, i32 addrspace(1)* %d.new.1
  ret void
}

define void @test_invoke(i32 addrspace(1)* %b) gc "statepoint-example" personality i32* ()* @fake_personality_function {
; CHECK-LABEL: @test_invoke(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = getelementptr i32, i32 addrspace(1)* [[B:%.*]], i64 16
; CHECK-NEXT:    [[SAFEPOINT_TOKEN:%.*]] = invoke token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* nonnull elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i32 addrspace(1)* [[B]], i32 addrspace(1)* [[D]]) ]
; CHECK-NEXT:    to label [[NORMAL_DEST:%.*]] unwind label [[UNWIND_DEST:%.*]]
; CHECK:       normal_dest:
; CHECK-NEXT:    [[B_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    [[B_NEW_2:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    [[D_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    [[D_NEW_2:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    [[D_NEW_3:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    [[D_NEW_4:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[B_NEW_1]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[B_NEW_2]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_1]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_2]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_3]], align 4
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_4]], align 4
; CHECK-NEXT:    ret void
; CHECK:       unwind_dest:
; CHECK-NEXT:    [[LPAD:%.*]] = landingpad token
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    [[LPB_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[LPAD]], i32 0, i32 0)
; CHECK-NEXT:    [[LPB_NEW_2:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[LPAD]], i32 0, i32 0)
; CHECK-NEXT:    [[LPD_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[LPAD]], i32 0, i32 1)
; CHECK-NEXT:    [[LPD_NEW_2:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[LPAD]], i32 0, i32 1)
; CHECK-NEXT:    [[LPD_NEW_3:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[LPAD]], i32 0, i32 1)
; CHECK-NEXT:    [[LPD_NEW_4:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[LPAD]], i32 0, i32 1)
; CHECK-NEXT:    store i32 2, i32 addrspace(1)* [[LPB_NEW_1]], align 4
; CHECK-NEXT:    store i32 2, i32 addrspace(1)* [[LPB_NEW_2]], align 4
; CHECK-NEXT:    store i32 2, i32 addrspace(1)* [[LPD_NEW_1]], align 4
; CHECK-NEXT:    store i32 2, i32 addrspace(1)* [[LPD_NEW_2]], align 4
; CHECK-NEXT:    store i32 2, i32 addrspace(1)* [[LPD_NEW_3]], align 4
; CHECK-NEXT:    store i32 2, i32 addrspace(1)* [[LPD_NEW_4]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %d = getelementptr i32, i32 addrspace(1)* %b, i64 16
  %safepoint_token = invoke token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %b, i32 addrspace(1)* %b, i32 addrspace(1)* %d, i32 addrspace(1)* %d)]
  to label %normal_dest unwind label %unwind_dest

normal_dest:
  %b.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %b.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 1)
  %d.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 2)
  %d.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 3)
  %d.new.3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 2)
  %d.new.4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 3)
  store i32 1, i32 addrspace(1)* %b.new.1
  store i32 1, i32 addrspace(1)* %b.new.2
  store i32 1, i32 addrspace(1)* %d.new.1
  store i32 1, i32 addrspace(1)* %d.new.2
  store i32 1, i32 addrspace(1)* %d.new.3
  store i32 1, i32 addrspace(1)* %d.new.4
  ret void

unwind_dest:
  %lpad = landingpad token
  cleanup
  %lpb.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 0)
  %lpb.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 1)
  %lpd.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 2)
  %lpd.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 3)
  %lpd.new.3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 1, i32 2)
  %lpd.new.4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 1, i32 3)
  store i32 2, i32 addrspace(1)* %lpb.new.1
  store i32 2, i32 addrspace(1)* %lpb.new.2
  store i32 2, i32 addrspace(1)* %lpd.new.1
  store i32 2, i32 addrspace(1)* %lpd.new.2
  store i32 2, i32 addrspace(1)* %lpd.new.3
  store i32 2, i32 addrspace(1)* %lpd.new.4
  ret void
}

define void @test_no_derived_use_invoke(i32 addrspace(1)* %b) gc "statepoint-example" personality i32* ()* @fake_personality_function {
; CHECK-LABEL: @test_no_derived_use_invoke(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SAFEPOINT_TOKEN:%.*]] = invoke token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* nonnull elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i32 addrspace(1)* [[B:%.*]]) ]
; CHECK-NEXT:    to label [[NORMAL_DEST:%.*]] unwind label [[UNWIND_DEST:%.*]]
; CHECK:       normal_dest:
; CHECK-NEXT:    [[B_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[B_NEW_1]], align 4
; CHECK-NEXT:    ret void
; CHECK:       unwind_dest:
; CHECK-NEXT:    [[LPAD:%.*]] = landingpad token
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    [[LPB_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[LPAD]], i32 0, i32 0)
; CHECK-NEXT:    store i32 2, i32 addrspace(1)* [[LPB_NEW_1]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %d = getelementptr i32, i32 addrspace(1)* %b, i64 16
  %safepoint_token = invoke token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %b, i32 addrspace(1)* %b, i32 addrspace(1)* %d, i32 addrspace(1)* %d)]
  to label %normal_dest unwind label %unwind_dest

normal_dest:
  %b.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %b.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 1)
  %d.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 2)
  %d.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 3)
  %d.new.3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 2)
  %d.new.4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 3)
  store i32 1, i32 addrspace(1)* %b.new.1
  ret void

unwind_dest:
  %lpad = landingpad token
  cleanup
  %lpb.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 0)
  %lpb.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 1)
  %lpd.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 2)
  %lpd.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 3)
  %lpd.new.3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 1, i32 2)
  %lpd.new.4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 1, i32 3)
  store i32 2, i32 addrspace(1)* %lpb.new.1
  ret void
}

define void @test_no_base_use_invoke(i32 addrspace(1)* %b) gc "statepoint-example" personality i32* ()* @fake_personality_function {
; CHECK-LABEL: @test_no_base_use_invoke(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[D:%.*]] = getelementptr i32, i32 addrspace(1)* [[B:%.*]], i64 16
; CHECK-NEXT:    [[SAFEPOINT_TOKEN:%.*]] = invoke token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* nonnull elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i32 addrspace(1)* [[B]], i32 addrspace(1)* [[D]]) ]
; CHECK-NEXT:    to label [[NORMAL_DEST:%.*]] unwind label [[UNWIND_DEST:%.*]]
; CHECK:       normal_dest:
; CHECK-NEXT:    [[D_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[SAFEPOINT_TOKEN]], i32 0, i32 1)
; CHECK-NEXT:    store i32 1, i32 addrspace(1)* [[D_NEW_1]], align 4
; CHECK-NEXT:    ret void
; CHECK:       unwind_dest:
; CHECK-NEXT:    [[LPAD:%.*]] = landingpad token
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    [[LPD_NEW_1:%.*]] = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token [[LPAD]], i32 0, i32 1)
; CHECK-NEXT:    store i32 2, i32 addrspace(1)* [[LPD_NEW_1]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %d = getelementptr i32, i32 addrspace(1)* %b, i64 16
  %safepoint_token = invoke token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* elementtype(void ()) @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %b, i32 addrspace(1)* %b, i32 addrspace(1)* %d, i32 addrspace(1)* %d)]
  to label %normal_dest unwind label %unwind_dest

normal_dest:
  %b.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %b.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 1)
  %d.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 2)
  %d.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 3)
  %d.new.3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 2)
  %d.new.4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 3)
  store i32 1, i32 addrspace(1)* %d.new.1
  ret void

unwind_dest:
  %lpad = landingpad token
  cleanup
  %lpb.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 0)
  %lpb.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 1)
  %lpd.new.1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 2)
  %lpd.new.2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 0, i32 3)
  %lpd.new.3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 1, i32 2)
  %lpd.new.4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %lpad,  i32 1, i32 3)
  store i32 2, i32 addrspace(1)* %lpd.new.1
  ret void
}

declare token @llvm.experimental.gc.statepoint.p0f_isVoidf(i64, i32, void ()*, i32, i32, ...)
declare i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token, i32, i32)