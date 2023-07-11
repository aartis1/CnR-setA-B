#!/bin/bash
#SBATCH --job-name=CnR_setab_MO		                        # Job name
#SBATCH --partition=batch		                            # Partition (queue) name
#SBATCH --ntasks=1	                                # Single task job
#SBATCH --cpus-per-task=8		                            # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=60gb			                                # Total memory for job
#SBATCH --time=24:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output=/scratch/ara67776/CnR_setAB			    # Location of standard output and error log files (replace cbergman with your myid)
#SBATCH --mail-user=ara67776@uga.edu                    # Where to send mail (replace cbergman with your myid)
#SBATCH --mail-type=ALL                            # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --output=/home/ara67776/work/error/log.%j			    # Location of standard output and error log files (replace cbergman with your myid)

#set output directory
OUTDIR="/scratch/ara67776/CnR_setAB"
#
# #if output directory doesn't exist, create it
# if [ ! -d $OUTDIR ]
# then
#     mkdir -p $OUTDIR
# fi
# #download relevant reference genome and annotations
# curl -s https://ftp.ensembl.org/pub/release-109/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna_rm.primary_assembly.fa.gz | gunzip -c > $OUTDIR/danio-refseq.fa
# curl -s https://ftp.ensembl.org/pub/release-109/gtf/danio_rerio/Danio_rerio.GRCz11.109.gtf.gz | gunzip -c > $OUTDIR/danio_annotation.gtf
#
# #spike in for CnR
# curl -s https://ftp.ensembl.org/pub/release-109/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz | gunzip -c > sacc_refseq.fa
# curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/005/845/GCA_000005845.2_ASM584v2/GCA_000005845.2_ASM584v2_genomic.fna.gz | gunzip -c > ecoli_refseq.fa
# #transfer raw files from local computer to the cluster

# if [ ! -d $OUTDIR/trimmed ]
# then
#     echo "Directory $OUTDIR/trimmed exists."
# else
#   mkdir $OUTDIR/trimmed
# fi
#trim ends of raw data before adapters are taken off (trimming paired ends)
# module load Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4
#starting with raw files in $OUTDIR/raw
# trim_galore --fastqc -j 8 --output_dir $OUTDIR/trimmed --paired $OUTDIR/raw/10_gfp_MO_IgG_4_5h_1_S10_L001_R1_001.fastq.gz $OUTDIR/raw/10_gfp_MO_IgG_4_5h_1_S10_L001_R2_001.fastq.gz
# trim_galore --fastqc -j 8 --output_dir $OUTDIR/trimmed --paired $OUTDIR/raw/1_suvAB_MO_K9_4_5h_1_S1_L001_R1_001.fastq.gz $OUTDIR/raw/1_suvAB_MO_K9_4_5h_1_S1_L001_R2_001.fastq.gz
# trim_galore --fastqc -j 8 --output_dir $OUTDIR/trimmed --paired $OUTDIR/raw/3_suvAB_MO_K9_4_5h_3_S3_L001_R1_001.fastq.gz $OUTDIR/raw/3_suvAB_MO_K9_4_5h_3_S3_L001_R2_001.fastq.gz
# trim_galore --fastqc -j 8 --output_dir $OUTDIR/trimmed --paired $OUTDIR/raw/4_setAB_MO_K9_4_5h_1_S4_L001_R1_001.fastq.gz $OUTDIR/raw/4_setAB_MO_K9_4_5h_1_S4_L001_R2_001.fastq.gz
# trim_galore --fastqc -j 8 --output_dir $OUTDIR/trimmed --paired $OUTDIR/raw/5_setAB_MO_K9_4_5h_2_S5_L001_R1_001.fastq.gz $OUTDIR/raw/5_setAB_MO_K9_4_5h_2_S5_L001_R2_001.fastq.gz
# trim_galore --fastqc -j 8 --output_dir $OUTDIR/trimmed --paired $OUTDIR/raw/6_setAB_MO_K9_4_5h_3_S6_L001_R1_001.fastq.gz $OUTDIR/raw/6_setAB_MO_K9_4_5h_3_S6_L001_R2_001.fastq.gz
# trim_galore --fastqc -j 8 --output_dir $OUTDIR/trimmed --paired $OUTDIR/raw/7_gfp_MO_K9_4_5h_1_S7_L001_R1_001.fastq.gz $OUTDIR/raw/7_gfp_MO_K9_4_5h_1_S7_L001_R2_001.fastq.gz
# trim_galore --fastqc -j 8 --output_dir $OUTDIR/trimmed --paired $OUTDIR/raw/8_gfp_MO_K9_4_5h_2_S8_L001_R1_001.fastq.gz $OUTDIR/raw/8_gfp_MO_K9_4_5h_2_S8_L001_R2_001.fastq.gz
# trim_galore --fastqc -j 8 --output_dir $OUTDIR/trimmed --paired $OUTDIR/raw/9_gfp_MO_K9_4_5h_3_S9_L001_R1_001.fastq.gz $OUTDIR/raw/9_gfp_MO_K9_4_5h_3_S9_L001_R2_001.fastq.gz
#checking to see if trimmed reads are real and not empty
if [ -s $10_gfp_MO_IgG_4_5h_1_S10_L001_R1_001_val_1.fq.gz ] && [ -s $10_gfp_MO_IgG_4_5h_1_S10_L001_R2_001_val_2.fq.gz ]; then
    echo "  $10_gfp_MO_IgG_4_5h_1_S10_L001_R1_001_val_1.fq.gz and $10_gfp_MO_IgG_4_5h_1_S10_L001_R2_001_val_2.fq.gz found and not empty"
else
    echo "  $10_gfp_MO_IgG_4_5h_1_S10_L001_R1_001_val_1.fq.gz and $10_gfp_MO_IgG_4_5h_1_S10_L001_R2_001_val_2.fq.gz was found to either not exist or be empty"
    echo "exiting"
    exit 0
fi
