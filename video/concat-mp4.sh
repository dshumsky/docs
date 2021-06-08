for f in $(ls *.mp4); do
    ffmpeg -i $f -c copy -bsf:v h264_mp4toannexb -f mpegts $f.ts
done

CONCAT=$(echo $(ls *.ts) | sed -e "s/ /|/g")

ffmpeg -i "concat:$CONCAT" -c copy -bsf:a aac_adtstoasc output.mp4

rm *.ts