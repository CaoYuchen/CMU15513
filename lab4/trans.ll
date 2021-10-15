; ModuleID = 'trans.c'
source_filename = "trans.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"Transpose submission\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"Basic transpose\00", align 1
@.str.2 = private unnamed_addr constant [36 x i8] c"Transpose using the temporary array\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @registerFunctions() local_unnamed_addr #0 !dbg !7 {
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @transpose_submit, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0)) #3, !dbg !10
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @trans_basic, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0)) #3, !dbg !11
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @trans_tmp, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.2, i64 0, i64 0)) #3, !dbg !12
  ret void, !dbg !13
}

declare dso_local void @registerTransFunction(void (i64, i64, double*, double*, double*)*, i8*) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define internal void @transpose_submit(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture) #0 !dbg !14 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !27, metadata !DIExpression()), !dbg !39
  call void @llvm.dbg.value(metadata i64 %1, metadata !28, metadata !DIExpression()), !dbg !40
  call void @llvm.dbg.value(metadata double* %2, metadata !29, metadata !DIExpression()), !dbg !41
  call void @llvm.dbg.value(metadata double* %3, metadata !30, metadata !DIExpression()), !dbg !42
  call void @llvm.dbg.value(metadata double* %4, metadata !31, metadata !DIExpression()), !dbg !43
  %6 = icmp eq i64 %0, %1, !dbg !44
  br i1 %6, label %7, label %105, !dbg !45

; <label>:7:                                      ; preds = %5
  %8 = and i64 %0, 7, !dbg !46
  %9 = icmp eq i64 %8, 0, !dbg !46
  %10 = icmp eq i64 %0, 0, !dbg !48
  br i1 %9, label %11, label %86, !dbg !46

; <label>:11:                                     ; preds = %7
  call void @llvm.dbg.value(metadata i64 undef, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 0, metadata !32, metadata !DIExpression()), !dbg !50
  br i1 %10, label %133, label %12, !dbg !51

; <label>:12:                                     ; preds = %11, %83
  %13 = phi i64 [ %16, %83 ], [ undef, %11 ]
  %14 = phi i64 [ %84, %83 ], [ 0, %11 ]
  call void @llvm.dbg.value(metadata i64 %13, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %14, metadata !32, metadata !DIExpression()), !dbg !50
  call void @llvm.dbg.value(metadata i64 %13, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 0, metadata !35, metadata !DIExpression()), !dbg !54
  br label %45, !dbg !55

; <label>:15:                                     ; preds = %19, %56
  %16 = phi i64 [ %80, %56 ], [ %35, %19 ]
  %17 = add i64 %47, 8, !dbg !59
  call void @llvm.dbg.value(metadata i64 %16, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %17, metadata !35, metadata !DIExpression()), !dbg !54
  %18 = icmp ult i64 %17, %0, !dbg !61
  br i1 %18, label %45, label %83, !dbg !55, !llvm.loop !62

; <label>:19:                                     ; preds = %34
  call void @llvm.dbg.value(metadata i64 %35, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %35, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %35, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %35, metadata !38, metadata !DIExpression()), !dbg !49
  %20 = add nuw nsw i64 %40, 1, !dbg !64
  call void @llvm.dbg.value(metadata i64 %35, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %20, metadata !36, metadata !DIExpression()), !dbg !68
  %21 = icmp eq i64 %20, 8, !dbg !69
  br i1 %21, label %15, label %38, !dbg !70, !llvm.loop !71

; <label>:22:                                     ; preds = %34, %38
  %23 = phi i64 [ %39, %38 ], [ %35, %34 ]
  %24 = phi i64 [ 0, %38 ], [ %36, %34 ]
  call void @llvm.dbg.value(metadata i64 %23, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %24, metadata !37, metadata !DIExpression()), !dbg !73
  %25 = add nuw nsw i64 %24, %47, !dbg !74
  %26 = icmp eq i64 %41, %25, !dbg !80
  br i1 %26, label %34, label %27, !dbg !81

; <label>:27:                                     ; preds = %22
  %28 = getelementptr inbounds double, double* %43, i64 %25, !dbg !82
  %29 = bitcast double* %28 to i64*, !dbg !82
  %30 = load i64, i64* %29, align 8, !dbg !82, !tbaa !83
  %31 = mul nsw i64 %25, %0, !dbg !87
  %32 = getelementptr inbounds double, double* %44, i64 %31, !dbg !87
  %33 = bitcast double* %32 to i64*, !dbg !88
  store i64 %30, i64* %33, align 8, !dbg !88, !tbaa !83
  br label %34, !dbg !89

; <label>:34:                                     ; preds = %27, %22
  %35 = phi i64 [ %23, %27 ], [ %41, %22 ]
  %36 = add nuw nsw i64 %24, 1, !dbg !90
  call void @llvm.dbg.value(metadata i64 %35, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %36, metadata !37, metadata !DIExpression()), !dbg !73
  %37 = icmp eq i64 %36, 8, !dbg !91
  br i1 %37, label %19, label %22, !dbg !92, !llvm.loop !93

; <label>:38:                                     ; preds = %45, %19
  %39 = phi i64 [ %35, %19 ], [ %46, %45 ]
  %40 = phi i64 [ %20, %19 ], [ 0, %45 ]
  call void @llvm.dbg.value(metadata i64 %39, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %40, metadata !36, metadata !DIExpression()), !dbg !68
  call void @llvm.dbg.value(metadata i64 %39, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 0, metadata !37, metadata !DIExpression()), !dbg !73
  %41 = add nuw nsw i64 %40, %14
  %42 = mul nsw i64 %41, %0
  %43 = getelementptr inbounds double, double* %2, i64 %42
  %44 = getelementptr inbounds double, double* %3, i64 %41
  br label %22, !dbg !92

; <label>:45:                                     ; preds = %12, %15
  %46 = phi i64 [ %13, %12 ], [ %16, %15 ]
  %47 = phi i64 [ 0, %12 ], [ %17, %15 ]
  call void @llvm.dbg.value(metadata i64 %46, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %47, metadata !35, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.value(metadata i64 %46, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 0, metadata !36, metadata !DIExpression()), !dbg !68
  %48 = icmp eq i64 %14, %47
  br i1 %48, label %49, label %38, !dbg !70

; <label>:49:                                     ; preds = %45, %56
  %50 = phi i64 [ %80, %56 ], [ %46, %45 ]
  %51 = phi i64 [ %65, %56 ], [ 0, %45 ]
  call void @llvm.dbg.value(metadata i64 %50, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %51, metadata !36, metadata !DIExpression()), !dbg !68
  call void @llvm.dbg.value(metadata i64 %50, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 0, metadata !37, metadata !DIExpression()), !dbg !73
  %52 = add nuw nsw i64 %51, %14
  %53 = mul nsw i64 %52, %0
  %54 = getelementptr inbounds double, double* %2, i64 %53
  %55 = getelementptr inbounds double, double* %3, i64 %52
  br label %67, !dbg !92

; <label>:56:                                     ; preds = %79
  call void @llvm.dbg.value(metadata i64 %80, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %80, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %80, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %80, metadata !38, metadata !DIExpression()), !dbg !49
  %57 = mul nsw i64 %80, %0, !dbg !95
  %58 = getelementptr inbounds double, double* %2, i64 %57, !dbg !95
  %59 = getelementptr inbounds double, double* %58, i64 %80, !dbg !95
  %60 = bitcast double* %59 to i64*, !dbg !95
  %61 = load i64, i64* %60, align 8, !dbg !95, !tbaa !83
  %62 = getelementptr inbounds double, double* %3, i64 %57, !dbg !97
  %63 = getelementptr inbounds double, double* %62, i64 %80, !dbg !97
  %64 = bitcast double* %63 to i64*, !dbg !98
  store i64 %61, i64* %64, align 8, !dbg !98, !tbaa !83
  %65 = add nuw nsw i64 %51, 1, !dbg !64
  call void @llvm.dbg.value(metadata i64 %80, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %65, metadata !36, metadata !DIExpression()), !dbg !68
  %66 = icmp eq i64 %65, 8, !dbg !69
  br i1 %66, label %15, label %49, !dbg !70, !llvm.loop !71

; <label>:67:                                     ; preds = %79, %49
  %68 = phi i64 [ %50, %49 ], [ %80, %79 ]
  %69 = phi i64 [ 0, %49 ], [ %81, %79 ]
  call void @llvm.dbg.value(metadata i64 %68, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %69, metadata !37, metadata !DIExpression()), !dbg !73
  %70 = add nuw nsw i64 %69, %14, !dbg !74
  %71 = icmp eq i64 %52, %70, !dbg !80
  br i1 %71, label %79, label %72, !dbg !81

; <label>:72:                                     ; preds = %67
  %73 = getelementptr inbounds double, double* %54, i64 %70, !dbg !82
  %74 = bitcast double* %73 to i64*, !dbg !82
  %75 = load i64, i64* %74, align 8, !dbg !82, !tbaa !83
  %76 = mul nsw i64 %70, %0, !dbg !87
  %77 = getelementptr inbounds double, double* %55, i64 %76, !dbg !87
  %78 = bitcast double* %77 to i64*, !dbg !88
  store i64 %75, i64* %78, align 8, !dbg !88, !tbaa !83
  br label %79, !dbg !89

; <label>:79:                                     ; preds = %72, %67
  %80 = phi i64 [ %68, %72 ], [ %52, %67 ]
  %81 = add nuw nsw i64 %69, 1, !dbg !90
  call void @llvm.dbg.value(metadata i64 %80, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %81, metadata !37, metadata !DIExpression()), !dbg !73
  %82 = icmp eq i64 %81, 8, !dbg !91
  br i1 %82, label %56, label %67, !dbg !92, !llvm.loop !93

; <label>:83:                                     ; preds = %15
  call void @llvm.dbg.value(metadata i64 %16, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %16, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %16, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %16, metadata !38, metadata !DIExpression()), !dbg !49
  %84 = add i64 %14, 8, !dbg !99
  call void @llvm.dbg.value(metadata i64 %16, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i64 %84, metadata !32, metadata !DIExpression()), !dbg !50
  %85 = icmp ult i64 %84, %0, !dbg !100
  br i1 %85, label %12, label %133, !dbg !51, !llvm.loop !101

; <label>:86:                                     ; preds = %7
  call void @llvm.dbg.value(metadata i64 %0, metadata !103, metadata !DIExpression()), !dbg !116
  call void @llvm.dbg.value(metadata i64 %1, metadata !106, metadata !DIExpression()), !dbg !118
  call void @llvm.dbg.value(metadata double* %2, metadata !107, metadata !DIExpression()), !dbg !119
  call void @llvm.dbg.value(metadata double* %3, metadata !108, metadata !DIExpression()), !dbg !120
  call void @llvm.dbg.value(metadata double* %4, metadata !109, metadata !DIExpression()), !dbg !121
  call void @llvm.dbg.value(metadata i64 0, metadata !110, metadata !DIExpression()), !dbg !122
  br i1 %10, label %133, label %87, !dbg !123

; <label>:87:                                     ; preds = %86, %102
  %88 = phi i64 [ %103, %102 ], [ 0, %86 ]
  call void @llvm.dbg.value(metadata i64 %88, metadata !110, metadata !DIExpression()), !dbg !122
  call void @llvm.dbg.value(metadata i64 0, metadata !112, metadata !DIExpression()), !dbg !124
  %89 = mul nsw i64 %88, %0
  %90 = getelementptr inbounds double, double* %2, i64 %89
  %91 = getelementptr inbounds double, double* %3, i64 %88
  br label %92, !dbg !125

; <label>:92:                                     ; preds = %92, %87
  %93 = phi i64 [ 0, %87 ], [ %100, %92 ]
  call void @llvm.dbg.value(metadata i64 %93, metadata !112, metadata !DIExpression()), !dbg !124
  %94 = getelementptr inbounds double, double* %90, i64 %93, !dbg !126
  %95 = bitcast double* %94 to i64*, !dbg !126
  %96 = load i64, i64* %95, align 8, !dbg !126, !tbaa !83
  %97 = mul nsw i64 %93, %0, !dbg !129
  %98 = getelementptr inbounds double, double* %91, i64 %97, !dbg !129
  %99 = bitcast double* %98 to i64*, !dbg !130
  store i64 %96, i64* %99, align 8, !dbg !130, !tbaa !83
  %100 = add nuw i64 %93, 1, !dbg !131
  call void @llvm.dbg.value(metadata i64 %100, metadata !112, metadata !DIExpression()), !dbg !124
  %101 = icmp eq i64 %100, %0, !dbg !132
  br i1 %101, label %102, label %92, !dbg !125, !llvm.loop !133

; <label>:102:                                    ; preds = %92
  %103 = add nuw i64 %88, 1, !dbg !136
  call void @llvm.dbg.value(metadata i64 %103, metadata !110, metadata !DIExpression()), !dbg !122
  %104 = icmp eq i64 %103, %0, !dbg !137
  br i1 %104, label %133, label %87, !dbg !123, !llvm.loop !138

; <label>:105:                                    ; preds = %5
  call void @llvm.dbg.value(metadata i64 %0, metadata !141, metadata !DIExpression()), !dbg !158
  call void @llvm.dbg.value(metadata i64 %1, metadata !144, metadata !DIExpression()), !dbg !160
  call void @llvm.dbg.value(metadata double* %2, metadata !145, metadata !DIExpression()), !dbg !161
  call void @llvm.dbg.value(metadata double* %3, metadata !146, metadata !DIExpression()), !dbg !162
  call void @llvm.dbg.value(metadata double* %4, metadata !147, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata i64 0, metadata !148, metadata !DIExpression()), !dbg !164
  %106 = icmp eq i64 %1, 0, !dbg !165
  %107 = icmp eq i64 %0, 0
  %108 = or i1 %107, %106, !dbg !166
  br i1 %108, label %133, label %109, !dbg !166

; <label>:109:                                    ; preds = %105, %130
  %110 = phi i64 [ %131, %130 ], [ 0, %105 ]
  call void @llvm.dbg.value(metadata i64 %110, metadata !148, metadata !DIExpression()), !dbg !164
  call void @llvm.dbg.value(metadata i64 0, metadata !150, metadata !DIExpression()), !dbg !167
  %111 = mul nsw i64 %110, %0
  %112 = getelementptr inbounds double, double* %2, i64 %111
  %113 = shl i64 %110, 1
  %114 = and i64 %113, 2
  %115 = getelementptr inbounds double, double* %3, i64 %110
  br label %116, !dbg !168

; <label>:116:                                    ; preds = %116, %109
  %117 = phi i64 [ 0, %109 ], [ %128, %116 ]
  call void @llvm.dbg.value(metadata i64 %117, metadata !150, metadata !DIExpression()), !dbg !167
  call void @llvm.dbg.value(metadata i64 %110, metadata !154, metadata !DIExpression(DW_OP_constu, 1, DW_OP_and, DW_OP_stack_value)), !dbg !169
  %118 = and i64 %117, 1, !dbg !170
  call void @llvm.dbg.value(metadata i64 %118, metadata !157, metadata !DIExpression()), !dbg !171
  %119 = getelementptr inbounds double, double* %112, i64 %117, !dbg !172
  %120 = bitcast double* %119 to i64*, !dbg !172
  %121 = load i64, i64* %120, align 8, !dbg !172, !tbaa !83
  %122 = or i64 %118, %114, !dbg !173
  %123 = getelementptr inbounds double, double* %4, i64 %122, !dbg !174
  %124 = bitcast double* %123 to i64*, !dbg !175
  store i64 %121, i64* %124, align 8, !dbg !175, !tbaa !83
  %125 = mul nsw i64 %117, %1, !dbg !176
  %126 = getelementptr inbounds double, double* %115, i64 %125, !dbg !176
  %127 = bitcast double* %126 to i64*, !dbg !177
  store i64 %121, i64* %127, align 8, !dbg !177, !tbaa !83
  %128 = add nuw i64 %117, 1, !dbg !178
  call void @llvm.dbg.value(metadata i64 %128, metadata !150, metadata !DIExpression()), !dbg !167
  %129 = icmp eq i64 %128, %0, !dbg !179
  br i1 %129, label %130, label %116, !dbg !168, !llvm.loop !180

; <label>:130:                                    ; preds = %116
  %131 = add nuw i64 %110, 1, !dbg !183
  call void @llvm.dbg.value(metadata i64 %131, metadata !148, metadata !DIExpression()), !dbg !164
  %132 = icmp eq i64 %131, %1, !dbg !165
  br i1 %132, label %133, label %109, !dbg !166, !llvm.loop !184

; <label>:133:                                    ; preds = %130, %102, %83, %11, %105, %86
  ret void, !dbg !187
}

; Function Attrs: nounwind uwtable
define internal void @trans_basic(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture readnone) #0 !dbg !104 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !103, metadata !DIExpression()), !dbg !188
  call void @llvm.dbg.value(metadata i64 %1, metadata !106, metadata !DIExpression()), !dbg !189
  call void @llvm.dbg.value(metadata double* %2, metadata !107, metadata !DIExpression()), !dbg !190
  call void @llvm.dbg.value(metadata double* %3, metadata !108, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.value(metadata double* %4, metadata !109, metadata !DIExpression()), !dbg !192
  call void @llvm.dbg.value(metadata i64 0, metadata !110, metadata !DIExpression()), !dbg !193
  %6 = icmp eq i64 %1, 0, !dbg !194
  %7 = icmp eq i64 %0, 0
  %8 = or i1 %6, %7, !dbg !139
  br i1 %8, label %27, label %9, !dbg !139

; <label>:9:                                      ; preds = %5, %24
  %10 = phi i64 [ %25, %24 ], [ 0, %5 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !110, metadata !DIExpression()), !dbg !193
  call void @llvm.dbg.value(metadata i64 0, metadata !112, metadata !DIExpression()), !dbg !195
  %11 = mul nsw i64 %10, %0
  %12 = getelementptr inbounds double, double* %2, i64 %11
  %13 = getelementptr inbounds double, double* %3, i64 %10
  br label %14, !dbg !134

; <label>:14:                                     ; preds = %14, %9
  %15 = phi i64 [ 0, %9 ], [ %22, %14 ]
  call void @llvm.dbg.value(metadata i64 %15, metadata !112, metadata !DIExpression()), !dbg !195
  %16 = getelementptr inbounds double, double* %12, i64 %15, !dbg !196
  %17 = bitcast double* %16 to i64*, !dbg !196
  %18 = load i64, i64* %17, align 8, !dbg !196, !tbaa !83
  %19 = mul nsw i64 %15, %1, !dbg !197
  %20 = getelementptr inbounds double, double* %13, i64 %19, !dbg !197
  %21 = bitcast double* %20 to i64*, !dbg !198
  store i64 %18, i64* %21, align 8, !dbg !198, !tbaa !83
  %22 = add nuw i64 %15, 1, !dbg !199
  call void @llvm.dbg.value(metadata i64 %22, metadata !112, metadata !DIExpression()), !dbg !195
  %23 = icmp eq i64 %22, %0, !dbg !200
  br i1 %23, label %24, label %14, !dbg !134, !llvm.loop !133

; <label>:24:                                     ; preds = %14
  %25 = add nuw i64 %10, 1, !dbg !201
  call void @llvm.dbg.value(metadata i64 %25, metadata !110, metadata !DIExpression()), !dbg !193
  %26 = icmp eq i64 %25, %1, !dbg !194
  br i1 %26, label %27, label %9, !dbg !139, !llvm.loop !138

; <label>:27:                                     ; preds = %24, %5
  ret void, !dbg !202
}

; Function Attrs: nounwind uwtable
define internal void @trans_tmp(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture) #0 !dbg !142 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !141, metadata !DIExpression()), !dbg !203
  call void @llvm.dbg.value(metadata i64 %1, metadata !144, metadata !DIExpression()), !dbg !204
  call void @llvm.dbg.value(metadata double* %2, metadata !145, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.value(metadata double* %3, metadata !146, metadata !DIExpression()), !dbg !206
  call void @llvm.dbg.value(metadata double* %4, metadata !147, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i64 0, metadata !148, metadata !DIExpression()), !dbg !208
  %6 = icmp eq i64 %1, 0, !dbg !209
  %7 = icmp eq i64 %0, 0
  %8 = or i1 %6, %7, !dbg !185
  br i1 %8, label %33, label %9, !dbg !185

; <label>:9:                                      ; preds = %5, %30
  %10 = phi i64 [ %31, %30 ], [ 0, %5 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !148, metadata !DIExpression()), !dbg !208
  call void @llvm.dbg.value(metadata i64 0, metadata !150, metadata !DIExpression()), !dbg !210
  %11 = mul nsw i64 %10, %0
  %12 = getelementptr inbounds double, double* %2, i64 %11
  %13 = shl i64 %10, 1
  %14 = and i64 %13, 2
  %15 = getelementptr inbounds double, double* %3, i64 %10
  br label %16, !dbg !181

; <label>:16:                                     ; preds = %16, %9
  %17 = phi i64 [ 0, %9 ], [ %28, %16 ]
  call void @llvm.dbg.value(metadata i64 %17, metadata !150, metadata !DIExpression()), !dbg !210
  call void @llvm.dbg.value(metadata i64 %10, metadata !154, metadata !DIExpression(DW_OP_constu, 1, DW_OP_and, DW_OP_stack_value)), !dbg !211
  %18 = and i64 %17, 1, !dbg !212
  call void @llvm.dbg.value(metadata i64 %18, metadata !157, metadata !DIExpression()), !dbg !213
  %19 = getelementptr inbounds double, double* %12, i64 %17, !dbg !214
  %20 = bitcast double* %19 to i64*, !dbg !214
  %21 = load i64, i64* %20, align 8, !dbg !214, !tbaa !83
  %22 = or i64 %18, %14, !dbg !215
  %23 = getelementptr inbounds double, double* %4, i64 %22, !dbg !216
  %24 = bitcast double* %23 to i64*, !dbg !217
  store i64 %21, i64* %24, align 8, !dbg !217, !tbaa !83
  %25 = mul nsw i64 %17, %1, !dbg !218
  %26 = getelementptr inbounds double, double* %15, i64 %25, !dbg !218
  %27 = bitcast double* %26 to i64*, !dbg !219
  store i64 %21, i64* %27, align 8, !dbg !219, !tbaa !83
  %28 = add nuw i64 %17, 1, !dbg !220
  call void @llvm.dbg.value(metadata i64 %28, metadata !150, metadata !DIExpression()), !dbg !210
  %29 = icmp eq i64 %28, %0, !dbg !221
  br i1 %29, label %30, label %16, !dbg !181, !llvm.loop !180

; <label>:30:                                     ; preds = %16
  %31 = add nuw i64 %10, 1, !dbg !222
  call void @llvm.dbg.value(metadata i64 %31, metadata !148, metadata !DIExpression()), !dbg !208
  %32 = icmp eq i64 %31, %1, !dbg !209
  br i1 %32, label %33, label %9, !dbg !185, !llvm.loop !184

; <label>:33:                                     ; preds = %30, %5
  ret void, !dbg !223
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.0 (tags/RELEASE_700/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "trans.c", directory: "/afs/andrew.cmu.edu/usr11/yuchenca/private/15513/lab4")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!7 = distinct !DISubprogram(name: "registerFunctions", scope: !1, file: !1, line: 162, type: !8, isLocal: false, isDefinition: true, scopeLine: 162, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocation(line: 164, column: 5, scope: !7)
!11 = !DILocation(line: 167, column: 5, scope: !7)
!12 = !DILocation(line: 168, column: 5, scope: !7)
!13 = !DILocation(line: 169, column: 1, scope: !7)
!14 = distinct !DISubprogram(name: "transpose_submit", scope: !1, file: !1, line: 125, type: !15, isLocal: true, isDefinition: true, scopeLine: 126, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !26)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17, !17, !20, !20, !25}
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !18, line: 62, baseType: !19)
!18 = !DIFile(filename: "/usr/local/depot/llvm-7.0/lib/clang/7.0.0/include/stddef.h", directory: "/afs/andrew.cmu.edu/usr11/yuchenca/private/15513/lab4")
!19 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, elements: !23)
!22 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!23 = !{!24}
!24 = !DISubrange(count: -1)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!26 = !{!27, !28, !29, !30, !31, !32, !35, !36, !37, !38}
!27 = !DILocalVariable(name: "M", arg: 1, scope: !14, file: !1, line: 125, type: !17)
!28 = !DILocalVariable(name: "N", arg: 2, scope: !14, file: !1, line: 125, type: !17)
!29 = !DILocalVariable(name: "A", arg: 3, scope: !14, file: !1, line: 125, type: !20)
!30 = !DILocalVariable(name: "B", arg: 4, scope: !14, file: !1, line: 125, type: !20)
!31 = !DILocalVariable(name: "tmp", arg: 5, scope: !14, file: !1, line: 126, type: !25)
!32 = !DILocalVariable(name: "i", scope: !33, file: !1, line: 128, type: !17)
!33 = distinct !DILexicalBlock(scope: !34, file: !1, line: 127, column: 17)
!34 = distinct !DILexicalBlock(scope: !14, file: !1, line: 127, column: 9)
!35 = !DILocalVariable(name: "j", scope: !33, file: !1, line: 128, type: !17)
!36 = !DILocalVariable(name: "di", scope: !33, file: !1, line: 128, type: !17)
!37 = !DILocalVariable(name: "dj", scope: !33, file: !1, line: 128, type: !17)
!38 = !DILocalVariable(name: "diag", scope: !33, file: !1, line: 128, type: !17)
!39 = !DILocation(line: 125, column: 37, scope: !14)
!40 = !DILocation(line: 125, column: 47, scope: !14)
!41 = !DILocation(line: 125, column: 57, scope: !14)
!42 = !DILocation(line: 125, column: 73, scope: !14)
!43 = !DILocation(line: 126, column: 37, scope: !14)
!44 = !DILocation(line: 127, column: 11, scope: !34)
!45 = !DILocation(line: 127, column: 9, scope: !14)
!46 = !DILocation(line: 130, column: 24, scope: !47)
!47 = distinct !DILexicalBlock(scope: !33, file: !1, line: 130, column: 13)
!48 = !DILocation(line: 0, scope: !47)
!49 = !DILocation(line: 128, column: 30, scope: !33)
!50 = !DILocation(line: 128, column: 16, scope: !33)
!51 = !DILocation(line: 131, column: 13, scope: !52)
!52 = distinct !DILexicalBlock(scope: !53, file: !1, line: 131, column: 13)
!53 = distinct !DILexicalBlock(scope: !47, file: !1, line: 130, column: 39)
!54 = !DILocation(line: 128, column: 19, scope: !33)
!55 = !DILocation(line: 132, column: 17, scope: !56)
!56 = distinct !DILexicalBlock(scope: !57, file: !1, line: 132, column: 17)
!57 = distinct !DILexicalBlock(scope: !58, file: !1, line: 131, column: 40)
!58 = distinct !DILexicalBlock(scope: !52, file: !1, line: 131, column: 13)
!59 = !DILocation(line: 132, column: 38, scope: !60)
!60 = distinct !DILexicalBlock(scope: !56, file: !1, line: 132, column: 17)
!61 = !DILocation(line: 132, column: 31, scope: !60)
!62 = distinct !{!62, !55, !63}
!63 = !DILocation(line: 146, column: 17, scope: !56)
!64 = !DILocation(line: 133, column: 44, scope: !65)
!65 = distinct !DILexicalBlock(scope: !66, file: !1, line: 133, column: 21)
!66 = distinct !DILexicalBlock(scope: !67, file: !1, line: 133, column: 21)
!67 = distinct !DILexicalBlock(scope: !60, file: !1, line: 132, column: 44)
!68 = !DILocation(line: 128, column: 22, scope: !33)
!69 = !DILocation(line: 133, column: 37, scope: !65)
!70 = !DILocation(line: 133, column: 21, scope: !66)
!71 = distinct !{!71, !70, !72}
!72 = !DILocation(line: 145, column: 21, scope: !66)
!73 = !DILocation(line: 128, column: 26, scope: !33)
!74 = !DILocation(line: 135, column: 45, scope: !75)
!75 = distinct !DILexicalBlock(scope: !76, file: !1, line: 135, column: 33)
!76 = distinct !DILexicalBlock(scope: !77, file: !1, line: 134, column: 52)
!77 = distinct !DILexicalBlock(scope: !78, file: !1, line: 134, column: 25)
!78 = distinct !DILexicalBlock(scope: !79, file: !1, line: 134, column: 25)
!79 = distinct !DILexicalBlock(scope: !65, file: !1, line: 133, column: 48)
!80 = !DILocation(line: 135, column: 40, scope: !75)
!81 = !DILocation(line: 135, column: 33, scope: !76)
!82 = !DILocation(line: 141, column: 49, scope: !76)
!83 = !{!84, !84, i64 0}
!84 = !{!"double", !85, i64 0}
!85 = !{!"omnipotent char", !86, i64 0}
!86 = !{!"Simple C/C++ TBAA"}
!87 = !DILocation(line: 141, column: 29, scope: !76)
!88 = !DILocation(line: 141, column: 47, scope: !76)
!89 = !DILocation(line: 142, column: 25, scope: !76)
!90 = !DILocation(line: 134, column: 48, scope: !77)
!91 = !DILocation(line: 134, column: 41, scope: !77)
!92 = !DILocation(line: 134, column: 25, scope: !78)
!93 = distinct !{!93, !92, !94}
!94 = !DILocation(line: 142, column: 25, scope: !78)
!95 = !DILocation(line: 144, column: 45, scope: !96)
!96 = distinct !DILexicalBlock(scope: !79, file: !1, line: 143, column: 29)
!97 = !DILocation(line: 144, column: 29, scope: !96)
!98 = !DILocation(line: 144, column: 43, scope: !96)
!99 = !DILocation(line: 131, column: 34, scope: !58)
!100 = !DILocation(line: 131, column: 27, scope: !58)
!101 = distinct !{!101, !51, !102}
!102 = !DILocation(line: 147, column: 13, scope: !52)
!103 = !DILocalVariable(name: "M", arg: 1, scope: !104, file: !1, line: 81, type: !17)
!104 = distinct !DISubprogram(name: "trans_basic", scope: !1, file: !1, line: 81, type: !15, isLocal: true, isDefinition: true, scopeLine: 82, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !105)
!105 = !{!103, !106, !107, !108, !109, !110, !112}
!106 = !DILocalVariable(name: "N", arg: 2, scope: !104, file: !1, line: 81, type: !17)
!107 = !DILocalVariable(name: "A", arg: 3, scope: !104, file: !1, line: 81, type: !20)
!108 = !DILocalVariable(name: "B", arg: 4, scope: !104, file: !1, line: 81, type: !20)
!109 = !DILocalVariable(name: "tmp", arg: 5, scope: !104, file: !1, line: 82, type: !25)
!110 = !DILocalVariable(name: "i", scope: !111, file: !1, line: 86, type: !17)
!111 = distinct !DILexicalBlock(scope: !104, file: !1, line: 86, column: 5)
!112 = !DILocalVariable(name: "j", scope: !113, file: !1, line: 87, type: !17)
!113 = distinct !DILexicalBlock(scope: !114, file: !1, line: 87, column: 9)
!114 = distinct !DILexicalBlock(scope: !115, file: !1, line: 86, column: 36)
!115 = distinct !DILexicalBlock(scope: !111, file: !1, line: 86, column: 5)
!116 = !DILocation(line: 81, column: 32, scope: !104, inlinedAt: !117)
!117 = distinct !DILocation(line: 149, column: 13, scope: !47)
!118 = !DILocation(line: 81, column: 42, scope: !104, inlinedAt: !117)
!119 = !DILocation(line: 81, column: 52, scope: !104, inlinedAt: !117)
!120 = !DILocation(line: 81, column: 68, scope: !104, inlinedAt: !117)
!121 = !DILocation(line: 82, column: 32, scope: !104, inlinedAt: !117)
!122 = !DILocation(line: 86, column: 17, scope: !111, inlinedAt: !117)
!123 = !DILocation(line: 86, column: 5, scope: !111, inlinedAt: !117)
!124 = !DILocation(line: 87, column: 21, scope: !113, inlinedAt: !117)
!125 = !DILocation(line: 87, column: 9, scope: !113, inlinedAt: !117)
!126 = !DILocation(line: 88, column: 23, scope: !127, inlinedAt: !117)
!127 = distinct !DILexicalBlock(scope: !128, file: !1, line: 87, column: 40)
!128 = distinct !DILexicalBlock(scope: !113, file: !1, line: 87, column: 9)
!129 = !DILocation(line: 88, column: 13, scope: !127, inlinedAt: !117)
!130 = !DILocation(line: 88, column: 21, scope: !127, inlinedAt: !117)
!131 = !DILocation(line: 87, column: 36, scope: !128, inlinedAt: !117)
!132 = !DILocation(line: 87, column: 30, scope: !128, inlinedAt: !117)
!133 = distinct !{!133, !134, !135}
!134 = !DILocation(line: 87, column: 9, scope: !113)
!135 = !DILocation(line: 89, column: 9, scope: !113)
!136 = !DILocation(line: 86, column: 32, scope: !115, inlinedAt: !117)
!137 = !DILocation(line: 86, column: 26, scope: !115, inlinedAt: !117)
!138 = distinct !{!138, !139, !140}
!139 = !DILocation(line: 86, column: 5, scope: !111)
!140 = !DILocation(line: 90, column: 5, scope: !111)
!141 = !DILocalVariable(name: "M", arg: 1, scope: !142, file: !1, line: 101, type: !17)
!142 = distinct !DISubprogram(name: "trans_tmp", scope: !1, file: !1, line: 101, type: !15, isLocal: true, isDefinition: true, scopeLine: 102, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !143)
!143 = !{!141, !144, !145, !146, !147, !148, !150, !154, !157}
!144 = !DILocalVariable(name: "N", arg: 2, scope: !142, file: !1, line: 101, type: !17)
!145 = !DILocalVariable(name: "A", arg: 3, scope: !142, file: !1, line: 101, type: !20)
!146 = !DILocalVariable(name: "B", arg: 4, scope: !142, file: !1, line: 101, type: !20)
!147 = !DILocalVariable(name: "tmp", arg: 5, scope: !142, file: !1, line: 102, type: !25)
!148 = !DILocalVariable(name: "i", scope: !149, file: !1, line: 106, type: !17)
!149 = distinct !DILexicalBlock(scope: !142, file: !1, line: 106, column: 5)
!150 = !DILocalVariable(name: "j", scope: !151, file: !1, line: 107, type: !17)
!151 = distinct !DILexicalBlock(scope: !152, file: !1, line: 107, column: 9)
!152 = distinct !DILexicalBlock(scope: !153, file: !1, line: 106, column: 36)
!153 = distinct !DILexicalBlock(scope: !149, file: !1, line: 106, column: 5)
!154 = !DILocalVariable(name: "di", scope: !155, file: !1, line: 108, type: !17)
!155 = distinct !DILexicalBlock(scope: !156, file: !1, line: 107, column: 40)
!156 = distinct !DILexicalBlock(scope: !151, file: !1, line: 107, column: 9)
!157 = !DILocalVariable(name: "dj", scope: !155, file: !1, line: 109, type: !17)
!158 = !DILocation(line: 101, column: 30, scope: !142, inlinedAt: !159)
!159 = distinct !DILocation(line: 153, column: 9, scope: !34)
!160 = !DILocation(line: 101, column: 40, scope: !142, inlinedAt: !159)
!161 = !DILocation(line: 101, column: 50, scope: !142, inlinedAt: !159)
!162 = !DILocation(line: 101, column: 66, scope: !142, inlinedAt: !159)
!163 = !DILocation(line: 102, column: 30, scope: !142, inlinedAt: !159)
!164 = !DILocation(line: 106, column: 17, scope: !149, inlinedAt: !159)
!165 = !DILocation(line: 106, column: 26, scope: !153, inlinedAt: !159)
!166 = !DILocation(line: 106, column: 5, scope: !149, inlinedAt: !159)
!167 = !DILocation(line: 107, column: 21, scope: !151, inlinedAt: !159)
!168 = !DILocation(line: 107, column: 9, scope: !151, inlinedAt: !159)
!169 = !DILocation(line: 108, column: 20, scope: !155, inlinedAt: !159)
!170 = !DILocation(line: 109, column: 27, scope: !155, inlinedAt: !159)
!171 = !DILocation(line: 109, column: 20, scope: !155, inlinedAt: !159)
!172 = !DILocation(line: 110, column: 32, scope: !155, inlinedAt: !159)
!173 = !DILocation(line: 110, column: 24, scope: !155, inlinedAt: !159)
!174 = !DILocation(line: 110, column: 13, scope: !155, inlinedAt: !159)
!175 = !DILocation(line: 110, column: 30, scope: !155, inlinedAt: !159)
!176 = !DILocation(line: 111, column: 13, scope: !155, inlinedAt: !159)
!177 = !DILocation(line: 111, column: 21, scope: !155, inlinedAt: !159)
!178 = !DILocation(line: 107, column: 36, scope: !156, inlinedAt: !159)
!179 = !DILocation(line: 107, column: 30, scope: !156, inlinedAt: !159)
!180 = distinct !{!180, !181, !182}
!181 = !DILocation(line: 107, column: 9, scope: !151)
!182 = !DILocation(line: 112, column: 9, scope: !151)
!183 = !DILocation(line: 106, column: 32, scope: !153, inlinedAt: !159)
!184 = distinct !{!184, !185, !186}
!185 = !DILocation(line: 106, column: 5, scope: !149)
!186 = !DILocation(line: 113, column: 5, scope: !149)
!187 = !DILocation(line: 154, column: 1, scope: !14)
!188 = !DILocation(line: 81, column: 32, scope: !104)
!189 = !DILocation(line: 81, column: 42, scope: !104)
!190 = !DILocation(line: 81, column: 52, scope: !104)
!191 = !DILocation(line: 81, column: 68, scope: !104)
!192 = !DILocation(line: 82, column: 32, scope: !104)
!193 = !DILocation(line: 86, column: 17, scope: !111)
!194 = !DILocation(line: 86, column: 26, scope: !115)
!195 = !DILocation(line: 87, column: 21, scope: !113)
!196 = !DILocation(line: 88, column: 23, scope: !127)
!197 = !DILocation(line: 88, column: 13, scope: !127)
!198 = !DILocation(line: 88, column: 21, scope: !127)
!199 = !DILocation(line: 87, column: 36, scope: !128)
!200 = !DILocation(line: 87, column: 30, scope: !128)
!201 = !DILocation(line: 86, column: 32, scope: !115)
!202 = !DILocation(line: 93, column: 1, scope: !104)
!203 = !DILocation(line: 101, column: 30, scope: !142)
!204 = !DILocation(line: 101, column: 40, scope: !142)
!205 = !DILocation(line: 101, column: 50, scope: !142)
!206 = !DILocation(line: 101, column: 66, scope: !142)
!207 = !DILocation(line: 102, column: 30, scope: !142)
!208 = !DILocation(line: 106, column: 17, scope: !149)
!209 = !DILocation(line: 106, column: 26, scope: !153)
!210 = !DILocation(line: 107, column: 21, scope: !151)
!211 = !DILocation(line: 108, column: 20, scope: !155)
!212 = !DILocation(line: 109, column: 27, scope: !155)
!213 = !DILocation(line: 109, column: 20, scope: !155)
!214 = !DILocation(line: 110, column: 32, scope: !155)
!215 = !DILocation(line: 110, column: 24, scope: !155)
!216 = !DILocation(line: 110, column: 13, scope: !155)
!217 = !DILocation(line: 110, column: 30, scope: !155)
!218 = !DILocation(line: 111, column: 13, scope: !155)
!219 = !DILocation(line: 111, column: 21, scope: !155)
!220 = !DILocation(line: 107, column: 36, scope: !156)
!221 = !DILocation(line: 107, column: 30, scope: !156)
!222 = !DILocation(line: 106, column: 32, scope: !153)
!223 = !DILocation(line: 116, column: 1, scope: !142)
