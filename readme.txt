Name: Fawaz Ahmad

Proj Desc: Processing code that renders a grid of equilateral triangles.
On click, a clicked triangle switches color once, and has a particular
color order of 3 colors then the default colorless background state in
cyclic fashion.

*-----------------------------------------------------------------------*
Improvements to be made: 

a. Algorithm for recognizing based on click
which triangle to color-swap is inefficient at very large
canvas sizes (has to run through all 
triangles).

a. Sol: Create a backwards conversion based on what col/row of pixel 
values which col/row of array matches most closely, and check only the 
triangles in that space for closest dist.


*-----------------------------------------------------------------------*
Implementation next steps (on website if put up): 
- Create an overhead color selector bar which uses RGB display and 
allows user to select which three colors they would like to use
- Create image download option to download the current picture made
- Create a canvas size configurator on website