#import "CLVector.h"

typedef struct  {
	double m11, m12, m13;
	double m21, m22, m23;
	double m31, m32, m33;
} CLMatrix3x3;

CLMatrix3x3 CLMatrix3x3Zero();

CLMatrix3x3 CLMatrix3x3Identity();

BOOL CLMatrix3x3IsOrthonormal(CLMatrix3x3 m);

double CLMatrix3x3Determinant(CLMatrix3x3 m);

CLMatrix3x3 CLMatrix3x3Transpose(CLMatrix3x3 m);

CLMatrix3x3 CLMatrix3x3Multiply(CLMatrix3x3 a, CLMatrix3x3 b);

CLMatrix3x3 CLMatrix3x3MultiplyScalar(CLMatrix3x3 a, double c);

double CLMatrix3x3Trace(CLMatrix3x3 m);

CLMatrix3x3 CLMatrix3x3Add(CLMatrix3x3 a, CLMatrix3x3 b);

CLMatrix3x3 CLMatrix3x3Subtract(CLMatrix3x3 a, CLMatrix3x3 b);

void CLMatrix3x3Eigenvalues(CLMatrix3x3 m, double eigenvalues[3]);

void CLMatrix3x3SymmetricEigenvectors(CLMatrix3x3 m, double eigenvalues[3], CLVector eigenvectors[3]);

CLMatrix3x3 CLMatrix3x1Multiply1x3(CLVector a, CLVector b);