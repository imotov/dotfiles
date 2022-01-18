#!/bin/bash
#
# Bootstraping ~/Projects
#

set -e

mkdir ~/Projects/
cd ~/Projects
mkdir elastic
mkdir imotov
mkdir other
mkdir tarantula

cd elastic
mkdir 8.x
cd 8.x
git clone git@github.com:imotov/elasticsearch.git
cd elasticsearch
git remote add elastic git@github.com:elastic/elasticsearch.git
git fetch elastic
git merge --ff-only elastic/master
cd ../..
mkdir no_ver
cd no_ver
git clone git@github.com:imotov/rally.git
cd rally
git remote add elastic git@github.com:elastic/rally.git
git fetch elastic
git merge --ff-only elastic/master
cd ..
git clone git@github.com:imotov/rally-tracks.git
cd rally-tracks
git remote add elastic git@github.com:elastic/rally-tracks.git
git fetch elastic
git merge --ff-only elastic/master
cd ../..
cd ..

cd imotov
git clone git@github.com:imotov/devenvs.git
cd ..

cd other
git clone git@github.com:imotov/sdrtrunk.git
cd sdrtrunk
git remote add DSheirer git@github.com:DSheirer/sdrtrunk.git
git fetch DSheirer
git merge --ff-only DSheirer/master
cd ../..

cd tarantula
git clone igor@tarantula.local:/volume1/git/test.git
cd ..
