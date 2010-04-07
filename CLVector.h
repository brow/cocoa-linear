typedef struct  {
	double x, y, z;
} CLVector;

CLVector CLVectorCrossProduct(CLVector a, CLVector b);

double CLVectorDotProduct(CLVector a, CLVector b);

CLVector CLVectorNormalize(CLVector src);

CLVector CLVectorMultiplyScalar(CLVector src, double scale);

CLVector CLVectorSubtract(const CLVector a, const CLVector b);

double CLVectorAngle(const CLVector a, const CLVector b);

double CLVectorAngleWRTPlane(const CLVector a, const CLVector b, const CLVector normal);
