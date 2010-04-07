#import <QuartzCore/QuartzCore.h>
#import "CLMatrix3x3.h"
#import "CLQuaternion.h"

CLMatrix3x3 Matrix3x3FromCATransform3D(CATransform3D t);

CATransform3D Matrix3x3ToCATransform3D(CLMatrix3x3 m);

CLQuaternion QuaternionFromCATransform3D(CATransform3D r);

CATransform3D QuaternionToCATransform3D(CLQuaternion quat);