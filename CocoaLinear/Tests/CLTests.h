#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "GHTestCase.h"
#import "CLVector.h"

@interface CLTests : GHTestCase {

}

- (void) assertDouble:(double)a equalsDouble:(double)b withAccuracy:(double)accuracy;
- (void) assertTransform:(CATransform3D)a equalsTransform:(CATransform3D)b withAccuracy:(double)accuracy;

@end

CLVector randomNormalizedVector();
CATransform3D randomRotationWithin(float maxRadians);
CATransform3D randomRotation();
