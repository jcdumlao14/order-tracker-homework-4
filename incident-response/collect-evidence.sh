#!/usr/bin/env bash
set -u

APP_URL="http://127.0.0.1:18080"
PROM_URL="http://127.0.0.1:19090"
ORDER_ID="express-1002"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

TIMESTAMP="$(date -u +"%Y%m%dT%H%M%SZ")"
INCIDENT_DIR="$SCRIPT_DIR/incidents"
EVIDENCE_DIR="$INCIDENT_DIR/$TIMESTAMP"

mkdir -p "$EVIDENCE_DIR"

echo "========================================"
echo " ORDER TRACKER EVIDENCE COLLECTOR"
echo "========================================"
echo
echo "Incident: ORDER-TRACKER-5XX-001"
echo "Timestamp: $TIMESTAMP"
echo "Output: $EVIDENCE_DIR"
echo

write_section() {
    local name="$1"
    local file="$EVIDENCE_DIR/$2"

    echo "=== $name ==="
    echo "Writing: $file"

    shift 2
    "$@" > "$file" 2>&1 || true

    echo
}

# ------------------------------------------------------------
# 1. Application health
# ------------------------------------------------------------
write_section \
    "APPLICATION HEALTH" \
    "healthz.txt" \
    curl.exe -sS --max-time 10 \
    "$APP_URL/healthz"

# ------------------------------------------------------------
# 2. Affected order lookup
# ------------------------------------------------------------
write_section \
    "AFFECTED ORDER LOOKUP" \
    "express-1002-response.txt" \
    curl.exe -sS -i --max-time 10 \
    "$APP_URL/api/orders/$ORDER_ID"

# ------------------------------------------------------------
# 3. Prometheus metric
# ------------------------------------------------------------
write_section \
    "PROMETHEUS ORDER LOOKUP STATUS" \
    "prometheus-order-lookup.txt" \
    curl.exe -sS --max-time 10 \
    "$PROM_URL/api/v1/query?query=order_lookup_status_total"

# ------------------------------------------------------------
# 4. Prometheus 5xx increase
# ------------------------------------------------------------
write_section \
    "PROMETHEUS 5XX INCREASE" \
    "prometheus-5xx-increase.txt" \
    curl.exe -sS --max-time 10 \
    "$PROM_URL/api/v1/query?query=increase(order_lookup_status_total%7Bhttp_status_code%3D~%225..%22%7D%5B5m%5D)"

# ------------------------------------------------------------
# 5. Alert state
# ------------------------------------------------------------
write_section \
    "PROMETHEUS ALERT STATE" \
    "alert-state.txt" \
    curl.exe -sS --max-time 10 \
    "$PROM_URL/api/v1/alerts"

# ------------------------------------------------------------
# 6. Recent application logs
# ------------------------------------------------------------
write_section \
    "RECENT APPLICATION LOGS" \
    "application-logs.txt" \
    docker.exe logs --tail 250 order-tracker-app-1

# ------------------------------------------------------------
# 7. Relevant source-code context
# ------------------------------------------------------------
{
    echo "=== app/main.py relevant lines ==="
    grep -n -B 8 -A 12 "estimated_at = placed_at.replace" \
        "$PROJECT_ROOT/app/main.py" || true

    echo
    echo "=== app/main.py order_detail ==="
    grep -n -A 20 -B 5 "def order_detail" \
        "$PROJECT_ROOT/app/main.py" || true
} > "$EVIDENCE_DIR/source-context.txt"

# ------------------------------------------------------------
# 8. Git metadata
# ------------------------------------------------------------
{
    echo "=== git status ==="
    git -C "$PROJECT_ROOT" status --short --branch

    echo
    echo "=== git branch ==="
    git -C "$PROJECT_ROOT" branch --show-current

    echo
    echo "=== git log ==="
    git -C "$PROJECT_ROOT" log -5 --oneline --decorate

    echo
    echo "=== git diff --stat ==="
    git -C "$PROJECT_ROOT" diff --stat
} > "$EVIDENCE_DIR/git-metadata.txt"

# ------------------------------------------------------------
# 9. Evidence manifest
# ------------------------------------------------------------
{
    echo "incident_id=ORDER-TRACKER-5XX-001"
    echo "collected_at_utc=$TIMESTAMP"
    echo "application_url=$APP_URL"
    echo "prometheus_url=$PROM_URL"
    echo "affected_order=$ORDER_ID"
    echo
    echo "Files:"
    find "$EVIDENCE_DIR" -maxdepth 1 -type f -printf "%f\n" 2>/dev/null \
        | sort || ls -1 "$EVIDENCE_DIR"
} > "$EVIDENCE_DIR/manifest.txt"

echo "========================================"
echo " EVIDENCE COLLECTION COMPLETE"
echo "========================================"
echo
echo "Evidence directory:"
echo "$EVIDENCE_DIR"
echo
echo "Collected files:"
ls -lh "$EVIDENCE_DIR"
echo
