#import "CLMatrix3x3Tests.h"
#import "CLConversions.h"

#define ACCURACY 0.000001

@implementation Matrix3x3Tests
- (void) setUp {
	[super setUp];
	
	CLMatrix3x3 tmpA = {	1, 2, 3,
						4, 5, 6,
						7, 8, 9 };
	a = tmpA;
	
	CLMatrix3x3 tmpB = {	-3, 2, -4,
						-5, 7, 8,
						-9, 1, 6 };
	b = tmpB;

	CLMatrix3x3 tmpC = {	5, 3, 1,
						1, 3, 5,
						0, 0, 1 };
	c = tmpC;
	
	CLMatrix3x3 tmpD = {	1, 2, 3,
						2, 4, -5,
						3, -5, 6 };
	d = tmpD;
	
	CLMatrix3x3 tmpE = {	0.664518786277521, 0.712609153627593, -0.224951054343865,
						-0.51109393373636, 0.653024449992795, 0.558875709446653,
						0.545158484830002, -0.25641228885873, 0.798157230462823	};
	e = tmpE;
}
	
- (void) testZero {
	CLMatrix3x3 zero = CLMatrix3x3Zero();
	CLMatrix3x3 test = CLMatrix3x3Multiply(a, zero);
	GHAssertEquals(zero, test, nil);
}

- (void) testIdentity {
	CLMatrix3x3 identity = CLMatrix3x3Identity();
	CLMatrix3x3 test = CLMatrix3x3Multiply(a, identity);
	GHAssertEquals(a, test, nil);
}

- (void) testDeterminant {
	GHAssertEquals(CLMatrix3x3Determinant(a), (double)0, nil);
	GHAssertEquals(CLMatrix3x3Determinant(b), (double)-418, nil);
}

- (void) testTranspose {
	CLMatrix3x3 check = { 1, 4, 7,
						2, 5, 8,
						3, 6, 9 };
	GHAssertEquals(CLMatrix3x3Transpose(a), check, nil);
	GHAssertEquals(CLMatrix3x3Transpose(check), a, nil);
}

- (void) testMultiply {
	CLMatrix3x3 checkAB = {	-40, 19, 30,
							-91, 49, 60,
							-142, 79, 90 };
	CLMatrix3x3 checkBA = {	-23, -28, -33,
							79, 89, 99,
							37, 35, 33	};
	GHAssertEquals(CLMatrix3x3Multiply(a, b), checkAB, nil);
	GHAssertEquals(CLMatrix3x3Multiply(b, a), checkBA, nil);
}

- (void) testMultiply2 {
	CATransform3D tA = randomRotation(), tB = randomRotation();
	CLMatrix3x3 mA = CLMatrix3x3FromCATransform3D(tA), mB = CLMatrix3x3FromCATransform3D(tB);
	CATransform3D test = CLMatrix3x3ToCATransform3D(CLMatrix3x3Multiply(mA, mB));
	[self assertTransform:test equalsTransform:CATransform3DConcat(tA, tB) withAccuracy:0.001];
}

- (void) testMultiply3 {
	CATransform3D tA = CATransform3DMakeRotation(M_PI/4, 0, 0, 1), tB = CATransform3DMakeScale(1, 0.5, 1);
	CLMatrix3x3 mA = CLMatrix3x3FromCATransform3D(tA), mB = CLMatrix3x3FromCATransform3D(tB);
	
	CATransform3D test = CLMatrix3x3ToCATransform3D(CLMatrix3x3Multiply(mA, mB));

	CATransform3D check = CATransform3DIdentity;
	check = CATransform3DScale(check, 1, 0.5, 1);
	check = CATransform3DRotate(check, M_PI/4, 0, 0, 1);
	
	[self assertTransform:test equalsTransform:check withAccuracy:0.001];
}

- (void) testTrace {
	GHAssertEquals(CLMatrix3x3Trace(a), (double)15, nil);
	GHAssertEquals(CLMatrix3x3Trace(b), (double)10, nil);
	GHAssertEquals(CLMatrix3x3Trace(c), (double)9, nil);
}

- (void) testSubtract {
	// TODO
}

- (void) testEigenvalues {
	double test[3], checkA[3] = {-1.116844, 0, 16.116844}, checkC[3] = {1, 2, 6};
	CLMatrix3x3Eigenvalues(a, test);	
	GHAssertEqualsWithAccuracy(test[0], checkA[0], ACCURACY, nil);
	GHAssertEqualsWithAccuracy(test[1], checkA[1], ACCURACY, nil);
	GHAssertEqualsWithAccuracy(test[2], checkA[2], ACCURACY, nil);
	
	CLMatrix3x3Eigenvalues(c, test);
	GHAssertEqualsWithAccuracy(test[0], checkC[0], ACCURACY, nil);
	GHAssertEqualsWithAccuracy(test[1], checkC[1], ACCURACY, nil);
	GHAssertEqualsWithAccuracy(test[2], checkC[2], ACCURACY, nil);
}

- (void) testEigenvaluesOneReal {
	double test[3], check[3] = {0, 0, 1};
	CLMatrix3x3Eigenvalues(e, test);	
	GHAssertEqualsWithAccuracy(test[0], check[0], ACCURACY, nil);
	GHAssertEqualsWithAccuracy(test[1], check[1], ACCURACY, nil);
	GHAssertEqualsWithAccuracy(test[2], check[2], ACCURACY, nil);
}

- (void) testEigenvectorsSymmetric{
	double testValues[3], checkValues[3] = {-3.077304, 3.841390, 10.235913};
	CLVector testVectors[3], checkVectors[3] = {	-0.652720, 0.551455, 0.519475,
												0.746551, 0.584861, 0.317173,
												0.128914, -0.594840, 0.793440 };
	
	CLMatrix3x3SymmetricEigenvectors(d, testValues, testVectors);
	GHAssertEqualsWithAccuracy(testValues[0], checkValues[0], ACCURACY, nil);
	GHAssertEqualsWithAccuracy(testValues[1], checkValues[1], ACCURACY, nil);
	GHAssertEqualsWithAccuracy(testValues[2], checkValues[2], ACCURACY, nil);
	GHAssertEqualsWithAccuracy(abs(testVectors[0].x), abs(checkVectors[0].x), ACCURACY, nil);
	GHAssertEqualsWithAccuracy(abs(testVectors[0].y), abs(checkVectors[0].y), ACCURACY, nil);
	GHAssertEqualsWithAccuracy(abs(testVectors[0].z), abs(checkVectors[0].z), ACCURACY, nil);
	GHAssertEqualsWithAccuracy(abs(testVectors[1].x), abs(checkVectors[1].x), ACCURACY, nil);
	GHAssertEqualsWithAccuracy(abs(testVectors[1].y), abs(checkVectors[1].y), ACCURACY, nil);
	GHAssertEqualsWithAccuracy(abs(testVectors[1].z), abs(checkVectors[1].z), ACCURACY, nil);
	GHAssertEqualsWithAccuracy(abs(testVectors[2].x), abs(checkVectors[2].x), ACCURACY, nil);
	GHAssertEqualsWithAccuracy(abs(testVectors[2].y), abs(checkVectors[2].y), ACCURACY, nil);
	GHAssertEqualsWithAccuracy(abs(testVectors[2].z), abs(checkVectors[2].z), ACCURACY, nil);
}

@end
