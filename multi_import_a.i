%module(package="multi_import") multi_import_a


%{
#include "yyy.h"
%}

%include yyy.h
