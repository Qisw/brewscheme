# brewscheme
brewscheme is a tool to facilitate Stata users developing graph schemes using research-based color palettes.  Unlike other uses of the color palettes developed by Brewer (see References below), this program allows users to specify the number of colors from any of the 35 color palettes they would like to use and allows users to mix/combine different palettes for the various graph types available in Stata.  Additionally, as a way of creating a centralized source for the Stata community to work from, palettes from outside of ColorBrewer are being added to boost the capabilities of the program.



## Examples
Generate a graph scheme using the set1 color brewer palette for all graphs.  Use the first five colors of the palette and set the color intensity to 80 for each of the graphs.

**brewscheme, scheme(set1) allst(set1) allc(5) allsat(80)**

Generate a graph scheme using the set1 color brewer palette for scatterplots, pastel1 for bar graphs, and brown to blue-green for all other graph types.  Use the default values of colors and intensity for each.

**brewscheme, scheme(mixed1) scatst(set1) barst(pastel1) somest(brbg)**

Create a graph scheme with a distinct color palette for each graph type:

**brewscheme, scheme(myriadColorPalettes) barst(paired) barc(12) dotst(prgn) dotc(7) scatstyle(set1) scatc(9) linest(pastel2) linec(8) boxstyle(accent) boxc(8) areast(dark2) areac(8) piest(mdepoint) sunst(greys) histst(veggiese) cist(activitiesa) matst(spectral) reflst(purd) refmst(set3) const(ylgn) cone(puor)**

## References
Brewer, C. A. (2002). _Color Brewer 2 [Computer Software]_. State College, PA: Cynthia Brewer, Mark Harrower, and 
    The Pennsylvania State University.
    
Lin, S., Fortuna, J., Kulkarni, C., Stone, M., & Heer, J. (2013). Selecting Semantically-Resonant Colors for 
    Data Visualization. In _Computer Graphics Forum_ (Vol. 32, No. 3pt4, pp. 401-410).  Blackwell Publishing Ltd.

## License Information
Please view  section 4 of the [ColorBrewer](http://www.colorbrewer2.org) copyright notice for additional information pertaining to the licensing and redistribution of ColorBrew intellectual property.
