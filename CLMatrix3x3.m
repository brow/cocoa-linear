#import "CLMatrix3x3.h"

int compareFloats(const void *a, const void *b);

CLMatrix3x3 CLMatrix3x3Zero() {
	const CLMatrix3x3 zero = {	0, 0, 0,
								0, 0, 0,
								0, 0, 0 };
	return zero;
}

CLMatrix3x3 CLMatrix3x3Identity() {
	const CLMatrix3x3 ident = {	1, 0, 0,
								0, 1, 0,
								0, 0, 1 };
	return ident;
}

BOOL CLMatrix3x3IsOrthonormal(CLMatrix3x3 m) {
	const double threshold = 1e-7;
	CLVector a = {m.m11, m.m21, m.m31};
	CLVector b = {m.m12, m.m22, m.m32};
	CLVector c = {m.m13, m.m23, m.m33};
	if (	CLVectorDotProduct(a, b) < threshold  &&
			CLVectorDotProduct(b, c) < threshold  &&
			CLVectorDotProduct(a, c) < threshold  &&
			abs(CLVectorDotProduct(a, a)-1) < threshold &&
			abs(CLVectorDotProduct(b, b)-1) < threshold &&
			abs(CLVectorDotProduct(c, c)-1) < threshold
	)
		return YES;
	else
		return NO;
}

double CLMatrix3x3Determinant(CLMatrix3x3 m) {
	return	m.m11 * m.m22 * m.m33 
			- m.m11 * m.m23 * m.m32
			+ m.m12 * m.m23 * m.m31
			- m.m12 * m.m21 * m.m33
			+ m.m13 * m.m21 * m.m32
			- m.m13 * m.m22 * m.m31;
}

CLMatrix3x3 CLMatrix3x3Transpose(CLMatrix3x3 m) {
	CLMatrix3x3 ret = m;
	ret.m12 = m.m21;
	ret.m13 = m.m31;
	ret.m21 = m.m12;
	ret.m23 = m.m32;
	ret.m31 = m.m13;
	ret.m32 = m.m23;
	return ret;
}

CLMatrix3x3 CLMatrix3x3Multiply(CLMatrix3x3 a, CLMatrix3x3 b) {
	CLMatrix3x3 ret;
	ret.m11 = a.m11 * b.m11 + a.m12 * b.m21 + a.m13 * b.m31;
	ret.m12 = a.m11 * b.m12 + a.m12 * b.m22 + a.m13 * b.m32;
	ret.m13 = a.m11 * b.m13 + a.m12 * b.m23 + a.m13 * b.m33;
	ret.m21 = a.m21 * b.m11 + a.m22 * b.m21 + a.m23 * b.m31;
	ret.m22 = a.m21 * b.m12 + a.m22 * b.m22 + a.m23 * b.m32;
	ret.m23 = a.m21 * b.m13 + a.m22 * b.m23 + a.m23 * b.m33;
	ret.m31 = a.m31 * b.m11 + a.m32 * b.m21 + a.m33 * b.m31;
	ret.m32 = a.m31 * b.m12 + a.m32 * b.m22 + a.m33 * b.m32;
	ret.m33 = a.m31 * b.m13 + a.m32 * b.m23 + a.m33 * b.m33;
	return ret;
}

double CLMatrix3x3Trace(CLMatrix3x3 m) {
	return m.m11 + m.m22 + m.m33;
}

CLMatrix3x3 CLMatrix3x3Add(CLMatrix3x3 a, CLMatrix3x3 b) {
	CLMatrix3x3 ret;
	ret.m11 = a.m11 + b.m11;
	ret.m12 = a.m12 + b.m12;
	ret.m13 = a.m13 + b.m13;
	ret.m21 = a.m21 + b.m21;
	ret.m22 = a.m22 + b.m22;
	ret.m23 = a.m23 + b.m23;
	ret.m31 = a.m31 + b.m31;
	ret.m32 = a.m32 + b.m32;
	ret.m33 = a.m33 + b.m33;
	return ret;
}

CLMatrix3x3 CLMatrix3x3Subtract(CLMatrix3x3 a, CLMatrix3x3 b) {
	CLMatrix3x3 ret;
	ret.m11 = a.m11 - b.m11;
	ret.m12 = a.m12 - b.m12;
	ret.m13 = a.m13 - b.m13;
	ret.m21 = a.m21 - b.m21;
	ret.m22 = a.m22 - b.m22;
	ret.m23 = a.m23 - b.m23;
	ret.m31 = a.m31 - b.m31;
	ret.m32 = a.m32 - b.m32;
	ret.m33 = a.m33 - b.m33;
	return ret;
}

CLMatrix3x3 CLMatrix3x3MultiplyScalar(CLMatrix3x3 a, double c) {
	CLMatrix3x3 ret;
	ret.m11 = a.m11*c;
	ret.m12 = a.m12*c;
	ret.m13 = a.m13*c;
	ret.m21 = a.m21*c;
	ret.m22 = a.m22*c;
	ret.m23 = a.m23*c;
	ret.m31 = a.m31*c;
	ret.m32 = a.m32*c;
	ret.m33 = a.m33*c;
	return ret;
}

void CLMatrix3x3Eigenvalues(CLMatrix3x3 mat, double eigenvalues[3]) {
	/* 
	 * Eigenvalues are the roots of the characteristic polynomial for the given matrix.
	 * Real roots are returned in descending order. Non-real roots are replaced by zeros.
	 */
	double a = -1;
	double b = CLMatrix3x3Trace(mat);
	double c = 0.5 * (CLMatrix3x3Trace(CLMatrix3x3Multiply(mat, mat)) - b*b);
	double d = CLMatrix3x3Determinant(mat);
	double x = (3*c/a - pow(b,2)/pow(a,2))/3;
	double y = (2*pow(b,3)/pow(a,3) - 9*b*c/pow(a,2) + 27*d/a)/27;
	double z = pow(y,2)/4 + pow(x,3)/27;
	if (z <= 0) {
		/* 3 real eigenvalues. */
		double i = sqrt(pow(y,2)/4 - z);
		double j = cbrt(i);
		double k = acos(-y/(2*i));
		double m = cos(k/3);
		double n = sqrt(3)*sin(k/3);
		double p = -(b/(3*a));
		eigenvalues[0] = 2 * j * m + p;
		eigenvalues[1] = -j * (m + n) + p;
		eigenvalues[2] = -j * (m - n) + p;
	} else {
		/* 1 real eigenvalue. */
		double r = -y/2 + sqrt(z);
		double s = cbrt(r);
		double t = -y/2 - sqrt(z);
		double u = cbrt(t);
		eigenvalues[0] = s + u - b/(3*a);
		eigenvalues[1] = 0;
		eigenvalues[2] = 0;
	}
	qsort(eigenvalues, 3, sizeof(double), compareFloats);
}

void CLMatrix3x3SymmetricEigenvectors(CLMatrix3x3 m, double eigenvalues[3], CLVector eigenvectors[3]) {
	/* This algorithm only generates correct eigenvectors if m is symmetric. */
	CLMatrix3x3Eigenvalues(m, eigenvalues);
	for (int i = 0; i < 3; i++) {
		double r = eigenvalues[i];
		eigenvectors[i].x = m.m12 * m.m23 - m.m13 * (m.m22 - r);
		eigenvectors[i].y = m.m12 * m.m13 - m.m23 * (m.m11 - r);
		eigenvectors[i].z = (m.m11 - r) * (m.m22 - r) - m.m12 * m.m12;
		eigenvectors[i] = CLVectorNormalize(eigenvectors[i]);
	}
}

CLMatrix3x3 CLMatrix3x1Multiply1x3(CLVector a, CLVector b) {
	/* a and b are column vectors. Return A transpose(B). */
	CLMatrix3x3 ret;
	ret.m11 = a.x * b.x;
	ret.m12 = a.x * b.y;
	ret.m13 = a.x * b.z;
	ret.m21 = a.y * b.x;
	ret.m22 = a.y * b.y;
	ret.m23 = a.y * b.z;
	ret.m31 = a.z * b.x;
	ret.m32 = a.z * b.y;
	ret.m33 = a.z * b.z;
	return ret;
}

int compareFloats(const void *a, const void *b)
{
	double temp = *(double *)a - *(double *)b;
	if (temp > 0)
		return 1;
	else if (temp < 0)
		return -1;
	else
		return 0;
}