%module(package="multi_import") multi_import_a

%import multi_import_b.i

%{
#include "yyy.h"
%}

%include yyy.h
