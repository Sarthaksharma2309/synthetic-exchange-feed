#!/usr/bin/env bash
ok()   { printf '  OK       %-14s %s\n' "$1" "$2"; }
miss() { printf '  MISSING  %-14s %s\n' "$1" "$2"; }
chk()  { if command -v "$1" >/dev/null 2>&1; then ok "$1" "$($1 ${2:---version} 2>&1 | head -1)"; else miss "$1" "$3"; fi; }

uname -r | grep -qi microsoft && echo "Running inside WSL2" || echo "Not WSL (native Linux or macOS?)"
chk g++ --version "sudo apt install build-essential"
chk cmake --version "sudo apt install cmake"
chk ninja --version "sudo apt install ninja-build"
chk git --version "sudo apt install git"
chk python3 --version "sudo apt install python3"
chk node --version "install nvm, then: nvm install 20"
chk docker --version "see chapter S3"
chk redis-cli --version "sudo apt install redis-tools"
# chk q -version "download kdb+ from KX and put q on PATH (needed from Chapter 6A)"
chk gh --version "sudo apt install gh"
nproc | xargs echo "CPU cores visible:"
[ -e /usr/include/boost/version.hpp ] && ok boost "$(grep 'define BOOST_LIB_VERSION' /usr/include/boost/version.hpp)" || miss boost "sudo apt install libboost-all-dev"
[ -d /usr/include/gtest ] && ok gtest "headers present" || miss gtest "sudo apt install libgtest-dev"
