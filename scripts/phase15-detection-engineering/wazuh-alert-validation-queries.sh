#!/bin/bash

# Phase 15 - Wazuh Alert Validation Queries
# Run this script on:
# SOC-Ubuntu-Server-01
#
# Purpose:
# This script checks Wazuh alerts.json for Phase 15 custom detection rules:
# 100200, 100201, 100202, 100203, and 100204.
#
# Requirements:
# - jq must be installed
# - Run with a user that has sudo access
# - Wazuh alerts file should exist at /var/ossec/logs/alerts/alerts.json

ALERTS_FILE="/var/ossec/logs/alerts/alerts.json"
AGENT_NAME="SOC-Windows11-01"

echo "[Phase 15] Wazuh Alert Validation Queries"
echo "Target agent: ${AGENT_NAME}"
echo "Alerts file: ${ALERTS_FILE}"
echo

if ! command -v jq >/dev/null 2>&1; then
  echo "[ERROR] jq is not installed. Install it with:"
  echo "sudo apt update && sudo apt install -y jq"
  exit 1
fi

if [ ! -f "$ALERTS_FILE" ]; then
  echo "[ERROR] Wazuh alerts file not found: $ALERTS_FILE"
  exit 1
fi

echo "[Phase 15] Checking all custom rule alerts..."
echo

sudo tail -n 50000 "$ALERTS_FILE" | jq -r '
select(.agent.name=="SOC-Windows11-01")
| select(
    .rule.id=="100200"
    or .rule.id=="100201"
    or .rule.id=="100202"
    or .rule.id=="100203"
    or .rule.id=="100204"
  )
| {
  timestamp: .timestamp,
  agent: .agent.name,
  rule_id: .rule.id,
  description: .rule.description,
  provider: .data.win.system.providerName,
  channel: .data.win.system.channel,
  eventID: .data.win.system.eventID,
  commandLine: .data.win.eventdata.commandLine,
  targetUserName: .data.win.eventdata.targetUserName,
  status: .data.win.eventdata.status
}'

echo
echo "[Phase 15] Rule count summary:"
echo

for RULE_ID in 100200 100201 100202 100203 100204; do
  COUNT=$(sudo tail -n 50000 "$ALERTS_FILE" | jq -r --arg rid "$RULE_ID" '
    select(.agent.name=="SOC-Windows11-01")
    | select(.rule.id==$rid)
    | .rule.id
  ' | wc -l)

  echo "Rule ${RULE_ID}: ${COUNT} alert(s)"
done

echo
echo "[Phase 15] Validation query completed."
