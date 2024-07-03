# Define input for the rules

import pandas as pd

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

def sumstats_path():
    return str(Path(config.get("path_sumstats"),"{seqid}/seq.{seqid}.gwaslab.tsv.bgz"))


def ws_path(file_path):
    return str(Path(config.get("workspace_path"), file_path))

def get_inputs():
    inputs = [str(Path(config.get("path_bed"),Path(config.get("bed_template")))),
              str(Path(config.get("path_bed"),Path(config.get("bim_template")))),
              str(Path(config.get("path_bed"),Path(config.get("fam_template"))))]
    return inputs

def get_inputs_stem():
    return str(Path(config.get("path_bed"),Path(config.get("bed_template"))).stem)