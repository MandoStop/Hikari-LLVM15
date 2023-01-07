; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=sroa %s | FileCheck %s

; SROA should keep `!tbaa.struct` metadata

%vector = type { float, float }
declare void @llvm.memcpy.p0.p0.i64(ptr writeonly, ptr readonly, i64, i1 immarg)
declare <2 x float> @foo(ptr %0)

define void @bar(ptr %y2) {
; CHECK-LABEL: @bar(
; CHECK-NEXT:    [[X14:%.*]] = call <2 x float> @foo(ptr [[Y2:%.*]])
; CHECK-NEXT:    store <2 x float> [[X14]], ptr [[Y2]], align 4, !tbaa.struct !0
; CHECK-NEXT:    ret void
;
  %x7 = alloca %vector
  %x14 = call <2 x float> @foo(ptr %y2)
  store <2 x float> %x14, ptr %x7
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %y2, ptr align 4 %x7, i64 8, i1 false), !tbaa.struct !10
  ret void
}

!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!7 = !{!"vector", !8, i64 0, !8, i64 4}
!8 = !{!"float", !4, i64 0}
!10 = !{i64 0, i64 4, !11, i64 4, i64 4, !11}
!11 = !{!8, !8, i64 0}