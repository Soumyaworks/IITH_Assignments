; ModuleID = 'binary_search.c'
source_filename = "binary_search.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.array = private unnamed_addr constant [6 x i32] [i32 100, i32 200, i32 488, i32 500, i32 600, i32 700], align 16
@.str = private unnamed_addr constant [33 x i8] c"\0AElement is not present in array\00", align 1
@.str.1 = private unnamed_addr constant [29 x i8] c"\0AElement is present here: %d\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @binarySearch(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  %11 = load i32, ptr %8, align 4
  %12 = load i32, ptr %7, align 4
  %13 = icmp sge i32 %11, %12
  br i1 %13, label %14, label %52

14:                                               ; preds = %4
  %15 = load i32, ptr %7, align 4
  %16 = load i32, ptr %8, align 4
  %17 = load i32, ptr %7, align 4
  %18 = sub nsw i32 %16, %17
  %19 = sdiv i32 %18, 2
  %20 = add nsw i32 %15, %19
  store i32 %20, ptr %10, align 4
  %21 = load ptr, ptr %6, align 8
  %22 = load i32, ptr %10, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds i32, ptr %21, i64 %23
  %25 = load i32, ptr %24, align 4
  %26 = load i32, ptr %9, align 4
  %27 = icmp eq i32 %25, %26
  br i1 %27, label %28, label %30

28:                                               ; preds = %14
  %29 = load i32, ptr %10, align 4
  store i32 %29, ptr %5, align 4
  br label %53

30:                                               ; preds = %14
  %31 = load ptr, ptr %6, align 8
  %32 = load i32, ptr %10, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds i32, ptr %31, i64 %33
  %35 = load i32, ptr %34, align 4
  %36 = load i32, ptr %9, align 4
  %37 = icmp sgt i32 %35, %36
  br i1 %37, label %38, label %45

38:                                               ; preds = %30
  %39 = load ptr, ptr %6, align 8
  %40 = load i32, ptr %7, align 4
  %41 = load i32, ptr %10, align 4
  %42 = sub nsw i32 %41, 1
  %43 = load i32, ptr %9, align 4
  %44 = call i32 @binarySearch(ptr noundef %39, i32 noundef %40, i32 noundef %42, i32 noundef %43)
  store i32 %44, ptr %5, align 4
  br label %53

45:                                               ; preds = %30
  %46 = load ptr, ptr %6, align 8
  %47 = load i32, ptr %10, align 4
  %48 = add nsw i32 %47, 1
  %49 = load i32, ptr %8, align 4
  %50 = load i32, ptr %9, align 4
  %51 = call i32 @binarySearch(ptr noundef %46, i32 noundef %48, i32 noundef %49, i32 noundef %50)
  store i32 %51, ptr %5, align 4
  br label %53

52:                                               ; preds = %4
  store i32 -1, ptr %5, align 4
  br label %53

53:                                               ; preds = %52, %45, %38, %28
  %54 = load i32, ptr %5, align 4
  ret i32 %54
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [6 x i32], align 16
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 16 %2, ptr align 16 @__const.main.array, i64 24, i1 false)
  store i32 6, ptr %3, align 4
  store i32 488, ptr %4, align 4
  %6 = getelementptr inbounds [6 x i32], ptr %2, i64 0, i64 0
  %7 = load i32, ptr %3, align 4
  %8 = sub nsw i32 %7, 1
  %9 = load i32, ptr %4, align 4
  %10 = call i32 @binarySearch(ptr noundef %6, i32 noundef 0, i32 noundef %8, i32 noundef %9)
  store i32 %10, ptr %5, align 4
  %11 = load i32, ptr %5, align 4
  %12 = icmp eq i32 %11, -1
  br i1 %12, label %13, label %15

13:                                               ; preds = %0
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  br label %18

15:                                               ; preds = %0
  %16 = load i32, ptr %5, align 4
  %17 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %16)
  br label %18

18:                                               ; preds = %15, %13
  ret i32 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 16.0.0 (https://github.com/llvm/llvm-project.git 6b940588a0fc77e60a61dc5e9a2fdcca1c1109e1)"}
