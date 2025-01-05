FROM debian:12

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    novnc websockify \
    x11vnc \
    supervisor \
    wget curl \
    && apt-get clean

# Set up the XFCE desktop environment
RUN mkdir -p ~/.vnc && \
    echo "xfce4-session" > ~/.xinitrc

# Install noVNC
RUN mkdir -p /opt/novnc && \
    wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz | tar xz --strip-components=1 -C /opt/novnc && \
    ln -s /opt/novnc/utils/novnc_proxy /usr/bin/novnc_proxy

# Expose port for noVNC
EXPOSE 8080

# Set entrypoint
COPY setup_noVNC.sh /setup_noVNC.sh
RUN chmod +x /setup_noVNC.sh
CMD ["/bin/bash", "/setup_noVNC.sh"]
