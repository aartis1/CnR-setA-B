#!/bin/bash
#SBATCH --job-name=CnR setA-B MO data		                        # Job name
#SBATCH --partition=batch		                            # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=2		                            # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=40gb			                                # Total memory for job
#SBATCH --time=2:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output=/home/ara67776/work/CnR/Setdb1/error			    # Location of standard output and error log files (replace cbergman with your myid)
#SBATCH --mail-user=ara67776@uga.edu                    # Where to send mail (replace cbergman with your myid)
#SBATCH --mail-type=ALL                            # Mail events (BEGIN, END, FAIL, ALL)


#set output directory
OUTDIR="/home/ara67776/work/CnR/Setdb1"

#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi

 
