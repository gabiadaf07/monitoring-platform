def compare_files_line_by_line(file1, file2):
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        for line1, line2 in zip(f1, f2):
            if line1 != line2:
                return False
        return True


def compare_files_verbose(file1, file2):
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        lines1 = f1.readlines()
        lines2 = f2.readlines()

    max_len = max(len(lines1), len(lines2))
    different = False

    for i in range(max_len):
        line1 = lines1[i].strip() if i < len(lines1) else "<EOF>"
        line2 = lines2[i].strip() if i < len(lines2) else "<EOF>"

        if line1 != line2:
            print(f"🔸 Diferență la linia {i+1}:\n  {file1}: {line1}\n  {file2}: {line2}")
            different = True

    if not different:
        print("✅ Fișierele sunt identice.")




result = compare_files_line_by_line(
    "../scripts/backups/monitoring_backup_20251025_1458.txt",
    "../scripts/backups/monitoring_backup_20251025_1500.txt"
)
diferente=compare_files_verbose(
    "../scripts/backups/monitoring_backup_20251025_1458.txt",
    "../scripts/backups/monitoring_backup_20251025_1500.txt"
)


print("Fișierele sunt identice." if result else "Fișierele sunt diferite."
"{diferente}")
