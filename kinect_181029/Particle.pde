
// a basic noise-based moving particle
class Particle {
  // unique id, (previous) position, speed
  float id, x, y, xp, yp, s, d;
  float midx, midy;
  color col; // color

  Particle(float id) {
    this.id = id;
    s = random(2, 6); // speed
  }

  public float getMidx() {
    return midx;
  }

  public float getMidy() {
    return midy;
  }

  void updateAndDisplay() {
    // let it flow, end with a new x and y position
    id += 0.01;
    //    d = (noise(id, x/globalY, y/globalY)-0.5)*globalX;
    int rg = 80; //originally 80
    x = constrain(random(x-rg, x+rg), 1, kinectWidth);
    y = constrain(random(y-rg, y+rg), 1, kinectHeight-1);
    //    x += cos(radians(d))*s;
    //    y += sin(radians(d))*s;

    // constrain to boundaries
    if (x<0) x=xp=kinectWidth;
    if (x>kinectWidth) x=xp=1;
    if (y<0) y=yp=kinectHeight-1;
    if (y>kinectHeight) y=yp=1;
    
//    if (x<-10) x=xp=kinectWidth+10;
//    if (x>kinectWidth+10) x=xp=-10;
//    if (y<-10) y=yp=kinectHeight+10;
//    if (y>kinectHeight+10) y=yp=-10;

    // if there is a polygon (more than 0 points)
    if (poly.npoints > 0) {
      // if this particle is outside the polygon
      if (!poly.contains(x, y)) {
        // while it is outside the polygon
        while (!poly.contains (x, y)) {
          // randomize x and y
          x = constrain(random(kinectWidth), 1, kinectWidth);
          y = constrain(random(kinectHeight), 1, kinectHeight -1);
        }
        // set previous x and y, to this x and y
        xp=x;
        yp=y;
      }
    }

    // line from previous to current position
    float cxp, cyp, dx, dy, con1, con2;
    con1 = 200;
    con2 = 200;
    cxp = random(xp-con1, xp+con1);
    cyp = random(yp-con2, yp+con2);
    dx = random(xp-con1, xp+con1);
    dy = random(yp-con2, yp+con2);
    //    line(xp, yp, x, y);


//    if (y < 0) y = kinectHeight;
//    if (y > kinectHeight) y = 0;
//    if (x < 0) x = kinectWidth;
//    if (x > kinectWidth) x = 0;
    
    pg.curve(cxp, cyp, xp, yp, x, y, dx, dy);

    midx = (xp+x)/2;
    midy = (yp+y)/2;
    
//    int colMid = (int)midx*3 + (int)(midy*2.25*cam.width);
    int colMid2 = (int)xp*3 + (int)(yp*2.25*cam.width);
//    int colMid3 = cam.width * (cam.height/2) + cam.width/2;
//    int colMid2 = (kinectHeight - (int)midx) + (int)(midy*kinectWidth);
    println("xp, yp: " + xp + ", " + yp + " || x, y: " + x + ", " + y + " || colmid: " + colMid2 + " camw,h : " + cam.width + ", " + cam.height + " max: " + cam.pixels.length);

//    col = cam.pixels[colMid2];
//    col = cam.pixels[colMid2];
    // individual particle color
//    stroke(col);
    pg.stroke(0,0,255);

    // set previous to current position
    xp=x;
    yp=y;
  }

  //  public void AdjustBound() {
  //    //error handling
  //    if (dy < 0) dy = height;
  //    if (dy > height) dy = 0;
  //    if (dx < 0) dx = width;
  //    if (dx > width) dx = 0;
  //  }
}

