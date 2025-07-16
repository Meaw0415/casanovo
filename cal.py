import os
import glob
import csv

def read_mztab(mztab_file):
    psm_list = []
    with open(mztab_file) as f:
        lines = f.readlines()
    header = None
    for row in lines:
        if row.startswith("PSH"):
            header = row.strip().split('\t')
            continue
        if row.startswith("PSM"):
            fields = row.strip().split('\t')
            d = dict(zip(header, fields))
            try:
                psm = {
                    'sequence': d['sequence'],
                    'exp_mass_to_charge': float(d['exp_mass_to_charge']),
                    'calc_mass_to_charge': float(d['calc_mass_to_charge']),
                }
                psm_list.append(psm)
            except Exception as e:
                print(f"Error parsing {d}: {e}")
                continue
    return psm_list

def parse_mgf_blocks(mgf_file):
    blocks = []
    with open(mgf_file) as f:
        block = {}
        for line in f:
            line = line.strip()
            if line == 'BEGIN IONS':
                block = {}
            elif line.startswith('PEPMASS='):
                block['pep_mass'] = float(line.split('=')[1].split()[0])
            elif line.startswith('SEQ='):
                block['seq'] = line.split('=')[1]
            elif line == 'END IONS':
                if 'pep_mass' in block and 'seq' in block:
                    blocks.append(block)
    return blocks

def find_psms_for_mass(psm_list, pepmass, tolerance=0.1):
    return [psm for psm in psm_list if abs(psm['exp_mass_to_charge'] - pepmass) < tolerance]

def main():
    mztab_dir = '/mnt/iMVR/zhengf/casanovo/res/r50'
    pos_mgf_dir = '/mnt/nas/fangzheng/nine-species-balanced'
    mztab_files = glob.glob(os.path.join(mztab_dir, '*.mztab'))
    all_rows = []
    window_size = 10
    tolerance = 0.1

    for mztab_file in mztab_files:
        basename = os.path.splitext(os.path.basename(mztab_file))[0]
        mgf_file = os.path.join(pos_mgf_dir, basename + '.mgf')
        if not os.path.exists(mgf_file):
            print(f"正样本mgf文件缺失: {mgf_file}")
            continue
        psms = read_mztab(mztab_file)
        mgf_blocks = parse_mgf_blocks(mgf_file)
        print(f"{basename}: MGF光谱数量={len(mgf_blocks)}，PSM条目数={len(psms)}")

        psm_idx = 0
        for blk in mgf_blocks:
            gt_seq = blk['seq']
            pepmass = blk['pep_mass']

            # 优先顺序匹配：取当前位置的10个psm
            psms_window = psms[psm_idx:psm_idx+window_size]
            mass_match = [psm for psm in psms_window if abs(psm['exp_mass_to_charge'] - pepmass) < tolerance]

            if len(mass_match) == window_size:
                cand_psms = mass_match
                psm_idx += window_size
            else:
                # 若顺序滑窗匹配不到，就用全局质量匹配
                cand_psms = find_psms_for_mass(psms, pepmass, tolerance)
                # 尝试找最佳起点（窗口左移），防止对齐漂移
                # 有窗口对齐时能对齐多滑动几步也可进一步加快
                # 这里只做简单实现，追求极致速度可进一步写成跳步对齐

            neg_psms = [psm for psm in cand_psms if psm['sequence'] != gt_seq]
            if neg_psms:
                neg_psm = max(neg_psms, key=lambda p: abs(p['exp_mass_to_charge'] - p['calc_mass_to_charge']))
                row = {
                    'src': basename,
                    'gt_seq': gt_seq,
                    'neg_seq': neg_psm['sequence'],
                    'exp_mass': neg_psm['exp_mass_to_charge'],
                    'calc_mass': neg_psm['calc_mass_to_charge']
                }
            else:
                row = {
                    'src': basename,
                    'gt_seq': gt_seq,
                    'neg_seq': 'NA',
                    'exp_mass': 'NA',
                    'calc_mass': 'NA'
                }
            all_rows.append(row)

        print(f"完成：{basename} 正样本数={len(mgf_blocks)}")

    os.makedirs(mztab_dir, exist_ok=True)
    save_file = os.path.join(mztab_dir, "all_neg_samples.csv")
    with open(save_file, 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['src', 'gt_seq', 'neg_seq', 'exp_mass', 'calc_mass'])
        writer.writeheader()
        for row in all_rows:
            writer.writerow(row)
    print(f"全部完成，总输出：{save_file}")
    print(f"所有正样本总数: {len(all_rows)}（每个正样本都保证有一行）")

if __name__ == '__main__':
    main()
