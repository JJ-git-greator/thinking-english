"""
Apply 'te_' prefix to all thinking-english tables for sharing
a Supabase project with pampas-reading.

Run from project root: python scripts/prefix_tables.py
"""
import io
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# words to prefix (table names, type names, function names, trigger name)
WORDS = [
    "organizations",
    "profiles",
    "passages",
    "paragraphs",
    "gist_notes",
    "reconstruction_attempts",
    "student_progress",
    "user_role",
    "difficulty_tier",
    "handle_new_user",
    "auth_org_id",
    "auth_role",
]

TRIGGER_RENAME = ("on_auth_user_created", "on_auth_user_created_te")

TARGET_DIRS = [
    ROOT / "app",
    ROOT / "lib",
    ROOT / "components",
    ROOT / "supabase",
    ROOT / "docs",
]
TARGET_EXTS = {".ts", ".tsx", ".sql", ".md"}

def apply_word_boundary_sub(text: str) -> tuple[str, int]:
    count = 0
    for w in WORDS:
        pattern = re.compile(r"\b" + re.escape(w) + r"\b")
        new_text, n = pattern.subn("te_" + w, text)
        # Avoid re-prefixing already-prefixed
        new_text = new_text.replace("te_te_", "te_")
        text = new_text
        count += n
    # Trigger rename (special case, suffix-style for clarity)
    pattern = re.compile(r"\b" + re.escape(TRIGGER_RENAME[0]) + r"\b")
    new_text, n = pattern.subn(TRIGGER_RENAME[1], text)
    text = new_text
    count += n
    return text, count

def main():
    total_files = 0
    total_replacements = 0
    for d in TARGET_DIRS:
        if not d.exists():
            continue
        for path in d.rglob("*"):
            if path.is_file() and path.suffix in TARGET_EXTS:
                content = path.read_text(encoding="utf-8")
                new_content, n = apply_word_boundary_sub(content)
                if n > 0:
                    path.write_text(new_content, encoding="utf-8")
                    total_files += 1
                    total_replacements += n
                    print(f"  {path.relative_to(ROOT)}: {n} replacements")
    print(f"\nTotal: {total_files} files, {total_replacements} replacements")

if __name__ == "__main__":
    main()
