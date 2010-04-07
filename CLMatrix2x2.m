#import "CLMatrix2x2.h"

void CLMatrix2x2Transpose(const double src[4], double dst[4]) {
	dst[0] = src[0];
	dst[1] = src[2];
	dst[2] = src[1];
	dst[3] = src[3];
}

void CLMatrix2x2MultiplyScalar(const double src[4], double c, double dst[4]) {
	dst[0] = c*src[0];
	dst[1] = c*src[1];
	dst[2] = c*src[2];
	dst[3] = c*src[3];
}

void CLMatrix2x1Multiply1x2(const double a[2], const double b[2], double dst[4]) {
	dst[0] = a[0] * b[0];
	dst[1] = a[0] * b[1];
	dst[2] = a[1] * b[0];
	dst[3] = a[1] * b[1];
}

void CLMatrix2x2Multiply2x1(const double a[4], const double b[2], double dst[2]) {
	dst[0] = a[0] * b[0] + a[1] * b[1];
	dst[1] = a[2] * b[0] + a[3] * b[1];
}

CGPoint CLMatrix2x2Transform(const double m[4], CGPoint p) {
	double pArr[2] = {p.x, p.y}, retArr[2];
	CLMatrix2x2Multiply2x1(m, pArr, retArr);
	return CGPointMake(retArr[0], retArr[1]);
}

void CLMatrix2x2Multiply(const double a[4], const double b[4], double dst[4]) {
	dst[0] = a[0] * b[0] + a[1] * b[2]; 
	dst[1] = a[0] * b[1] + a[1] * b[3];
	dst[2] = a[2] * b[0] + a[3] * b[2];
	dst[3] = a[2] * b[1] + a[3] * b[3];
}

void CLMatrix2x2Add(const double a[4], const double b[4], double dst[4]) {
	dst[0] = a[0] + b[0];
	dst[1] = a[1] + b[1];
	dst[2] = a[2] + b[2];
	dst[3] = a[3] + b[3];
}

void CLMatrix2x2Eigenvectors(const double m[4], double *l1, double *l2, double u1[2], double u2[2]) {
	/* Find eigenvalues. */
	double trace = m[0] + m[3];
	double det = m[0] * m[3] - m[1] * m[2];
	*l1 = trace/2 + sqrt(pow(trace,2) / 4 - det);
	*l2 = trace/2 - sqrt(pow(trace,2) / 4 - det);
	
	/* Find eigenvectors. */
	if (m[2] != 0) {
		u1[0] = *l1 - m[3];
		u1[1] = m[2];
		u2[0] = *l2 - m[3];
		u2[1] = m[2];
	}
	else if (m[1] != 0) {
		u1[0] = m[1];
		u1[1] = *l1 - m[0];
		u2[0] = m[1];
		u2[1] = *l2 - m[0];
	}
	else {
		u1[0] = 1;
		u1[1] = 0;
		u2[0] = 0;
		u2[1] = 1;
	}
	
	/* Unitize eigenvectors. */
	double normU1 = sqrt(pow(u1[0],2)+pow(u1[1],2));
	double normU2 = sqrt(pow(u2[0],2)+pow(u2[1],2));
	u1[0] /= normU1;
	u1[1] /= normU1;
	u2[0] /= normU2;
	u2[1] /= normU2;
}
