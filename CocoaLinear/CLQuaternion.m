#import "CLQuaternion.h"

CLQuaternion CLQuaternionIdentity() {
	CLQuaternion ret = {1, 0, 0, 0};
	return ret;
}

CLQuaternion CLQuaternionZero() {
	CLQuaternion ret = {0, 0, 0, 0};
	return ret;
}

CLQuaternion CLQuaternionMultiply(CLQuaternion a, CLQuaternion b) {
	CLQuaternion ret;
	ret.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z;
	ret.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y;
	ret.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x;
	ret.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w;
	return ret;
}

CLQuaternion CLQuaternionMultiplyScalar(CLQuaternion q, double c) {
	CLQuaternion ret;
	ret.w = c * q.w;
	ret.x = c * q.x;
	ret.y = c * q.y;
	ret.z = c * q.z;
	return ret;
}

CLQuaternion CLQuaternionAdd(CLQuaternion a, CLQuaternion b) {
	CLQuaternion ret;
	ret.w = a.w + b.w;
	ret.x = a.x + b.x;
	ret.y = a.y + b.y;
	ret.z = a.z + b.z;
	return ret;
}

CLQuaternion CLQuaternionNormalize(CLQuaternion q) {
	CLQuaternion ret;
	double scale = 1 / sqrt(q.w*q.w + q.x*q.x + q.y*q.y + q.z*q.z);
	ret.w = scale * q.w;
	ret.x = scale * q.x;
	ret.y = scale * q.y;
	ret.z = scale * q.z;
	return ret;
}

double CLQuaternionDotProduct(CLQuaternion q1, CLQuaternion q2) {
	return q1.x * q2.x + q1.y * q2.y + q1.z * q2.z;
}

double CLQuaternionLength(CLQuaternion q) {
	return sqrt(q.w*q.w + q.x*q.x + q.y*q.y + q.z*q.z);
}

CLQuaternion CLQuaternionComplement(CLQuaternion q) {
	CLQuaternion ret;
	ret.w = -q.w;
	ret.x = -q.x;
	ret.y = -q.y;
	ret.z = -q.z;
	return ret;
}

CLQuaternion CLQuaternionInvert(CLQuaternion q) {
	CLQuaternion ret;
	ret.w = -q.w;
	ret.x = q.x;
	ret.y = q.y;
	ret.z = q.z;
	return ret;
}