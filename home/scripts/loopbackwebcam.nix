{
  config,
  lib,
  pkgs,
  ...
}:
let
  loopbackWebcam = pkgs.writeShellApplication {
    name = "loopbackwebcam";

    runtimeInputs = with pkgs; [
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
    ];

    text = ''
      export GST_PLUGIN_SYSTEM_PATH_1_0="${pkgs.gst_all_1.gstreamer.out}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0"
      gst-launch-1.0 v4l2src device=/dev/video0 ! \
      image/jpeg,width=640,height=480,framerate=30/1 ! \
      decodebin ! videoconvert ! \
      video/x-raw,width=640,height=480,framerate=30/1 ! \
      v4l2sink device=/dev/video10
    '';
  };
in
{
  home.packages = [ loopbackWebcam ];
}
