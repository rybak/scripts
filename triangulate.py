#!/usr/bin/env python3

# Ax+Bz+C=0
# A*x1+B*z1+C=0
# A*x2+B*z2+C=0
# A*(x1-x2) = -B*(z1-z2)
# A/B=(z2-z1)/(x1-x2)

# C=-A*x-B*z

x1=431
z1=-248
x2=430
z2=-267
x3=-86
z3=-302
x4=-81
z4=-317

A1 = (z2-z1)/(x1-x2)
B1 = 1.0
C1 = -A1 * x1 - B1 * z1

A2 = (z4-z3)/(x3-x4)
B2 = 1.0
C2 = -A2 * x3 - B2 * z3

# A1x+B1z+C1=A2x+B2z+C2
# A1x+B1z+C1=0
# A2x+B2z+C2=0

x = (B1*C2 - B2*C1) / (A1*B2 - A2*B1)
z = (C1*A2 - C2*A1) / (A1*B2 - A2*B1)

print("x = {:7.2f} | z = {:7.2f}".format(x, z))
