; ModuleID = 'binary_search.c'
source_filename = "binary_search.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.array = private unnamed_addr constant [6 x i32] [i32 100, i32 200, i32 488, i32 500, i32 600, i32 700], align 16
@.str = private unnamed_addr constant [33 x i8] c"\0AElement is not present in array\00", align 1
@.str.1 = private unnamed_addr constant [29 x i8] c"\0AElement is present here: %d\00", align 1

; Function Attrs: minsize nofree nosync nounwind optsize memory(argmem: read) uwtable
define dso_local i32 @binarySearch(ptr noundef readonly %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #0 {
  br label %5

5:                                                ; preds = %23, %4
  %6 = phi i32 [ %24, %23 ], [ %1, %4 ]
  %7 = phi i32 [ %9, %23 ], [ %2, %4 ]
  br label %8

8:                                                ; preds = %5, %21
  %9 = phi i32 [ %22, %21 ], [ %7, %5 ]
  %10 = icmp slt i32 %9, %6
  br i1 %10, label %25, label %11

11:                                               ; preds = %8
  %12 = sub nsw i32 %9, %6
  %13 = sdiv i32 %12, 2
  %14 = add nsw i32 %13, %6
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, ptr %0, i64 %15
  %17 = load i32, ptr %16, align 4, !tbaa !5
  %18 = icmp eq i32 %17, %3
  br i1 %18, label %25, label %19

19:                                               ; preds = %11
  %20 = icmp sgt i32 %17, %3
  br i1 %20, label %21, label %23

21:                                               ; preds = %19
  %22 = add nsw i32 %14, -1
  br label %8

23:                                               ; preds = %19
  %24 = add nsw i32 %14, 1
  br label %5

25:                                               ; preds = %8, %11
  %26 = phi i32 [ %14, %11 ], [ -1, %8 ]
  ret i32 %26
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: minsize nofree nounwind optsize uwtable
define dso_local i32 @main() local_unnamed_addr #2 {
  %1 = alloca [6 x i32], align 16
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %1) #5
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(24) %1, ptr noundef nonnull align 16 dereferenceable(24) @__const.main.array, i64 24, i1 false)
  %2 = call i32 @binarySearch(ptr noundef nonnull %1, i32 noundef 0, i32 noundef 5, i32 noundef 488) #6
  %3 = icmp eq i32 %2, -1
  br i1 %3, label %4, label %6

4:                                                ; preds = %0
  %5 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str) #6
  br label %8

6:                                                ; preds = %0
  %7 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %2) #6
  br label %8

8:                                                ; preds = %6, %4
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %1) #5
  ret i32 0
}

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: minsize nofree nounwind optsize
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

attributes #0 = { minsize nofree nosync nounwind optsize memory(argmem: read) uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { minsize nofree nounwind optsize uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { minsize nofree nounwind optsize "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { minsize optsize }

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
