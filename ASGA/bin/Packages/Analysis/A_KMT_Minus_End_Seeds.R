################################################################################
# Packages KMT_Minus_End_Seeds
#
# (c) 2019 Kiewisz
# This code is licensed under GPL V3.0 license (see LICENSE.txt for details)
#
# Author: Robert Kiewisz
# Created: 2020-05-17
# Reviewed: Robert Kiewisz 28/08/2020 (v0.31.1)
################################################################################

# Set-up analysis --------------------------------------------------------------
A_KMT_Minus_End_Seeds <- function(input, output, session) {

  # Analyze (-) ends nucleation from the KMT for Pole1 ---------------------------
  total <- as.numeric(length(which(colnames(Segments) == "Pole1_00"):as.numeric(which(colnames(Segments) == "Pole2_00"))) - 1)
  
  if (SEED_INT_AS_FUNCTION == TRUE) {
    MINUS_DISTANCE <<- 0.035
  } else {
    Function_Scale_Seed <<- list(MINUS_DISTANCE)
  }
  
  progressSweetAlert(
    session = session,
    id = "P_nucleation1",
    title = "Calculating (-) nucleated from the KMT for the Pole1...",
    display_pct = TRUE,
    value = 0
  )

  KMTs_minus_seed_P1 <- Minus_end_seed(which(colnames(Segments) == "Pole1_00"))

  for (i in as.numeric(which(colnames(Segments) == "Pole1_00") + 1):as.numeric(which(colnames(Segments) == "Pole2_00") - 1)) {
    tryCatch(
      {
        assign(
          "DF",
          Minus_end_seed(i)
        )
        KMTs_minus_seed_P1 <- rbind(KMTs_minus_seed_P1, DF)
      },
      error = function(e) {}
    )

    updateProgressBar(
      session = session,
      id = "P_nucleation1",
      value = round((i - 1) / total * 100, 0)
    )
    Sys.sleep(0.1)
  }

  KMTs_minus_seed_P1 <<- KMTs_minus_seed_P1
  closeSweetAlert(session = session)

  # Analyze (-) ends nucleation from the KMT for Pole2 ---------------------------
  total <- which(colnames(Segments) == colnames(Segments %>% select(starts_with("Pole")))[ncol(Segments %>% select(starts_with("Pole")))]) -
    as.numeric(which(colnames(Segments) == "Pole2_00") - 1)

  progressSweetAlert(
    session = session,
    id = "P_nucleation2",
    title = "Calculating (-) nucleated from the KMT for the Pole2...",
    display_pct = TRUE,
    value = 0
  )

  if (nrow(Pole2_00) == 0) {
    KMTs_minus_seed_P2 <- data.frame()
  } else {
    KMTs_minus_seed_P2 <- Minus_end_seed(which(colnames(Segments) == "Pole2_00"))
  }

  for (i in as.numeric(which(colnames(Segments) == "Pole2_00") + 1):as.numeric(ncol(Segments) - 4)) {
    tryCatch(
      {
        assign(
          "DF",
          Minus_end_seed(i)
        )
        KMTs_minus_seed_P2 <- rbind(KMTs_minus_seed_P2, DF)
      },
      error = function(e) {}
    )
    updateProgressBar(
      session = session,
      id = "P_nucleation2",
      value = round((i - as.numeric(which(colnames(Segments) == "Pole2_00") - 1)) / total * 100, 0)
    )
    Sys.sleep(0.1)
  }

  KMTs_minus_seed_P2 <<- KMTs_minus_seed_P2
  closeSweetAlert(session = session)

  # Analyze (-) ends KMTs interaction with MT spline -----------------------------
  progressSweetAlert(
    session = session,
    id = "KMT_ends",
    title = "Calculating KMTs (-) end position around other MTs...",
    display_pct = TRUE,
    value = 0
  )

  # Define if analysis should be run as a function of distance or to run only for specified distance length
  if (SEED_INT_AS_FUNCTION == TRUE) {
    Function_Scale_Seed <<- list(0.025, 0.030, 0.035, 0.045, 0.050, 0.075, 0.1)
  } else {
    Function_Scale_Seed <<- list(MINUS_DISTANCE)
  }

  for (i in 1:length(Function_Scale_Seed)) {
    updateProgressBar(
      session = session,
      id = "KMT_ends",
      title = paste("Calculating KMTs (-) end position around other MTs for ", Function_Scale_Seed[i], "um...", sep = " "),
      value = round(as.numeric(i / length(Function_Scale_Seed)) * 100, 0)
    )
    Sys.sleep(0.1)

    MINUS_DISTANCE <<- as.numeric(Function_Scale_Seed[i])

    cores <<- detectCores()
    cl <<- makeCluster(cores)
    registerDoParallel(cl)

    KMT_Minus_End <<- foreach(
      i = 1:nrow(Segments_KMT), .combine = "rbind", .inorder = F,
      .export = c("Segments_KMT", "Nodes", "Points", "Pole1", "Pole2", "MINUS_DISTANCE", "KMT_Minus_End_Interaction"),
      .packages = "tibble"
    ) %dopar% {
      KMT_Minus_End_Interaction(i)
    }


    assign(paste("KMT_Minus_End", MINUS_DISTANCE, sep = "_"),
      KMT_Minus_End,
      envir = .GlobalEnv
    )
  }

  closeSweetAlert(session = session)
}
