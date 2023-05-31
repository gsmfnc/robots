import g4p_controls.*;

static final int CILINDRICO = 0;
static final int CARTESIANO = 1;
static final int SCARA = 2;
static final int SFERICO = 3;
static final int SFERICO_STANFORD = 4;
static final int ANTROPOMORFO = 5;
static final int POLSO_SFERICO = 6;

//coupling values
float q1 = 0;
float q2 = 0;
float q3 = 0;

float q1REF = 0;
float q2REF = 0;
float q3REF = 0;

//end-effector coordinates (related to default coordinate system)
double finalX = 0;
double finalY = 0;
double finalZ = 0;

//coupling value's increasing/decreasing step
float passo = 0.5;
//robot's drawing scale
float scala = 100.0;

//determines robot's type
int robotNo = CILINDRICO;

float kp = 0.02;

PGraphics pg;

void setup()
{
    size(1200, 700, P3D);
    //see gui.pde
    createGUI();

    //creating a smaller 2D window with a grid (oscilloscope)
    pg = createGraphics(400, 400);
    pg.beginDraw();
    pg.background(255, 255, 255);
    pg.stroke(200);
    pg.fill(0, 0, 0);
    pg.line(0, 100, 400, 100);
    pg.line(0, 200, 400, 200);
    pg.line(0, 300, 400, 300);
    pg.line(100, 0, 100, 400);
    pg.line(200, 0, 200, 400);
    pg.line(300, 0, 300, 400);
    pg.endDraw();

    setRestPosition();
}

void draw()
{
    background(173, 216, 230);

    pushMatrix();

    translate(1.5 * width / 4, height/2, 0);
    rotateX(PI/2);

    rotateY(-angoloY);
    rotateX(angoloX);

    directionalLight(126, 126, 126, 0, 0, -1.5);
    ambientLight(200, 200, 200);

    noStroke();

    q1 = q1 + kp * (q1REF - q1);
    q2 = q2 + kp * (q2REF - q2);
    q3 = q3 + kp * (q3REF - q3);

    fill(0);
    translate(0, 0, -25);
    box(50);
    translate(0, 0, 25);

    fill(#CEA61F);
    robot();

    popMatrix();

    noLights();
    write_text(); //see text.pde
    oscilloscope(); //see oscilloscope.pde
}

void robot()
{
    if (robotNo == CILINDRICO) {
        //CILINDRICO
        link(q1, 1, 0, 0);
        link(0, q2, -PI/2, 0);
        link(0, q3, 0, 0);
    }
    if (robotNo == CARTESIANO) {
        //CARTESIANO
        link(0, q1, -PI/2,0);
        link(-PI/2, q2, -PI/2,0);
        link(0, q3, 0,0);
    }
    if (robotNo == SCARA) {
        //SCARA
        link(q1, 1, 0, 1);
        link(q2, 0, PI, 1);
        link(0, q3, 0, 0);
    }
    if (robotNo == SFERICO) {
        //SFERICO
        link(q1, 1, -PI/2, 0);
        link(q2, 0, -PI/2, 1);
        link(0, q3, 0, 0);
    }
    if (robotNo == SFERICO_STANFORD) {
        //SFERICO STANFORD
        link(q1, 1, -PI/2, 0);
        link(q2, 1, PI/2, 0);
        link(0, q3, 0, 0);
    }
    if (robotNo == ANTROPOMORFO) {
        //ANTROPOMORFO
        link(q1, 1, PI/2, 0);
        link(q2, 0, 0, 1);
        link(q3, 0, 0, 1);
    }
    if (robotNo == POLSO_SFERICO) {
        //POLSO SFERICO
        link(q1, 1, PI/2, 0);
        link(q2, 0, -PI/2, 0);
        link(q3, 1, 0, 0);
    }

    //end-effector coordinates
    finalX = Math.floor(modelX(0, 0, 0) * 100) / 100;
    finalY = Math.floor(modelY(0, 0, 0) * 100) / 100;
    finalZ = Math.floor(modelZ(0, 0, 0) * 100) / 100;
}

void link(float theta, float d, float alpha, float a)
{
    rotateZ(theta);
    sphere(25);

    fill(0, 0, 0);
    stroke(255);
    line(0, 0, 0, 0, 0, 300);
    line(0, 0, 0, 0, 0, -300);
    noStroke();

    fill(#CEA61F);
    translate(0, 0, scala * d/2.0);
    box(25, 25, scala * d);
    translate(0, 0, scala * d/2.0);

    rotateX(alpha);
    sphere(25);
    translate(scala*a/2.0, 0, 0);
    box(scala * a, 25, 25);
    translate(scala*a/2.0, 0, 0);
}

void setRestPosition()
/*
 * This function determines a 'rest' position for every robot.
*/
{
    if (robotNo == CILINDRICO) {
        q1 = -90 * PI / 180;
        q2 = 55 * PI / 180;
        q3 = 55 * PI / 180;

        q1REF = -90 * PI / 180;
        q2REF = 55 * PI / 180;
        q3REF = 55 * PI / 180;
    }

    if (robotNo == CARTESIANO) {
        q1 = 55 * PI / 180;
        q2 = 85 * PI / 180;
        q3 = -30 * PI / 180;

        q1REF = 55 * PI / 180;
        q2REF = 85 * PI / 180;
        q3REF = -30 * PI / 180;
    }

    if (robotNo == SCARA) {
        q1 = 0 * PI / 180;
        q2 = 0 * PI / 180;
        q3 = 0 * PI / 180;

        q1REF = 0 * PI / 180;
        q2REF = 0 * PI / 180;
        q3REF = 0 * PI / 180;
    }

    if (robotNo == SFERICO) {
        q1 = 0 * PI / 180;
        q2 = 0 * PI / 180;
        q3 = 50 * PI / 180;

        q1REF = 0 * PI / 180;
        q2REF = 0 * PI / 180;
        q3REF = 50 * PI / 180;
    }

    if (robotNo == SFERICO_STANFORD) {
        q1 = -90 * PI / 180;
        q2 = -35 * PI / 180;
        q3 = 50 * PI / 180;

        q1REF = -90 * PI / 180;
        q2REF = -35 * PI / 180;
        q3REF = 50 * PI / 180;
    }

    if (robotNo == ANTROPOMORFO) {
        q1 = 0 * PI / 180;
        q2 = -35 * PI / 180;
        q3 = 50 * PI / 180;

        q1REF = 0 * PI / 180;
        q2REF = -35 * PI / 180;
        q3REF = 50 * PI / 180;
    }

    if (robotNo == POLSO_SFERICO) {
        q1 = 0  * PI / 180;
        q2 = -45 * PI / 180;
        q3 = 50 * PI / 180;

        q1REF = 0  * PI / 180;
        q2REF = -45 * PI / 180;
        q3REF = 50 * PI / 180;
    }
}
