#import "CLTests.h"

@implementation CLTests

- (void) setUp {
	srand(123);
}

- (void) assertDouble:(double)a equalsDouble:(double)b withAccuracy:(double)accuracy {
	/* STAssertEqualsWithAccuracy is inaccurate when either argument is not finite. */
	STAssertTrue(isfinite(a), nil);
	STAssertTrue(isfinite(b), nil);
	STAssertEqualsWithAccuracy(a, b, accuracy, nil);
}

- (void) assertTransform:(CATransform3D)a equalsTransform:(CATransform3D)b withAccuracy:(double)accuracy {
	[self assertDouble:a.m11 equalsDouble:b.m11 withAccuracy:accuracy];
	[self assertDouble:a.m12 equalsDouble:b.m12 withAccuracy:accuracy];
	[self assertDouble:a.m13 equalsDouble:b.m13 withAccuracy:accuracy];
	[self assertDouble:a.m14 equalsDouble:b.m14 withAccuracy:accuracy];
	[self assertDouble:a.m21 equalsDouble:b.m21 withAccuracy:accuracy];
	[self assertDouble:a.m22 equalsDouble:b.m22 withAccuracy:accuracy];
	[self assertDouble:a.m23 equalsDouble:b.m23 withAccuracy:accuracy];
	[self assertDouble:a.m24 equalsDouble:b.m24 withAccuracy:accuracy];
	[self assertDouble:a.m31 equalsDouble:b.m31 withAccuracy:accuracy];
	[self assertDouble:a.m32 equalsDouble:b.m32 withAccuracy:accuracy];
	[self assertDouble:a.m33 equalsDouble:b.m33 withAccuracy:accuracy];
	[self assertDouble:a.m34 equalsDouble:b.m34 withAccuracy:accuracy];
	[self assertDouble:a.m41 equalsDouble:b.m41 withAccuracy:accuracy];
	[self assertDouble:a.m42 equalsDouble:b.m42 withAccuracy:accuracy];
	[self assertDouble:a.m43 equalsDouble:b.m43 withAccuracy:accuracy];
	[self assertDouble:a.m44 equalsDouble:b.m44 withAccuracy:accuracy];
}

@end

CLVector randomNormalizedVector() {
	CLVector v;
	v.x = (float)rand() * 2.0 / RAND_MAX - 1.0;
	v.y = (float)rand() * 2.0 / RAND_MAX - 1.0;
	v.z = (float)rand() * 2.0 / RAND_MAX - 1.0;
	return CLVectorNormalize(v);
}


CATransform3D randomRotationWithin(float maxRadians) {
	CLVector axis = randomNormalizedVector();
	float angle = (float)rand() * maxRadians / RAND_MAX;
	return CATransform3DMakeRotation(angle, axis.x, axis.y, axis.z);
}

CATransform3D randomRotation() {
	return randomRotationWithin(M_PI);
}
