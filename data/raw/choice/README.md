# Choice Properties REIT annual reports

Original reports for fiscal years 2023, 2024, and 2025.
Source: https://www.choicereit.ca/investors/

The 2024 and 2025 PDFs are stored directly in this directory.

## Restore the 2023 PDF

The original 2023 PDF is 35,528,177 bytes, exceeding GitHub's browser upload limit.
It is stored as five binary parts (.part01 through .part05), without modifying its contents.

After cloning/downloading this branch, run from the repository root:

```sh
python3 data/raw/choice/restore_2023.py
```

The script joins the parts in order and verifies the original SHA-256 before writing the PDF.
Keep all five parts. The restored PDF is a local working file; do not upload it through the browser.

Original SHA-256: 7e5449c337852cffa9d8075d7c7c1ca80d01398997875baeb7692ac249562eba

Official source files:
- 2023: https://www.choicereit.ca/wp-content/uploads/2025/09/Choice-REIT-Annual-Report-2023-Final-Release-AODA.pdf
- 2024: https://www.choicereit.ca/wp-content/uploads/2025/09/Q30_7336_CP_AR_2024_ENG_March_17A_AODA.pdf
- 2025: https://www.choicereit.ca/wp-content/uploads/2026/03/Choice-Properties-2025-Annual-Report-English-AODA.pdf
