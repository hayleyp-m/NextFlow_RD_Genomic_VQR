docker build -t variantvalidator/indexgenome:1.1.0 ./dockerfiles/indexGenome/
docker build -t variantvalidator/gatk4:4.3.0.0 ./dockerfiles/gatk/
docker build -t variantvalidator/fastqc:0.12.1 ./dockerfiles/FASTqc/
docker build -t staphb/fastp:0.24.0 ./dockerfiles/fastp/
