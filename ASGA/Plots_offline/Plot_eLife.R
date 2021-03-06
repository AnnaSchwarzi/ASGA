###########################################################################################################################
# Plots for eLife paper
#
# (c) 2019-2021 Kiewisz
# This code is licensed under GPL V3.0 license (see LICENSE.txt for details)
#
# Author: Robert Kiewisz
# Created: 2021-02-02
###########################################################################################################################
source("bin/Utility/Library.R")

# Supplementary 4: 3D Euclidean distance between spindle poles from tomographic data
PTP <- tibble(X_Coord_P1 = c(51385.63281, 52571.19531, 80278.8125),	
              Y_Coord_P1 = c(18100.44141, 113530.8203, 81406.53906),	
              Z_Coord_P1 = c(25617.02148, 28686.98242, 17718.85156),
              X_Coord_P2 = c(51282.79297, 52565.24609, 80279.78906),	
              Y_Coord_P2 = c(89695.32031, 9660.630859, -13390.78125),	
              Z_Coord_P2 = c(24732.59766, 28693.30469, 17719.81055))/10000
PTP$distance <- apply(PTP, 1, 
                      function(x) dist(matrix(x, nrow = 2, byrow = TRUE)))

Pole_to_Pole <- ggplot(PTP[1,], aes("Metaphase #1", distance)) + 
                geom_col(fill = "brown1") + 
                theme_classic()
Pole_to_Pole <- Pole_to_Pole + 
                geom_col(data = PTP[2,], aes("Metaphase #2", distance), fill = "brown3")
Pole_to_Pole <- Pole_to_Pole + 
                geom_col(data = PTP[3,], aes("Metaphase #3", distance), fill = "brown4")
Pole_to_Pole <- Pole_to_Pole + 
                geom_col(data = data.frame(distance = mean(PTP[,7])), aes("Avg.", distance), fill = "darkred") + 
                stat_summary(data = data.frame(distance =PTP[,7]), 
                             aes("Avg.", distance),
                             fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

print(Pole_to_Pole)

# Supplementary 4: 3D Euclidean distance between sister-kinetochore (IKD)
IKD_avg <- rbind(Data_1_IKD, Data_2_IKD, Data_3_IKD)

IKD <- ggplot(Data_1_IKD, aes("Metaphase #1", `Inter-kinetochore distance`)) + 
       geom_quasirandom(method = "tukeyDense", color = "brown1", shape = 15, size = 1.5) + 
       stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange") +
       ylim(0.5, 1.8) + 
       theme_classic()
IKD <- IKD + 
       geom_quasirandom(data = Data_2_IKD, aes("Metaphase #2", `Inter-kinetochore distance`), 
                        color = "brown3",  shape = 16, size = 1.5) + 
       stat_summary(data = Data_2_IKD, 
                    aes("Metaphase #2", `Inter-kinetochore distance`), 
                    fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
IKD <- IKD + 
       geom_quasirandom(data = Data_3_IKD, aes("Metaphase #3", `Inter-kinetochore distance`), 
                        color = "brown4",  shape = 17, size = 1.5) +
       stat_summary(data = Data_3_IKD, 
                    aes("Metaphase #3", `Inter-kinetochore distance`), 
                    fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
IKD <- IKD + 
       geom_quasirandom(data = IKD_avg, aes("Avg.", `Inter-kinetochore distance`), 
                        color = "grey20", shape = 16, size = 1.5) + 
       stat_summary(data = IKD_avg, 
                   aes("Avg.", `Inter-kinetochore distance`), 
                   fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

print(IKD)

# Fig 2: No. of KMTs per k-fiber
No_KMTs_avg <- rbind(Data_1_KMT_No, Data_2_KMT_No, Data_3_KMT_No)

No_KMTs <- ggplot(Data_1_KMT_No, aes("Metaphase #1", KMTs_per_kinetochore)) + 
           geom_quasirandom(method = "tukeyDense", color = "brown1", shape = 15, size = 1.5) +
           stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange") + 
           theme_classic()
No_KMTs <- No_KMTs + 
           geom_quasirandom(data = Data_2_KMT_No, aes("Metaphase #2", KMTs_per_kinetochore), 
                            method = "tukeyDense", color = "brown3", shape = 16, size = 1.5) + 
           stat_summary(data = Data_2_KMT_No,
                        aes("Metaphase #2", KMTs_per_kinetochore), 
                        fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
No_KMTs <- No_KMTs + 
  geom_quasirandom(data = Data_3_KMT_No, aes("Metaphase #3", KMTs_per_kinetochore), 
                   method = "tukeyDense", color = "brown4", shape = 17, size = 1.5) + 
  stat_summary(data = Data_3_KMT_No,
               aes("Metaphase #3", KMTs_per_kinetochore), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
No_KMTs <- No_KMTs + 
  geom_quasirandom(data = No_KMTs_avg, aes("Avg.", KMTs_per_kinetochore), 
                   method = "tukeyDense", color = "darkred", shape = 16, size = 1.5) + 
  stat_summary(data = No_KMTs_avg,
               aes("Avg.", KMTs_per_kinetochore), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

print(No_KMTs)

IKD_KMT_avg <- rbind(Data_1_IKD_KMT_No, Data_2_IKD_KMT_No, Data_3_IKD_KMT_No)
IKD_KMT_NO <- ggplot(Data_1_IKD_KMT_No, aes(`Inter-kinetochore distance`, `KMTs no.`)) + 
              geom_point(color = "brown1", shape = 15, size = 2) + theme_classic() + xlim(0.5, 1.75)
IKD_KMT_NO <- IKD_KMT_NO +
  geom_point(data = Data_2_IKD_KMT_No, aes(`Inter-kinetochore distance`, `KMTs no.`), color = "brown3", shape = 16, size = 2)
IKD_KMT_NO <- IKD_KMT_NO +
  geom_point(data = Data_3_IKD_KMT_No, aes(`Inter-kinetochore distance`, `KMTs no.`), color = "brown4", shape = 17, size = 2)

Correlation <- tibble(
  Data_1 = cor(Data_1_IKD_KMT_No$`Inter-kinetochore distance`, Data_1_IKD_KMT_No$`KMTs no.`),
  Data_2 = cor(Data_2_IKD_KMT_No$`Inter-kinetochore distance`, Data_2_IKD_KMT_No$`KMTs no.`),
  Data_3 = cor(Data_3_IKD_KMT_No$`Inter-kinetochore distance`, Data_3_IKD_KMT_No$`KMTs no.`),
  AVG = cor(IKD_KMT_avg$`Inter-kinetochore distance`, IKD_KMT_avg$`KMTs no.`)
)
Correlation

print(IKD_KMT_NO)

IKD_dekta_avg <- rbind(Data_1_IKD_KMT_Delta, Data_2_IKD_KMT_Delta, Data_3_IKD_KMT_Delta)
IKD_delta_NO <- ggplot(Data_1_IKD_KMT_Delta, aes(`Inter-kinetochore distance`, `Delta of KMTs`)) + 
  geom_point(color = "brown1", shape = 15, size = 2) + theme_classic() + xlim(0.5, 1.75)
IKD_delta_NO <- IKD_delta_NO +
  geom_point(data = Data_2_IKD_KMT_Delta, aes(`Inter-kinetochore distance`, `Delta of KMTs`), color = "brown3", shape = 16, size = 2)
IKD_delta_NO <- IKD_delta_NO +
  geom_point(data = Data_3_IKD_KMT_Delta, aes(`Inter-kinetochore distance`, `Delta of KMTs`), color = "brown4", shape = 17, size = 2)

Correlation <- tibble(
  Data_1 = cor(Data_1_IKD_KMT_Delta$`Inter-kinetochore distance`, Data_1_IKD_KMT_Delta$`Delta of KMTs`),
  Data_2 = cor(Data_2_IKD_KMT_Delta$`Inter-kinetochore distance`, Data_2_IKD_KMT_Delta$`Delta of KMTs`),
  Data_3 = cor(Data_3_IKD_KMT_Delta$`Inter-kinetochore distance`, Data_3_IKD_KMT_Delta$`Delta of KMTs`),
  AVG = cor(IKD_dekta_avg$`Inter-kinetochore distance`, IKD_dekta_avg$`Delta of KMTs`)
)
Correlation

print(IKD_delta_NO)

# Fig 3: Length distribution
LD_avg <- rbind(Data_1_LD, Data_2_LD, Data_3_LD)

LD <- ggplot(Data_1_LD, aes("Metaphase #1", length)) + 
      geom_quasirandom(method = "tukeyDense", color = "brown1", shape = 15, size = 1.5) + 
      stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange") + 
      theme_classic()
LD <- LD + 
      geom_quasirandom(data = Data_2_LD, aes("Metaphase #2", length), 
                       method = "tukeyDense", color = "brown3", shape = 16, size = 1.5) + 
      stat_summary(data = Data_2_LD,
                   aes("Metaphase #2", length), 
                   fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
LD <- LD + 
      geom_quasirandom(data = Data_3_LD, aes("Metaphase #3", length), 
                   method = "tukeyDense", color = "brown4", shape = 17, size = 1.5) + 
      stat_summary(data = Data_3_LD,
               aes("Metaphase #3", length), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
LD <- LD + 
      geom_quasirandom(data = LD_avg, aes("Avg.", length), 
                   method = "tukeyDense", color = "darkred", shape = 16, size = 1.5) + 
      stat_summary(data = LD_avg,
               aes("Avg.", length), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
print(LD)

# Fig 3: Minus ends distance and distribution

Data_1 <- ggplot_build(ggplot(Data_1_KMT_Minus_Ends, aes(minus_dist_to_pole)) + 
                              geom_density())$data[[1]]
Data_1 <- as.numeric(FWHM(Data_1$x, Data_1$y, 2)[2])

Data_2 <- ggplot_build(ggplot(Data_2_KMT_Minus_Ends, aes(minus_dist_to_pole)) + 
                              geom_density())$data[[1]]
y_max <- Data_2[which.max(Data_2$y),1]/1.2   # Data show double pick to account for that FWHM is taken only for the first peak
Data_2 <- Data_2[as.numeric(which.max(Data_2$y)+1):nrow(Data_2),]
Data_2 <- as.numeric(Data_2[which(abs(Data_2$y - y_max) == min(abs(Data_2$y - y_max))),]$x)

Data_3 <- ggplot_build(ggplot(Data_3_KMT_Minus_Ends, aes(minus_dist_to_pole)) + 
                         geom_density())$data[[1]]
Data_3 <- as.numeric(FWHM(Data_3$x, Data_3$y, 2)[2])

Minus_Ends_avg <- rbind(Data_1_KMT_Minus_Ends, Data_2_KMT_Minus_Ends, Data_3_KMT_Minus_Ends)

MInus_Ends <- ggplot(Data_1_KMT_Minus_Ends, aes("Metaphase #1", minus_dist_to_pole)) + 
              geom_quasirandom(method = "tukeyDense", color = "brown1", shape = 15, size = 1.5) + 
              stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange") + 
              theme_classic()
MInus_Ends <- MInus_Ends + 
              geom_quasirandom(data = Data_2_KMT_Minus_Ends, aes("Metaphase #2", minus_dist_to_pole), 
                               method = "tukeyDense", color = "brown3", shape = 16, size = 1.5) + 
              stat_summary(data = Data_2_KMT_Minus_Ends,
                           aes("Metaphase #2", minus_dist_to_pole), 
                           fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
MInus_Ends <- MInus_Ends + 
              geom_quasirandom(data = Data_3_KMT_Minus_Ends, aes("Metaphase #3", minus_dist_to_pole), 
                               method = "tukeyDense", color = "brown4", shape = 17, size = 1.5) + 
              stat_summary(data = Data_3_KMT_Minus_Ends,
                          aes("Metaphase #3", minus_dist_to_pole), 
                          fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
MInus_Ends <- MInus_Ends + 
              geom_quasirandom(data = Minus_Ends_avg, aes("Avg.", minus_dist_to_pole), 
                               method = "tukeyDense", color = "darkred", shape = 16, size = 1.5) + 
              stat_summary(data = Minus_Ends_avg,
                           aes("Avg.", minus_dist_to_pole), 
                           fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
print(MInus_Ends)

Minus_Position <- ggplot(Data_1_KMT_Minus_Ends, aes("Metaphase #1", Relative_minus_position))+ 
                  geom_quasirandom(method = "tukeyDense", color = "brown1", shape = 15, size = 1.5) + 
                  stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange") + 
                  theme_classic()
Minus_Position <- Minus_Position + 
                  geom_quasirandom(data = Data_2_KMT_Minus_Ends, aes("Metaphase #2", Relative_minus_position), 
                                   method = "tukeyDense", color = "brown3", shape = 16, size = 1.5) + 
                  stat_summary(data = Data_2_KMT_Minus_Ends,
                               aes("Metaphase #2", Relative_minus_position), 
                               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
Minus_Position <- Minus_Position + 
                  geom_quasirandom(data = Data_3_KMT_Minus_Ends, aes("Metaphase #3", Relative_minus_position), 
                                   method = "tukeyDense", color = "brown4", shape = 17, size = 1.5) + 
                  stat_summary(data = Data_3_KMT_Minus_Ends,
                               aes("Metaphase #3", Relative_minus_position), 
                               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
Minus_Position <- Minus_Position + 
                  geom_quasirandom(data = Minus_Ends_avg, aes("Avg.", Relative_minus_position), 
                                   method = "tukeyDense", color = "darkred", shape = 16, size = 1.5) + 
                  stat_summary(data = Minus_Ends_avg,
                               aes("Avg.", Relative_minus_position), 
                               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

print(Minus_Position)

# Fig 4: Tortuosity 

Tortuosity_avg <- rbind(Data_1_KMT_Total_Curv, Data_2_KMT_Total_Curv, Data_3_KMT_Total_Curv)

Tortuosity <- ggplot(Data_1_KMT_Total_Curv, aes("Metaphase #1", Curvature)) + 
              geom_quasirandom(method = "tukeyDense", color = "brown1", shape = 15, size = 1.5) + 
              stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange") + 
              theme_classic()
Tortuosity <- Tortuosity + 
              geom_quasirandom(data = Data_2_KMT_Total_Curv, aes("Metaphase #2", Curvature), 
                               method = "tukeyDense", color = "brown3", shape = 16, size = 1.5) + 
              stat_summary(data = Data_2_KMT_Total_Curv,
                           aes("Metaphase #2", Curvature), 
                           fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
Tortuosity <- Tortuosity + 
              geom_quasirandom(data = Data_3_KMT_Total_Curv, aes("Metaphase #3", Curvature), 
                               method = "tukeyDense", color = "brown4", shape = 17, size = 1.5) + 
              stat_summary(data = Data_3_KMT_Total_Curv,
                           aes("Metaphase #3", Curvature), 
                           fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
Tortuosity <- Tortuosity + 
              geom_quasirandom(data = Tortuosity_avg, aes("Avg.", Curvature), 
                               method = "tukeyDense", color = "grey20", shape = 16, size = 1.5) + 
              stat_summary(data = Tortuosity_avg,
                           aes("Avg.", Curvature), 
                           fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
print(Tortuosity)

# Fig 4: Tortuosity vs length

 Tortuosity_length <- ggplot(Data_1_KMT_Total_Curv, aes(`KMTs length`, Curvature)) + 
                      geom_jitter(shape = 15, color = "brown1") + 
                      theme_classic()
 Tortuosity_length <- Tortuosity_length +
                      geom_point(data = Data_2_KMT_Total_Curv, aes(`KMTs length`, Curvature), shape = 16, color = "brown3") 
 Tortuosity_length <- Tortuosity_length +
                      geom_point(data = Data_3_KMT_Total_Curv, aes(`KMTs length`, Curvature), shape = 17, color = "brown4")
 Tortuosity_length <- Tortuosity_length +
                      geom_smooth(data = Tortuosity_avg, aes(`KMTs length`, Curvature), se = F, color = "grey20", size = 2, method = "loess") 
 
 print(Tortuosity_length)
 
# Fig 4: Local tortuosity
 Tortuosity_local_avg <- rbind(Data_1_KMT_Local_Curv, Data_2_KMT_Local_Curv, Data_3_KMT_Local_Curv)
 
 Tortuosity_local <- ggplot(Data_1_KMT_Local_Curv, aes(Relative_Position, Curvature)) + 
                     geom_jitter(shape = 15, color = "brown1") +
                     theme_classic() + ylim(1,1.1)
 Tortuosity_local <- Tortuosity_local +
                     geom_point(data = Data_2_KMT_Local_Curv, aes(Relative_Position, Curvature), shape = 16, color = "brown3") 
 Tortuosity_local <- Tortuosity_local +
                     geom_point(data = Data_3_KMT_Local_Curv, aes(Relative_Position, Curvature), shape = 17, color = "brown4")
 Tortuosity_local <- Tortuosity_local +
                     geom_smooth(data = Tortuosity_local_avg, aes(Relative_Position, Curvature), se = F, color = "grey20", size = 2, method = "loess") 
 
 print(Tortuosity_local)
 

 cor(Tortuosity_local_avg$Curvature, Tortuosity_local_avg$Relative_Position)
 
 # Fig 5: Fiber area
 Area_avg <- rbind(Data_1_Fiber_Area,Data_2_Fiber_Area,Data_3_Fiber_Area)

 Fiber_area <- ggplot(Data_1_Fiber_Area, aes(Relative_position, Alpha_area)) + 
               geom_smooth(color = "brown1",se=F, method = "loess", formula = "y~x") + 
               theme_classic()
 
 Fiber_area <- Fiber_area + 
               geom_smooth(data = Data_2_Fiber_Area, aes(Relative_position, Alpha_area),
                           color = "brown3",se=F, method = "loess", formula = "y~x")
 
 Fiber_area <- Fiber_area + 
               geom_smooth(data = Data_3_Fiber_Area, aes(Relative_position, Alpha_area),
                           color = "brown4",se=F, method = "loess", formula = "y~x")
 
 Fiber_area <- Fiber_area + 
               geom_smooth(data = Area_avg, aes(Relative_position, Alpha_area),
                 
                                     color = "grey20",se=T, method = "loess", formula = "y~x")
 print(Fiber_area)
 
 # Fig 5: Fiber density
 Density_avg <- rbind(Data_1_N_Density,Data_2_N_Density,Data_3_N_Density)
 
 Fiber_denisty <- ggplot(Data_1_N_Density, aes(Relative_position, `Focused KMTs %`)) + 
   geom_smooth(color = "brown1",se=F, method = "loess", formula = "y~x") + 
   theme_classic() + ylim(0,100)
 
 Fiber_denisty <- Fiber_denisty + 
   geom_smooth(data = Data_2_N_Density, aes(Relative_position, `Focused KMTs %`),
               color = "brown3",se=F, method = "loess", formula = "y~x")
 
 Fiber_denisty <- Fiber_denisty + 
   geom_smooth(data = Data_3_N_Density, aes(Relative_position, `Focused KMTs %`),
               color = "brown4",se=F, method = "loess", formula = "y~x")
 
 Fiber_denisty <- Fiber_denisty + 
   geom_smooth(data = Density_avg, aes(Relative_position, `Focused KMTs %`),
               color = "grey20",se=T, method = "loess", formula = "y~x")
 print(Fiber_denisty)
 
 
# Supplementary 5: Kinetochore size

 Kinetochores_size_avg <- rbind(Data_1_K_Core_Area, Data_2_K_Core_Area, Data_3_K_Core_Area)
 K_Core_size <- ggplot(Kinetochores_size_avg, aes(Kinetochore_area, KMT_no)) +
                stat_ellipse(color = "grey20", size = 1, level = 0.95) + 
                theme_classic()
 K_Core_size <- K_Core_size + 
                geom_point(data = Data_1_K_Core_Area, aes(Kinetochore_area, KMT_no), color = "brown3", shape = 15)
 K_Core_size <- K_Core_size + 
                geom_point(data = Data_2_K_Core_Area, aes(Kinetochore_area, KMT_no), color = "brown3", shape = 16)
 K_Core_size <- K_Core_size + 
                geom_point(data = Data_3_K_Core_Area, aes(Kinetochore_area, KMT_no), color = "brown4", shape = 17)
print(K_Core_size) 


# Supplementary 6: SMTs minus-ends

SMTs_avg <- rbind(Data_1_SMT_Ends, Data_2_SMT_Ends, Data_3_SMT_Ends)
Data_avg <- ggplot_build(ggplot(SMTs_avg, aes(Dist)) + 
                           geom_density())$data[[1]]

Data_FHWM <- as.numeric(FWHM(Data_avg$x, Data_avg$y, 1))
Data_FHWM <- (Data_FHWM[1] * 2) - Data_avg[1,2] #Double a distance of the peak to the pole - initial gap of not interaction (centrioles itself)

SMTs <- ggplot(SMTs_avg, aes("Avg", Dist)) + geom_quasirandom(size = 1.5, color = "grey20") +
        theme_classic() +
        stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom ="pointrange") +
        geom_hline(yintercept = Data_FHWM)
SMTs <- SMTs +
        geom_quasirandom(data = Data_1_SMT_Ends, aes("#1", Dist), color = "brown1", size = 1.5, shape = 15) +
        stat_summary(data = Data_1_SMT_Ends, aes("#1", Dist), fun.data="mean_sdl", fun.args = list(mult=1), geom ="pointrange")
SMTs <- SMTs +
        geom_quasirandom(data = Data_2_SMT_Ends, aes("#2", Dist), color = "brown3", size = 1.5, shape = 16) +
        stat_summary(data = Data_2_SMT_Ends, aes("#2", Dist), fun.data="mean_sdl", fun.args = list(mult=1), geom ="pointrange")
SMTs <- SMTs +
        geom_quasirandom(data = Data_3_SMT_Ends, aes("#3", Dist), color = "brown4", size = 1.5, shape = 17) +
        stat_summary(data = Data_3_SMT_Ends, aes("#3", Dist), fun.data="mean_sdl", fun.args = list(mult=1), geom ="pointrange")
print(SMTs)

# MT-MT interaction

Minus_seed_avg <- rbind(Data_1_KMTs_minus_seed, Data_2_KMTs_minus_seed, Data_3_KMTs_minus_seed)

Minus_Seed <- ggplot(filter(Data_1_KMTs_minus_seed, I_class == "KMT"), aes(Relative_pos)) + geom_freqpoly(color = "tomato1") + theme_classic() + ylim(0,100)
Minus_Seed <- Minus_Seed + geom_freqpoly(data = filter(Data_2_KMTs_minus_seed, I_class == "KMT"), aes(Relative_pos), color = "red1")
Minus_Seed <- Minus_Seed + geom_freqpoly(data = filter(Data_3_KMTs_minus_seed, I_class == "KMT"), aes(Relative_pos), color = "salmon1")
Minus_Seed <- Minus_Seed + geom_freqpoly(data = filter(Minus_seed_avg, I_class == "KMT"), aes(Relative_pos), color = "grey20")
print(Minus_Seed)
Minus_Seed <- ggplot(filter(Data_1_KMTs_minus_seed, I_class == "SMT"), aes(Relative_pos)) + geom_freqpoly(color = "darkorange1") + theme_classic() + ylim(0,100)
Minus_Seed <- Minus_Seed + geom_freqpoly(data = filter(Data_2_KMTs_minus_seed, I_class == "SMT"), aes(Relative_pos), color = "tan1")
Minus_Seed <- Minus_Seed + geom_freqpoly(data = filter(Data_3_KMTs_minus_seed, I_class == "SMT"), aes(Relative_pos), color = "gold3")
Minus_Seed <- Minus_Seed + geom_freqpoly(data = filter(Minus_seed_avg, I_class == "SMT"), aes(Relative_pos), color = "grey50")

print(Minus_Seed)

# KMTs minus end interaction
KMT_Minus_End_Interaction <- rbind(Data_1_KMT_Minus_End_Interaction, Data_2_KMT_Minus_End_Interaction, Data_3_KMT_Minus_End_Interaction)

KMT_Minus_End_Data <- tibble(ALL_KMT = nrow(filter(KMT_Minus_End_Interaction, MT_type == "KMT"))/ 2689,
                             ALL_SMT = nrow(filter(KMT_Minus_End_Interaction, MT_type == "SMT"))/ 2689,
                             ALL_KMT_1 = nrow(filter(Data_1_KMT_Minus_End_Interaction, MT_type == "KMT"))/ 792,
                             ALL_KMT_2 = nrow(filter(Data_2_KMT_Minus_End_Interaction, MT_type == "KMT") / 1147),
                             ALL_KMT_3 = nrow(filter(Data_3_KMT_Minus_End_Interaction, MT_type == "KMT") / 750),
                             ALL_SMT_1 = nrow(filter(Data_1_KMT_Minus_End_Interaction, MT_type == "SMT"))/ 792,
                             ALL_SMT_2 = nrow(filter(Data_2_KMT_Minus_End_Interaction, MT_type == "SMT") / 1147),
                             ALL_SMT_3 = nrow(filter(Data_3_KMT_Minus_End_Interaction, MT_type == "SMT") / 750),
                             
)
KMT_Minus_End_Data <- tibble(
  Data = c( 
    nrow(filter(KMT_Minus_End_Interaction, MT_type == "KMT")) / 2689,
    nrow(filter(KMT_Minus_End_Interaction, MT_type == "SMT")) / 2689,
    nrow(filter(Data_1_KMT_Minus_End_Interaction, MT_type == "KMT"))/ 792,
    nrow(filter(Data_2_KMT_Minus_End_Interaction, MT_type == "KMT")) / 1147,
    nrow(filter(Data_3_KMT_Minus_End_Interaction, MT_type == "KMT")) / 750,
    nrow(filter(Data_1_KMT_Minus_End_Interaction, MT_type == "SMT")) / 792,
    nrow(filter(Data_2_KMT_Minus_End_Interaction, MT_type == "SMT")) / 1147,
    nrow(filter(Data_3_KMT_Minus_End_Interaction, MT_type == "SMT")) / 750,
    nrow(filter(KMT_Minus_End_Interaction, MT_type == "KMT" & KMT_Minus_Distance >= 1.53)) / 1322,
    nrow(filter(KMT_Minus_End_Interaction, MT_type == "SMT" & KMT_Minus_Distance >= 1.53)) / 1322,
    nrow(filter(Data_1_KMT_Minus_End_Interaction, MT_type == "KMT" & KMT_Minus_Distance >= 1.53))/ 295,
    nrow(filter(Data_2_KMT_Minus_End_Interaction, MT_type == "KMT" & KMT_Minus_Distance >= 1.53)) / 726,
    nrow(filter(Data_3_KMT_Minus_End_Interaction, MT_type == "KMT" & KMT_Minus_Distance >= 1.53)) / 301,
    nrow(filter(Data_1_KMT_Minus_End_Interaction, MT_type == "SMT" & KMT_Minus_Distance >= 1.53)) / 295,
    nrow(filter(Data_2_KMT_Minus_End_Interaction, MT_type == "SMT" & KMT_Minus_Distance >= 1.53)) / 726,
    nrow(filter(Data_3_KMT_Minus_End_Interaction, MT_type == "SMT" & KMT_Minus_Distance >= 1.53)) / 301
  ),
  Label = c(
    "ALL_KMT",
    "ALL_SMT",
    "ALL_KMT_1",
    "ALL_KMT_2",
    "ALL_KMT_3",
    "ALL_SMT_1",
    "ALL_SMT_2",
    "ALL_SMT_3",
    "Pole_KMT",
    "Pole_SMT",
    "Pole_KMT_1",
    "Pole_KMT_2",
    "Pole_KMT_3",
    "Pole_SMT_1",
    "Pole_SMT_2",
    "Pole_SMT_3"
  ))

ggplot(KMT_Minus_End_Data, aes(Label, weight = Data)) + geom_bar() + theme_classic()

p1 <- ggplot(KMT_Minus_End_Interaction, aes(Relative_position)) + geom_freqpoly(color="grey20") + theme_classic() + ylim(0,80)
p1 <- p1 + geom_freqpoly(data = filter(KMT_Minus_End_Interaction, MT_type == "KMT"), aes(Relative_position),
                        color = "red")
p1 <- p1 + geom_freqpoly(data = filter(KMT_Minus_End_Interaction, MT_type == "SMT"), aes(Relative_position),
                        color = "orange")
p1

p1 <- ggplot(filter(KMT_Minus_End_0.1, KMT_Minus_Distance >= 1.53 & MT_type == "KMT" | KMT_Minus_Distance >= 1.53 & MT_type == "SMT"), 
             aes(Relative_position)) + 
  geom_freqpoly(color="grey20") + theme_classic()  + ylim(0,30)
p1 <- p1 + geom_freqpoly(data = filter(KMT_Minus_End_0.1, MT_type == "KMT" & KMT_Minus_Distance >= 1.53), aes(Relative_position),
                         color = "red")
p1 <- p1 + geom_freqpoly(data = filter(KMT_Minus_End_0.1, MT_type == "SMT" & KMT_Minus_Distance >= 1.53), aes(Relative_position),
                         color = "orange")
p1

# MT-MT interactions

for(i in 1:nrow(Data_1_MT_Interaction)){
  if(Data_1_MT_Interaction$Segments_ID_1[i] %in% Segments_KMT$`Segment ID`){
    Data_1_MT_Interaction[i,8] <- "KMT"
  } else {
    Data_1_MT_Interaction[i,8] <- "SMT"
  }
}

for(i in 1:nrow(Data_2_MT_Interaction)){
  if(Data_2_MT_Interaction$Segments_ID_1[i] %in% Segments_KMT$`Segment ID`){
    Data_2_MT_Interaction[i,8] <- "KMT"
  } else {
    Data_2_MT_Interaction[i,8] <- "SMT"
  }
}

for(i in 1:nrow(Data_3_MT_Interaction)){
  if(Data_3_MT_Interaction$Segments_ID_1[i] %in% Segments_KMT$`Segment ID`){
    Data_3_MT_Interaction[i,8] <- "KMT"
  } else {
    Data_3_MT_Interaction[i,8] <- "SMT"
  }
}

AVG_MT_Interaction <- tibble()
coutnter <- 1
for(i in unique(Data_1_MT_Interaction$Segments_ID_1)){
  AVG_MT_Interaction[coutnter,1] <- sum(filter(Data_1_MT_Interaction, `Segments_ID_1` == i)$Length)
  AVG_MT_Interaction[coutnter,2] <- nrow(filter(Data_1_MT_Interaction, `Segments_ID_1` == i))
  coutnter <- coutnter+1
}

coutnter <- 1
for(i in unique(Data_2_MT_Interaction$Segments_ID_1)){
  AVG_MT_Interaction[coutnter,3] <- sum(filter(Data_2_MT_Interaction, `Segments_ID_1` == i)$Length)
  AVG_MT_Interaction[coutnter,4] <- nrow(filter(Data_2_MT_Interaction, `Segments_ID_1` == i))
  coutnter <- coutnter+1
}
coutnter <- 1
for(i in unique(Data_3_MT_Interaction$Segments_ID_1)){
  AVG_MT_Interaction[coutnter,5] <- sum(filter(Data_3_MT_Interaction, `Segments_ID_1` == i)$Length)
  AVG_MT_Interaction[coutnter,6] <- nrow(filter(Data_3_MT_Interaction, `Segments_ID_1` == i))
  coutnter <- coutnter+1
}

AVG_Inter_length <- ggplot(na.omit(AVG_MT_Interaction), aes("#1", `...1`)) + geom_quasirandom(shape = 15, size = 1.5, color = "grey10") + theme_classic() + 
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#2", `...3`), shape = 16, size = 1.5, color = "grey20") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#2", `...3`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#3", `...5`), shape = 17, size = 1.5, color = "grey30") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#3", `...5`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

AVG_Inter_length

AVG_Inter_length <- ggplot(na.omit(AVG_MT_Interaction), aes("#1", `...2`)) + geom_quasirandom(shape = 15, size = 1.5, color = "grey10") + theme_classic() + 
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#2", `...4`), shape = 16, size = 1.5, color = "grey20") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#2", `...4`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#3", `...6`), shape = 17, size = 1.5, color = "grey30") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#3", `...6`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

AVG_Inter_length

AVG_MT_Interaction <- tibble()
coutnter <- 1
for(i in unique(filter(Data_1_MT_Interaction, `...8` == "SMT")$Segments_ID_1)){
  AVG_MT_Interaction[coutnter,1] <- sum(filter(Data_1_MT_Interaction, `Segments_ID_1` == i)$Length)
  AVG_MT_Interaction[coutnter,2] <- nrow(filter(Data_1_MT_Interaction, `Segments_ID_1` == i))
  coutnter <- coutnter+1
}

coutnter <- 1
for(i in unique(filter(Data_2_MT_Interaction, `...8` == "SMT")$Segments_ID_1)){
  AVG_MT_Interaction[coutnter,3] <- sum(filter(Data_2_MT_Interaction, `Segments_ID_1` == i)$Length)
  AVG_MT_Interaction[coutnter,4] <- nrow(filter(Data_2_MT_Interaction, `Segments_ID_1` == i))
  coutnter <- coutnter+1
}
coutnter <- 1
for(i in unique(filter(Data_3_MT_Interaction, `...8` == "SMT")$Segments_ID_1)){
  AVG_MT_Interaction[coutnter,5] <- sum(filter(Data_3_MT_Interaction, `Segments_ID_1` == i)$Length)
  AVG_MT_Interaction[coutnter,6] <- nrow(filter(Data_3_MT_Interaction, `Segments_ID_1` == i))
  coutnter <- coutnter+1
}

AVG_Inter_length <- ggplot(na.omit(AVG_MT_Interaction), aes("#1", `...1`)) + geom_quasirandom(shape = 15, size = 1.5, color = "orange1") + theme_classic() + 
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#2", `...3`), shape = 16, size = 1.5, color = "orange2") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#2", `...3`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#3", `...5`), shape = 17, size = 1.5, color = "orange3") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#3", `...5`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

AVG_Inter_length

AVG_Inter_length <- ggplot(na.omit(AVG_MT_Interaction), aes("#1", `...2`)) + geom_quasirandom(shape = 15, size = 1.5, color = "orange1") + theme_classic() + 
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#2", `...4`), shape = 16, size = 1.5, color = "orange2") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#2", `...4`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#3", `...6`), shape = 17, size = 1.5, color = "orange3") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#3", `...6`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

AVG_Inter_length

AVG_MT_Interaction <- tibble()
coutnter <- 1
for(i in unique(filter(Data_1_MT_Interaction, `...8` == "KMT")$Segments_ID_1)){
  AVG_MT_Interaction[coutnter,1] <- sum(filter(Data_1_MT_Interaction, `Segments_ID_1` == i)$Length)
  AVG_MT_Interaction[coutnter,2] <- nrow(filter(Data_1_MT_Interaction, `Segments_ID_1` == i))
  coutnter <- coutnter+1
}

coutnter <- 1
for(i in unique(filter(Data_2_MT_Interaction, `...8` == "KMT")$Segments_ID_1)){
  AVG_MT_Interaction[coutnter,3] <- sum(filter(Data_2_MT_Interaction, `Segments_ID_1` == i)$Length)
  AVG_MT_Interaction[coutnter,4] <- nrow(filter(Data_2_MT_Interaction, `Segments_ID_1` == i))
  coutnter <- coutnter+1
}
coutnter <- 1
for(i in unique(filter(Data_3_MT_Interaction, `...8` == "KMT")$Segments_ID_1)){
  AVG_MT_Interaction[coutnter,5] <- sum(filter(Data_3_MT_Interaction, `Segments_ID_1` == i)$Length)
  AVG_MT_Interaction[coutnter,6] <- nrow(filter(Data_3_MT_Interaction, `Segments_ID_1` == i))
  coutnter <- coutnter+1
}

AVG_Inter_length <- ggplot(na.omit(AVG_MT_Interaction), aes("#1", `...1`)) + geom_quasirandom(shape = 15, size = 1.5, color = "red1") + theme_classic() + 
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#2", `...3`), shape = 16, size = 1.5, color = "red2") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#2", `...3`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#3", `...5`), shape = 17, size = 1.5, color = "red3") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#3", `...5`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

AVG_Inter_length

AVG_Inter_length <- ggplot(na.omit(AVG_MT_Interaction), aes("#1", `...2`)) + geom_quasirandom(shape = 15, size = 1.5, color = "red1") + theme_classic() + 
  stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange") + ylim(0,32)
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#2", `...4`), shape = 16, size = 1.5, color = "red2") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#2", `...4`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")
AVG_Inter_length <- AVG_Inter_length + 
  geom_quasirandom(data = na.omit(AVG_MT_Interaction), aes("#3", `...6`), shape = 17, size = 1.5, color = "red3") +
  stat_summary(data = na.omit(AVG_MT_Interaction),
               aes("#3", `...6`), 
               fun.data="mean_sdl", fun.args = list(mult=1), geom="pointrange")

AVG_Inter_length
