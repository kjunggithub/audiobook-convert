# Audiobook Convert
A shell script to convert mp3 to m4b files.

## Dependencies
`audiobook-convert` uses `ffmpeg` and `rename`. For ffmpeg, make sure you have access to `libfdk_aac`.
```shell
brew install rename ffmpeg --with-fdk-aac
```

## Instructions
1. Clone the repo.

```shell
git clone git@github.com:kjunggithub/audiobook-convert.git
cd audiobook-convert
```

2. Running the script.

Move all `.mp3` files to be combined and converted into `input/` and from the root folder of the repository, run:

` sh convert.sh`
