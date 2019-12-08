import argparse


def main():
    parser = argparse.ArgumentParser(
                description='Open file, find tissue gene counts for given \
                gene',
                prog='bay')

    parser.add_argument('-c',  # cell_volume
                        '--cell_volume',
                        type=str,
                        help="Volume of cell in µm^3"",
                        required=True)

    parser.add_argument('-g',
                        '--gen_time',
                        type=str,
                        help="Generation time, in hours",
                        required=True)



    args = parser.parse_args()
    data_file_name = args.gene_reads
    sample_info_file_name = args.sample_attributes
    gene_name = args.gene
    group_col_name = args.group_type
    out_file_name = args.output_file
