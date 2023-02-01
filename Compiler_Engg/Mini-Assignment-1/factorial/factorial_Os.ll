; ModuleID = 'factorial.c'
source_filename = "factorial.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [29 x i8] c"\0AThe factorial of (n=5) = %d\00", align 1

; Function Attrs: nofree nosync nounwind optsize memory(none) uwtable
define dso_local i32 @factorial(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp eq i32 %0, 1
  br i1 %2, label %27, label %3

3:                                                ; preds = %1
  %4 = add i32 %0, 2
  %5 = and i32 %4, -4
  %6 = add i32 %0, -2
  %7 = insertelement <4 x i32> poison, i32 %6, i64 0
  %8 = shufflevector <4 x i32> %7, <4 x i32> poison, <4 x i32> zeroinitializer
  %9 = insertelement <4 x i32> poison, i32 %0, i64 0
  %10 = shufflevector <4 x i32> %9, <4 x i32> poison, <4 x i32> zeroinitializer
  %11 = add <4 x i32> %10, <i32 0, i32 -1, i32 -2, i32 -3>
  br label %12

12:                                               ; preds = %12, %3
  %13 = phi i32 [ 0, %3 ], [ %17, %12 ]
  %14 = phi <4 x i32> [ %11, %3 ], [ %18, %12 ]
  %15 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %3 ], [ %16, %12 ]
  %16 = mul <4 x i32> %14, %15
  %17 = add i32 %13, 4
  %18 = add <4 x i32> %14, <i32 -4, i32 -4, i32 -4, i32 -4>
  %19 = icmp eq i32 %17, %5
  br i1 %19, label %20, label %12, !llvm.loop !5

20:                                               ; preds = %12
  %21 = insertelement <4 x i32> poison, i32 %13, i64 0
  %22 = shufflevector <4 x i32> %21, <4 x i32> poison, <4 x i32> zeroinitializer
  %23 = or <4 x i32> %22, <i32 0, i32 1, i32 2, i32 3>
  %24 = icmp ugt <4 x i32> %23, %8
  %25 = select <4 x i1> %24, <4 x i32> %15, <4 x i32> %16
  %26 = tail call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> %25)
  br label %27

27:                                               ; preds = %20, %1
  %28 = phi i32 [ 1, %1 ], [ %26, %20 ]
  ret i32 %28
}

; Function Attrs: nofree nounwind optsize uwtable
define dso_local i32 @main() local_unnamed_addr #1 {
  %1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef 120) #4
  ret i32 0
}

; Function Attrs: nofree nounwind optsize
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i32 @llvm.vector.reduce.mul.v4i32(<4 x i32>) #3

attributes #0 = { nofree nosync nounwind optsize memory(none) uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind optsize uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind optsize "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { optsize }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 6b940588a0fc77e60a61dc5e9a2fdcca1c1109e1)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.isvectorized", i32 1}
