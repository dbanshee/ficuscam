cd "$(dirname "$0")";
find ./snapshot -type f -mtime -1 -printf "%T@ %p\n" | sort -n | cut -d' ' -f2 | xargs cat | ffmpeg -f image2pipe -r 1 -vcodec mjpeg -i - -vcodec h264_omx tmp/snapVideo_tmp.mp4
mv tmp/snapVideo_tmp.mp4 tmp/snapVideo.mp4

