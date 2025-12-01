from pathlib import Path
import os
import sys

LCOV_PATH = Path('app/app_root/coverage/lcov.info')
THRESHOLD = float(os.environ.get('COVERAGE_THRESHOLD', '0'))

if not LCOV_PATH.exists():
    raise SystemExit(f"Coverage file not found: {LCOV_PATH}")

lf = 0
lh = 0
for line in LCOV_PATH.read_text().splitlines():
    if line.startswith('LF:'):
        lf += int(line.split(':', 1)[1])
    elif line.startswith('LH:'):
        lh += int(line.split(':', 1)[1])

if lf == 0:
    raise SystemExit('No lines found in coverage file')

pct = lh / lf * 100
print(f'Coverage: {pct:.2f}% ({lh}/{lf} lines hit)')

if THRESHOLD > 0 and pct < THRESHOLD:
    raise SystemExit(f'Coverage {pct:.2f}% is below threshold {THRESHOLD}%')
