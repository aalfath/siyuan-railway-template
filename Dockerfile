# SiYuan for Railway: the official image, pinned by version and digest.
# Bump both the tag and the digest together, and add a CHANGELOG.md entry.
FROM b3log/siyuan:v3.8.10@sha256:44ee53c45cde3a252c6d913de9b0ff79bf9bb0a5e336e5cc36c06357d6757919

COPY --chmod=755 start.sh /opt/railway/start.sh

# SiYuan always listens on 6806 inside a container.
EXPOSE 6806

ENTRYPOINT ["/opt/railway/start.sh"]
