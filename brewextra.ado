********************************************************************************
* Description of the Program -												   *
* This program is used to install additional palettes into the brewmeta  	   *
* database locally.  It is called initially when brewmeta is called, but sub-  *
* sequently would be used with a future program brewpalettes to construct and  *
* persist data files with palettes over time (so a user could rebuild the 	   *
* entire database in a single step.											   *
*                                                                              *
* Data Requirements -														   *
*     none                                                                     *
*																			   *
* System Requirements -														   *
*     none                                                                     *
*                                                                              *
* Program Output -                                                             *
*     r(brewextrapalettes) - List of the names of the additional palettes      *
*     r(brewextras) - File path/name where extras dataset is located		   *
*                                                                              *
* Lines -                                                                      *
*     607                                                                      *
*                                                                              *
********************************************************************************
		
*! brewextra
*! v 0.0.4
*! 08SEP2015

// Drop the program from memory if loaded
cap prog drop brewextra

// Define the program as an rclass program
prog def brewextra, rclass

	// Version of Stata underwhich program is assumed to run
	version 13.1
	
	// Define syntax structure for program
	syntax [, files(string asis) REFresh]
	
	// Preserve pre-existing state of the data
	preserve
	
		// Check for a b subdirectory in personal
		cap confirm new file `"`c(sysdir_personal)'brewuser"'
		
		// If it would be a new directory
		if _rc == 0 {
		
			// Create the subdirectory
			qui: mkdir `"`c(sysdir_personal)'brewuser"'
			
			// Print status message to console
			di as res `"Creating directory `c(sysdir_personal)'brewuser "'	 ///   
			`"to store user defined palette files."'
		
		} // End IF Block for b subdirectory of personal
		
		// Check for refresh option
		cap confirm new file `"`c(sysdir_personal)'brewuser/extras.dta"'
		
		// Check for existing extras file or refresh option
		if _rc == 0 | "`refresh'" != "" {
		
			// Clear existing data from memory
			clear

			// Reserve memory for 130 observations
			set obs 130

			// Create palette, RGB, and meta variables 
			// Meta variable contains additional info related to the research/experiments
			// and could include labels with which people associated a particular color
			qui: g palette = "" 
			qui: g rgb = ""
			qui: g meta = ""

			// Populate the palette variable(s) with data from brewscheme project
			qui: replace palette = "mdebar" in 1/5
			qui: replace palette = "mdepoint" in 6/8
			qui: replace palette = "tableau" in 9/28
			qui: replace palette = "fruite" in 29/35
			qui: replace palette = "fruita" in 36/42
			qui: replace palette = "veggiesa" in 43/49
			qui: replace palette = "veggiese" in 50/56
			qui: replace palette = "brandsa" in 57/63
			qui: replace palette = "brandse" in 64/70
			qui: replace palette = "drinksa" in 71/77
			qui: replace palette = "drinkse" in 78/84
			qui: replace palette = "fooda" in 85/91
			qui: replace palette = "foodt" in 92/98
			qui: replace palette = "carsa" in 99/104
			qui: replace palette = "carst" in 105/110
			qui: replace palette = "featuresa" in 111/115
			qui: replace palette = "featurest" in 116/120
			qui: replace palette = "activitiesa" in 121/125
			qui: replace palette = "activitiest" in 126/130
			bys palette: g colorid = _n
			bys palette: g pcolor = _N
			qui: g maxcolors = pcolor

			// Mississippi Department of Education specific colors for bar graphs
			qui: replace rgb = "255 0 0" if palette == "mdebar" & colorid == 1
			qui: replace rgb = "255 127 0" if palette == "mdebar" & colorid == 2
			qui: replace rgb = "255 255 0" if palette == "mdebar" & colorid == 3
			qui: replace rgb = "0 128 0" if palette == "mdebar" & colorid == 4
			qui: replace rgb = "0 0 255" if palette == "mdebar" & colorid == 5
				
			// Mississippi Department of Education specific colors for scatter plots
			qui: replace rgb = "0 0 255" if palette == "mdepoint" & colorid == 1
			qui: replace rgb = "255 127 0" if palette == "mdepoint" & colorid == 2
			qui: replace rgb = "0 128 0" if palette == "mdepoint" & colorid == 3
			
			// Define colors used in Tableau's color scheme
			qui: replace rgb = "31 119 180" if palette == "tableau" & colorid == 1
			qui: replace rgb = "255 127 14" if palette == "tableau" & colorid == 2
			qui: replace rgb = "44 160 44" if palette == "tableau" & colorid == 3
			qui: replace rgb = "214 39 40" if palette == "tableau" & colorid == 4
			qui: replace rgb = "148 103 189" if palette == "tableau" & colorid == 5 
			qui: replace rgb = "140 86 75" if palette == "tableau" & colorid == 6
			qui: replace rgb = "227 119 194" if palette == "tableau" & colorid == 7
			qui: replace rgb = "127 127 127" if palette == "tableau" & colorid == 8
			qui: replace rgb = "188 189 34" if palette == "tableau" & colorid == 9
			qui: replace rgb = "23 190 207" if palette == "tableau" & colorid == 10
			qui: replace rgb = "174 119 232" if palette == "tableau" & colorid == 11
			qui: replace rgb = "255 187 120" if palette == "tableau" & colorid == 12
			qui: replace rgb = "152 223 138" if palette == "tableau" & colorid == 13
			qui: replace rgb = "255 152 150" if palette == "tableau" & colorid == 14
			qui: replace rgb = "197 176 213" if palette == "tableau" & colorid == 15
			qui: replace rgb = "196 156 148" if palette == "tableau" & colorid == 16
			qui: replace rgb = "247 182 210" if palette == "tableau" & colorid == 17
			qui: replace rgb = "199 199 199" if palette == "tableau" & colorid == 18
			qui: replace rgb = "219 219 141" if palette == "tableau" & colorid == 19
			qui: replace rgb = "158 218 229" if palette == "tableau" & colorid == 20

			// Fruits corresponding to fruit palettes
			qui: replace meta = "Apple" if inlist(palette, "fruite",		 ///   
											"fruita") & colorid == 1
			qui: replace meta = "Banana" if inlist(palette, "fruite",		 ///   
											"fruita") & colorid == 2 
			qui: replace meta = "Blueberry" if inlist(palette, "fruite",	 ///   
											"fruita") & colorid == 3
			qui: replace meta = "Cherry" if inlist(palette, "fruite",		 ///   
											"fruita") & colorid == 4
			qui: replace meta = "Grape" if inlist(palette, "fruite",		 ///   
											"fruita") & colorid == 5
			qui: replace meta = "Peach" if inlist(palette, "fruite",		 ///   
											"fruita") & colorid == 6
			qui: replace meta = "Tangerine" if inlist(palette, "fruite",	 ///   
											"fruita") & colorid == 7

			// Fruit expert selected palette
			qui: replace rgb = "146 195 51" if palette == "fruite" & colorid == 1
			qui: replace rgb = "251 222 6" if palette == "fruite" & colorid == 2
			qui: replace rgb = "64 105 166" if palette == "fruite" & colorid == 3
			qui: replace rgb = "200 0 0" if palette == "fruite" & colorid == 4
			qui: replace rgb = "127 34 147" if palette == "fruite" & colorid == 5
			qui: replace rgb = "251 162 127" if palette == "fruite" & colorid == 6
			qui: replace rgb = "255 86 29" if palette == "fruite" & colorid == 7

			// Fruit algorithm selected palette
			qui: replace rgb = "44 160 44" if palette == "fruita" & colorid == 1
			qui: replace rgb = "188 189 34" if palette == "fruita" & colorid == 2
			qui: replace rgb = "31 119 180" if palette == "fruita" & colorid == 3
			qui: replace rgb = "214 39 40" if palette == "fruita" & colorid == 4
			qui: replace rgb = "148 103 189" if palette == "fruita" & colorid == 5
			qui: replace rgb = "255 187 120" if palette == "fruita" & colorid == 6
			qui: replace rgb = "255 127 14" if palette == "fruita" & colorid == 7

			// Vegetables corresponding to veggies palettes		
			qui: replace meta = "Carrot" if inlist(palette, "veggiese",		 ///   
											"veggiesa") & colorid == 1
			qui: replace meta = "Celery" if inlist(palette, "veggiese",		 ///   
											"veggiesa") & colorid == 2
			qui: replace meta = "Corn" if inlist(palette, "veggiese",		 ///   
											"veggiesa") & colorid == 3
			qui: replace meta = "Eggplant" if inlist(palette, "veggiese",	 ///   
											"veggiesa") & colorid == 4
			qui: replace meta = "Mushroom" if inlist(palette, "veggiese",	 ///   
											"veggiesa") & colorid == 5
			qui: replace meta = "Olive" if inlist(palette, "veggiese",		 ///   
											"veggiesa") & colorid == 6
			qui: replace meta = "Tomato" if inlist(palette, "veggiese",		 ///   
											"veggiesa") & colorid == 7

			// Vegetable algorithm selected
			qui: replace rgb = "255 127 14" if palette == "veggiesa" & colorid == 1
			qui: replace rgb = "44 160 44" if palette == "veggiesa" & colorid == 2
			qui: replace rgb = "188 189 34" if palette == "veggiesa" & colorid == 3
			qui: replace rgb = "148 103 189" if palette == "veggiesa" & colorid == 4
			qui: replace rgb = "140 86 75" if palette == "veggiesa" & colorid == 5
			qui: replace rgb = "152 223 138" if palette == "veggiesa" & colorid == 6
			qui: replace rgb = "214 39 40" if palette == "veggiesa" & colorid == 7

			// Vegetable export selected
			qui: replace rgb = "255 141 61" if palette == "veggiese" & colorid == 1
			qui: replace rgb = "157 212 105" if palette == "veggiese" & colorid == 2
			qui: replace rgb = "245 208 64" if palette == "veggiese" & colorid == 3
			qui: replace rgb = "104 59 101" if palette == "veggiese" & colorid == 4
			qui: replace rgb = "239 197 143" if palette == "veggiese" & colorid == 5
			qui: replace rgb = "139 129 57" if palette == "veggiese" & colorid == 6
			qui: replace rgb = "255 26 34" if palette == "veggiese" & colorid == 7

			// Brands corresponding to brand palettes
			qui: replace meta = "Apple" if inlist(palette, "brandse",		 ///   
											"brandsa") & colorid == 1
			qui: replace meta = "AT&T" if inlist(palette, "brandse",		 ///   
											"brandsa") & colorid == 2
			qui: replace meta = "Home Depot" if inlist(palette, "brandse",	 ///   
											"brandsa") & colorid == 3
			qui: replace meta = "Kodak" if inlist(palette, "brandse",		 ///   
											"brandsa") & colorid == 4
			qui: replace meta = "Starbucks" if inlist(palette, "brandse",	 ///   
											"brandsa") & colorid == 5
			qui: replace meta = "Target" if inlist(palette, "brandse",		 ///   
											"brandsa") & colorid == 6
			qui: replace meta = "Yahoo!" if inlist(palette, "brandse",		 ///   
											"brandsa") & colorid == 7

			// Brands algorithm selected
			qui: replace rgb = "152 223 138" if palette == "brandsa" & colorid == 1
			qui: replace rgb = "31 119 180" if palette == "brandsa" & colorid == 2
			qui: replace rgb = "255 127 14" if palette == "brandsa" & colorid == 3
			qui: replace rgb = "140 86 75" if palette == "brandsa" & colorid == 4
			qui: replace rgb = "44 160 44" if palette == "brandsa" & colorid == 5
			qui: replace rgb = "214 39 40" if palette == "brandsa" & colorid == 6
			qui: replace rgb = "148 103 189" if palette == "brandsa" & colorid == 7

			// Brands export selected
			qui: replace rgb = "161 165 169" if palette == "brandse" & colorid == 1
			qui: replace rgb = "44 163 218" if palette == "brandse" & colorid == 2
			qui: replace rgb = "242 99 33" if palette == "brandse" & colorid == 3
			qui: replace rgb = "255 183 0" if palette == "brandse" & colorid == 4
			qui: replace rgb = "0 112 66" if palette == "brandse" & colorid == 5
			qui: replace rgb = "204 0 0" if palette == "brandse" & colorid == 6
			qui: replace rgb = "123 0 153" if palette == "brandse" & colorid == 7

			// Drinks corresponding to brand palettes
			qui: replace meta = "A&W Root Beer" if inlist(palette, 			 ///   
											 "drinkse", "drinksa") & colorid == 1
			qui: replace meta = "Coca-Cola" if inlist(palette, "drinkse",	 ///   
											"drinksa") & colorid == 2
			qui: replace meta = "Dr. Pepper" if inlist(palette, "drinkse",	 ///   
											"drinksa") & colorid == 3
			qui: replace meta = "Pepsi" if inlist(palette, "drinkse",		 ///   
											"drinksa") & colorid == 4
			qui: replace meta = "Sprite" if inlist(palette, "drinkse",		 ///   
											"drinksa") & colorid == 5
			qui: replace meta = "Sunkist" if inlist(palette, "drinkse",		 ///   
											"drinksa") & colorid == 6
			qui: replace meta = "Welch's Grape" if inlist(palette, 			 ///   
											"drinkse", "drinksa") & colorid == 7

			// Drinks algorithm selected
			qui: replace rgb = "140 86 75" if palette == "drinksa" & colorid == 1
			qui: replace rgb = "214 39 40" if palette == "drinksa" & colorid == 2
			qui: replace rgb = "227 119 194" if palette == "drinksa" & colorid == 3
			qui: replace rgb = "31 119 180" if palette == "drinksa" & colorid == 4
			qui: replace rgb = "44 160 44" if palette == "drinksa" & colorid == 5
			qui: replace rgb = "255 127 14" if palette == "drinksa" & colorid == 6
			qui: replace rgb = "148 103 189" if palette == "drinksa" & colorid == 7

			// Drinks export selected
			qui: replace rgb = "119 67 6" if palette == "drinkse" & colorid == 1
			qui: replace rgb = "254 0 0" if palette == "drinkse" & colorid == 2
			qui: replace rgb = "151 37 63" if palette == "drinkse" & colorid == 3
			qui: replace rgb = "1 106 171" if palette == "drinkse" & colorid == 4
			qui: replace rgb = "1 159 76" if palette == "drinkse" & colorid == 5
			qui: replace rgb = "254 115 20" if palette == "drinkse" & colorid == 6
			qui: replace rgb = "104 105 169" if palette == "drinkse" & colorid == 7

			// Foods corresponding to brand palettes
			qui: replace meta = "Sour Cream" if inlist(palette, "foodse", 	 ///   
											"foodsa") & colorid == 1
			qui: replace meta = "Blue Cheese Dressing" if inlist(palette, 	 ///   
											"foodse", "foodsa") & colorid == 2
			qui: replace meta = "Porterhouse Steak" if inlist(palette, 		 ///   
											"foodse", "foodsa") & colorid == 3
			qui: replace meta = "Iceburg Lettuce" if inlist(palette, 		 ///   
											"foodse", "foodsa") & colorid == 4
			qui: replace meta = "Onions (Raw)" if inlist(palette, "foodse",	 ///   
											"foodsa") & colorid == 5
			qui: replace meta = "Potato (Baked)" if inlist(palette,			 ///   
											"foodse", "foodsa") & colorid == 6
			qui: replace meta = "Tomato" if inlist(palette, "foodse",		 ///   
											"foodsa") & colorid == 7

			// Foods algorithm selected
			qui: replace rgb = "31 119 180" if palette == "fooda" & colorid == 1
			qui: replace rgb = "255 127 14" if palette == "fooda" & colorid == 2
			qui: replace rgb = "140 86 75" if palette == "fooda" & colorid == 3
			qui: replace rgb = "44 160 44" if palette == "fooda" & colorid == 4
			qui: replace rgb = "255 187 120" if palette == "fooda" & colorid == 5
			qui: replace rgb = "219 219 141" if palette == "fooda" & colorid == 6
			qui: replace rgb = "214 39 40" if palette == "fooda" & colorid == 7

			// Foods export selected
			qui: replace rgb = "199 199 199" if palette == "foodt" & colorid == 1
			qui: replace rgb = "31 119 180" if palette == "foodt" & colorid == 2
			qui: replace rgb = "140 86 75" if palette == "foodt" & colorid == 3
			qui: replace rgb = "152 223 138" if palette == "foodt" & colorid == 4
			qui: replace rgb = "219 219 141" if palette == "foodt" & colorid == 5
			qui: replace rgb = "196 156 148" if palette == "foodt" & colorid == 6
			qui: replace rgb = "214 39 40" if palette == "foodt" & colorid == 7

			// Car Colors corresponding to brand palettes
			qui: replace meta = "Red" if inlist(palette, "carse",			 ///   
												"carsa") & colorid == 1
			qui: replace meta = "Silver" if inlist(palette, "carse",		 ///   
												"carsa") & colorid == 2
			qui: replace meta = "Black" if inlist(palette, "carse",			 ///   
												"carsa") & colorid == 3
			qui: replace meta = "Green" if inlist(palette, "carse",			 ///   
												"carsa") & colorid == 4
			qui: replace meta = "Brown" if inlist(palette, "carse",			 ///   
												"carsa") & colorid == 5
			qui: replace meta = "Blue" if inlist(palette, "carse",			 ///   
												"carsa") & colorid == 6

			// Car Colors algorithm selected
			qui: replace rgb = "214 39 40" if palette == "carsa" & colorid == 1
			qui: replace rgb = "199 199 199" if palette == "carsa" & colorid == 2
			qui: replace rgb = "127 127 127" if palette == "carsa" & colorid == 3
			qui: replace rgb = "44 160 44" if palette == "carsa" & colorid == 4
			qui: replace rgb = "140 86 75" if palette == "carsa" & colorid == 5
			qui: replace rgb = "31 119 180" if palette == "carsa" & colorid == 6

			// Car Colors export selected
			qui: replace rgb = "214 39 40" if palette == "carst" & colorid == 1
			qui: replace rgb = "199 199 199" if palette == "carst" & colorid == 2
			qui: replace rgb = "127 127 127" if palette == "carst" & colorid == 3 
			qui: replace rgb = "44 160 44" if palette == "carst" & colorid == 4
			qui: replace rgb = "140 86 75" if palette == "carst" & colorid == 5
			qui: replace rgb = "31 119 180" if palette == "carst" & colorid == 6

			// Features corresponding to brand palettes
			qui: replace meta = "Speed" if inlist(palette, "featurest",		 ///   
											"featuresa") & colorid == 1
			qui: replace meta = "Reliability" if inlist(palette, "featurest", ///   
											"featuresa") & colorid == 2
			qui: replace meta = "Comfort" if inlist(palette, "featurest",	 ///   
											"featuresa") & colorid == 3
			qui: replace meta = "Safety" if inlist(palette, "featurest",	 ///   
											"featuresa") & colorid == 4
			qui: replace meta = "Efficiency" if inlist(palette, "featurest", ///   
											"featuresa") & colorid == 5

			// Features algorithm selected
			qui: replace rgb = "214 39 40" if palette == "featuresa" & colorid == 1
			qui: replace rgb = "31 119 180" if palette == "featuresa" & colorid == 2
			qui: replace rgb = "140 86 75" if palette == "featuresa" & colorid == 3
			qui: replace rgb = "255 127 14" if palette == "featuresa" & colorid == 4
			qui: replace rgb = "44 160 44" if palette == "featuresa" & colorid == 5

			// Features export selected
			qui: replace rgb = "214 39 40" if palette == "featurest" & colorid == 1
			qui: replace rgb = "31 119 180" if palette == "featurest" & colorid == 2
			qui: replace rgb = "174 119 232" if palette == "featurest" & colorid == 3 
			qui: replace rgb = "44 160 44" if palette == "featurest" & colorid == 4
			qui: replace rgb = "152 223 138" if palette == "featurest" & colorid == 5

			// Activities corresponding to brand palettes
			qui: replace meta = "Sleeping" if inlist(palette, "activitiest", ///   
											"activitiesa") & colorid == 1
			qui: replace meta = "Working" if inlist(palette, "activitiest",	 ///   
											"activitiesa") & colorid == 2
			qui: replace meta = "Leisure" if inlist(palette, "activitiest",	 ///   
											"activitiesa") & colorid == 3
			qui: replace meta = "Eating" if inlist(palette, "activitiest",	 ///   
											"activitiesa") & colorid == 4
			qui: replace meta = "Driving" if inlist(palette, "activitiest",	 ///   
											"activitiesa") & colorid == 5

			// Activities algorithm selected
			qui: replace rgb = "140 86 75" if palette == "activitiesa"		 ///   
														& colorid == 1
			qui: replace rgb = "255 127 14" if palette == "activitiesa"		 ///   
														& colorid == 2
			qui: replace rgb = "31 119 180" if palette == "activitiesa"		 ///   
														& colorid == 3
			qui: replace rgb = "227 119 194" if palette == "activitiesa"	 ///   
														& colorid == 4 
			qui: replace rgb = "214 39 40" if palette == "activitiesa"		 ///   
														& colorid == 5

			// Activities export selected
			qui: replace rgb = "31 119 180" if palette == "activitiest"		 ///   
														& colorid == 1
			qui: replace rgb = "214 39 40" if palette == "activitiest"		 ///   
														& colorid == 2
			qui: replace rgb = "152 223 138" if palette == "activitiest"	 ///   
														& colorid == 3 
			qui: replace rgb = "44 160 44" if palette == "activitiest"		 ///   
														& colorid == 4
			qui: replace rgb = "127 127 127" if palette == "activitiest"	 ///   
														& colorid == 5

														
			// Create a sequence ID for the Data set 
			qui: egen seqid = concat(palette pcolor colorid)
			
			// Local macros w/palette names
			loc sem1 "carsa, carse, foodsa, foodse, featuresa, featurese"
			loc sem2 "activitiesa, activitiese, fruita, fruite, veggiesa"
			loc sem3 "veggiese, brandsa, brandse, drinksa, drinkse"
			loc others "mdebar, mdepoint, tableau"
			loc extrapalettes `"`sem1', `sem2', `sem3', `others'"'
			
			// Return all added palette names in single local
			ret loc brewextrapalettes = `"`extrapalettes'"'
			
			// Return file path/name for file created
			ret loc brewextras = `"`c(sysdir_personal)'brewuser/extras.dta"'
			
			// Check for brewuser directory
			if `"`: dir `"`c(sysdir_personal)'"' dirs brewuser, nofail respect'"' == "" {
			
				// Make directory
				qui: mkdir `"`c(sysdir_personal)'brewuser"'
				
				// Save the brew extras data set
				qui: save `"`c(sysdir_personal)'brewuser/extras.dta"', replace
				
			} // End IF Block to save the extra color palettes
		
			// Push the extras file through check file spec sub routine
			checkfilespec `"`c(sysdir_personal)'brewuser/extras.dta"'
			
		} // End IF Block for refresh/no extras file
									
		// If the files parameter contains an argument 								
		if `"`files'"' != "" {
		
			// Loop over the individual files listed in the argument
			forv i = 1/`: word count `files'' {
			
				// Check the individual files
				checkfilespec `"`: word `i' of `files''"'
			
				// Return name of file with palettes added
				ret loc brewextrafile`i' = `"`r(filenm)'"'
			
			} // End Loop over files
			
		} // End IF Block for files argument being non-null
		
	// Restore data to original state
	restore
		
// End of Subroutine definition
end


// Define subroutine to check the additional incoming files
prog def checkfilespec, rclass

		// Syntax structure for subroutine
 		syntax anything(name = infiles id = "Palette file")
		
		// Preserve state of data currently in memory
		preserve
		
			// Load the data file into memory
			qui: use `infiles', clear
			
			// Loop over required variables to make sure all necessary data is 
			// available
			foreach v in palette rgb seqid meta {
			
				// Confirm variable exists
				cap confirm variable `v'
				
				// If variable doesn't exist
				if _rc != 0 {
				
					// Display error message
					di as err "Variable `v' does not exist in the file."
					
					// Return code of 1
					ret sca code = 1

				} // End IF Block for variable existence
				
				// If variable exists check type
				else {
				
					// Check to make sure the variable is a string
					if regexm("`: type `v''", "str*") != 1 {
					
						// Print error message to console
						di as err "Variable `v' must be a string variable."
						
						// Return code of 1
						ret sca code = 1
						
					} // End IF Block for type cast checking
				
				} // End ELSE Block for type checking
				
			} // End Loop over string variables
			
			// Loop over numeric variables
			foreach v in colorblind print photocopy lcd colorid pcolor {
			
				// Confirm variable exists
				cap confirm variable `v'
				
				// If variable doesn't exist
				if _rc != 0 & inlist("`v'", "colorid", "pcolor") == 1 {
				
					// Display error message
					di as err "Variable `v' does not exist in the file."
					
					// Return code of 1
					ret sca code = 1

				} // End IF Block for variable existence
				
				// For the meta data variables create them if they don't exist
				else if _rc != 0 & !inlist("`v'", "colorid", "pcolor") == 1 {
				
					// Populate the meta data variables with missing codes for 
					// information not available
					qui: g `v' = .n
					
				} // End ELSEIF Block 
				
				// Otherwise secondary checks
				else {
				
					// For id variables they must be non-null
					if inlist("`v'", "colorid", "pcolor") == 1  {
					
						// See if any values are missing 
						qui: count if mi(`v')
						
						// Exit if missing values
						if `= r(N)' != 0 {
						
							// Print error message
							di as err `"Missing values encountered in `v'"'
							
							// Exit program
							exit
							
						} // End IF Block for no null value ids
						
					} // End IF Block for ID Variable additional validation
					
					// Otherwise
					else {
					
						// Replace missing values with coded missing values
						qui: replace `v' = .n if mi(`v')
						
					} // End ELSE Block for metadata variables
					
				} // End ELSE Block
				
			} // End Loop over numeric variables
			
			// Get the names of the palettes to add to the brewmeta data file
			qui: levelsof palette, loc(newpalettes)

			// Set the display order of the variables to match brewmeta.dta
			order palette colorblind print photocopy lcd colorid pcolor rgb  ///   
			maxcolors seqid meta

			// Compress dataset before saving
			qui: compress
			
			// Parse the file path/name passed to the function and store the file name
			loc fnm `"`: di regexr(`infiles', ".*/", "")'"'
			
			// If the file checks out thus far save it to the extras directory
			qui: save `"`c(sysdir_personal)'brewuser/`fnm'"', replace
						
			// Load brewmeta file
			qui: use `"`c(sysdir_personal)'b/brewmeta.dta"', clear
			
			// Get existing palettes characteristics
			loc existpalettes : char _dta[palettes]
		
			// Append new colors
			qui: append using `"`c(sysdir_personal)'brewuser/`fnm'"'
			
			// Drop any duplicates
			qui: duplicates drop
			
			// Define meta data characteristics with available palettes
			char _dta[palettes] `"`existpalettes', `newpalettes'"'	
			
			// Save over old file
			qui: save, replace
		
		// Restore to original state of data in memory
		restore
		
		// Return a code of 0
		ret sca code = 0
		
		// Return file name
		ret loc filenm = `"`c(sysdir_personal)'brewuser/`infiles'"'
		
// End Subroutine
end		
