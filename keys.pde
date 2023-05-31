/*
 *  Defines keys to interact with the simulation:
 *      -   w, s:   modifies first's robot coupling
 *      -   e, d:   modifies second's robot coupling
 *      -   r, f:   modifies third's robot coupling
 *      -   ENTER:  rest position
 *      -   BACKSPACE:  initial camera position
*/

void keyPressed()
{
    if (key == 'w')
        q1REF += passo;
    if (key == 's')
        q1REF -= passo;

    if (key == 'e')
        q2REF += passo;
    if (key == 'd')
        q2REF -= passo;

    if (key == 'r')
        q3REF += passo;
    if (key == 'f')
        q3REF -= passo;

    if (keyCode == TAB) {
        angoloX = 0;
        angoloY = 0;
    }

    if (keyCode == ENTER)
        setRestPosition();
}
