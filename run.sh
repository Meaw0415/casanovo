# CUDA_VISIBLE_DEVICES=2 casanovo evaluate /mnt/nas/fangzheng/nine-species-balanced/Apis-mellifera.mgf --model /mnt/nas/fangzheng/mass/ckpt/excl_honeybee.ckpt --config  /mnt/data1/fangzheng/casanovo/casanovo/config1.yaml
# CUDA_VISIBLE_DEVICES=2 casanovo evaluate /mnt/nas/fangzheng/nine-species-balanced/Apis-mellifera.mgf --model /mnt/nas/fangzheng/mass/ckpt/excl_honeybee.ckpt --config  /mnt/data1/fangzheng/casanovo/casanovo/config.yaml


CUDA_VISIBLE_DEVICES=2 casanovo sequence /mnt/data1/fangzheng/casanovo/sample_data/sample_preprocessed_spectra.mgf --config /mnt/data1/fangzheng/casanovo/casanovo/config.yaml --output /mnt/data1/fangzheng/casanovo/sample_data/r.mztab
CUDA_VISIBLE_DEVICES=2 casanovo sequence /mnt/data1/fangzheng/casanovo/sample_data/sample_preprocessed_spectra.mgf --config /mnt/data1/fangzheng/casanovo/casanovo/config1.yaml --output /mnt/data1/fangzheng/casanovo/sample_data/r1.mztab