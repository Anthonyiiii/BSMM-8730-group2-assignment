"""Restore the unchanged 2023 annual report from its five binary parts."""
from pathlib import Path
import hashlib

root = Path(__file__).resolve().parent
name = "Choice-REIT-Annual-Report-2023-Final-Release-AODA.pdf"
expected = "7e5449c337852cffa9d8075d7c7c1ca80d01398997875baeb7692ac249562eba"
data = b"".join((root / (name + f".part{i:02d}")).read_bytes() for i in range(1, 6))
if len(data) != 35528177 or hashlib.sha256(data).hexdigest() != expected:
    raise SystemExit("Verification failed: missing or altered report parts.")
target = root / name
if target.exists():
    if hashlib.sha256(target.read_bytes()).hexdigest() != expected:
        raise SystemExit("Existing PDF differs; refusing to overwrite.")
else:
    target.write_bytes(data)
print(f"Verified original PDF: {target}")
