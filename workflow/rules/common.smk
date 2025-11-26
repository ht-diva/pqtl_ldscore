import pandas as pd
from pathlib import Path

data = []
with open(config["path_seqids"], "r") as fp:
    lines = fp.readlines()

for line in lines:
    p = Path(line.strip())
    seqid = ".".join(p.stem.split(".")[:3])
    data.append((seqid, str(p)))

analytes = (
    pd.DataFrame.from_records(data, columns=["seqid", "path_sumstats"])
    .set_index("seqid", drop=False)
    .sort_index()
)

def sumstats_path(wildcards):
    return str(Path(config["path_sumstats"],
                    f"{wildcards.seqid}/{wildcards.seqid}.gwaslab.tsv.bgz"))

def ws_path(file_path):
    return str(Path(config.get("workspace_path"))) + "/" + file_path

def get_inputs(wildcards):
    chrom = str(wildcards.chrom).strip(".")  # remove any stray dots
    return [
        str(Path(config["path_bed"], config["bed_template"].format(chrom=chrom))),
        str(Path(config["path_bed"], config["bim_template"].format(chrom=chrom))),
        str(Path(config["path_bed"], config["fam_template"].format(chrom=chrom))),

def get_inputs_stem(wildcards):
    chrom = str(wildcards.chrom).strip(".")
    return str(Path(config["path_bed"],config["bed_template"].format(chrom=chrom))).replace(".bed","")

