NB.  some regression tests

load 'c:/users/frasert/j901-user/projects/jsoftware/reg10e.ijs'

NB. cocurrent 'testr'


NB.  Data
NB.  dobson and Barnett p 96 Diet data

Carbs =: 33 40 37 27 30 43 34 48 30 38 50 51 30 36 41 42 46 24 35 37
age =:  33 47 49 35 46 52 62 23 32 42 31 61 63 40 50 64 56 61 48 28
weight=: 100 92 135 144 140 101 95 101 98 105 108 85 130 127 109  
weight =: weight, 107 117 100 118 102
protein =:14 15 18 12 15 15 14 17 15 14 17 19 19 20 15 16 18 13 18 14
 
Carbdiet =: 'Carbs age weight protein';Carbs;age;weight;protein

awp =: age,.weight,.protein
xtx =: (t 1,.awp) mp (1,.awp)


