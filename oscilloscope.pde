/*
 *  This function draws an oscilloscope into a PGraphics display:
 *  the idea is to read frameCount value and use it as time variable.
 *  To reduce "x-axis speed", time was multiplied by a step size variable. The
 *  PGraphics screen has a width of 400, hence width / step supplies the x value
 *  of "end screen".
 *  Formula for plotting:
 *      line starting from (step * t-1, previous variable value)
                      to   (step * t, current variable value)
*/

float pg_width = 400;
float step = 1 / 6.0;
float endscreen = pg_width / step;

float oldq1 = 0;
float oldq2 = 0;
float oldq3 = 0;

float oldq1REF = 0;
float oldq2REF = 0;
float oldq3REF = 0;

void oscilloscope()
{
    pg.beginDraw();

    //q1REF, q2REF, q3REF plotting
    pg.stroke(126);
    pg.line(pg_width - step * ((frameCount - 1) % endscreen), 100 - oldq1REF * 10,
            pg_width - step * (frameCount % endscreen), 100 - q1REF * 10);
    pg.line(pg_width - step * ((frameCount - 1) % endscreen), 200 - oldq2REF * 10,
            pg_width - step * (frameCount % endscreen), 200 - q2REF * 10);
    pg.line(pg_width - step * ((frameCount - 1) % endscreen), 300 - oldq3REF * 10,
            pg_width - step * (frameCount % endscreen), 300 - q3REF * 10);

    //q1, q2, q3 plotting
    pg.stroke(0);
    pg.line(pg_width - step * ((frameCount - 1) % endscreen), 100 - oldq1 * 10,
            pg_width - step * (frameCount % endscreen), 100 - q1 * 10);
    pg.line(pg_width - step * ((frameCount - 1) % endscreen), 200 - oldq2 * 10,
            pg_width - step * (frameCount % endscreen), 200 - q2 * 10);
    pg.line(pg_width - step * ((frameCount - 1) % endscreen), 300 - oldq3 * 10,
            pg_width - step * (frameCount % endscreen), 300 - q3 * 10);

    //if "end screen" is reached, clears screen and re-draws grid.
    if (frameCount % endscreen == 0) {
        pg.background(255, 255, 255);
        pg.stroke(200);
        pg.line(0, 100, 400, 100);
        pg.line(0, 200, 400, 200);
        pg.line(0, 300, 400, 300);

        pg.line(100, 0, 100, 400);
        pg.line(200, 0, 200, 400);
        pg.line(300, 0, 300, 400);
    }

    pg.endDraw();
    image(pg, 780, 50);

    oldq1 = q1;
    oldq2 = q2;
    oldq3 = q3;

    oldq1REF = q1REF;
    oldq2REF = q2REF;
    oldq3REF = q3REF;
}
