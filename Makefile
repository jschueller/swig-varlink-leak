
all: multi_import

multi_import: multi_import_a.i multi_import_b.i xxx.h yyy.h multi_import_runme.py __init__.py
	mkdir -p multi_import
	~/projects/swig/install/bin/swig -python  -c++ -outdir multi_import -I. -o multi_import_a_wrap.cxx ./multi_import_a.i
	g++ -c -O1 -g -fsanitize=address -fno-omit-frame-pointer -fPIC -I. -I./ -I/usr/include  multi_import_a_wrap.cxx   -I.  -I/usr/include/python3.8 -I/usr/lib/python3.8/config
	g++ -shared  -I/usr/include multi_import_a_wrap.o -o multi_import/_multi_import_a.so
	~/projects/swig/install/bin/swig -python  -c++ -outdir multi_import -I. -o multi_import_b_wrap.cxx ./multi_import_b.i
	g++ -c -O1 -g -fsanitize=address -fno-omit-frame-pointer -fPIC -I. -I./ -I/usr/include  multi_import_b_wrap.cxx   -I.  -I/usr/include/python3.8 -I/usr/lib/python3.8/config
	g++  -shared  -I/usr/include  multi_import_b_wrap.o -o multi_import/_multi_import_b.so
	cp __init__.py multi_import
	LD_PRELOAD=`gcc -print-file-name=libasan.so` python3 ./multi_import_runme.py
