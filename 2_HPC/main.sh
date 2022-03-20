# base count
cat chr21.fa | wc -c

# N count
cat chr21.fa | grep 'N' | wc -c

# gene/CDS/exon count
cat annotation.gtf | cut -f 3 | tail +6 | sort -u > category.txt

cat category.txt | while read line
do
    echo $(cat annotation.gtf | cut -f 3 | tail +6 | grep $line | wc -w)'\t'$line's' >> category_results.txt
done

# list gene ID
cat annotation.gtf | cut -f 3,9 | tail +6 | sed 's/;/\t/g' | cut -f 2 | head
cat annotation.gtf | cut -f 3,9 | tail +6 | sed 's/;/\t/g' | cut -f 2 | sort -u > geneID.txt

# list transcripts according to gene ID
cat annotation.gtf | cut -f 3,9 | tail +6 | sed 's/;/\t/g' | awk -F '\t' '$1 == "transcript" {print $2}' > transcripts.txt

# count transcripts per gene ID
cat geneID.txt | while read line
do
    echo $line'\t'$(cat annotation.gtf | cut -f 3,9 | tail +6 | sed 's/;/\t/g' | awk -F '\t' '$1 == "transcript" {print $1, $2}' | grep $line | wc -l) >> geneID_count.txt
done

# number of lncRNA genes and transripts
cat annotation.gtf | cut -f 3,9 | tail +6 | sed 's/;/\t/g' | awk -F '\t' '$1 == "gene" {print $3}' | grep 'lncRNA' | wc -l
cat annotation.gtf | cut -f 3,9 | tail +6 | sed 's/;/\t/g' | awk -F '\t' '$1 == "transcript" {print $4}' | grep 'lncRNA' | wc -l

# Is there a gene that encodes a protein and a lncRNA at the same time?

## gene_type description does not contain two functions at the same time
cat annotation.gtf | cut -f 3,9 | tail +6 | sed 's/;/\t/g' | awk -F '\t' '$1 == "gene" {print $3}' | sort -u
## however, a gene with gene_type "protein_coding" may have lncRNA transcripts
cat annotation.gtf | cut -f 3,9 | tail +6 | sed 's/;/\t/g' | awk -F '\t' '$1 == "transcript" && $4 == " gene_type \"protein_coding\"" && $6 == " transcript_type \"lncRNA\"" {print}' | wc -l

# Chromosome 1
cat wholeGenome.gtf | awk -F '\t' '$1 == "1" {print $0}' > chr1.gtf
## gene/CDS/exon count
cat chr1.gtf | cut -f 3 | tail +6 | sort -u > category1.txt
cat category1.txt | while read line
do
    echo $(cat chr1.gtf | cut -f 3 | tail +6 | grep $line | wc -w)'\t'$line's' >> category_results_1.txt
done

cat wholeGenome.gtf | cut -f 3 | tail +6 | sort -u > category_WG.txt
cat category_WG.txt | while read line
do
    echo $(cat wholeGenome.gtf | cut -f 3 | tail +6 | grep $line | wc -w)'\t'$line's' >> category_results_WG.txt
done