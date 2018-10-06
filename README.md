# processing_works
media art tutorials and works with processing
try not to use SimpleOpenNI lib, but openkinect_processing lib

### Running Environments

OS: OSX 10.14(macOS Mojave)
Processing Version: 2.2.1
Kinect: Microsoft Kinect V2
(have problem with SimpleOpenNI, cannot find device)

Libs
1. openkinect_processing
2. blobDetection
3. Video


### 181006, pen-drawing looking work

With internal webcam, draw randomly generated curves on canvers.
select a sigle x,y point, and another new x and y point with add random(-20, 20) on it.
draw a curve between the point and new point.
if they are too close, its slope of curve is became exponentially slanting. Or, gradient.
still working on it, and will be done until early Nov.


### references
https://shiffman.net/p5/kinect/

