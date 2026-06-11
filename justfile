drawio:
    for f in assets/*.drawio; do \
        drawio -x -f svg --embed-svg-images --embed-svg-fonts true --svg-theme light -b 0 \
            -o "fig/$(basename "$f" .drawio).svg" "$f"; \
    done
