#!/bin/bash
for n in {1..3}
do
  kubectl label nodes kube-minion-${n} disktype=fast
done
