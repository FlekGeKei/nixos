while true; do
	RAW=$(intel_gpu_top -J | head -n 55 | sed '$a\        }' | sed '$a\}' | jq -r '.engines' & )

	if [[ -n "$(pgrep -f "intel_gpu_top -J")" ]]; then
		kill -9 $(pgrep -f "intel_gpu_top -J")
	fi

	RENDER3D_RAW=$(echo $RAW | jq -r '."Render/3D/0".busy')
	BLITTER_RAW=$(echo $RAW | jq -r '."Blitter/0".busy')
	VIDEO_RAW=$(echo $RAW | jq -r '."Video/0".busy')
	VIDEOENHANCE_RAW=$(echo $RAW | jq -r '."VideoEnhance/0".busy')
	ALL=$(echo $RENDER3D_RAW+$BLITTER_RAW+$VIDEO_RAW+$VIDEOENHANCE_RAW | bc)

	ALL0=$(awk -v n=$ALL 'BEGIN { printf "%.2f", n }')
	ALL1=$(awk -v n=$ALL0 'BEGIN { printf "%.1f", n }')
	text=$(awk -v n=$ALL1 'BEGIN { printf "%.0f", n }')

	echo '{"text": "'$text'", "tooltip": "'$ALL'%"}'

	sleep 10
done
