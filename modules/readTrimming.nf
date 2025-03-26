/*
 * Run fastp on the read fastq files
 */
process fastp {

    label 'process_single'

    container 'staphb/fastp:0.24.0'

    // Add a tag to identify the process
    tag "$sample_id"

    // Specify the output directory for the FASTQC results
    publishDir("$params.outdir/fastp", mode: "copy")

    input:
    tuple val(sample_id), path(reads)

    output:
    path ("fastp_${sample_id}_logs/${sample_id}_*_trimmed.fastq.gz")

    script:
    """
    echo "Running fastp"
    mkdir -p fastp_${sample_id}_logs

    # Check the number of files in reads and run fastqc accordingly
    if [ -f "${reads[0]}" ] && [ -f "${reads[1]}" ]; then
        fastp -i ${reads[0]} -o fastp_${sample_id}_logs/${sample_id}_1_trimmed.fastq.gz \
        -I ${reads[1]} -O fastp_${sample_id}_logs/${sample_id}_2_trimmed.fastq.gz \
        --html fastp_${sample_id}_logs/${sample_id}.html --json fastp_${sample_id}_logs/${sample_id}.json
    elif [ -f "${reads[0]}" ]; then
        fastp -i ${reads[0]} -o fastp_${sample_id}_logs/${sample_id}_trimmed.fastq.gz \
        --html fastp_${sample_id}_logs/${sample_id}.html --json fastp_${sample_id}_logs/${sample_id}.json
    else
        echo "No valid read files found for sample ${sample_id}"
        exit 1
    fi

    echo "fastp Complete"
    """
}
