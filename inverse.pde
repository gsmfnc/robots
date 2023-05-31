/*
 *  Reads Textfields contents and according to robotNo value applies inverse
 *  kinematics to the specified robot. (see gui.pde)
*/

float D1 = 1;
float D2 = 1;
float D3 = 1;
float L1 = 1;
float L2 = 1;
float L3 = 1;

void inverse()
{
    String firstParameterText = firstParameterTF.getText();
    String secondParameterText = secondParameterTF.getText();
    String thirdParameterText = thirdParameterTF.getText();

    float x = 0;
    float y = 0;
    float z = 0;

    try {
        x = Float.parseFloat(firstParameterText);
        y = Float.parseFloat(secondParameterText);
        z = Float.parseFloat(thirdParameterText);
    } catch(Exception e) {
        e.printStackTrace();
    }

    if (robotNo == CILINDRICO)
        //CILINDRICO
        inverse_cilindrico(x, y, z);
    if (robotNo == CARTESIANO)
        //CARTESIANO
        inverse_cartesiano(x, y, z);
    if (robotNo == SCARA)
        //SCARA
        inverse_scara(x, y, z);
    if (robotNo == SFERICO)
        //SFERICO
        inverse_sferico(x, y, z);
    if (robotNo == SFERICO_STANFORD)
        //SFERICO STANFORD
        inverse_stanford(x, y, z);
    if (robotNo == ANTROPOMORFO)
        //ANTROPOMORFO
        inverse_antropomorfo(x, y, z);
    if (robotNo == POLSO_SFERICO)
        //POLSO SFERICO
        inverse_polso_sferico(x, y, z);
}

void inverse_cilindrico(float x, float y, float z)
{
    float tmp = x;
    x = y;
    y = tmp;

    if (pow(x, 2) + pow(y, 2) == 0)
        return;

    tmp = x;
    x = z;
    z = tmp;

    q2REF = z/scala - L1;
    q3REF = sqrt(x*x + y*y)/scala;
    q1REF = atan2(-y/q3REF, x/q3REF);
}

void inverse_cartesiano(float x, float y, float z)
{
    float tmp[] = swap(y, z);
    y = tmp[0];
    z = tmp[1];

    q1REF = z / scala;
    q2REF = y / scala;
    q3REF = x / scala;
}

void inverse_scara(float x, float y, float z)
{
    float tmp[] = swap(y, z);
    y = tmp[0];
    z = tmp[1];

    float A = pow(x/scala,2)+pow(y/scala,2);
    if (!(pow(L2-L3,2) < A && A < pow(L2+L3,2)))
        return;

    float Y = z-L1*scala;
    float X = sqrt(pow(x,2)+pow(y,2));
    float a = (pow(x,2)+pow(y,2)-pow(scala*L2,2)-pow(scala*L3,2))/
                (2*scala*L2*scala*L3);
    A = sqrt(abs(1-pow(a,2)));
    q3REF = L1-z/scala;
    q2REF = atan2(A, a);
    float b1 = scala*L2+cos(q2REF)*scala*L3;
    float b2 = sin(q2REF)*scala*L3;
    q1REF = atan2(-b2*x+b1*y, b1*x+b2*y);
}

void inverse_sferico(float x, float y, float z)
{
    float tmp[] = swap(y, z);
    y = tmp[0];
    z = tmp[1];

    float A = pow(x,2)+pow(y,2)+pow(z-L1,2);
    if (A > pow(L2,2)) {
        float Y = z-L1*scala;
        float X = sqrt(pow(x,2)+pow(y,2));
        q3REF = sqrt(pow(X,2)+pow(Y,2)-pow(scala*L2,2));
        float b1 = q3REF/( pow(q3REF,2)+pow(scala*L2,2));
        float b2 = L2*scala/( pow(q3REF,2)+pow(scala*L2,2));
        q2REF = atan2(-b2*Y+b1*X,b1*Y+b2*X);
        float a = q3REF*sin(q2REF)+L2*scala*cos(q2REF);
        q1REF = atan2(y/a,x/a);
        q3REF = -q3REF/scala;
    }
}

void inverse_stanford(float x, float y, float z)
{
    float tmp[] = swap(y, z);
    y = tmp[0];
    z = tmp[1];

    if (!(pow(x/scala, 2) + pow(y/scala, 2) > pow(L2, 2)))
        return;

    q3REF = sqrt(pow(x,2)+pow(y,2)+pow(z-scala*L1,2)-pow(scala*L2,2));
    float C = (z-scala*L1)/q3REF;
    float S = sqrt(pow(x,2)+pow(y,2)-pow(scala*L2,2))/q3REF;
    q2REF = atan2(S,C);
    float D = pow(q3REF,2)*pow(sin(q2REF),2) + pow(scala*L2,2);
    C = (1/D)*(q3REF*sin(q2REF)*x + scala*L2*y);
    S = (1/D)*(q3REF*sin(q2REF)*y - scala*L2*x);
    q1REF = atan2(S,C);
    q3REF = q3REF/scala;
}

void inverse_antropomorfo(float x, float y, float z)
{
    float tmp[] = swap(y, z);
    y = tmp[0];
    z = tmp[1];

    if (!(pow(L2-L3, 2) < pow(x/scala, 2) + pow(y/scala, 2) + pow(z/scala-L1, 2)
            && pow(x/scala, 2) + pow(y/scala, 2) + pow(z/scala-L1, 2) <
                                                    pow(L2+L3, 2)))
        return;

    float Y = z-L1*scala;
    float X = sqrt(pow(x,2)+pow(y,2));
    float a = (pow(X,2)+pow(Y,2)-pow(L2*scala,2)-pow(L3*scala,2))/
                (2*L1*scala*L3*scala);
    float A = -sqrt(1-pow(a,2));
    q1REF = atan2(y, x);
    q3REF = atan2(A, a);
    float b1 = scala+cos(q3REF)*scala;
    float b2 = sin(q3REF)*scala;
    q2REF = q2REF;
    q1REF = q1REF;
    q2REF = atan2(-b2*X+b1*Y, b1*X+b2*Y);
}

//57.735025, 157.735026, 57.735026
void inverse_polso_sferico(float x, float y, float z)
{
    float tmp[] = swap(y, z);
    y = tmp[0];
    z = tmp[1];

    float A = pow(x,2)+pow(y,2)+pow(z-L1*scala,2);
    if (A == pow(L2*scala,2)) {
        float Y = z-L1*scala;
        float X = sqrt(pow(x,2)+pow(y,2));
        q3REF = 0;
        q2REF = atan2(X,Y);
        q1REF = atan2(-y/sin(q2REF),-x/sin(q2REF));
    }
    System.out.println(A);
    System.out.println(pow(L2*scala,2));
}

float[] swap(float a, float b)
{
    float tmp = b;
    b = a;
    a = tmp;

    float r[] = {a, b};

    return r;
}
