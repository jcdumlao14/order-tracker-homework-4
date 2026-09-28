#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${ORDER_TRACKER_BASE_URL:-http://127.0.0.1:18080}"

echo "Order Tracker recovery verification"
echo "Base URL: ${BASE_URL}"
echo

echo "Checking health..."
curl --fail --silent --show-error \
  "${BASE_URL}/healthz"

echo
echo

echo "Checking affected express order..."
curl --fail --silent --show-error \
  "${BASE_URL}/api/orders/express-1002"

echo
echo
echo "Recovery verification completed."
echo "Record HTTP status, response content, alert state, and"
echo "5xx metric state in the incident record."