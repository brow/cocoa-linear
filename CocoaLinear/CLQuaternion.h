typedef struct {
	double w, x, y, z;
} CLQuaternion;


CLQuaternion CLQuaternionIdentity();

CLQuaternion CLQuaternionZero();

CLQuaternion CLQuaternionMultiply(CLQuaternion a, CLQuaternion b);

CLQuaternion CLQuaternionMultiplyScalar(CLQuaternion q, double c);

CLQuaternion CLQuaternionAdd(CLQuaternion a, CLQuaternion b);

CLQuaternion CLQuaternionNormalize(CLQuaternion q);

double CLQuaternionDotProduct(CLQuaternion q1, CLQuaternion q2);

double CLQuaternionLength(CLQuaternion q);

CLQuaternion CLQuaternionComplement(CLQuaternion q);

CLQuaternion CLQuaternionInvert(CLQuaternion q);