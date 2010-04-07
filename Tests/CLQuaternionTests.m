#import "CLQuaternionTests.h"
#import "CLConversions.h"

@implementation QuaternionTests

- (void) assertQuaternion:(CLQuaternion)test equalsQuaternion:(CLQuaternion)check withAccuracy:(double)accuracy {
	if ((test.w > 0 && check.w > 0) || (test.w < 0 && check.w < 0)) {
		[self assertDouble:test.w equalsDouble:check.w withAccuracy:accuracy];
		[self assertDouble:test.x equalsDouble:check.x withAccuracy:accuracy];
		[self assertDouble:test.y equalsDouble:check.y withAccuracy:accuracy];
		[self assertDouble:test.z equalsDouble:check.z withAccuracy:accuracy];
	} else {
		[self assertDouble:-test.w equalsDouble:check.w withAccuracy:accuracy];
		[self assertDouble:-test.x equalsDouble:check.x withAccuracy:accuracy];
		[self assertDouble:-test.y equalsDouble:check.y withAccuracy:accuracy];
		[self assertDouble:-test.z equalsDouble:check.z withAccuracy:accuracy];
	}
}

- (void) testConvertIdentity {
	CATransform3D rotation = CATransform3DIdentity;
	CLQuaternion check = {1, 0, 0, 0};
	CLQuaternion test = QuaternionFromCATransform3D(rotation);
	[self assertQuaternion:test equalsQuaternion:check withAccuracy:0.0000001];
}

- (void) testConversionTo {
	CATransform3D rotation = CATransform3DMakeRotation(0.4, 0.9, 0.7, 0.6);
	CLQuaternion check = {0.9800665741417773, -0.13877757041056324, -0.10793811236000465, -0.09251838894658905};
	CLQuaternion test = QuaternionFromCATransform3D(rotation);
	[self assertQuaternion:test equalsQuaternion:check withAccuracy:0.0000001];
}

- (void) testConversionFrom {
	for (int trial = 0; trial < 200; trial++) {
		CATransform3D rotation = randomRotation();
		CLQuaternion testQuaternion = QuaternionFromCATransform3D(rotation);
		CATransform3D test = QuaternionToCATransform3D(testQuaternion);
		[self assertTransform:test equalsTransform:rotation withAccuracy:0.0001];
	}
}

- (void) testConversionFromSmall {
	for (int trial = 0; trial < 200; trial++) {
		CLVector v = randomNormalizedVector();
		float angle = pow(10, -(rand() % 15));
		CATransform3D rotation = CATransform3DMakeRotation(angle, v.x, v.y, v.z);
		CLQuaternion testQuaternion = QuaternionFromCATransform3D(rotation);
		CATransform3D test = QuaternionToCATransform3D(testQuaternion);
		[self assertTransform:test equalsTransform:rotation withAccuracy:0.00001];
	}
}

- (void) testNormalize {
	CLQuaternion q = QuaternionFromCATransform3D(randomRotation());
	double c = 7;
	CLQuaternion cq = CLQuaternionMultiplyScalar(q, c);
	[self assertDouble:CLQuaternionLength(q) equalsDouble:1 withAccuracy:0.0000001];
	[self assertDouble:CLQuaternionLength(cq) equalsDouble:c withAccuracy:0.0000001];
	[self assertDouble:CLQuaternionLength(CLQuaternionNormalize(cq)) equalsDouble:1 withAccuracy:0.0000001];
}

- (void) testMultiply {
	for (int trial = 0; trial < 200; trial++) {
		CATransform3D a = randomRotation();
		CATransform3D b = randomRotation();
		CLQuaternion qA = QuaternionFromCATransform3D(a);
		CLQuaternion qB = QuaternionFromCATransform3D(b);
		CLQuaternion qAB = CLQuaternionMultiply(qA,qB);
		
		[self assertTransform:QuaternionToCATransform3D(qAB) equalsTransform:CATransform3DConcat(a,b) withAccuracy:0.0001];
		[self assertQuaternion:qAB equalsQuaternion:QuaternionFromCATransform3D(CATransform3DConcat(a, b)) withAccuracy:0.0001];
	}
}

- (void) testDivide {
	for (int trial = 0; trial < 200; trial++) {
		CATransform3D a = randomRotation();
		CATransform3D b = randomRotation();
		CATransform3D aOverB = CATransform3DConcat(CATransform3DInvert(b), a);
		[self assertTransform:CATransform3DConcat(b, aOverB) equalsTransform:a withAccuracy:0.0001];
	}
}

- (void) testInvert {
	for (int trial = 0; trial < 200; trial++) {
		CLQuaternion a = QuaternionFromCATransform3D(randomRotation());
		CLQuaternion aInv = CLQuaternionInvert(a);
		[self assertQuaternion:CLQuaternionMultiply(aInv, a) equalsQuaternion:CLQuaternionIdentity() withAccuracy:0.0000000001];
	}
}

@end
