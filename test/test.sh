#!/bin/bash
RX_VIVO="00_02_D1"

STRING="00_02_D1_6B_E4_1B"
if [[ $STRING =~ $RX_VIVO ]]; then
      echo "Match."
  else
        echo "No match."
    fi
