
// a basic noise-based moving particle
class Particle {
  // unique id, (previous) position, speed
  float id, x, y, xp, yp, s, d;
  color col; // color
  
  Particle(float id) {
    this.id = id;
    s = random(2, 6); // speed
  }
  
  void updateAndDisplay() {
    // let it flow, end with a new x and y position
    id += 0.01;
//    d = (noise(id, x/globalY, y/globalY)-0.5)*globalX;
    x = random(x-80, x+80);
    y = random(y-80, y+80);
//    x += cos(radians(d))*s;
//    y += sin(radians(d))*s;

    // constrain to boundaries
    if (x<-10) x=xp=kinectWidth+10;
    if (x>kinectWidth+10) x=xp=-10;
    if (y<-10) y=yp=kinectHeight+10;
    if (y>kinectHeight+10) y=yp=-10;

    // if there is a polygon (more than 0 points)
    if (poly.npoints > 0) {
      // if this particle is outside the polygon
      if (!poly.contains(x, y)) {
        // while it is outside the polygon
        while(!poly.contains(x, y)) {
          // randomize x and y
          x = random(kinectWidth);
          y = random(kinectHeight);
        }
        // set previous x and y, to this x and y
        xp=x;
        yp=y;
      }
    }
    
    // individual particle color
    stroke(col);
    // line from previous to current position
    float cxp, cyp, dx, dy, con1, con2;
    con1 = 200;
    con2 = 200;
    cxp = random(xp-con1, xp+con1);
    cyp = random(yp-con2, yp+con2);
    dx = random(xp-con1, xp+con1);
    dy = random(yp-con2, yp+con2);
//    line(xp, yp, x, y);
    curve(cxp, cyp, xp, yp, x, y, dx, dy);
        
    // set previous to current position
    xp=x;
    yp=y;
  }
}

