# BackupTool

![Version](https://img.shields.io/badge/version-1.0-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows%2010%20%7C%2011-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

**BackupTool** is a robust, portable, and high-performance backup utility for Windows. Built as a GUI wrapper for the native **Robocopy** engine, it allows users to perform incremental backups and full drive mirroring with professional efficiency and zero installation.

> 🚀 **Available on Microsoft Store** (Coming Soon)

## 🌟 Key Features

* **⚡ High-Performance Engine:** Powered by Windows native Robocopy with multi-threading support (`/MT:16`).
* **🌍 Multi-Language Interface:** Native support for **11 languages** (English, Portuguese, Spanish, German, French, Italian, Russian, Hindi, Arabic, Japanese, Chinese).
* **🛡️ Drive Safety:** Automatically ignores system protected folders (like `System Volume Information`) when copying entire drives.
* **⚙️ Smart Modes:**
    * **Default:** Incremental copy (only new or changed files).
    * **Mirror:** Full synchronization (deletes files in destination that are not in source).
* **🚀 Direct Execution:** Optimized for speed, starting the backup process immediately without pre-calculation delays.
* **🔒 Privacy Focused:** All processing is local. No data leaves your computer.

## 📥 Download & Installation

### Option 1: Portable (Recommended for Developers)
1.  Go to the [Releases](https://github.com/CMouraB/BackupTool/releases) page.
2.  Download `BackupTool.exe`.
3.  Run it directly (No installation required).

### Option 2: Installer (Windows)
Download the `BackupTool_Setup.exe` for a standard installation with Start Menu shortcuts.

## 🛠️ Technical Requirements

* Windows 10 or Windows 11 (x64).
* PowerShell 5.1 or higher (Pre-installed on Windows).
* **Administrator Privileges** are recommended for full drive backups (e.g., `D:\` to `E:\`).

## 🤝 Support the Project

This project is open-source and free. If it saved your files or your time, consider buying me a coffee!

<a href="https://www.paypal.com/donate/?business=AJQHMVMPV9APS&no_recurring=0&currency_code=USD">
  <img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" alt="Donate with PayPal" />
</a>

## 📄 Privacy Policy

We respect your privacy. This application functions offline and does not collect telemetry.
Read our full [Privacy Policy](https://moura.in.net/backuptool-privacy.html).

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

---
**Developed by Moura**
[moura.in.net](http://moura.in.net)
