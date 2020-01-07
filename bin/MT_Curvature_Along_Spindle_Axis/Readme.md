# Project Title
Analyzing the changes in the KMTs curvature along the spindle pole axis 
## Getting Started
This program calculates how the curvature of given MTS (KMTs) is changing along the spindle axis .
### 
For this You need exported data from ZIB Amira, and formatted into .xlsx file using excel

## Data preparation
Data also should also be prepared prior to the analysis
      Prefarable data should be resampled for 1000A ~ 0.1um, and cleaned out for any MTs which is not fully in the volume, and also fibers which 
      do does not have all KMTs that should be deleted for the best accuracy of the program.
      For proper calculation of the relative position, spindle pole to pole axis, should be aligned with the spindle Y-axis
      The last requirement is to label all fiber with names PoleX_YY
###
        X -> Pole 1 or 2
        YY -> number of the fiber
## Using the code
Up to now, the program is analog and require user interaction upon uploading your data.
###
      lines 10-12 -> dir of the file
      lines 23-24 -> xyz pole position
