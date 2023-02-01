; ModuleID = 'binary_search.c'
source_filename = "binary_search.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.1 = private unnamed_addr constant [29 x i8] c"\0AElement is present here: %d\00", align 1

; Function Attrs: nofree nosync nounwind memory(argmem: read) uwtable
define dso_local i32 @binarySearch(ptr noundef readonly %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = icmp slt i32 %2, %1
  br i1 %5, label %26, label %6

6:                                                ; preds = %4, %23
  %7 = phi i32 [ %10, %23 ], [ %2, %4 ]
  %8 = phi i32 [ %24, %23 ], [ %1, %4 ]
  br label %9

9:                                                ; preds = %6, %20
  %10 = phi i32 [ %7, %6 ], [ %21, %20 ]
  %11 = sub nsw i32 %10, %8
  %12 = sdiv i32 %11, 2
  %13 = add nsw i32 %12, %8
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds i32, ptr %0, i64 %14
  %16 = load i32, ptr %15, align 4, !tbaa !5
  %17 = icmp eq i32 %16, %3
  br i1 %17, label %26, label %18

18:                                               ; preds = %9
  %19 = icmp sgt i32 %16, %3
  br i1 %19, label %20, label %23

20:                                               ; preds = %18
  %21 = add nsw i32 %13, -1
  %22 = icmp sgt i32 %11, 1
  br i1 %22, label %9, label %26

23:                                               ; preds = %18
  %24 = add nsw i32 %13, 1
  %25 = icmp sgt i32 %10, %13
  br i1 %25, label %6, label %26

26:                                               ; preds = %23, %9, %20, %4
  %27 = phi i32 [ -1, %4 ], [ -1, %20 ], [ %13, %9 ], [ -1, %23 ]
  ret i32 %27
}

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #1 {
  %1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef 2)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

attributes #0 = { nofree nosync nounwind memory(argmem: read) uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 6b940588a0fc77e60a61dc5e9a2fdcca1c1109e1)"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
