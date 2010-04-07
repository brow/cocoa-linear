#define USE_APPLICATION_UNIT_TEST 1

#import <QuartzCore/QuartzCore.h>
#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "CLVector.h"

@interface CLTests : SenTestCase {

}

- (void) assertDouble:(double)a equalsDouble:(double)b withAccuracy:(double)accuracy;
- (void) assertTransform:(CATransform3D)a equalsTransform:(CATransform3D)b withAccuracy:(double)accuracy;

@end

CLVector randomNormalizedVector();
CATransform3D randomRotationWithin(float maxRadians);
CATransform3D randomRotation();
