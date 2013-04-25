使用 sympy 解聯立方程組
=======================

4x + 3y + 3z = 350

4x + 2y + 5z = 360

8x + 8y + 10z = 840

::

    from sympy import *

    x = Symbol('x')
    y = Symbol('y')
    z = Symbol('z')

    f1 = 4*x + 3*y + 3*z - 350 
    f2 = 4*x + 2*y + 5*z - 360 
    f3 = 8*x + 8*y + 10*z - 840 

    sol = solve((f1, f2, f3), x, y, z)
    pprint(sol)                               
    # OUT: {x: 50, y: 30, z: 20}

