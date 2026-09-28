#!/usr/bin/env bash
set -euo pipefail

# Order Tracker rollback runbook.
#
# This runbook is intentionally conservative.
# A first responder must not execute an application rollback
# without explicit authorization from the responsible operator.
#
# Expected workflow:
#   1. Preserve the incident evidence.
#   2. Confirm the deployment/version to which rollback is requested.
#   3. Obtain explicit human authorization.
#   4. Execute the approved rollback using the deployment system.
#   5. Run verify-recovery.sh.
#   6. Record the result in the incident record.
#
# This file does not perform an automatic rollback.

echo "Order Tracker rollback runbook"
echo
echo "No rollback action is executed automatically."
echo "Preserve incident evidence and obtain explicit authorization"
echo "before executing any deployment rollback."