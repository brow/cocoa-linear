#import <QuartzCore/QuartzCore.h>
#import "CLMatrix3x3.h"
#import "CLQuaternion.h"

CLMatrix3x3 CLMatrix3x3FromCATransform3D(CATransform3D t);

CATransform3D CLMatrix3x3ToCATransform3D(CLMatrix3x3 m);

CLQuaternion CLQuaternionFromCATransform3D(CATransform3D r);

CATransform3D CLQuaternionToCATransform3D(CLQuaternion quat);