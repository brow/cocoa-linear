#import "CLVectorTests.h"
#import "GHUnit.h"

#define ACCURACY 0.000000001

@implementation VectorTests

- (void) assertVector:(CLVector)test equalsVector:(CLVector)check withAccuracy:(double)accuracy {
	GHAssertEqualsWithAccuracy(test.x, check.x, ACCURACY, nil);
	GHAssertEqualsWithAccuracy(test.y, check.y, ACCURACY, nil);
	GHAssertEqualsWithAccuracy(test.z, check.z, ACCURACY, nil);
}

- (void) setUp {
	a.x = 1;
	a.y = 2;
	a.z = 3;
	
	b.x = -0.4;
	b.y = 0.5;
	b.z = -0.6;
	
	c.x = 0;
	c.y = -0.7;
	c.z = -0.8;
}

- (void) testCross {
	CLVector test, check = {-2.7, -0.6, 1.3};
	test = CLVectorCrossProduct(a, b);
	[self assertVector:test equalsVector:check withAccuracy:ACCURACY];
}

- (void) testDot {
	double test = CLVectorDotProduct(a,b);
	double check = -1.2;
	GHAssertEqualsWithAccuracy(test, check, ACCURACY, nil);
}

- (void) testNormalize {
	CLVector check = {0, -0.658504607, -0.7525766947};
	CLVector test = CLVectorNormalize(c);
	[self assertVector:test equalsVector:check withAccuracy:ACCURACY];
}

- (void) testMultiply {
	CLVector test, check = {0, -1.4, -1.6};
	test = CLVectorMultiplyScalar(c, 2);
	[self assertVector:test equalsVector:check withAccuracy:ACCURACY];
}

//- (void) testMatrixMultiply {
//}

//- (void) testApplyCATransform3D {
//}

- (void) testSubtract {
	CLVector test, check = {1.4, 1.5, 3.6};
	test = CLVectorSubtract(a, b);
	[self assertVector:test equalsVector:check withAccuracy:ACCURACY];
}

@end
