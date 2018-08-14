
* Playback HLS on http://192.168.1.4:8080/hls/picamdocker.m3u8
* Record and send to dash
    ffmpeg -i rtsp://192.168.1.5:8554/unicast  -stats -an -vcodec copy -f flv rtmp://192.168.1.4/dashpub/dashstreampi
* Playback Dash Cli sudo MP4Client /tmp/data/dash/dashstreampi.mpd  (if vol is mounted to /tmp/data)
 sudo MP4Client http://192.168.1.4:8080/dash/dashstreampi.mpd
*  Remove Append from Discovery Service Script

