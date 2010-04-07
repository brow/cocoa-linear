#import "CLVector.h"
#import <math.h>

/* Cross product for 3D vectors */
CLVector CLVectorCrossProduct(CLVector a, CLVector b) {
	CLVector ret = {	a.y * b.z - a.z * b.y,
		a.z * b.x - a.x * b.z,
	a.x * b.y - a.y * b.x };
	return ret;
}

/* Dot product for 3D vectors */
double CLVectorDotProduct(CLVector a, CLVector b) {
	return a.x * b.x + a.y * b.y + a.z * b.z;
}

/* Normalize a 3D vector; find the unit vector for the given vector. */
CLVector CLVectorNormalize(CLVector src) {
	double norm = sqrt(CLVectorDotProduct(src,src));
	return CLVectorMultiplyScalar(src, 1/norm);
}

/* Scalar multiply a 3D vector. */
CLVector CLVectorMultiplyScalar(CLVector src, double scale) {
	CLVector ret = {	src.x * scale,
		src.y * scale,
	src.z * scale };
	return ret;
}

/* Subtract. */
CLVector CLVectorSubtract(const CLVector a, const CLVector b) {
	CLVector ret = {	a.x - b.x,
		a.y - b.y,
	a.z - b.z };
	return ret;
}

/* Angle between 3D vectors (in degrees) */
double CLVectorAngle(const CLVector a, const CLVector b) {
	double len_a = sqrt(CLVectorDotProduct(a,a));
	double len_b = sqrt(CLVectorDotProduct(b,b));
	double tmp = CLVectorDotProduct(a,b)/(len_a*len_b);
	
	if (tmp < 1)
		return acos(tmp) * 180.0 / M_PI;
	else
		return 0;
}

/* Angle between 3D vectors (in degrees) after projecting onto a plane. */
double CLVectorAngleWRTPlane(const CLVector a, const CLVector b, const CLVector normal) {
	CLVector nrm, proj_on_nrm, perp_a, perp_b, check;
	nrm = CLVectorNormalize(normal);
	
	proj_on_nrm = CLVectorMultiplyScalar(nrm, CLVectorDotProduct(a, nrm));
	perp_a = CLVectorSubtract(a, proj_on_nrm);
	
	proj_on_nrm = CLVectorMultiplyScalar(nrm, CLVectorDotProduct(b, nrm));
	perp_b = CLVectorSubtract(b, proj_on_nrm);
	
	check = CLVectorCrossProduct(a, b);
	if (CLVectorDotProduct(normal, check) > 0)
		return CLVectorAngle(perp_a, perp_b);
	else
		return -CLVectorAngle(perp_a, perp_b);
}