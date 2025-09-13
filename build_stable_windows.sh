#!/bin/bash

export RUSTFLAGS="
    -C relro-level=none \
    -C code-model=small \
    -C linker-plugin-lto=no \
    -C default-linker-libraries \
    -C target-feature=+crt-static \
    -C symbol-mangling-version=v0 \
    -C llvm-args=-fp-contract=off \
    -C llvm-args=-enable-misched \
    -C llvm-args=-enable-post-misched \
    -C llvm-args=-enable-dfa-jump-thread \
    -C link-args=/OPT:REF,ICF \
    -C link-args=/NXCOMPAT \
    -C link-args=/DYNAMICBASE \
    -C link-args=/DEBUG:NONE \
    -C link-args=/PDB:NONE
" 

cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +stable build -r --target "$1" --bin "$2" --features="windows-gui-bin"
