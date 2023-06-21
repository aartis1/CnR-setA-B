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
curl -s https://ftp.ensembl.org/pub/release-109/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz | gunzip -c > sacc_refseq.fa
curl -s https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/005/845/GCA_000005845.2_ASM584v2/GCA_000005845.2_ASM584v2_genomic.fna.gz | gunzip -c > ecoli_refseq.fa
#place all setdb1 raw data into raw directory
mkdir /home/ara67776/work/CnR/Setdb1 raw
mv 27_suvAB_setAB_MO_K9CnR_4.2023 raw
#trim 3' ends of raw data before adapters are taken off
module load Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4
mkdir /home/ara67776/work/CnR/Setdb1 CnR_trimmed
#download samtools and bowtie to continue trimming
module load SAMtools/1.10-GCC-8.3.0
module load Bowtie2/2.4.1-GCC-8.3.0
for infile in CnR_histone_mods/trimmed/*.gz
do
base=$(basename ${infile} _trimmed.fq.gz)
bowtie2 --local --very-sensitive-local --phred33 --no-unal -p 24 -x $OUTDIR/danio_ref -U $infile | samtools view -bq 20 | samtools sort - > $OUTDIR/CnR_histone_mods/bams/$base.danio_sort.bam
done
