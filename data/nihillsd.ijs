Note ''
R
> library(DAAG)
> nihills
)


nihills0 =: 0 : 0
                        dist climb      time     timef
Binevenagh               7.5  1740 0.8583333 1.0644444
Slieve Gullion           4.2  1110 0.4666667 0.6230556
Glenariff Mountain       5.9  1210 0.7030556 0.8869444
Donard & Commedagh       6.8  3300 1.0386111 1.2141667
McVeigh Classic          5.0  1200 0.5411111 0.6375000
Tollymore Mountain       4.8   950 0.4833333 0.5886111
Slieve Martin            4.3  1600 0.5505556 0.7016667
Moughanmore              3.0  1500 0.4636111 0.6475000
Hen & Cock               2.5  1500 0.4497222 0.6075000
Annalong Horseshoe      12.0  5080 1.9491667 2.4805556
Monument Race            4.0  1000 0.4716667 0.5947222
Loughshannagh Horseshoe  4.3  1700 0.6469444 0.8822222
Rocky                    4.0  1300 0.5230556 0.6652778
Meelbeg Meelmore         3.5  1800 0.4544444 0.6086111
Donard Forest            4.5  1400 0.5186111 0.6433333
Slieve Donard            5.5  2790 0.9483333 1.2086111
Flagstaff to Carling    11.0  3000 1.4569444 2.0344444
Slieve Bearnagh          4.0  2690 0.6877778 0.7991667
Seven Sevens            18.9  8775 3.9027778 5.9855556
Lurig Challenge          4.0  1000 0.4347222 0.5755556
Scrabo Hill Race         2.9   750 0.3247222 0.4091667
Slieve Gallion           4.6  1440 0.6361111 0.7494444
BARF Turkey Trot         5.7  1430 0.7130556 0.9383333
)

$nihills0

nihillsd =: }:"1  ]}.  24 55 $ nihills0
nihillst =: 23 {."1 nihillsd
nihills  =: ". 23 }."1 nihillsd
'dist climb  time timef' =: |: nihills

lognihills  =: ^. ". 23 }."1 nihillsd
'ldist lclimb  ltime ltimef' =: |: lognihills
grad  =: climb % dist
lgrad =: ^. grad
varcap =: ' "dist" "climb" "time" "timef" ;'

