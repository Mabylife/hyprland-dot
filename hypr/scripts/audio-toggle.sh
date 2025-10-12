#!/usr/bin/env bash
# 檔名建議：~/scripts/audio-toggle.sh
# 記得 chmod +x ~/scripts/audio-toggle.sh

# ===== 需要你自行填寫的部分 (用 pactl list short sinks / sources 找出) =====
SINK_HEADPHONE="alsa_output.usb-Logitech_G_series_G435_Wireless_Gaming_Headset_202105190004-00.analog-stereo"   # 耳機喇叭 sink
SINK_HDMI="alsa_output.pci-0000_01_00.1.hdmi-stereo"               # 外接螢幕喇叭 sink
SOURCE_HEADSET="alsa_input.usb-Logitech_G_series_G435_Wireless_Gaming_Headset_202105190004-00.mono-fallback"    # 耳機麥克風 source

# CAVA config 路徑
CAVA_CFG="$HOME/.config/cava/config"

# ===== 不太需要改的部分 =====
current_default_sink=$(pactl info | awk -F': ' '/Default Sink/{print $2}')

if [[ "$current_default_sink" == "$SINK_HEADPHONE" ]]; then
    new_sink="$SINK_HDMI"
    notify_msg="切到 外接螢幕 喇叭"
else
    new_sink="$SINK_HEADPHONE"
    notify_msg="切到 耳機 喇叭"
fi

echo "[Audio Toggle] New sink => $new_sink"

# 1. 設定新的 default sink
pactl set-default-sink "$new_sink"

# 2. 移動所有現有播放 stream 到新的 sink
for input in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$input" "$new_sink"
done

# 3. 鎖定 default source = 耳機麥克風
pactl set-default-source "$SOURCE_HEADSET"

# 4. 讓 CAVA 追蹤新的 monitor
monitor_source="${new_sink}.monitor"

# 修改 CAVA 設定檔中的 source 行；若沒有則追加
if grep -qi "^source" "$CAVA_CFG"; then
    sed -i "s|^source *=.*|source = $monitor_source|I" "$CAVA_CFG"
else
    echo "source = $monitor_source" >> "$CAVA_CFG"
fi

# 5. (可選) 發通知，如果你有 dunst / mako
if command -v notify-send >/dev/null; then
    notify-send "音訊切換" "$notify_msg"
fi
