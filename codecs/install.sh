# Default OpenH264 codecs from ffmpeg-free have issues with stuttering video.
# The codecs we want to use live in RPM Fusion repo under a full ffmpeg version.
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
