!/bin/bash
SBATCH --job-name=CnR_setab_mods		                        # Job name
SBATCH --partition=batch		                            # Partition (queue) name
SBATCH --ntasks=1			                                # Single task job
SBATCH --cpus-per-task=6		                            # Number of cores per task - match this to the num_threads used by BLAST
SBATCH --mem=40gb			                                # Total memory for job
SBATCH --time=2:00:00  		                            # Time limit hrs:min:sec
SBATCH --output=/home/ara67776/work/CnR/Setdb1/error			    # Location of standard output and error log files (replace cbergman with your myid)
SBATCH --mail-user=ara67776@uga.edu                    # Where to send mail (replace cbergman with your myid)
SBATCH --mail-type=ALL                            # Mail events (BEGIN, END, FAIL, ALL)


#set output directory
OUTDIR="/home/ara67776/work/CnR/Setdb1"

#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi
#download relevant reference genome and annotations
curl -s https://ftp.ensembl.org/pub/release-109/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna_rm.primary_assembly.fa.gz | gunzip -c > $OUTDIR/danio-refseq.fa
curl -s https://ftp.ensembl.org/pub/release-109/gtf/danio_rerio/Danio_rerio.GRCz11.109.gtf.gz | gunzip -c > $OUTDIR/danio_annotation.gtf

#spike in for CnR
 curl -s https://ftp.ensembl.org/pub/release-109/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz | gunzip -c $OUTDIR/sacc_refseq.fa
 curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/005/845/GCA_000005845.2_ASM584v2/GCA_000005845.2_ASM584v2_genomic.fna.gz | gunzip -c $OUTDIR/ecoli_refseq.fa
