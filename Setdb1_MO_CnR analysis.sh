#!bin/bash
SBATCH --job-name=CnR_setab_MO		                        # Job name
SBATCH --partition=batch		                            # Partition (queue) name
SBATCH --ntasks=1	                                # Single task job
SBATCH --cpus-per-task=24		                            # Number of cores per task - match this to the num_threads used by BLAST
SBATCH --mem=60gb			                                # Total memory for job
SBATCH --time=24:00:00  		                            # Time limit hrs:min:sec
SBATCH --output=/scratch/ara67776/CnR_setAB			    # Location of standard output and error log files (replace cbergman with your myid)
SBATCH --mail-user=ara67776@uga.edu                    # Where to send mail (replace cbergman with your myid)
SBATCH --mail-type=ALL                            # Mail events (BEGIN, END, FAIL, ALL)


#set output directory
OUTDIR="/scratch/ara67776/CnR_setAB"

#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi
# #download relevant reference genome and annotations
# curl -s https://ftp.ensembl.org/pub/release-109/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna_rm.primary_assembly.fa.gz | gunzip -c > $OUTDIR/danio-refseq.fa
# curl -s https://ftp.ensembl.org/pub/release-109/gtf/danio_rerio/Danio_rerio.GRCz11.109.gtf.gz | gunzip -c > $OUTDIR/danio_annotation.gtf

#spike in for CnR
curl -s https://ftp.ensembl.org/pub/release-109/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz | gunzip -c $OUTDIR/sacc_refseq.fa
curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/005/845/GCA_000005845.2_ASM584v2/GCA_000005845.2_ASM584v2_genomic.fna.gz | gunzip -c $OUTDIR/ecoli_refseq.fa
