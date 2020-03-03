NB. session definitions for view

NB.*vd v view driver
NB.*view v cover for vd

load 'graphics/view/jzview'
coclass 'jwview'
coinsert 'jzview'

NB. =========================================================
NB. z locale definitions
vd_z_=: 3 : 0
caller_jwview_=. coname''
vd_jwview_ y
)

view_z_=: 3 : 0
'' view_jwview_ y
:
caller_jwview_=. coname''
x view_jwview_ y
)
