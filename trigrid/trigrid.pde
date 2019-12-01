// setup for triangle grid
TriCent[][] grid;
// colors used in palet
color back = color(255, 251, 238);
color dark = color(172, 192, 250);
color light = color(199, 247, 255);
color tone = color(60, 130, 236);
// Constant values used in program
// calculated by trig for equilateral triangles
float sideLen = 50;
float triHeight = 43.30127;
float centerOffset1 = 14.43;
float centerOffset2 = 28.87127;
void setup() {  // this is run once.   
    
    // set the background color
    background(back);
    
    // canvas size 
    size(800, 600); 
    int wide = 800;
    int lengt = 600;
          
    // removed smooth edges because they were removing contiguous
    // color between triangles
    noSmooth();
    
   // create array of triangular positions, row major
   int rows = (int)(2*lengt/sideLen) + 1;
   int cols = (int)(wide/triHeight) + 1;
   grid = new TriCent[rows][cols];
   
   for (int col = 0; col < grid[0].length; col++) {
       for (int row = 0; row < grid.length; row++) {
         // deals with case if triangle is pointing left
           if ((col % 2 == 0 && row % 2 == 0) || (col % 2 == 1 && row % 2 == 1)) {
             grid[row][col] = new TriCent(col*triHeight + centerOffset2, row*sideLen/2,
                                          col*triHeight, row*sideLen/2,
                                          col*triHeight + triHeight, row*sideLen/2 - sideLen/2,
                                          col*triHeight + triHeight, row*sideLen/2 + sideLen/2);
            // create grid frame for each triangle
            stroke(240);
            strokeWeight(1);
            fill(back);
            triangle(col*triHeight, row*sideLen/2,
                                          col*triHeight + triHeight, row*sideLen/2 - sideLen/2,
                                          col*triHeight + triHeight, row*sideLen/2 + sideLen/2);           
           }
         // deals with case if triangle is pointing right
           else if ((col % 2 == 0 && row % 2 == 1) || (col % 2 == 1 && row % 2 == 0)) {
             grid[row][col] = new TriCent(col*triHeight + centerOffset1, row*sideLen/2,
                                          col*triHeight, row*sideLen/2 - sideLen/2,
                                          col*triHeight, row*sideLen/2 + sideLen/2,
                                          col*triHeight + triHeight, row*sideLen/2);
            // create grid frame for each triangle
            stroke(240);
            strokeWeight(1);
            fill(back);
            triangle(col*triHeight, row*sideLen/2 - sideLen/2,
                                          col*triHeight, row*sideLen/2 + sideLen/2,
                                          col*triHeight + triHeight, row*sideLen/2);   
           }
           
       }
   }
    
} 

// Object for triangle locating and color transformation
class TriCent {
  
    // storage of triangle coordinates (center and vertices)
    float centerX;
    float centerY;
    float vOneX;
    float vOneY;
    float vTwoX;
    float vTwoY;
    float vThreeX;
    float vThreeY;
    
    // triangle frame constructor
    TriCent (float cX, float cY, float v1X, float v1Y, 
             float v2X, float v2Y, float v3X, float v3Y) {
        centerX = cX;
        centerY = cY;
        vOneX = v1X;
        vOneY = v1Y;
        vTwoX = v2X;
        vTwoY = v2Y;
        vThreeX = v3X;
        vThreeY = v3Y;
    }
    
    // returns distance from center of triangle to arg x,y coordinates
    float distTo (int x, int y) {
        float dist = sqrt(sq(x-centerX)+sq(y-centerY));
        return dist;
    }
    // draws the triangle for this TriCent with the color at (x,y)
    void drawTri (int x, int y) {
        strokeJoin(ROUND);
        color current = get(x, y);
        // established order of color transformation
        if (current == back) {
            stroke(dark);
            strokeWeight(1);
            fill(dark);
            triangle(vOneX, vOneY, vTwoX, vTwoY, vThreeX, vThreeY);
        }
        else if (current == dark) {
            stroke(light);
            strokeWeight(1);
            fill(light);
            triangle(vOneX, vOneY, vTwoX, vTwoY, vThreeX, vThreeY);
        }
        else if (current == light) {
            stroke(tone);
            strokeWeight(1);
            fill(tone);
            triangle(vOneX, vOneY, vTwoX, vTwoY, vThreeX, vThreeY);
        }
        else if (current == tone) {
            stroke(240);
            strokeWeight(1);
            fill(back);
            triangle(vOneX, vOneY, vTwoX, vTwoY, vThreeX, vThreeY);
        }
        
    }
}

 void draw() {  // this is run repeatedly.
    if (mousePressed) {
        TriCent minDistTri = new TriCent(0, 0, 0, 0, 0, 0, 0, 0);
        float lowestDist = grid[0][0].distTo(mouseX, mouseY);
        // iterate through each TriCent to find the one under mouse press
        // (will have shortest distance)
        for (int col = 0; col < grid[0].length; col++) {
           for (int row = 0; row < grid.length - 1; row++) {
               float currDist = grid[row][col].distTo(mouseX, mouseY);
               if (currDist < lowestDist) {
                   lowestDist = currDist;
                   minDistTri = grid[row][col];
               }
           }
        }
        minDistTri.drawTri(mouseX, mouseY);
    }
    // added short delay to mitigate rapid multi-color flipping on clicks
    delay(50);
} 
