#!/usr/bin/env bash
pushd /workspaces/$(basename ${GITHUB_REPOSITORY})
git submodule init
git submodule update
popd
