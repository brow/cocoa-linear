void CLMatrix2x2Transpose(const double *src, double *dst);

void CLMatrix2x2Multiply(const double *a, const double* b, double *dst);

void CLMatrix2x2Eigenvectors(const double m[4], double *l1, double *l2, double u1[2], double u2[2]);

void CLMatrix2x2MultiplyScalar(const double src[4], double c, double dst[4]);

void CLMatrix2x1Multiply1x2(const double a[2], const double b[2], double dst[4]);

void CLMatrix2x2Multiply2x1(const double a[4], const double b[2], double dst[2]);

CGPoint CLMatrix2x2Transform(const double m[4], CGPoint p);

void CLMatrix2x2Add(const double a[4], const double b[4], double dst[4]);