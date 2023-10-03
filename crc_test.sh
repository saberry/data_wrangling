#!/bin/bash

#$ -pe mpi-24 24    # Specify parallel environment and legal core size
#$ -q debug         # Specify queue, debug is up to 4 hours, long is 14 days
#$ -N job_name      # Specify job name

module load R 
setenv R_LIBS ~/myRLibs

mpirun -np ${NSLOTS} Rscript crc_test.R > crc_test.out