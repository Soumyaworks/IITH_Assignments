#!/bin/bash

llvm_path='/home/cselab/llvm-project/build/bin'
echo "$llvm_path";

for file in *.c; do
	echo "$file";
	#echo ${file%.*}.ll;
	subdir=${file%%.*}
	mkdir -- "$subdir"
	mv -- "$file" "$subdir"
done

for dir in */; do
	echo $dir;
	cd $dir
	for file in *.c; do
		echo "$file";
		#echo ${file%*c}ll;
		#subdir=${file%%.*}
		#mkdir -- "$subdir"
		#mv -- "$file" "$subdir"
		
		# Creating the .ll, .s and a.out files
		echo "Creating the .ll, .s and a.out files for ${file}";
		
		#clang_path="${llvm_path}/clang"
		#echo "******"
		#echo $clang_path
		${llvm_path}/clang $file -S -emit-llvm
		${llvm_path}/clang $file -S
		${llvm_path}/clang $file
		
		#~/llvm-project/build/bin/clang $file -S -emit-llvm
		#~/llvm-project/build/bin/clang $file -S
		#~/llvm-project/build/bin/clang $file
		
		
		# Applying different levels of optimization
		echo "Applying different levels of optimization for ${file}";
		
		${llvm_path}/clang $file -S -emit-llvm -O1 -o ${file%.*}_O1.ll
		${llvm_path}/clang $file -S -emit-llvm -O2 -o ${file%.*}_O2.ll
		${llvm_path}/clang $file -S -emit-llvm -O3 -o ${file%.*}_O3.ll
		${llvm_path}/clang $file -S -emit-llvm -Os -o ${file%.*}_Os.ll
		${llvm_path}/clang $file -S -emit-llvm -Oz -o ${file%.*}_Oz.ll
		
		# Generating the dom tree and cfg
		
		echo "Generating the dom-tree and cfg for ${file}";
		
		${llvm_path}/opt -enable-new-pm=0 -dot-dom ${file%*c}ll
		${llvm_path}/opt -enable-new-pm=0 -dot-cfg ${file%*c}ll -o cfg.main.dot
		
		# Adding view-cfg as -dot-cfg was not working in my case
		${llvm_path}/opt -enable-new-pm=0 -view-cfg ${file%*c}ll
		
		echo "Applying dce and sccp for ${file}";
		
		# Applying dce
		${llvm_path}/opt -enable-new-pm=0 -dce ${file%.*}.ll -o ${file%.*}_dce.bc
		# Using disassembler to convert to human readable format
		${llvm_path}/llvm-dis ./${file%.*}_dce.bc -o ./${file%.*}_dce.ll
		
		#Applying sccp
		${llvm_path}/opt -enable-new-pm=0 -sccp ${file%.*}_dce.ll -o ${file%.*}_sccp.bc
		${llvm_path}/llvm-dis ./${file%.*}_sccp.bc -o ./${file%.*}_sccp.ll
		
		
	done
	cd ..
done
