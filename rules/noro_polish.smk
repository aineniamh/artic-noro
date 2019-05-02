rule nanopolish_index:
    input:
        summary="{run}_sequencing_summary.txt"
        reads="{run}_all.fastq"
    output:
        "calls/{barcode}.bcf.gz.csi"
    shell:
        "bcftools index {input}"
