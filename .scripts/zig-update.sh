# Latest build of Zig SDK
tarball_path=$HOME/.temp/zig-sdk-master.tar.xz
mkdir -p $HOME/.temp
index=$(curl https://ziglang.org/download/index.json)
tarball_url=$(echo $index | jq -r '.["master"].["aarch64-macos"].["tarball"]')
curl $tarball_url --output $tarball_path

shasum=$(echo $index | jq -r '.["master"].["aarch64-macos"].["shasum"]')
if ! sha256 $tarball_path --check=$shasum; then 
    echo "Sha checksum failed" >&2
    exit 2
fi

backup_path=$HOME/zig-sdk.bak
if [ -d $backup_path ]; then
    echo "Removing old backup"
    rm -rf $backup_path
fi

zigsdk_path=$HOME/zig-sdk
if [ -d $zigsdk_path ]; then
    echo "Found already installed Zig SDK"
    was_installed_before=true
else
    echo "No previously installed Zig SDK found"
    was_installed_before=false
fi

if [ "$was_installed_before" = true ]; then
    echo "Backing up previously installed Zig SDK"
    mv $HOME/zig-sdk $HOME/zig-sdk.bak
fi

mkdir -p $HOME/zig-sdk
echo "Extracting new version"
pv $tarball_path | tar -x --directory $zigsdk_path --strip-components=1

echo "Done"

# Build latest ZLS
rm -rf $HOME/.temp/zls
git clone https://github.com/zigtools/zls.git --depth=1 $HOME/.temp/zls
cd $HOME/.temp/zls
zig build --release=safe

mkdir -p $HOME/bin
zls_backup_path=$HOME/bin/zls.bak
if [ -d $zls_backup_path ]; then
    echo "Removing old backup"
    rm -rf $zls_backup_path
fi

zls_path=$HOME/bin/zls
if [ -d $zls_path ]; then
    echo "Found already installed ZLS"
    was_installed_before=true
else
    echo "No previously installed ZLS found"
    was_installed_before=false
fi

if [ "$was_installed_before" = true ]; then
    echo "Backing up previously installed ZLS"
    mv $HOME/bin/zls $HOME/bin/zls.bak
fi

echo "Moving new ZLS version"
mv $HOME/.temp/zls/zig-out/bin/zls $HOME/bin/zls

echo "Done"

zig version
zls --version
