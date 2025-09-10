CUDA_VISIBLE_DEVICES=5 casanovo train --validation_peak_path /mnt/nas/fangzheng/nine-species-balanced/Apis-mellifera.mgf \
 /mnt/nas/fangzheng/nine-species-balanced/Bacillus-subtilis.mgf \
 /mnt/nas/fangzheng/nine-species-balanced/Candidatus-endoloripes.mgf \
 /mnt/nas/fangzheng/nine-species-balanced/H.-sapiens.mgf \
 /mnt/nas/fangzheng/nine-species-balanced/Methanosarcina-mazei.mgf \
 /mnt/nas/fangzheng/nine-species-balanced/Mus-musculus.mgf \
 /mnt/nas/fangzheng/nine-species-balanced/Vigna-mungo.mgf \
 /mnt/nas/fangzheng/nine-species-balanced/Solanum-lycopersicum.mgf \
 /mnt/nas/fangzheng/nine-species-balanced/Saccharomyces-cerevisiae.mgf \
 --model /mnt/iMVR/zhengf/epoch=23-step=500000.ckpt \
 --config /mnt/iMVR/zhengf/casanovo/casanovo/config_dpo.yaml \


# CUDA_VISIBLE_DEVICES=5 casanovo train --validation_peak_path /mnt/nas/fangzheng/nine-species-balanced/1.mgf /mnt/nas/fangzheng/nine-species-balanced/2.mgf  --model /mnt/iMVR/zhengf/epoch=23-step=500000.ckpt --config /mnt/iMVR/zhengf/casanovo/casanovo/config_dpo.yaml
#   \
#   \
#   \


# CUDA_VISIBLE_DEVICES=6 casanovo evaluate  /mnt/nas/fangzheng/nine-species-balanced/Apis-mellifera.mgf  --model /mnt/nas/fangzheng/mass/ckpt/excl_honeybee.ckpt --config /mnt/data1/fangzheng/casanovo/casanovo/config_dpo.yaml
#   \
#   \

# CUDA_VISIBLE_DEVICES=7 casanovo train --validation_peak_path /mnt/nas/fangzheng/nine-species-balanced/aa.mgf \
#  /mnt/nas/fangzheng/nine-species-balanced/Bacillus-subtilis.mgf \
#  /mnt/nas/fangzheng/nine-species-balanced/Candidatus-endoloripes.mgf \
#  /mnt/nas/fangzheng/nine-species-balanced/H.-sapiens.mgf \
#  /mnt/nas/fangzheng/nine-species-balanced/Methanosarcina-mazei.mgf \
#  /mnt/nas/fangzheng/nine-species-balanced/Mus-musculus.mgf \
#  /mnt/nas/fangzheng/nine-species-balanced/Vigna-mungo.mgf \
#  /mnt/nas/fangzheng/nine-species-balanced/Solanum-lycopersicum.mgf \
#  /mnt/nas/fangzheng/nine-species-balanced/Saccharomyces-cerevisiae.mgf \
#  --config /mnt/data1/fangzheng/casanovo/casanovo/config_dpo.yaml \
#  --model /mnt/data1/fangzheng/casav4/epoch=23-step=500000.ckpt

# CUDA_VISIBLE_DEVICES=4 casanovo train --validation_peak_path /mnt/nas/fangzheng/nine-species-balanced/aa.mgf \
# /mnt/nas/fangzheng/nine-species-balanced/Bacillus-subtilis.mgf \
#  --config /mnt/data1/fangzheng/casanovo/casanovo/config_dpo.yaml \
#  --model /mnt/data1/fangzheng/casav4/epoch=23-step=500000.ckpt