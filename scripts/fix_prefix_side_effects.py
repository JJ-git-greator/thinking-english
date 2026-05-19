"""
Fix the side effects of prefix_tables.py:
1. Revert URL path strings (/learn/te_passages -> /learn/passages, etc.)
2. Revert local variable name 'te_passages' back to 'passages' for cleanliness

DB tables stay as te_*. Only URL paths and unrelated variable names get reverted.
"""
import io, re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# URL-path strings: revert
URL_REVERTS = [
    ("/learn/te_passages", "/learn/passages"),
    ("/learn/te_paragraphs", "/learn/paragraphs"),
]

# Local variable name (page.tsx) — revert just the destructure pattern
VAR_REVERTS = [
    ("data: te_passages }", "data: passages }"),
    ("te_passages ?? [])", "passages ?? [])"),
    ("(te_passages ?? []).map", "(passages ?? []).map"),
    ("!te_passages || te_passages.length", "!passages || passages.length"),
]

TARGET_DIRS = [ROOT / "app", ROOT / "lib", ROOT / "components"]
TARGET_EXTS = {".ts", ".tsx"}

def main():
    total = 0
    for d in TARGET_DIRS:
        for path in d.rglob("*"):
            if path.is_file() and path.suffix in TARGET_EXTS:
                content = path.read_text(encoding="utf-8")
                original = content
                for old, new in URL_REVERTS + VAR_REVERTS:
                    content = content.replace(old, new)
                if content != original:
                    path.write_text(content, encoding="utf-8")
                    total += 1
                    print(f"  fixed: {path.relative_to(ROOT)}")
    print(f"\nTotal: {total} files")

if __name__ == "__main__":
    main()
