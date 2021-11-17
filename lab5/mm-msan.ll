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
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 0, void ()* @msan.module_ctor, i8* null }]
@__msan_track_origins = weak_odr local_unnamed_addr constant i32 2
@__msan_retval_tls = external thread_local(initialexec) global [100 x i64]
@__msan_retval_origin_tls = external thread_local(initialexec) global i32
@__msan_param_tls = external thread_local(initialexec) global [100 x i64]
@__msan_param_origin_tls = external thread_local(initialexec) global [200 x i32]
@__msan_va_arg_tls = external thread_local(initialexec) global [100 x i64]
@__msan_va_arg_overflow_size_tls = external thread_local(initialexec) global i64
@__msan_origin_tls = external thread_local(initialexec) global i32

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local zeroext i1 @mm_checkheap(i32 %line) local_unnamed_addr #0 !dbg !65 {
entry:
  call void @llvm.dbg.value(metadata i32 %line, metadata !70, metadata !DIExpression()), !dbg !71
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !72
  store i32 0, i32* @__msan_retval_origin_tls, align 4, !dbg !72
  ret i1 true, !dbg !72
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local zeroext i1 @mm_init() local_unnamed_addr #0 !dbg !73 {
entry:
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !80
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !80
  %call = call i8* @mem_sbrk(i64 16) #4, !dbg !80
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !81
  %0 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !81
  %1 = ptrtoint i8* %call to i64, !dbg !81
  %.demorgan = or i64 %_msret, %1, !dbg !81
  %2 = icmp eq i64 %.demorgan, -1, !dbg !81
  %3 = icmp ne i64 %_msret, 0, !dbg !81
  %_msprop_icmp = and i1 %3, %2, !dbg !81
  br i1 %_msprop_icmp, label %4, label %5, !dbg !83, !prof !84

; <label>:4:                                      ; preds = %entry
  store i32 %0, i32* @__msan_origin_tls, align 4, !dbg !83
  call void @__msan_warning_noreturn() #4, !dbg !83
  call void asm sideeffect "", ""() #4, !dbg !83
  unreachable, !dbg !83

; <label>:5:                                      ; preds = %entry
  %cmp = icmp eq i8* %call, inttoptr (i64 -1 to i8*), !dbg !81
  br i1 %cmp, label %return, label %for.end, !dbg !83

for.end:                                          ; preds = %5
  %6 = bitcast i8* %call to i64*, !dbg !85
  call void @llvm.dbg.value(metadata i64* %6, metadata !77, metadata !DIExpression()), !dbg !86
  %7 = call i8* @__msan_memset(i8* bitcast ([14 x %struct.block*]* @seg_list to i8*), i32 0, i64 112) #4, !dbg !87
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !90
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !90
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !90
  %call2 = call fastcc i64 @pack_foot(i64 0, i64 1), !dbg !90
  %_msret17 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !91
  %8 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !91
  br i1 %3, label %9, label %10, !dbg !91, !prof !84

; <label>:9:                                      ; preds = %for.end
  store i32 %0, i32* @__msan_origin_tls, align 4, !dbg !91
  call void @__msan_warning_noreturn() #4, !dbg !91
  call void asm sideeffect "", ""() #4, !dbg !91
  unreachable, !dbg !91

; <label>:10:                                     ; preds = %for.end
  %11 = ptrtoint i8* %call to i64, !dbg !91
  %12 = xor i64 %11, 87960930222080, !dbg !91
  %13 = inttoptr i64 %12 to i64*, !dbg !91
  store i64 %_msret17, i64* %13, align 8, !dbg !91
  %_mscmp23 = icmp eq i64 %_msret17, 0, !dbg !91
  br i1 %_mscmp23, label %21, label %14, !dbg !91, !prof !92

; <label>:14:                                     ; preds = %10
  %15 = add i64 %12, 17592186044416, !dbg !91
  %16 = call i32 @__msan_chain_origin(i32 %8) #4, !dbg !91
  %17 = zext i32 %16 to i64, !dbg !91
  %18 = shl nuw i64 %17, 32, !dbg !91
  %19 = or i64 %18, %17, !dbg !91
  %20 = inttoptr i64 %15 to i64*, !dbg !91
  store i64 %19, i64* %20, align 8, !dbg !91
  br label %21, !dbg !91

; <label>:21:                                     ; preds = %10, %14
  store i64 %call2, i64* %6, align 8, !dbg !91, !tbaa !93
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !97
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !97
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !97
  %call4 = call fastcc i64 @pack_foot(i64 0, i64 3), !dbg !97
  %_msret18 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !98
  %22 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !98
  %arrayidx5 = getelementptr inbounds i8, i8* %call, i64 8, !dbg !98
  %23 = bitcast i8* %arrayidx5 to i64*, !dbg !98
  br i1 false, label %24, label %25, !dbg !99, !prof !84

; <label>:24:                                     ; preds = %21
  unreachable, !dbg !99

; <label>:25:                                     ; preds = %21
  %26 = ptrtoint i8* %arrayidx5 to i64, !dbg !99
  %27 = xor i64 %26, 87960930222080, !dbg !99
  %28 = inttoptr i64 %27 to i64*, !dbg !99
  store i64 %_msret18, i64* %28, align 8, !dbg !99
  %_mscmp24 = icmp eq i64 %_msret18, 0, !dbg !99
  br i1 %_mscmp24, label %36, label %29, !dbg !99, !prof !92

; <label>:29:                                     ; preds = %25
  %30 = add i64 %27, 17592186044416, !dbg !99
  %31 = call i32 @__msan_chain_origin(i32 %22) #4, !dbg !99
  %32 = zext i32 %31 to i64, !dbg !99
  %33 = shl nuw i64 %32, 32, !dbg !99
  %34 = or i64 %33, %32, !dbg !99
  %35 = inttoptr i64 %30 to i64*, !dbg !99
  store i64 %34, i64* %35, align 8, !dbg !99
  br label %36, !dbg !99

; <label>:36:                                     ; preds = %25, %29
  store i64 %call4, i64* %23, align 8, !dbg !99, !tbaa !93
  store i64 0, i64* inttoptr (i64 xor (i64 ptrtoint (%struct.block** @heap_start to i64), i64 87960930222080) to i64*), align 8, !dbg !100
  br i1 false, label %37, label %38, !dbg !100, !prof !84

; <label>:37:                                     ; preds = %36
  br label %38, !dbg !100

; <label>:38:                                     ; preds = %36, %37
  store i8* %arrayidx5, i8** bitcast (%struct.block** @heap_start to i8**), align 8, !dbg !100, !tbaa !101
  store i64 0, i64* inttoptr (i64 xor (i64 ptrtoint (%struct.block** @heap_epi to i64), i64 87960930222080) to i64*), align 8, !dbg !103
  br i1 false, label %39, label %40, !dbg !103, !prof !84

; <label>:39:                                     ; preds = %38
  br label %40, !dbg !103

; <label>:40:                                     ; preds = %38, %39
  store i8* %arrayidx5, i8** bitcast (%struct.block** @heap_epi to i8**), align 8, !dbg !103, !tbaa !101
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !104
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !104
  %call7 = call fastcc %struct.block* @extend_heap(i64 1024), !dbg !104
  %_msret19 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !106
  %41 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !106
  %42 = ptrtoint %struct.block* %call7 to i64, !dbg !106
  %43 = xor i64 %_msret19, -1, !dbg !106
  %44 = and i64 %43, %42, !dbg !106
  %45 = icmp eq i64 %44, 0, !dbg !106
  %46 = icmp ne i64 %_msret19, 0, !dbg !106
  %_msprop_icmp20 = and i1 %46, %45, !dbg !106
  %cmp8 = icmp ne %struct.block* %call7, null, !dbg !106
  br label %return, !dbg !107

return:                                           ; preds = %40, %5
  %_msphi_s = phi i1 [ false, %5 ], [ %_msprop_icmp20, %40 ], !dbg !109
  %_msphi_o = phi i32 [ 0, %5 ], [ %41, %40 ], !dbg !109
  %retval.0 = phi i1 [ false, %5 ], [ %cmp8, %40 ], !dbg !109
  store i1 %_msphi_s, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !110
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !110
  ret i1 %retval.0, !dbg !110
}

declare dso_local i8* @mem_sbrk(i64) local_unnamed_addr #1

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @pack_foot(i64 %size, i64 %alloc) unnamed_addr #0 !dbg !111 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !118
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !118
  %2 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !118
  %3 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !118
  call void @llvm.dbg.value(metadata i64 %size, metadata !115, metadata !DIExpression()), !dbg !118
  call void @llvm.dbg.value(metadata i64 %alloc, metadata !116, metadata !DIExpression()), !dbg !119
  call void @llvm.dbg.value(metadata i64 %size, metadata !117, metadata !DIExpression()), !dbg !120
  %4 = and i64 %2, 2, !dbg !121
  %and = and i64 %alloc, 2, !dbg !121
  %5 = xor i64 %and, -1, !dbg !123
  %6 = xor i64 %size, -1, !dbg !123
  %7 = and i64 %4, %0, !dbg !123
  %8 = and i64 %0, %5, !dbg !123
  %9 = and i64 %4, %6, !dbg !123
  %10 = or i64 %9, %8, !dbg !123
  %11 = or i64 %10, %7, !dbg !123
  %12 = icmp eq i64 %0, 0, !dbg !123
  %13 = select i1 %12, i32 %3, i32 %1, !dbg !123
  %14 = or i64 %and, %size, !dbg !123
  call void @llvm.dbg.value(metadata i64 %14, metadata !117, metadata !DIExpression()), !dbg !120
  %15 = and i64 %2, 1, !dbg !124
  %and1 = and i64 %alloc, 1, !dbg !124
  call void @llvm.dbg.value(metadata i64 %14, metadata !117, metadata !DIExpression(DW_OP_constu, 1, DW_OP_or, DW_OP_stack_value)), !dbg !120
  %16 = xor i64 %14, -1, !dbg !126
  %17 = xor i64 %and1, -1, !dbg !126
  %18 = and i64 %0, %15, !dbg !126
  %19 = and i64 %15, %16, !dbg !126
  %20 = and i64 %11, %17, !dbg !126
  %21 = or i64 %20, %19, !dbg !126
  %22 = or i64 %21, %18, !dbg !126
  %23 = icmp eq i64 %15, 0, !dbg !126
  %24 = select i1 %23, i32 %13, i32 %3, !dbg !126
  %25 = or i64 %14, %and1, !dbg !126
  call void @llvm.dbg.value(metadata i64 %25, metadata !117, metadata !DIExpression()), !dbg !120
  store i64 %22, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !127
  store i32 %24, i32* @__msan_retval_origin_tls, align 4, !dbg !127
  ret i64 %25, !dbg !127
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @extend_heap(i64 %size) unnamed_addr #0 !dbg !128 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !136
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !136
  call void @llvm.dbg.value(metadata i64 %size, metadata !132, metadata !DIExpression()), !dbg !136
  %2 = load %struct.block*, %struct.block** @heap_epi, align 8, !dbg !137, !tbaa !101
  %_msld = load i64, i64* inttoptr (i64 xor (i64 ptrtoint (%struct.block** @heap_epi to i64), i64 87960930222080) to i64*), align 8, !dbg !138
  %3 = load i32, i32* inttoptr (i64 add (i64 xor (i64 ptrtoint (%struct.block** @heap_epi to i64), i64 87960930222080), i64 17592186044416) to i32*), align 8, !dbg !138
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !138
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !138
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !138
  %call = call fastcc i64 @get_footer(%struct.block* %2), !dbg !138
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !139
  %4 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !139
  call void @llvm.dbg.value(metadata i64 %call, metadata !134, metadata !DIExpression()), !dbg !139
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !140
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !140
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !140
  %call1 = call fastcc i64 @round_up(i64 %size), !dbg !140
  %_msret12 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !136
  %5 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !136
  call void @llvm.dbg.value(metadata i64 %call1, metadata !132, metadata !DIExpression()), !dbg !136
  store i64 %_msret12, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !141
  store i32 %5, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !141
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !141
  %call2 = call i8* @mem_sbrk(i64 %call1) #4, !dbg !141
  %_msret13 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !143
  %6 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !143
  call void @llvm.dbg.value(metadata i8* %call2, metadata !133, metadata !DIExpression()), !dbg !143
  %7 = ptrtoint i8* %call2 to i64, !dbg !144
  %.demorgan = or i64 %_msret13, %7, !dbg !144
  %8 = icmp eq i64 %.demorgan, -1, !dbg !144
  %9 = icmp ne i64 %_msret13, 0, !dbg !144
  %_msprop_icmp = and i1 %9, %8, !dbg !144
  br i1 %_msprop_icmp, label %10, label %11, !dbg !145, !prof !84

; <label>:10:                                     ; preds = %entry
  store i32 %6, i32* @__msan_origin_tls, align 4, !dbg !145
  call void @__msan_warning_noreturn() #4, !dbg !145
  call void asm sideeffect "", ""() #4, !dbg !145
  unreachable, !dbg !145

; <label>:11:                                     ; preds = %entry
  %cmp = icmp eq i8* %call2, inttoptr (i64 -1 to i8*), !dbg !144
  br i1 %cmp, label %return, label %if.end, !dbg !145

if.end:                                           ; preds = %11
  store i64 %_msret13, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !146
  store i32 %6, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !146
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !146
  %call3 = call fastcc %struct.block* @payload_to_header(i8* %call2), !dbg !146
  %_msret14 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !147
  %12 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !147
  call void @llvm.dbg.value(metadata %struct.block* %call3, metadata !135, metadata !DIExpression()), !dbg !147
  store i64 %_msret14, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !148
  store i32 %12, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !148
  store i64 %_msret12, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !148
  store i32 %5, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !148
  store i64 %_msret, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !148
  store i32 %4, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !148
  call fastcc void @write_block_foot(%struct.block* nonnull %call3, i64 %call1, i64 %call), !dbg !148
  store i64 %_msret14, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !149
  store i32 %12, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !149
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !149
  %call4 = call fastcc %struct.block* @find_next(%struct.block* nonnull %call3), !dbg !149
  %_msret15 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !150
  %13 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !150
  store i64 %_msret15, i64* inttoptr (i64 xor (i64 ptrtoint (%struct.block** @heap_epi to i64), i64 87960930222080) to i64*), align 8, !dbg !150
  %_mscmp19 = icmp ne i64 %_msret15, 0, !dbg !150
  br i1 %_mscmp19, label %14, label %19, !dbg !150, !prof !84

; <label>:14:                                     ; preds = %if.end
  %15 = call i32 @__msan_chain_origin(i32 %13) #4, !dbg !150
  %16 = zext i32 %15 to i64, !dbg !150
  %17 = shl nuw i64 %16, 32, !dbg !150
  %18 = or i64 %17, %16, !dbg !150
  store i64 %18, i64* inttoptr (i64 add (i64 xor (i64 ptrtoint (%struct.block** @heap_epi to i64), i64 87960930222080), i64 17592186044416) to i64*), align 8, !dbg !150
  br label %19, !dbg !150

; <label>:19:                                     ; preds = %if.end, %14
  store %struct.block* %call4, %struct.block** @heap_epi, align 8, !dbg !150, !tbaa !101
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !151
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !151
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !151
  %call5 = call fastcc i64 @pack_foot(i64 0, i64 1), !dbg !151
  %_msret16 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !152
  %20 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !152
  %header = getelementptr inbounds %struct.block, %struct.block* %call4, i64 0, i32 0, !dbg !152
  br i1 %_mscmp19, label %21, label %22, !dbg !153, !prof !84

; <label>:21:                                     ; preds = %19
  store i32 %13, i32* @__msan_origin_tls, align 4, !dbg !153
  call void @__msan_warning_noreturn() #4, !dbg !153
  call void asm sideeffect "", ""() #4, !dbg !153
  unreachable, !dbg !153

; <label>:22:                                     ; preds = %19
  %23 = ptrtoint %struct.block* %call4 to i64, !dbg !153
  %24 = xor i64 %23, 87960930222080, !dbg !153
  %25 = inttoptr i64 %24 to i64*, !dbg !153
  store i64 %_msret16, i64* %25, align 8, !dbg !153
  %_mscmp20 = icmp eq i64 %_msret16, 0, !dbg !153
  br i1 %_mscmp20, label %33, label %26, !dbg !153, !prof !92

; <label>:26:                                     ; preds = %22
  %27 = add i64 %24, 17592186044416, !dbg !153
  %28 = call i32 @__msan_chain_origin(i32 %20) #4, !dbg !153
  %29 = zext i32 %28 to i64, !dbg !153
  %30 = shl nuw i64 %29, 32, !dbg !153
  %31 = or i64 %30, %29, !dbg !153
  %32 = inttoptr i64 %27 to i64*, !dbg !153
  store i64 %31, i64* %32, align 8, !dbg !153
  br label %33, !dbg !153

; <label>:33:                                     ; preds = %22, %26
  store i64 %call5, i64* %header, align 8, !dbg !153, !tbaa !154
  store i64 %_msret14, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !156
  store i32 %12, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !156
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !156
  %call6 = call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %call3), !dbg !156
  %_msret17 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !147
  %34 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !147
  call void @llvm.dbg.value(metadata %struct.block* %call6, metadata !135, metadata !DIExpression()), !dbg !147
  br label %return, !dbg !157

return:                                           ; preds = %11, %33
  %_msphi_s = phi i64 [ %_msret17, %33 ], [ 0, %11 ], !dbg !158
  %_msphi_o = phi i32 [ %34, %33 ], [ 0, %11 ], !dbg !158
  %retval.0 = phi %struct.block* [ %call6, %33 ], [ null, %11 ], !dbg !158
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !159
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !159
  ret %struct.block* %retval.0, !dbg !159
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local i8* @mm_malloc(i64 %size) local_unnamed_addr #0 !dbg !160 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !170
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !170
  call void @llvm.dbg.value(metadata i64 %size, metadata !164, metadata !DIExpression()), !dbg !170
  call void @llvm.dbg.value(metadata i8* null, metadata !168, metadata !DIExpression()), !dbg !171
  %2 = load %struct.block*, %struct.block** @heap_start, align 8, !dbg !172, !tbaa !101
  %_msld = load i64, i64* inttoptr (i64 xor (i64 ptrtoint (%struct.block** @heap_start to i64), i64 87960930222080) to i64*), align 8, !dbg !174
  %3 = ptrtoint %struct.block* %2 to i64, !dbg !174
  %4 = xor i64 %_msld, -1, !dbg !174
  %5 = and i64 %4, %3, !dbg !174
  %6 = icmp eq i64 %5, 0, !dbg !174
  %7 = icmp ne i64 %_msld, 0, !dbg !174
  %_msprop_icmp = and i1 %7, %6, !dbg !174
  br i1 %_msprop_icmp, label %8, label %10, !dbg !175, !prof !84

; <label>:8:                                      ; preds = %entry
  %9 = load i32, i32* inttoptr (i64 add (i64 xor (i64 ptrtoint (%struct.block** @heap_start to i64), i64 87960930222080), i64 17592186044416) to i32*), align 8, !dbg !174
  store i32 %9, i32* @__msan_origin_tls, align 4, !dbg !175
  call void @__msan_warning_noreturn() #4, !dbg !175
  call void asm sideeffect "", ""() #4, !dbg !175
  unreachable, !dbg !175

; <label>:10:                                     ; preds = %entry
  %cmp = icmp eq %struct.block* %2, null, !dbg !174
  br i1 %cmp, label %if.then, label %if.end, !dbg !175

if.then:                                          ; preds = %10
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !176
  %call = call zeroext i1 @mm_init(), !dbg !176
  br label %if.end, !dbg !178

if.end:                                           ; preds = %if.then, %10
  %11 = xor i64 %0, -1, !dbg !179
  %12 = and i64 %11, %size, !dbg !179
  %13 = icmp eq i64 %12, 0, !dbg !179
  %14 = icmp ne i64 %0, 0, !dbg !179
  %_msprop_icmp31 = and i1 %14, %13, !dbg !179
  br i1 %_msprop_icmp31, label %15, label %16, !dbg !181, !prof !84

; <label>:15:                                     ; preds = %if.end
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !181
  call void @__msan_warning_noreturn() #4, !dbg !181
  call void asm sideeffect "", ""() #4, !dbg !181
  unreachable, !dbg !181

; <label>:16:                                     ; preds = %if.end
  %cmp1 = icmp eq i64 %size, 0, !dbg !179
  br i1 %cmp1, label %return, label %if.end3, !dbg !181

if.end3:                                          ; preds = %16
  %17 = icmp ult i64 %12, 17, !dbg !182
  %18 = or i64 %0, %size, !dbg !182
  %19 = icmp ult i64 %18, 17, !dbg !182
  %20 = xor i1 %17, %19, !dbg !182
  br i1 %20, label %21, label %22, !dbg !184, !prof !84

; <label>:21:                                     ; preds = %if.end3
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !184
  call void @__msan_warning_noreturn() #4, !dbg !184
  call void asm sideeffect "", ""() #4, !dbg !184
  unreachable, !dbg !184

; <label>:22:                                     ; preds = %if.end3
  %cmp4 = icmp ult i64 %size, 17, !dbg !182
  br i1 %cmp4, label %if.end7, label %if.else, !dbg !184

if.else:                                          ; preds = %22
  %add = add i64 %size, 8, !dbg !185
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !186
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !186
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !186
  %call6 = call fastcc i64 @round_up(i64 %add), !dbg !186
  %_msret44 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !187
  %23 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !187
  call void @llvm.dbg.value(metadata i64 %call6, metadata !165, metadata !DIExpression()), !dbg !187
  br label %if.end7

if.end7:                                          ; preds = %22, %if.else
  %_msphi_s32 = phi i64 [ %_msret44, %if.else ], [ 0, %22 ], !dbg !188
  %_msphi_o33 = phi i32 [ %23, %if.else ], [ 0, %22 ], !dbg !188
  %asize.0 = phi i64 [ %call6, %if.else ], [ 32, %22 ], !dbg !188
  call void @llvm.dbg.value(metadata i64 %asize.0, metadata !165, metadata !DIExpression()), !dbg !187
  store i64 %_msphi_s32, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !189
  store i32 %_msphi_o33, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !189
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !189
  %call8 = call fastcc %struct.block* @find_fit(i64 %asize.0), !dbg !189
  %_msret34 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !191
  %24 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !191
  call void @llvm.dbg.value(metadata %struct.block* %call8, metadata !167, metadata !DIExpression()), !dbg !191
  %25 = ptrtoint %struct.block* %call8 to i64, !dbg !192
  %26 = xor i64 %_msret34, -1, !dbg !192
  %27 = and i64 %26, %25, !dbg !192
  %28 = icmp eq i64 %27, 0, !dbg !192
  %29 = icmp ne i64 %_msret34, 0, !dbg !192
  %_msprop_icmp35 = and i1 %29, %28, !dbg !192
  br i1 %_msprop_icmp35, label %30, label %31, !dbg !193, !prof !84

; <label>:30:                                     ; preds = %if.end7
  store i32 %24, i32* @__msan_origin_tls, align 4, !dbg !193
  call void @__msan_warning_noreturn() #4, !dbg !193
  call void asm sideeffect "", ""() #4, !dbg !193
  unreachable, !dbg !193

; <label>:31:                                     ; preds = %if.end7
  %cmp9 = icmp eq %struct.block* %call8, null, !dbg !192
  br i1 %cmp9, label %if.then10, label %if.end16, !dbg !193

if.then10:                                        ; preds = %31
  store i64 %_msphi_s32, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !194
  store i32 %_msphi_o33, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !194
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !194
  %call11 = call fastcc i64 @max(i64 %asize.0), !dbg !194
  %_msret36 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !196
  %32 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !196
  call void @llvm.dbg.value(metadata i64 %call11, metadata !166, metadata !DIExpression()), !dbg !196
  store i64 %_msret36, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !197
  store i32 %32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !197
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !197
  %call12 = call fastcc %struct.block* @extend_heap(i64 %call11), !dbg !197
  %_msret37 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !191
  %33 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !191
  call void @llvm.dbg.value(metadata %struct.block* %call12, metadata !167, metadata !DIExpression()), !dbg !191
  %34 = ptrtoint %struct.block* %call12 to i64, !dbg !198
  %35 = xor i64 %_msret37, -1, !dbg !198
  %36 = and i64 %35, %34, !dbg !198
  %37 = icmp eq i64 %36, 0, !dbg !198
  %38 = icmp ne i64 %_msret37, 0, !dbg !198
  %_msprop_icmp38 = and i1 %38, %37, !dbg !198
  br i1 %_msprop_icmp38, label %39, label %40, !dbg !200, !prof !84

; <label>:39:                                     ; preds = %if.then10
  store i32 %33, i32* @__msan_origin_tls, align 4, !dbg !200
  call void @__msan_warning_noreturn() #4, !dbg !200
  call void asm sideeffect "", ""() #4, !dbg !200
  unreachable, !dbg !200

; <label>:40:                                     ; preds = %if.then10
  %cmp13 = icmp eq %struct.block* %call12, null, !dbg !198
  br i1 %cmp13, label %return, label %if.end16, !dbg !200

if.end16:                                         ; preds = %40, %31
  %_msphi_s39 = phi i64 [ %_msret37, %40 ], [ %_msret34, %31 ], !dbg !201
  %_msphi_o40 = phi i32 [ %33, %40 ], [ %24, %31 ], !dbg !201
  %block.0 = phi %struct.block* [ %call12, %40 ], [ %call8, %31 ], !dbg !201
  call void @llvm.dbg.value(metadata %struct.block* %block.0, metadata !167, metadata !DIExpression()), !dbg !191
  store i64 %_msphi_s39, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !202
  store i32 %_msphi_o40, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !202
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !202
  %call17 = call fastcc i64 @get_size(%struct.block* nonnull %block.0), !dbg !202
  %_msret41 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !203
  %41 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !203
  call void @llvm.dbg.value(metadata i64 %call17, metadata !169, metadata !DIExpression()), !dbg !203
  store i64 %_msphi_s39, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !204
  store i32 %_msphi_o40, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !204
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !204
  %call18 = call fastcc i64 @get_footer(%struct.block* nonnull %block.0), !dbg !204
  %_msret42 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !205
  %42 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !205
  %43 = and i64 %_msret42, -2, !dbg !205
  %or = or i64 %call18, 1, !dbg !205
  store i64 %_msphi_s39, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !206
  store i32 %_msphi_o40, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !206
  store i64 %_msret41, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !206
  store i32 %41, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !206
  store i64 %43, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !206
  store i32 %42, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !206
  call fastcc void @write_block_foot(%struct.block* nonnull %block.0, i64 %call17, i64 %or), !dbg !206
  store i64 %_msphi_s39, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !207
  store i32 %_msphi_o40, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !207
  store i64 %_msphi_s32, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !207
  store i32 %_msphi_o33, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !207
  call fastcc void @split_block(%struct.block* nonnull %block.0, i64 %asize.0), !dbg !207
  store i64 %_msphi_s39, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !208
  store i32 %_msphi_o40, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !208
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !208
  %call19 = call fastcc i8* @header_to_payload(%struct.block* nonnull %block.0), !dbg !208
  %_msret43 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !171
  %44 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !171
  call void @llvm.dbg.value(metadata i8* %call19, metadata !168, metadata !DIExpression()), !dbg !171
  br label %return, !dbg !209

return:                                           ; preds = %40, %16, %if.end16
  %_msphi_s = phi i64 [ %_msret43, %if.end16 ], [ 0, %16 ], [ 0, %40 ], !dbg !210
  %_msphi_o = phi i32 [ %44, %if.end16 ], [ 0, %16 ], [ 0, %40 ], !dbg !210
  %retval.0 = phi i8* [ %call19, %if.end16 ], [ null, %16 ], [ null, %40 ], !dbg !210
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !211
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !211
  ret i8* %retval.0, !dbg !211
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @round_up(i64 %size) unnamed_addr #0 !dbg !212 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !218
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !218
  call void @llvm.dbg.value(metadata i64 %size, metadata !216, metadata !DIExpression()), !dbg !218
  call void @llvm.dbg.value(metadata i64 16, metadata !217, metadata !DIExpression()), !dbg !219
  %add = add i64 %size, 15, !dbg !220
  %2 = and i64 %0, -16, !dbg !221
  %div = and i64 %add, -16, !dbg !221
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !222
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !222
  ret i64 %div, !dbg !222
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @find_fit(i64 %asize) unnamed_addr #0 !dbg !223 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !229
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !229
  call void @llvm.dbg.value(metadata i64 %asize, metadata !225, metadata !DIExpression()), !dbg !229
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !226, metadata !DIExpression()), !dbg !230
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !231
  %call = call fastcc i64 @search_seg_list(i64 %asize), !dbg !231
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !232
  %2 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !232
  call void @llvm.dbg.value(metadata i64 %call, metadata !227, metadata !DIExpression()), !dbg !232
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !226, metadata !DIExpression()), !dbg !230
  %3 = xor i64 %_msret, -1, !dbg !233
  %4 = and i64 %call, %3, !dbg !233
  %5 = icmp ult i64 %4, 14, !dbg !233
  %6 = or i64 %_msret, %call, !dbg !233
  %7 = icmp ult i64 %6, 14, !dbg !233
  %8 = xor i1 %5, %7, !dbg !233
  br i1 %8, label %9, label %10, !dbg !235, !prof !84

; <label>:9:                                      ; preds = %entry
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !235
  call void @__msan_warning_noreturn() #4, !dbg !235
  call void asm sideeffect "", ""() #4, !dbg !235
  unreachable, !dbg !235

; <label>:10:                                     ; preds = %entry
  %cmp11 = icmp ult i64 %call, 14, !dbg !233
  br i1 %cmp11, label %for.body.preheader, label %return, !dbg !235

for.body.preheader:                               ; preds = %10
  %11 = icmp eq i64 %_msret, 0
  br label %for.body, !dbg !236

for.cond:                                         ; preds = %34
  call void @llvm.dbg.value(metadata i64 %inc, metadata !227, metadata !DIExpression()), !dbg !232
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !226, metadata !DIExpression()), !dbg !230
  %12 = and i64 %inc, %3, !dbg !233
  %13 = icmp ult i64 %12, 14, !dbg !233
  %14 = icmp ult i64 %inc, 14, !dbg !233
  %15 = xor i1 %13, %14, !dbg !233
  br i1 %15, label %16, label %17, !dbg !235, !prof !84

; <label>:16:                                     ; preds = %for.cond
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !235
  call void @__msan_warning_noreturn() #4, !dbg !235
  call void asm sideeffect "", ""() #4, !dbg !235
  unreachable, !dbg !235

; <label>:17:                                     ; preds = %for.cond
  br i1 %14, label %for.body, label %return.loopexit, !dbg !235, !llvm.loop !238

for.body:                                         ; preds = %for.body.preheader, %17
  %i.012 = phi i64 [ %inc, %17 ], [ %call, %for.body.preheader ]
  call void @llvm.dbg.value(metadata i64 %i.012, metadata !227, metadata !DIExpression()), !dbg !232
  %arrayidx = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %i.012, !dbg !236
  br i1 %11, label %19, label %18, !dbg !236, !prof !92

; <label>:18:                                     ; preds = %for.body
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !236
  call void @__msan_warning_noreturn() #4, !dbg !236
  call void asm sideeffect "", ""() #4, !dbg !236
  unreachable, !dbg !236

; <label>:19:                                     ; preds = %for.body
  %20 = load %struct.block*, %struct.block** %arrayidx, align 8, !dbg !236, !tbaa !101
  %21 = ptrtoint %struct.block** %arrayidx to i64, !dbg !240
  %22 = xor i64 %21, 87960930222080, !dbg !240
  %23 = inttoptr i64 %22 to i64*, !dbg !240
  %24 = add i64 %22, 17592186044416, !dbg !240
  %25 = inttoptr i64 %24 to i32*, !dbg !240
  %_msld = load i64, i64* %23, align 8, !dbg !240
  %26 = load i32, i32* %25, align 8, !dbg !240
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !240
  store i32 %26, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !240
  store i64 %0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !240
  store i32 %1, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !240
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !240
  %call1 = call fastcc %struct.block* @best_fit(%struct.block* %20, i64 %asize), !dbg !240
  %_msret14 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !230
  %27 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !230
  call void @llvm.dbg.value(metadata %struct.block* %call1, metadata !226, metadata !DIExpression()), !dbg !230
  %28 = ptrtoint %struct.block* %call1 to i64, !dbg !241
  %29 = xor i64 %_msret14, -1, !dbg !241
  %30 = and i64 %29, %28, !dbg !241
  %31 = icmp eq i64 %30, 0, !dbg !241
  %32 = icmp ne i64 %_msret14, 0, !dbg !241
  %_msprop_icmp = and i1 %32, %31, !dbg !241
  %inc = add nuw nsw i64 %i.012, 1, !dbg !243
  call void @llvm.dbg.value(metadata i64 %inc, metadata !227, metadata !DIExpression()), !dbg !232
  br i1 %_msprop_icmp, label %33, label %34, !dbg !244, !prof !84

; <label>:33:                                     ; preds = %19
  store i32 %27, i32* @__msan_origin_tls, align 4, !dbg !244
  call void @__msan_warning_noreturn() #4, !dbg !244
  call void asm sideeffect "", ""() #4, !dbg !244
  unreachable, !dbg !244

; <label>:34:                                     ; preds = %19
  %cmp2 = icmp eq %struct.block* %call1, null, !dbg !241
  br i1 %cmp2, label %for.cond, label %return.loopexit, !dbg !244

return.loopexit:                                  ; preds = %17, %34
  %_msphi_s15.ph = phi i64 [ %_msret14, %34 ], [ 0, %17 ]
  %_msphi_o16.ph = phi i32 [ %27, %34 ], [ 0, %17 ]
  %retval.0.ph = phi %struct.block* [ %call1, %34 ], [ null, %17 ]
  br label %return, !dbg !245

return:                                           ; preds = %return.loopexit, %10
  %_msphi_s15 = phi i64 [ 0, %10 ], [ %_msphi_s15.ph, %return.loopexit ], !dbg !246
  %_msphi_o16 = phi i32 [ 0, %10 ], [ %_msphi_o16.ph, %return.loopexit ], !dbg !246
  %retval.0 = phi %struct.block* [ null, %10 ], [ %retval.0.ph, %return.loopexit ], !dbg !246
  store i64 %_msphi_s15, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !245
  store i32 %_msphi_o16, i32* @__msan_retval_origin_tls, align 4, !dbg !245
  ret %struct.block* %retval.0, !dbg !245
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @max(i64 %x) unnamed_addr #0 !dbg !248 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !252
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !252
  call void @llvm.dbg.value(metadata i64 %x, metadata !250, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i64 1024, metadata !251, metadata !DIExpression()), !dbg !253
  %2 = xor i64 %0, -1, !dbg !254
  %3 = and i64 %2, %x, !dbg !254
  %4 = icmp ugt i64 %3, 1024, !dbg !254
  %5 = or i64 %0, %x, !dbg !254
  %6 = icmp ugt i64 %5, 1024, !dbg !254
  %7 = xor i1 %4, %6, !dbg !254
  %cmp = icmp ugt i64 %x, 1024, !dbg !254
  %8 = select i1 %cmp, i64 %0, i64 0, !dbg !255
  %9 = xor i64 %x, 1024, !dbg !255
  %10 = or i64 %0, %9, !dbg !255
  %_msprop_select = select i1 %7, i64 %10, i64 %8, !dbg !255
  %11 = or i1 %7, %cmp, !dbg !255
  %12 = select i1 %11, i32 %1, i32 0, !dbg !255
  %cond = select i1 %cmp, i64 %x, i64 1024, !dbg !255
  store i64 %_msprop_select, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !256
  store i32 %12, i32* @__msan_retval_origin_tls, align 4, !dbg !256
  ret i64 %cond, !dbg !256
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @get_size(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !257 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !262
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !261, metadata !DIExpression()), !dbg !262
  %_mscmp = icmp eq i64 %0, 0, !dbg !263
  br i1 %_mscmp, label %3, label %1, !dbg !263, !prof !92

; <label>:1:                                      ; preds = %entry
  %2 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !262
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !263
  call void @__msan_warning_noreturn() #4, !dbg !263
  call void asm sideeffect "", ""() #4, !dbg !263
  unreachable, !dbg !263

; <label>:3:                                      ; preds = %entry
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !263
  %4 = load i64, i64* %header, align 8, !dbg !263, !tbaa !154
  %5 = ptrtoint %struct.block* %block to i64, !dbg !264
  %6 = xor i64 %5, 87960930222080, !dbg !264
  %7 = inttoptr i64 %6 to i64*, !dbg !264
  %8 = add i64 %6, 17592186044416, !dbg !264
  %9 = inttoptr i64 %8 to i32*, !dbg !264
  %_msld = load i64, i64* %7, align 8, !dbg !264
  %10 = load i32, i32* %9, align 8, !dbg !264
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !264
  store i32 %10, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !264
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !264
  %call = call fastcc i64 @extract_size(i64 %4), !dbg !264
  ret i64 %call, !dbg !265
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @write_block_foot(%struct.block* %block, i64 %size, i64 %alloc) unnamed_addr #0 !dbg !266 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !274
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !274
  %2 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !274
  %3 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !274
  %4 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !274
  %5 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !274
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !270, metadata !DIExpression()), !dbg !274
  call void @llvm.dbg.value(metadata i64 %size, metadata !271, metadata !DIExpression()), !dbg !275
  call void @llvm.dbg.value(metadata i64 %alloc, metadata !272, metadata !DIExpression()), !dbg !276
  store i64 %4, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !277
  store i32 %5, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !277
  store i64 %2, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !277
  store i32 %3, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !277
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !277
  %call = call fastcc i64 @pack_foot(i64 %size, i64 %alloc), !dbg !277
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !278
  %6 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !278
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !278
  %_mscmp = icmp eq i64 %0, 0, !dbg !279
  br i1 %_mscmp, label %8, label %7, !dbg !279, !prof !92

; <label>:7:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !279
  call void @__msan_warning_noreturn() #4, !dbg !279
  call void asm sideeffect "", ""() #4, !dbg !279
  unreachable, !dbg !279

; <label>:8:                                      ; preds = %entry
  %9 = ptrtoint %struct.block* %block to i64, !dbg !279
  %10 = xor i64 %9, 87960930222080, !dbg !279
  %11 = inttoptr i64 %10 to i64*, !dbg !279
  store i64 %_msret, i64* %11, align 8, !dbg !279
  %_mscmp8 = icmp ne i64 %_msret, 0, !dbg !279
  br i1 %_mscmp8, label %12, label %19, !dbg !279, !prof !84

; <label>:12:                                     ; preds = %8
  %13 = add i64 %10, 17592186044416, !dbg !279
  %14 = call i32 @__msan_chain_origin(i32 %6) #4, !dbg !279
  %15 = zext i32 %14 to i64, !dbg !279
  %16 = shl nuw i64 %15, 32, !dbg !279
  %17 = or i64 %16, %15, !dbg !279
  %18 = inttoptr i64 %13 to i64*, !dbg !279
  store i64 %17, i64* %18, align 8, !dbg !279
  br label %19, !dbg !279

; <label>:19:                                     ; preds = %8, %12
  store i64 %call, i64* %header, align 8, !dbg !279, !tbaa !154
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !280
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !280
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !280
  %call1 = call fastcc i64* @header_to_footer(%struct.block* %block), !dbg !280
  %_msret6 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !281
  call void @llvm.dbg.value(metadata i64* %call1, metadata !273, metadata !DIExpression()), !dbg !281
  %_mscmp7 = icmp eq i64 %_msret6, 0, !dbg !282
  br i1 %_mscmp7, label %22, label %20, !dbg !282, !prof !92

; <label>:20:                                     ; preds = %19
  %21 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !281
  store i32 %21, i32* @__msan_origin_tls, align 4, !dbg !282
  call void @__msan_warning_noreturn() #4, !dbg !282
  call void asm sideeffect "", ""() #4, !dbg !282
  unreachable, !dbg !282

; <label>:22:                                     ; preds = %19
  %23 = ptrtoint i64* %call1 to i64, !dbg !282
  %24 = xor i64 %23, 87960930222080, !dbg !282
  %25 = inttoptr i64 %24 to i64*, !dbg !282
  store i64 %_msret, i64* %25, align 8, !dbg !282
  br i1 %_mscmp8, label %26, label %33, !dbg !282, !prof !84

; <label>:26:                                     ; preds = %22
  %27 = add i64 %24, 17592186044416, !dbg !282
  %28 = call i32 @__msan_chain_origin(i32 %6) #4, !dbg !282
  %29 = zext i32 %28 to i64, !dbg !282
  %30 = shl nuw i64 %29, 32, !dbg !282
  %31 = or i64 %30, %29, !dbg !282
  %32 = inttoptr i64 %27 to i64*, !dbg !282
  store i64 %31, i64* %32, align 8, !dbg !282
  br label %33, !dbg !282

; <label>:33:                                     ; preds = %22, %26
  store i64 %call, i64* %call1, align 8, !dbg !282, !tbaa !93
  ret void, !dbg !283
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @get_footer(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !284 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !289
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !288, metadata !DIExpression()), !dbg !289
  %_mscmp = icmp eq i64 %0, 0, !dbg !290
  br i1 %_mscmp, label %3, label %1, !dbg !290, !prof !92

; <label>:1:                                      ; preds = %entry
  %2 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !289
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !290
  call void @__msan_warning_noreturn() #4, !dbg !290
  call void asm sideeffect "", ""() #4, !dbg !290
  unreachable, !dbg !290

; <label>:3:                                      ; preds = %entry
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !290
  %4 = load i64, i64* %header, align 8, !dbg !290, !tbaa !154
  %5 = ptrtoint %struct.block* %block to i64, !dbg !291
  %6 = xor i64 %5, 87960930222080, !dbg !291
  %7 = inttoptr i64 %6 to i64*, !dbg !291
  %8 = add i64 %6, 17592186044416, !dbg !291
  %9 = inttoptr i64 %8 to i32*, !dbg !291
  %_msld = load i64, i64* %7, align 8, !dbg !291
  %10 = load i32, i32* %9, align 8, !dbg !291
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !291
  store i32 %10, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !291
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !291
  %call = call fastcc i64 @extract_footer(i64 %4), !dbg !291
  ret i64 %call, !dbg !292
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @split_block(%struct.block* %block, i64 %asize) unnamed_addr #0 !dbg !293 {
entry:
  %0 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !302
  %1 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !302
  %2 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !302
  %3 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !302
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !297, metadata !DIExpression()), !dbg !302
  call void @llvm.dbg.value(metadata i64 %asize, metadata !298, metadata !DIExpression()), !dbg !303
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !304
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !304
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !305
  %4 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !305
  call void @llvm.dbg.value(metadata i64 %call, metadata !300, metadata !DIExpression()), !dbg !305
  %_msprop = or i64 %_msret, %0, !dbg !306
  %5 = icmp eq i64 %0, 0, !dbg !306
  %6 = select i1 %5, i32 %4, i32 %1, !dbg !306
  %sub = sub i64 %call, %asize, !dbg !306
  call void @llvm.dbg.value(metadata i64 %sub, metadata !301, metadata !DIExpression()), !dbg !307
  %7 = xor i64 %_msprop, -32, !dbg !308
  %8 = and i64 %sub, %7, !dbg !308
  %9 = icmp ugt i64 %8, 31, !dbg !308
  %10 = or i64 %_msprop, %sub, !dbg !308
  %11 = icmp ugt i64 %10, 31, !dbg !308
  %12 = xor i1 %9, %11, !dbg !308
  br i1 %12, label %13, label %14, !dbg !310, !prof !84

; <label>:13:                                     ; preds = %entry
  store i32 %6, i32* @__msan_origin_tls, align 4, !dbg !310
  call void @__msan_warning_noreturn() #4, !dbg !310
  call void asm sideeffect "", ""() #4, !dbg !310
  unreachable, !dbg !310

; <label>:14:                                     ; preds = %entry
  %cmp = icmp ugt i64 %sub, 31, !dbg !308
  br i1 %cmp, label %if.then, label %if.else, !dbg !310

if.then:                                          ; preds = %14
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !311
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !311
  call fastcc void @delete_seg_list(%struct.block* %block), !dbg !311
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !313
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !313
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !313
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !313
  %call1 = call fastcc i64 @pack_foot(i64 %asize, i64 3), !dbg !313
  %_msret21 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !314
  %15 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !314
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !314
  %_mscmp25 = icmp eq i64 %2, 0, !dbg !315
  br i1 %_mscmp25, label %17, label %16, !dbg !315, !prof !92

; <label>:16:                                     ; preds = %if.then
  store i32 %3, i32* @__msan_origin_tls, align 4, !dbg !315
  call void @__msan_warning_noreturn() #4, !dbg !315
  call void asm sideeffect "", ""() #4, !dbg !315
  unreachable, !dbg !315

; <label>:17:                                     ; preds = %if.then
  %18 = ptrtoint %struct.block* %block to i64, !dbg !315
  %19 = xor i64 %18, 87960930222080, !dbg !315
  %20 = inttoptr i64 %19 to i64*, !dbg !315
  store i64 %_msret21, i64* %20, align 8, !dbg !315
  %_mscmp29 = icmp eq i64 %_msret21, 0, !dbg !315
  br i1 %_mscmp29, label %28, label %21, !dbg !315, !prof !92

; <label>:21:                                     ; preds = %17
  %22 = add i64 %19, 17592186044416, !dbg !315
  %23 = call i32 @__msan_chain_origin(i32 %15) #4, !dbg !315
  %24 = zext i32 %23 to i64, !dbg !315
  %25 = shl nuw i64 %24, 32, !dbg !315
  %26 = or i64 %25, %24, !dbg !315
  %27 = inttoptr i64 %22 to i64*, !dbg !315
  store i64 %26, i64* %27, align 8, !dbg !315
  br label %28, !dbg !315

; <label>:28:                                     ; preds = %17, %21
  store i64 %call1, i64* %header, align 8, !dbg !315, !tbaa !154
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !316
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !316
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !316
  %call2 = call fastcc %struct.block* @find_next(%struct.block* %block), !dbg !316
  %_msret22 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !317
  %29 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !317
  call void @llvm.dbg.value(metadata %struct.block* %call2, metadata !299, metadata !DIExpression()), !dbg !317
  store i64 %_msret22, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !318
  store i32 %29, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !318
  store i64 %_msprop, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !318
  store i32 %6, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !318
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !318
  call fastcc void @write_block_foot(%struct.block* %call2, i64 %sub, i64 2), !dbg !318
  store i64 %_msret22, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !319
  store i32 %29, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !319
  store i64 %_msprop, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !319
  store i32 %6, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !319
  call fastcc void @add_seg_list(%struct.block* %call2, i64 %sub), !dbg !319
  br label %if.end, !dbg !320

if.else:                                          ; preds = %14
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !321
  store i32 %4, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !321
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !321
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !321
  %call3 = call fastcc i64 @pack_foot(i64 %call, i64 3), !dbg !321
  %_msret23 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !323
  %30 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !323
  %header4 = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !323
  %_mscmp26 = icmp eq i64 %2, 0, !dbg !324
  br i1 %_mscmp26, label %32, label %31, !dbg !324, !prof !92

; <label>:31:                                     ; preds = %if.else
  store i32 %3, i32* @__msan_origin_tls, align 4, !dbg !324
  call void @__msan_warning_noreturn() #4, !dbg !324
  call void asm sideeffect "", ""() #4, !dbg !324
  unreachable, !dbg !324

; <label>:32:                                     ; preds = %if.else
  %33 = ptrtoint %struct.block* %block to i64, !dbg !324
  %34 = xor i64 %33, 87960930222080, !dbg !324
  %35 = inttoptr i64 %34 to i64*, !dbg !324
  store i64 %_msret23, i64* %35, align 8, !dbg !324
  %_mscmp30 = icmp eq i64 %_msret23, 0, !dbg !324
  br i1 %_mscmp30, label %43, label %36, !dbg !324, !prof !92

; <label>:36:                                     ; preds = %32
  %37 = add i64 %34, 17592186044416, !dbg !324
  %38 = call i32 @__msan_chain_origin(i32 %30) #4, !dbg !324
  %39 = zext i32 %38 to i64, !dbg !324
  %40 = shl nuw i64 %39, 32, !dbg !324
  %41 = or i64 %40, %39, !dbg !324
  %42 = inttoptr i64 %37 to i64*, !dbg !324
  store i64 %41, i64* %42, align 8, !dbg !324
  br label %43, !dbg !324

; <label>:43:                                     ; preds = %32, %36
  store i64 %call3, i64* %header4, align 8, !dbg !324, !tbaa !154
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !325
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !325
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !325
  %call5 = call fastcc %struct.block* @find_next(%struct.block* %block), !dbg !325
  %_msret24 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !317
  call void @llvm.dbg.value(metadata %struct.block* %call5, metadata !299, metadata !DIExpression()), !dbg !317
  %header6 = getelementptr inbounds %struct.block, %struct.block* %call5, i64 0, i32 0, !dbg !326
  %_mscmp27 = icmp eq i64 %_msret24, 0, !dbg !326
  br i1 %_mscmp27, label %46, label %44, !dbg !326, !prof !92

; <label>:44:                                     ; preds = %43
  %45 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !317
  store i32 %45, i32* @__msan_origin_tls, align 4, !dbg !326
  call void @__msan_warning_noreturn() #4, !dbg !326
  call void asm sideeffect "", ""() #4, !dbg !326
  unreachable, !dbg !326

; <label>:46:                                     ; preds = %43
  %47 = load i64, i64* %header6, align 8, !dbg !326, !tbaa !154
  %48 = ptrtoint %struct.block* %call5 to i64, !dbg !327
  %49 = xor i64 %48, 87960930222080, !dbg !327
  %50 = inttoptr i64 %49 to i64*, !dbg !327
  %51 = add i64 %49, 17592186044416, !dbg !327
  %52 = inttoptr i64 %51 to i32*, !dbg !327
  %_msld = load i64, i64* %50, align 8, !dbg !327
  %53 = load i32, i32* %52, align 8, !dbg !327
  %54 = and i64 %_msld, -3, !dbg !327
  %or = or i64 %47, 2, !dbg !327
  br i1 false, label %55, label %56, !dbg !328, !prof !84

; <label>:55:                                     ; preds = %46
  unreachable, !dbg !328

; <label>:56:                                     ; preds = %46
  store i64 %54, i64* %50, align 8, !dbg !328
  %_mscmp31 = icmp eq i64 %54, 0, !dbg !328
  br i1 %_mscmp31, label %63, label %57, !dbg !328, !prof !92

; <label>:57:                                     ; preds = %56
  %58 = call i32 @__msan_chain_origin(i32 %53) #4, !dbg !328
  %59 = zext i32 %58 to i64, !dbg !328
  %60 = shl nuw i64 %59, 32, !dbg !328
  %61 = or i64 %60, %59, !dbg !328
  %62 = inttoptr i64 %51 to i64*, !dbg !328
  store i64 %61, i64* %62, align 8, !dbg !328
  br label %63, !dbg !328

; <label>:63:                                     ; preds = %56, %57
  store i64 %or, i64* %header6, align 8, !dbg !328, !tbaa !154
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !329
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !329
  call fastcc void @delete_seg_list(%struct.block* %block), !dbg !329
  br label %if.end

if.end:                                           ; preds = %63, %28
  ret void, !dbg !330
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull i8* @header_to_payload(%struct.block* readnone %block) unnamed_addr #0 !dbg !331 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !336
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !336
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !335, metadata !DIExpression()), !dbg !336
  %2 = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, !dbg !337
  %arraydecay = bitcast %union.anon* %2 to i8*, !dbg !338
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !339
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !339
  ret i8* %arraydecay, !dbg !339
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local void @mm_free(i8* %bp) local_unnamed_addr #0 !dbg !340 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !347
  call void @llvm.dbg.value(metadata i8* %bp, metadata !344, metadata !DIExpression()), !dbg !347
  %1 = ptrtoint i8* %bp to i64, !dbg !348
  %2 = xor i64 %0, -1, !dbg !348
  %3 = and i64 %2, %1, !dbg !348
  %4 = icmp eq i64 %3, 0, !dbg !348
  %5 = icmp ne i64 %0, 0, !dbg !348
  %_msprop_icmp = and i1 %5, %4, !dbg !348
  br i1 %_msprop_icmp, label %6, label %8, !dbg !350, !prof !84

; <label>:6:                                      ; preds = %entry
  %7 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !347
  store i32 %7, i32* @__msan_origin_tls, align 4, !dbg !350
  call void @__msan_warning_noreturn() #4, !dbg !350
  call void asm sideeffect "", ""() #4, !dbg !350
  unreachable, !dbg !350

; <label>:8:                                      ; preds = %entry
  %cmp = icmp eq i8* %bp, null, !dbg !348
  br i1 %cmp, label %return, label %if.end, !dbg !350

if.end:                                           ; preds = %8
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !351
  %call = call fastcc %struct.block* @payload_to_header(i8* nonnull %bp), !dbg !351
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !352
  %9 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !352
  call void @llvm.dbg.value(metadata %struct.block* %call, metadata !345, metadata !DIExpression()), !dbg !352
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !353
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !353
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !353
  %call1 = call fastcc i64 @get_size(%struct.block* nonnull %call), !dbg !353
  %_msret8 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !354
  %10 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !354
  call void @llvm.dbg.value(metadata i64 %call1, metadata !346, metadata !DIExpression()), !dbg !354
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !355
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !355
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !355
  %call2 = call fastcc i64 @get_footer(%struct.block* nonnull %call), !dbg !355
  %_msret9 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !356
  %11 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !356
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !356
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !356
  store i64 %_msret8, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !356
  store i32 %10, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !356
  store i64 %_msret9, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !356
  store i32 %11, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !356
  call fastcc void @write_block_foot(%struct.block* nonnull %call, i64 %call1, i64 %call2), !dbg !356
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !357
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !357
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !357
  %call3 = call fastcc %struct.block* @coalesce_block(%struct.block* nonnull %call), !dbg !357
  br label %return, !dbg !358

return:                                           ; preds = %8, %if.end
  ret void, !dbg !358
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull %struct.block* @payload_to_header(i8* readnone %bp) unnamed_addr #0 !dbg !359 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !364
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !364
  call void @llvm.dbg.value(metadata i8* %bp, metadata !363, metadata !DIExpression()), !dbg !364
  %add.ptr = getelementptr inbounds i8, i8* %bp, i64 -8, !dbg !365
  %2 = bitcast i8* %add.ptr to %struct.block*, !dbg !366
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !367
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !367
  ret %struct.block* %2, !dbg !367
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @coalesce_block(%struct.block* %block) unnamed_addr #0 !dbg !368 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !378
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !378
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !372, metadata !DIExpression()), !dbg !378
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !379
  %call = call fastcc %struct.block* @find_next(%struct.block* %block), !dbg !379
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !380
  %2 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !380
  call void @llvm.dbg.value(metadata %struct.block* %call, metadata !374, metadata !DIExpression()), !dbg !380
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !381
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !381
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !381
  %call1 = call fastcc i64 @get_footer(%struct.block* %block), !dbg !381
  %_msret78 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !382
  %3 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !382
  %4 = xor i64 %_msret78, -1, !dbg !382
  %5 = and i64 %call1, %4, !dbg !382
  %6 = icmp eq i64 %5, 0, !dbg !382
  %7 = icmp ne i64 %_msret78, 0, !dbg !382
  %_msprop_icmp = and i1 %7, %6, !dbg !382
  %tobool = icmp ne i64 %call1, 0, !dbg !382
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !383
  store i32 %2, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !383
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !383
  %call2 = call fastcc zeroext i1 @get_alloc(%struct.block* %call), !dbg !383
  %_msret79 = load i1, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !384
  %8 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !384
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !384
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !384
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !384
  %call4 = call fastcc i64 @get_size(%struct.block* %block), !dbg !384
  %_msret80 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !385
  %9 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !385
  call void @llvm.dbg.value(metadata i64 %call4, metadata !377, metadata !DIExpression()), !dbg !385
  %tobool.not = xor i1 %tobool, true, !dbg !386
  %call2.not = xor i1 %call2, true, !dbg !386
  %10 = and i1 %_msprop_icmp, %_msret79, !dbg !386
  %11 = and i1 %tobool, %_msret79, !dbg !386
  %12 = and i1 %_msprop_icmp, %call2, !dbg !386
  %13 = or i1 %12, %11, !dbg !386
  %14 = or i1 %10, %13, !dbg !386
  %15 = select i1 %_msret79, i32 %8, i32 %3, !dbg !386
  br i1 %14, label %16, label %17, !dbg !386, !prof !84

; <label>:16:                                     ; preds = %entry
  store i32 %15, i32* @__msan_origin_tls, align 4, !dbg !386
  call void @__msan_warning_noreturn() #4, !dbg !386
  call void asm sideeffect "", ""() #4, !dbg !386
  unreachable, !dbg !386

; <label>:17:                                     ; preds = %entry
  %brmerge = or i1 %tobool.not, %call2.not, !dbg !386
  br i1 %brmerge, label %if.else, label %if.then, !dbg !386

if.then:                                          ; preds = %17
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !388
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !388
  store i64 %_msret80, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !388
  store i32 %9, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !388
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !388
  call fastcc void @write_block_foot(%struct.block* %block, i64 %call4, i64 2), !dbg !388
  %header = getelementptr inbounds %struct.block, %struct.block* %call, i64 0, i32 0, !dbg !390
  %_mscmp98 = icmp eq i64 %_msret, 0, !dbg !390
  br i1 %_mscmp98, label %19, label %18, !dbg !390, !prof !92

; <label>:18:                                     ; preds = %if.then
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !390
  call void @__msan_warning_noreturn() #4, !dbg !390
  call void asm sideeffect "", ""() #4, !dbg !390
  unreachable, !dbg !390

; <label>:19:                                     ; preds = %if.then
  %20 = load i64, i64* %header, align 8, !dbg !390, !tbaa !154
  %21 = ptrtoint %struct.block* %call to i64, !dbg !391
  %22 = xor i64 %21, 87960930222080, !dbg !391
  %23 = inttoptr i64 %22 to i64*, !dbg !391
  %24 = add i64 %22, 17592186044416, !dbg !391
  %25 = inttoptr i64 %24 to i32*, !dbg !391
  %_msld92 = load i64, i64* %23, align 8, !dbg !391
  %26 = load i32, i32* %25, align 8, !dbg !391
  %27 = and i64 %_msld92, -3, !dbg !391
  %and = and i64 %20, -3, !dbg !391
  br i1 false, label %28, label %29, !dbg !392, !prof !84

; <label>:28:                                     ; preds = %19
  unreachable, !dbg !392

; <label>:29:                                     ; preds = %19
  store i64 %27, i64* %23, align 8, !dbg !392
  %_mscmp101 = icmp eq i64 %27, 0, !dbg !392
  br i1 %_mscmp101, label %36, label %30, !dbg !392, !prof !92

; <label>:30:                                     ; preds = %29
  %31 = call i32 @__msan_chain_origin(i32 %26) #4, !dbg !392
  %32 = zext i32 %31 to i64, !dbg !392
  %33 = shl nuw i64 %32, 32, !dbg !392
  %34 = or i64 %33, %32, !dbg !392
  %35 = inttoptr i64 %24 to i64*, !dbg !392
  store i64 %34, i64* %35, align 8, !dbg !392
  br label %36, !dbg !392

; <label>:36:                                     ; preds = %29, %30
  store i64 %and, i64* %header, align 8, !dbg !392, !tbaa !154
  br label %if.end36, !dbg !393

if.else:                                          ; preds = %17
  %37 = and i1 %_msret79, %tobool.not, !dbg !394
  br i1 %37, label %38, label %39, !dbg !394, !prof !84

; <label>:38:                                     ; preds = %if.else
  store i32 %15, i32* @__msan_origin_tls, align 4, !dbg !394
  call void @__msan_warning_noreturn() #4, !dbg !394
  call void asm sideeffect "", ""() #4, !dbg !394
  unreachable, !dbg !394

; <label>:39:                                     ; preds = %if.else
  %brmerge74 = or i1 %tobool, %call2.not, !dbg !394
  br i1 %brmerge74, label %if.else17, label %if.then11, !dbg !394

if.then11:                                        ; preds = %39
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !396
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !396
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !396
  %call12 = call fastcc %struct.block* @find_prev(%struct.block* %block), !dbg !396
  %_msret89 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !398
  %40 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !398
  call void @llvm.dbg.value(metadata %struct.block* %call12, metadata !373, metadata !DIExpression()), !dbg !398
  store i64 %_msret89, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !399
  store i32 %40, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !399
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !399
  %call13 = call fastcc i64 @get_size(%struct.block* %call12), !dbg !399
  %_msret90 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !400
  %41 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !400
  %_msprop91 = or i64 %_msret90, %_msret80, !dbg !400
  %42 = icmp eq i64 %_msret80, 0, !dbg !400
  %43 = select i1 %42, i32 %41, i32 %9, !dbg !400
  %add = add i64 %call13, %call4, !dbg !400
  call void @llvm.dbg.value(metadata i64 %add, metadata !377, metadata !DIExpression()), !dbg !385
  store i64 %_msret89, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !401
  store i32 %40, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !401
  call fastcc void @delete_seg_list(%struct.block* %call12), !dbg !401
  store i64 %_msret89, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !402
  store i32 %40, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !402
  store i64 %_msprop91, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !402
  store i32 %43, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !402
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !402
  call fastcc void @write_block_foot(%struct.block* %call12, i64 %add, i64 2), !dbg !402
  %header14 = getelementptr inbounds %struct.block, %struct.block* %call, i64 0, i32 0, !dbg !403
  %_mscmp96 = icmp eq i64 %_msret, 0, !dbg !403
  br i1 %_mscmp96, label %45, label %44, !dbg !403, !prof !92

; <label>:44:                                     ; preds = %if.then11
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !403
  call void @__msan_warning_noreturn() #4, !dbg !403
  call void asm sideeffect "", ""() #4, !dbg !403
  unreachable, !dbg !403

; <label>:45:                                     ; preds = %if.then11
  %46 = load i64, i64* %header14, align 8, !dbg !403, !tbaa !154
  %47 = ptrtoint %struct.block* %call to i64, !dbg !404
  %48 = xor i64 %47, 87960930222080, !dbg !404
  %49 = inttoptr i64 %48 to i64*, !dbg !404
  %50 = add i64 %48, 17592186044416, !dbg !404
  %51 = inttoptr i64 %50 to i32*, !dbg !404
  %_msld = load i64, i64* %49, align 8, !dbg !404
  %52 = load i32, i32* %51, align 8, !dbg !404
  %53 = and i64 %_msld, -3, !dbg !404
  %and15 = and i64 %46, -3, !dbg !404
  br i1 false, label %54, label %55, !dbg !405, !prof !84

; <label>:54:                                     ; preds = %45
  unreachable, !dbg !405

; <label>:55:                                     ; preds = %45
  store i64 %53, i64* %49, align 8, !dbg !405
  %_mscmp100 = icmp eq i64 %53, 0, !dbg !405
  br i1 %_mscmp100, label %62, label %56, !dbg !405, !prof !92

; <label>:56:                                     ; preds = %55
  %57 = call i32 @__msan_chain_origin(i32 %52) #4, !dbg !405
  %58 = zext i32 %57 to i64, !dbg !405
  %59 = shl nuw i64 %58, 32, !dbg !405
  %60 = or i64 %59, %58, !dbg !405
  %61 = inttoptr i64 %50 to i64*, !dbg !405
  store i64 %60, i64* %61, align 8, !dbg !405
  br label %62, !dbg !405

; <label>:62:                                     ; preds = %55, %56
  store i64 %and15, i64* %header14, align 8, !dbg !405, !tbaa !154
  call void @llvm.dbg.value(metadata %struct.block* %call12, metadata !372, metadata !DIExpression()), !dbg !378
  br label %if.end36, !dbg !406

if.else17:                                        ; preds = %39
  %63 = and i1 %_msprop_icmp, %call2.not, !dbg !407
  br i1 %63, label %64, label %66, !dbg !407, !prof !84

; <label>:64:                                     ; preds = %if.else17
  %65 = select i1 %_msprop_icmp, i32 %3, i32 %8, !dbg !407
  store i32 %65, i32* @__msan_origin_tls, align 4, !dbg !407
  call void @__msan_warning_noreturn() #4, !dbg !407
  call void asm sideeffect "", ""() #4, !dbg !407
  unreachable, !dbg !407

; <label>:66:                                     ; preds = %if.else17
  %brmerge76 = or i1 %call2, %tobool.not, !dbg !407
  br i1 %brmerge76, label %if.else24, label %if.then21, !dbg !407

if.then21:                                        ; preds = %66
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !409
  store i32 %2, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !409
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !409
  %call22 = call fastcc i64 @get_size(%struct.block* %call), !dbg !409
  %_msret87 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !411
  %67 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !411
  %_msprop88 = or i64 %_msret87, %_msret80, !dbg !411
  %68 = icmp eq i64 %_msret80, 0, !dbg !411
  %69 = select i1 %68, i32 %67, i32 %9, !dbg !411
  %add23 = add i64 %call22, %call4, !dbg !411
  call void @llvm.dbg.value(metadata i64 %add23, metadata !377, metadata !DIExpression()), !dbg !385
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !412
  store i32 %2, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !412
  call fastcc void @delete_seg_list(%struct.block* %call), !dbg !412
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !413
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !413
  store i64 %_msprop88, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !413
  store i32 %69, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !413
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !413
  call fastcc void @write_block_foot(%struct.block* %block, i64 %add23, i64 2), !dbg !413
  br label %if.end36, !dbg !414

if.else24:                                        ; preds = %66
  br i1 false, label %70, label %71, !dbg !415, !prof !84

; <label>:70:                                     ; preds = %if.else24
  unreachable, !dbg !415

; <label>:71:                                     ; preds = %if.else24
  %brmerge77 = or i1 %tobool, %call2, !dbg !415
  br i1 %brmerge77, label %if.end36, label %if.then28, !dbg !415

if.then28:                                        ; preds = %71
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !417
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !417
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !417
  %call29 = call fastcc %struct.block* @find_prev(%struct.block* %block), !dbg !417
  %_msret83 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !398
  %72 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !398
  call void @llvm.dbg.value(metadata %struct.block* %call29, metadata !373, metadata !DIExpression()), !dbg !398
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !419
  store i32 %2, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !419
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !419
  %call30 = call fastcc i64 @get_size(%struct.block* %call), !dbg !419
  %_msret84 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !420
  %73 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !420
  %_msprop = or i64 %_msret84, %_msret80, !dbg !420
  %74 = icmp eq i64 %_msret80, 0, !dbg !420
  %75 = select i1 %74, i32 %73, i32 %9, !dbg !420
  %add31 = add i64 %call30, %call4, !dbg !420
  store i64 %_msret83, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !421
  store i32 %72, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !421
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !421
  %call32 = call fastcc i64 @get_size(%struct.block* %call29), !dbg !421
  %_msret85 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !422
  %76 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !422
  %_msprop86 = or i64 %_msprop, %_msret85, !dbg !422
  %77 = icmp eq i64 %_msret85, 0, !dbg !422
  %78 = select i1 %77, i32 %75, i32 %76, !dbg !422
  %add33 = add i64 %add31, %call32, !dbg !422
  call void @llvm.dbg.value(metadata i64 %add33, metadata !377, metadata !DIExpression()), !dbg !385
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !423
  store i32 %2, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !423
  call fastcc void @delete_seg_list(%struct.block* %call), !dbg !423
  store i64 %_msret83, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !424
  store i32 %72, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !424
  call fastcc void @delete_seg_list(%struct.block* %call29), !dbg !424
  store i64 %_msret83, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !425
  store i32 %72, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !425
  store i64 %_msprop86, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !425
  store i32 %78, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !425
  store i64 0, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !425
  call fastcc void @write_block_foot(%struct.block* %call29, i64 %add33, i64 2), !dbg !425
  call void @llvm.dbg.value(metadata %struct.block* %call29, metadata !372, metadata !DIExpression()), !dbg !378
  br label %if.end36, !dbg !426

if.end36:                                         ; preds = %71, %62, %if.then28, %if.then21, %36
  %_msphi_s = phi i64 [ %0, %36 ], [ %0, %71 ], [ %_msret83, %if.then28 ], [ %0, %if.then21 ], [ %_msret89, %62 ]
  %_msphi_o = phi i32 [ %1, %36 ], [ %1, %71 ], [ %72, %if.then28 ], [ %1, %if.then21 ], [ %40, %62 ]
  %block.addr.0 = phi %struct.block* [ %block, %36 ], [ %block, %71 ], [ %call29, %if.then28 ], [ %block, %if.then21 ], [ %call12, %62 ]
  %_msphi_s81 = phi i64 [ %_msret80, %36 ], [ %_msret80, %71 ], [ %_msprop86, %if.then28 ], [ %_msprop88, %if.then21 ], [ %_msprop91, %62 ], !dbg !427
  %_msphi_o82 = phi i32 [ %9, %36 ], [ %9, %71 ], [ %78, %if.then28 ], [ %69, %if.then21 ], [ %43, %62 ], !dbg !427
  %size.0 = phi i64 [ %call4, %36 ], [ %call4, %71 ], [ %add33, %if.then28 ], [ %add23, %if.then21 ], [ %add, %62 ], !dbg !427
  call void @llvm.dbg.value(metadata i64 %size.0, metadata !377, metadata !DIExpression()), !dbg !385
  call void @llvm.dbg.value(metadata %struct.block* %block.addr.0, metadata !372, metadata !DIExpression()), !dbg !378
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !428
  store i32 %_msphi_o, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !428
  store i64 %_msphi_s81, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !428
  store i32 %_msphi_o82, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !428
  call fastcc void @add_seg_list(%struct.block* %block.addr.0, i64 %size.0), !dbg !428
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !429
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !429
  ret %struct.block* %block.addr.0, !dbg !429
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local i8* @mm_realloc(i8* %ptr, i64 %size) local_unnamed_addr #0 !dbg !430 {
entry:
  %0 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !439
  %1 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !439
  %2 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !439
  %3 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !439
  call void @llvm.dbg.value(metadata i8* %ptr, metadata !434, metadata !DIExpression()), !dbg !439
  call void @llvm.dbg.value(metadata i64 %size, metadata !435, metadata !DIExpression()), !dbg !440
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !441
  %call = call fastcc %struct.block* @payload_to_header(i8* %ptr), !dbg !441
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !442
  %4 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !442
  call void @llvm.dbg.value(metadata %struct.block* %call, metadata !436, metadata !DIExpression()), !dbg !442
  %5 = xor i64 %0, -1, !dbg !443
  %6 = and i64 %5, %size, !dbg !443
  %7 = icmp eq i64 %6, 0, !dbg !443
  %8 = icmp ne i64 %0, 0, !dbg !443
  %_msprop_icmp = and i1 %8, %7, !dbg !443
  br i1 %_msprop_icmp, label %9, label %10, !dbg !445, !prof !84

; <label>:9:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !445
  call void @__msan_warning_noreturn() #4, !dbg !445
  call void asm sideeffect "", ""() #4, !dbg !445
  unreachable, !dbg !445

; <label>:10:                                     ; preds = %entry
  %cmp = icmp eq i64 %size, 0, !dbg !443
  br i1 %cmp, label %if.then, label %if.end, !dbg !445

if.then:                                          ; preds = %10
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !446
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !446
  call void @mm_free(i8* %ptr), !dbg !446
  br label %return, !dbg !448

if.end:                                           ; preds = %10
  %11 = ptrtoint i8* %ptr to i64, !dbg !449
  %12 = xor i64 %2, -1, !dbg !449
  %13 = and i64 %12, %11, !dbg !449
  %14 = icmp eq i64 %13, 0, !dbg !449
  %15 = icmp ne i64 %2, 0, !dbg !449
  %_msprop_icmp23 = and i1 %15, %14, !dbg !449
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !451
  store i32 %1, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !451
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !451
  %call3 = call i8* @mm_malloc(i64 %size), !dbg !451
  %_msret24 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !452
  %16 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !452
  br i1 %_msprop_icmp23, label %17, label %18, !dbg !452, !prof !84

; <label>:17:                                     ; preds = %if.end
  store i32 %3, i32* @__msan_origin_tls, align 4, !dbg !452
  call void @__msan_warning_noreturn() #4, !dbg !452
  call void asm sideeffect "", ""() #4, !dbg !452
  unreachable, !dbg !452

; <label>:18:                                     ; preds = %if.end
  %cmp1 = icmp eq i8* %ptr, null, !dbg !449
  br i1 %cmp1, label %return, label %if.end4, !dbg !452

if.end4:                                          ; preds = %18
  call void @llvm.dbg.value(metadata i8* %call3, metadata !438, metadata !DIExpression()), !dbg !453
  %19 = ptrtoint i8* %call3 to i64, !dbg !454
  %20 = xor i64 %_msret24, -1, !dbg !454
  %21 = and i64 %20, %19, !dbg !454
  %22 = icmp eq i64 %21, 0, !dbg !454
  %23 = icmp ne i64 %_msret24, 0, !dbg !454
  %_msprop_icmp25 = and i1 %23, %22, !dbg !454
  br i1 %_msprop_icmp25, label %24, label %25, !dbg !456, !prof !84

; <label>:24:                                     ; preds = %if.end4
  store i32 %16, i32* @__msan_origin_tls, align 4, !dbg !456
  call void @__msan_warning_noreturn() #4, !dbg !456
  call void asm sideeffect "", ""() #4, !dbg !456
  unreachable, !dbg !456

; <label>:25:                                     ; preds = %if.end4
  %cmp6 = icmp eq i8* %call3, null, !dbg !454
  br i1 %cmp6, label %return, label %if.end8, !dbg !456

if.end8:                                          ; preds = %25
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !457
  store i32 %4, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !457
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !457
  %call9 = call fastcc i64 @get_payload_size(%struct.block* nonnull %call), !dbg !457
  %_msret26 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !458
  %26 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !458
  call void @llvm.dbg.value(metadata i64 %call9, metadata !437, metadata !DIExpression()), !dbg !458
  %_msprop = or i64 %_msret26, %0, !dbg !459
  %27 = select i1 %8, i32 %1, i32 %26, !dbg !459
  %28 = icmp ne i64 %_msprop, 0, !dbg !459
  %cmp10 = icmp ugt i64 %call9, %size, !dbg !459
  %29 = select i1 %cmp10, i64 %0, i64 %_msret26, !dbg !461
  %30 = xor i64 %call9, %size, !dbg !461
  %31 = or i64 %_msprop, %30, !dbg !461
  %_msprop_select = select i1 %28, i64 %31, i64 %29, !dbg !461
  %32 = select i1 %cmp10, i32 %1, i32 %26, !dbg !461
  %33 = select i1 %28, i32 %27, i32 %32, !dbg !461
  %spec.select = select i1 %cmp10, i64 %size, i64 %call9, !dbg !461
  call void @llvm.dbg.value(metadata i64 %spec.select, metadata !437, metadata !DIExpression()), !dbg !458
  store i64 %_msret24, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !462
  store i32 %16, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !462
  store i64 %2, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !462
  store i32 %3, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !462
  store i64 %_msprop_select, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !462
  store i32 %33, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !462
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !462
  %call13 = call i8* @mem_memcpy(i8* nonnull %call3, i8* nonnull %ptr, i64 %spec.select) #4, !dbg !462
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !463
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !463
  call void @mm_free(i8* nonnull %ptr), !dbg !463
  br label %return, !dbg !464

return:                                           ; preds = %25, %18, %if.end8, %if.then
  %_msphi_s = phi i64 [ 0, %if.then ], [ %_msret24, %if.end8 ], [ %_msret24, %18 ], [ 0, %25 ], !dbg !451
  %_msphi_o = phi i32 [ 0, %if.then ], [ %16, %if.end8 ], [ %16, %18 ], [ 0, %25 ], !dbg !451
  %retval.0 = phi i8* [ null, %if.then ], [ %call3, %if.end8 ], [ %call3, %18 ], [ null, %25 ], !dbg !451
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !465
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !465
  ret i8* %retval.0, !dbg !465
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @get_payload_size(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !466 {
entry:
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !468, metadata !DIExpression()), !dbg !470
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !471
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !471
  call void @llvm.dbg.value(metadata i64 %call, metadata !469, metadata !DIExpression()), !dbg !472
  %sub = add i64 %call, -8, !dbg !473
  ret i64 %sub, !dbg !474
}

declare dso_local i8* @mem_memcpy(i8*, i8*, i64) local_unnamed_addr #1

; Function Attrs: noinline nounwind sanitize_memory uwtable
define dso_local i8* @mm_calloc(i64 %elements, i64 %size) local_unnamed_addr #0 !dbg !475 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !483
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !483
  %2 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !483
  %3 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !483
  call void @llvm.dbg.value(metadata i64 %elements, metadata !479, metadata !DIExpression()), !dbg !483
  call void @llvm.dbg.value(metadata i64 %size, metadata !480, metadata !DIExpression()), !dbg !484
  %_msprop = or i64 %2, %0, !dbg !485
  %4 = icmp ne i64 %0, 0, !dbg !485
  %5 = select i1 %4, i32 %1, i32 %3, !dbg !485
  %mul = mul i64 %size, %elements, !dbg !485
  call void @llvm.dbg.value(metadata i64 %mul, metadata !482, metadata !DIExpression()), !dbg !486
  %6 = xor i64 %0, -1, !dbg !487
  %7 = and i64 %6, %elements, !dbg !487
  %8 = icmp eq i64 %7, 0, !dbg !487
  %_msprop_icmp = and i1 %4, %8, !dbg !487
  br i1 %_msprop_icmp, label %9, label %10, !dbg !489, !prof !84

; <label>:9:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !489
  call void @__msan_warning_noreturn() #4, !dbg !489
  call void asm sideeffect "", ""() #4, !dbg !489
  unreachable, !dbg !489

; <label>:10:                                     ; preds = %entry
  %cmp = icmp eq i64 %elements, 0, !dbg !487
  br i1 %cmp, label %return, label %if.end, !dbg !489

if.end:                                           ; preds = %10
  br i1 %4, label %11, label %12, !dbg !490, !prof !84

; <label>:11:                                     ; preds = %if.end
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !490
  call void @__msan_warning_noreturn() #4, !dbg !490
  call void asm sideeffect "", ""() #4, !dbg !490
  unreachable, !dbg !490

; <label>:12:                                     ; preds = %if.end
  %div = udiv i64 %mul, %elements, !dbg !490
  %13 = xor i64 %div, %size, !dbg !492
  %14 = xor i64 %_msprop, -1, !dbg !492
  %15 = and i64 %13, %14, !dbg !492
  %16 = icmp eq i64 %15, 0, !dbg !492
  %17 = icmp ne i64 %_msprop, 0, !dbg !492
  %_msprop_icmp15 = and i1 %17, %16, !dbg !492
  br i1 %_msprop_icmp15, label %18, label %21, !dbg !493, !prof !84

; <label>:18:                                     ; preds = %12
  %19 = icmp eq i64 %2, 0, !dbg !492
  %20 = select i1 %19, i32 %5, i32 %3, !dbg !492
  store i32 %20, i32* @__msan_origin_tls, align 4, !dbg !493
  call void @__msan_warning_noreturn() #4, !dbg !493
  call void asm sideeffect "", ""() #4, !dbg !493
  unreachable, !dbg !493

; <label>:21:                                     ; preds = %12
  %cmp1 = icmp eq i64 %div, %size, !dbg !492
  br i1 %cmp1, label %if.end3, label %return, !dbg !493

if.end3:                                          ; preds = %21
  store i64 %_msprop, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !494
  store i32 %5, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !494
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !494
  %call = call i8* @mm_malloc(i64 %mul), !dbg !494
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !495
  %22 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !495
  call void @llvm.dbg.value(metadata i8* %call, metadata !481, metadata !DIExpression()), !dbg !495
  %23 = ptrtoint i8* %call to i64, !dbg !496
  %24 = xor i64 %_msret, -1, !dbg !496
  %25 = and i64 %24, %23, !dbg !496
  %26 = icmp eq i64 %25, 0, !dbg !496
  %27 = icmp ne i64 %_msret, 0, !dbg !496
  %_msprop_icmp16 = and i1 %27, %26, !dbg !496
  br i1 %_msprop_icmp16, label %28, label %29, !dbg !498, !prof !84

; <label>:28:                                     ; preds = %if.end3
  store i32 %22, i32* @__msan_origin_tls, align 4, !dbg !498
  call void @__msan_warning_noreturn() #4, !dbg !498
  call void asm sideeffect "", ""() #4, !dbg !498
  unreachable, !dbg !498

; <label>:29:                                     ; preds = %if.end3
  %cmp4 = icmp eq i8* %call, null, !dbg !496
  br i1 %cmp4, label %return, label %if.end6, !dbg !498

if.end6:                                          ; preds = %29
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !499
  store i32 %22, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !499
  store i32 0, i32* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i32*), align 8, !dbg !499
  store i64 %_msprop, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 16) to i64*), align 8, !dbg !499
  store i32 %5, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 16) to i32*), align 4, !dbg !499
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !499
  %call7 = call i8* @mem_memset(i8* nonnull %call, i32 0, i64 %mul) #4, !dbg !499
  br label %return, !dbg !500

return:                                           ; preds = %29, %21, %10, %if.end6
  %_msphi_s = phi i64 [ %_msret, %if.end6 ], [ 0, %10 ], [ 0, %21 ], [ 0, %29 ], !dbg !501
  %_msphi_o = phi i32 [ %22, %if.end6 ], [ 0, %10 ], [ 0, %21 ], [ 0, %29 ], !dbg !501
  %retval.0 = phi i8* [ %call, %if.end6 ], [ null, %10 ], [ null, %21 ], [ null, %29 ], !dbg !501
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !502
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !502
  ret i8* %retval.0, !dbg !502
}

declare dso_local i8* @mem_memset(i8*, i32, i64) local_unnamed_addr #1

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @find_next(%struct.block* readonly %block) unnamed_addr #0 !dbg !503 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !506
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !506
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !505, metadata !DIExpression()), !dbg !506
  %2 = bitcast %struct.block* %block to i8*, !dbg !507
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !508
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !508
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !509
  %3 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !509
  %_msprop = or i64 %_msret, %0, !dbg !509
  %4 = icmp eq i64 %_msret, 0, !dbg !509
  %5 = select i1 %4, i32 %1, i32 %3, !dbg !509
  %add.ptr = getelementptr inbounds i8, i8* %2, i64 %call, !dbg !509
  %6 = bitcast i8* %add.ptr to %struct.block*, !dbg !510
  store i64 %_msprop, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !511
  store i32 %5, i32* @__msan_retval_origin_tls, align 4, !dbg !511
  ret %struct.block* %6, !dbg !511
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @search_seg_list(i64 %size) unnamed_addr #0 !dbg !512 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !517
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !517
  call void @llvm.dbg.value(metadata i64 %size, metadata !516, metadata !DIExpression()), !dbg !517
  %2 = xor i64 %0, -1, !dbg !518
  %3 = and i64 %2, %size, !dbg !518
  %4 = icmp ult i64 %3, 32, !dbg !518
  %5 = or i64 %0, %size, !dbg !518
  %6 = icmp ult i64 %5, 32, !dbg !518
  %7 = xor i1 %4, %6, !dbg !518
  br i1 %7, label %8, label %9, !dbg !520, !prof !84

; <label>:8:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !520
  call void @__msan_warning_noreturn() #4, !dbg !520
  call void asm sideeffect "", ""() #4, !dbg !520
  unreachable, !dbg !520

; <label>:9:                                      ; preds = %entry
  %cmp = icmp ult i64 %size, 32, !dbg !518
  br i1 %cmp, label %return, label %if.else, !dbg !520

if.else:                                          ; preds = %9
  %10 = icmp ult i64 %3, 64, !dbg !521
  %11 = icmp ult i64 %5, 64, !dbg !521
  %12 = xor i1 %10, %11, !dbg !521
  br i1 %12, label %13, label %14, !dbg !523, !prof !84

; <label>:13:                                     ; preds = %if.else
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !523
  call void @__msan_warning_noreturn() #4, !dbg !523
  call void asm sideeffect "", ""() #4, !dbg !523
  unreachable, !dbg !523

; <label>:14:                                     ; preds = %if.else
  %cmp2 = icmp ult i64 %size, 64, !dbg !521
  br i1 %cmp2, label %return, label %if.else4, !dbg !523

if.else4:                                         ; preds = %14
  %15 = icmp ult i64 %3, 128, !dbg !524
  %16 = icmp ult i64 %5, 128, !dbg !524
  %17 = xor i1 %15, %16, !dbg !524
  br i1 %17, label %18, label %19, !dbg !526, !prof !84

; <label>:18:                                     ; preds = %if.else4
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !526
  call void @__msan_warning_noreturn() #4, !dbg !526
  call void asm sideeffect "", ""() #4, !dbg !526
  unreachable, !dbg !526

; <label>:19:                                     ; preds = %if.else4
  %cmp7 = icmp ult i64 %size, 128, !dbg !524
  br i1 %cmp7, label %return, label %if.else9, !dbg !526

if.else9:                                         ; preds = %19
  %20 = icmp ult i64 %3, 256, !dbg !527
  %21 = icmp ult i64 %5, 256, !dbg !527
  %22 = xor i1 %20, %21, !dbg !527
  br i1 %22, label %23, label %24, !dbg !529, !prof !84

; <label>:23:                                     ; preds = %if.else9
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !529
  call void @__msan_warning_noreturn() #4, !dbg !529
  call void asm sideeffect "", ""() #4, !dbg !529
  unreachable, !dbg !529

; <label>:24:                                     ; preds = %if.else9
  %cmp12 = icmp ult i64 %size, 256, !dbg !527
  br i1 %cmp12, label %return, label %if.else14, !dbg !529

if.else14:                                        ; preds = %24
  %25 = icmp ult i64 %3, 512, !dbg !530
  %26 = icmp ult i64 %5, 512, !dbg !530
  %27 = xor i1 %25, %26, !dbg !530
  br i1 %27, label %28, label %29, !dbg !532, !prof !84

; <label>:28:                                     ; preds = %if.else14
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !532
  call void @__msan_warning_noreturn() #4, !dbg !532
  call void asm sideeffect "", ""() #4, !dbg !532
  unreachable, !dbg !532

; <label>:29:                                     ; preds = %if.else14
  %cmp17 = icmp ult i64 %size, 512, !dbg !530
  br i1 %cmp17, label %return, label %if.else19, !dbg !532

if.else19:                                        ; preds = %29
  %30 = icmp ult i64 %3, 1024, !dbg !533
  %31 = icmp ult i64 %5, 1024, !dbg !533
  %32 = xor i1 %30, %31, !dbg !533
  br i1 %32, label %33, label %34, !dbg !535, !prof !84

; <label>:33:                                     ; preds = %if.else19
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !535
  call void @__msan_warning_noreturn() #4, !dbg !535
  call void asm sideeffect "", ""() #4, !dbg !535
  unreachable, !dbg !535

; <label>:34:                                     ; preds = %if.else19
  %cmp22 = icmp ult i64 %size, 1024, !dbg !533
  br i1 %cmp22, label %return, label %if.else24, !dbg !535

if.else24:                                        ; preds = %34
  %35 = icmp ult i64 %3, 2048, !dbg !536
  %36 = icmp ult i64 %5, 2048, !dbg !536
  %37 = xor i1 %35, %36, !dbg !536
  br i1 %37, label %38, label %39, !dbg !538, !prof !84

; <label>:38:                                     ; preds = %if.else24
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !538
  call void @__msan_warning_noreturn() #4, !dbg !538
  call void asm sideeffect "", ""() #4, !dbg !538
  unreachable, !dbg !538

; <label>:39:                                     ; preds = %if.else24
  %cmp27 = icmp ult i64 %size, 2048, !dbg !536
  br i1 %cmp27, label %return, label %if.else29, !dbg !538

if.else29:                                        ; preds = %39
  %40 = icmp ult i64 %3, 4096, !dbg !539
  %41 = icmp ult i64 %5, 4096, !dbg !539
  %42 = xor i1 %40, %41, !dbg !539
  br i1 %42, label %43, label %44, !dbg !541, !prof !84

; <label>:43:                                     ; preds = %if.else29
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !541
  call void @__msan_warning_noreturn() #4, !dbg !541
  call void asm sideeffect "", ""() #4, !dbg !541
  unreachable, !dbg !541

; <label>:44:                                     ; preds = %if.else29
  %cmp32 = icmp ult i64 %size, 4096, !dbg !539
  br i1 %cmp32, label %return, label %if.else34, !dbg !541

if.else34:                                        ; preds = %44
  %45 = icmp ult i64 %3, 8192, !dbg !542
  %46 = icmp ult i64 %5, 8192, !dbg !542
  %47 = xor i1 %45, %46, !dbg !542
  br i1 %47, label %48, label %49, !dbg !544, !prof !84

; <label>:48:                                     ; preds = %if.else34
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !544
  call void @__msan_warning_noreturn() #4, !dbg !544
  call void asm sideeffect "", ""() #4, !dbg !544
  unreachable, !dbg !544

; <label>:49:                                     ; preds = %if.else34
  %cmp37 = icmp ult i64 %size, 8192, !dbg !542
  br i1 %cmp37, label %return, label %if.else39, !dbg !544

if.else39:                                        ; preds = %49
  %50 = icmp ult i64 %3, 16384, !dbg !545
  %51 = icmp ult i64 %5, 16384, !dbg !545
  %52 = xor i1 %50, %51, !dbg !545
  br i1 %52, label %53, label %54, !dbg !547, !prof !84

; <label>:53:                                     ; preds = %if.else39
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !547
  call void @__msan_warning_noreturn() #4, !dbg !547
  call void asm sideeffect "", ""() #4, !dbg !547
  unreachable, !dbg !547

; <label>:54:                                     ; preds = %if.else39
  %cmp42 = icmp ult i64 %size, 16384, !dbg !545
  br i1 %cmp42, label %return, label %if.else44, !dbg !547

if.else44:                                        ; preds = %54
  %55 = icmp ult i64 %3, 32768, !dbg !548
  %56 = icmp ult i64 %5, 32768, !dbg !548
  %57 = xor i1 %55, %56, !dbg !548
  br i1 %57, label %58, label %59, !dbg !550, !prof !84

; <label>:58:                                     ; preds = %if.else44
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !550
  call void @__msan_warning_noreturn() #4, !dbg !550
  call void asm sideeffect "", ""() #4, !dbg !550
  unreachable, !dbg !550

; <label>:59:                                     ; preds = %if.else44
  %cmp47 = icmp ult i64 %size, 32768, !dbg !548
  br i1 %cmp47, label %return, label %if.else49, !dbg !550

if.else49:                                        ; preds = %59
  %60 = icmp ult i64 %3, 65536, !dbg !551
  %61 = icmp ult i64 %5, 65536, !dbg !551
  %62 = xor i1 %60, %61, !dbg !551
  br i1 %62, label %63, label %64, !dbg !553, !prof !84

; <label>:63:                                     ; preds = %if.else49
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !553
  call void @__msan_warning_noreturn() #4, !dbg !553
  call void asm sideeffect "", ""() #4, !dbg !553
  unreachable, !dbg !553

; <label>:64:                                     ; preds = %if.else49
  %cmp52 = icmp ult i64 %size, 65536, !dbg !551
  br i1 %cmp52, label %return, label %if.else54, !dbg !553

if.else54:                                        ; preds = %64
  %65 = icmp ult i64 %3, 131072, !dbg !554
  %66 = icmp ult i64 %5, 131072, !dbg !554
  %67 = xor i1 %65, %66, !dbg !554
  %cmp57 = icmp ult i64 %size, 131072, !dbg !554
  %_msprop_select = zext i1 %67 to i64, !dbg !556
  %68 = select i1 %67, i32 %1, i32 0, !dbg !556
  %. = select i1 %cmp57, i64 12, i64 13, !dbg !556
  br label %return, !dbg !556

return:                                           ; preds = %if.else54, %64, %59, %54, %49, %44, %39, %34, %29, %24, %19, %14, %9
  %_msphi_s = phi i64 [ 0, %9 ], [ 0, %14 ], [ 0, %19 ], [ 0, %24 ], [ 0, %29 ], [ 0, %34 ], [ 0, %39 ], [ 0, %44 ], [ 0, %49 ], [ 0, %54 ], [ 0, %59 ], [ 0, %64 ], [ %_msprop_select, %if.else54 ], !dbg !557
  %_msphi_o = phi i32 [ 0, %9 ], [ 0, %14 ], [ 0, %19 ], [ 0, %24 ], [ 0, %29 ], [ 0, %34 ], [ 0, %39 ], [ 0, %44 ], [ 0, %49 ], [ 0, %54 ], [ 0, %59 ], [ 0, %64 ], [ %68, %if.else54 ], !dbg !557
  %retval.0 = phi i64 [ 0, %9 ], [ 1, %14 ], [ 2, %19 ], [ 3, %24 ], [ 4, %29 ], [ 5, %34 ], [ 6, %39 ], [ 7, %44 ], [ 8, %49 ], [ 9, %54 ], [ 10, %59 ], [ 11, %64 ], [ %., %if.else54 ], !dbg !557
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !558
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !558
  ret i64 %retval.0, !dbg !558
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @best_fit(%struct.block* readonly %block, i64 %asize) unnamed_addr #0 !dbg !559 {
entry:
  %0 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !569
  %1 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !569
  %2 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !569
  %3 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !569
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !563, metadata !DIExpression()), !dbg !569
  call void @llvm.dbg.value(metadata i64 %asize, metadata !564, metadata !DIExpression()), !dbg !570
  call void @llvm.dbg.value(metadata i64 -1, metadata !567, metadata !DIExpression()), !dbg !571
  call void @llvm.dbg.value(metadata %struct.block* null, metadata !566, metadata !DIExpression()), !dbg !572
  %4 = ptrtoint %struct.block* %block to i64, !dbg !573
  %5 = xor i64 %2, -1, !dbg !573
  %6 = and i64 %5, %4, !dbg !573
  %7 = icmp eq i64 %6, 0, !dbg !573
  %8 = icmp ne i64 %2, 0, !dbg !573
  %_msprop_icmp = and i1 %8, %7, !dbg !573
  br i1 %_msprop_icmp, label %9, label %10, !dbg !575, !prof !84

; <label>:9:                                      ; preds = %entry
  store i32 %3, i32* @__msan_origin_tls, align 4, !dbg !575
  call void @__msan_warning_noreturn() #4, !dbg !575
  call void asm sideeffect "", ""() #4, !dbg !575
  unreachable, !dbg !575

; <label>:10:                                     ; preds = %entry
  %cmp = icmp eq %struct.block* %block, null, !dbg !573
  br i1 %cmp, label %return, label %for.body.preheader, !dbg !575

for.body.preheader:                               ; preds = %10
  %11 = icmp eq i64 %0, 0
  br label %for.body, !dbg !576

for.body:                                         ; preds = %for.body.preheader, %59
  %_msphi_s27 = phi i64 [ %_msprop_select35, %59 ], [ 0, %for.body.preheader ]
  %_msphi_o28 = phi i32 [ %43, %59 ], [ 0, %for.body.preheader ]
  %bestfit_size.025 = phi i64 [ %bestfit_size.1, %59 ], [ -1, %for.body.preheader ]
  %_msphi_s29 = phi i64 [ %_msprop_select, %59 ], [ 0, %for.body.preheader ]
  %_msphi_o30 = phi i32 [ %38, %59 ], [ 0, %for.body.preheader ]
  %bestfit_block.024 = phi %struct.block* [ %bestfit_block.1, %59 ], [ null, %for.body.preheader ]
  %_msphi_s31 = phi i64 [ %_msld, %59 ], [ %2, %for.body.preheader ]
  %_msphi_o32 = phi i32 [ %52, %59 ], [ %3, %for.body.preheader ]
  %seg_block.023 = phi %struct.block* [ %46, %59 ], [ %block, %for.body.preheader ]
  call void @llvm.dbg.value(metadata i64 %bestfit_size.025, metadata !567, metadata !DIExpression()), !dbg !571
  call void @llvm.dbg.value(metadata %struct.block* %bestfit_block.024, metadata !566, metadata !DIExpression()), !dbg !572
  call void @llvm.dbg.value(metadata %struct.block* %seg_block.023, metadata !565, metadata !DIExpression()), !dbg !580
  store i64 %_msphi_s31, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !576
  store i32 %_msphi_o32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !576
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !576
  %call = call fastcc i64 @get_size(%struct.block* nonnull %seg_block.023), !dbg !576
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !581
  %12 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !581
  call void @llvm.dbg.value(metadata i64 %call, metadata !568, metadata !DIExpression()), !dbg !581
  %13 = xor i64 %call, %asize, !dbg !582
  %14 = or i64 %_msret, %0, !dbg !582
  %15 = xor i64 %14, -1, !dbg !582
  %16 = and i64 %13, %15, !dbg !582
  %17 = icmp eq i64 %16, 0, !dbg !582
  %18 = icmp ne i64 %14, 0, !dbg !582
  %_msprop_icmp33 = and i1 %18, %17, !dbg !582
  %19 = select i1 %11, i32 %12, i32 %1, !dbg !582
  br i1 %_msprop_icmp33, label %20, label %21, !dbg !584, !prof !84

; <label>:20:                                     ; preds = %for.body
  store i32 %19, i32* @__msan_origin_tls, align 4, !dbg !584
  call void @__msan_warning_noreturn() #4, !dbg !584
  call void asm sideeffect "", ""() #4, !dbg !584
  unreachable, !dbg !584

; <label>:21:                                     ; preds = %for.body
  %cmp2 = icmp eq i64 %call, %asize, !dbg !582
  br i1 %cmp2, label %return.loopexit, label %if.else, !dbg !584

if.else:                                          ; preds = %21
  %cmp4 = icmp ugt i64 %call, %asize, !dbg !585
  %_msprop34 = or i64 %_msret, %_msphi_s27, !dbg !587
  %22 = icmp eq i64 %_msphi_s27, 0, !dbg !587
  %23 = select i1 %22, i32 %12, i32 %_msphi_o28, !dbg !587
  %24 = icmp ne i64 %_msprop34, 0, !dbg !587
  %cmp5 = icmp ult i64 %call, %bestfit_size.025, !dbg !587
  %25 = and i1 %18, %24, !dbg !588
  %26 = and i1 %cmp4, %24, !dbg !588
  %27 = and i1 %cmp5, %18, !dbg !588
  %28 = or i1 %26, %27, !dbg !588
  %29 = or i1 %25, %28, !dbg !588
  %30 = select i1 %24, i32 %23, i32 %19, !dbg !588
  %or.cond = and i1 %cmp4, %cmp5, !dbg !588
  call void @llvm.dbg.value(metadata i64 %call, metadata !567, metadata !DIExpression()), !dbg !571
  call void @llvm.dbg.value(metadata %struct.block* %seg_block.023, metadata !566, metadata !DIExpression()), !dbg !572
  %31 = select i1 %or.cond, i64 %_msphi_s31, i64 %_msphi_s29, !dbg !588
  %32 = ptrtoint %struct.block* %seg_block.023 to i64, !dbg !588
  %33 = ptrtoint %struct.block* %bestfit_block.024 to i64, !dbg !588
  %34 = or i64 %_msphi_s31, %_msphi_s29, !dbg !588
  %35 = xor i64 %32, %33, !dbg !588
  %36 = or i64 %34, %35, !dbg !588
  %_msprop_select = select i1 %29, i64 %36, i64 %31, !dbg !588
  %37 = select i1 %or.cond, i32 %_msphi_o32, i32 %_msphi_o30, !dbg !588
  %38 = select i1 %29, i32 %30, i32 %37, !dbg !588
  %bestfit_block.1 = select i1 %or.cond, %struct.block* %seg_block.023, %struct.block* %bestfit_block.024, !dbg !588
  %39 = select i1 %or.cond, i64 %_msret, i64 %_msphi_s27, !dbg !588
  %40 = xor i64 %call, %bestfit_size.025, !dbg !588
  %41 = or i64 %_msprop34, %40, !dbg !588
  %_msprop_select35 = select i1 %29, i64 %41, i64 %39, !dbg !588
  %42 = select i1 %or.cond, i32 %12, i32 %_msphi_o28, !dbg !588
  %43 = select i1 %29, i32 %30, i32 %42, !dbg !588
  %bestfit_size.1 = select i1 %or.cond, i64 %call, i64 %bestfit_size.025, !dbg !588
  %next_block = getelementptr inbounds %struct.block, %struct.block* %seg_block.023, i64 0, i32 1, i32 0, i32 1, !dbg !589
  %_mscmp38 = icmp eq i64 %_msphi_s31, 0, !dbg !589
  br i1 %_mscmp38, label %45, label %44, !dbg !589, !prof !92

; <label>:44:                                     ; preds = %if.else
  store i32 %_msphi_o32, i32* @__msan_origin_tls, align 4, !dbg !589
  call void @__msan_warning_noreturn() #4, !dbg !589
  call void asm sideeffect "", ""() #4, !dbg !589
  unreachable, !dbg !589

; <label>:45:                                     ; preds = %if.else
  %46 = load %struct.block*, %struct.block** %next_block, align 8, !dbg !589, !tbaa !590
  %47 = ptrtoint %struct.block** %next_block to i64, !dbg !571
  %48 = xor i64 %47, 87960930222080, !dbg !571
  %49 = inttoptr i64 %48 to i64*, !dbg !571
  %50 = add i64 %48, 17592186044416, !dbg !571
  %51 = inttoptr i64 %50 to i32*, !dbg !571
  %_msld = load i64, i64* %49, align 8, !dbg !571
  %52 = load i32, i32* %51, align 8, !dbg !571
  call void @llvm.dbg.value(metadata i64 %bestfit_size.1, metadata !567, metadata !DIExpression()), !dbg !571
  call void @llvm.dbg.value(metadata %struct.block* %bestfit_block.1, metadata !566, metadata !DIExpression()), !dbg !572
  call void @llvm.dbg.value(metadata %struct.block* %46, metadata !565, metadata !DIExpression()), !dbg !580
  %53 = ptrtoint %struct.block* %46 to i64, !dbg !591
  %54 = xor i64 %_msld, -1, !dbg !591
  %55 = and i64 %54, %53, !dbg !591
  %56 = icmp eq i64 %55, 0, !dbg !591
  %57 = icmp ne i64 %_msld, 0, !dbg !591
  %_msprop_icmp36 = and i1 %57, %56, !dbg !591
  br i1 %_msprop_icmp36, label %58, label %59, !dbg !592, !prof !84

; <label>:58:                                     ; preds = %45
  store i32 %52, i32* @__msan_origin_tls, align 4, !dbg !592
  call void @__msan_warning_noreturn() #4, !dbg !592
  call void asm sideeffect "", ""() #4, !dbg !592
  unreachable, !dbg !592

; <label>:59:                                     ; preds = %45
  %cmp1 = icmp eq %struct.block* %46, null, !dbg !591
  br i1 %cmp1, label %return.loopexit, label %for.body, !dbg !592, !llvm.loop !593

return.loopexit:                                  ; preds = %59, %21
  %_msphi_s.ph = phi i64 [ %_msprop_select, %59 ], [ %_msphi_s31, %21 ]
  %_msphi_o.ph = phi i32 [ %38, %59 ], [ %_msphi_o32, %21 ]
  %retval.0.ph = phi %struct.block* [ %bestfit_block.1, %59 ], [ %seg_block.023, %21 ]
  br label %return, !dbg !595

return:                                           ; preds = %return.loopexit, %10
  %_msphi_s = phi i64 [ 0, %10 ], [ %_msphi_s.ph, %return.loopexit ], !dbg !596
  %_msphi_o = phi i32 [ 0, %10 ], [ %_msphi_o.ph, %return.loopexit ], !dbg !596
  %retval.0 = phi %struct.block* [ null, %10 ], [ %retval.0.ph, %return.loopexit ], !dbg !596
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !595
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !595
  ret %struct.block* %retval.0, !dbg !595
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @extract_size(i64 %word) unnamed_addr #0 !dbg !599 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !604
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !604
  call void @llvm.dbg.value(metadata i64 %word, metadata !603, metadata !DIExpression()), !dbg !604
  %2 = and i64 %0, -16, !dbg !605
  %and = and i64 %word, -16, !dbg !605
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !606
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !606
  ret i64 %and, !dbg !606
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull i64* @header_to_footer(%struct.block* readonly %block) unnamed_addr #0 !dbg !607 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !612
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !612
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !611, metadata !DIExpression()), !dbg !612
  %2 = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, !dbg !613
  %arraydecay = bitcast %union.anon* %2 to i8*, !dbg !614
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !615
  %call = call fastcc i64 @get_size(%struct.block* %block), !dbg !615
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !616
  %3 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !616
  %_msprop = or i64 %_msret, %0, !dbg !616
  %4 = icmp eq i64 %_msret, 0, !dbg !616
  %5 = select i1 %4, i32 %1, i32 %3, !dbg !616
  %add.ptr = getelementptr inbounds i8, i8* %arraydecay, i64 %call, !dbg !616
  %add.ptr1 = getelementptr inbounds i8, i8* %add.ptr, i64 -16, !dbg !617
  %6 = bitcast i8* %add.ptr1 to i64*, !dbg !618
  store i64 %_msprop, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !619
  store i32 %5, i32* @__msan_retval_origin_tls, align 4, !dbg !619
  ret i64* %6, !dbg !619
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc i64 @extract_footer(i64 %word) unnamed_addr #0 !dbg !620 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !625
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !625
  call void @llvm.dbg.value(metadata i64 %word, metadata !624, metadata !DIExpression()), !dbg !625
  %2 = and i64 %0, 2, !dbg !626
  %and = and i64 %word, 2, !dbg !626
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !627
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !627
  ret i64 %and, !dbg !627
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @delete_seg_list(%struct.block* nocapture %block) unnamed_addr #0 !dbg !628 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !636
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !632, metadata !DIExpression()), !dbg !636
  %prev_block2 = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 0, !dbg !637
  %_mscmp = icmp eq i64 %0, 0, !dbg !637
  br i1 %_mscmp, label %3, label %1, !dbg !637, !prof !92

; <label>:1:                                      ; preds = %entry
  %2 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !636
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !637
  call void @__msan_warning_noreturn() #4, !dbg !637
  call void asm sideeffect "", ""() #4, !dbg !637
  unreachable, !dbg !637

; <label>:3:                                      ; preds = %entry
  %4 = load %struct.block*, %struct.block** %prev_block2, align 8, !dbg !637, !tbaa !590
  %5 = ptrtoint %struct.block** %prev_block2 to i64, !dbg !638
  %6 = xor i64 %5, 87960930222080, !dbg !638
  %7 = inttoptr i64 %6 to i64*, !dbg !638
  %8 = add i64 %6, 17592186044416, !dbg !638
  %9 = inttoptr i64 %8 to i32*, !dbg !638
  %_msld = load i64, i64* %7, align 8, !dbg !638
  %10 = load i32, i32* %9, align 8, !dbg !638
  call void @llvm.dbg.value(metadata %struct.block* %4, metadata !634, metadata !DIExpression()), !dbg !638
  %next_block3 = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 1, !dbg !639
  br i1 false, label %11, label %12, !dbg !639, !prof !84

; <label>:11:                                     ; preds = %3
  unreachable, !dbg !639

; <label>:12:                                     ; preds = %3
  %13 = load %struct.block*, %struct.block** %next_block3, align 8, !dbg !639, !tbaa !590
  %14 = ptrtoint %struct.block** %next_block3 to i64, !dbg !640
  %15 = xor i64 %14, 87960930222080, !dbg !640
  %16 = inttoptr i64 %15 to i64*, !dbg !640
  %17 = add i64 %15, 17592186044416, !dbg !640
  %18 = inttoptr i64 %17 to i32*, !dbg !640
  %_msld30 = load i64, i64* %16, align 8, !dbg !640
  %19 = load i32, i32* %18, align 8, !dbg !640
  call void @llvm.dbg.value(metadata %struct.block* %13, metadata !635, metadata !DIExpression()), !dbg !640
  %20 = ptrtoint %struct.block* %4 to i64, !dbg !641
  %21 = xor i64 %_msld, -1, !dbg !641
  %22 = and i64 %21, %20, !dbg !641
  %23 = icmp eq i64 %22, 0, !dbg !641
  %24 = icmp ne i64 %_msld, 0, !dbg !641
  %_msprop_icmp = and i1 %24, %23, !dbg !641
  %25 = ptrtoint %struct.block* %13 to i64, !dbg !643
  %26 = xor i64 %_msld30, -1, !dbg !643
  %27 = and i64 %26, %25, !dbg !643
  %28 = icmp eq i64 %27, 0, !dbg !643
  %29 = icmp ne i64 %_msld30, 0, !dbg !643
  %_msprop_icmp31 = and i1 %29, %28, !dbg !643
  %cmp4 = icmp eq %struct.block* %13, null, !dbg !643
  br i1 %_msprop_icmp, label %30, label %31, !dbg !645, !prof !84

; <label>:30:                                     ; preds = %12
  store i32 %10, i32* @__msan_origin_tls, align 4, !dbg !645
  call void @__msan_warning_noreturn() #4, !dbg !645
  call void asm sideeffect "", ""() #4, !dbg !645
  unreachable, !dbg !645

; <label>:31:                                     ; preds = %12
  %cmp = icmp eq %struct.block* %4, null, !dbg !641
  br i1 %cmp, label %if.then, label %if.else8, !dbg !645

if.then:                                          ; preds = %31
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !646
  %call = call fastcc i64 @get_size(%struct.block* nonnull %block), !dbg !646
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !647
  %32 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !647
  store i64 %_msret, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !647
  store i32 %32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !647
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !647
  %call1 = call fastcc i64 @search_seg_list(i64 %call), !dbg !647
  %_msret32 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !648
  %33 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !648
  call void @llvm.dbg.value(metadata i64 %call1, metadata !633, metadata !DIExpression()), !dbg !648
  %34 = icmp ne i64 %_msret32, 0, !dbg !649
  %35 = select i1 %34, i32 %33, i32 0, !dbg !649
  %arrayidx = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %call1, !dbg !649
  br i1 %_msprop_icmp31, label %36, label %37, !dbg !653, !prof !84

; <label>:36:                                     ; preds = %if.then
  store i32 %19, i32* @__msan_origin_tls, align 4, !dbg !653
  call void @__msan_warning_noreturn() #4, !dbg !653
  call void asm sideeffect "", ""() #4, !dbg !653
  unreachable, !dbg !653

; <label>:37:                                     ; preds = %if.then
  br i1 %cmp4, label %if.then5, label %if.else, !dbg !653

if.then5:                                         ; preds = %37
  br i1 %34, label %38, label %39, !dbg !654, !prof !84

; <label>:38:                                     ; preds = %if.then5
  store i32 %35, i32* @__msan_origin_tls, align 4, !dbg !654
  call void @__msan_warning_noreturn() #4, !dbg !654
  call void asm sideeffect "", ""() #4, !dbg !654
  unreachable, !dbg !654

; <label>:39:                                     ; preds = %if.then5
  %40 = ptrtoint %struct.block** %arrayidx to i64, !dbg !654
  %41 = xor i64 %40, 87960930222080, !dbg !654
  %42 = inttoptr i64 %41 to i64*, !dbg !654
  store i64 0, i64* %42, align 8, !dbg !654
  store %struct.block* null, %struct.block** %arrayidx, align 8, !dbg !654, !tbaa !101
  br label %if.end16, !dbg !656

if.else:                                          ; preds = %37
  br i1 %34, label %43, label %44, !dbg !657, !prof !84

; <label>:43:                                     ; preds = %if.else
  store i32 %35, i32* @__msan_origin_tls, align 4, !dbg !657
  call void @__msan_warning_noreturn() #4, !dbg !657
  call void asm sideeffect "", ""() #4, !dbg !657
  unreachable, !dbg !657

; <label>:44:                                     ; preds = %if.else
  %45 = ptrtoint %struct.block** %arrayidx to i64, !dbg !657
  %46 = xor i64 %45, 87960930222080, !dbg !657
  %47 = inttoptr i64 %46 to i64*, !dbg !657
  store i64 %_msld30, i64* %47, align 8, !dbg !657
  br i1 %29, label %48, label %55, !dbg !657, !prof !84

; <label>:48:                                     ; preds = %44
  %49 = add i64 %46, 17592186044416, !dbg !657
  %50 = call i32 @__msan_chain_origin(i32 %19) #4, !dbg !657
  %51 = zext i32 %50 to i64, !dbg !657
  %52 = shl nuw i64 %51, 32, !dbg !657
  %53 = or i64 %52, %51, !dbg !657
  %54 = inttoptr i64 %49 to i64*, !dbg !657
  store i64 %53, i64* %54, align 8, !dbg !657
  br label %55, !dbg !657

; <label>:55:                                     ; preds = %44, %48
  store %struct.block* %13, %struct.block** %arrayidx, align 8, !dbg !657, !tbaa !101
  %prev_block7 = getelementptr inbounds %struct.block, %struct.block* %13, i64 0, i32 1, i32 0, i32 0, !dbg !658
  br i1 %29, label %56, label %57, !dbg !659, !prof !84

; <label>:56:                                     ; preds = %55
  store i32 %19, i32* @__msan_origin_tls, align 4, !dbg !659
  call void @__msan_warning_noreturn() #4, !dbg !659
  call void asm sideeffect "", ""() #4, !dbg !659
  unreachable, !dbg !659

; <label>:57:                                     ; preds = %55
  %58 = ptrtoint %struct.block** %prev_block7 to i64, !dbg !659
  %59 = xor i64 %58, 87960930222080, !dbg !659
  %60 = inttoptr i64 %59 to i64*, !dbg !659
  store i64 0, i64* %60, align 8, !dbg !659
  store %struct.block* null, %struct.block** %prev_block7, align 8, !dbg !659, !tbaa !590
  br label %if.end16

if.else8:                                         ; preds = %31
  br i1 %_msprop_icmp31, label %61, label %62, !dbg !660, !prof !84

; <label>:61:                                     ; preds = %if.else8
  store i32 %19, i32* @__msan_origin_tls, align 4, !dbg !660
  call void @__msan_warning_noreturn() #4, !dbg !660
  call void asm sideeffect "", ""() #4, !dbg !660
  unreachable, !dbg !660

; <label>:62:                                     ; preds = %if.else8
  br i1 %cmp4, label %if.then10, label %if.else12, !dbg !660

if.then10:                                        ; preds = %62
  %next_block11 = getelementptr inbounds %struct.block, %struct.block* %4, i64 0, i32 1, i32 0, i32 1, !dbg !661
  br i1 %24, label %63, label %64, !dbg !663, !prof !84

; <label>:63:                                     ; preds = %if.then10
  store i32 %10, i32* @__msan_origin_tls, align 4, !dbg !663
  call void @__msan_warning_noreturn() #4, !dbg !663
  call void asm sideeffect "", ""() #4, !dbg !663
  unreachable, !dbg !663

; <label>:64:                                     ; preds = %if.then10
  %65 = ptrtoint %struct.block** %next_block11 to i64, !dbg !663
  %66 = xor i64 %65, 87960930222080, !dbg !663
  %67 = inttoptr i64 %66 to i64*, !dbg !663
  store i64 0, i64* %67, align 8, !dbg !663
  store %struct.block* null, %struct.block** %next_block11, align 8, !dbg !663, !tbaa !590
  br label %if.end16, !dbg !664

if.else12:                                        ; preds = %62
  %prev_block13 = getelementptr inbounds %struct.block, %struct.block* %13, i64 0, i32 1, i32 0, i32 0, !dbg !665
  br i1 %29, label %68, label %69, !dbg !667, !prof !84

; <label>:68:                                     ; preds = %if.else12
  store i32 %19, i32* @__msan_origin_tls, align 4, !dbg !667
  call void @__msan_warning_noreturn() #4, !dbg !667
  call void asm sideeffect "", ""() #4, !dbg !667
  unreachable, !dbg !667

; <label>:69:                                     ; preds = %if.else12
  %70 = ptrtoint %struct.block** %prev_block13 to i64, !dbg !667
  %71 = xor i64 %70, 87960930222080, !dbg !667
  %72 = inttoptr i64 %71 to i64*, !dbg !667
  store i64 %_msld, i64* %72, align 8, !dbg !667
  br i1 %24, label %73, label %80, !dbg !667, !prof !84

; <label>:73:                                     ; preds = %69
  %74 = add i64 %71, 17592186044416, !dbg !667
  %75 = call i32 @__msan_chain_origin(i32 %10) #4, !dbg !667
  %76 = zext i32 %75 to i64, !dbg !667
  %77 = shl nuw i64 %76, 32, !dbg !667
  %78 = or i64 %77, %76, !dbg !667
  %79 = inttoptr i64 %74 to i64*, !dbg !667
  store i64 %78, i64* %79, align 8, !dbg !667
  br label %80, !dbg !667

; <label>:80:                                     ; preds = %69, %73
  store %struct.block* %4, %struct.block** %prev_block13, align 8, !dbg !667, !tbaa !590
  %next_block14 = getelementptr inbounds %struct.block, %struct.block* %4, i64 0, i32 1, i32 0, i32 1, !dbg !668
  br i1 %24, label %81, label %82, !dbg !669, !prof !84

; <label>:81:                                     ; preds = %80
  store i32 %10, i32* @__msan_origin_tls, align 4, !dbg !669
  call void @__msan_warning_noreturn() #4, !dbg !669
  call void asm sideeffect "", ""() #4, !dbg !669
  unreachable, !dbg !669

; <label>:82:                                     ; preds = %80
  %83 = ptrtoint %struct.block** %next_block14 to i64, !dbg !669
  %84 = xor i64 %83, 87960930222080, !dbg !669
  %85 = inttoptr i64 %84 to i64*, !dbg !669
  store i64 0, i64* %85, align 8, !dbg !669
  br i1 false, label %86, label %87, !dbg !669, !prof !84

; <label>:86:                                     ; preds = %82
  br label %87, !dbg !669

; <label>:87:                                     ; preds = %82, %86
  store %struct.block* %13, %struct.block** %next_block14, align 8, !dbg !669, !tbaa !590
  br label %if.end16

if.end16:                                         ; preds = %64, %87, %39, %57
  %88 = bitcast %struct.block** %prev_block2 to i8*, !dbg !670
  %89 = call i8* @__msan_memset(i8* %88, i32 0, i64 16) #4, !dbg !671
  ret void, !dbg !670
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc void @add_seg_list(%struct.block* %block, i64 %size) unnamed_addr #0 !dbg !672 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !677
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !677
  %2 = load i64, i64* inttoptr (i64 add (i64 ptrtoint ([100 x i64]* @__msan_param_tls to i64), i64 8) to i64*), align 8, !dbg !677
  %3 = load i32, i32* inttoptr (i64 add (i64 ptrtoint ([200 x i32]* @__msan_param_origin_tls to i64), i64 8) to i32*), align 4, !dbg !677
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !674, metadata !DIExpression()), !dbg !677
  call void @llvm.dbg.value(metadata i64 %size, metadata !675, metadata !DIExpression()), !dbg !678
  store i64 %2, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !679
  store i32 %3, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !679
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !679
  %call = call fastcc i64 @search_seg_list(i64 %size), !dbg !679
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !680
  call void @llvm.dbg.value(metadata i64 %call, metadata !676, metadata !DIExpression()), !dbg !680
  %4 = icmp eq i64 %_msret, 0, !dbg !681
  %arrayidx = getelementptr inbounds [14 x %struct.block*], [14 x %struct.block*]* @seg_list, i64 0, i64 %call, !dbg !681
  br i1 %4, label %7, label %5, !dbg !681, !prof !92

; <label>:5:                                      ; preds = %entry
  %6 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !680
  store i32 %6, i32* @__msan_origin_tls, align 4, !dbg !681
  call void @__msan_warning_noreturn() #4, !dbg !681
  call void asm sideeffect "", ""() #4, !dbg !681
  unreachable, !dbg !681

; <label>:7:                                      ; preds = %entry
  %8 = load %struct.block*, %struct.block** %arrayidx, align 8, !dbg !681, !tbaa !101
  %9 = ptrtoint %struct.block** %arrayidx to i64, !dbg !683
  %10 = xor i64 %9, 87960930222080, !dbg !683
  %11 = inttoptr i64 %10 to i64*, !dbg !683
  %12 = add i64 %10, 17592186044416, !dbg !683
  %13 = inttoptr i64 %12 to i32*, !dbg !683
  %_msld = load i64, i64* %11, align 8, !dbg !683
  %14 = load i32, i32* %13, align 8, !dbg !683
  %15 = icmp ne i64 %_msld, 0, !dbg !683
  %cmp = icmp eq %struct.block* %8, null, !dbg !683
  %prev_block = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 0, !dbg !684
  %_mscmp18 = icmp eq i64 %0, 0, !dbg !684
  br i1 %_mscmp18, label %17, label %16, !dbg !684, !prof !92

; <label>:16:                                     ; preds = %7
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !684
  call void @__msan_warning_noreturn() #4, !dbg !684
  call void asm sideeffect "", ""() #4, !dbg !684
  unreachable, !dbg !684

; <label>:17:                                     ; preds = %7
  %18 = xor i64 %_msld, -1, !dbg !683
  %19 = ptrtoint %struct.block* %8 to i64, !dbg !683
  %20 = and i64 %18, %19, !dbg !683
  %21 = icmp eq i64 %20, 0, !dbg !683
  %_msprop_icmp = and i1 %15, %21, !dbg !683
  %22 = ptrtoint %struct.block** %prev_block to i64, !dbg !684
  %23 = xor i64 %22, 87960930222080, !dbg !684
  %24 = inttoptr i64 %23 to i64*, !dbg !684
  store i64 0, i64* %24, align 8, !dbg !684
  store %struct.block* null, %struct.block** %prev_block, align 8, !dbg !684, !tbaa !590
  br i1 %_msprop_icmp, label %25, label %26, !dbg !686, !prof !84

; <label>:25:                                     ; preds = %17
  store i32 %14, i32* @__msan_origin_tls, align 4, !dbg !686
  call void @__msan_warning_noreturn() #4, !dbg !686
  call void asm sideeffect "", ""() #4, !dbg !686
  unreachable, !dbg !686

; <label>:26:                                     ; preds = %17
  br i1 %cmp, label %if.then, label %if.else, !dbg !686

if.then:                                          ; preds = %26
  %next_block = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 1, !dbg !687
  br i1 false, label %27, label %28, !dbg !689, !prof !84

; <label>:27:                                     ; preds = %if.then
  unreachable, !dbg !689

; <label>:28:                                     ; preds = %if.then
  %29 = ptrtoint %struct.block** %next_block to i64, !dbg !689
  %30 = xor i64 %29, 87960930222080, !dbg !689
  %31 = inttoptr i64 %30 to i64*, !dbg !689
  store i64 0, i64* %31, align 8, !dbg !689
  store %struct.block* null, %struct.block** %next_block, align 8, !dbg !689, !tbaa !590
  br label %if.end, !dbg !690

if.else:                                          ; preds = %26
  br i1 false, label %32, label %33, !dbg !691, !prof !84

; <label>:32:                                     ; preds = %if.else
  unreachable, !dbg !691

; <label>:33:                                     ; preds = %if.else
  %34 = bitcast %struct.block** %arrayidx to i64*, !dbg !691
  %35 = load i64, i64* %34, align 8, !dbg !691, !tbaa !101
  %36 = ptrtoint %struct.block** %arrayidx to i64, !dbg !692
  %37 = xor i64 %36, 87960930222080, !dbg !692
  %38 = inttoptr i64 %37 to i64*, !dbg !692
  %39 = add i64 %37, 17592186044416, !dbg !692
  %40 = inttoptr i64 %39 to i32*, !dbg !692
  %_msld17 = load i64, i64* %38, align 8, !dbg !692
  %41 = load i32, i32* %40, align 8, !dbg !692
  %next_block4 = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 1, i32 0, i32 1, !dbg !692
  %42 = bitcast %struct.block** %next_block4 to i64*, !dbg !693
  br i1 false, label %43, label %44, !dbg !693, !prof !84

; <label>:43:                                     ; preds = %33
  unreachable, !dbg !693

; <label>:44:                                     ; preds = %33
  %45 = ptrtoint %struct.block** %next_block4 to i64, !dbg !693
  %46 = xor i64 %45, 87960930222080, !dbg !693
  %47 = inttoptr i64 %46 to i64*, !dbg !693
  store i64 %_msld17, i64* %47, align 8, !dbg !693
  %_mscmp26 = icmp eq i64 %_msld17, 0, !dbg !693
  br i1 %_mscmp26, label %55, label %48, !dbg !693, !prof !92

; <label>:48:                                     ; preds = %44
  %49 = add i64 %46, 17592186044416, !dbg !693
  %50 = call i32 @__msan_chain_origin(i32 %41) #4, !dbg !693
  %51 = zext i32 %50 to i64, !dbg !693
  %52 = shl nuw i64 %51, 32, !dbg !693
  %53 = or i64 %52, %51, !dbg !693
  %54 = inttoptr i64 %49 to i64*, !dbg !693
  store i64 %53, i64* %54, align 8, !dbg !693
  br label %55, !dbg !693

; <label>:55:                                     ; preds = %44, %48
  store i64 %35, i64* %42, align 8, !dbg !693, !tbaa !590
  %prev_block6 = getelementptr inbounds %struct.block, %struct.block* %8, i64 0, i32 1, i32 0, i32 0, !dbg !694
  br i1 %15, label %56, label %57, !dbg !695, !prof !84

; <label>:56:                                     ; preds = %55
  store i32 %14, i32* @__msan_origin_tls, align 4, !dbg !695
  call void @__msan_warning_noreturn() #4, !dbg !695
  call void asm sideeffect "", ""() #4, !dbg !695
  unreachable, !dbg !695

; <label>:57:                                     ; preds = %55
  %58 = ptrtoint %struct.block** %prev_block6 to i64, !dbg !695
  %59 = xor i64 %58, 87960930222080, !dbg !695
  %60 = inttoptr i64 %59 to i64*, !dbg !695
  store i64 0, i64* %60, align 8, !dbg !695
  br i1 false, label %61, label %62, !dbg !695, !prof !84

; <label>:61:                                     ; preds = %57
  br label %62, !dbg !695

; <label>:62:                                     ; preds = %57, %61
  store %struct.block* %block, %struct.block** %prev_block6, align 8, !dbg !695, !tbaa !590
  br label %if.end

if.end:                                           ; preds = %62, %28
  br i1 false, label %63, label %64, !dbg !696, !prof !84

; <label>:63:                                     ; preds = %if.end
  unreachable, !dbg !696

; <label>:64:                                     ; preds = %if.end
  store i64 0, i64* %11, align 8, !dbg !696
  br i1 false, label %65, label %66, !dbg !696, !prof !84

; <label>:65:                                     ; preds = %64
  br label %66, !dbg !696

; <label>:66:                                     ; preds = %64, %65
  store %struct.block* %block, %struct.block** %arrayidx, align 8, !dbg !696, !tbaa !101
  ret void, !dbg !697
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc zeroext i1 @get_alloc(%struct.block* nocapture readonly %block) unnamed_addr #0 !dbg !698 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !703
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !702, metadata !DIExpression()), !dbg !703
  %_mscmp = icmp eq i64 %0, 0, !dbg !704
  br i1 %_mscmp, label %3, label %1, !dbg !704, !prof !92

; <label>:1:                                      ; preds = %entry
  %2 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !703
  store i32 %2, i32* @__msan_origin_tls, align 4, !dbg !704
  call void @__msan_warning_noreturn() #4, !dbg !704
  call void asm sideeffect "", ""() #4, !dbg !704
  unreachable, !dbg !704

; <label>:3:                                      ; preds = %entry
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !704
  %4 = load i64, i64* %header, align 8, !dbg !704, !tbaa !154
  %5 = ptrtoint %struct.block* %block to i64, !dbg !705
  %6 = xor i64 %5, 87960930222080, !dbg !705
  %7 = inttoptr i64 %6 to i64*, !dbg !705
  %8 = add i64 %6, 17592186044416, !dbg !705
  %9 = inttoptr i64 %8 to i32*, !dbg !705
  %_msld = load i64, i64* %7, align 8, !dbg !705
  %10 = load i32, i32* %9, align 8, !dbg !705
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !705
  store i32 %10, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !705
  store i1 false, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !705
  %call = call fastcc zeroext i1 @extract_alloc(i64 %4), !dbg !705
  ret i1 %call, !dbg !706
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc %struct.block* @find_prev(%struct.block* readonly %block) unnamed_addr #0 !dbg !707 {
entry:
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !709, metadata !DIExpression()), !dbg !711
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !712
  %call = call fastcc i64* @find_prev_footer(%struct.block* %block), !dbg !712
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !713
  %0 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !713
  call void @llvm.dbg.value(metadata i64* %call, metadata !710, metadata !DIExpression()), !dbg !713
  %_mscmp = icmp eq i64 %_msret, 0, !dbg !714
  br i1 %_mscmp, label %2, label %1, !dbg !714, !prof !92

; <label>:1:                                      ; preds = %entry
  store i32 %0, i32* @__msan_origin_tls, align 4, !dbg !714
  call void @__msan_warning_noreturn() #4, !dbg !714
  call void asm sideeffect "", ""() #4, !dbg !714
  unreachable, !dbg !714

; <label>:2:                                      ; preds = %entry
  %3 = load i64, i64* %call, align 8, !dbg !714, !tbaa !93
  %4 = ptrtoint i64* %call to i64, !dbg !716
  %5 = xor i64 %4, 87960930222080, !dbg !716
  %6 = inttoptr i64 %5 to i64*, !dbg !716
  %7 = add i64 %5, 17592186044416, !dbg !716
  %8 = inttoptr i64 %7 to i32*, !dbg !716
  %_msld = load i64, i64* %6, align 8, !dbg !716
  %9 = load i32, i32* %8, align 8, !dbg !716
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !716
  store i32 %9, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !716
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !716
  %call1 = call fastcc i64 @extract_size(i64 %3), !dbg !716
  %_msret4 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !717
  %10 = xor i64 %_msret4, -1, !dbg !717
  %11 = and i64 %call1, %10, !dbg !717
  %12 = icmp eq i64 %11, 0, !dbg !717
  %13 = icmp ne i64 %_msret4, 0, !dbg !717
  %_msprop_icmp = and i1 %13, %12, !dbg !717
  br i1 %_msprop_icmp, label %14, label %16, !dbg !718, !prof !84

; <label>:14:                                     ; preds = %2
  %15 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !717
  store i32 %15, i32* @__msan_origin_tls, align 4, !dbg !718
  call void @__msan_warning_noreturn() #4, !dbg !718
  call void asm sideeffect "", ""() #4, !dbg !718
  unreachable, !dbg !718

; <label>:16:                                     ; preds = %2
  %cmp = icmp eq i64 %call1, 0, !dbg !717
  br i1 %cmp, label %return, label %if.end, !dbg !718

if.end:                                           ; preds = %16
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !719
  store i32 %0, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !719
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !719
  %call2 = call fastcc %struct.block* @footer_to_header(i64* nonnull %call), !dbg !719
  %_msret5 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !720
  %17 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !720
  br label %return, !dbg !720

return:                                           ; preds = %16, %if.end
  %_msphi_s = phi i64 [ %_msret5, %if.end ], [ 0, %16 ], !dbg !721
  %_msphi_o = phi i32 [ %17, %if.end ], [ 0, %16 ], !dbg !721
  %retval.0 = phi %struct.block* [ %call2, %if.end ], [ null, %16 ], !dbg !721
  store i64 %_msphi_s, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !722
  store i32 %_msphi_o, i32* @__msan_retval_origin_tls, align 4, !dbg !722
  ret %struct.block* %retval.0, !dbg !722
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc zeroext i1 @extract_alloc(i64 %word) unnamed_addr #0 !dbg !723 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !728
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !728
  call void @llvm.dbg.value(metadata i64 %word, metadata !727, metadata !DIExpression()), !dbg !728
  %2 = and i64 %0, 1, !dbg !729
  %and = and i64 %word, 1, !dbg !729
  %3 = xor i64 %2, -1, !dbg !730
  %4 = and i64 %and, %3, !dbg !730
  %5 = icmp eq i64 %4, 0, !dbg !730
  %6 = icmp ne i64 %2, 0, !dbg !730
  %_msprop_icmp = and i1 %6, %5, !dbg !730
  %tobool = icmp ne i64 %and, 0, !dbg !730
  store i1 %_msprop_icmp, i1* bitcast ([100 x i64]* @__msan_retval_tls to i1*), align 8, !dbg !731
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !731
  ret i1 %tobool, !dbg !731
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull i64* @find_prev_footer(%struct.block* readnone %block) unnamed_addr #0 !dbg !732 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !735
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !735
  call void @llvm.dbg.value(metadata %struct.block* %block, metadata !734, metadata !DIExpression()), !dbg !735
  %header = getelementptr inbounds %struct.block, %struct.block* %block, i64 0, i32 0, !dbg !736
  %add.ptr = getelementptr inbounds i64, i64* %header, i64 -1, !dbg !737
  store i64 %0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !738
  store i32 %1, i32* @__msan_retval_origin_tls, align 4, !dbg !738
  ret i64* %add.ptr, !dbg !738
}

; Function Attrs: noinline nounwind sanitize_memory uwtable
define internal fastcc nonnull %struct.block* @footer_to_header(i64* readonly %footer) unnamed_addr #0 !dbg !739 {
entry:
  %0 = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !745
  %1 = load i32, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !745
  call void @llvm.dbg.value(metadata i64* %footer, metadata !743, metadata !DIExpression()), !dbg !745
  %_mscmp = icmp eq i64 %0, 0, !dbg !746
  br i1 %_mscmp, label %3, label %2, !dbg !746, !prof !92

; <label>:2:                                      ; preds = %entry
  store i32 %1, i32* @__msan_origin_tls, align 4, !dbg !746
  call void @__msan_warning_noreturn() #4, !dbg !746
  call void asm sideeffect "", ""() #4, !dbg !746
  unreachable, !dbg !746

; <label>:3:                                      ; preds = %entry
  %4 = load i64, i64* %footer, align 8, !dbg !746, !tbaa !93
  %5 = ptrtoint i64* %footer to i64, !dbg !747
  %6 = xor i64 %5, 87960930222080, !dbg !747
  %7 = inttoptr i64 %6 to i64*, !dbg !747
  %8 = add i64 %6, 17592186044416, !dbg !747
  %9 = inttoptr i64 %8 to i32*, !dbg !747
  %_msld = load i64, i64* %7, align 8, !dbg !747
  %10 = load i32, i32* %9, align 8, !dbg !747
  store i64 %_msld, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_param_tls, i64 0, i64 0), align 8, !dbg !747
  store i32 %10, i32* getelementptr inbounds ([200 x i32], [200 x i32]* @__msan_param_origin_tls, i64 0, i64 0), align 4, !dbg !747
  store i64 0, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !747
  %call = call fastcc i64 @extract_size(i64 %4), !dbg !747
  %_msret = load i64, i64* getelementptr inbounds ([100 x i64], [100 x i64]* @__msan_retval_tls, i64 0, i64 0), align 8, !dbg !748
  %11 = load i32, i32* @__msan_retval_origin_tls, align 4, !dbg !748
  call void @llvm.dbg.value(metadata i64 %call, metadata !744, metadata !DIExpression()), !dbg !748
  %add.ptr3 = getelementptr inbounds i64, i64* %footer, i64 1, !dbg !749
  %add.ptr = bitcast i64* %add.ptr3 to i8*, !dbg !749
  %12 = icmp eq i64 %_msret, 0, !dbg !750
  %idx.neg = sub i64 0, %call, !dbg !750
  %13 = select i1 %12, i32 %1, i32 %11, !dbg !750
  %add.ptr1 = getelementptr inbounds i8, i8* %add.ptr, i64 %idx.neg, !dbg !750
  %14 = bitcast i8* %add.ptr1 to %struct.block*, !dbg !751
  store i32 %13, i32* @__msan_retval_origin_tls, align 4, !dbg !752
  ret %struct.block* %14, !dbg !752
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

declare void @__msan_init() local_unnamed_addr

define internal void @msan.module_ctor() {
  tail call void @__msan_init()
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #3

declare i32 @__msan_chain_origin(i32)

declare i8* @__msan_memmove(i8*, i8*, i64)

declare i8* @__msan_memcpy(i8*, i8*, i64)

declare i8* @__msan_memset(i8*, i32, i64)

declare void @__msan_warning_noreturn()

declare void @__msan_maybe_warning_1(i8, i32)

declare void @__msan_maybe_store_origin_1(i8, i8*, i32)

declare void @__msan_maybe_warning_2(i16, i32)

declare void @__msan_maybe_store_origin_2(i16, i8*, i32)

declare void @__msan_maybe_warning_4(i32, i32)

declare void @__msan_maybe_store_origin_4(i32, i8*, i32)

declare void @__msan_maybe_warning_8(i64, i32)

declare void @__msan_maybe_store_origin_8(i64, i8*, i32)

declare void @__msan_set_alloca_origin4(i8*, i64, i8*, i64)

declare void @__msan_poison_stack(i8*, i64)

attributes #0 = { noinline nounwind sanitize_memory uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="true" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="true" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

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
!84 = !{!"branch_weights", i32 1, i32 1000}
!85 = !DILocation(line: 929, column: 21, scope: !73)
!86 = !DILocation(line: 929, column: 13, scope: !73)
!87 = !DILocation(line: 944, column: 21, scope: !88)
!88 = distinct !DILexicalBlock(scope: !89, file: !3, line: 943, column: 45)
!89 = distinct !DILexicalBlock(scope: !79, file: !3, line: 943, column: 5)
!90 = !DILocation(line: 947, column: 16, scope: !73)
!91 = !DILocation(line: 947, column: 14, scope: !73)
!92 = !{!"branch_weights", i32 1000, i32 1}
!93 = !{!94, !94, i64 0}
!94 = !{!"long", !95, i64 0}
!95 = !{!"omnipotent char", !96, i64 0}
!96 = !{!"Simple C/C++ TBAA"}
!97 = !DILocation(line: 948, column: 16, scope: !73)
!98 = !DILocation(line: 948, column: 5, scope: !73)
!99 = !DILocation(line: 948, column: 14, scope: !73)
!100 = !DILocation(line: 951, column: 16, scope: !73)
!101 = !{!102, !102, i64 0}
!102 = !{!"any pointer", !95, i64 0}
!103 = !DILocation(line: 953, column: 14, scope: !73)
!104 = !DILocation(line: 956, column: 9, scope: !105)
!105 = distinct !DILexicalBlock(scope: !73, file: !3, line: 956, column: 9)
!106 = !DILocation(line: 956, column: 32, scope: !105)
!107 = !DILocation(line: 957, column: 9, scope: !108)
!108 = distinct !DILexicalBlock(scope: !105, file: !3, line: 956, column: 41)
!109 = !DILocation(line: 0, scope: !73)
!110 = !DILocation(line: 961, column: 1, scope: !73)
!111 = distinct !DISubprogram(name: "pack_foot", scope: !3, file: !3, line: 287, type: !112, isLocal: true, isDefinition: true, scopeLine: 287, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !114)
!112 = !DISubroutineType(types: !113)
!113 = !{!7, !31, !31}
!114 = !{!115, !116, !117}
!115 = !DILocalVariable(name: "size", arg: 1, scope: !111, file: !3, line: 287, type: !31)
!116 = !DILocalVariable(name: "alloc", arg: 2, scope: !111, file: !3, line: 287, type: !31)
!117 = !DILocalVariable(name: "word", scope: !111, file: !3, line: 288, type: !7)
!118 = !DILocation(line: 287, column: 32, scope: !111)
!119 = !DILocation(line: 287, column: 45, scope: !111)
!120 = !DILocation(line: 288, column: 12, scope: !111)
!121 = !DILocation(line: 289, column: 15, scope: !122)
!122 = distinct !DILexicalBlock(scope: !111, file: !3, line: 289, column: 9)
!123 = !DILocation(line: 289, column: 9, scope: !111)
!124 = !DILocation(line: 292, column: 15, scope: !125)
!125 = distinct !DILexicalBlock(scope: !111, file: !3, line: 292, column: 9)
!126 = !DILocation(line: 292, column: 9, scope: !111)
!127 = !DILocation(line: 295, column: 5, scope: !111)
!128 = distinct !DISubprogram(name: "extend_heap", scope: !3, file: !3, line: 638, type: !129, isLocal: true, isDefinition: true, scopeLine: 638, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !131)
!129 = !DISubroutineType(types: !130)
!130 = !{!12, !31}
!131 = !{!132, !133, !134, !135}
!132 = !DILocalVariable(name: "size", arg: 1, scope: !128, file: !3, line: 638, type: !31)
!133 = !DILocalVariable(name: "bp", scope: !128, file: !3, line: 639, type: !11)
!134 = !DILocalVariable(name: "epi", scope: !128, file: !3, line: 642, type: !7)
!135 = !DILocalVariable(name: "block", scope: !128, file: !3, line: 654, type: !12)
!136 = !DILocation(line: 638, column: 36, scope: !128)
!137 = !DILocation(line: 642, column: 29, scope: !128)
!138 = !DILocation(line: 642, column: 18, scope: !128)
!139 = !DILocation(line: 642, column: 12, scope: !128)
!140 = !DILocation(line: 643, column: 12, scope: !128)
!141 = !DILocation(line: 644, column: 15, scope: !142)
!142 = distinct !DILexicalBlock(scope: !128, file: !3, line: 644, column: 9)
!143 = !DILocation(line: 639, column: 11, scope: !128)
!144 = !DILocation(line: 644, column: 41, scope: !142)
!145 = !DILocation(line: 644, column: 9, scope: !128)
!146 = !DILocation(line: 654, column: 22, scope: !128)
!147 = !DILocation(line: 654, column: 14, scope: !128)
!148 = !DILocation(line: 655, column: 5, scope: !128)
!149 = !DILocation(line: 660, column: 16, scope: !128)
!150 = !DILocation(line: 660, column: 14, scope: !128)
!151 = !DILocation(line: 661, column: 24, scope: !128)
!152 = !DILocation(line: 661, column: 15, scope: !128)
!153 = !DILocation(line: 661, column: 22, scope: !128)
!154 = !{!155, !94, i64 0}
!155 = !{!"block", !94, i64 0, !95, i64 8}
!156 = !DILocation(line: 664, column: 13, scope: !128)
!157 = !DILocation(line: 666, column: 5, scope: !128)
!158 = !DILocation(line: 0, scope: !128)
!159 = !DILocation(line: 667, column: 1, scope: !128)
!160 = distinct !DISubprogram(name: "mm_malloc", scope: !3, file: !3, line: 976, type: !161, isLocal: false, isDefinition: true, scopeLine: 976, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !163)
!161 = !DISubroutineType(types: !162)
!162 = !{!11, !31}
!163 = !{!164, !165, !166, !167, !168, !169}
!164 = !DILocalVariable(name: "size", arg: 1, scope: !160, file: !3, line: 976, type: !31)
!165 = !DILocalVariable(name: "asize", scope: !160, file: !3, line: 979, type: !31)
!166 = !DILocalVariable(name: "extendsize", scope: !160, file: !3, line: 980, type: !31)
!167 = !DILocalVariable(name: "block", scope: !160, file: !3, line: 981, type: !12)
!168 = !DILocalVariable(name: "bp", scope: !160, file: !3, line: 982, type: !11)
!169 = !DILocalVariable(name: "block_size", scope: !160, file: !3, line: 1021, type: !31)
!170 = !DILocation(line: 976, column: 21, scope: !160)
!171 = !DILocation(line: 982, column: 11, scope: !160)
!172 = !DILocation(line: 985, column: 9, scope: !173)
!173 = distinct !DILexicalBlock(scope: !160, file: !3, line: 985, column: 9)
!174 = !DILocation(line: 985, column: 20, scope: !173)
!175 = !DILocation(line: 985, column: 9, scope: !160)
!176 = !DILocation(line: 986, column: 9, scope: !177)
!177 = distinct !DILexicalBlock(scope: !173, file: !3, line: 985, column: 29)
!178 = !DILocation(line: 987, column: 5, scope: !177)
!179 = !DILocation(line: 990, column: 14, scope: !180)
!180 = distinct !DILexicalBlock(scope: !160, file: !3, line: 990, column: 9)
!181 = !DILocation(line: 990, column: 9, scope: !160)
!182 = !DILocation(line: 996, column: 14, scope: !183)
!183 = distinct !DILexicalBlock(scope: !160, file: !3, line: 996, column: 9)
!184 = !DILocation(line: 996, column: 9, scope: !160)
!185 = !DILocation(line: 999, column: 31, scope: !183)
!186 = !DILocation(line: 999, column: 17, scope: !183)
!187 = !DILocation(line: 979, column: 12, scope: !160)
!188 = !DILocation(line: 0, scope: !183)
!189 = !DILocation(line: 1007, column: 18, scope: !190)
!190 = distinct !DILexicalBlock(scope: !160, file: !3, line: 1007, column: 9)
!191 = !DILocation(line: 981, column: 14, scope: !160)
!192 = !DILocation(line: 1007, column: 35, scope: !190)
!193 = !DILocation(line: 1007, column: 9, scope: !160)
!194 = !DILocation(line: 1009, column: 22, scope: !195)
!195 = distinct !DILexicalBlock(scope: !190, file: !3, line: 1007, column: 44)
!196 = !DILocation(line: 980, column: 12, scope: !160)
!197 = !DILocation(line: 1010, column: 17, scope: !195)
!198 = !DILocation(line: 1012, column: 19, scope: !199)
!199 = distinct !DILexicalBlock(scope: !195, file: !3, line: 1012, column: 13)
!200 = !DILocation(line: 1012, column: 13, scope: !195)
!201 = !DILocation(line: 0, scope: !190)
!202 = !DILocation(line: 1021, column: 25, scope: !160)
!203 = !DILocation(line: 1021, column: 12, scope: !160)
!204 = !DILocation(line: 1022, column: 41, scope: !160)
!205 = !DILocation(line: 1022, column: 59, scope: !160)
!206 = !DILocation(line: 1022, column: 5, scope: !160)
!207 = !DILocation(line: 1025, column: 5, scope: !160)
!208 = !DILocation(line: 1027, column: 10, scope: !160)
!209 = !DILocation(line: 1030, column: 5, scope: !160)
!210 = !DILocation(line: 0, scope: !160)
!211 = !DILocation(line: 1031, column: 1, scope: !160)
!212 = distinct !DISubprogram(name: "round_up", scope: !3, file: !3, line: 251, type: !213, isLocal: true, isDefinition: true, scopeLine: 251, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !215)
!213 = !DISubroutineType(types: !214)
!214 = !{!31, !31, !31}
!215 = !{!216, !217}
!216 = !DILocalVariable(name: "size", arg: 1, scope: !212, file: !3, line: 251, type: !31)
!217 = !DILocalVariable(name: "n", arg: 2, scope: !212, file: !3, line: 251, type: !31)
!218 = !DILocation(line: 251, column: 31, scope: !212)
!219 = !DILocation(line: 251, column: 44, scope: !212)
!220 = !DILocation(line: 252, column: 23, scope: !212)
!221 = !DILocation(line: 252, column: 14, scope: !212)
!222 = !DILocation(line: 252, column: 5, scope: !212)
!223 = distinct !DISubprogram(name: "find_fit", scope: !3, file: !3, line: 835, type: !129, isLocal: true, isDefinition: true, scopeLine: 835, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !224)
!224 = !{!225, !226, !227}
!225 = !DILocalVariable(name: "asize", arg: 1, scope: !223, file: !3, line: 835, type: !31)
!226 = !DILocalVariable(name: "bestfit", scope: !223, file: !3, line: 836, type: !12)
!227 = !DILocalVariable(name: "i", scope: !228, file: !3, line: 839, type: !31)
!228 = distinct !DILexicalBlock(scope: !223, file: !3, line: 839, column: 5)
!229 = !DILocation(line: 835, column: 33, scope: !223)
!230 = !DILocation(line: 836, column: 14, scope: !223)
!231 = !DILocation(line: 839, column: 21, scope: !228)
!232 = !DILocation(line: 839, column: 17, scope: !228)
!233 = !DILocation(line: 839, column: 47, scope: !234)
!234 = distinct !DILexicalBlock(scope: !228, file: !3, line: 839, column: 5)
!235 = !DILocation(line: 839, column: 5, scope: !228)
!236 = !DILocation(line: 841, column: 28, scope: !237)
!237 = distinct !DILexicalBlock(scope: !234, file: !3, line: 839, column: 69)
!238 = distinct !{!238, !235, !239}
!239 = !DILocation(line: 844, column: 5, scope: !228)
!240 = !DILocation(line: 841, column: 19, scope: !237)
!241 = !DILocation(line: 842, column: 21, scope: !242)
!242 = distinct !DILexicalBlock(scope: !237, file: !3, line: 842, column: 13)
!243 = !DILocation(line: 839, column: 64, scope: !234)
!244 = !DILocation(line: 842, column: 13, scope: !237)
!245 = !DILocation(line: 850, column: 1, scope: !223)
!246 = !DILocation(line: 0, scope: !247)
!247 = distinct !DILexicalBlock(scope: !223, file: !3, line: 846, column: 9)
!248 = distinct !DISubprogram(name: "max", scope: !3, file: !3, line: 241, type: !213, isLocal: true, isDefinition: true, scopeLine: 241, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !249)
!249 = !{!250, !251}
!250 = !DILocalVariable(name: "x", arg: 1, scope: !248, file: !3, line: 241, type: !31)
!251 = !DILocalVariable(name: "y", arg: 2, scope: !248, file: !3, line: 241, type: !31)
!252 = !DILocation(line: 241, column: 26, scope: !248)
!253 = !DILocation(line: 241, column: 36, scope: !248)
!254 = !DILocation(line: 242, column: 15, scope: !248)
!255 = !DILocation(line: 242, column: 12, scope: !248)
!256 = !DILocation(line: 242, column: 5, scope: !248)
!257 = distinct !DISubprogram(name: "get_size", scope: !3, file: !3, line: 316, type: !258, isLocal: true, isDefinition: true, scopeLine: 316, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !260)
!258 = !DISubroutineType(types: !259)
!259 = !{!31, !12}
!260 = !{!261}
!261 = !DILocalVariable(name: "block", arg: 1, scope: !257, file: !3, line: 316, type: !12)
!262 = !DILocation(line: 316, column: 33, scope: !257)
!263 = !DILocation(line: 317, column: 32, scope: !257)
!264 = !DILocation(line: 317, column: 12, scope: !257)
!265 = !DILocation(line: 317, column: 5, scope: !257)
!266 = distinct !DISubprogram(name: "write_block_foot", scope: !3, file: !3, line: 471, type: !267, isLocal: true, isDefinition: true, scopeLine: 471, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !269)
!267 = !DISubroutineType(types: !268)
!268 = !{null, !12, !31, !31}
!269 = !{!270, !271, !272, !273}
!270 = !DILocalVariable(name: "block", arg: 1, scope: !266, file: !3, line: 471, type: !12)
!271 = !DILocalVariable(name: "size", arg: 2, scope: !266, file: !3, line: 471, type: !31)
!272 = !DILocalVariable(name: "alloc", arg: 3, scope: !266, file: !3, line: 471, type: !31)
!273 = !DILocalVariable(name: "footerp", scope: !266, file: !3, line: 475, type: !6)
!274 = !DILocation(line: 471, column: 39, scope: !266)
!275 = !DILocation(line: 471, column: 53, scope: !266)
!276 = !DILocation(line: 471, column: 66, scope: !266)
!277 = !DILocation(line: 474, column: 21, scope: !266)
!278 = !DILocation(line: 474, column: 12, scope: !266)
!279 = !DILocation(line: 474, column: 19, scope: !266)
!280 = !DILocation(line: 475, column: 23, scope: !266)
!281 = !DILocation(line: 475, column: 13, scope: !266)
!282 = !DILocation(line: 476, column: 14, scope: !266)
!283 = !DILocation(line: 477, column: 1, scope: !266)
!284 = distinct !DISubprogram(name: "get_footer", scope: !3, file: !3, line: 420, type: !285, isLocal: true, isDefinition: true, scopeLine: 420, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !287)
!285 = !DISubroutineType(types: !286)
!286 = !{!7, !12}
!287 = !{!288}
!288 = !DILocalVariable(name: "block", arg: 1, scope: !284, file: !3, line: 420, type: !12)
!289 = !DILocation(line: 420, column: 35, scope: !284)
!290 = !DILocation(line: 421, column: 34, scope: !284)
!291 = !DILocation(line: 421, column: 12, scope: !284)
!292 = !DILocation(line: 421, column: 5, scope: !284)
!293 = distinct !DISubprogram(name: "split_block", scope: !3, file: !3, line: 681, type: !294, isLocal: true, isDefinition: true, scopeLine: 681, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !296)
!294 = !DISubroutineType(types: !295)
!295 = !{null, !12, !31}
!296 = !{!297, !298, !299, !300, !301}
!297 = !DILocalVariable(name: "block", arg: 1, scope: !293, file: !3, line: 681, type: !12)
!298 = !DILocalVariable(name: "asize", arg: 2, scope: !293, file: !3, line: 681, type: !31)
!299 = !DILocalVariable(name: "nextp", scope: !293, file: !3, line: 683, type: !12)
!300 = !DILocalVariable(name: "block_size", scope: !293, file: !3, line: 684, type: !31)
!301 = !DILocalVariable(name: "rest_size", scope: !293, file: !3, line: 685, type: !31)
!302 = !DILocation(line: 681, column: 34, scope: !293)
!303 = !DILocation(line: 681, column: 48, scope: !293)
!304 = !DILocation(line: 684, column: 25, scope: !293)
!305 = !DILocation(line: 684, column: 12, scope: !293)
!306 = !DILocation(line: 685, column: 35, scope: !293)
!307 = !DILocation(line: 685, column: 12, scope: !293)
!308 = !DILocation(line: 687, column: 19, scope: !309)
!309 = distinct !DILexicalBlock(scope: !293, file: !3, line: 687, column: 9)
!310 = !DILocation(line: 687, column: 9, scope: !293)
!311 = !DILocation(line: 688, column: 9, scope: !312)
!312 = distinct !DILexicalBlock(scope: !309, file: !3, line: 687, column: 38)
!313 = !DILocation(line: 690, column: 25, scope: !312)
!314 = !DILocation(line: 690, column: 16, scope: !312)
!315 = !DILocation(line: 690, column: 23, scope: !312)
!316 = !DILocation(line: 693, column: 17, scope: !312)
!317 = !DILocation(line: 683, column: 14, scope: !293)
!318 = !DILocation(line: 694, column: 9, scope: !312)
!319 = !DILocation(line: 695, column: 9, scope: !312)
!320 = !DILocation(line: 696, column: 5, scope: !312)
!321 = !DILocation(line: 699, column: 25, scope: !322)
!322 = distinct !DILexicalBlock(scope: !309, file: !3, line: 696, column: 12)
!323 = !DILocation(line: 699, column: 16, scope: !322)
!324 = !DILocation(line: 699, column: 23, scope: !322)
!325 = !DILocation(line: 700, column: 17, scope: !322)
!326 = !DILocation(line: 701, column: 32, scope: !322)
!327 = !DILocation(line: 701, column: 39, scope: !322)
!328 = !DILocation(line: 701, column: 23, scope: !322)
!329 = !DILocation(line: 702, column: 9, scope: !322)
!330 = !DILocation(line: 705, column: 1, scope: !293)
!331 = distinct !DISubprogram(name: "header_to_payload", scope: !3, file: !3, line: 337, type: !332, isLocal: true, isDefinition: true, scopeLine: 337, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !334)
!332 = !DISubroutineType(types: !333)
!333 = !{!11, !12}
!334 = !{!335}
!335 = !DILocalVariable(name: "block", arg: 1, scope: !331, file: !3, line: 337, type: !12)
!336 = !DILocation(line: 337, column: 41, scope: !331)
!337 = !DILocation(line: 339, column: 28, scope: !331)
!338 = !DILocation(line: 339, column: 20, scope: !331)
!339 = !DILocation(line: 339, column: 5, scope: !331)
!340 = distinct !DISubprogram(name: "mm_free", scope: !3, file: !3, line: 1043, type: !341, isLocal: false, isDefinition: true, scopeLine: 1043, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !343)
!341 = !DISubroutineType(types: !342)
!342 = !{null, !11}
!343 = !{!344, !345, !346}
!344 = !DILocalVariable(name: "bp", arg: 1, scope: !340, file: !3, line: 1043, type: !11)
!345 = !DILocalVariable(name: "block", scope: !340, file: !3, line: 1050, type: !12)
!346 = !DILocalVariable(name: "size", scope: !340, file: !3, line: 1051, type: !31)
!347 = !DILocation(line: 1043, column: 17, scope: !340)
!348 = !DILocation(line: 1046, column: 12, scope: !349)
!349 = distinct !DILexicalBlock(scope: !340, file: !3, line: 1046, column: 9)
!350 = !DILocation(line: 1046, column: 9, scope: !340)
!351 = !DILocation(line: 1050, column: 22, scope: !340)
!352 = !DILocation(line: 1050, column: 14, scope: !340)
!353 = !DILocation(line: 1051, column: 19, scope: !340)
!354 = !DILocation(line: 1051, column: 12, scope: !340)
!355 = !DILocation(line: 1057, column: 43, scope: !340)
!356 = !DILocation(line: 1057, column: 5, scope: !340)
!357 = !DILocation(line: 1060, column: 5, scope: !340)
!358 = !DILocation(line: 1063, column: 1, scope: !340)
!359 = distinct !DISubprogram(name: "payload_to_header", scope: !3, file: !3, line: 326, type: !360, isLocal: true, isDefinition: true, scopeLine: 326, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !362)
!360 = !DISubroutineType(types: !361)
!361 = !{!12, !11}
!362 = !{!363}
!363 = !DILocalVariable(name: "bp", arg: 1, scope: !359, file: !3, line: 326, type: !11)
!364 = !DILocation(line: 326, column: 41, scope: !359)
!365 = !DILocation(line: 327, column: 35, scope: !359)
!366 = !DILocation(line: 327, column: 12, scope: !359)
!367 = !DILocation(line: 327, column: 5, scope: !359)
!368 = distinct !DISubprogram(name: "coalesce_block", scope: !3, file: !3, line: 550, type: !369, isLocal: true, isDefinition: true, scopeLine: 550, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !371)
!369 = !DISubroutineType(types: !370)
!370 = !{!12, !12}
!371 = !{!372, !373, !374, !375, !376, !377}
!372 = !DILocalVariable(name: "block", arg: 1, scope: !368, file: !3, line: 550, type: !12)
!373 = !DILocalVariable(name: "prev_block", scope: !368, file: !3, line: 552, type: !12)
!374 = !DILocalVariable(name: "next_block", scope: !368, file: !3, line: 553, type: !12)
!375 = !DILocalVariable(name: "prev_alloc", scope: !368, file: !3, line: 555, type: !36)
!376 = !DILocalVariable(name: "next_alloc", scope: !368, file: !3, line: 556, type: !36)
!377 = !DILocalVariable(name: "size", scope: !368, file: !3, line: 557, type: !31)
!378 = !DILocation(line: 550, column: 41, scope: !368)
!379 = !DILocation(line: 553, column: 27, scope: !368)
!380 = !DILocation(line: 553, column: 14, scope: !368)
!381 = !DILocation(line: 555, column: 29, scope: !368)
!382 = !DILocation(line: 555, column: 23, scope: !368)
!383 = !DILocation(line: 556, column: 23, scope: !368)
!384 = !DILocation(line: 557, column: 19, scope: !368)
!385 = !DILocation(line: 557, column: 12, scope: !368)
!386 = !DILocation(line: 562, column: 20, scope: !387)
!387 = distinct !DILexicalBlock(scope: !368, file: !3, line: 562, column: 9)
!388 = !DILocation(line: 563, column: 9, scope: !389)
!389 = distinct !DILexicalBlock(scope: !387, file: !3, line: 562, column: 35)
!390 = !DILocation(line: 564, column: 42, scope: !389)
!391 = !DILocation(line: 564, column: 49, scope: !389)
!392 = !DILocation(line: 564, column: 28, scope: !389)
!393 = !DILocation(line: 565, column: 5, scope: !389)
!394 = !DILocation(line: 567, column: 26, scope: !395)
!395 = distinct !DILexicalBlock(scope: !387, file: !3, line: 567, column: 14)
!396 = !DILocation(line: 569, column: 22, scope: !397)
!397 = distinct !DILexicalBlock(scope: !395, file: !3, line: 567, column: 41)
!398 = !DILocation(line: 552, column: 14, scope: !368)
!399 = !DILocation(line: 570, column: 17, scope: !397)
!400 = !DILocation(line: 570, column: 14, scope: !397)
!401 = !DILocation(line: 573, column: 9, scope: !397)
!402 = !DILocation(line: 576, column: 9, scope: !397)
!403 = !DILocation(line: 577, column: 42, scope: !397)
!404 = !DILocation(line: 577, column: 49, scope: !397)
!405 = !DILocation(line: 577, column: 28, scope: !397)
!406 = !DILocation(line: 579, column: 5, scope: !397)
!407 = !DILocation(line: 581, column: 25, scope: !408)
!408 = distinct !DILexicalBlock(scope: !395, file: !3, line: 581, column: 14)
!409 = !DILocation(line: 583, column: 17, scope: !410)
!410 = distinct !DILexicalBlock(scope: !408, file: !3, line: 581, column: 41)
!411 = !DILocation(line: 583, column: 14, scope: !410)
!412 = !DILocation(line: 586, column: 9, scope: !410)
!413 = !DILocation(line: 589, column: 9, scope: !410)
!414 = !DILocation(line: 590, column: 5, scope: !410)
!415 = !DILocation(line: 592, column: 26, scope: !416)
!416 = distinct !DILexicalBlock(scope: !408, file: !3, line: 592, column: 14)
!417 = !DILocation(line: 594, column: 22, scope: !418)
!418 = distinct !DILexicalBlock(scope: !416, file: !3, line: 592, column: 42)
!419 = !DILocation(line: 595, column: 23, scope: !418)
!420 = !DILocation(line: 595, column: 21, scope: !418)
!421 = !DILocation(line: 595, column: 46, scope: !418)
!422 = !DILocation(line: 595, column: 44, scope: !418)
!423 = !DILocation(line: 598, column: 9, scope: !418)
!424 = !DILocation(line: 599, column: 9, scope: !418)
!425 = !DILocation(line: 602, column: 9, scope: !418)
!426 = !DILocation(line: 604, column: 5, scope: !418)
!427 = !DILocation(line: 0, scope: !397)
!428 = !DILocation(line: 622, column: 5, scope: !368)
!429 = !DILocation(line: 624, column: 5, scope: !368)
!430 = distinct !DISubprogram(name: "mm_realloc", scope: !3, file: !3, line: 1077, type: !431, isLocal: false, isDefinition: true, scopeLine: 1077, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !433)
!431 = !DISubroutineType(types: !432)
!432 = !{!11, !11, !31}
!433 = !{!434, !435, !436, !437, !438}
!434 = !DILocalVariable(name: "ptr", arg: 1, scope: !430, file: !3, line: 1077, type: !11)
!435 = !DILocalVariable(name: "size", arg: 2, scope: !430, file: !3, line: 1077, type: !31)
!436 = !DILocalVariable(name: "block", scope: !430, file: !3, line: 1078, type: !12)
!437 = !DILocalVariable(name: "copysize", scope: !430, file: !3, line: 1079, type: !31)
!438 = !DILocalVariable(name: "newptr", scope: !430, file: !3, line: 1080, type: !11)
!439 = !DILocation(line: 1077, column: 21, scope: !430)
!440 = !DILocation(line: 1077, column: 33, scope: !430)
!441 = !DILocation(line: 1078, column: 22, scope: !430)
!442 = !DILocation(line: 1078, column: 14, scope: !430)
!443 = !DILocation(line: 1083, column: 14, scope: !444)
!444 = distinct !DILexicalBlock(scope: !430, file: !3, line: 1083, column: 9)
!445 = !DILocation(line: 1083, column: 9, scope: !430)
!446 = !DILocation(line: 1084, column: 9, scope: !447)
!447 = distinct !DILexicalBlock(scope: !444, file: !3, line: 1083, column: 20)
!448 = !DILocation(line: 1085, column: 9, scope: !447)
!449 = !DILocation(line: 1089, column: 13, scope: !450)
!450 = distinct !DILexicalBlock(scope: !430, file: !3, line: 1089, column: 9)
!451 = !DILocation(line: 0, scope: !430)
!452 = !DILocation(line: 1089, column: 9, scope: !430)
!453 = !DILocation(line: 1080, column: 11, scope: !430)
!454 = !DILocation(line: 1097, column: 16, scope: !455)
!455 = distinct !DILexicalBlock(scope: !430, file: !3, line: 1097, column: 9)
!456 = !DILocation(line: 1097, column: 9, scope: !430)
!457 = !DILocation(line: 1102, column: 16, scope: !430)
!458 = !DILocation(line: 1079, column: 12, scope: !430)
!459 = !DILocation(line: 1103, column: 14, scope: !460)
!460 = distinct !DILexicalBlock(scope: !430, file: !3, line: 1103, column: 9)
!461 = !DILocation(line: 1103, column: 9, scope: !430)
!462 = !DILocation(line: 1106, column: 5, scope: !430)
!463 = !DILocation(line: 1109, column: 5, scope: !430)
!464 = !DILocation(line: 1111, column: 5, scope: !430)
!465 = !DILocation(line: 1112, column: 1, scope: !430)
!466 = distinct !DISubprogram(name: "get_payload_size", scope: !3, file: !3, line: 377, type: !258, isLocal: true, isDefinition: true, scopeLine: 377, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !467)
!467 = !{!468, !469}
!468 = !DILocalVariable(name: "block", arg: 1, scope: !466, file: !3, line: 377, type: !12)
!469 = !DILocalVariable(name: "asize", scope: !466, file: !3, line: 378, type: !31)
!470 = !DILocation(line: 377, column: 41, scope: !466)
!471 = !DILocation(line: 378, column: 20, scope: !466)
!472 = !DILocation(line: 378, column: 12, scope: !466)
!473 = !DILocation(line: 379, column: 18, scope: !466)
!474 = !DILocation(line: 379, column: 5, scope: !466)
!475 = distinct !DISubprogram(name: "mm_calloc", scope: !3, file: !3, line: 1127, type: !476, isLocal: false, isDefinition: true, scopeLine: 1127, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !478)
!476 = !DISubroutineType(types: !477)
!477 = !{!11, !31, !31}
!478 = !{!479, !480, !481, !482}
!479 = !DILocalVariable(name: "elements", arg: 1, scope: !475, file: !3, line: 1127, type: !31)
!480 = !DILocalVariable(name: "size", arg: 2, scope: !475, file: !3, line: 1127, type: !31)
!481 = !DILocalVariable(name: "bp", scope: !475, file: !3, line: 1128, type: !11)
!482 = !DILocalVariable(name: "asize", scope: !475, file: !3, line: 1129, type: !31)
!483 = !DILocation(line: 1127, column: 21, scope: !475)
!484 = !DILocation(line: 1127, column: 38, scope: !475)
!485 = !DILocation(line: 1129, column: 29, scope: !475)
!486 = !DILocation(line: 1129, column: 12, scope: !475)
!487 = !DILocation(line: 1131, column: 18, scope: !488)
!488 = distinct !DILexicalBlock(scope: !475, file: !3, line: 1131, column: 9)
!489 = !DILocation(line: 1131, column: 9, scope: !475)
!490 = !DILocation(line: 1134, column: 15, scope: !491)
!491 = distinct !DILexicalBlock(scope: !475, file: !3, line: 1134, column: 9)
!492 = !DILocation(line: 1134, column: 26, scope: !491)
!493 = !DILocation(line: 1134, column: 9, scope: !475)
!494 = !DILocation(line: 1139, column: 10, scope: !475)
!495 = !DILocation(line: 1128, column: 11, scope: !475)
!496 = !DILocation(line: 1140, column: 12, scope: !497)
!497 = distinct !DILexicalBlock(scope: !475, file: !3, line: 1140, column: 9)
!498 = !DILocation(line: 1140, column: 9, scope: !475)
!499 = !DILocation(line: 1145, column: 5, scope: !475)
!500 = !DILocation(line: 1147, column: 5, scope: !475)
!501 = !DILocation(line: 0, scope: !475)
!502 = !DILocation(line: 1148, column: 1, scope: !475)
!503 = distinct !DISubprogram(name: "find_next", scope: !3, file: !3, line: 489, type: !369, isLocal: true, isDefinition: true, scopeLine: 489, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !504)
!504 = !{!505}
!505 = !DILocalVariable(name: "block", arg: 1, scope: !503, file: !3, line: 489, type: !12)
!506 = !DILocation(line: 489, column: 36, scope: !503)
!507 = !DILocation(line: 493, column: 24, scope: !503)
!508 = !DILocation(line: 493, column: 40, scope: !503)
!509 = !DILocation(line: 493, column: 38, scope: !503)
!510 = !DILocation(line: 493, column: 12, scope: !503)
!511 = !DILocation(line: 493, column: 5, scope: !503)
!512 = distinct !DISubprogram(name: "search_seg_list", scope: !3, file: !3, line: 793, type: !513, isLocal: true, isDefinition: true, scopeLine: 793, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !515)
!513 = !DISubroutineType(types: !514)
!514 = !{!31, !31}
!515 = !{!516}
!516 = !DILocalVariable(name: "size", arg: 1, scope: !512, file: !3, line: 793, type: !31)
!517 = !DILocation(line: 793, column: 38, scope: !512)
!518 = !DILocation(line: 794, column: 14, scope: !519)
!519 = distinct !DILexicalBlock(scope: !512, file: !3, line: 794, column: 9)
!520 = !DILocation(line: 794, column: 9, scope: !512)
!521 = !DILocation(line: 796, column: 49, scope: !522)
!522 = distinct !DILexicalBlock(scope: !519, file: !3, line: 796, column: 14)
!523 = !DILocation(line: 796, column: 40, scope: !522)
!524 = !DILocation(line: 798, column: 49, scope: !525)
!525 = distinct !DILexicalBlock(scope: !522, file: !3, line: 798, column: 14)
!526 = !DILocation(line: 798, column: 40, scope: !525)
!527 = !DILocation(line: 800, column: 49, scope: !528)
!528 = distinct !DILexicalBlock(scope: !525, file: !3, line: 800, column: 14)
!529 = !DILocation(line: 800, column: 40, scope: !528)
!530 = !DILocation(line: 802, column: 49, scope: !531)
!531 = distinct !DILexicalBlock(scope: !528, file: !3, line: 802, column: 14)
!532 = !DILocation(line: 802, column: 40, scope: !531)
!533 = !DILocation(line: 804, column: 49, scope: !534)
!534 = distinct !DILexicalBlock(scope: !531, file: !3, line: 804, column: 14)
!535 = !DILocation(line: 804, column: 40, scope: !534)
!536 = !DILocation(line: 806, column: 49, scope: !537)
!537 = distinct !DILexicalBlock(scope: !534, file: !3, line: 806, column: 14)
!538 = !DILocation(line: 806, column: 40, scope: !537)
!539 = !DILocation(line: 808, column: 49, scope: !540)
!540 = distinct !DILexicalBlock(scope: !537, file: !3, line: 808, column: 14)
!541 = !DILocation(line: 808, column: 40, scope: !540)
!542 = !DILocation(line: 810, column: 49, scope: !543)
!543 = distinct !DILexicalBlock(scope: !540, file: !3, line: 810, column: 14)
!544 = !DILocation(line: 810, column: 40, scope: !543)
!545 = !DILocation(line: 812, column: 49, scope: !546)
!546 = distinct !DILexicalBlock(scope: !543, file: !3, line: 812, column: 14)
!547 = !DILocation(line: 812, column: 40, scope: !546)
!548 = !DILocation(line: 814, column: 50, scope: !549)
!549 = distinct !DILexicalBlock(scope: !546, file: !3, line: 814, column: 14)
!550 = !DILocation(line: 814, column: 41, scope: !549)
!551 = !DILocation(line: 816, column: 50, scope: !552)
!552 = distinct !DILexicalBlock(scope: !549, file: !3, line: 816, column: 14)
!553 = !DILocation(line: 816, column: 41, scope: !552)
!554 = !DILocation(line: 818, column: 50, scope: !555)
!555 = distinct !DILexicalBlock(scope: !552, file: !3, line: 818, column: 14)
!556 = !DILocation(line: 819, column: 9, scope: !555)
!557 = !DILocation(line: 0, scope: !555)
!558 = !DILocation(line: 822, column: 1, scope: !512)
!559 = distinct !DISubprogram(name: "best_fit", scope: !3, file: !3, line: 862, type: !560, isLocal: true, isDefinition: true, scopeLine: 862, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !562)
!560 = !DISubroutineType(types: !561)
!561 = !{!12, !12, !31}
!562 = !{!563, !564, !565, !566, !567, !568}
!563 = !DILocalVariable(name: "block", arg: 1, scope: !559, file: !3, line: 862, type: !12)
!564 = !DILocalVariable(name: "asize", arg: 2, scope: !559, file: !3, line: 862, type: !31)
!565 = !DILocalVariable(name: "seg_block", scope: !559, file: !3, line: 863, type: !12)
!566 = !DILocalVariable(name: "bestfit_block", scope: !559, file: !3, line: 863, type: !12)
!567 = !DILocalVariable(name: "bestfit_size", scope: !559, file: !3, line: 864, type: !31)
!568 = !DILocalVariable(name: "current_size", scope: !559, file: !3, line: 864, type: !31)
!569 = !DILocation(line: 862, column: 35, scope: !559)
!570 = !DILocation(line: 862, column: 49, scope: !559)
!571 = !DILocation(line: 864, column: 12, scope: !559)
!572 = !DILocation(line: 863, column: 26, scope: !559)
!573 = !DILocation(line: 867, column: 15, scope: !574)
!574 = distinct !DILexicalBlock(scope: !559, file: !3, line: 867, column: 9)
!575 = !DILocation(line: 867, column: 9, scope: !559)
!576 = !DILocation(line: 873, column: 24, scope: !577)
!577 = distinct !DILexicalBlock(scope: !578, file: !3, line: 872, column: 45)
!578 = distinct !DILexicalBlock(scope: !579, file: !3, line: 871, column: 5)
!579 = distinct !DILexicalBlock(scope: !559, file: !3, line: 871, column: 5)
!580 = !DILocation(line: 863, column: 14, scope: !559)
!581 = !DILocation(line: 864, column: 26, scope: !559)
!582 = !DILocation(line: 874, column: 26, scope: !583)
!583 = distinct !DILexicalBlock(scope: !577, file: !3, line: 874, column: 13)
!584 = !DILocation(line: 874, column: 13, scope: !577)
!585 = !DILocation(line: 876, column: 34, scope: !586)
!586 = distinct !DILexicalBlock(scope: !583, file: !3, line: 876, column: 20)
!587 = !DILocation(line: 876, column: 60, scope: !586)
!588 = !DILocation(line: 876, column: 43, scope: !586)
!589 = !DILocation(line: 872, column: 33, scope: !578)
!590 = !{!95, !95, i64 0}
!591 = !DILocation(line: 871, column: 39, scope: !578)
!592 = !DILocation(line: 871, column: 5, scope: !579)
!593 = distinct !{!593, !592, !594}
!594 = !DILocation(line: 880, column: 5, scope: !579)
!595 = !DILocation(line: 887, column: 1, scope: !559)
!596 = !DILocation(line: 0, scope: !597)
!597 = distinct !DILexicalBlock(scope: !598, file: !3, line: 884, column: 12)
!598 = distinct !DILexicalBlock(scope: !559, file: !3, line: 881, column: 9)
!599 = distinct !DISubprogram(name: "extract_size", scope: !3, file: !3, line: 307, type: !600, isLocal: true, isDefinition: true, scopeLine: 307, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !602)
!600 = !DISubroutineType(types: !601)
!601 = !{!31, !7}
!602 = !{!603}
!603 = !DILocalVariable(name: "word", arg: 1, scope: !599, file: !3, line: 307, type: !7)
!604 = !DILocation(line: 307, column: 35, scope: !599)
!605 = !DILocation(line: 308, column: 18, scope: !599)
!606 = !DILocation(line: 308, column: 5, scope: !599)
!607 = distinct !DISubprogram(name: "header_to_footer", scope: !3, file: !3, line: 349, type: !608, isLocal: true, isDefinition: true, scopeLine: 349, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !610)
!608 = !DISubroutineType(types: !609)
!609 = !{!6, !12}
!610 = !{!611}
!611 = !DILocalVariable(name: "block", arg: 1, scope: !607, file: !3, line: 349, type: !12)
!612 = !DILocation(line: 349, column: 42, scope: !607)
!613 = !DILocation(line: 352, column: 30, scope: !607)
!614 = !DILocation(line: 352, column: 23, scope: !607)
!615 = !DILocation(line: 352, column: 40, scope: !607)
!616 = !DILocation(line: 352, column: 38, scope: !607)
!617 = !DILocation(line: 352, column: 56, scope: !607)
!618 = !DILocation(line: 352, column: 12, scope: !607)
!619 = !DILocation(line: 352, column: 5, scope: !607)
!620 = distinct !DISubprogram(name: "extract_footer", scope: !3, file: !3, line: 411, type: !621, isLocal: true, isDefinition: true, scopeLine: 411, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !623)
!621 = !DISubroutineType(types: !622)
!622 = !{!7, !7}
!623 = !{!624}
!624 = !DILocalVariable(name: "word", arg: 1, scope: !620, file: !3, line: 411, type: !7)
!625 = !DILocation(line: 411, column: 37, scope: !620)
!626 = !DILocation(line: 412, column: 18, scope: !620)
!627 = !DILocation(line: 412, column: 5, scope: !620)
!628 = distinct !DISubprogram(name: "delete_seg_list", scope: !3, file: !3, line: 718, type: !629, isLocal: true, isDefinition: true, scopeLine: 718, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !631)
!629 = !DISubroutineType(types: !630)
!630 = !{null, !12}
!631 = !{!632, !633, !634, !635}
!632 = !DILocalVariable(name: "block", arg: 1, scope: !628, file: !3, line: 718, type: !12)
!633 = !DILocalVariable(name: "idx", scope: !628, file: !3, line: 720, type: !31)
!634 = !DILocalVariable(name: "prev_block", scope: !628, file: !3, line: 721, type: !12)
!635 = !DILocalVariable(name: "next_block", scope: !628, file: !3, line: 722, type: !12)
!636 = !DILocation(line: 718, column: 38, scope: !628)
!637 = !DILocation(line: 721, column: 34, scope: !628)
!638 = !DILocation(line: 721, column: 14, scope: !628)
!639 = !DILocation(line: 722, column: 34, scope: !628)
!640 = !DILocation(line: 722, column: 14, scope: !628)
!641 = !DILocation(line: 725, column: 20, scope: !642)
!642 = distinct !DILexicalBlock(scope: !628, file: !3, line: 725, column: 9)
!643 = !DILocation(line: 0, scope: !644)
!644 = distinct !DILexicalBlock(scope: !642, file: !3, line: 736, column: 14)
!645 = !DILocation(line: 725, column: 9, scope: !628)
!646 = !DILocation(line: 720, column: 34, scope: !628)
!647 = !DILocation(line: 720, column: 18, scope: !628)
!648 = !DILocation(line: 720, column: 12, scope: !628)
!649 = !DILocation(line: 0, scope: !650)
!650 = distinct !DILexicalBlock(scope: !651, file: !3, line: 729, column: 16)
!651 = distinct !DILexicalBlock(scope: !652, file: !3, line: 726, column: 13)
!652 = distinct !DILexicalBlock(scope: !642, file: !3, line: 725, column: 29)
!653 = !DILocation(line: 726, column: 13, scope: !652)
!654 = !DILocation(line: 728, column: 27, scope: !655)
!655 = distinct !DILexicalBlock(scope: !651, file: !3, line: 726, column: 33)
!656 = !DILocation(line: 729, column: 9, scope: !655)
!657 = !DILocation(line: 731, column: 27, scope: !650)
!658 = !DILocation(line: 732, column: 25, scope: !650)
!659 = !DILocation(line: 732, column: 36, scope: !650)
!660 = !DILocation(line: 736, column: 14, scope: !642)
!661 = !DILocation(line: 738, column: 21, scope: !662)
!662 = distinct !DILexicalBlock(scope: !644, file: !3, line: 736, column: 34)
!663 = !DILocation(line: 738, column: 32, scope: !662)
!664 = !DILocation(line: 739, column: 5, scope: !662)
!665 = !DILocation(line: 743, column: 21, scope: !666)
!666 = distinct !DILexicalBlock(scope: !644, file: !3, line: 741, column: 10)
!667 = !DILocation(line: 743, column: 32, scope: !666)
!668 = !DILocation(line: 744, column: 21, scope: !666)
!669 = !DILocation(line: 744, column: 32, scope: !666)
!670 = !DILocation(line: 750, column: 1, scope: !628)
!671 = !DILocation(line: 749, column: 23, scope: !628)
!672 = distinct !DISubprogram(name: "add_seg_list", scope: !3, file: !3, line: 763, type: !294, isLocal: true, isDefinition: true, scopeLine: 763, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !673)
!673 = !{!674, !675, !676}
!674 = !DILocalVariable(name: "block", arg: 1, scope: !672, file: !3, line: 763, type: !12)
!675 = !DILocalVariable(name: "size", arg: 2, scope: !672, file: !3, line: 763, type: !31)
!676 = !DILocalVariable(name: "seg_index", scope: !672, file: !3, line: 765, type: !31)
!677 = !DILocation(line: 763, column: 35, scope: !672)
!678 = !DILocation(line: 763, column: 49, scope: !672)
!679 = !DILocation(line: 765, column: 24, scope: !672)
!680 = !DILocation(line: 765, column: 12, scope: !672)
!681 = !DILocation(line: 768, column: 9, scope: !682)
!682 = distinct !DILexicalBlock(scope: !672, file: !3, line: 768, column: 9)
!683 = !DILocation(line: 768, column: 29, scope: !682)
!684 = !DILocation(line: 0, scope: !685)
!685 = distinct !DILexicalBlock(scope: !682, file: !3, line: 776, column: 10)
!686 = !DILocation(line: 768, column: 9, scope: !672)
!687 = !DILocation(line: 772, column: 16, scope: !688)
!688 = distinct !DILexicalBlock(scope: !682, file: !3, line: 768, column: 38)
!689 = !DILocation(line: 772, column: 27, scope: !688)
!690 = !DILocation(line: 774, column: 5, scope: !688)
!691 = !DILocation(line: 779, column: 29, scope: !685)
!692 = !DILocation(line: 779, column: 16, scope: !685)
!693 = !DILocation(line: 779, column: 27, scope: !685)
!694 = !DILocation(line: 780, column: 30, scope: !685)
!695 = !DILocation(line: 780, column: 41, scope: !685)
!696 = !DILocation(line: 0, scope: !688)
!697 = !DILocation(line: 783, column: 1, scope: !672)
!698 = distinct !DISubprogram(name: "get_alloc", scope: !3, file: !3, line: 399, type: !699, isLocal: true, isDefinition: true, scopeLine: 399, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !701)
!699 = !DISubroutineType(types: !700)
!700 = !{!36, !12}
!701 = !{!702}
!702 = !DILocalVariable(name: "block", arg: 1, scope: !698, file: !3, line: 399, type: !12)
!703 = !DILocation(line: 399, column: 32, scope: !698)
!704 = !DILocation(line: 400, column: 33, scope: !698)
!705 = !DILocation(line: 400, column: 12, scope: !698)
!706 = !DILocation(line: 400, column: 5, scope: !698)
!707 = distinct !DISubprogram(name: "find_prev", scope: !3, file: !3, line: 521, type: !369, isLocal: true, isDefinition: true, scopeLine: 521, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !708)
!708 = !{!709, !710}
!709 = !DILocalVariable(name: "block", arg: 1, scope: !707, file: !3, line: 521, type: !12)
!710 = !DILocalVariable(name: "footerp", scope: !707, file: !3, line: 523, type: !6)
!711 = !DILocation(line: 521, column: 36, scope: !707)
!712 = !DILocation(line: 523, column: 23, scope: !707)
!713 = !DILocation(line: 523, column: 13, scope: !707)
!714 = !DILocation(line: 526, column: 22, scope: !715)
!715 = distinct !DILexicalBlock(scope: !707, file: !3, line: 526, column: 9)
!716 = !DILocation(line: 526, column: 9, scope: !715)
!717 = !DILocation(line: 526, column: 32, scope: !715)
!718 = !DILocation(line: 526, column: 9, scope: !707)
!719 = !DILocation(line: 530, column: 12, scope: !707)
!720 = !DILocation(line: 530, column: 5, scope: !707)
!721 = !DILocation(line: 0, scope: !707)
!722 = !DILocation(line: 531, column: 1, scope: !707)
!723 = distinct !DISubprogram(name: "extract_alloc", scope: !3, file: !3, line: 390, type: !724, isLocal: true, isDefinition: true, scopeLine: 390, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !726)
!724 = !DISubroutineType(types: !725)
!725 = !{!36, !7}
!726 = !{!727}
!727 = !DILocalVariable(name: "word", arg: 1, scope: !723, file: !3, line: 390, type: !7)
!728 = !DILocation(line: 390, column: 34, scope: !723)
!729 = !DILocation(line: 391, column: 24, scope: !723)
!730 = !DILocation(line: 391, column: 12, scope: !723)
!731 = !DILocation(line: 391, column: 5, scope: !723)
!732 = distinct !DISubprogram(name: "find_prev_footer", scope: !3, file: !3, line: 501, type: !608, isLocal: true, isDefinition: true, scopeLine: 501, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !733)
!733 = !{!734}
!734 = !DILocalVariable(name: "block", arg: 1, scope: !732, file: !3, line: 501, type: !12)
!735 = !DILocation(line: 501, column: 42, scope: !732)
!736 = !DILocation(line: 503, column: 21, scope: !732)
!737 = !DILocation(line: 503, column: 29, scope: !732)
!738 = !DILocation(line: 503, column: 5, scope: !732)
!739 = distinct !DISubprogram(name: "footer_to_header", scope: !3, file: !3, line: 362, type: !740, isLocal: true, isDefinition: true, scopeLine: 362, flags: DIFlagPrototyped, isOptimized: true, unit: !2, retainedNodes: !742)
!740 = !DISubroutineType(types: !741)
!741 = !{!12, !6}
!742 = !{!743, !744}
!743 = !DILocalVariable(name: "footer", arg: 1, scope: !739, file: !3, line: 362, type: !6)
!744 = !DILocalVariable(name: "size", scope: !739, file: !3, line: 363, type: !31)
!745 = !DILocation(line: 362, column: 42, scope: !739)
!746 = !DILocation(line: 363, column: 32, scope: !739)
!747 = !DILocation(line: 363, column: 19, scope: !739)
!748 = !DILocation(line: 363, column: 12, scope: !739)
!749 = !DILocation(line: 365, column: 39, scope: !739)
!750 = !DILocation(line: 365, column: 47, scope: !739)
!751 = !DILocation(line: 365, column: 12, scope: !739)
!752 = !DILocation(line: 365, column: 5, scope: !739)
