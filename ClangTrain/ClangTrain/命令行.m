clang -fmodules  main.m -o main//可执行文件
clang -S main.m -o main.s//汇编
clang -fmodules -fsyntax-only -Xclang -ast-dump main.m//语法树
clang -E main.m -o xx.m//库引入的显示
