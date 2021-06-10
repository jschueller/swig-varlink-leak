
all: python3

swig:
	~/projects/swig/install/bin/swig -python -c++ example.i
	swig -python -c++ example.i
python2: swig
	g++ -O1 -g -fsanitize=address -fno-omit-frame-pointer -fPIC -shared -o _example.so example_wrap.cxx -I/usr/include/python2.7
	LD_PRELOAD=`gcc -print-file-name=libasan.so` python2 test_example.py
python3: swig
	g++ -O1 -g -fsanitize=address -fno-omit-frame-pointer -fPIC -shared -o _example.so example_wrap.cxx -I/usr/include/python3.8
	LD_PRELOAD=`gcc -print-file-name=libasan.so` python3 test_example.py
