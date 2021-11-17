; ModuleID = 'mm.c'
source_filename = "mm.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.block = type { i64, %union.anon }
%union.anon = type { %struct.anon }
%struct.anon = type { %struct.block*, %struct.block* }

@seg_list = internal unnamed_addr global [14 x %struct.block*] zeroinitializer, align 16, !dbg !0
@heap_start = internal unnamed_addr global %struct.block* null, align 8, !dbg !52
@heap_epi = internal unnamed_addr global %struct.block* null, align 8, !dbg !54

; Function Attrs: nounwind readnone uwtable
define dso_local zeroext i1 @mm_checkheap(i32) local_unnamed_addr #0 !dbg !65 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !70, metadata !DIExpression()), !dbg !71
  ret i1 true, !dbg !72
}

; Function Attrs: nounwind uwtable
define dso_local zeroext i1 @mm_init() local_unnamed_addr #1 !dbg !73 {
  %1 = tail call i8* @mem_sbrk(i64 16) #5, !dbg !80
  %2 = icmp eq i8* %1, inttoptr (i64 -1 to i8*), !dbg !81
  br i1 %2, label %17, label %3, !dbg !83

; <label>:3:                                      ; preds = %0
  call void @llvm.dbg.value(metadata i8* %1, metadata !77, metadata !DIExpression()), !dbg !84
  call void @llvm.memset.p0i8.i64(i8* align 16 bitcast ([14 x %struct.block*]* @seg_list to i8*), i8 0, i64 112, i1 false), !dbg !85
  %4 = getelementptr inbounds i8, i8* %1, i64 8, !dbg !88
  %5 = bitcast i8* %1 to <2 x i64>*, !dbg !89
  store <2 x i64> <i64 1, i64 3>, <2 x i64>* %5, align 8, !dbg !89, !tbaa !90
  store i8* %4, i8** bitcast (%struct.block** @heap_start to i8**), align 8, !dbg !94, !tbaa !95
  store i8* %4, i8** bitcast (%struct.block** @heap_epi to i8**), align 8, !dbg !97, !tbaa !95
  call void @llvm.dbg.value(metadata i64 1024, metadata !98, metadata !DIExpression()) #5, !dbg !106
  call void @llvm.dbg.value(metadata i64 1024, metadata !98, metadata !DIExpression()) #5, !dbg !106
  %6 = tail call i8* @mem_sbrk(i64 1024) #5, !dbg !109
  call void @llvm.dbg.value(metadata i8* %6, metadata !103, metadata !DIExpression()) #5, !dbg !111
  %7 = icmp eq i8* %6, inttoptr (i64 -1 to i8*), !dbg !112
  br i1 %7, label %17, label %8, !dbg !113

; <label>:8:                                      ; preds = %3
  call void @llvm.dbg.value(metadata i64 2, metadata !104, metadata !DIExpression()) #5, !dbg !114
  call void @llvm.dbg.value(metadata i8* %6, metadata !115, metadata !DIExpression()) #5, !dbg !120
  %9 = getelementptr inbounds i8, i8* %6, i64 -8, !dbg !122
  %10 = bitcast i8* %9 to %struct.block*, !dbg !123
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !105, metadata !DIExpression()) #5, !dbg !124
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !125, metadata !DIExpression()) #5, !dbg !133
  call void @llvm.dbg.value(metadata i64 1024, metadata !130, metadata !DIExpression()) #5, !dbg !135
  call void @llvm.dbg.value(metadata i64 2, metadata !131, metadata !DIExpression()) #5, !dbg !136
  %11 = bitcast i8* %9 to i64*, !dbg !137
  store i64 1026, i64* %11, align 8, !dbg !138, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !141, metadata !DIExpression()) #5, !dbg !146
  %12 = getelementptr inbounds i8, i8* %6, i64 1008, !dbg !148
  call void @llvm.dbg.value(metadata i8* %12, metadata !132, metadata !DIExpression()) #5, !dbg !149
  call void @llvm.dbg.value(metadata %struct.block* %10, metadata !150, metadata !DIExpression()) #5, !dbg !155
  %13 = getelementptr inbounds i8, i8* %6, i64 1016, !dbg !157
  store i8* %13, i8** bitcast (%struct.block** @heap_epi to i8**), align 8, !dbg !158, !tbaa !95
  %14 = bitcast i8* %12 to <2 x i64>*, !dbg !159
  store <2 x i64> <i64 1026, i64 1>, <2 x i64>* %14, align 8, !dbg !159, !tbaa !90
  %15 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %10) #5, !dbg !160
  call void @llvm.dbg.value(metadata %struct.block* %15, metadata !105, metadata !DIExpression()) #5, !dbg !124
  %16 = icmp ne %struct.block* %15, null
  br label %17

; <label>:17:                                     ; preds = %8, %3, %0
  %18 = phi i1 [ false, %0 ], [ %16, %8 ], [ false, %3 ], !dbg !161
  ret i1 %18, !dbg !162
}

declare dso_local i8* @mem_sbrk(i64) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_malloc(i64) local_unnamed_addr #1 !dbg !163 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !167, metadata !DIExpression()), !dbg !173
  call void @llvm.dbg.value(metadata i8* null, metadata !171, metadata !DIExpression()), !dbg !174
  %2 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !175, !tbaa !95
  %3 = icmp eq %struct.block* %2, null, !dbg !177
  br i1 %3, label %4, label %20, !dbg !178

; <label>:4:                                      ; preds = %1
  %5 = tail call i8* @mem_sbrk(i64 16) #5, !dbg !179
  %6 = icmp eq i8* %5, inttoptr (i64 -1 to i8*), !dbg !182
  br i1 %6, label %20, label %7, !dbg !183

; <label>:7:                                      ; preds = %4
  call void @llvm.dbg.value(metadata i8* %5, metadata !77, metadata !DIExpression()) #5, !dbg !184
  tail call void @llvm.memset.p0i8.i64(i8* align 16 bitcast ([14 x %struct.block*]* @seg_list to i8*), i8 0, i64 112, i1 false) #5, !dbg !185
  %8 = getelementptr inbounds i8, i8* %5, i64 8, !dbg !186
  %9 = bitcast i8* %5 to <2 x i64>*, !dbg !187
  store <2 x i64> <i64 1, i64 3>, <2 x i64>* %9, align 8, !dbg !187, !tbaa !90
  store i8* %8, i8** bitcast (%struct.block** @heap_start to i8**), align 8, !dbg !188, !tbaa !95
  store i8* %8, i8** bitcast (%struct.block** @heap_epi to i8**), align 8, !dbg !189, !tbaa !95
  call void @llvm.dbg.value(metadata i64 1024, metadata !98, metadata !DIExpression()) #5, !dbg !190
  call void @llvm.dbg.value(metadata i64 1024, metadata !98, metadata !DIExpression()) #5, !dbg !190
  %10 = tail call i8* @mem_sbrk(i64 1024) #5, !dbg !192
  call void @llvm.dbg.value(metadata i8* %10, metadata !103, metadata !DIExpression()) #5, !dbg !193
  %11 = icmp eq i8* %10, inttoptr (i64 -1 to i8*), !dbg !194
  br i1 %11, label %20, label %12, !dbg !195

; <label>:12:                                     ; preds = %7
  call void @llvm.dbg.value(metadata i64 2, metadata !104, metadata !DIExpression()) #5, !dbg !196
  call void @llvm.dbg.value(metadata i8* %10, metadata !115, metadata !DIExpression()) #5, !dbg !197
  %13 = getelementptr inbounds i8, i8* %10, i64 -8, !dbg !199
  %14 = bitcast i8* %13 to %struct.block*, !dbg !200
  call void @llvm.dbg.value(metadata %struct.block* %14, metadata !105, metadata !DIExpression()) #5, !dbg !201
  call void @llvm.dbg.value(metadata %struct.block* %14, metadata !125, metadata !DIExpression()) #5, !dbg !202
  call void @llvm.dbg.value(metadata i64 1024, metadata !130, metadata !DIExpression()) #5, !dbg !204
  call void @llvm.dbg.value(metadata i64 2, metadata !131, metadata !DIExpression()) #5, !dbg !205
  %15 = bitcast i8* %13 to i64*, !dbg !206
  store i64 1026, i64* %15, align 8, !dbg !207, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %14, metadata !141, metadata !DIExpression()) #5, !dbg !208
  %16 = getelementptr inbounds i8, i8* %10, i64 1008, !dbg !210
  call void @llvm.dbg.value(metadata i8* %16, metadata !132, metadata !DIExpression()) #5, !dbg !211
  call void @llvm.dbg.value(metadata %struct.block* %14, metadata !150, metadata !DIExpression()) #5, !dbg !212
  %17 = getelementptr inbounds i8, i8* %10, i64 1016, !dbg !214
  store i8* %17, i8** bitcast (%struct.block** @heap_epi to i8**), align 8, !dbg !215, !tbaa !95
  %18 = bitcast i8* %16 to <2 x i64>*, !dbg !216
  store <2 x i64> <i64 1026, i64 1>, <2 x i64>* %18, align 8, !dbg !216, !tbaa !90
  %19 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %14) #5, !dbg !217
  call void @llvm.dbg.value(metadata %struct.block* %19, metadata !105, metadata !DIExpression()) #5, !dbg !201
  br label %20

; <label>:20:                                     ; preds = %12, %7, %4, %1
  %21 = icmp eq i64 %0, 0, !dbg !218
  br i1 %21, label %276, label %22, !dbg !220

; <label>:22:                                     ; preds = %20
  %23 = icmp ult i64 %0, 17, !dbg !221
  br i1 %23, label %53, label %24, !dbg !223

; <label>:24:                                     ; preds = %22
  call void @llvm.dbg.value(metadata i64 %0, metadata !224, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !230
  call void @llvm.dbg.value(metadata i64 16, metadata !229, metadata !DIExpression()), !dbg !232
  %25 = add i64 %0, 23, !dbg !233
  %26 = and i64 %25, -16, !dbg !234
  call void @llvm.dbg.value(metadata i64 %26, metadata !168, metadata !DIExpression()), !dbg !235
  call void @llvm.dbg.value(metadata i64 %26, metadata !168, metadata !DIExpression()), !dbg !235
  call void @llvm.dbg.value(metadata i64 %26, metadata !236, metadata !DIExpression()), !dbg !242
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !239, metadata !DIExpression()), !dbg !245
  call void @llvm.dbg.value(metadata i64 %26, metadata !246, metadata !DIExpression()), !dbg !251
  %27 = icmp ult i64 %26, 32, !dbg !253
  br i1 %27, label %53, label %28, !dbg !255

; <label>:28:                                     ; preds = %24
  %29 = icmp ult i64 %26, 64, !dbg !256
  br i1 %29, label %53, label %30, !dbg !258

; <label>:30:                                     ; preds = %28
  %31 = icmp ult i64 %26, 128, !dbg !259
  br i1 %31, label %53, label %32, !dbg !261

; <label>:32:                                     ; preds = %30
  %33 = icmp ult i64 %26, 256, !dbg !262
  br i1 %33, label %53, label %34, !dbg !264

; <label>:34:                                     ; preds = %32
  %35 = icmp ult i64 %26, 512, !dbg !265
  br i1 %35, label %53, label %36, !dbg !267

; <label>:36:                                     ; preds = %34
  %37 = icmp ult i64 %26, 1024, !dbg !268
  br i1 %37, label %53, label %38, !dbg !270

; <label>:38:                                     ; preds = %36
  %39 = icmp ult i64 %26, 2048, !dbg !271
  br i1 %39, label %53, label %40, !dbg !273

; <label>:40:                                     ; preds = %38
  %41 = icmp ult i64 %26, 4096, !dbg !274
  br i1 %41, label %53, label %42, !dbg !276

; <label>:42:                                     ; preds = %40
  %43 = icmp ult i64 %26, 8192, !dbg !277
  br i1 %43, label %53, label %44, !dbg !279

; <label>:44:                                     ; preds = %42
  %45 = icmp ult i64 %26, 16384, !dbg !280
  br i1 %45, label %53, label %46, !dbg !282

; <label>:46:                                     ; preds = %44
  %47 = icmp ult i64 %26, 32768, !dbg !283
  br i1 %47, label %53, label %48, !dbg !285

; <label>:48:                                     ; preds = %46
  %49 = icmp ult i64 %26, 65536, !dbg !286
  br i1 %49, label %53, label %50, !dbg !288

; <label>:50:                                     ; preds = %48
  %51 = icmp ult i64 %26, 131072, !dbg !289
  %52 = select i1 %51, i64 12, i64 13, !dbg !291
  br label %53, !dbg !291

; <label>:53:                                     ; preds = %22, %50, %48, %46, %44, %42, %40, %38, %36, %34, %32, %30, %28, %24
  %54 = phi i64 [ %26, %24 ], [ %26, %28 ], [ %26, %30 ], [ %26, %32 ], [ %26, %34 ], [ %26, %36 ], [ %26, %38 ], [ %26, %40 ], [ %26, %42 ], [ %26, %44 ], [ %26, %46 ], [ %26, %48 ], [ %26, %50 ], [ 32, %22 ]
  %55 = phi i64 [ 0, %24 ], [ 1, %28 ], [ 2, %30 ], [ 3, %32 ], [ 4, %34 ], [ 5, %36 ], [ 6, %38 ], [ 7, %40 ], [ 8, %42 ], [ 9, %44 ], [ 10, %46 ], [ 11, %48 ], [ %52, %50 ], [ 1, %22 ], !dbg !292
  call void @llvm.dbg.value(metadata i64 %55, metadata !240, metadata !DIExpression()), !dbg !293
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !239, metadata !DIExpression()), !dbg !245
  br label %56, !dbg !294

; <label>:56:                                     ; preds = %80, %53
  %57 = phi i64 [ %55, %53 ], [ %81, %80 ]
  call void @llvm.dbg.value(metadata i64 %57, metadata !240, metadata !DIExpression()), !dbg !293
  %58 = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %57, !dbg !295
  %59 = load %struct.block*, %struct.block** %58, align 8, !dbg !295, !tbaa !95
  call void @llvm.dbg.value(metadata %struct.block* %59, metadata !298, metadata !DIExpression()), !dbg !308
  call void @llvm.dbg.value(metadata i64 %26, metadata !303, metadata !DIExpression()), !dbg !310
  call void @llvm.dbg.value(metadata i64 -1, metadata !306, metadata !DIExpression()), !dbg !311
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !305, metadata !DIExpression()), !dbg !312
  %60 = icmp eq %struct.block* %59, null, !dbg !313
  br i1 %60, label %80, label %61, !dbg !315

; <label>:61:                                     ; preds = %56, %69
  %62 = phi i64 [ %74, %69 ], [ -1, %56 ]
  %63 = phi %struct.block* [ %73, %69 ], [ null, %56 ]
  %64 = phi %struct.block* [ %76, %69 ], [ %59, %56 ]
  call void @llvm.dbg.value(metadata i64 %62, metadata !306, metadata !DIExpression()), !dbg !311
  call void @llvm.dbg.value(metadata %struct.block* %63, metadata !305, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata %struct.block* %64, metadata !304, metadata !DIExpression()), !dbg !316
  %65 = getelementptr %struct.block, %struct.block* %64, i64 0, i32 0
  %66 = load i64, i64* %65, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %66, metadata !317, metadata !DIExpression()), !dbg !322
  %67 = and i64 %66, -16, !dbg !333
  call void @llvm.dbg.value(metadata i64 %67, metadata !307, metadata !DIExpression()), !dbg !334
  %68 = icmp eq i64 %67, %54, !dbg !335
  br i1 %68, label %106, label %69, !dbg !337

; <label>:69:                                     ; preds = %61
  %70 = icmp ugt i64 %67, %54, !dbg !338
  %71 = icmp ult i64 %67, %62, !dbg !340
  %72 = and i1 %70, %71, !dbg !341
  call void @llvm.dbg.value(metadata i64 %67, metadata !306, metadata !DIExpression()), !dbg !311
  call void @llvm.dbg.value(metadata %struct.block* %64, metadata !305, metadata !DIExpression()), !dbg !312
  %73 = select i1 %72, %struct.block* %64, %struct.block* %63, !dbg !341
  %74 = select i1 %72, i64 %67, i64 %62, !dbg !341
  %75 = getelementptr inbounds %struct.block, %struct.block* %64, i64 0, i32 1, i32 0, i32 1, !dbg !342
  %76 = load %struct.block*, %struct.block** %75, align 8, !dbg !342, !tbaa !343
  call void @llvm.dbg.value(metadata i64 %74, metadata !306, metadata !DIExpression()), !dbg !311
  call void @llvm.dbg.value(metadata %struct.block* %73, metadata !305, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata %struct.block* %76, metadata !304, metadata !DIExpression()), !dbg !316
  %77 = icmp eq %struct.block* %76, null, !dbg !344
  br i1 %77, label %78, label %61, !dbg !345, !llvm.loop !346

; <label>:78:                                     ; preds = %69
  call void @llvm.dbg.value(metadata %struct.block* %73, metadata !239, metadata !DIExpression()), !dbg !245
  %79 = icmp eq %struct.block* %73, null, !dbg !349
  br i1 %79, label %80, label %106, !dbg !351

; <label>:80:                                     ; preds = %78, %56
  %81 = add nuw nsw i64 %57, 1, !dbg !352
  call void @llvm.dbg.value(metadata i64 %81, metadata !240, metadata !DIExpression()), !dbg !293
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !239, metadata !DIExpression()), !dbg !245
  %82 = icmp ult i64 %81, 14, !dbg !353
  br i1 %82, label %56, label %83, !dbg !294, !llvm.loop !354

; <label>:83:                                     ; preds = %80
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !170, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i64 %26, metadata !358, metadata !DIExpression()), !dbg !362
  call void @llvm.dbg.value(metadata i64 1024, metadata !361, metadata !DIExpression()), !dbg !365
  %84 = icmp ugt i64 %54, 1024, !dbg !366
  %85 = select i1 %84, i64 %54, i64 1024, !dbg !367
  call void @llvm.dbg.value(metadata i64 %85, metadata !169, metadata !DIExpression()), !dbg !368
  call void @llvm.dbg.value(metadata i64 %85, metadata !98, metadata !DIExpression()) #5, !dbg !369
  %86 = load %struct.block*, %struct.block** @heap_epi, align 8, !dbg !371, !tbaa !95
  %87 = getelementptr %struct.block, %struct.block* %86, i64 0, i32 0
  %88 = load i64, i64* %87, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %88, metadata !372, metadata !DIExpression()) #5, !dbg !377
  call void @llvm.dbg.value(metadata i64 %85, metadata !224, metadata !DIExpression()) #5, !dbg !385
  call void @llvm.dbg.value(metadata i64 16, metadata !229, metadata !DIExpression()) #5, !dbg !387
  call void @llvm.dbg.value(metadata i64 %85, metadata !98, metadata !DIExpression()) #5, !dbg !369
  %89 = tail call i8* @mem_sbrk(i64 %85) #5, !dbg !388
  call void @llvm.dbg.value(metadata i8* %89, metadata !103, metadata !DIExpression()) #5, !dbg !389
  %90 = icmp eq i8* %89, inttoptr (i64 -1 to i8*), !dbg !390
  br i1 %90, label %276, label %91, !dbg !391

; <label>:91:                                     ; preds = %83
  %92 = and i64 %88, 2, !dbg !392
  call void @llvm.dbg.value(metadata i64 %92, metadata !104, metadata !DIExpression()) #5, !dbg !393
  call void @llvm.dbg.value(metadata i8* %89, metadata !115, metadata !DIExpression()) #5, !dbg !394
  %93 = getelementptr inbounds i8, i8* %89, i64 -8, !dbg !396
  %94 = bitcast i8* %93 to %struct.block*, !dbg !397
  call void @llvm.dbg.value(metadata %struct.block* %94, metadata !105, metadata !DIExpression()) #5, !dbg !398
  call void @llvm.dbg.value(metadata %struct.block* %94, metadata !125, metadata !DIExpression()) #5, !dbg !399
  call void @llvm.dbg.value(metadata i64 %85, metadata !130, metadata !DIExpression()) #5, !dbg !401
  call void @llvm.dbg.value(metadata i64 %92, metadata !131, metadata !DIExpression()) #5, !dbg !402
  call void @llvm.dbg.value(metadata i64 %85, metadata !403, metadata !DIExpression()) #5, !dbg !410
  call void @llvm.dbg.value(metadata i64 %92, metadata !408, metadata !DIExpression()) #5, !dbg !412
  call void @llvm.dbg.value(metadata i64 %85, metadata !409, metadata !DIExpression()) #5, !dbg !413
  %95 = or i64 %92, %85, !dbg !414
  call void @llvm.dbg.value(metadata i64 %95, metadata !409, metadata !DIExpression()) #5, !dbg !413
  call void @llvm.dbg.value(metadata i64 %95, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !413
  call void @llvm.dbg.value(metadata i64 %95, metadata !409, metadata !DIExpression()) #5, !dbg !413
  %96 = bitcast i8* %93 to i64*, !dbg !415
  store i64 %95, i64* %96, align 8, !dbg !416, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %94, metadata !141, metadata !DIExpression()) #5, !dbg !417
  call void @llvm.dbg.value(metadata i64 %95, metadata !317, metadata !DIExpression()) #5, !dbg !419
  %97 = getelementptr inbounds i8, i8* %89, i64 %85, !dbg !422
  %98 = getelementptr inbounds i8, i8* %97, i64 -16, !dbg !423
  %99 = bitcast i8* %98 to i64*, !dbg !424
  call void @llvm.dbg.value(metadata i64* %99, metadata !132, metadata !DIExpression()) #5, !dbg !425
  call void @llvm.dbg.value(metadata i64 %85, metadata !403, metadata !DIExpression()) #5, !dbg !426
  call void @llvm.dbg.value(metadata i64 %92, metadata !408, metadata !DIExpression()) #5, !dbg !428
  call void @llvm.dbg.value(metadata i64 %85, metadata !409, metadata !DIExpression()) #5, !dbg !429
  call void @llvm.dbg.value(metadata i64 %95, metadata !409, metadata !DIExpression()) #5, !dbg !429
  call void @llvm.dbg.value(metadata i64 %95, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !429
  call void @llvm.dbg.value(metadata i64 %95, metadata !409, metadata !DIExpression()) #5, !dbg !429
  store i64 %95, i64* %99, align 8, !dbg !430, !tbaa !90
  call void @llvm.dbg.value(metadata %struct.block* %94, metadata !150, metadata !DIExpression()) #5, !dbg !431
  %100 = load i64, i64* %96, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %100, metadata !317, metadata !DIExpression()) #5, !dbg !433
  %101 = and i64 %100, -16, !dbg !436
  %102 = getelementptr inbounds i8, i8* %93, i64 %101, !dbg !437
  store i8* %102, i8** bitcast (%struct.block** @heap_epi to i8**), align 8, !dbg !438, !tbaa !95
  call void @llvm.dbg.value(metadata i64 0, metadata !403, metadata !DIExpression()) #5, !dbg !439
  call void @llvm.dbg.value(metadata i64 1, metadata !408, metadata !DIExpression()) #5, !dbg !441
  call void @llvm.dbg.value(metadata i64 0, metadata !409, metadata !DIExpression()) #5, !dbg !442
  call void @llvm.dbg.value(metadata i64 0, metadata !409, metadata !DIExpression()) #5, !dbg !442
  call void @llvm.dbg.value(metadata i64 0, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !442
  call void @llvm.dbg.value(metadata i64 1, metadata !409, metadata !DIExpression()) #5, !dbg !442
  %103 = bitcast i8* %102 to i64*, !dbg !443
  store i64 1, i64* %103, align 8, !dbg !444, !tbaa !139
  %104 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %94) #5, !dbg !445
  call void @llvm.dbg.value(metadata %struct.block* %104, metadata !105, metadata !DIExpression()) #5, !dbg !398
  call void @llvm.dbg.value(metadata %struct.block* %104, metadata !170, metadata !DIExpression()), !dbg !357
  %105 = icmp eq %struct.block* %104, null, !dbg !446
  br i1 %105, label %276, label %106, !dbg !448

; <label>:106:                                    ; preds = %78, %61, %91
  %107 = phi %struct.block* [ %104, %91 ], [ %64, %61 ], [ %73, %78 ], !dbg !449
  call void @llvm.dbg.value(metadata %struct.block* %107, metadata !170, metadata !DIExpression()), !dbg !357
  %108 = getelementptr %struct.block, %struct.block* %107, i64 0, i32 0
  %109 = load i64, i64* %108, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %109, metadata !317, metadata !DIExpression()), !dbg !450
  %110 = and i64 %109, -16, !dbg !453
  call void @llvm.dbg.value(metadata i64 %110, metadata !172, metadata !DIExpression()), !dbg !454
  call void @llvm.dbg.value(metadata i64 %109, metadata !372, metadata !DIExpression()), !dbg !455
  call void @llvm.dbg.value(metadata %struct.block* %107, metadata !125, metadata !DIExpression()), !dbg !458
  call void @llvm.dbg.value(metadata i64 %110, metadata !130, metadata !DIExpression()), !dbg !460
  call void @llvm.dbg.value(metadata i64 %109, metadata !131, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !461
  call void @llvm.dbg.value(metadata i64 %110, metadata !403, metadata !DIExpression()), !dbg !462
  call void @llvm.dbg.value(metadata i64 %109, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !464
  call void @llvm.dbg.value(metadata i64 %110, metadata !409, metadata !DIExpression()), !dbg !465
  %111 = and i64 %109, -14, !dbg !466
  call void @llvm.dbg.value(metadata i64 %111, metadata !409, metadata !DIExpression()), !dbg !465
  call void @llvm.dbg.value(metadata i64 %111, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !465
  %112 = or i64 %111, 1, !dbg !467
  call void @llvm.dbg.value(metadata i64 %112, metadata !409, metadata !DIExpression()), !dbg !465
  store i64 %112, i64* %108, align 8, !dbg !468, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %107, metadata !141, metadata !DIExpression()), !dbg !469
  %113 = getelementptr inbounds %struct.block, %struct.block* %107, i64 0, i32 1, !dbg !471
  %114 = bitcast %union.anon* %113 to i8*, !dbg !472
  call void @llvm.dbg.value(metadata i64 %112, metadata !317, metadata !DIExpression()), !dbg !473
  %115 = getelementptr inbounds i8, i8* %114, i64 %110, !dbg !476
  %116 = getelementptr inbounds i8, i8* %115, i64 -16, !dbg !477
  %117 = bitcast i8* %116 to i64*, !dbg !478
  call void @llvm.dbg.value(metadata i64* %117, metadata !132, metadata !DIExpression()), !dbg !479
  call void @llvm.dbg.value(metadata i64 %110, metadata !403, metadata !DIExpression()), !dbg !480
  call void @llvm.dbg.value(metadata i64 %109, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !482
  call void @llvm.dbg.value(metadata i64 %110, metadata !409, metadata !DIExpression()), !dbg !483
  call void @llvm.dbg.value(metadata i64 %111, metadata !409, metadata !DIExpression()), !dbg !483
  call void @llvm.dbg.value(metadata i64 %111, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !483
  call void @llvm.dbg.value(metadata i64 %112, metadata !409, metadata !DIExpression()), !dbg !483
  store i64 %112, i64* %117, align 8, !dbg !484, !tbaa !90
  call void @llvm.dbg.value(metadata %struct.block* %107, metadata !485, metadata !DIExpression()) #5, !dbg !494
  call void @llvm.dbg.value(metadata i64 %26, metadata !490, metadata !DIExpression()) #5, !dbg !496
  %118 = load i64, i64* %108, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %118, metadata !317, metadata !DIExpression()) #5, !dbg !497
  %119 = and i64 %118, -16, !dbg !500
  call void @llvm.dbg.value(metadata i64 %119, metadata !492, metadata !DIExpression()) #5, !dbg !501
  %120 = sub i64 %119, %54, !dbg !502
  call void @llvm.dbg.value(metadata i64 %120, metadata !493, metadata !DIExpression()) #5, !dbg !503
  %121 = icmp ugt i64 %120, 31, !dbg !504
  br i1 %121, label %122, label %220, !dbg !506

; <label>:122:                                    ; preds = %106
  call void @llvm.dbg.value(metadata %struct.block* %107, metadata !507, metadata !DIExpression()) #5, !dbg !515
  call void @llvm.dbg.value(metadata i64 %118, metadata !317, metadata !DIExpression()) #5, !dbg !518
  call void @llvm.dbg.value(metadata i64 %119, metadata !246, metadata !DIExpression()) #5, !dbg !521
  %123 = icmp ult i64 %119, 32, !dbg !523
  br i1 %123, label %149, label %124, !dbg !524

; <label>:124:                                    ; preds = %122
  %125 = icmp ult i64 %119, 64, !dbg !525
  br i1 %125, label %149, label %126, !dbg !526

; <label>:126:                                    ; preds = %124
  %127 = icmp ult i64 %119, 128, !dbg !527
  br i1 %127, label %149, label %128, !dbg !528

; <label>:128:                                    ; preds = %126
  %129 = icmp ult i64 %119, 256, !dbg !529
  br i1 %129, label %149, label %130, !dbg !530

; <label>:130:                                    ; preds = %128
  %131 = icmp ult i64 %119, 512, !dbg !531
  br i1 %131, label %149, label %132, !dbg !532

; <label>:132:                                    ; preds = %130
  %133 = icmp ult i64 %119, 1024, !dbg !533
  br i1 %133, label %149, label %134, !dbg !534

; <label>:134:                                    ; preds = %132
  %135 = icmp ult i64 %119, 2048, !dbg !535
  br i1 %135, label %149, label %136, !dbg !536

; <label>:136:                                    ; preds = %134
  %137 = icmp ult i64 %119, 4096, !dbg !537
  br i1 %137, label %149, label %138, !dbg !538

; <label>:138:                                    ; preds = %136
  %139 = icmp ult i64 %119, 8192, !dbg !539
  br i1 %139, label %149, label %140, !dbg !540

; <label>:140:                                    ; preds = %138
  %141 = icmp ult i64 %119, 16384, !dbg !541
  br i1 %141, label %149, label %142, !dbg !542

; <label>:142:                                    ; preds = %140
  %143 = icmp ult i64 %119, 32768, !dbg !543
  br i1 %143, label %149, label %144, !dbg !544

; <label>:144:                                    ; preds = %142
  %145 = icmp ult i64 %119, 65536, !dbg !545
  br i1 %145, label %149, label %146, !dbg !546

; <label>:146:                                    ; preds = %144
  %147 = icmp ult i64 %119, 131072, !dbg !547
  %148 = select i1 %147, i64 12, i64 13, !dbg !548
  br label %149, !dbg !548

; <label>:149:                                    ; preds = %146, %144, %142, %140, %138, %136, %134, %132, %130, %128, %126, %124, %122
  %150 = phi i64 [ 0, %122 ], [ 1, %124 ], [ 2, %126 ], [ 3, %128 ], [ 4, %130 ], [ 5, %132 ], [ 6, %134 ], [ 7, %136 ], [ 8, %138 ], [ 9, %140 ], [ 10, %142 ], [ 11, %144 ], [ %148, %146 ], !dbg !549
  call void @llvm.dbg.value(metadata i64 %150, metadata !512, metadata !DIExpression()) #5, !dbg !550
  %151 = getelementptr inbounds %struct.block, %struct.block* %107, i64 0, i32 1, i32 0, i32 0, !dbg !551
  %152 = load %struct.block*, %struct.block** %151, align 8, !dbg !551, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %152, metadata !513, metadata !DIExpression()) #5, !dbg !552
  %153 = getelementptr inbounds %struct.block, %struct.block* %107, i64 0, i32 1, i32 0, i32 1, !dbg !553
  %154 = load %struct.block*, %struct.block** %153, align 8, !dbg !553, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %154, metadata !514, metadata !DIExpression()) #5, !dbg !554
  %155 = icmp eq %struct.block* %152, null, !dbg !555
  %156 = icmp eq %struct.block* %154, null, !dbg !557
  br i1 %155, label %157, label %162, !dbg !559

; <label>:157:                                    ; preds = %149
  %158 = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %150, !dbg !560
  br i1 %156, label %159, label %160, !dbg !564

; <label>:159:                                    ; preds = %157
  store %struct.block* null, %struct.block** %158, align 8, !dbg !565, !tbaa !95
  br label %168, !dbg !567

; <label>:160:                                    ; preds = %157
  store %struct.block* %154, %struct.block** %158, align 8, !dbg !568, !tbaa !95
  %161 = getelementptr inbounds %struct.block, %struct.block* %154, i64 0, i32 1, i32 0, i32 0, !dbg !569
  store %struct.block* null, %struct.block** %161, align 8, !dbg !570, !tbaa !343
  br label %168

; <label>:162:                                    ; preds = %149
  br i1 %156, label %163, label %165, !dbg !571

; <label>:163:                                    ; preds = %162
  %164 = getelementptr inbounds %struct.block, %struct.block* %152, i64 0, i32 1, i32 0, i32 1, !dbg !572
  store %struct.block* null, %struct.block** %164, align 8, !dbg !574, !tbaa !343
  br label %168, !dbg !575

; <label>:165:                                    ; preds = %162
  %166 = getelementptr inbounds %struct.block, %struct.block* %154, i64 0, i32 1, i32 0, i32 0, !dbg !576
  store %struct.block* %152, %struct.block** %166, align 8, !dbg !578, !tbaa !343
  %167 = getelementptr inbounds %struct.block, %struct.block* %152, i64 0, i32 1, i32 0, i32 1, !dbg !579
  store %struct.block* %154, %struct.block** %167, align 8, !dbg !580, !tbaa !343
  br label %168

; <label>:168:                                    ; preds = %165, %163, %160, %159
  %169 = bitcast %struct.block** %151 to i8*, !dbg !581
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %169, i8 0, i64 16, i1 false) #5, !dbg !582
  call void @llvm.dbg.value(metadata i64 %26, metadata !403, metadata !DIExpression()) #5, !dbg !583
  call void @llvm.dbg.value(metadata i64 3, metadata !408, metadata !DIExpression()) #5, !dbg !585
  call void @llvm.dbg.value(metadata i64 %26, metadata !409, metadata !DIExpression()) #5, !dbg !586
  call void @llvm.dbg.value(metadata i64 %26, metadata !409, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #5, !dbg !586
  call void @llvm.dbg.value(metadata i64 %26, metadata !409, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !586
  %170 = or i64 %54, 3, !dbg !587
  call void @llvm.dbg.value(metadata i64 %170, metadata !409, metadata !DIExpression()) #5, !dbg !586
  store i64 %170, i64* %108, align 8, !dbg !588, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %107, metadata !150, metadata !DIExpression()) #5, !dbg !589
  %171 = bitcast %struct.block* %107 to i8*, !dbg !591
  call void @llvm.dbg.value(metadata i64 %170, metadata !317, metadata !DIExpression()) #5, !dbg !592
  %172 = getelementptr inbounds i8, i8* %171, i64 %54, !dbg !595
  call void @llvm.dbg.value(metadata i8* %172, metadata !491, metadata !DIExpression()) #5, !dbg !596
  call void @llvm.dbg.value(metadata i8* %172, metadata !125, metadata !DIExpression()) #5, !dbg !597
  call void @llvm.dbg.value(metadata i64 %120, metadata !130, metadata !DIExpression()) #5, !dbg !599
  call void @llvm.dbg.value(metadata i64 2, metadata !131, metadata !DIExpression()) #5, !dbg !600
  call void @llvm.dbg.value(metadata i64 %120, metadata !403, metadata !DIExpression()) #5, !dbg !601
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()) #5, !dbg !603
  call void @llvm.dbg.value(metadata i64 %120, metadata !409, metadata !DIExpression()) #5, !dbg !604
  %173 = or i64 %120, 2, !dbg !605
  call void @llvm.dbg.value(metadata i64 %173, metadata !409, metadata !DIExpression()) #5, !dbg !604
  call void @llvm.dbg.value(metadata i64 %173, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !604
  call void @llvm.dbg.value(metadata i64 %173, metadata !409, metadata !DIExpression()) #5, !dbg !604
  %174 = bitcast i8* %172 to i64*, !dbg !606
  store i64 %173, i64* %174, align 8, !dbg !607, !tbaa !139
  call void @llvm.dbg.value(metadata i8* %172, metadata !141, metadata !DIExpression()) #5, !dbg !608
  %175 = getelementptr inbounds i8, i8* %172, i64 8, !dbg !610
  call void @llvm.dbg.value(metadata i64 %173, metadata !317, metadata !DIExpression()) #5, !dbg !611
  %176 = getelementptr inbounds i8, i8* %175, i64 %120, !dbg !614
  %177 = getelementptr inbounds i8, i8* %176, i64 -16, !dbg !615
  %178 = bitcast i8* %177 to i64*, !dbg !616
  call void @llvm.dbg.value(metadata i64* %178, metadata !132, metadata !DIExpression()) #5, !dbg !617
  call void @llvm.dbg.value(metadata i64 %120, metadata !403, metadata !DIExpression()) #5, !dbg !618
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()) #5, !dbg !620
  call void @llvm.dbg.value(metadata i64 %120, metadata !409, metadata !DIExpression()) #5, !dbg !621
  call void @llvm.dbg.value(metadata i64 %173, metadata !409, metadata !DIExpression()) #5, !dbg !621
  call void @llvm.dbg.value(metadata i64 %173, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !621
  call void @llvm.dbg.value(metadata i64 %173, metadata !409, metadata !DIExpression()) #5, !dbg !621
  store i64 %173, i64* %178, align 8, !dbg !622, !tbaa !90
  call void @llvm.dbg.value(metadata i8* %172, metadata !623, metadata !DIExpression()) #5, !dbg !628
  call void @llvm.dbg.value(metadata i64 %120, metadata !626, metadata !DIExpression()) #5, !dbg !630
  call void @llvm.dbg.value(metadata i64 %120, metadata !246, metadata !DIExpression()) #5, !dbg !631
  %179 = icmp ult i64 %120, 64, !dbg !633
  br i1 %179, label %203, label %180, !dbg !634

; <label>:180:                                    ; preds = %168
  %181 = icmp ult i64 %120, 128, !dbg !635
  br i1 %181, label %203, label %182, !dbg !636

; <label>:182:                                    ; preds = %180
  %183 = icmp ult i64 %120, 256, !dbg !637
  br i1 %183, label %203, label %184, !dbg !638

; <label>:184:                                    ; preds = %182
  %185 = icmp ult i64 %120, 512, !dbg !639
  br i1 %185, label %203, label %186, !dbg !640

; <label>:186:                                    ; preds = %184
  %187 = icmp ult i64 %120, 1024, !dbg !641
  br i1 %187, label %203, label %188, !dbg !642

; <label>:188:                                    ; preds = %186
  %189 = icmp ult i64 %120, 2048, !dbg !643
  br i1 %189, label %203, label %190, !dbg !644

; <label>:190:                                    ; preds = %188
  %191 = icmp ult i64 %120, 4096, !dbg !645
  br i1 %191, label %203, label %192, !dbg !646

; <label>:192:                                    ; preds = %190
  %193 = icmp ult i64 %120, 8192, !dbg !647
  br i1 %193, label %203, label %194, !dbg !648

; <label>:194:                                    ; preds = %192
  %195 = icmp ult i64 %120, 16384, !dbg !649
  br i1 %195, label %203, label %196, !dbg !650

; <label>:196:                                    ; preds = %194
  %197 = icmp ult i64 %120, 32768, !dbg !651
  br i1 %197, label %203, label %198, !dbg !652

; <label>:198:                                    ; preds = %196
  %199 = icmp ult i64 %120, 65536, !dbg !653
  br i1 %199, label %203, label %200, !dbg !654

; <label>:200:                                    ; preds = %198
  %201 = icmp ult i64 %120, 131072, !dbg !655
  %202 = select i1 %201, i64 12, i64 13, !dbg !656
  br label %203, !dbg !656

; <label>:203:                                    ; preds = %200, %198, %196, %194, %192, %190, %188, %186, %184, %182, %180, %168
  %204 = phi i64 [ 1, %168 ], [ 2, %180 ], [ 3, %182 ], [ 4, %184 ], [ 5, %186 ], [ 6, %188 ], [ 7, %190 ], [ 8, %192 ], [ 9, %194 ], [ 10, %196 ], [ 11, %198 ], [ %202, %200 ], !dbg !657
  call void @llvm.dbg.value(metadata i64 %204, metadata !627, metadata !DIExpression()) #5, !dbg !658
  %205 = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %204, !dbg !659
  %206 = load %struct.block*, %struct.block** %205, align 8, !dbg !659, !tbaa !95
  %207 = icmp eq %struct.block* %206, null, !dbg !661
  %208 = bitcast i8* %175 to %struct.block**, !dbg !662
  store %struct.block* null, %struct.block** %208, align 8, !dbg !662, !tbaa !343
  br i1 %207, label %209, label %212, !dbg !664

; <label>:209:                                    ; preds = %203
  %210 = getelementptr inbounds i8, i8* %172, i64 16, !dbg !665
  %211 = bitcast i8* %210 to %struct.block**, !dbg !665
  store %struct.block* null, %struct.block** %211, align 8, !dbg !667, !tbaa !343
  br label %218, !dbg !668

; <label>:212:                                    ; preds = %203
  %213 = ptrtoint %struct.block* %206 to i64, !dbg !664
  %214 = getelementptr inbounds i8, i8* %172, i64 16, !dbg !669
  %215 = bitcast i8* %214 to i64*, !dbg !670
  store i64 %213, i64* %215, align 8, !dbg !670, !tbaa !343
  %216 = getelementptr inbounds %struct.block, %struct.block* %206, i64 0, i32 1, i32 0, i32 0, !dbg !671
  %217 = bitcast %struct.block** %216 to i8**, !dbg !672
  store i8* %172, i8** %217, align 8, !dbg !672, !tbaa !343
  br label %218

; <label>:218:                                    ; preds = %212, %209
  %219 = bitcast %struct.block** %205 to i8**, !dbg !673
  store i8* %172, i8** %219, align 8, !dbg !673, !tbaa !95
  br label %276, !dbg !674

; <label>:220:                                    ; preds = %106
  call void @llvm.dbg.value(metadata i64 %119, metadata !403, metadata !DIExpression()) #5, !dbg !675
  call void @llvm.dbg.value(metadata i64 3, metadata !408, metadata !DIExpression()) #5, !dbg !678
  call void @llvm.dbg.value(metadata i64 %119, metadata !409, metadata !DIExpression()) #5, !dbg !679
  call void @llvm.dbg.value(metadata i64 %119, metadata !409, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_stack_value)) #5, !dbg !679
  call void @llvm.dbg.value(metadata i64 %119, metadata !409, metadata !DIExpression(DW_OP_constu, 2, DW_OP_or, DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !679
  %221 = or i64 %119, 3, !dbg !680
  call void @llvm.dbg.value(metadata i64 %221, metadata !409, metadata !DIExpression()) #5, !dbg !679
  store i64 %221, i64* %108, align 8, !dbg !681, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %107, metadata !150, metadata !DIExpression()) #5, !dbg !682
  %222 = bitcast %struct.block* %107 to i8*, !dbg !684
  call void @llvm.dbg.value(metadata i64 %221, metadata !317, metadata !DIExpression()) #5, !dbg !685
  %223 = getelementptr inbounds i8, i8* %222, i64 %119, !dbg !688
  call void @llvm.dbg.value(metadata i8* %223, metadata !491, metadata !DIExpression()) #5, !dbg !596
  %224 = bitcast i8* %223 to i64*, !dbg !689
  %225 = load i64, i64* %224, align 8, !dbg !689, !tbaa !139
  %226 = or i64 %225, 2, !dbg !690
  store i64 %226, i64* %224, align 8, !dbg !691, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %107, metadata !507, metadata !DIExpression()) #5, !dbg !692
  %227 = load i64, i64* %108, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %227, metadata !317, metadata !DIExpression()) #5, !dbg !694
  %228 = and i64 %227, -16, !dbg !697
  call void @llvm.dbg.value(metadata i64 %228, metadata !246, metadata !DIExpression()) #5, !dbg !698
  %229 = icmp ult i64 %228, 32, !dbg !700
  br i1 %229, label %255, label %230, !dbg !701

; <label>:230:                                    ; preds = %220
  %231 = icmp ult i64 %228, 64, !dbg !702
  br i1 %231, label %255, label %232, !dbg !703

; <label>:232:                                    ; preds = %230
  %233 = icmp ult i64 %228, 128, !dbg !704
  br i1 %233, label %255, label %234, !dbg !705

; <label>:234:                                    ; preds = %232
  %235 = icmp ult i64 %228, 256, !dbg !706
  br i1 %235, label %255, label %236, !dbg !707

; <label>:236:                                    ; preds = %234
  %237 = icmp ult i64 %228, 512, !dbg !708
  br i1 %237, label %255, label %238, !dbg !709

; <label>:238:                                    ; preds = %236
  %239 = icmp ult i64 %228, 1024, !dbg !710
  br i1 %239, label %255, label %240, !dbg !711

; <label>:240:                                    ; preds = %238
  %241 = icmp ult i64 %228, 2048, !dbg !712
  br i1 %241, label %255, label %242, !dbg !713

; <label>:242:                                    ; preds = %240
  %243 = icmp ult i64 %228, 4096, !dbg !714
  br i1 %243, label %255, label %244, !dbg !715

; <label>:244:                                    ; preds = %242
  %245 = icmp ult i64 %228, 8192, !dbg !716
  br i1 %245, label %255, label %246, !dbg !717

; <label>:246:                                    ; preds = %244
  %247 = icmp ult i64 %228, 16384, !dbg !718
  br i1 %247, label %255, label %248, !dbg !719

; <label>:248:                                    ; preds = %246
  %249 = icmp ult i64 %228, 32768, !dbg !720
  br i1 %249, label %255, label %250, !dbg !721

; <label>:250:                                    ; preds = %248
  %251 = icmp ult i64 %228, 65536, !dbg !722
  br i1 %251, label %255, label %252, !dbg !723

; <label>:252:                                    ; preds = %250
  %253 = icmp ult i64 %228, 131072, !dbg !724
  %254 = select i1 %253, i64 12, i64 13, !dbg !725
  br label %255, !dbg !725

; <label>:255:                                    ; preds = %252, %250, %248, %246, %244, %242, %240, %238, %236, %234, %232, %230, %220
  %256 = phi i64 [ 0, %220 ], [ 1, %230 ], [ 2, %232 ], [ 3, %234 ], [ 4, %236 ], [ 5, %238 ], [ 6, %240 ], [ 7, %242 ], [ 8, %244 ], [ 9, %246 ], [ 10, %248 ], [ 11, %250 ], [ %254, %252 ], !dbg !726
  call void @llvm.dbg.value(metadata i64 %256, metadata !512, metadata !DIExpression()) #5, !dbg !727
  %257 = getelementptr inbounds %struct.block, %struct.block* %107, i64 0, i32 1, i32 0, i32 0, !dbg !728
  %258 = load %struct.block*, %struct.block** %257, align 8, !dbg !728, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %258, metadata !513, metadata !DIExpression()) #5, !dbg !729
  %259 = getelementptr inbounds %struct.block, %struct.block* %107, i64 0, i32 1, i32 0, i32 1, !dbg !730
  %260 = load %struct.block*, %struct.block** %259, align 8, !dbg !730, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %260, metadata !514, metadata !DIExpression()) #5, !dbg !731
  %261 = icmp eq %struct.block* %258, null, !dbg !732
  %262 = icmp eq %struct.block* %260, null, !dbg !733
  br i1 %261, label %263, label %268, !dbg !734

; <label>:263:                                    ; preds = %255
  %264 = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %256, !dbg !735
  br i1 %262, label %265, label %266, !dbg !736

; <label>:265:                                    ; preds = %263
  store %struct.block* null, %struct.block** %264, align 8, !dbg !737, !tbaa !95
  br label %274, !dbg !738

; <label>:266:                                    ; preds = %263
  store %struct.block* %260, %struct.block** %264, align 8, !dbg !739, !tbaa !95
  %267 = getelementptr inbounds %struct.block, %struct.block* %260, i64 0, i32 1, i32 0, i32 0, !dbg !740
  store %struct.block* null, %struct.block** %267, align 8, !dbg !741, !tbaa !343
  br label %274

; <label>:268:                                    ; preds = %255
  br i1 %262, label %269, label %271, !dbg !742

; <label>:269:                                    ; preds = %268
  %270 = getelementptr inbounds %struct.block, %struct.block* %258, i64 0, i32 1, i32 0, i32 1, !dbg !743
  store %struct.block* null, %struct.block** %270, align 8, !dbg !744, !tbaa !343
  br label %274, !dbg !745

; <label>:271:                                    ; preds = %268
  %272 = getelementptr inbounds %struct.block, %struct.block* %260, i64 0, i32 1, i32 0, i32 0, !dbg !746
  store %struct.block* %258, %struct.block** %272, align 8, !dbg !747, !tbaa !343
  %273 = getelementptr inbounds %struct.block, %struct.block* %258, i64 0, i32 1, i32 0, i32 1, !dbg !748
  store %struct.block* %260, %struct.block** %273, align 8, !dbg !749, !tbaa !343
  br label %274

; <label>:274:                                    ; preds = %271, %269, %266, %265
  %275 = bitcast %struct.block** %257 to i8*, !dbg !750
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %275, i8 0, i64 16, i1 false) #5, !dbg !751
  br label %276

; <label>:276:                                    ; preds = %83, %274, %218, %91, %20
  %277 = phi i8* [ null, %20 ], [ null, %91 ], [ %114, %218 ], [ %114, %274 ], [ null, %83 ], !dbg !752
  ret i8* %277, !dbg !753
}

; Function Attrs: nounwind uwtable
define dso_local void @mm_free(i8*) local_unnamed_addr #1 !dbg !754 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !758, metadata !DIExpression()), !dbg !761
  %2 = icmp eq i8* %0, null, !dbg !762
  br i1 %2, label %14, label %3, !dbg !764

; <label>:3:                                      ; preds = %1
  call void @llvm.dbg.value(metadata i8* %0, metadata !115, metadata !DIExpression()), !dbg !765
  %4 = getelementptr inbounds i8, i8* %0, i64 -8, !dbg !767
  %5 = bitcast i8* %4 to %struct.block*, !dbg !768
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !759, metadata !DIExpression()), !dbg !769
  %6 = bitcast i8* %4 to i64*
  %7 = load i64, i64* %6, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %7, metadata !317, metadata !DIExpression()), !dbg !770
  %8 = and i64 %7, -16, !dbg !773
  call void @llvm.dbg.value(metadata i64 %8, metadata !760, metadata !DIExpression()), !dbg !774
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !125, metadata !DIExpression()), !dbg !775
  call void @llvm.dbg.value(metadata i64 %8, metadata !130, metadata !DIExpression()), !dbg !777
  call void @llvm.dbg.value(metadata i64 %7, metadata !131, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)), !dbg !778
  call void @llvm.dbg.value(metadata i64 %8, metadata !403, metadata !DIExpression()), !dbg !779
  call void @llvm.dbg.value(metadata i64 %7, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)), !dbg !781
  call void @llvm.dbg.value(metadata i64 %8, metadata !409, metadata !DIExpression()), !dbg !782
  %9 = and i64 %7, -14, !dbg !783
  call void @llvm.dbg.value(metadata i64 %9, metadata !409, metadata !DIExpression()), !dbg !782
  call void @llvm.dbg.value(metadata i64 %9, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !782
  call void @llvm.dbg.value(metadata i64 %9, metadata !409, metadata !DIExpression()), !dbg !782
  store i64 %9, i64* %6, align 8, !dbg !784, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %5, metadata !141, metadata !DIExpression()), !dbg !785
  call void @llvm.dbg.value(metadata i64 %9, metadata !317, metadata !DIExpression()), !dbg !787
  %10 = getelementptr inbounds i8, i8* %0, i64 %8, !dbg !790
  %11 = getelementptr inbounds i8, i8* %10, i64 -16, !dbg !791
  %12 = bitcast i8* %11 to i64*, !dbg !792
  call void @llvm.dbg.value(metadata i64* %12, metadata !132, metadata !DIExpression()), !dbg !793
  call void @llvm.dbg.value(metadata i64 %8, metadata !403, metadata !DIExpression()), !dbg !794
  call void @llvm.dbg.value(metadata i64 %7, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)), !dbg !796
  call void @llvm.dbg.value(metadata i64 %8, metadata !409, metadata !DIExpression()), !dbg !797
  call void @llvm.dbg.value(metadata i64 %9, metadata !409, metadata !DIExpression()), !dbg !797
  call void @llvm.dbg.value(metadata i64 %9, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !797
  call void @llvm.dbg.value(metadata i64 %9, metadata !409, metadata !DIExpression()), !dbg !797
  store i64 %9, i64* %12, align 8, !dbg !798, !tbaa !90
  %13 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %5), !dbg !799
  br label %14, !dbg !800

; <label>:14:                                     ; preds = %1, %3
  ret void, !dbg !800
}

; Function Attrs: nounwind uwtable
define internal fastcc %struct.block* @coalesce_block(%struct.block*) unnamed_addr #1 !dbg !801 {
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !803, metadata !DIExpression()), !dbg !809
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !150, metadata !DIExpression()), !dbg !810
  %2 = bitcast %struct.block* %0 to i8*, !dbg !812
  %3 = getelementptr %struct.block, %struct.block* %0, i64 0, i32 0
  %4 = load i64, i64* %3, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %4, metadata !317, metadata !DIExpression()), !dbg !813
  %5 = and i64 %4, -16, !dbg !816
  %6 = getelementptr inbounds i8, i8* %2, i64 %5, !dbg !817
  call void @llvm.dbg.value(metadata i8* %6, metadata !805, metadata !DIExpression()), !dbg !818
  call void @llvm.dbg.value(metadata i64 %4, metadata !372, metadata !DIExpression()), !dbg !819
  %7 = and i64 %4, 2, !dbg !822
  %8 = icmp ne i64 %7, 0, !dbg !823
  %9 = bitcast i8* %6 to i64*
  %10 = load i64, i64* %9, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %10, metadata !824, metadata !DIExpression()), !dbg !829
  %11 = and i64 %10, 1, !dbg !837
  %12 = icmp ne i64 %11, 0, !dbg !838
  call void @llvm.dbg.value(metadata i64 %4, metadata !317, metadata !DIExpression()), !dbg !839
  call void @llvm.dbg.value(metadata i64 %5, metadata !808, metadata !DIExpression()), !dbg !842
  %13 = xor i1 %8, true, !dbg !843
  %14 = xor i1 %12, true, !dbg !843
  %15 = or i1 %13, %14, !dbg !843
  br i1 %15, label %25, label %16, !dbg !843

; <label>:16:                                     ; preds = %1
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !125, metadata !DIExpression()), !dbg !845
  call void @llvm.dbg.value(metadata i64 %5, metadata !130, metadata !DIExpression()), !dbg !848
  call void @llvm.dbg.value(metadata i64 2, metadata !131, metadata !DIExpression()), !dbg !849
  call void @llvm.dbg.value(metadata i64 %5, metadata !403, metadata !DIExpression()), !dbg !850
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()), !dbg !852
  call void @llvm.dbg.value(metadata i64 %5, metadata !409, metadata !DIExpression()), !dbg !853
  %17 = or i64 %5, 2, !dbg !854
  call void @llvm.dbg.value(metadata i64 %17, metadata !409, metadata !DIExpression()), !dbg !853
  call void @llvm.dbg.value(metadata i64 %17, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !853
  call void @llvm.dbg.value(metadata i64 %17, metadata !409, metadata !DIExpression()), !dbg !853
  store i64 %17, i64* %3, align 8, !dbg !855, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !141, metadata !DIExpression()), !dbg !856
  %18 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, !dbg !858
  %19 = bitcast %union.anon* %18 to i8*, !dbg !859
  call void @llvm.dbg.value(metadata i64 %17, metadata !317, metadata !DIExpression()), !dbg !860
  %20 = getelementptr inbounds i8, i8* %19, i64 %5, !dbg !863
  %21 = getelementptr inbounds i8, i8* %20, i64 -16, !dbg !864
  %22 = bitcast i8* %21 to i64*, !dbg !865
  call void @llvm.dbg.value(metadata i64* %22, metadata !132, metadata !DIExpression()), !dbg !866
  call void @llvm.dbg.value(metadata i64 %5, metadata !403, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()), !dbg !869
  call void @llvm.dbg.value(metadata i64 %5, metadata !409, metadata !DIExpression()), !dbg !870
  call void @llvm.dbg.value(metadata i64 %17, metadata !409, metadata !DIExpression()), !dbg !870
  call void @llvm.dbg.value(metadata i64 %17, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !870
  call void @llvm.dbg.value(metadata i64 %17, metadata !409, metadata !DIExpression()), !dbg !870
  store i64 %17, i64* %22, align 8, !dbg !871, !tbaa !90
  %23 = load i64, i64* %9, align 8, !dbg !872, !tbaa !139
  %24 = and i64 %23, -3, !dbg !873
  store i64 %24, i64* %9, align 8, !dbg !874, !tbaa !139
  br label %275, !dbg !875

; <label>:25:                                     ; preds = %1
  %26 = or i1 %8, %14, !dbg !876
  br i1 %26, label %95, label %27, !dbg !876

; <label>:27:                                     ; preds = %25
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !878, metadata !DIExpression()), !dbg !882
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !885, metadata !DIExpression()), !dbg !888
  %28 = getelementptr inbounds i64, i64* %3, i64 -1, !dbg !890
  call void @llvm.dbg.value(metadata i64* %28, metadata !881, metadata !DIExpression()), !dbg !891
  %29 = load i64, i64* %28, align 8, !dbg !892, !tbaa !90
  call void @llvm.dbg.value(metadata i64 %29, metadata !317, metadata !DIExpression()), !dbg !894
  %30 = and i64 %29, -16, !dbg !896
  %31 = icmp eq i64 %30, 0, !dbg !897
  call void @llvm.dbg.value(metadata i64* %28, metadata !898, metadata !DIExpression()), !dbg !904
  call void @llvm.dbg.value(metadata i64 %29, metadata !317, metadata !DIExpression()), !dbg !906
  call void @llvm.dbg.value(metadata i64 %30, metadata !903, metadata !DIExpression()), !dbg !908
  %32 = sub i64 0, %30, !dbg !909
  %33 = getelementptr inbounds i8, i8* %2, i64 %32, !dbg !909
  %34 = bitcast i8* %33 to %struct.block*, !dbg !910
  %35 = select i1 %31, %struct.block* null, %struct.block* %34, !dbg !911
  call void @llvm.dbg.value(metadata %struct.block* %35, metadata !804, metadata !DIExpression()), !dbg !912
  %36 = getelementptr %struct.block, %struct.block* %35, i64 0, i32 0
  %37 = load i64, i64* %36, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %37, metadata !317, metadata !DIExpression()), !dbg !913
  %38 = and i64 %37, -16, !dbg !916
  %39 = add i64 %38, %5, !dbg !917
  call void @llvm.dbg.value(metadata i64 %39, metadata !808, metadata !DIExpression()), !dbg !842
  call void @llvm.dbg.value(metadata %struct.block* %35, metadata !507, metadata !DIExpression()) #5, !dbg !918
  call void @llvm.dbg.value(metadata i64 %37, metadata !317, metadata !DIExpression()) #5, !dbg !920
  call void @llvm.dbg.value(metadata i64 %38, metadata !246, metadata !DIExpression()) #5, !dbg !923
  %40 = icmp ult i64 %38, 32, !dbg !925
  br i1 %40, label %66, label %41, !dbg !926

; <label>:41:                                     ; preds = %27
  %42 = icmp ult i64 %38, 64, !dbg !927
  br i1 %42, label %66, label %43, !dbg !928

; <label>:43:                                     ; preds = %41
  %44 = icmp ult i64 %38, 128, !dbg !929
  br i1 %44, label %66, label %45, !dbg !930

; <label>:45:                                     ; preds = %43
  %46 = icmp ult i64 %38, 256, !dbg !931
  br i1 %46, label %66, label %47, !dbg !932

; <label>:47:                                     ; preds = %45
  %48 = icmp ult i64 %38, 512, !dbg !933
  br i1 %48, label %66, label %49, !dbg !934

; <label>:49:                                     ; preds = %47
  %50 = icmp ult i64 %38, 1024, !dbg !935
  br i1 %50, label %66, label %51, !dbg !936

; <label>:51:                                     ; preds = %49
  %52 = icmp ult i64 %38, 2048, !dbg !937
  br i1 %52, label %66, label %53, !dbg !938

; <label>:53:                                     ; preds = %51
  %54 = icmp ult i64 %38, 4096, !dbg !939
  br i1 %54, label %66, label %55, !dbg !940

; <label>:55:                                     ; preds = %53
  %56 = icmp ult i64 %38, 8192, !dbg !941
  br i1 %56, label %66, label %57, !dbg !942

; <label>:57:                                     ; preds = %55
  %58 = icmp ult i64 %38, 16384, !dbg !943
  br i1 %58, label %66, label %59, !dbg !944

; <label>:59:                                     ; preds = %57
  %60 = icmp ult i64 %38, 32768, !dbg !945
  br i1 %60, label %66, label %61, !dbg !946

; <label>:61:                                     ; preds = %59
  %62 = icmp ult i64 %38, 65536, !dbg !947
  br i1 %62, label %66, label %63, !dbg !948

; <label>:63:                                     ; preds = %61
  %64 = icmp ult i64 %38, 131072, !dbg !949
  %65 = select i1 %64, i64 12, i64 13, !dbg !950
  br label %66, !dbg !950

; <label>:66:                                     ; preds = %63, %61, %59, %57, %55, %53, %51, %49, %47, %45, %43, %41, %27
  %67 = phi i64 [ 0, %27 ], [ 1, %41 ], [ 2, %43 ], [ 3, %45 ], [ 4, %47 ], [ 5, %49 ], [ 6, %51 ], [ 7, %53 ], [ 8, %55 ], [ 9, %57 ], [ 10, %59 ], [ 11, %61 ], [ %65, %63 ], !dbg !951
  call void @llvm.dbg.value(metadata i64 %67, metadata !512, metadata !DIExpression()) #5, !dbg !952
  %68 = getelementptr inbounds %struct.block, %struct.block* %35, i64 0, i32 1, i32 0, i32 0, !dbg !953
  %69 = load %struct.block*, %struct.block** %68, align 8, !dbg !953, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %69, metadata !513, metadata !DIExpression()) #5, !dbg !954
  %70 = getelementptr inbounds %struct.block, %struct.block* %35, i64 0, i32 1, i32 0, i32 1, !dbg !955
  %71 = load %struct.block*, %struct.block** %70, align 8, !dbg !955, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %71, metadata !514, metadata !DIExpression()) #5, !dbg !956
  %72 = icmp eq %struct.block* %69, null, !dbg !957
  %73 = icmp eq %struct.block* %71, null, !dbg !958
  br i1 %72, label %74, label %79, !dbg !959

; <label>:74:                                     ; preds = %66
  %75 = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %67, !dbg !960
  br i1 %73, label %76, label %77, !dbg !961

; <label>:76:                                     ; preds = %74
  store %struct.block* null, %struct.block** %75, align 8, !dbg !962, !tbaa !95
  br label %85, !dbg !963

; <label>:77:                                     ; preds = %74
  store %struct.block* %71, %struct.block** %75, align 8, !dbg !964, !tbaa !95
  %78 = getelementptr inbounds %struct.block, %struct.block* %71, i64 0, i32 1, i32 0, i32 0, !dbg !965
  store %struct.block* null, %struct.block** %78, align 8, !dbg !966, !tbaa !343
  br label %85

; <label>:79:                                     ; preds = %66
  br i1 %73, label %80, label %82, !dbg !967

; <label>:80:                                     ; preds = %79
  %81 = getelementptr inbounds %struct.block, %struct.block* %69, i64 0, i32 1, i32 0, i32 1, !dbg !968
  store %struct.block* null, %struct.block** %81, align 8, !dbg !969, !tbaa !343
  br label %85, !dbg !970

; <label>:82:                                     ; preds = %79
  %83 = getelementptr inbounds %struct.block, %struct.block* %71, i64 0, i32 1, i32 0, i32 0, !dbg !971
  store %struct.block* %69, %struct.block** %83, align 8, !dbg !972, !tbaa !343
  %84 = getelementptr inbounds %struct.block, %struct.block* %69, i64 0, i32 1, i32 0, i32 1, !dbg !973
  store %struct.block* %71, %struct.block** %84, align 8, !dbg !974, !tbaa !343
  br label %85

; <label>:85:                                     ; preds = %76, %77, %80, %82
  %86 = bitcast %struct.block** %68 to i8*, !dbg !975
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %86, i8 0, i64 16, i1 false) #5, !dbg !976
  call void @llvm.dbg.value(metadata %struct.block* %35, metadata !125, metadata !DIExpression()), !dbg !977
  call void @llvm.dbg.value(metadata i64 %39, metadata !130, metadata !DIExpression()), !dbg !979
  call void @llvm.dbg.value(metadata i64 2, metadata !131, metadata !DIExpression()), !dbg !980
  call void @llvm.dbg.value(metadata i64 %39, metadata !403, metadata !DIExpression()), !dbg !981
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()), !dbg !983
  call void @llvm.dbg.value(metadata i64 %39, metadata !409, metadata !DIExpression()), !dbg !984
  %87 = or i64 %39, 2, !dbg !985
  call void @llvm.dbg.value(metadata i64 %87, metadata !409, metadata !DIExpression()), !dbg !984
  call void @llvm.dbg.value(metadata i64 %87, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !984
  call void @llvm.dbg.value(metadata i64 %87, metadata !409, metadata !DIExpression()), !dbg !984
  store i64 %87, i64* %36, align 8, !dbg !986, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %35, metadata !141, metadata !DIExpression()), !dbg !987
  %88 = getelementptr inbounds %struct.block, %struct.block* %35, i64 0, i32 1, !dbg !989
  %89 = bitcast %union.anon* %88 to i8*, !dbg !990
  call void @llvm.dbg.value(metadata i64 %87, metadata !317, metadata !DIExpression()), !dbg !991
  %90 = getelementptr inbounds i8, i8* %89, i64 %39, !dbg !994
  %91 = getelementptr inbounds i8, i8* %90, i64 -16, !dbg !995
  %92 = bitcast i8* %91 to i64*, !dbg !996
  call void @llvm.dbg.value(metadata i64* %92, metadata !132, metadata !DIExpression()), !dbg !997
  call void @llvm.dbg.value(metadata i64 %39, metadata !403, metadata !DIExpression()), !dbg !998
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()), !dbg !1000
  call void @llvm.dbg.value(metadata i64 %39, metadata !409, metadata !DIExpression()), !dbg !1001
  call void @llvm.dbg.value(metadata i64 %87, metadata !409, metadata !DIExpression()), !dbg !1001
  call void @llvm.dbg.value(metadata i64 %87, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1001
  call void @llvm.dbg.value(metadata i64 %87, metadata !409, metadata !DIExpression()), !dbg !1001
  store i64 %87, i64* %92, align 8, !dbg !1002, !tbaa !90
  %93 = load i64, i64* %9, align 8, !dbg !1003, !tbaa !139
  %94 = and i64 %93, -3, !dbg !1004
  store i64 %94, i64* %9, align 8, !dbg !1005, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %35, metadata !803, metadata !DIExpression()), !dbg !809
  br label %275, !dbg !1006

; <label>:95:                                     ; preds = %25
  %96 = or i1 %12, %13, !dbg !1007
  br i1 %96, label %154, label %97, !dbg !1007

; <label>:97:                                     ; preds = %95
  call void @llvm.dbg.value(metadata i64 %10, metadata !317, metadata !DIExpression()), !dbg !1009
  %98 = and i64 %10, -16, !dbg !1013
  %99 = add i64 %98, %5, !dbg !1014
  call void @llvm.dbg.value(metadata i64 %99, metadata !808, metadata !DIExpression()), !dbg !842
  call void @llvm.dbg.value(metadata i8* %6, metadata !507, metadata !DIExpression()) #5, !dbg !1015
  call void @llvm.dbg.value(metadata i64 %10, metadata !317, metadata !DIExpression()) #5, !dbg !1017
  call void @llvm.dbg.value(metadata i64 %98, metadata !246, metadata !DIExpression()) #5, !dbg !1020
  %100 = icmp ult i64 %98, 32, !dbg !1022
  br i1 %100, label %126, label %101, !dbg !1023

; <label>:101:                                    ; preds = %97
  %102 = icmp ult i64 %98, 64, !dbg !1024
  br i1 %102, label %126, label %103, !dbg !1025

; <label>:103:                                    ; preds = %101
  %104 = icmp ult i64 %98, 128, !dbg !1026
  br i1 %104, label %126, label %105, !dbg !1027

; <label>:105:                                    ; preds = %103
  %106 = icmp ult i64 %98, 256, !dbg !1028
  br i1 %106, label %126, label %107, !dbg !1029

; <label>:107:                                    ; preds = %105
  %108 = icmp ult i64 %98, 512, !dbg !1030
  br i1 %108, label %126, label %109, !dbg !1031

; <label>:109:                                    ; preds = %107
  %110 = icmp ult i64 %98, 1024, !dbg !1032
  br i1 %110, label %126, label %111, !dbg !1033

; <label>:111:                                    ; preds = %109
  %112 = icmp ult i64 %98, 2048, !dbg !1034
  br i1 %112, label %126, label %113, !dbg !1035

; <label>:113:                                    ; preds = %111
  %114 = icmp ult i64 %98, 4096, !dbg !1036
  br i1 %114, label %126, label %115, !dbg !1037

; <label>:115:                                    ; preds = %113
  %116 = icmp ult i64 %98, 8192, !dbg !1038
  br i1 %116, label %126, label %117, !dbg !1039

; <label>:117:                                    ; preds = %115
  %118 = icmp ult i64 %98, 16384, !dbg !1040
  br i1 %118, label %126, label %119, !dbg !1041

; <label>:119:                                    ; preds = %117
  %120 = icmp ult i64 %98, 32768, !dbg !1042
  br i1 %120, label %126, label %121, !dbg !1043

; <label>:121:                                    ; preds = %119
  %122 = icmp ult i64 %98, 65536, !dbg !1044
  br i1 %122, label %126, label %123, !dbg !1045

; <label>:123:                                    ; preds = %121
  %124 = icmp ult i64 %98, 131072, !dbg !1046
  %125 = select i1 %124, i64 12, i64 13, !dbg !1047
  br label %126, !dbg !1047

; <label>:126:                                    ; preds = %123, %121, %119, %117, %115, %113, %111, %109, %107, %105, %103, %101, %97
  %127 = phi i64 [ 0, %97 ], [ 1, %101 ], [ 2, %103 ], [ 3, %105 ], [ 4, %107 ], [ 5, %109 ], [ 6, %111 ], [ 7, %113 ], [ 8, %115 ], [ 9, %117 ], [ 10, %119 ], [ 11, %121 ], [ %125, %123 ], !dbg !1048
  call void @llvm.dbg.value(metadata i64 %127, metadata !512, metadata !DIExpression()) #5, !dbg !1049
  %128 = getelementptr inbounds i8, i8* %6, i64 8, !dbg !1050
  %129 = bitcast i8* %128 to %struct.block**, !dbg !1050
  %130 = load %struct.block*, %struct.block** %129, align 8, !dbg !1050, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %130, metadata !513, metadata !DIExpression()) #5, !dbg !1051
  %131 = getelementptr inbounds i8, i8* %6, i64 16, !dbg !1052
  %132 = bitcast i8* %131 to %struct.block**, !dbg !1052
  %133 = load %struct.block*, %struct.block** %132, align 8, !dbg !1052, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %133, metadata !514, metadata !DIExpression()) #5, !dbg !1053
  %134 = icmp eq %struct.block* %130, null, !dbg !1054
  %135 = icmp eq %struct.block* %133, null, !dbg !1055
  br i1 %134, label %136, label %141, !dbg !1056

; <label>:136:                                    ; preds = %126
  %137 = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %127, !dbg !1057
  br i1 %135, label %138, label %139, !dbg !1058

; <label>:138:                                    ; preds = %136
  store %struct.block* null, %struct.block** %137, align 8, !dbg !1059, !tbaa !95
  br label %147, !dbg !1060

; <label>:139:                                    ; preds = %136
  store %struct.block* %133, %struct.block** %137, align 8, !dbg !1061, !tbaa !95
  %140 = getelementptr inbounds %struct.block, %struct.block* %133, i64 0, i32 1, i32 0, i32 0, !dbg !1062
  store %struct.block* null, %struct.block** %140, align 8, !dbg !1063, !tbaa !343
  br label %147

; <label>:141:                                    ; preds = %126
  br i1 %135, label %142, label %144, !dbg !1064

; <label>:142:                                    ; preds = %141
  %143 = getelementptr inbounds %struct.block, %struct.block* %130, i64 0, i32 1, i32 0, i32 1, !dbg !1065
  store %struct.block* null, %struct.block** %143, align 8, !dbg !1066, !tbaa !343
  br label %147, !dbg !1067

; <label>:144:                                    ; preds = %141
  %145 = getelementptr inbounds %struct.block, %struct.block* %133, i64 0, i32 1, i32 0, i32 0, !dbg !1068
  store %struct.block* %130, %struct.block** %145, align 8, !dbg !1069, !tbaa !343
  %146 = getelementptr inbounds %struct.block, %struct.block* %130, i64 0, i32 1, i32 0, i32 1, !dbg !1070
  store %struct.block* %133, %struct.block** %146, align 8, !dbg !1071, !tbaa !343
  br label %147

; <label>:147:                                    ; preds = %138, %139, %142, %144
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %128, i8 0, i64 16, i1 false) #5, !dbg !1072
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !125, metadata !DIExpression()), !dbg !1073
  call void @llvm.dbg.value(metadata i64 %99, metadata !130, metadata !DIExpression()), !dbg !1075
  call void @llvm.dbg.value(metadata i64 2, metadata !131, metadata !DIExpression()), !dbg !1076
  call void @llvm.dbg.value(metadata i64 %99, metadata !403, metadata !DIExpression()), !dbg !1077
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()), !dbg !1079
  call void @llvm.dbg.value(metadata i64 %99, metadata !409, metadata !DIExpression()), !dbg !1080
  %148 = or i64 %99, 2, !dbg !1081
  call void @llvm.dbg.value(metadata i64 %148, metadata !409, metadata !DIExpression()), !dbg !1080
  call void @llvm.dbg.value(metadata i64 %148, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1080
  call void @llvm.dbg.value(metadata i64 %148, metadata !409, metadata !DIExpression()), !dbg !1080
  store i64 %148, i64* %3, align 8, !dbg !1082, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !141, metadata !DIExpression()), !dbg !1083
  %149 = getelementptr inbounds %struct.block, %struct.block* %0, i64 0, i32 1, !dbg !1085
  %150 = bitcast %union.anon* %149 to i8*, !dbg !1086
  call void @llvm.dbg.value(metadata i64 %148, metadata !317, metadata !DIExpression()), !dbg !1087
  %151 = getelementptr inbounds i8, i8* %150, i64 %99, !dbg !1090
  %152 = getelementptr inbounds i8, i8* %151, i64 -16, !dbg !1091
  %153 = bitcast i8* %152 to i64*, !dbg !1092
  call void @llvm.dbg.value(metadata i64* %153, metadata !132, metadata !DIExpression()), !dbg !1093
  call void @llvm.dbg.value(metadata i64 %99, metadata !403, metadata !DIExpression()), !dbg !1094
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()), !dbg !1096
  call void @llvm.dbg.value(metadata i64 %99, metadata !409, metadata !DIExpression()), !dbg !1097
  call void @llvm.dbg.value(metadata i64 %148, metadata !409, metadata !DIExpression()), !dbg !1097
  call void @llvm.dbg.value(metadata i64 %148, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1097
  call void @llvm.dbg.value(metadata i64 %148, metadata !409, metadata !DIExpression()), !dbg !1097
  store i64 %148, i64* %153, align 8, !dbg !1098, !tbaa !90
  br label %275, !dbg !1099

; <label>:154:                                    ; preds = %95
  %155 = or i64 %11, %7, !dbg !1100
  %156 = icmp eq i64 %155, 0, !dbg !1100
  br i1 %156, label %157, label %275, !dbg !1100

; <label>:157:                                    ; preds = %154
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !878, metadata !DIExpression()), !dbg !1102
  call void @llvm.dbg.value(metadata %struct.block* %0, metadata !885, metadata !DIExpression()), !dbg !1105
  %158 = getelementptr inbounds i64, i64* %3, i64 -1, !dbg !1107
  call void @llvm.dbg.value(metadata i64* %158, metadata !881, metadata !DIExpression()), !dbg !1108
  %159 = load i64, i64* %158, align 8, !dbg !1109, !tbaa !90
  call void @llvm.dbg.value(metadata i64 %159, metadata !317, metadata !DIExpression()), !dbg !1110
  %160 = and i64 %159, -16, !dbg !1112
  %161 = icmp eq i64 %160, 0, !dbg !1113
  call void @llvm.dbg.value(metadata i64* %158, metadata !898, metadata !DIExpression()), !dbg !1114
  call void @llvm.dbg.value(metadata i64 %159, metadata !317, metadata !DIExpression()), !dbg !1116
  call void @llvm.dbg.value(metadata i64 %160, metadata !903, metadata !DIExpression()), !dbg !1118
  %162 = sub i64 0, %160, !dbg !1119
  %163 = getelementptr inbounds i8, i8* %2, i64 %162, !dbg !1119
  %164 = bitcast i8* %163 to %struct.block*, !dbg !1120
  %165 = select i1 %161, %struct.block* null, %struct.block* %164, !dbg !1121
  call void @llvm.dbg.value(metadata %struct.block* %165, metadata !804, metadata !DIExpression()), !dbg !912
  call void @llvm.dbg.value(metadata i64 %10, metadata !317, metadata !DIExpression()), !dbg !1122
  %166 = and i64 %10, -16, !dbg !1125
  %167 = add i64 %166, %5, !dbg !1126
  %168 = getelementptr %struct.block, %struct.block* %165, i64 0, i32 0
  %169 = load i64, i64* %168, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %169, metadata !317, metadata !DIExpression()), !dbg !1127
  %170 = and i64 %169, -16, !dbg !1130
  %171 = add i64 %167, %170, !dbg !1131
  call void @llvm.dbg.value(metadata i64 %171, metadata !808, metadata !DIExpression()), !dbg !842
  call void @llvm.dbg.value(metadata i8* %6, metadata !507, metadata !DIExpression()) #5, !dbg !1132
  call void @llvm.dbg.value(metadata i64 %10, metadata !317, metadata !DIExpression()) #5, !dbg !1134
  call void @llvm.dbg.value(metadata i64 %166, metadata !246, metadata !DIExpression()) #5, !dbg !1137
  %172 = icmp ult i64 %166, 32, !dbg !1139
  br i1 %172, label %198, label %173, !dbg !1140

; <label>:173:                                    ; preds = %157
  %174 = icmp ult i64 %166, 64, !dbg !1141
  br i1 %174, label %198, label %175, !dbg !1142

; <label>:175:                                    ; preds = %173
  %176 = icmp ult i64 %166, 128, !dbg !1143
  br i1 %176, label %198, label %177, !dbg !1144

; <label>:177:                                    ; preds = %175
  %178 = icmp ult i64 %166, 256, !dbg !1145
  br i1 %178, label %198, label %179, !dbg !1146

; <label>:179:                                    ; preds = %177
  %180 = icmp ult i64 %166, 512, !dbg !1147
  br i1 %180, label %198, label %181, !dbg !1148

; <label>:181:                                    ; preds = %179
  %182 = icmp ult i64 %166, 1024, !dbg !1149
  br i1 %182, label %198, label %183, !dbg !1150

; <label>:183:                                    ; preds = %181
  %184 = icmp ult i64 %166, 2048, !dbg !1151
  br i1 %184, label %198, label %185, !dbg !1152

; <label>:185:                                    ; preds = %183
  %186 = icmp ult i64 %166, 4096, !dbg !1153
  br i1 %186, label %198, label %187, !dbg !1154

; <label>:187:                                    ; preds = %185
  %188 = icmp ult i64 %166, 8192, !dbg !1155
  br i1 %188, label %198, label %189, !dbg !1156

; <label>:189:                                    ; preds = %187
  %190 = icmp ult i64 %166, 16384, !dbg !1157
  br i1 %190, label %198, label %191, !dbg !1158

; <label>:191:                                    ; preds = %189
  %192 = icmp ult i64 %166, 32768, !dbg !1159
  br i1 %192, label %198, label %193, !dbg !1160

; <label>:193:                                    ; preds = %191
  %194 = icmp ult i64 %166, 65536, !dbg !1161
  br i1 %194, label %198, label %195, !dbg !1162

; <label>:195:                                    ; preds = %193
  %196 = icmp ult i64 %166, 131072, !dbg !1163
  %197 = select i1 %196, i64 12, i64 13, !dbg !1164
  br label %198, !dbg !1164

; <label>:198:                                    ; preds = %195, %193, %191, %189, %187, %185, %183, %181, %179, %177, %175, %173, %157
  %199 = phi i64 [ 0, %157 ], [ 1, %173 ], [ 2, %175 ], [ 3, %177 ], [ 4, %179 ], [ 5, %181 ], [ 6, %183 ], [ 7, %185 ], [ 8, %187 ], [ 9, %189 ], [ 10, %191 ], [ 11, %193 ], [ %197, %195 ], !dbg !1165
  call void @llvm.dbg.value(metadata i64 %199, metadata !512, metadata !DIExpression()) #5, !dbg !1166
  %200 = getelementptr inbounds i8, i8* %6, i64 8, !dbg !1167
  %201 = bitcast i8* %200 to %struct.block**, !dbg !1167
  %202 = load %struct.block*, %struct.block** %201, align 8, !dbg !1167, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %202, metadata !513, metadata !DIExpression()) #5, !dbg !1168
  %203 = getelementptr inbounds i8, i8* %6, i64 16, !dbg !1169
  %204 = bitcast i8* %203 to %struct.block**, !dbg !1169
  %205 = load %struct.block*, %struct.block** %204, align 8, !dbg !1169, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %205, metadata !514, metadata !DIExpression()) #5, !dbg !1170
  %206 = icmp eq %struct.block* %202, null, !dbg !1171
  %207 = icmp eq %struct.block* %205, null, !dbg !1172
  br i1 %206, label %208, label %213, !dbg !1173

; <label>:208:                                    ; preds = %198
  %209 = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %199, !dbg !1174
  br i1 %207, label %210, label %211, !dbg !1175

; <label>:210:                                    ; preds = %208
  store %struct.block* null, %struct.block** %209, align 8, !dbg !1176, !tbaa !95
  br label %219, !dbg !1177

; <label>:211:                                    ; preds = %208
  store %struct.block* %205, %struct.block** %209, align 8, !dbg !1178, !tbaa !95
  %212 = getelementptr inbounds %struct.block, %struct.block* %205, i64 0, i32 1, i32 0, i32 0, !dbg !1179
  store %struct.block* null, %struct.block** %212, align 8, !dbg !1180, !tbaa !343
  br label %219

; <label>:213:                                    ; preds = %198
  br i1 %207, label %214, label %216, !dbg !1181

; <label>:214:                                    ; preds = %213
  %215 = getelementptr inbounds %struct.block, %struct.block* %202, i64 0, i32 1, i32 0, i32 1, !dbg !1182
  store %struct.block* null, %struct.block** %215, align 8, !dbg !1183, !tbaa !343
  br label %219, !dbg !1184

; <label>:216:                                    ; preds = %213
  %217 = getelementptr inbounds %struct.block, %struct.block* %205, i64 0, i32 1, i32 0, i32 0, !dbg !1185
  store %struct.block* %202, %struct.block** %217, align 8, !dbg !1186, !tbaa !343
  %218 = getelementptr inbounds %struct.block, %struct.block* %202, i64 0, i32 1, i32 0, i32 1, !dbg !1187
  store %struct.block* %205, %struct.block** %218, align 8, !dbg !1188, !tbaa !343
  br label %219

; <label>:219:                                    ; preds = %210, %211, %214, %216
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %200, i8 0, i64 16, i1 false) #5, !dbg !1189
  call void @llvm.dbg.value(metadata %struct.block* %165, metadata !507, metadata !DIExpression()) #5, !dbg !1190
  %220 = load i64, i64* %168, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %220, metadata !317, metadata !DIExpression()) #5, !dbg !1192
  %221 = and i64 %220, -16, !dbg !1195
  call void @llvm.dbg.value(metadata i64 %221, metadata !246, metadata !DIExpression()) #5, !dbg !1196
  %222 = icmp ult i64 %221, 32, !dbg !1198
  br i1 %222, label %248, label %223, !dbg !1199

; <label>:223:                                    ; preds = %219
  %224 = icmp ult i64 %221, 64, !dbg !1200
  br i1 %224, label %248, label %225, !dbg !1201

; <label>:225:                                    ; preds = %223
  %226 = icmp ult i64 %221, 128, !dbg !1202
  br i1 %226, label %248, label %227, !dbg !1203

; <label>:227:                                    ; preds = %225
  %228 = icmp ult i64 %221, 256, !dbg !1204
  br i1 %228, label %248, label %229, !dbg !1205

; <label>:229:                                    ; preds = %227
  %230 = icmp ult i64 %221, 512, !dbg !1206
  br i1 %230, label %248, label %231, !dbg !1207

; <label>:231:                                    ; preds = %229
  %232 = icmp ult i64 %221, 1024, !dbg !1208
  br i1 %232, label %248, label %233, !dbg !1209

; <label>:233:                                    ; preds = %231
  %234 = icmp ult i64 %221, 2048, !dbg !1210
  br i1 %234, label %248, label %235, !dbg !1211

; <label>:235:                                    ; preds = %233
  %236 = icmp ult i64 %221, 4096, !dbg !1212
  br i1 %236, label %248, label %237, !dbg !1213

; <label>:237:                                    ; preds = %235
  %238 = icmp ult i64 %221, 8192, !dbg !1214
  br i1 %238, label %248, label %239, !dbg !1215

; <label>:239:                                    ; preds = %237
  %240 = icmp ult i64 %221, 16384, !dbg !1216
  br i1 %240, label %248, label %241, !dbg !1217

; <label>:241:                                    ; preds = %239
  %242 = icmp ult i64 %221, 32768, !dbg !1218
  br i1 %242, label %248, label %243, !dbg !1219

; <label>:243:                                    ; preds = %241
  %244 = icmp ult i64 %221, 65536, !dbg !1220
  br i1 %244, label %248, label %245, !dbg !1221

; <label>:245:                                    ; preds = %243
  %246 = icmp ult i64 %221, 131072, !dbg !1222
  %247 = select i1 %246, i64 12, i64 13, !dbg !1223
  br label %248, !dbg !1223

; <label>:248:                                    ; preds = %245, %243, %241, %239, %237, %235, %233, %231, %229, %227, %225, %223, %219
  %249 = phi i64 [ 0, %219 ], [ 1, %223 ], [ 2, %225 ], [ 3, %227 ], [ 4, %229 ], [ 5, %231 ], [ 6, %233 ], [ 7, %235 ], [ 8, %237 ], [ 9, %239 ], [ 10, %241 ], [ 11, %243 ], [ %247, %245 ], !dbg !1224
  call void @llvm.dbg.value(metadata i64 %249, metadata !512, metadata !DIExpression()) #5, !dbg !1225
  %250 = getelementptr inbounds %struct.block, %struct.block* %165, i64 0, i32 1, i32 0, i32 0, !dbg !1226
  %251 = load %struct.block*, %struct.block** %250, align 8, !dbg !1226, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %251, metadata !513, metadata !DIExpression()) #5, !dbg !1227
  %252 = getelementptr inbounds %struct.block, %struct.block* %165, i64 0, i32 1, i32 0, i32 1, !dbg !1228
  %253 = load %struct.block*, %struct.block** %252, align 8, !dbg !1228, !tbaa !343
  call void @llvm.dbg.value(metadata %struct.block* %253, metadata !514, metadata !DIExpression()) #5, !dbg !1229
  %254 = icmp eq %struct.block* %251, null, !dbg !1230
  %255 = icmp eq %struct.block* %253, null, !dbg !1231
  br i1 %254, label %256, label %261, !dbg !1232

; <label>:256:                                    ; preds = %248
  %257 = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %249, !dbg !1233
  br i1 %255, label %258, label %259, !dbg !1234

; <label>:258:                                    ; preds = %256
  store %struct.block* null, %struct.block** %257, align 8, !dbg !1235, !tbaa !95
  br label %267, !dbg !1236

; <label>:259:                                    ; preds = %256
  store %struct.block* %253, %struct.block** %257, align 8, !dbg !1237, !tbaa !95
  %260 = getelementptr inbounds %struct.block, %struct.block* %253, i64 0, i32 1, i32 0, i32 0, !dbg !1238
  store %struct.block* null, %struct.block** %260, align 8, !dbg !1239, !tbaa !343
  br label %267

; <label>:261:                                    ; preds = %248
  br i1 %255, label %262, label %264, !dbg !1240

; <label>:262:                                    ; preds = %261
  %263 = getelementptr inbounds %struct.block, %struct.block* %251, i64 0, i32 1, i32 0, i32 1, !dbg !1241
  store %struct.block* null, %struct.block** %263, align 8, !dbg !1242, !tbaa !343
  br label %267, !dbg !1243

; <label>:264:                                    ; preds = %261
  %265 = getelementptr inbounds %struct.block, %struct.block* %253, i64 0, i32 1, i32 0, i32 0, !dbg !1244
  store %struct.block* %251, %struct.block** %265, align 8, !dbg !1245, !tbaa !343
  %266 = getelementptr inbounds %struct.block, %struct.block* %251, i64 0, i32 1, i32 0, i32 1, !dbg !1246
  store %struct.block* %253, %struct.block** %266, align 8, !dbg !1247, !tbaa !343
  br label %267

; <label>:267:                                    ; preds = %258, %259, %262, %264
  %268 = bitcast %struct.block** %250 to i8*, !dbg !1248
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %268, i8 0, i64 16, i1 false) #5, !dbg !1249
  call void @llvm.dbg.value(metadata %struct.block* %165, metadata !125, metadata !DIExpression()), !dbg !1250
  call void @llvm.dbg.value(metadata i64 %171, metadata !130, metadata !DIExpression()), !dbg !1252
  call void @llvm.dbg.value(metadata i64 2, metadata !131, metadata !DIExpression()), !dbg !1253
  call void @llvm.dbg.value(metadata i64 %171, metadata !403, metadata !DIExpression()), !dbg !1254
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()), !dbg !1256
  call void @llvm.dbg.value(metadata i64 %171, metadata !409, metadata !DIExpression()), !dbg !1257
  %269 = or i64 %171, 2, !dbg !1258
  call void @llvm.dbg.value(metadata i64 %269, metadata !409, metadata !DIExpression()), !dbg !1257
  call void @llvm.dbg.value(metadata i64 %269, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1257
  call void @llvm.dbg.value(metadata i64 %269, metadata !409, metadata !DIExpression()), !dbg !1257
  store i64 %269, i64* %168, align 8, !dbg !1259, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %165, metadata !141, metadata !DIExpression()), !dbg !1260
  %270 = getelementptr inbounds %struct.block, %struct.block* %165, i64 0, i32 1, !dbg !1262
  %271 = bitcast %union.anon* %270 to i8*, !dbg !1263
  call void @llvm.dbg.value(metadata i64 %269, metadata !317, metadata !DIExpression()), !dbg !1264
  %272 = getelementptr inbounds i8, i8* %271, i64 %171, !dbg !1267
  %273 = getelementptr inbounds i8, i8* %272, i64 -16, !dbg !1268
  %274 = bitcast i8* %273 to i64*, !dbg !1269
  call void @llvm.dbg.value(metadata i64* %274, metadata !132, metadata !DIExpression()), !dbg !1270
  call void @llvm.dbg.value(metadata i64 %171, metadata !403, metadata !DIExpression()), !dbg !1271
  call void @llvm.dbg.value(metadata i64 2, metadata !408, metadata !DIExpression()), !dbg !1273
  call void @llvm.dbg.value(metadata i64 %171, metadata !409, metadata !DIExpression()), !dbg !1274
  call void @llvm.dbg.value(metadata i64 %269, metadata !409, metadata !DIExpression()), !dbg !1274
  call void @llvm.dbg.value(metadata i64 %269, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !1274
  call void @llvm.dbg.value(metadata i64 %269, metadata !409, metadata !DIExpression()), !dbg !1274
  store i64 %269, i64* %274, align 8, !dbg !1275, !tbaa !90
  call void @llvm.dbg.value(metadata %struct.block* %165, metadata !803, metadata !DIExpression()), !dbg !809
  br label %275, !dbg !1276

; <label>:275:                                    ; preds = %154, %85, %267, %147, %16
  %276 = phi %struct.block* [ %0, %16 ], [ %0, %154 ], [ %165, %267 ], [ %0, %147 ], [ %35, %85 ]
  %277 = phi i64 [ %5, %16 ], [ %5, %154 ], [ %171, %267 ], [ %99, %147 ], [ %39, %85 ], !dbg !1277
  call void @llvm.dbg.value(metadata i64 %277, metadata !808, metadata !DIExpression()), !dbg !842
  call void @llvm.dbg.value(metadata %struct.block* %276, metadata !803, metadata !DIExpression()), !dbg !809
  call void @llvm.dbg.value(metadata %struct.block* %276, metadata !623, metadata !DIExpression()), !dbg !1278
  call void @llvm.dbg.value(metadata i64 %277, metadata !626, metadata !DIExpression()), !dbg !1280
  call void @llvm.dbg.value(metadata i64 %277, metadata !246, metadata !DIExpression()), !dbg !1281
  %278 = icmp ult i64 %277, 32, !dbg !1283
  br i1 %278, label %304, label %279, !dbg !1284

; <label>:279:                                    ; preds = %275
  %280 = icmp ult i64 %277, 64, !dbg !1285
  br i1 %280, label %304, label %281, !dbg !1286

; <label>:281:                                    ; preds = %279
  %282 = icmp ult i64 %277, 128, !dbg !1287
  br i1 %282, label %304, label %283, !dbg !1288

; <label>:283:                                    ; preds = %281
  %284 = icmp ult i64 %277, 256, !dbg !1289
  br i1 %284, label %304, label %285, !dbg !1290

; <label>:285:                                    ; preds = %283
  %286 = icmp ult i64 %277, 512, !dbg !1291
  br i1 %286, label %304, label %287, !dbg !1292

; <label>:287:                                    ; preds = %285
  %288 = icmp ult i64 %277, 1024, !dbg !1293
  br i1 %288, label %304, label %289, !dbg !1294

; <label>:289:                                    ; preds = %287
  %290 = icmp ult i64 %277, 2048, !dbg !1295
  br i1 %290, label %304, label %291, !dbg !1296

; <label>:291:                                    ; preds = %289
  %292 = icmp ult i64 %277, 4096, !dbg !1297
  br i1 %292, label %304, label %293, !dbg !1298

; <label>:293:                                    ; preds = %291
  %294 = icmp ult i64 %277, 8192, !dbg !1299
  br i1 %294, label %304, label %295, !dbg !1300

; <label>:295:                                    ; preds = %293
  %296 = icmp ult i64 %277, 16384, !dbg !1301
  br i1 %296, label %304, label %297, !dbg !1302

; <label>:297:                                    ; preds = %295
  %298 = icmp ult i64 %277, 32768, !dbg !1303
  br i1 %298, label %304, label %299, !dbg !1304

; <label>:299:                                    ; preds = %297
  %300 = icmp ult i64 %277, 65536, !dbg !1305
  br i1 %300, label %304, label %301, !dbg !1306

; <label>:301:                                    ; preds = %299
  %302 = icmp ult i64 %277, 131072, !dbg !1307
  %303 = select i1 %302, i64 12, i64 13, !dbg !1308
  br label %304, !dbg !1308

; <label>:304:                                    ; preds = %301, %299, %297, %295, %293, %291, %289, %287, %285, %283, %281, %279, %275
  %305 = phi i64 [ 0, %275 ], [ 1, %279 ], [ 2, %281 ], [ 3, %283 ], [ 4, %285 ], [ 5, %287 ], [ 6, %289 ], [ 7, %291 ], [ 8, %293 ], [ 9, %295 ], [ 10, %297 ], [ 11, %299 ], [ %303, %301 ], !dbg !1309
  call void @llvm.dbg.value(metadata i64 %305, metadata !627, metadata !DIExpression()), !dbg !1310
  %306 = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %305, !dbg !1311
  %307 = load %struct.block*, %struct.block** %306, align 8, !dbg !1311, !tbaa !95
  %308 = icmp eq %struct.block* %307, null, !dbg !1312
  %309 = getelementptr inbounds %struct.block, %struct.block* %276, i64 0, i32 1, i32 0, i32 0, !dbg !1313
  store %struct.block* null, %struct.block** %309, align 8, !dbg !1313, !tbaa !343
  br i1 %308, label %310, label %312, !dbg !1314

; <label>:310:                                    ; preds = %304
  %311 = getelementptr inbounds %struct.block, %struct.block* %276, i64 0, i32 1, i32 0, i32 1, !dbg !1315
  store %struct.block* null, %struct.block** %311, align 8, !dbg !1316, !tbaa !343
  br label %317, !dbg !1317

; <label>:312:                                    ; preds = %304
  %313 = ptrtoint %struct.block* %307 to i64, !dbg !1314
  %314 = getelementptr inbounds %struct.block, %struct.block* %276, i64 0, i32 1, i32 0, i32 1, !dbg !1318
  %315 = bitcast %struct.block** %314 to i64*, !dbg !1319
  store i64 %313, i64* %315, align 8, !dbg !1319, !tbaa !343
  %316 = getelementptr inbounds %struct.block, %struct.block* %307, i64 0, i32 1, i32 0, i32 0, !dbg !1320
  store %struct.block* %276, %struct.block** %316, align 8, !dbg !1321, !tbaa !343
  br label %317

; <label>:317:                                    ; preds = %310, %312
  store %struct.block* %276, %struct.block** %306, align 8, !dbg !1322, !tbaa !95
  ret %struct.block* %276, !dbg !1323
}

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_realloc(i8*, i64) local_unnamed_addr #1 !dbg !1324 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !1328, metadata !DIExpression()), !dbg !1333
  call void @llvm.dbg.value(metadata i64 %1, metadata !1329, metadata !DIExpression()), !dbg !1334
  call void @llvm.dbg.value(metadata i8* %0, metadata !115, metadata !DIExpression()), !dbg !1335
  %3 = getelementptr inbounds i8, i8* %0, i64 -8, !dbg !1337
  %4 = bitcast i8* %3 to %struct.block*, !dbg !1338
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !1330, metadata !DIExpression()), !dbg !1339
  %5 = icmp eq i64 %1, 0, !dbg !1340
  %6 = icmp eq i8* %0, null, !dbg !1342
  br i1 %5, label %7, label %17, !dbg !1344

; <label>:7:                                      ; preds = %2
  call void @llvm.dbg.value(metadata i8* %0, metadata !758, metadata !DIExpression()) #5, !dbg !1345
  br i1 %6, label %45, label %8, !dbg !1348

; <label>:8:                                      ; preds = %7
  call void @llvm.dbg.value(metadata i8* %0, metadata !115, metadata !DIExpression()) #5, !dbg !1349
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !759, metadata !DIExpression()) #5, !dbg !1351
  %9 = bitcast i8* %3 to i64*
  %10 = load i64, i64* %9, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %10, metadata !317, metadata !DIExpression()) #5, !dbg !1352
  %11 = and i64 %10, -16, !dbg !1355
  call void @llvm.dbg.value(metadata i64 %11, metadata !760, metadata !DIExpression()) #5, !dbg !1356
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !125, metadata !DIExpression()) #5, !dbg !1357
  call void @llvm.dbg.value(metadata i64 %11, metadata !130, metadata !DIExpression()) #5, !dbg !1359
  call void @llvm.dbg.value(metadata i64 %10, metadata !131, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)) #5, !dbg !1360
  call void @llvm.dbg.value(metadata i64 %11, metadata !403, metadata !DIExpression()) #5, !dbg !1361
  call void @llvm.dbg.value(metadata i64 %10, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)) #5, !dbg !1363
  call void @llvm.dbg.value(metadata i64 %11, metadata !409, metadata !DIExpression()) #5, !dbg !1364
  %12 = and i64 %10, -14, !dbg !1365
  call void @llvm.dbg.value(metadata i64 %12, metadata !409, metadata !DIExpression()) #5, !dbg !1364
  call void @llvm.dbg.value(metadata i64 %12, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !1364
  call void @llvm.dbg.value(metadata i64 %12, metadata !409, metadata !DIExpression()) #5, !dbg !1364
  store i64 %12, i64* %9, align 8, !dbg !1366, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !141, metadata !DIExpression()) #5, !dbg !1367
  call void @llvm.dbg.value(metadata i64 %12, metadata !317, metadata !DIExpression()) #5, !dbg !1369
  %13 = getelementptr inbounds i8, i8* %0, i64 %11, !dbg !1372
  %14 = getelementptr inbounds i8, i8* %13, i64 -16, !dbg !1373
  %15 = bitcast i8* %14 to i64*, !dbg !1374
  call void @llvm.dbg.value(metadata i64* %15, metadata !132, metadata !DIExpression()) #5, !dbg !1375
  call void @llvm.dbg.value(metadata i64 %11, metadata !403, metadata !DIExpression()) #5, !dbg !1376
  call void @llvm.dbg.value(metadata i64 %10, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)) #5, !dbg !1378
  call void @llvm.dbg.value(metadata i64 %11, metadata !409, metadata !DIExpression()) #5, !dbg !1379
  call void @llvm.dbg.value(metadata i64 %12, metadata !409, metadata !DIExpression()) #5, !dbg !1379
  call void @llvm.dbg.value(metadata i64 %12, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !1379
  call void @llvm.dbg.value(metadata i64 %12, metadata !409, metadata !DIExpression()) #5, !dbg !1379
  store i64 %12, i64* %15, align 8, !dbg !1380, !tbaa !90
  %16 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %4) #5, !dbg !1381
  br label %45, !dbg !1382

; <label>:17:                                     ; preds = %2
  %18 = tail call i8* @mm_malloc(i64 %1), !dbg !1383
  br i1 %6, label %45, label %19, !dbg !1384

; <label>:19:                                     ; preds = %17
  call void @llvm.dbg.value(metadata i8* %18, metadata !1332, metadata !DIExpression()), !dbg !1385
  %20 = icmp eq i8* %18, null, !dbg !1386
  br i1 %20, label %45, label %21, !dbg !1388

; <label>:21:                                     ; preds = %19
  %22 = bitcast i8* %3 to i64*
  %23 = load i64, i64* %22, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %23, metadata !317, metadata !DIExpression()), !dbg !1389
  %24 = and i64 %23, -16, !dbg !1397
  call void @llvm.dbg.value(metadata i64 %24, metadata !1395, metadata !DIExpression()), !dbg !1398
  %25 = add i64 %24, -8, !dbg !1399
  call void @llvm.dbg.value(metadata i64 %25, metadata !1331, metadata !DIExpression()), !dbg !1400
  %26 = icmp ugt i64 %25, %1, !dbg !1401
  br i1 %26, label %36, label %27, !dbg !1403

; <label>:27:                                     ; preds = %21
  %28 = tail call i8* @mem_memcpy(i8* nonnull %18, i8* nonnull %0, i64 %25) #5, !dbg !1404
  call void @llvm.dbg.value(metadata i8* %0, metadata !758, metadata !DIExpression()) #5, !dbg !1405
  call void @llvm.dbg.value(metadata i8* %0, metadata !115, metadata !DIExpression()) #5, !dbg !1407
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !759, metadata !DIExpression()) #5, !dbg !1409
  %29 = load i64, i64* %22, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %29, metadata !317, metadata !DIExpression()) #5, !dbg !1410
  %30 = and i64 %29, -16, !dbg !1413
  call void @llvm.dbg.value(metadata i64 %30, metadata !760, metadata !DIExpression()) #5, !dbg !1414
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !125, metadata !DIExpression()) #5, !dbg !1415
  call void @llvm.dbg.value(metadata i64 %30, metadata !130, metadata !DIExpression()) #5, !dbg !1417
  call void @llvm.dbg.value(metadata i64 %29, metadata !131, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)) #5, !dbg !1418
  call void @llvm.dbg.value(metadata i64 %30, metadata !403, metadata !DIExpression()) #5, !dbg !1419
  call void @llvm.dbg.value(metadata i64 %29, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)) #5, !dbg !1421
  call void @llvm.dbg.value(metadata i64 %30, metadata !409, metadata !DIExpression()) #5, !dbg !1422
  %31 = and i64 %29, -14, !dbg !1423
  call void @llvm.dbg.value(metadata i64 %31, metadata !409, metadata !DIExpression()) #5, !dbg !1422
  call void @llvm.dbg.value(metadata i64 %31, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !1422
  call void @llvm.dbg.value(metadata i64 %31, metadata !409, metadata !DIExpression()) #5, !dbg !1422
  store i64 %31, i64* %22, align 8, !dbg !1424, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !141, metadata !DIExpression()) #5, !dbg !1425
  call void @llvm.dbg.value(metadata i64 %31, metadata !317, metadata !DIExpression()) #5, !dbg !1427
  %32 = getelementptr inbounds i8, i8* %0, i64 %30, !dbg !1430
  %33 = getelementptr inbounds i8, i8* %32, i64 -16, !dbg !1431
  %34 = bitcast i8* %33 to i64*, !dbg !1432
  call void @llvm.dbg.value(metadata i64* %34, metadata !132, metadata !DIExpression()) #5, !dbg !1433
  call void @llvm.dbg.value(metadata i64 %30, metadata !403, metadata !DIExpression()) #5, !dbg !1434
  call void @llvm.dbg.value(metadata i64 %29, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)) #5, !dbg !1436
  call void @llvm.dbg.value(metadata i64 %30, metadata !409, metadata !DIExpression()) #5, !dbg !1437
  call void @llvm.dbg.value(metadata i64 %31, metadata !409, metadata !DIExpression()) #5, !dbg !1437
  call void @llvm.dbg.value(metadata i64 %31, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !1437
  call void @llvm.dbg.value(metadata i64 %31, metadata !409, metadata !DIExpression()) #5, !dbg !1437
  store i64 %31, i64* %34, align 8, !dbg !1438, !tbaa !90
  %35 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %4) #5, !dbg !1439
  br label %45, !dbg !1403

; <label>:36:                                     ; preds = %21
  call void @llvm.dbg.value(metadata i64 %1, metadata !1331, metadata !DIExpression()), !dbg !1400
  %37 = tail call i8* @mem_memcpy(i8* nonnull %18, i8* nonnull %0, i64 %1) #5, !dbg !1404
  call void @llvm.dbg.value(metadata i8* %0, metadata !758, metadata !DIExpression()) #5, !dbg !1440
  call void @llvm.dbg.value(metadata i8* %0, metadata !115, metadata !DIExpression()) #5, !dbg !1442
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !759, metadata !DIExpression()) #5, !dbg !1444
  %38 = load i64, i64* %22, align 8, !tbaa !139
  call void @llvm.dbg.value(metadata i64 %38, metadata !317, metadata !DIExpression()) #5, !dbg !1445
  %39 = and i64 %38, -16, !dbg !1448
  call void @llvm.dbg.value(metadata i64 %39, metadata !760, metadata !DIExpression()) #5, !dbg !1449
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !125, metadata !DIExpression()) #5, !dbg !1450
  call void @llvm.dbg.value(metadata i64 %39, metadata !130, metadata !DIExpression()) #5, !dbg !1452
  call void @llvm.dbg.value(metadata i64 %38, metadata !131, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)) #5, !dbg !1453
  call void @llvm.dbg.value(metadata i64 %39, metadata !403, metadata !DIExpression()) #5, !dbg !1454
  call void @llvm.dbg.value(metadata i64 %38, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)) #5, !dbg !1456
  call void @llvm.dbg.value(metadata i64 %39, metadata !409, metadata !DIExpression()) #5, !dbg !1457
  %40 = and i64 %38, -14, !dbg !1458
  call void @llvm.dbg.value(metadata i64 %40, metadata !409, metadata !DIExpression()) #5, !dbg !1457
  call void @llvm.dbg.value(metadata i64 %40, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !1457
  call void @llvm.dbg.value(metadata i64 %40, metadata !409, metadata !DIExpression()) #5, !dbg !1457
  store i64 %40, i64* %22, align 8, !dbg !1459, !tbaa !139
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !141, metadata !DIExpression()) #5, !dbg !1460
  call void @llvm.dbg.value(metadata i64 %40, metadata !317, metadata !DIExpression()) #5, !dbg !1462
  %41 = getelementptr inbounds i8, i8* %0, i64 %39, !dbg !1465
  %42 = getelementptr inbounds i8, i8* %41, i64 -16, !dbg !1466
  %43 = bitcast i8* %42 to i64*, !dbg !1467
  call void @llvm.dbg.value(metadata i64* %43, metadata !132, metadata !DIExpression()) #5, !dbg !1468
  call void @llvm.dbg.value(metadata i64 %39, metadata !403, metadata !DIExpression()) #5, !dbg !1469
  call void @llvm.dbg.value(metadata i64 %38, metadata !408, metadata !DIExpression(DW_OP_constu, 2, DW_OP_and, DW_OP_stack_value)) #5, !dbg !1471
  call void @llvm.dbg.value(metadata i64 %39, metadata !409, metadata !DIExpression()) #5, !dbg !1472
  call void @llvm.dbg.value(metadata i64 %40, metadata !409, metadata !DIExpression()) #5, !dbg !1472
  call void @llvm.dbg.value(metadata i64 %40, metadata !409, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)) #5, !dbg !1472
  call void @llvm.dbg.value(metadata i64 %40, metadata !409, metadata !DIExpression()) #5, !dbg !1472
  store i64 %40, i64* %43, align 8, !dbg !1473, !tbaa !90
  %44 = tail call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %4) #5, !dbg !1474
  br label %45, !dbg !1475

; <label>:45:                                     ; preds = %8, %7, %36, %27, %19, %17
  %46 = phi i8* [ %18, %17 ], [ null, %19 ], [ %18, %27 ], [ %18, %36 ], [ null, %7 ], [ null, %8 ], !dbg !1383
  ret i8* %46, !dbg !1477
}

declare dso_local i8* @mem_memcpy(i8*, i8*, i64) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local i8* @mm_calloc(i64, i64) local_unnamed_addr #1 !dbg !1478 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !1482, metadata !DIExpression()), !dbg !1486
  call void @llvm.dbg.value(metadata i64 %1, metadata !1483, metadata !DIExpression()), !dbg !1487
  %3 = mul i64 %1, %0, !dbg !1488
  call void @llvm.dbg.value(metadata i64 %3, metadata !1485, metadata !DIExpression()), !dbg !1489
  %4 = icmp eq i64 %0, 0, !dbg !1490
  br i1 %4, label %13, label %5, !dbg !1492

; <label>:5:                                      ; preds = %2
  %6 = udiv i64 %3, %0, !dbg !1493
  %7 = icmp eq i64 %6, %1, !dbg !1495
  br i1 %7, label %8, label %13, !dbg !1496

; <label>:8:                                      ; preds = %5
  %9 = tail call i8* @mm_malloc(i64 %3), !dbg !1497
  call void @llvm.dbg.value(metadata i8* %9, metadata !1484, metadata !DIExpression()), !dbg !1498
  %10 = icmp eq i8* %9, null, !dbg !1499
  br i1 %10, label %13, label %11, !dbg !1501

; <label>:11:                                     ; preds = %8
  %12 = tail call i8* @mem_memset(i8* nonnull %9, i32 0, i64 %3) #5, !dbg !1502
  br label %13, !dbg !1503

; <label>:13:                                     ; preds = %8, %5, %2, %11
  %14 = phi i8* [ %9, %11 ], [ null, %2 ], [ null, %5 ], [ null, %8 ], !dbg !1504
  ret i8* %14, !dbg !1505
}

declare dso_local i8* @mem_memset(i8*, i32, i64) local_unnamed_addr #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #4

attributes #0 = { nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!61, !62, !63}
!llvm.ident = !{!64}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "seg_list", scope: !2, file: !3, line: 209, type: !58, isLocal: true, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.0 (tags/RELEASE_700/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !37)
!3 = !DIFile(filename: "mm.c", directory: "/afs/andrew.cmu.edu/usr11/yuchenca/private/15513/lab5")
!4 = !{}
!5 = !{!6, !11, !12, !31, !33, !35, !36}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_typedef, name: "word_t", file: !3, line: 123, baseType: !8)
!8 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !9, line: 55, baseType: !10)
!9 = !DIFile(filename: "/usr/include/stdint.h", directory: "/afs/andrew.cmu.edu/usr11/yuchenca/private/15513/lab5")
!10 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "block_t", file: !3, line: 183, baseType: !14)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "block", file: !3, line: 151, size: 192, elements: !15)
!15 = !{!16, !17}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "header", scope: !14, file: !3, line: 153, baseType: !7, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, scope: !14, file: !3, line: 169, baseType: !18, size: 128, offset: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !14, file: !3, line: 169, size: 128, elements: !19)
!19 = !{!20, !26}
!20 = !DIDerivedType(tag: DW_TAG_member, scope: !18, file: !3, line: 171, baseType: !21, size: 128)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !18, file: !3, line: 171, size: 128, elements: !22)
!22 = !{!23, !25}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "prev_block", scope: !21, file: !3, line: 172, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "next_block", scope: !21, file: !3, line: 173, baseType: !24, size: 64, offset: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "payload", scope: !18, file: !3, line: 175, baseType: !27)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, elements: !29)
!28 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!29 = !{!30}
!30 = !DISubrange(count: 0)
!31 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !32, line: 62, baseType: !10)
!32 = !DIFile(filename: "/usr/local/depot/llvm-7.0/lib/clang/7.0.0/include/stddef.h", directory: "/afs/andrew.cmu.edu/usr11/yuchenca/private/15513/lab5")
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !9, line: 119, baseType: !34)
!34 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!36 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!37 = !{!38, !41, !43, !45, !0, !47, !50, !52, !54, !56}
!38 = !DIGlobalVariableExpression(var: !39, expr: !DIExpression(DW_OP_constu, 8, DW_OP_stack_value))
!39 = distinct !DIGlobalVariable(name: "wsize", scope: !2, file: !3, line: 126, type: !40, isLocal: true, isDefinition: true)
!40 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !31)
!41 = !DIGlobalVariableExpression(var: !42, expr: !DIExpression(DW_OP_constu, 1024, DW_OP_stack_value))
!42 = distinct !DIGlobalVariable(name: "chunksize", scope: !2, file: !3, line: 137, type: !40, isLocal: true, isDefinition: true)
!43 = !DIGlobalVariableExpression(var: !44, expr: !DIExpression(DW_OP_constu, 16, DW_OP_stack_value))
!44 = distinct !DIGlobalVariable(name: "dsize", scope: !2, file: !3, line: 129, type: !40, isLocal: true, isDefinition: true)
!45 = !DIGlobalVariableExpression(var: !46, expr: !DIExpression(DW_OP_constu, 32, DW_OP_stack_value))
!46 = distinct !DIGlobalVariable(name: "min_block_size", scope: !2, file: !3, line: 132, type: !40, isLocal: true, isDefinition: true)
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression(DW_OP_constu, 2, DW_OP_stack_value))
!48 = distinct !DIGlobalVariable(name: "footer_mask", scope: !2, file: !3, line: 145, type: !49, isLocal: true, isDefinition: true)
!49 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7)
!50 = !DIGlobalVariableExpression(var: !51, expr: !DIExpression(DW_OP_constu, 1, DW_OP_stack_value))
!51 = distinct !DIGlobalVariable(name: "alloc_mask", scope: !2, file: !3, line: 140, type: !49, isLocal: true, isDefinition: true)
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(name: "heap_start", scope: !2, file: !3, line: 205, type: !12, isLocal: true, isDefinition: true)
!54 = !DIGlobalVariableExpression(var: !55, expr: !DIExpression())
!55 = distinct !DIGlobalVariable(name: "heap_epi", scope: !2, file: !3, line: 207, type: !12, isLocal: true, isDefinition: true)
!56 = !DIGlobalVariableExpression(var: !57, expr: !DIExpression(DW_OP_constu, 18446744073709551600, DW_OP_stack_value))
!57 = distinct !DIGlobalVariable(name: "size_mask", scope: !2, file: !3, line: 148, type: !49, isLocal: true, isDefinition: true)
!58 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 896, elements: !59)
!59 = !{!60}
!60 = !DISubrange(count: 14)
!61 = !{i32 2, !"Dwarf Version", i32 4}
!62 = !{i32 2, !"Debug Info Version", i32 3}
!63 = !{i32 1, !"wchar_size", i32 4}
!64 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!65 = distinct !DISubprogram(name: "mm_checkheap", scope: !3, file: !3, line: 896, type: !66, isLocal: false, isDefinition: true, scopeLine: 896, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !69)
!66 = !DISubroutineType(types: !67)
!67 = !{!36, !68}
!68 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!69 = !{!70}
!70 = !DILocalVariable(name: "line", arg: 1, scope: !65, file: !3, line: 896, type: !68)
!71 = !DILocation(line: 896, column: 23, scope: !65)
!72 = !DILocation(line: 913, column: 5, scope: !65)
!73 = distinct !DISubprogram(name: "mm_init", scope: !3, file: !3, line: 927, type: !74, isLocal: false, isDefinition: true, scopeLine: 927, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !76)
!74 = !DISubroutineType(types: !75)
!75 = !{!36}
!76 = !{!77, !78}
!77 = !DILocalVariable(name: "start", scope: !73, file: !3, line: 929, type: !6)
!78 = !DILocalVariable(name: "i", scope: !79, file: !3, line: 943, type: !68)
!79 = distinct !DILexicalBlock(scope: !73, file: !3, line: 943, column: 5)
!80 = !DILocation(line: 929, column: 32, scope: !73)
!81 = !DILocation(line: 931, column: 15, scope: !82)
!82 = distinct !DILexicalBlock(scope: !73, file: !3, line: 931, column: 9)
!83 = !DILocation(line: 931, column: 9, scope: !73)
!84 = !DILocation(line: 929, column: 13, scope: !73)
!85 = !DILocation(line: 944, column: 21, scope: !86)
!86 = distinct !DILexicalBlock(scope: !87, file: !3, line: 943, column: 45)
!87 = distinct !DILexicalBlock(scope: !79, file: !3, line: 943, column: 5)
!88 = !DILocation(line: 948, column: 5, scope: !73)
!89 = !DILocation(line: 947, column: 14, scope: !73)
!90 = !{!91, !91, i64 0}
!91 = !{!"long", !92, i64 0}
!92 = !{!"omnipotent char", !93, i64 0}
!93 = !{!"Simple C/C++ TBAA"}
!94 = !DILocation(line: 951, column: 16, scope: !73)
!95 = !{!96, !96, i64 0}
!96 = !{!"any pointer", !92, i64 0}
!97 = !DILocation(line: 953, column: 14, scope: !73)
!98 = !DILocalVariable(name: "size", arg: 1, scope: !99, file: !3, line: 638, type: !31)
!99 = distinct !DISubprogram(name: "extend_heap", scope: !3, file: !3, line: 638, type: !100, isLocal: true, isDefinition: true, scopeLine: 638, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !102)
!100 = !DISubroutineType(types: !101)
!101 = !{!12, !31}
!102 = !{!98, !103, !104, !105}
!103 = !DILocalVariable(name: "bp", scope: !99, file: !3, line: 639, type: !11)
!104 = !DILocalVariable(name: "epi", scope: !99, file: !3, line: 642, type: !7)
!105 = !DILocalVariable(name: "block", scope: !99, file: !3, line: 654, type: !12)
!106 = !DILocation(line: 638, column: 36, scope: !99, inlinedAt: !107)
!107 = distinct !DILocation(line: 956, column: 9, scope: !108)
!108 = distinct !DILexicalBlock(scope: !73, file: !3, line: 956, column: 9)
!109 = !DILocation(line: 644, column: 15, scope: !110, inlinedAt: !107)
!110 = distinct !DILexicalBlock(scope: !99, file: !3, line: 644, column: 9)
!111 = !DILocation(line: 639, column: 11, scope: !99, inlinedAt: !107)
!112 = !DILocation(line: 644, column: 41, scope: !110, inlinedAt: !107)
!113 = !DILocation(line: 644, column: 9, scope: !99, inlinedAt: !107)
!114 = !DILocation(line: 642, column: 12, scope: !99, inlinedAt: !107)
!115 = !DILocalVariable(name: "bp", arg: 1, scope: !116, file: !3, line: 326, type: !11)
!116 = distinct !DISubprogram(name: "payload_to_header", scope: !3, file: !3, line: 326, type: !117, isLocal: true, isDefinition: true, scopeLine: 326, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !119)
!117 = !DISubroutineType(types: !118)
!118 = !{!12, !11}
!119 = !{!115}
!120 = !DILocation(line: 326, column: 41, scope: !116, inlinedAt: !121)
!121 = distinct !DILocation(line: 654, column: 22, scope: !99, inlinedAt: !107)
!122 = !DILocation(line: 327, column: 35, scope: !116, inlinedAt: !121)
!123 = !DILocation(line: 327, column: 12, scope: !116, inlinedAt: !121)
!124 = !DILocation(line: 654, column: 14, scope: !99, inlinedAt: !107)
!125 = !DILocalVariable(name: "block", arg: 1, scope: !126, file: !3, line: 471, type: !12)
!126 = distinct !DISubprogram(name: "write_block_foot", scope: !3, file: !3, line: 471, type: !127, isLocal: true, isDefinition: true, scopeLine: 471, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !129)
!127 = !DISubroutineType(types: !128)
!128 = !{null, !12, !31, !31}
!129 = !{!125, !130, !131, !132}
!130 = !DILocalVariable(name: "size", arg: 2, scope: !126, file: !3, line: 471, type: !31)
!131 = !DILocalVariable(name: "alloc", arg: 3, scope: !126, file: !3, line: 471, type: !31)
!132 = !DILocalVariable(name: "footerp", scope: !126, file: !3, line: 475, type: !6)
!133 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !134)
!134 = distinct !DILocation(line: 655, column: 5, scope: !99, inlinedAt: !107)
!135 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !134)
!136 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !134)
!137 = !DILocation(line: 474, column: 12, scope: !126, inlinedAt: !134)
!138 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !134)
!139 = !{!140, !91, i64 0}
!140 = !{!"block", !91, i64 0, !92, i64 8}
!141 = !DILocalVariable(name: "block", arg: 1, scope: !142, file: !3, line: 349, type: !12)
!142 = distinct !DISubprogram(name: "header_to_footer", scope: !3, file: !3, line: 349, type: !143, isLocal: true, isDefinition: true, scopeLine: 349, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !145)
!143 = !DISubroutineType(types: !144)
!144 = !{!6, !12}
!145 = !{!141}
!146 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !147)
!147 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !134)
!148 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !147)
!149 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !134)
!150 = !DILocalVariable(name: "block", arg: 1, scope: !151, file: !3, line: 489, type: !12)
!151 = distinct !DISubprogram(name: "find_next", scope: !3, file: !3, line: 489, type: !152, isLocal: true, isDefinition: true, scopeLine: 489, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !154)
!152 = !DISubroutineType(types: !153)
!153 = !{!12, !12}
!154 = !{!150}
!155 = !DILocation(line: 489, column: 36, scope: !151, inlinedAt: !156)
!156 = distinct !DILocation(line: 660, column: 16, scope: !99, inlinedAt: !107)
!157 = !DILocation(line: 493, column: 38, scope: !151, inlinedAt: !156)
!158 = !DILocation(line: 660, column: 14, scope: !99, inlinedAt: !107)
!159 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !134)
!160 = !DILocation(line: 664, column: 13, scope: !99, inlinedAt: !107)
!161 = !DILocation(line: 0, scope: !73)
!162 = !DILocation(line: 961, column: 1, scope: !73)
!163 = distinct !DISubprogram(name: "mm_malloc", scope: !3, file: !3, line: 976, type: !164, isLocal: false, isDefinition: true, scopeLine: 976, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !166)
!164 = !DISubroutineType(types: !165)
!165 = !{!11, !31}
!166 = !{!167, !168, !169, !170, !171, !172}
!167 = !DILocalVariable(name: "size", arg: 1, scope: !163, file: !3, line: 976, type: !31)
!168 = !DILocalVariable(name: "asize", scope: !163, file: !3, line: 979, type: !31)
!169 = !DILocalVariable(name: "extendsize", scope: !163, file: !3, line: 980, type: !31)
!170 = !DILocalVariable(name: "block", scope: !163, file: !3, line: 981, type: !12)
!171 = !DILocalVariable(name: "bp", scope: !163, file: !3, line: 982, type: !11)
!172 = !DILocalVariable(name: "block_size", scope: !163, file: !3, line: 1021, type: !31)
!173 = !DILocation(line: 976, column: 21, scope: !163)
!174 = !DILocation(line: 982, column: 11, scope: !163)
!175 = !DILocation(line: 985, column: 9, scope: !176)
!176 = distinct !DILexicalBlock(scope: !163, file: !3, line: 985, column: 9)
!177 = !DILocation(line: 985, column: 20, scope: !176)
!178 = !DILocation(line: 985, column: 9, scope: !163)
!179 = !DILocation(line: 929, column: 32, scope: !73, inlinedAt: !180)
!180 = distinct !DILocation(line: 986, column: 9, scope: !181)
!181 = distinct !DILexicalBlock(scope: !176, file: !3, line: 985, column: 29)
!182 = !DILocation(line: 931, column: 15, scope: !82, inlinedAt: !180)
!183 = !DILocation(line: 931, column: 9, scope: !73, inlinedAt: !180)
!184 = !DILocation(line: 929, column: 13, scope: !73, inlinedAt: !180)
!185 = !DILocation(line: 944, column: 21, scope: !86, inlinedAt: !180)
!186 = !DILocation(line: 948, column: 5, scope: !73, inlinedAt: !180)
!187 = !DILocation(line: 947, column: 14, scope: !73, inlinedAt: !180)
!188 = !DILocation(line: 951, column: 16, scope: !73, inlinedAt: !180)
!189 = !DILocation(line: 953, column: 14, scope: !73, inlinedAt: !180)
!190 = !DILocation(line: 638, column: 36, scope: !99, inlinedAt: !191)
!191 = distinct !DILocation(line: 956, column: 9, scope: !108, inlinedAt: !180)
!192 = !DILocation(line: 644, column: 15, scope: !110, inlinedAt: !191)
!193 = !DILocation(line: 639, column: 11, scope: !99, inlinedAt: !191)
!194 = !DILocation(line: 644, column: 41, scope: !110, inlinedAt: !191)
!195 = !DILocation(line: 644, column: 9, scope: !99, inlinedAt: !191)
!196 = !DILocation(line: 642, column: 12, scope: !99, inlinedAt: !191)
!197 = !DILocation(line: 326, column: 41, scope: !116, inlinedAt: !198)
!198 = distinct !DILocation(line: 654, column: 22, scope: !99, inlinedAt: !191)
!199 = !DILocation(line: 327, column: 35, scope: !116, inlinedAt: !198)
!200 = !DILocation(line: 327, column: 12, scope: !116, inlinedAt: !198)
!201 = !DILocation(line: 654, column: 14, scope: !99, inlinedAt: !191)
!202 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !203)
!203 = distinct !DILocation(line: 655, column: 5, scope: !99, inlinedAt: !191)
!204 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !203)
!205 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !203)
!206 = !DILocation(line: 474, column: 12, scope: !126, inlinedAt: !203)
!207 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !203)
!208 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !209)
!209 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !203)
!210 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !209)
!211 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !203)
!212 = !DILocation(line: 489, column: 36, scope: !151, inlinedAt: !213)
!213 = distinct !DILocation(line: 660, column: 16, scope: !99, inlinedAt: !191)
!214 = !DILocation(line: 493, column: 38, scope: !151, inlinedAt: !213)
!215 = !DILocation(line: 660, column: 14, scope: !99, inlinedAt: !191)
!216 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !203)
!217 = !DILocation(line: 664, column: 13, scope: !99, inlinedAt: !191)
!218 = !DILocation(line: 990, column: 14, scope: !219)
!219 = distinct !DILexicalBlock(scope: !163, file: !3, line: 990, column: 9)
!220 = !DILocation(line: 990, column: 9, scope: !163)
!221 = !DILocation(line: 996, column: 14, scope: !222)
!222 = distinct !DILexicalBlock(scope: !163, file: !3, line: 996, column: 9)
!223 = !DILocation(line: 996, column: 9, scope: !163)
!224 = !DILocalVariable(name: "size", arg: 1, scope: !225, file: !3, line: 251, type: !31)
!225 = distinct !DISubprogram(name: "round_up", scope: !3, file: !3, line: 251, type: !226, isLocal: true, isDefinition: true, scopeLine: 251, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !228)
!226 = !DISubroutineType(types: !227)
!227 = !{!31, !31, !31}
!228 = !{!224, !229}
!229 = !DILocalVariable(name: "n", arg: 2, scope: !225, file: !3, line: 251, type: !31)
!230 = !DILocation(line: 251, column: 31, scope: !225, inlinedAt: !231)
!231 = distinct !DILocation(line: 999, column: 17, scope: !222)
!232 = !DILocation(line: 251, column: 44, scope: !225, inlinedAt: !231)
!233 = !DILocation(line: 252, column: 23, scope: !225, inlinedAt: !231)
!234 = !DILocation(line: 252, column: 14, scope: !225, inlinedAt: !231)
!235 = !DILocation(line: 979, column: 12, scope: !163)
!236 = !DILocalVariable(name: "asize", arg: 1, scope: !237, file: !3, line: 835, type: !31)
!237 = distinct !DISubprogram(name: "find_fit", scope: !3, file: !3, line: 835, type: !100, isLocal: true, isDefinition: true, scopeLine: 835, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !238)
!238 = !{!236, !239, !240}
!239 = !DILocalVariable(name: "bestfit", scope: !237, file: !3, line: 836, type: !12)
!240 = !DILocalVariable(name: "i", scope: !241, file: !3, line: 839, type: !31)
!241 = distinct !DILexicalBlock(scope: !237, file: !3, line: 839, column: 5)
!242 = !DILocation(line: 835, column: 33, scope: !237, inlinedAt: !243)
!243 = distinct !DILocation(line: 1007, column: 18, scope: !244)
!244 = distinct !DILexicalBlock(scope: !163, file: !3, line: 1007, column: 9)
!245 = !DILocation(line: 836, column: 14, scope: !237, inlinedAt: !243)
!246 = !DILocalVariable(name: "size", arg: 1, scope: !247, file: !3, line: 793, type: !31)
!247 = distinct !DISubprogram(name: "search_seg_list", scope: !3, file: !3, line: 793, type: !248, isLocal: true, isDefinition: true, scopeLine: 793, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !250)
!248 = !DISubroutineType(types: !249)
!249 = !{!31, !31}
!250 = !{!246}
!251 = !DILocation(line: 793, column: 38, scope: !247, inlinedAt: !252)
!252 = distinct !DILocation(line: 839, column: 21, scope: !241, inlinedAt: !243)
!253 = !DILocation(line: 794, column: 14, scope: !254, inlinedAt: !252)
!254 = distinct !DILexicalBlock(scope: !247, file: !3, line: 794, column: 9)
!255 = !DILocation(line: 794, column: 9, scope: !247, inlinedAt: !252)
!256 = !DILocation(line: 796, column: 49, scope: !257, inlinedAt: !252)
!257 = distinct !DILexicalBlock(scope: !254, file: !3, line: 796, column: 14)
!258 = !DILocation(line: 796, column: 40, scope: !257, inlinedAt: !252)
!259 = !DILocation(line: 798, column: 49, scope: !260, inlinedAt: !252)
!260 = distinct !DILexicalBlock(scope: !257, file: !3, line: 798, column: 14)
!261 = !DILocation(line: 798, column: 40, scope: !260, inlinedAt: !252)
!262 = !DILocation(line: 800, column: 49, scope: !263, inlinedAt: !252)
!263 = distinct !DILexicalBlock(scope: !260, file: !3, line: 800, column: 14)
!264 = !DILocation(line: 800, column: 40, scope: !263, inlinedAt: !252)
!265 = !DILocation(line: 802, column: 49, scope: !266, inlinedAt: !252)
!266 = distinct !DILexicalBlock(scope: !263, file: !3, line: 802, column: 14)
!267 = !DILocation(line: 802, column: 40, scope: !266, inlinedAt: !252)
!268 = !DILocation(line: 804, column: 49, scope: !269, inlinedAt: !252)
!269 = distinct !DILexicalBlock(scope: !266, file: !3, line: 804, column: 14)
!270 = !DILocation(line: 804, column: 40, scope: !269, inlinedAt: !252)
!271 = !DILocation(line: 806, column: 49, scope: !272, inlinedAt: !252)
!272 = distinct !DILexicalBlock(scope: !269, file: !3, line: 806, column: 14)
!273 = !DILocation(line: 806, column: 40, scope: !272, inlinedAt: !252)
!274 = !DILocation(line: 808, column: 49, scope: !275, inlinedAt: !252)
!275 = distinct !DILexicalBlock(scope: !272, file: !3, line: 808, column: 14)
!276 = !DILocation(line: 808, column: 40, scope: !275, inlinedAt: !252)
!277 = !DILocation(line: 810, column: 49, scope: !278, inlinedAt: !252)
!278 = distinct !DILexicalBlock(scope: !275, file: !3, line: 810, column: 14)
!279 = !DILocation(line: 810, column: 40, scope: !278, inlinedAt: !252)
!280 = !DILocation(line: 812, column: 49, scope: !281, inlinedAt: !252)
!281 = distinct !DILexicalBlock(scope: !278, file: !3, line: 812, column: 14)
!282 = !DILocation(line: 812, column: 40, scope: !281, inlinedAt: !252)
!283 = !DILocation(line: 814, column: 50, scope: !284, inlinedAt: !252)
!284 = distinct !DILexicalBlock(scope: !281, file: !3, line: 814, column: 14)
!285 = !DILocation(line: 814, column: 41, scope: !284, inlinedAt: !252)
!286 = !DILocation(line: 816, column: 50, scope: !287, inlinedAt: !252)
!287 = distinct !DILexicalBlock(scope: !284, file: !3, line: 816, column: 14)
!288 = !DILocation(line: 816, column: 41, scope: !287, inlinedAt: !252)
!289 = !DILocation(line: 818, column: 50, scope: !290, inlinedAt: !252)
!290 = distinct !DILexicalBlock(scope: !287, file: !3, line: 818, column: 14)
!291 = !DILocation(line: 819, column: 9, scope: !290, inlinedAt: !252)
!292 = !DILocation(line: 0, scope: !290, inlinedAt: !252)
!293 = !DILocation(line: 839, column: 17, scope: !241, inlinedAt: !243)
!294 = !DILocation(line: 839, column: 5, scope: !241, inlinedAt: !243)
!295 = !DILocation(line: 841, column: 28, scope: !296, inlinedAt: !243)
!296 = distinct !DILexicalBlock(scope: !297, file: !3, line: 839, column: 69)
!297 = distinct !DILexicalBlock(scope: !241, file: !3, line: 839, column: 5)
!298 = !DILocalVariable(name: "block", arg: 1, scope: !299, file: !3, line: 862, type: !12)
!299 = distinct !DISubprogram(name: "best_fit", scope: !3, file: !3, line: 862, type: !300, isLocal: true, isDefinition: true, scopeLine: 862, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !302)
!300 = !DISubroutineType(types: !301)
!301 = !{!12, !12, !31}
!302 = !{!298, !303, !304, !305, !306, !307}
!303 = !DILocalVariable(name: "asize", arg: 2, scope: !299, file: !3, line: 862, type: !31)
!304 = !DILocalVariable(name: "seg_block", scope: !299, file: !3, line: 863, type: !12)
!305 = !DILocalVariable(name: "bestfit_block", scope: !299, file: !3, line: 863, type: !12)
!306 = !DILocalVariable(name: "bestfit_size", scope: !299, file: !3, line: 864, type: !31)
!307 = !DILocalVariable(name: "current_size", scope: !299, file: !3, line: 864, type: !31)
!308 = !DILocation(line: 862, column: 35, scope: !299, inlinedAt: !309)
!309 = distinct !DILocation(line: 841, column: 19, scope: !296, inlinedAt: !243)
!310 = !DILocation(line: 862, column: 49, scope: !299, inlinedAt: !309)
!311 = !DILocation(line: 864, column: 12, scope: !299, inlinedAt: !309)
!312 = !DILocation(line: 863, column: 26, scope: !299, inlinedAt: !309)
!313 = !DILocation(line: 867, column: 15, scope: !314, inlinedAt: !309)
!314 = distinct !DILexicalBlock(scope: !299, file: !3, line: 867, column: 9)
!315 = !DILocation(line: 867, column: 9, scope: !299, inlinedAt: !309)
!316 = !DILocation(line: 863, column: 14, scope: !299, inlinedAt: !309)
!317 = !DILocalVariable(name: "word", arg: 1, scope: !318, file: !3, line: 307, type: !7)
!318 = distinct !DISubprogram(name: "extract_size", scope: !3, file: !3, line: 307, type: !319, isLocal: true, isDefinition: true, scopeLine: 307, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !321)
!319 = !DISubroutineType(types: !320)
!320 = !{!31, !7}
!321 = !{!317}
!322 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !323)
!323 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !329)
!324 = distinct !DISubprogram(name: "get_size", scope: !3, file: !3, line: 316, type: !325, isLocal: true, isDefinition: true, scopeLine: 316, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !327)
!325 = !DISubroutineType(types: !326)
!326 = !{!31, !12}
!327 = !{!328}
!328 = !DILocalVariable(name: "block", arg: 1, scope: !324, file: !3, line: 316, type: !12)
!329 = distinct !DILocation(line: 873, column: 24, scope: !330, inlinedAt: !309)
!330 = distinct !DILexicalBlock(scope: !331, file: !3, line: 872, column: 45)
!331 = distinct !DILexicalBlock(scope: !332, file: !3, line: 871, column: 5)
!332 = distinct !DILexicalBlock(scope: !299, file: !3, line: 871, column: 5)
!333 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !323)
!334 = !DILocation(line: 864, column: 26, scope: !299, inlinedAt: !309)
!335 = !DILocation(line: 874, column: 26, scope: !336, inlinedAt: !309)
!336 = distinct !DILexicalBlock(scope: !330, file: !3, line: 874, column: 13)
!337 = !DILocation(line: 874, column: 13, scope: !330, inlinedAt: !309)
!338 = !DILocation(line: 876, column: 34, scope: !339, inlinedAt: !309)
!339 = distinct !DILexicalBlock(scope: !336, file: !3, line: 876, column: 20)
!340 = !DILocation(line: 876, column: 60, scope: !339, inlinedAt: !309)
!341 = !DILocation(line: 876, column: 43, scope: !339, inlinedAt: !309)
!342 = !DILocation(line: 872, column: 33, scope: !331, inlinedAt: !309)
!343 = !{!92, !92, i64 0}
!344 = !DILocation(line: 871, column: 39, scope: !331, inlinedAt: !309)
!345 = !DILocation(line: 871, column: 5, scope: !332, inlinedAt: !309)
!346 = distinct !{!346, !347, !348}
!347 = !DILocation(line: 871, column: 5, scope: !332)
!348 = !DILocation(line: 880, column: 5, scope: !332)
!349 = !DILocation(line: 842, column: 21, scope: !350, inlinedAt: !243)
!350 = distinct !DILexicalBlock(scope: !296, file: !3, line: 842, column: 13)
!351 = !DILocation(line: 842, column: 13, scope: !296, inlinedAt: !243)
!352 = !DILocation(line: 839, column: 64, scope: !297, inlinedAt: !243)
!353 = !DILocation(line: 839, column: 47, scope: !297, inlinedAt: !243)
!354 = distinct !{!354, !355, !356}
!355 = !DILocation(line: 839, column: 5, scope: !241)
!356 = !DILocation(line: 844, column: 5, scope: !241)
!357 = !DILocation(line: 981, column: 14, scope: !163)
!358 = !DILocalVariable(name: "x", arg: 1, scope: !359, file: !3, line: 241, type: !31)
!359 = distinct !DISubprogram(name: "max", scope: !3, file: !3, line: 241, type: !226, isLocal: true, isDefinition: true, scopeLine: 241, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !360)
!360 = !{!358, !361}
!361 = !DILocalVariable(name: "y", arg: 2, scope: !359, file: !3, line: 241, type: !31)
!362 = !DILocation(line: 241, column: 26, scope: !359, inlinedAt: !363)
!363 = distinct !DILocation(line: 1009, column: 22, scope: !364)
!364 = distinct !DILexicalBlock(scope: !244, file: !3, line: 1007, column: 44)
!365 = !DILocation(line: 241, column: 36, scope: !359, inlinedAt: !363)
!366 = !DILocation(line: 242, column: 15, scope: !359, inlinedAt: !363)
!367 = !DILocation(line: 242, column: 12, scope: !359, inlinedAt: !363)
!368 = !DILocation(line: 980, column: 12, scope: !163)
!369 = !DILocation(line: 638, column: 36, scope: !99, inlinedAt: !370)
!370 = distinct !DILocation(line: 1010, column: 17, scope: !364)
!371 = !DILocation(line: 642, column: 29, scope: !99, inlinedAt: !370)
!372 = !DILocalVariable(name: "word", arg: 1, scope: !373, file: !3, line: 411, type: !7)
!373 = distinct !DISubprogram(name: "extract_footer", scope: !3, file: !3, line: 411, type: !374, isLocal: true, isDefinition: true, scopeLine: 411, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !376)
!374 = !DISubroutineType(types: !375)
!375 = !{!7, !7}
!376 = !{!372}
!377 = !DILocation(line: 411, column: 37, scope: !373, inlinedAt: !378)
!378 = distinct !DILocation(line: 421, column: 12, scope: !379, inlinedAt: !384)
!379 = distinct !DISubprogram(name: "get_footer", scope: !3, file: !3, line: 420, type: !380, isLocal: true, isDefinition: true, scopeLine: 420, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !382)
!380 = !DISubroutineType(types: !381)
!381 = !{!7, !12}
!382 = !{!383}
!383 = !DILocalVariable(name: "block", arg: 1, scope: !379, file: !3, line: 420, type: !12)
!384 = distinct !DILocation(line: 642, column: 18, scope: !99, inlinedAt: !370)
!385 = !DILocation(line: 251, column: 31, scope: !225, inlinedAt: !386)
!386 = distinct !DILocation(line: 643, column: 12, scope: !99, inlinedAt: !370)
!387 = !DILocation(line: 251, column: 44, scope: !225, inlinedAt: !386)
!388 = !DILocation(line: 644, column: 15, scope: !110, inlinedAt: !370)
!389 = !DILocation(line: 639, column: 11, scope: !99, inlinedAt: !370)
!390 = !DILocation(line: 644, column: 41, scope: !110, inlinedAt: !370)
!391 = !DILocation(line: 644, column: 9, scope: !99, inlinedAt: !370)
!392 = !DILocation(line: 412, column: 18, scope: !373, inlinedAt: !378)
!393 = !DILocation(line: 642, column: 12, scope: !99, inlinedAt: !370)
!394 = !DILocation(line: 326, column: 41, scope: !116, inlinedAt: !395)
!395 = distinct !DILocation(line: 654, column: 22, scope: !99, inlinedAt: !370)
!396 = !DILocation(line: 327, column: 35, scope: !116, inlinedAt: !395)
!397 = !DILocation(line: 327, column: 12, scope: !116, inlinedAt: !395)
!398 = !DILocation(line: 654, column: 14, scope: !99, inlinedAt: !370)
!399 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !400)
!400 = distinct !DILocation(line: 655, column: 5, scope: !99, inlinedAt: !370)
!401 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !400)
!402 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !400)
!403 = !DILocalVariable(name: "size", arg: 1, scope: !404, file: !3, line: 287, type: !31)
!404 = distinct !DISubprogram(name: "pack_foot", scope: !3, file: !3, line: 287, type: !405, isLocal: true, isDefinition: true, scopeLine: 287, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !407)
!405 = !DISubroutineType(types: !406)
!406 = !{!7, !31, !31}
!407 = !{!403, !408, !409}
!408 = !DILocalVariable(name: "alloc", arg: 2, scope: !404, file: !3, line: 287, type: !31)
!409 = !DILocalVariable(name: "word", scope: !404, file: !3, line: 288, type: !7)
!410 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !411)
!411 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !400)
!412 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !411)
!413 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !411)
!414 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !411)
!415 = !DILocation(line: 474, column: 12, scope: !126, inlinedAt: !400)
!416 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !400)
!417 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !418)
!418 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !400)
!419 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !420)
!420 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !421)
!421 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !418)
!422 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !418)
!423 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !418)
!424 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !418)
!425 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !400)
!426 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !427)
!427 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !400)
!428 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !427)
!429 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !427)
!430 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !400)
!431 = !DILocation(line: 489, column: 36, scope: !151, inlinedAt: !432)
!432 = distinct !DILocation(line: 660, column: 16, scope: !99, inlinedAt: !370)
!433 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !434)
!434 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !435)
!435 = distinct !DILocation(line: 493, column: 40, scope: !151, inlinedAt: !432)
!436 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !434)
!437 = !DILocation(line: 493, column: 38, scope: !151, inlinedAt: !432)
!438 = !DILocation(line: 660, column: 14, scope: !99, inlinedAt: !370)
!439 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !440)
!440 = distinct !DILocation(line: 661, column: 24, scope: !99, inlinedAt: !370)
!441 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !440)
!442 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !440)
!443 = !DILocation(line: 661, column: 15, scope: !99, inlinedAt: !370)
!444 = !DILocation(line: 661, column: 22, scope: !99, inlinedAt: !370)
!445 = !DILocation(line: 664, column: 13, scope: !99, inlinedAt: !370)
!446 = !DILocation(line: 1012, column: 19, scope: !447)
!447 = distinct !DILexicalBlock(scope: !364, file: !3, line: 1012, column: 13)
!448 = !DILocation(line: 1012, column: 13, scope: !364)
!449 = !DILocation(line: 0, scope: !244)
!450 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !451)
!451 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !452)
!452 = distinct !DILocation(line: 1021, column: 25, scope: !163)
!453 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !451)
!454 = !DILocation(line: 1021, column: 12, scope: !163)
!455 = !DILocation(line: 411, column: 37, scope: !373, inlinedAt: !456)
!456 = distinct !DILocation(line: 421, column: 12, scope: !379, inlinedAt: !457)
!457 = distinct !DILocation(line: 1022, column: 41, scope: !163)
!458 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !459)
!459 = distinct !DILocation(line: 1022, column: 5, scope: !163)
!460 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !459)
!461 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !459)
!462 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !463)
!463 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !459)
!464 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !463)
!465 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !463)
!466 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !463)
!467 = !DILocation(line: 292, column: 9, scope: !404, inlinedAt: !463)
!468 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !459)
!469 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !470)
!470 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !459)
!471 = !DILocation(line: 352, column: 30, scope: !142, inlinedAt: !470)
!472 = !DILocation(line: 352, column: 23, scope: !142, inlinedAt: !470)
!473 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !474)
!474 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !475)
!475 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !470)
!476 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !470)
!477 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !470)
!478 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !470)
!479 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !459)
!480 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !481)
!481 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !459)
!482 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !481)
!483 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !481)
!484 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !459)
!485 = !DILocalVariable(name: "block", arg: 1, scope: !486, file: !3, line: 681, type: !12)
!486 = distinct !DISubprogram(name: "split_block", scope: !3, file: !3, line: 681, type: !487, isLocal: true, isDefinition: true, scopeLine: 681, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !489)
!487 = !DISubroutineType(types: !488)
!488 = !{null, !12, !31}
!489 = !{!485, !490, !491, !492, !493}
!490 = !DILocalVariable(name: "asize", arg: 2, scope: !486, file: !3, line: 681, type: !31)
!491 = !DILocalVariable(name: "nextp", scope: !486, file: !3, line: 683, type: !12)
!492 = !DILocalVariable(name: "block_size", scope: !486, file: !3, line: 684, type: !31)
!493 = !DILocalVariable(name: "rest_size", scope: !486, file: !3, line: 685, type: !31)
!494 = !DILocation(line: 681, column: 34, scope: !486, inlinedAt: !495)
!495 = distinct !DILocation(line: 1025, column: 5, scope: !163)
!496 = !DILocation(line: 681, column: 48, scope: !486, inlinedAt: !495)
!497 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !498)
!498 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !499)
!499 = distinct !DILocation(line: 684, column: 25, scope: !486, inlinedAt: !495)
!500 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !498)
!501 = !DILocation(line: 684, column: 12, scope: !486, inlinedAt: !495)
!502 = !DILocation(line: 685, column: 35, scope: !486, inlinedAt: !495)
!503 = !DILocation(line: 685, column: 12, scope: !486, inlinedAt: !495)
!504 = !DILocation(line: 687, column: 19, scope: !505, inlinedAt: !495)
!505 = distinct !DILexicalBlock(scope: !486, file: !3, line: 687, column: 9)
!506 = !DILocation(line: 687, column: 9, scope: !486, inlinedAt: !495)
!507 = !DILocalVariable(name: "block", arg: 1, scope: !508, file: !3, line: 718, type: !12)
!508 = distinct !DISubprogram(name: "delete_seg_list", scope: !3, file: !3, line: 718, type: !509, isLocal: true, isDefinition: true, scopeLine: 718, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !511)
!509 = !DISubroutineType(types: !510)
!510 = !{null, !12}
!511 = !{!507, !512, !513, !514}
!512 = !DILocalVariable(name: "idx", scope: !508, file: !3, line: 720, type: !31)
!513 = !DILocalVariable(name: "prev_block", scope: !508, file: !3, line: 721, type: !12)
!514 = !DILocalVariable(name: "next_block", scope: !508, file: !3, line: 722, type: !12)
!515 = !DILocation(line: 718, column: 38, scope: !508, inlinedAt: !516)
!516 = distinct !DILocation(line: 688, column: 9, scope: !517, inlinedAt: !495)
!517 = distinct !DILexicalBlock(scope: !505, file: !3, line: 687, column: 38)
!518 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !519)
!519 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !520)
!520 = distinct !DILocation(line: 720, column: 34, scope: !508, inlinedAt: !516)
!521 = !DILocation(line: 793, column: 38, scope: !247, inlinedAt: !522)
!522 = distinct !DILocation(line: 720, column: 18, scope: !508, inlinedAt: !516)
!523 = !DILocation(line: 794, column: 14, scope: !254, inlinedAt: !522)
!524 = !DILocation(line: 794, column: 9, scope: !247, inlinedAt: !522)
!525 = !DILocation(line: 796, column: 49, scope: !257, inlinedAt: !522)
!526 = !DILocation(line: 796, column: 40, scope: !257, inlinedAt: !522)
!527 = !DILocation(line: 798, column: 49, scope: !260, inlinedAt: !522)
!528 = !DILocation(line: 798, column: 40, scope: !260, inlinedAt: !522)
!529 = !DILocation(line: 800, column: 49, scope: !263, inlinedAt: !522)
!530 = !DILocation(line: 800, column: 40, scope: !263, inlinedAt: !522)
!531 = !DILocation(line: 802, column: 49, scope: !266, inlinedAt: !522)
!532 = !DILocation(line: 802, column: 40, scope: !266, inlinedAt: !522)
!533 = !DILocation(line: 804, column: 49, scope: !269, inlinedAt: !522)
!534 = !DILocation(line: 804, column: 40, scope: !269, inlinedAt: !522)
!535 = !DILocation(line: 806, column: 49, scope: !272, inlinedAt: !522)
!536 = !DILocation(line: 806, column: 40, scope: !272, inlinedAt: !522)
!537 = !DILocation(line: 808, column: 49, scope: !275, inlinedAt: !522)
!538 = !DILocation(line: 808, column: 40, scope: !275, inlinedAt: !522)
!539 = !DILocation(line: 810, column: 49, scope: !278, inlinedAt: !522)
!540 = !DILocation(line: 810, column: 40, scope: !278, inlinedAt: !522)
!541 = !DILocation(line: 812, column: 49, scope: !281, inlinedAt: !522)
!542 = !DILocation(line: 812, column: 40, scope: !281, inlinedAt: !522)
!543 = !DILocation(line: 814, column: 50, scope: !284, inlinedAt: !522)
!544 = !DILocation(line: 814, column: 41, scope: !284, inlinedAt: !522)
!545 = !DILocation(line: 816, column: 50, scope: !287, inlinedAt: !522)
!546 = !DILocation(line: 816, column: 41, scope: !287, inlinedAt: !522)
!547 = !DILocation(line: 818, column: 50, scope: !290, inlinedAt: !522)
!548 = !DILocation(line: 819, column: 9, scope: !290, inlinedAt: !522)
!549 = !DILocation(line: 0, scope: !290, inlinedAt: !522)
!550 = !DILocation(line: 720, column: 12, scope: !508, inlinedAt: !516)
!551 = !DILocation(line: 721, column: 34, scope: !508, inlinedAt: !516)
!552 = !DILocation(line: 721, column: 14, scope: !508, inlinedAt: !516)
!553 = !DILocation(line: 722, column: 34, scope: !508, inlinedAt: !516)
!554 = !DILocation(line: 722, column: 14, scope: !508, inlinedAt: !516)
!555 = !DILocation(line: 725, column: 20, scope: !556, inlinedAt: !516)
!556 = distinct !DILexicalBlock(scope: !508, file: !3, line: 725, column: 9)
!557 = !DILocation(line: 0, scope: !558, inlinedAt: !516)
!558 = distinct !DILexicalBlock(scope: !556, file: !3, line: 736, column: 14)
!559 = !DILocation(line: 725, column: 9, scope: !508, inlinedAt: !516)
!560 = !DILocation(line: 0, scope: !561, inlinedAt: !516)
!561 = distinct !DILexicalBlock(scope: !562, file: !3, line: 729, column: 16)
!562 = distinct !DILexicalBlock(scope: !563, file: !3, line: 726, column: 13)
!563 = distinct !DILexicalBlock(scope: !556, file: !3, line: 725, column: 29)
!564 = !DILocation(line: 726, column: 13, scope: !563, inlinedAt: !516)
!565 = !DILocation(line: 728, column: 27, scope: !566, inlinedAt: !516)
!566 = distinct !DILexicalBlock(scope: !562, file: !3, line: 726, column: 33)
!567 = !DILocation(line: 729, column: 9, scope: !566, inlinedAt: !516)
!568 = !DILocation(line: 731, column: 27, scope: !561, inlinedAt: !516)
!569 = !DILocation(line: 732, column: 25, scope: !561, inlinedAt: !516)
!570 = !DILocation(line: 732, column: 36, scope: !561, inlinedAt: !516)
!571 = !DILocation(line: 736, column: 14, scope: !556, inlinedAt: !516)
!572 = !DILocation(line: 738, column: 21, scope: !573, inlinedAt: !516)
!573 = distinct !DILexicalBlock(scope: !558, file: !3, line: 736, column: 34)
!574 = !DILocation(line: 738, column: 32, scope: !573, inlinedAt: !516)
!575 = !DILocation(line: 739, column: 5, scope: !573, inlinedAt: !516)
!576 = !DILocation(line: 743, column: 21, scope: !577, inlinedAt: !516)
!577 = distinct !DILexicalBlock(scope: !558, file: !3, line: 741, column: 10)
!578 = !DILocation(line: 743, column: 32, scope: !577, inlinedAt: !516)
!579 = !DILocation(line: 744, column: 21, scope: !577, inlinedAt: !516)
!580 = !DILocation(line: 744, column: 32, scope: !577, inlinedAt: !516)
!581 = !DILocation(line: 750, column: 1, scope: !508, inlinedAt: !516)
!582 = !DILocation(line: 749, column: 23, scope: !508, inlinedAt: !516)
!583 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !584)
!584 = distinct !DILocation(line: 690, column: 25, scope: !517, inlinedAt: !495)
!585 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !584)
!586 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !584)
!587 = !DILocation(line: 292, column: 9, scope: !404, inlinedAt: !584)
!588 = !DILocation(line: 690, column: 23, scope: !517, inlinedAt: !495)
!589 = !DILocation(line: 489, column: 36, scope: !151, inlinedAt: !590)
!590 = distinct !DILocation(line: 693, column: 17, scope: !517, inlinedAt: !495)
!591 = !DILocation(line: 493, column: 24, scope: !151, inlinedAt: !590)
!592 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !593)
!593 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !594)
!594 = distinct !DILocation(line: 493, column: 40, scope: !151, inlinedAt: !590)
!595 = !DILocation(line: 493, column: 38, scope: !151, inlinedAt: !590)
!596 = !DILocation(line: 683, column: 14, scope: !486, inlinedAt: !495)
!597 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !598)
!598 = distinct !DILocation(line: 694, column: 9, scope: !517, inlinedAt: !495)
!599 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !598)
!600 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !598)
!601 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !602)
!602 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !598)
!603 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !602)
!604 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !602)
!605 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !602)
!606 = !DILocation(line: 474, column: 12, scope: !126, inlinedAt: !598)
!607 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !598)
!608 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !609)
!609 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !598)
!610 = !DILocation(line: 352, column: 30, scope: !142, inlinedAt: !609)
!611 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !612)
!612 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !613)
!613 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !609)
!614 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !609)
!615 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !609)
!616 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !609)
!617 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !598)
!618 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !619)
!619 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !598)
!620 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !619)
!621 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !619)
!622 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !598)
!623 = !DILocalVariable(name: "block", arg: 1, scope: !624, file: !3, line: 763, type: !12)
!624 = distinct !DISubprogram(name: "add_seg_list", scope: !3, file: !3, line: 763, type: !487, isLocal: true, isDefinition: true, scopeLine: 763, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !625)
!625 = !{!623, !626, !627}
!626 = !DILocalVariable(name: "size", arg: 2, scope: !624, file: !3, line: 763, type: !31)
!627 = !DILocalVariable(name: "seg_index", scope: !624, file: !3, line: 765, type: !31)
!628 = !DILocation(line: 763, column: 35, scope: !624, inlinedAt: !629)
!629 = distinct !DILocation(line: 695, column: 9, scope: !517, inlinedAt: !495)
!630 = !DILocation(line: 763, column: 49, scope: !624, inlinedAt: !629)
!631 = !DILocation(line: 793, column: 38, scope: !247, inlinedAt: !632)
!632 = distinct !DILocation(line: 765, column: 24, scope: !624, inlinedAt: !629)
!633 = !DILocation(line: 796, column: 49, scope: !257, inlinedAt: !632)
!634 = !DILocation(line: 796, column: 40, scope: !257, inlinedAt: !632)
!635 = !DILocation(line: 798, column: 49, scope: !260, inlinedAt: !632)
!636 = !DILocation(line: 798, column: 40, scope: !260, inlinedAt: !632)
!637 = !DILocation(line: 800, column: 49, scope: !263, inlinedAt: !632)
!638 = !DILocation(line: 800, column: 40, scope: !263, inlinedAt: !632)
!639 = !DILocation(line: 802, column: 49, scope: !266, inlinedAt: !632)
!640 = !DILocation(line: 802, column: 40, scope: !266, inlinedAt: !632)
!641 = !DILocation(line: 804, column: 49, scope: !269, inlinedAt: !632)
!642 = !DILocation(line: 804, column: 40, scope: !269, inlinedAt: !632)
!643 = !DILocation(line: 806, column: 49, scope: !272, inlinedAt: !632)
!644 = !DILocation(line: 806, column: 40, scope: !272, inlinedAt: !632)
!645 = !DILocation(line: 808, column: 49, scope: !275, inlinedAt: !632)
!646 = !DILocation(line: 808, column: 40, scope: !275, inlinedAt: !632)
!647 = !DILocation(line: 810, column: 49, scope: !278, inlinedAt: !632)
!648 = !DILocation(line: 810, column: 40, scope: !278, inlinedAt: !632)
!649 = !DILocation(line: 812, column: 49, scope: !281, inlinedAt: !632)
!650 = !DILocation(line: 812, column: 40, scope: !281, inlinedAt: !632)
!651 = !DILocation(line: 814, column: 50, scope: !284, inlinedAt: !632)
!652 = !DILocation(line: 814, column: 41, scope: !284, inlinedAt: !632)
!653 = !DILocation(line: 816, column: 50, scope: !287, inlinedAt: !632)
!654 = !DILocation(line: 816, column: 41, scope: !287, inlinedAt: !632)
!655 = !DILocation(line: 818, column: 50, scope: !290, inlinedAt: !632)
!656 = !DILocation(line: 819, column: 9, scope: !290, inlinedAt: !632)
!657 = !DILocation(line: 0, scope: !290, inlinedAt: !632)
!658 = !DILocation(line: 765, column: 12, scope: !624, inlinedAt: !629)
!659 = !DILocation(line: 768, column: 9, scope: !660, inlinedAt: !629)
!660 = distinct !DILexicalBlock(scope: !624, file: !3, line: 768, column: 9)
!661 = !DILocation(line: 768, column: 29, scope: !660, inlinedAt: !629)
!662 = !DILocation(line: 0, scope: !663, inlinedAt: !629)
!663 = distinct !DILexicalBlock(scope: !660, file: !3, line: 776, column: 10)
!664 = !DILocation(line: 768, column: 9, scope: !624, inlinedAt: !629)
!665 = !DILocation(line: 772, column: 16, scope: !666, inlinedAt: !629)
!666 = distinct !DILexicalBlock(scope: !660, file: !3, line: 768, column: 38)
!667 = !DILocation(line: 772, column: 27, scope: !666, inlinedAt: !629)
!668 = !DILocation(line: 774, column: 5, scope: !666, inlinedAt: !629)
!669 = !DILocation(line: 779, column: 16, scope: !663, inlinedAt: !629)
!670 = !DILocation(line: 779, column: 27, scope: !663, inlinedAt: !629)
!671 = !DILocation(line: 780, column: 30, scope: !663, inlinedAt: !629)
!672 = !DILocation(line: 780, column: 41, scope: !663, inlinedAt: !629)
!673 = !DILocation(line: 0, scope: !666, inlinedAt: !629)
!674 = !DILocation(line: 696, column: 5, scope: !517, inlinedAt: !495)
!675 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !676)
!676 = distinct !DILocation(line: 699, column: 25, scope: !677, inlinedAt: !495)
!677 = distinct !DILexicalBlock(scope: !505, file: !3, line: 696, column: 12)
!678 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !676)
!679 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !676)
!680 = !DILocation(line: 292, column: 9, scope: !404, inlinedAt: !676)
!681 = !DILocation(line: 699, column: 23, scope: !677, inlinedAt: !495)
!682 = !DILocation(line: 489, column: 36, scope: !151, inlinedAt: !683)
!683 = distinct !DILocation(line: 700, column: 17, scope: !677, inlinedAt: !495)
!684 = !DILocation(line: 493, column: 24, scope: !151, inlinedAt: !683)
!685 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !686)
!686 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !687)
!687 = distinct !DILocation(line: 493, column: 40, scope: !151, inlinedAt: !683)
!688 = !DILocation(line: 493, column: 38, scope: !151, inlinedAt: !683)
!689 = !DILocation(line: 701, column: 32, scope: !677, inlinedAt: !495)
!690 = !DILocation(line: 701, column: 39, scope: !677, inlinedAt: !495)
!691 = !DILocation(line: 701, column: 23, scope: !677, inlinedAt: !495)
!692 = !DILocation(line: 718, column: 38, scope: !508, inlinedAt: !693)
!693 = distinct !DILocation(line: 702, column: 9, scope: !677, inlinedAt: !495)
!694 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !695)
!695 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !696)
!696 = distinct !DILocation(line: 720, column: 34, scope: !508, inlinedAt: !693)
!697 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !695)
!698 = !DILocation(line: 793, column: 38, scope: !247, inlinedAt: !699)
!699 = distinct !DILocation(line: 720, column: 18, scope: !508, inlinedAt: !693)
!700 = !DILocation(line: 794, column: 14, scope: !254, inlinedAt: !699)
!701 = !DILocation(line: 794, column: 9, scope: !247, inlinedAt: !699)
!702 = !DILocation(line: 796, column: 49, scope: !257, inlinedAt: !699)
!703 = !DILocation(line: 796, column: 40, scope: !257, inlinedAt: !699)
!704 = !DILocation(line: 798, column: 49, scope: !260, inlinedAt: !699)
!705 = !DILocation(line: 798, column: 40, scope: !260, inlinedAt: !699)
!706 = !DILocation(line: 800, column: 49, scope: !263, inlinedAt: !699)
!707 = !DILocation(line: 800, column: 40, scope: !263, inlinedAt: !699)
!708 = !DILocation(line: 802, column: 49, scope: !266, inlinedAt: !699)
!709 = !DILocation(line: 802, column: 40, scope: !266, inlinedAt: !699)
!710 = !DILocation(line: 804, column: 49, scope: !269, inlinedAt: !699)
!711 = !DILocation(line: 804, column: 40, scope: !269, inlinedAt: !699)
!712 = !DILocation(line: 806, column: 49, scope: !272, inlinedAt: !699)
!713 = !DILocation(line: 806, column: 40, scope: !272, inlinedAt: !699)
!714 = !DILocation(line: 808, column: 49, scope: !275, inlinedAt: !699)
!715 = !DILocation(line: 808, column: 40, scope: !275, inlinedAt: !699)
!716 = !DILocation(line: 810, column: 49, scope: !278, inlinedAt: !699)
!717 = !DILocation(line: 810, column: 40, scope: !278, inlinedAt: !699)
!718 = !DILocation(line: 812, column: 49, scope: !281, inlinedAt: !699)
!719 = !DILocation(line: 812, column: 40, scope: !281, inlinedAt: !699)
!720 = !DILocation(line: 814, column: 50, scope: !284, inlinedAt: !699)
!721 = !DILocation(line: 814, column: 41, scope: !284, inlinedAt: !699)
!722 = !DILocation(line: 816, column: 50, scope: !287, inlinedAt: !699)
!723 = !DILocation(line: 816, column: 41, scope: !287, inlinedAt: !699)
!724 = !DILocation(line: 818, column: 50, scope: !290, inlinedAt: !699)
!725 = !DILocation(line: 819, column: 9, scope: !290, inlinedAt: !699)
!726 = !DILocation(line: 0, scope: !290, inlinedAt: !699)
!727 = !DILocation(line: 720, column: 12, scope: !508, inlinedAt: !693)
!728 = !DILocation(line: 721, column: 34, scope: !508, inlinedAt: !693)
!729 = !DILocation(line: 721, column: 14, scope: !508, inlinedAt: !693)
!730 = !DILocation(line: 722, column: 34, scope: !508, inlinedAt: !693)
!731 = !DILocation(line: 722, column: 14, scope: !508, inlinedAt: !693)
!732 = !DILocation(line: 725, column: 20, scope: !556, inlinedAt: !693)
!733 = !DILocation(line: 0, scope: !558, inlinedAt: !693)
!734 = !DILocation(line: 725, column: 9, scope: !508, inlinedAt: !693)
!735 = !DILocation(line: 0, scope: !561, inlinedAt: !693)
!736 = !DILocation(line: 726, column: 13, scope: !563, inlinedAt: !693)
!737 = !DILocation(line: 728, column: 27, scope: !566, inlinedAt: !693)
!738 = !DILocation(line: 729, column: 9, scope: !566, inlinedAt: !693)
!739 = !DILocation(line: 731, column: 27, scope: !561, inlinedAt: !693)
!740 = !DILocation(line: 732, column: 25, scope: !561, inlinedAt: !693)
!741 = !DILocation(line: 732, column: 36, scope: !561, inlinedAt: !693)
!742 = !DILocation(line: 736, column: 14, scope: !556, inlinedAt: !693)
!743 = !DILocation(line: 738, column: 21, scope: !573, inlinedAt: !693)
!744 = !DILocation(line: 738, column: 32, scope: !573, inlinedAt: !693)
!745 = !DILocation(line: 739, column: 5, scope: !573, inlinedAt: !693)
!746 = !DILocation(line: 743, column: 21, scope: !577, inlinedAt: !693)
!747 = !DILocation(line: 743, column: 32, scope: !577, inlinedAt: !693)
!748 = !DILocation(line: 744, column: 21, scope: !577, inlinedAt: !693)
!749 = !DILocation(line: 744, column: 32, scope: !577, inlinedAt: !693)
!750 = !DILocation(line: 750, column: 1, scope: !508, inlinedAt: !693)
!751 = !DILocation(line: 749, column: 23, scope: !508, inlinedAt: !693)
!752 = !DILocation(line: 0, scope: !163)
!753 = !DILocation(line: 1031, column: 1, scope: !163)
!754 = distinct !DISubprogram(name: "mm_free", scope: !3, file: !3, line: 1043, type: !755, isLocal: false, isDefinition: true, scopeLine: 1043, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !757)
!755 = !DISubroutineType(types: !756)
!756 = !{null, !11}
!757 = !{!758, !759, !760}
!758 = !DILocalVariable(name: "bp", arg: 1, scope: !754, file: !3, line: 1043, type: !11)
!759 = !DILocalVariable(name: "block", scope: !754, file: !3, line: 1050, type: !12)
!760 = !DILocalVariable(name: "size", scope: !754, file: !3, line: 1051, type: !31)
!761 = !DILocation(line: 1043, column: 17, scope: !754)
!762 = !DILocation(line: 1046, column: 12, scope: !763)
!763 = distinct !DILexicalBlock(scope: !754, file: !3, line: 1046, column: 9)
!764 = !DILocation(line: 1046, column: 9, scope: !754)
!765 = !DILocation(line: 326, column: 41, scope: !116, inlinedAt: !766)
!766 = distinct !DILocation(line: 1050, column: 22, scope: !754)
!767 = !DILocation(line: 327, column: 35, scope: !116, inlinedAt: !766)
!768 = !DILocation(line: 327, column: 12, scope: !116, inlinedAt: !766)
!769 = !DILocation(line: 1050, column: 14, scope: !754)
!770 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !771)
!771 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !772)
!772 = distinct !DILocation(line: 1051, column: 19, scope: !754)
!773 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !771)
!774 = !DILocation(line: 1051, column: 12, scope: !754)
!775 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !776)
!776 = distinct !DILocation(line: 1057, column: 5, scope: !754)
!777 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !776)
!778 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !776)
!779 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !780)
!780 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !776)
!781 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !780)
!782 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !780)
!783 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !780)
!784 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !776)
!785 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !786)
!786 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !776)
!787 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !788)
!788 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !789)
!789 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !786)
!790 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !786)
!791 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !786)
!792 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !786)
!793 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !776)
!794 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !795)
!795 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !776)
!796 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !795)
!797 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !795)
!798 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !776)
!799 = !DILocation(line: 1060, column: 5, scope: !754)
!800 = !DILocation(line: 1063, column: 1, scope: !754)
!801 = distinct !DISubprogram(name: "coalesce_block", scope: !3, file: !3, line: 550, type: !152, isLocal: true, isDefinition: true, scopeLine: 550, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !802)
!802 = !{!803, !804, !805, !806, !807, !808}
!803 = !DILocalVariable(name: "block", arg: 1, scope: !801, file: !3, line: 550, type: !12)
!804 = !DILocalVariable(name: "prev_block", scope: !801, file: !3, line: 552, type: !12)
!805 = !DILocalVariable(name: "next_block", scope: !801, file: !3, line: 553, type: !12)
!806 = !DILocalVariable(name: "prev_alloc", scope: !801, file: !3, line: 555, type: !36)
!807 = !DILocalVariable(name: "next_alloc", scope: !801, file: !3, line: 556, type: !36)
!808 = !DILocalVariable(name: "size", scope: !801, file: !3, line: 557, type: !31)
!809 = !DILocation(line: 550, column: 41, scope: !801)
!810 = !DILocation(line: 489, column: 36, scope: !151, inlinedAt: !811)
!811 = distinct !DILocation(line: 553, column: 27, scope: !801)
!812 = !DILocation(line: 493, column: 24, scope: !151, inlinedAt: !811)
!813 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !814)
!814 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !815)
!815 = distinct !DILocation(line: 493, column: 40, scope: !151, inlinedAt: !811)
!816 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !814)
!817 = !DILocation(line: 493, column: 38, scope: !151, inlinedAt: !811)
!818 = !DILocation(line: 553, column: 14, scope: !801)
!819 = !DILocation(line: 411, column: 37, scope: !373, inlinedAt: !820)
!820 = distinct !DILocation(line: 421, column: 12, scope: !379, inlinedAt: !821)
!821 = distinct !DILocation(line: 555, column: 29, scope: !801)
!822 = !DILocation(line: 412, column: 18, scope: !373, inlinedAt: !820)
!823 = !DILocation(line: 555, column: 23, scope: !801)
!824 = !DILocalVariable(name: "word", arg: 1, scope: !825, file: !3, line: 390, type: !7)
!825 = distinct !DISubprogram(name: "extract_alloc", scope: !3, file: !3, line: 390, type: !826, isLocal: true, isDefinition: true, scopeLine: 390, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !828)
!826 = !DISubroutineType(types: !827)
!827 = !{!36, !7}
!828 = !{!824}
!829 = !DILocation(line: 390, column: 34, scope: !825, inlinedAt: !830)
!830 = distinct !DILocation(line: 400, column: 12, scope: !831, inlinedAt: !836)
!831 = distinct !DISubprogram(name: "get_alloc", scope: !3, file: !3, line: 399, type: !832, isLocal: true, isDefinition: true, scopeLine: 399, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !834)
!832 = !DISubroutineType(types: !833)
!833 = !{!36, !12}
!834 = !{!835}
!835 = !DILocalVariable(name: "block", arg: 1, scope: !831, file: !3, line: 399, type: !12)
!836 = distinct !DILocation(line: 556, column: 23, scope: !801)
!837 = !DILocation(line: 391, column: 24, scope: !825, inlinedAt: !830)
!838 = !DILocation(line: 391, column: 12, scope: !825, inlinedAt: !830)
!839 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !840)
!840 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !841)
!841 = distinct !DILocation(line: 557, column: 19, scope: !801)
!842 = !DILocation(line: 557, column: 12, scope: !801)
!843 = !DILocation(line: 562, column: 20, scope: !844)
!844 = distinct !DILexicalBlock(scope: !801, file: !3, line: 562, column: 9)
!845 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !846)
!846 = distinct !DILocation(line: 563, column: 9, scope: !847)
!847 = distinct !DILexicalBlock(scope: !844, file: !3, line: 562, column: 35)
!848 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !846)
!849 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !846)
!850 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !851)
!851 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !846)
!852 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !851)
!853 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !851)
!854 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !851)
!855 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !846)
!856 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !857)
!857 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !846)
!858 = !DILocation(line: 352, column: 30, scope: !142, inlinedAt: !857)
!859 = !DILocation(line: 352, column: 23, scope: !142, inlinedAt: !857)
!860 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !861)
!861 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !862)
!862 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !857)
!863 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !857)
!864 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !857)
!865 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !857)
!866 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !846)
!867 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !868)
!868 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !846)
!869 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !868)
!870 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !868)
!871 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !846)
!872 = !DILocation(line: 564, column: 42, scope: !847)
!873 = !DILocation(line: 564, column: 49, scope: !847)
!874 = !DILocation(line: 564, column: 28, scope: !847)
!875 = !DILocation(line: 565, column: 5, scope: !847)
!876 = !DILocation(line: 567, column: 26, scope: !877)
!877 = distinct !DILexicalBlock(scope: !844, file: !3, line: 567, column: 14)
!878 = !DILocalVariable(name: "block", arg: 1, scope: !879, file: !3, line: 521, type: !12)
!879 = distinct !DISubprogram(name: "find_prev", scope: !3, file: !3, line: 521, type: !152, isLocal: true, isDefinition: true, scopeLine: 521, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !880)
!880 = !{!878, !881}
!881 = !DILocalVariable(name: "footerp", scope: !879, file: !3, line: 523, type: !6)
!882 = !DILocation(line: 521, column: 36, scope: !879, inlinedAt: !883)
!883 = distinct !DILocation(line: 569, column: 22, scope: !884)
!884 = distinct !DILexicalBlock(scope: !877, file: !3, line: 567, column: 41)
!885 = !DILocalVariable(name: "block", arg: 1, scope: !886, file: !3, line: 501, type: !12)
!886 = distinct !DISubprogram(name: "find_prev_footer", scope: !3, file: !3, line: 501, type: !143, isLocal: true, isDefinition: true, scopeLine: 501, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !887)
!887 = !{!885}
!888 = !DILocation(line: 501, column: 42, scope: !886, inlinedAt: !889)
!889 = distinct !DILocation(line: 523, column: 23, scope: !879, inlinedAt: !883)
!890 = !DILocation(line: 503, column: 29, scope: !886, inlinedAt: !889)
!891 = !DILocation(line: 523, column: 13, scope: !879, inlinedAt: !883)
!892 = !DILocation(line: 526, column: 22, scope: !893, inlinedAt: !883)
!893 = distinct !DILexicalBlock(scope: !879, file: !3, line: 526, column: 9)
!894 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !895)
!895 = distinct !DILocation(line: 526, column: 9, scope: !893, inlinedAt: !883)
!896 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !895)
!897 = !DILocation(line: 526, column: 32, scope: !893, inlinedAt: !883)
!898 = !DILocalVariable(name: "footer", arg: 1, scope: !899, file: !3, line: 362, type: !6)
!899 = distinct !DISubprogram(name: "footer_to_header", scope: !3, file: !3, line: 362, type: !900, isLocal: true, isDefinition: true, scopeLine: 362, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !902)
!900 = !DISubroutineType(types: !901)
!901 = !{!12, !6}
!902 = !{!898, !903}
!903 = !DILocalVariable(name: "size", scope: !899, file: !3, line: 363, type: !31)
!904 = !DILocation(line: 362, column: 42, scope: !899, inlinedAt: !905)
!905 = distinct !DILocation(line: 530, column: 12, scope: !879, inlinedAt: !883)
!906 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !907)
!907 = distinct !DILocation(line: 363, column: 19, scope: !899, inlinedAt: !905)
!908 = !DILocation(line: 363, column: 12, scope: !899, inlinedAt: !905)
!909 = !DILocation(line: 365, column: 47, scope: !899, inlinedAt: !905)
!910 = !DILocation(line: 365, column: 12, scope: !899, inlinedAt: !905)
!911 = !DILocation(line: 526, column: 9, scope: !879, inlinedAt: !883)
!912 = !DILocation(line: 552, column: 14, scope: !801)
!913 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !914)
!914 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !915)
!915 = distinct !DILocation(line: 570, column: 17, scope: !884)
!916 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !914)
!917 = !DILocation(line: 570, column: 14, scope: !884)
!918 = !DILocation(line: 718, column: 38, scope: !508, inlinedAt: !919)
!919 = distinct !DILocation(line: 573, column: 9, scope: !884)
!920 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !921)
!921 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !922)
!922 = distinct !DILocation(line: 720, column: 34, scope: !508, inlinedAt: !919)
!923 = !DILocation(line: 793, column: 38, scope: !247, inlinedAt: !924)
!924 = distinct !DILocation(line: 720, column: 18, scope: !508, inlinedAt: !919)
!925 = !DILocation(line: 794, column: 14, scope: !254, inlinedAt: !924)
!926 = !DILocation(line: 794, column: 9, scope: !247, inlinedAt: !924)
!927 = !DILocation(line: 796, column: 49, scope: !257, inlinedAt: !924)
!928 = !DILocation(line: 796, column: 40, scope: !257, inlinedAt: !924)
!929 = !DILocation(line: 798, column: 49, scope: !260, inlinedAt: !924)
!930 = !DILocation(line: 798, column: 40, scope: !260, inlinedAt: !924)
!931 = !DILocation(line: 800, column: 49, scope: !263, inlinedAt: !924)
!932 = !DILocation(line: 800, column: 40, scope: !263, inlinedAt: !924)
!933 = !DILocation(line: 802, column: 49, scope: !266, inlinedAt: !924)
!934 = !DILocation(line: 802, column: 40, scope: !266, inlinedAt: !924)
!935 = !DILocation(line: 804, column: 49, scope: !269, inlinedAt: !924)
!936 = !DILocation(line: 804, column: 40, scope: !269, inlinedAt: !924)
!937 = !DILocation(line: 806, column: 49, scope: !272, inlinedAt: !924)
!938 = !DILocation(line: 806, column: 40, scope: !272, inlinedAt: !924)
!939 = !DILocation(line: 808, column: 49, scope: !275, inlinedAt: !924)
!940 = !DILocation(line: 808, column: 40, scope: !275, inlinedAt: !924)
!941 = !DILocation(line: 810, column: 49, scope: !278, inlinedAt: !924)
!942 = !DILocation(line: 810, column: 40, scope: !278, inlinedAt: !924)
!943 = !DILocation(line: 812, column: 49, scope: !281, inlinedAt: !924)
!944 = !DILocation(line: 812, column: 40, scope: !281, inlinedAt: !924)
!945 = !DILocation(line: 814, column: 50, scope: !284, inlinedAt: !924)
!946 = !DILocation(line: 814, column: 41, scope: !284, inlinedAt: !924)
!947 = !DILocation(line: 816, column: 50, scope: !287, inlinedAt: !924)
!948 = !DILocation(line: 816, column: 41, scope: !287, inlinedAt: !924)
!949 = !DILocation(line: 818, column: 50, scope: !290, inlinedAt: !924)
!950 = !DILocation(line: 819, column: 9, scope: !290, inlinedAt: !924)
!951 = !DILocation(line: 0, scope: !290, inlinedAt: !924)
!952 = !DILocation(line: 720, column: 12, scope: !508, inlinedAt: !919)
!953 = !DILocation(line: 721, column: 34, scope: !508, inlinedAt: !919)
!954 = !DILocation(line: 721, column: 14, scope: !508, inlinedAt: !919)
!955 = !DILocation(line: 722, column: 34, scope: !508, inlinedAt: !919)
!956 = !DILocation(line: 722, column: 14, scope: !508, inlinedAt: !919)
!957 = !DILocation(line: 725, column: 20, scope: !556, inlinedAt: !919)
!958 = !DILocation(line: 0, scope: !558, inlinedAt: !919)
!959 = !DILocation(line: 725, column: 9, scope: !508, inlinedAt: !919)
!960 = !DILocation(line: 0, scope: !561, inlinedAt: !919)
!961 = !DILocation(line: 726, column: 13, scope: !563, inlinedAt: !919)
!962 = !DILocation(line: 728, column: 27, scope: !566, inlinedAt: !919)
!963 = !DILocation(line: 729, column: 9, scope: !566, inlinedAt: !919)
!964 = !DILocation(line: 731, column: 27, scope: !561, inlinedAt: !919)
!965 = !DILocation(line: 732, column: 25, scope: !561, inlinedAt: !919)
!966 = !DILocation(line: 732, column: 36, scope: !561, inlinedAt: !919)
!967 = !DILocation(line: 736, column: 14, scope: !556, inlinedAt: !919)
!968 = !DILocation(line: 738, column: 21, scope: !573, inlinedAt: !919)
!969 = !DILocation(line: 738, column: 32, scope: !573, inlinedAt: !919)
!970 = !DILocation(line: 739, column: 5, scope: !573, inlinedAt: !919)
!971 = !DILocation(line: 743, column: 21, scope: !577, inlinedAt: !919)
!972 = !DILocation(line: 743, column: 32, scope: !577, inlinedAt: !919)
!973 = !DILocation(line: 744, column: 21, scope: !577, inlinedAt: !919)
!974 = !DILocation(line: 744, column: 32, scope: !577, inlinedAt: !919)
!975 = !DILocation(line: 750, column: 1, scope: !508, inlinedAt: !919)
!976 = !DILocation(line: 749, column: 23, scope: !508, inlinedAt: !919)
!977 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !978)
!978 = distinct !DILocation(line: 576, column: 9, scope: !884)
!979 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !978)
!980 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !978)
!981 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !982)
!982 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !978)
!983 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !982)
!984 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !982)
!985 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !982)
!986 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !978)
!987 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !988)
!988 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !978)
!989 = !DILocation(line: 352, column: 30, scope: !142, inlinedAt: !988)
!990 = !DILocation(line: 352, column: 23, scope: !142, inlinedAt: !988)
!991 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !992)
!992 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !993)
!993 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !988)
!994 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !988)
!995 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !988)
!996 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !988)
!997 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !978)
!998 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !999)
!999 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !978)
!1000 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !999)
!1001 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !999)
!1002 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !978)
!1003 = !DILocation(line: 577, column: 42, scope: !884)
!1004 = !DILocation(line: 577, column: 49, scope: !884)
!1005 = !DILocation(line: 577, column: 28, scope: !884)
!1006 = !DILocation(line: 579, column: 5, scope: !884)
!1007 = !DILocation(line: 581, column: 25, scope: !1008)
!1008 = distinct !DILexicalBlock(scope: !877, file: !3, line: 581, column: 14)
!1009 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1010)
!1010 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1011)
!1011 = distinct !DILocation(line: 583, column: 17, scope: !1012)
!1012 = distinct !DILexicalBlock(scope: !1008, file: !3, line: 581, column: 41)
!1013 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !1010)
!1014 = !DILocation(line: 583, column: 14, scope: !1012)
!1015 = !DILocation(line: 718, column: 38, scope: !508, inlinedAt: !1016)
!1016 = distinct !DILocation(line: 586, column: 9, scope: !1012)
!1017 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1018)
!1018 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1019)
!1019 = distinct !DILocation(line: 720, column: 34, scope: !508, inlinedAt: !1016)
!1020 = !DILocation(line: 793, column: 38, scope: !247, inlinedAt: !1021)
!1021 = distinct !DILocation(line: 720, column: 18, scope: !508, inlinedAt: !1016)
!1022 = !DILocation(line: 794, column: 14, scope: !254, inlinedAt: !1021)
!1023 = !DILocation(line: 794, column: 9, scope: !247, inlinedAt: !1021)
!1024 = !DILocation(line: 796, column: 49, scope: !257, inlinedAt: !1021)
!1025 = !DILocation(line: 796, column: 40, scope: !257, inlinedAt: !1021)
!1026 = !DILocation(line: 798, column: 49, scope: !260, inlinedAt: !1021)
!1027 = !DILocation(line: 798, column: 40, scope: !260, inlinedAt: !1021)
!1028 = !DILocation(line: 800, column: 49, scope: !263, inlinedAt: !1021)
!1029 = !DILocation(line: 800, column: 40, scope: !263, inlinedAt: !1021)
!1030 = !DILocation(line: 802, column: 49, scope: !266, inlinedAt: !1021)
!1031 = !DILocation(line: 802, column: 40, scope: !266, inlinedAt: !1021)
!1032 = !DILocation(line: 804, column: 49, scope: !269, inlinedAt: !1021)
!1033 = !DILocation(line: 804, column: 40, scope: !269, inlinedAt: !1021)
!1034 = !DILocation(line: 806, column: 49, scope: !272, inlinedAt: !1021)
!1035 = !DILocation(line: 806, column: 40, scope: !272, inlinedAt: !1021)
!1036 = !DILocation(line: 808, column: 49, scope: !275, inlinedAt: !1021)
!1037 = !DILocation(line: 808, column: 40, scope: !275, inlinedAt: !1021)
!1038 = !DILocation(line: 810, column: 49, scope: !278, inlinedAt: !1021)
!1039 = !DILocation(line: 810, column: 40, scope: !278, inlinedAt: !1021)
!1040 = !DILocation(line: 812, column: 49, scope: !281, inlinedAt: !1021)
!1041 = !DILocation(line: 812, column: 40, scope: !281, inlinedAt: !1021)
!1042 = !DILocation(line: 814, column: 50, scope: !284, inlinedAt: !1021)
!1043 = !DILocation(line: 814, column: 41, scope: !284, inlinedAt: !1021)
!1044 = !DILocation(line: 816, column: 50, scope: !287, inlinedAt: !1021)
!1045 = !DILocation(line: 816, column: 41, scope: !287, inlinedAt: !1021)
!1046 = !DILocation(line: 818, column: 50, scope: !290, inlinedAt: !1021)
!1047 = !DILocation(line: 819, column: 9, scope: !290, inlinedAt: !1021)
!1048 = !DILocation(line: 0, scope: !290, inlinedAt: !1021)
!1049 = !DILocation(line: 720, column: 12, scope: !508, inlinedAt: !1016)
!1050 = !DILocation(line: 721, column: 34, scope: !508, inlinedAt: !1016)
!1051 = !DILocation(line: 721, column: 14, scope: !508, inlinedAt: !1016)
!1052 = !DILocation(line: 722, column: 34, scope: !508, inlinedAt: !1016)
!1053 = !DILocation(line: 722, column: 14, scope: !508, inlinedAt: !1016)
!1054 = !DILocation(line: 725, column: 20, scope: !556, inlinedAt: !1016)
!1055 = !DILocation(line: 0, scope: !558, inlinedAt: !1016)
!1056 = !DILocation(line: 725, column: 9, scope: !508, inlinedAt: !1016)
!1057 = !DILocation(line: 0, scope: !561, inlinedAt: !1016)
!1058 = !DILocation(line: 726, column: 13, scope: !563, inlinedAt: !1016)
!1059 = !DILocation(line: 728, column: 27, scope: !566, inlinedAt: !1016)
!1060 = !DILocation(line: 729, column: 9, scope: !566, inlinedAt: !1016)
!1061 = !DILocation(line: 731, column: 27, scope: !561, inlinedAt: !1016)
!1062 = !DILocation(line: 732, column: 25, scope: !561, inlinedAt: !1016)
!1063 = !DILocation(line: 732, column: 36, scope: !561, inlinedAt: !1016)
!1064 = !DILocation(line: 736, column: 14, scope: !556, inlinedAt: !1016)
!1065 = !DILocation(line: 738, column: 21, scope: !573, inlinedAt: !1016)
!1066 = !DILocation(line: 738, column: 32, scope: !573, inlinedAt: !1016)
!1067 = !DILocation(line: 739, column: 5, scope: !573, inlinedAt: !1016)
!1068 = !DILocation(line: 743, column: 21, scope: !577, inlinedAt: !1016)
!1069 = !DILocation(line: 743, column: 32, scope: !577, inlinedAt: !1016)
!1070 = !DILocation(line: 744, column: 21, scope: !577, inlinedAt: !1016)
!1071 = !DILocation(line: 744, column: 32, scope: !577, inlinedAt: !1016)
!1072 = !DILocation(line: 749, column: 23, scope: !508, inlinedAt: !1016)
!1073 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !1074)
!1074 = distinct !DILocation(line: 589, column: 9, scope: !1012)
!1075 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !1074)
!1076 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !1074)
!1077 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1078)
!1078 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !1074)
!1079 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1078)
!1080 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1078)
!1081 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !1078)
!1082 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !1074)
!1083 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !1084)
!1084 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !1074)
!1085 = !DILocation(line: 352, column: 30, scope: !142, inlinedAt: !1084)
!1086 = !DILocation(line: 352, column: 23, scope: !142, inlinedAt: !1084)
!1087 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1088)
!1088 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1089)
!1089 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !1084)
!1090 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !1084)
!1091 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !1084)
!1092 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !1084)
!1093 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !1074)
!1094 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1095)
!1095 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !1074)
!1096 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1095)
!1097 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1095)
!1098 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !1074)
!1099 = !DILocation(line: 590, column: 5, scope: !1012)
!1100 = !DILocation(line: 592, column: 26, scope: !1101)
!1101 = distinct !DILexicalBlock(scope: !1008, file: !3, line: 592, column: 14)
!1102 = !DILocation(line: 521, column: 36, scope: !879, inlinedAt: !1103)
!1103 = distinct !DILocation(line: 594, column: 22, scope: !1104)
!1104 = distinct !DILexicalBlock(scope: !1101, file: !3, line: 592, column: 42)
!1105 = !DILocation(line: 501, column: 42, scope: !886, inlinedAt: !1106)
!1106 = distinct !DILocation(line: 523, column: 23, scope: !879, inlinedAt: !1103)
!1107 = !DILocation(line: 503, column: 29, scope: !886, inlinedAt: !1106)
!1108 = !DILocation(line: 523, column: 13, scope: !879, inlinedAt: !1103)
!1109 = !DILocation(line: 526, column: 22, scope: !893, inlinedAt: !1103)
!1110 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1111)
!1111 = distinct !DILocation(line: 526, column: 9, scope: !893, inlinedAt: !1103)
!1112 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !1111)
!1113 = !DILocation(line: 526, column: 32, scope: !893, inlinedAt: !1103)
!1114 = !DILocation(line: 362, column: 42, scope: !899, inlinedAt: !1115)
!1115 = distinct !DILocation(line: 530, column: 12, scope: !879, inlinedAt: !1103)
!1116 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1117)
!1117 = distinct !DILocation(line: 363, column: 19, scope: !899, inlinedAt: !1115)
!1118 = !DILocation(line: 363, column: 12, scope: !899, inlinedAt: !1115)
!1119 = !DILocation(line: 365, column: 47, scope: !899, inlinedAt: !1115)
!1120 = !DILocation(line: 365, column: 12, scope: !899, inlinedAt: !1115)
!1121 = !DILocation(line: 526, column: 9, scope: !879, inlinedAt: !1103)
!1122 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1123)
!1123 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1124)
!1124 = distinct !DILocation(line: 595, column: 23, scope: !1104)
!1125 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !1123)
!1126 = !DILocation(line: 595, column: 21, scope: !1104)
!1127 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1128)
!1128 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1129)
!1129 = distinct !DILocation(line: 595, column: 46, scope: !1104)
!1130 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !1128)
!1131 = !DILocation(line: 595, column: 44, scope: !1104)
!1132 = !DILocation(line: 718, column: 38, scope: !508, inlinedAt: !1133)
!1133 = distinct !DILocation(line: 598, column: 9, scope: !1104)
!1134 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1135)
!1135 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1136)
!1136 = distinct !DILocation(line: 720, column: 34, scope: !508, inlinedAt: !1133)
!1137 = !DILocation(line: 793, column: 38, scope: !247, inlinedAt: !1138)
!1138 = distinct !DILocation(line: 720, column: 18, scope: !508, inlinedAt: !1133)
!1139 = !DILocation(line: 794, column: 14, scope: !254, inlinedAt: !1138)
!1140 = !DILocation(line: 794, column: 9, scope: !247, inlinedAt: !1138)
!1141 = !DILocation(line: 796, column: 49, scope: !257, inlinedAt: !1138)
!1142 = !DILocation(line: 796, column: 40, scope: !257, inlinedAt: !1138)
!1143 = !DILocation(line: 798, column: 49, scope: !260, inlinedAt: !1138)
!1144 = !DILocation(line: 798, column: 40, scope: !260, inlinedAt: !1138)
!1145 = !DILocation(line: 800, column: 49, scope: !263, inlinedAt: !1138)
!1146 = !DILocation(line: 800, column: 40, scope: !263, inlinedAt: !1138)
!1147 = !DILocation(line: 802, column: 49, scope: !266, inlinedAt: !1138)
!1148 = !DILocation(line: 802, column: 40, scope: !266, inlinedAt: !1138)
!1149 = !DILocation(line: 804, column: 49, scope: !269, inlinedAt: !1138)
!1150 = !DILocation(line: 804, column: 40, scope: !269, inlinedAt: !1138)
!1151 = !DILocation(line: 806, column: 49, scope: !272, inlinedAt: !1138)
!1152 = !DILocation(line: 806, column: 40, scope: !272, inlinedAt: !1138)
!1153 = !DILocation(line: 808, column: 49, scope: !275, inlinedAt: !1138)
!1154 = !DILocation(line: 808, column: 40, scope: !275, inlinedAt: !1138)
!1155 = !DILocation(line: 810, column: 49, scope: !278, inlinedAt: !1138)
!1156 = !DILocation(line: 810, column: 40, scope: !278, inlinedAt: !1138)
!1157 = !DILocation(line: 812, column: 49, scope: !281, inlinedAt: !1138)
!1158 = !DILocation(line: 812, column: 40, scope: !281, inlinedAt: !1138)
!1159 = !DILocation(line: 814, column: 50, scope: !284, inlinedAt: !1138)
!1160 = !DILocation(line: 814, column: 41, scope: !284, inlinedAt: !1138)
!1161 = !DILocation(line: 816, column: 50, scope: !287, inlinedAt: !1138)
!1162 = !DILocation(line: 816, column: 41, scope: !287, inlinedAt: !1138)
!1163 = !DILocation(line: 818, column: 50, scope: !290, inlinedAt: !1138)
!1164 = !DILocation(line: 819, column: 9, scope: !290, inlinedAt: !1138)
!1165 = !DILocation(line: 0, scope: !290, inlinedAt: !1138)
!1166 = !DILocation(line: 720, column: 12, scope: !508, inlinedAt: !1133)
!1167 = !DILocation(line: 721, column: 34, scope: !508, inlinedAt: !1133)
!1168 = !DILocation(line: 721, column: 14, scope: !508, inlinedAt: !1133)
!1169 = !DILocation(line: 722, column: 34, scope: !508, inlinedAt: !1133)
!1170 = !DILocation(line: 722, column: 14, scope: !508, inlinedAt: !1133)
!1171 = !DILocation(line: 725, column: 20, scope: !556, inlinedAt: !1133)
!1172 = !DILocation(line: 0, scope: !558, inlinedAt: !1133)
!1173 = !DILocation(line: 725, column: 9, scope: !508, inlinedAt: !1133)
!1174 = !DILocation(line: 0, scope: !561, inlinedAt: !1133)
!1175 = !DILocation(line: 726, column: 13, scope: !563, inlinedAt: !1133)
!1176 = !DILocation(line: 728, column: 27, scope: !566, inlinedAt: !1133)
!1177 = !DILocation(line: 729, column: 9, scope: !566, inlinedAt: !1133)
!1178 = !DILocation(line: 731, column: 27, scope: !561, inlinedAt: !1133)
!1179 = !DILocation(line: 732, column: 25, scope: !561, inlinedAt: !1133)
!1180 = !DILocation(line: 732, column: 36, scope: !561, inlinedAt: !1133)
!1181 = !DILocation(line: 736, column: 14, scope: !556, inlinedAt: !1133)
!1182 = !DILocation(line: 738, column: 21, scope: !573, inlinedAt: !1133)
!1183 = !DILocation(line: 738, column: 32, scope: !573, inlinedAt: !1133)
!1184 = !DILocation(line: 739, column: 5, scope: !573, inlinedAt: !1133)
!1185 = !DILocation(line: 743, column: 21, scope: !577, inlinedAt: !1133)
!1186 = !DILocation(line: 743, column: 32, scope: !577, inlinedAt: !1133)
!1187 = !DILocation(line: 744, column: 21, scope: !577, inlinedAt: !1133)
!1188 = !DILocation(line: 744, column: 32, scope: !577, inlinedAt: !1133)
!1189 = !DILocation(line: 749, column: 23, scope: !508, inlinedAt: !1133)
!1190 = !DILocation(line: 718, column: 38, scope: !508, inlinedAt: !1191)
!1191 = distinct !DILocation(line: 599, column: 9, scope: !1104)
!1192 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1193)
!1193 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1194)
!1194 = distinct !DILocation(line: 720, column: 34, scope: !508, inlinedAt: !1191)
!1195 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !1193)
!1196 = !DILocation(line: 793, column: 38, scope: !247, inlinedAt: !1197)
!1197 = distinct !DILocation(line: 720, column: 18, scope: !508, inlinedAt: !1191)
!1198 = !DILocation(line: 794, column: 14, scope: !254, inlinedAt: !1197)
!1199 = !DILocation(line: 794, column: 9, scope: !247, inlinedAt: !1197)
!1200 = !DILocation(line: 796, column: 49, scope: !257, inlinedAt: !1197)
!1201 = !DILocation(line: 796, column: 40, scope: !257, inlinedAt: !1197)
!1202 = !DILocation(line: 798, column: 49, scope: !260, inlinedAt: !1197)
!1203 = !DILocation(line: 798, column: 40, scope: !260, inlinedAt: !1197)
!1204 = !DILocation(line: 800, column: 49, scope: !263, inlinedAt: !1197)
!1205 = !DILocation(line: 800, column: 40, scope: !263, inlinedAt: !1197)
!1206 = !DILocation(line: 802, column: 49, scope: !266, inlinedAt: !1197)
!1207 = !DILocation(line: 802, column: 40, scope: !266, inlinedAt: !1197)
!1208 = !DILocation(line: 804, column: 49, scope: !269, inlinedAt: !1197)
!1209 = !DILocation(line: 804, column: 40, scope: !269, inlinedAt: !1197)
!1210 = !DILocation(line: 806, column: 49, scope: !272, inlinedAt: !1197)
!1211 = !DILocation(line: 806, column: 40, scope: !272, inlinedAt: !1197)
!1212 = !DILocation(line: 808, column: 49, scope: !275, inlinedAt: !1197)
!1213 = !DILocation(line: 808, column: 40, scope: !275, inlinedAt: !1197)
!1214 = !DILocation(line: 810, column: 49, scope: !278, inlinedAt: !1197)
!1215 = !DILocation(line: 810, column: 40, scope: !278, inlinedAt: !1197)
!1216 = !DILocation(line: 812, column: 49, scope: !281, inlinedAt: !1197)
!1217 = !DILocation(line: 812, column: 40, scope: !281, inlinedAt: !1197)
!1218 = !DILocation(line: 814, column: 50, scope: !284, inlinedAt: !1197)
!1219 = !DILocation(line: 814, column: 41, scope: !284, inlinedAt: !1197)
!1220 = !DILocation(line: 816, column: 50, scope: !287, inlinedAt: !1197)
!1221 = !DILocation(line: 816, column: 41, scope: !287, inlinedAt: !1197)
!1222 = !DILocation(line: 818, column: 50, scope: !290, inlinedAt: !1197)
!1223 = !DILocation(line: 819, column: 9, scope: !290, inlinedAt: !1197)
!1224 = !DILocation(line: 0, scope: !290, inlinedAt: !1197)
!1225 = !DILocation(line: 720, column: 12, scope: !508, inlinedAt: !1191)
!1226 = !DILocation(line: 721, column: 34, scope: !508, inlinedAt: !1191)
!1227 = !DILocation(line: 721, column: 14, scope: !508, inlinedAt: !1191)
!1228 = !DILocation(line: 722, column: 34, scope: !508, inlinedAt: !1191)
!1229 = !DILocation(line: 722, column: 14, scope: !508, inlinedAt: !1191)
!1230 = !DILocation(line: 725, column: 20, scope: !556, inlinedAt: !1191)
!1231 = !DILocation(line: 0, scope: !558, inlinedAt: !1191)
!1232 = !DILocation(line: 725, column: 9, scope: !508, inlinedAt: !1191)
!1233 = !DILocation(line: 0, scope: !561, inlinedAt: !1191)
!1234 = !DILocation(line: 726, column: 13, scope: !563, inlinedAt: !1191)
!1235 = !DILocation(line: 728, column: 27, scope: !566, inlinedAt: !1191)
!1236 = !DILocation(line: 729, column: 9, scope: !566, inlinedAt: !1191)
!1237 = !DILocation(line: 731, column: 27, scope: !561, inlinedAt: !1191)
!1238 = !DILocation(line: 732, column: 25, scope: !561, inlinedAt: !1191)
!1239 = !DILocation(line: 732, column: 36, scope: !561, inlinedAt: !1191)
!1240 = !DILocation(line: 736, column: 14, scope: !556, inlinedAt: !1191)
!1241 = !DILocation(line: 738, column: 21, scope: !573, inlinedAt: !1191)
!1242 = !DILocation(line: 738, column: 32, scope: !573, inlinedAt: !1191)
!1243 = !DILocation(line: 739, column: 5, scope: !573, inlinedAt: !1191)
!1244 = !DILocation(line: 743, column: 21, scope: !577, inlinedAt: !1191)
!1245 = !DILocation(line: 743, column: 32, scope: !577, inlinedAt: !1191)
!1246 = !DILocation(line: 744, column: 21, scope: !577, inlinedAt: !1191)
!1247 = !DILocation(line: 744, column: 32, scope: !577, inlinedAt: !1191)
!1248 = !DILocation(line: 750, column: 1, scope: !508, inlinedAt: !1191)
!1249 = !DILocation(line: 749, column: 23, scope: !508, inlinedAt: !1191)
!1250 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !1251)
!1251 = distinct !DILocation(line: 602, column: 9, scope: !1104)
!1252 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !1251)
!1253 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !1251)
!1254 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1255)
!1255 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !1251)
!1256 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1255)
!1257 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1255)
!1258 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !1255)
!1259 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !1251)
!1260 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !1261)
!1261 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !1251)
!1262 = !DILocation(line: 352, column: 30, scope: !142, inlinedAt: !1261)
!1263 = !DILocation(line: 352, column: 23, scope: !142, inlinedAt: !1261)
!1264 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1265)
!1265 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1266)
!1266 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !1261)
!1267 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !1261)
!1268 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !1261)
!1269 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !1261)
!1270 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !1251)
!1271 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1272)
!1272 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !1251)
!1273 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1272)
!1274 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1272)
!1275 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !1251)
!1276 = !DILocation(line: 604, column: 5, scope: !1104)
!1277 = !DILocation(line: 0, scope: !884)
!1278 = !DILocation(line: 763, column: 35, scope: !624, inlinedAt: !1279)
!1279 = distinct !DILocation(line: 622, column: 5, scope: !801)
!1280 = !DILocation(line: 763, column: 49, scope: !624, inlinedAt: !1279)
!1281 = !DILocation(line: 793, column: 38, scope: !247, inlinedAt: !1282)
!1282 = distinct !DILocation(line: 765, column: 24, scope: !624, inlinedAt: !1279)
!1283 = !DILocation(line: 794, column: 14, scope: !254, inlinedAt: !1282)
!1284 = !DILocation(line: 794, column: 9, scope: !247, inlinedAt: !1282)
!1285 = !DILocation(line: 796, column: 49, scope: !257, inlinedAt: !1282)
!1286 = !DILocation(line: 796, column: 40, scope: !257, inlinedAt: !1282)
!1287 = !DILocation(line: 798, column: 49, scope: !260, inlinedAt: !1282)
!1288 = !DILocation(line: 798, column: 40, scope: !260, inlinedAt: !1282)
!1289 = !DILocation(line: 800, column: 49, scope: !263, inlinedAt: !1282)
!1290 = !DILocation(line: 800, column: 40, scope: !263, inlinedAt: !1282)
!1291 = !DILocation(line: 802, column: 49, scope: !266, inlinedAt: !1282)
!1292 = !DILocation(line: 802, column: 40, scope: !266, inlinedAt: !1282)
!1293 = !DILocation(line: 804, column: 49, scope: !269, inlinedAt: !1282)
!1294 = !DILocation(line: 804, column: 40, scope: !269, inlinedAt: !1282)
!1295 = !DILocation(line: 806, column: 49, scope: !272, inlinedAt: !1282)
!1296 = !DILocation(line: 806, column: 40, scope: !272, inlinedAt: !1282)
!1297 = !DILocation(line: 808, column: 49, scope: !275, inlinedAt: !1282)
!1298 = !DILocation(line: 808, column: 40, scope: !275, inlinedAt: !1282)
!1299 = !DILocation(line: 810, column: 49, scope: !278, inlinedAt: !1282)
!1300 = !DILocation(line: 810, column: 40, scope: !278, inlinedAt: !1282)
!1301 = !DILocation(line: 812, column: 49, scope: !281, inlinedAt: !1282)
!1302 = !DILocation(line: 812, column: 40, scope: !281, inlinedAt: !1282)
!1303 = !DILocation(line: 814, column: 50, scope: !284, inlinedAt: !1282)
!1304 = !DILocation(line: 814, column: 41, scope: !284, inlinedAt: !1282)
!1305 = !DILocation(line: 816, column: 50, scope: !287, inlinedAt: !1282)
!1306 = !DILocation(line: 816, column: 41, scope: !287, inlinedAt: !1282)
!1307 = !DILocation(line: 818, column: 50, scope: !290, inlinedAt: !1282)
!1308 = !DILocation(line: 819, column: 9, scope: !290, inlinedAt: !1282)
!1309 = !DILocation(line: 0, scope: !290, inlinedAt: !1282)
!1310 = !DILocation(line: 765, column: 12, scope: !624, inlinedAt: !1279)
!1311 = !DILocation(line: 768, column: 9, scope: !660, inlinedAt: !1279)
!1312 = !DILocation(line: 768, column: 29, scope: !660, inlinedAt: !1279)
!1313 = !DILocation(line: 0, scope: !663, inlinedAt: !1279)
!1314 = !DILocation(line: 768, column: 9, scope: !624, inlinedAt: !1279)
!1315 = !DILocation(line: 772, column: 16, scope: !666, inlinedAt: !1279)
!1316 = !DILocation(line: 772, column: 27, scope: !666, inlinedAt: !1279)
!1317 = !DILocation(line: 774, column: 5, scope: !666, inlinedAt: !1279)
!1318 = !DILocation(line: 779, column: 16, scope: !663, inlinedAt: !1279)
!1319 = !DILocation(line: 779, column: 27, scope: !663, inlinedAt: !1279)
!1320 = !DILocation(line: 780, column: 30, scope: !663, inlinedAt: !1279)
!1321 = !DILocation(line: 780, column: 41, scope: !663, inlinedAt: !1279)
!1322 = !DILocation(line: 0, scope: !666, inlinedAt: !1279)
!1323 = !DILocation(line: 624, column: 5, scope: !801)
!1324 = distinct !DISubprogram(name: "mm_realloc", scope: !3, file: !3, line: 1077, type: !1325, isLocal: false, isDefinition: true, scopeLine: 1077, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1327)
!1325 = !DISubroutineType(types: !1326)
!1326 = !{!11, !11, !31}
!1327 = !{!1328, !1329, !1330, !1331, !1332}
!1328 = !DILocalVariable(name: "ptr", arg: 1, scope: !1324, file: !3, line: 1077, type: !11)
!1329 = !DILocalVariable(name: "size", arg: 2, scope: !1324, file: !3, line: 1077, type: !31)
!1330 = !DILocalVariable(name: "block", scope: !1324, file: !3, line: 1078, type: !12)
!1331 = !DILocalVariable(name: "copysize", scope: !1324, file: !3, line: 1079, type: !31)
!1332 = !DILocalVariable(name: "newptr", scope: !1324, file: !3, line: 1080, type: !11)
!1333 = !DILocation(line: 1077, column: 21, scope: !1324)
!1334 = !DILocation(line: 1077, column: 33, scope: !1324)
!1335 = !DILocation(line: 326, column: 41, scope: !116, inlinedAt: !1336)
!1336 = distinct !DILocation(line: 1078, column: 22, scope: !1324)
!1337 = !DILocation(line: 327, column: 35, scope: !116, inlinedAt: !1336)
!1338 = !DILocation(line: 327, column: 12, scope: !116, inlinedAt: !1336)
!1339 = !DILocation(line: 1078, column: 14, scope: !1324)
!1340 = !DILocation(line: 1083, column: 14, scope: !1341)
!1341 = distinct !DILexicalBlock(scope: !1324, file: !3, line: 1083, column: 9)
!1342 = !DILocation(line: 0, scope: !1343)
!1343 = distinct !DILexicalBlock(scope: !1324, file: !3, line: 1089, column: 9)
!1344 = !DILocation(line: 1083, column: 9, scope: !1324)
!1345 = !DILocation(line: 1043, column: 17, scope: !754, inlinedAt: !1346)
!1346 = distinct !DILocation(line: 1084, column: 9, scope: !1347)
!1347 = distinct !DILexicalBlock(scope: !1341, file: !3, line: 1083, column: 20)
!1348 = !DILocation(line: 1046, column: 9, scope: !754, inlinedAt: !1346)
!1349 = !DILocation(line: 326, column: 41, scope: !116, inlinedAt: !1350)
!1350 = distinct !DILocation(line: 1050, column: 22, scope: !754, inlinedAt: !1346)
!1351 = !DILocation(line: 1050, column: 14, scope: !754, inlinedAt: !1346)
!1352 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1353)
!1353 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1354)
!1354 = distinct !DILocation(line: 1051, column: 19, scope: !754, inlinedAt: !1346)
!1355 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !1353)
!1356 = !DILocation(line: 1051, column: 12, scope: !754, inlinedAt: !1346)
!1357 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !1358)
!1358 = distinct !DILocation(line: 1057, column: 5, scope: !754, inlinedAt: !1346)
!1359 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !1358)
!1360 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !1358)
!1361 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1362)
!1362 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !1358)
!1363 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1362)
!1364 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1362)
!1365 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !1362)
!1366 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !1358)
!1367 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !1368)
!1368 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !1358)
!1369 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1370)
!1370 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1371)
!1371 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !1368)
!1372 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !1368)
!1373 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !1368)
!1374 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !1368)
!1375 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !1358)
!1376 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1377)
!1377 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !1358)
!1378 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1377)
!1379 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1377)
!1380 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !1358)
!1381 = !DILocation(line: 1060, column: 5, scope: !754, inlinedAt: !1346)
!1382 = !DILocation(line: 1063, column: 1, scope: !754, inlinedAt: !1346)
!1383 = !DILocation(line: 0, scope: !1324)
!1384 = !DILocation(line: 1089, column: 9, scope: !1324)
!1385 = !DILocation(line: 1080, column: 11, scope: !1324)
!1386 = !DILocation(line: 1097, column: 16, scope: !1387)
!1387 = distinct !DILexicalBlock(scope: !1324, file: !3, line: 1097, column: 9)
!1388 = !DILocation(line: 1097, column: 9, scope: !1324)
!1389 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1390)
!1390 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1391)
!1391 = distinct !DILocation(line: 378, column: 20, scope: !1392, inlinedAt: !1396)
!1392 = distinct !DISubprogram(name: "get_payload_size", scope: !3, file: !3, line: 377, type: !325, isLocal: true, isDefinition: true, scopeLine: 377, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1393)
!1393 = !{!1394, !1395}
!1394 = !DILocalVariable(name: "block", arg: 1, scope: !1392, file: !3, line: 377, type: !12)
!1395 = !DILocalVariable(name: "asize", scope: !1392, file: !3, line: 378, type: !31)
!1396 = distinct !DILocation(line: 1102, column: 16, scope: !1324)
!1397 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !1390)
!1398 = !DILocation(line: 378, column: 12, scope: !1392, inlinedAt: !1396)
!1399 = !DILocation(line: 379, column: 18, scope: !1392, inlinedAt: !1396)
!1400 = !DILocation(line: 1079, column: 12, scope: !1324)
!1401 = !DILocation(line: 1103, column: 14, scope: !1402)
!1402 = distinct !DILexicalBlock(scope: !1324, file: !3, line: 1103, column: 9)
!1403 = !DILocation(line: 1103, column: 9, scope: !1324)
!1404 = !DILocation(line: 1106, column: 5, scope: !1324)
!1405 = !DILocation(line: 1043, column: 17, scope: !754, inlinedAt: !1406)
!1406 = distinct !DILocation(line: 1109, column: 5, scope: !1324)
!1407 = !DILocation(line: 326, column: 41, scope: !116, inlinedAt: !1408)
!1408 = distinct !DILocation(line: 1050, column: 22, scope: !754, inlinedAt: !1406)
!1409 = !DILocation(line: 1050, column: 14, scope: !754, inlinedAt: !1406)
!1410 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1411)
!1411 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1412)
!1412 = distinct !DILocation(line: 1051, column: 19, scope: !754, inlinedAt: !1406)
!1413 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !1411)
!1414 = !DILocation(line: 1051, column: 12, scope: !754, inlinedAt: !1406)
!1415 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !1416)
!1416 = distinct !DILocation(line: 1057, column: 5, scope: !754, inlinedAt: !1406)
!1417 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !1416)
!1418 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !1416)
!1419 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1420)
!1420 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !1416)
!1421 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1420)
!1422 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1420)
!1423 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !1420)
!1424 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !1416)
!1425 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !1426)
!1426 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !1416)
!1427 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1428)
!1428 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1429)
!1429 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !1426)
!1430 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !1426)
!1431 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !1426)
!1432 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !1426)
!1433 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !1416)
!1434 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1435)
!1435 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !1416)
!1436 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1435)
!1437 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1435)
!1438 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !1416)
!1439 = !DILocation(line: 1060, column: 5, scope: !754, inlinedAt: !1406)
!1440 = !DILocation(line: 1043, column: 17, scope: !754, inlinedAt: !1441)
!1441 = distinct !DILocation(line: 1109, column: 5, scope: !1324)
!1442 = !DILocation(line: 326, column: 41, scope: !116, inlinedAt: !1443)
!1443 = distinct !DILocation(line: 1050, column: 22, scope: !754, inlinedAt: !1441)
!1444 = !DILocation(line: 1050, column: 14, scope: !754, inlinedAt: !1441)
!1445 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1446)
!1446 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1447)
!1447 = distinct !DILocation(line: 1051, column: 19, scope: !754, inlinedAt: !1441)
!1448 = !DILocation(line: 308, column: 18, scope: !318, inlinedAt: !1446)
!1449 = !DILocation(line: 1051, column: 12, scope: !754, inlinedAt: !1441)
!1450 = !DILocation(line: 471, column: 39, scope: !126, inlinedAt: !1451)
!1451 = distinct !DILocation(line: 1057, column: 5, scope: !754, inlinedAt: !1441)
!1452 = !DILocation(line: 471, column: 53, scope: !126, inlinedAt: !1451)
!1453 = !DILocation(line: 471, column: 66, scope: !126, inlinedAt: !1451)
!1454 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1455)
!1455 = distinct !DILocation(line: 474, column: 21, scope: !126, inlinedAt: !1451)
!1456 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1455)
!1457 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1455)
!1458 = !DILocation(line: 289, column: 9, scope: !404, inlinedAt: !1455)
!1459 = !DILocation(line: 474, column: 19, scope: !126, inlinedAt: !1451)
!1460 = !DILocation(line: 349, column: 42, scope: !142, inlinedAt: !1461)
!1461 = distinct !DILocation(line: 475, column: 23, scope: !126, inlinedAt: !1451)
!1462 = !DILocation(line: 307, column: 35, scope: !318, inlinedAt: !1463)
!1463 = distinct !DILocation(line: 317, column: 12, scope: !324, inlinedAt: !1464)
!1464 = distinct !DILocation(line: 352, column: 40, scope: !142, inlinedAt: !1461)
!1465 = !DILocation(line: 352, column: 38, scope: !142, inlinedAt: !1461)
!1466 = !DILocation(line: 352, column: 56, scope: !142, inlinedAt: !1461)
!1467 = !DILocation(line: 352, column: 12, scope: !142, inlinedAt: !1461)
!1468 = !DILocation(line: 475, column: 13, scope: !126, inlinedAt: !1451)
!1469 = !DILocation(line: 287, column: 32, scope: !404, inlinedAt: !1470)
!1470 = distinct !DILocation(line: 476, column: 16, scope: !126, inlinedAt: !1451)
!1471 = !DILocation(line: 287, column: 45, scope: !404, inlinedAt: !1470)
!1472 = !DILocation(line: 288, column: 12, scope: !404, inlinedAt: !1470)
!1473 = !DILocation(line: 476, column: 14, scope: !126, inlinedAt: !1451)
!1474 = !DILocation(line: 1060, column: 5, scope: !754, inlinedAt: !1441)
!1475 = !DILocation(line: 1105, column: 5, scope: !1476)
!1476 = distinct !DILexicalBlock(scope: !1402, file: !3, line: 1103, column: 26)
!1477 = !DILocation(line: 1112, column: 1, scope: !1324)
!1478 = distinct !DISubprogram(name: "mm_calloc", scope: !3, file: !3, line: 1127, type: !1479, isLocal: false, isDefinition: true, scopeLine: 1127, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !1481)
!1479 = !DISubroutineType(types: !1480)
!1480 = !{!11, !31, !31}
!1481 = !{!1482, !1483, !1484, !1485}
!1482 = !DILocalVariable(name: "elements", arg: 1, scope: !1478, file: !3, line: 1127, type: !31)
!1483 = !DILocalVariable(name: "size", arg: 2, scope: !1478, file: !3, line: 1127, type: !31)
!1484 = !DILocalVariable(name: "bp", scope: !1478, file: !3, line: 1128, type: !11)
!1485 = !DILocalVariable(name: "asize", scope: !1478, file: !3, line: 1129, type: !31)
!1486 = !DILocation(line: 1127, column: 21, scope: !1478)
!1487 = !DILocation(line: 1127, column: 38, scope: !1478)
!1488 = !DILocation(line: 1129, column: 29, scope: !1478)
!1489 = !DILocation(line: 1129, column: 12, scope: !1478)
!1490 = !DILocation(line: 1131, column: 18, scope: !1491)
!1491 = distinct !DILexicalBlock(scope: !1478, file: !3, line: 1131, column: 9)
!1492 = !DILocation(line: 1131, column: 9, scope: !1478)
!1493 = !DILocation(line: 1134, column: 15, scope: !1494)
!1494 = distinct !DILexicalBlock(scope: !1478, file: !3, line: 1134, column: 9)
!1495 = !DILocation(line: 1134, column: 26, scope: !1494)
!1496 = !DILocation(line: 1134, column: 9, scope: !1478)
!1497 = !DILocation(line: 1139, column: 10, scope: !1478)
!1498 = !DILocation(line: 1128, column: 11, scope: !1478)
!1499 = !DILocation(line: 1140, column: 12, scope: !1500)
!1500 = distinct !DILexicalBlock(scope: !1478, file: !3, line: 1140, column: 9)
!1501 = !DILocation(line: 1140, column: 9, scope: !1478)
!1502 = !DILocation(line: 1145, column: 5, scope: !1478)
!1503 = !DILocation(line: 1147, column: 5, scope: !1478)
!1504 = !DILocation(line: 0, scope: !1478)
!1505 = !DILocation(line: 1148, column: 1, scope: !1478)
