#import "CLConversions.h"

CATransform3D Matrix3x3ToCATransform3D(CLMatrix3x3 m) {
	CATransform3D ret = CATransform3DIdentity;
	ret.m11 = m.m11;
	ret.m12 = m.m12;
	ret.m13 = m.m13;
	ret.m21 = m.m21;
	ret.m22 = m.m22;
	ret.m23 = m.m23;
	ret.m31 = m.m31;
	ret.m32 = m.m32;
	ret.m33 = m.m33;
	return ret;
}

CLMatrix3x3 Matrix3x3FromCATransform3D(CATransform3D t) {
	CLMatrix3x3 ret;
	ret.m11 = t.m11;
	ret.m12 = t.m12;
	ret.m13 = t.m13;
	ret.m21 = t.m21;
	ret.m22 = t.m22;
	ret.m23 = t.m23;
	ret.m31 = t.m31;
	ret.m32 = t.m32;
	ret.m33 = t.m33;
	return ret;
}

CLQuaternion QuaternionFromCATransform3D(CATransform3D q) {
	float max = MAX(MAX(fabs(q.m11), fabs(q.m22)), fabs(q.m33));
	CLQuaternion ret;
	double r;
	
	if (max == fabs(q.m11)) {
		r = sqrt(1.0 + (q.m11 - q.m22) - q.m33);
		ret.w = (q.m32 - q.m23) / (2*r);
		ret.x = r / 2;
		ret.y = (q.m12 + q.m21) / (2*r);
		ret.z = (q.m31 + q.m13) / (2*r);
	}
	else if (max == fabs(q.m22)) {
		r = sqrt(1.0 + (q.m22 - q.m33) - q.m11);
		ret.w = (q.m13 - q.m31) / (2*r);
		ret.y = r / 2;
		ret.z = (q.m23 + q.m32) / (2*r);
		ret.x = (q.m12 + q.m21) / (2*r);
	}
	else if (max == fabs(q.m33)) {
		r = sqrt(1.0 + (q.m33 - q.m11) - q.m22);
		ret.w = (q.m21 - q.m12) / (2*r);
		ret.z = r / 2;
		ret.x = (q.m31 + q.m13) / (2*r);
		ret.y = (q.m23 + q.m32) / (2*r);
	}
	else
		assert(false);
	
	if (r < 0.05) {
		double trace = q.m11 + q.m22 + q.m33 + 1;
		double s = 0.5 / sqrt(trace);
		ret.w = 0.25 / s;
		double d = 4 * ret.w;
		ret.x = (q.m32 - q.m23)/d;
		ret.y = (q.m13 - q.m31)/d;
		ret.z = (q.m21 - q.m12)/d;
	}
	
	return CLQuaternionNormalize(ret);
}

CATransform3D QuaternionToCATransform3D(CLQuaternion q) {
	CATransform3D ret = CATransform3DIdentity;
	ret.m11 = 1- 2*q.z*q.z- 2*q.y*q.y;
	ret.m12 = - 2* q.z*q.w+2*q.y*q.x;
	ret.m13 = 2*q.y*q.w +2* q.z*q.x;
	ret.m21 = 2*q.x*q.y+ 2*q.w*q.z;
	ret.m22 = 1 - 2*q.z*q.z - 2*q.x*q.x;
	ret.m23 = 2*q.z*q.y- 2*q.x*q.w;
	ret.m31 = 2*q.x*q.z- 2*q.w*q.y;
	ret.m32 = 2*q.y*q.z + 2*q.w*q.x;
	ret.m33 = 1- 2*q.y*q.y- 2*q.x*q.x;
	return ret;
}