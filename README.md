# BackupTool
A simple app to backup your files in a storage!

# Backup Tool v1.0

A robust and multi-language incremental backup tool for Windows, powered by the **Robocopy** engine to ensure maximum performance and reliability. Designed to be simple, fast, and secure.

## 🚀 Features

* **Robocopy Engine:** Utilizes native Windows technology for high-speed transfers with multi-threading support.
* **Incremental Backup:** Compares files by date and size, copying only what has been changed.
* **Mirror Mode:** Option for exact synchronization, removing files in the destination that no longer exist in the source.
* **Multi-language Interface:** Native support for 11 languages:
    * Portuguese, English, Spanish, German, French, Italian, Russian, Hindi, Arabic, Japanese, and Chinese.
* **Auto-Detection:** Automatically identifies the operating system language on first launch.
* **Real-Time Log:** Progress visualization directly within the application interface.
* **Data Persistence:** Automatically saves your last path settings and preferences.
* **Drive Security:** Special handling for full drive backups (e.g., D:\ to E:\), automatically ignoring system folders and the recycle bin.

## 🛠️ Requirements

* Windows 10 or 11.
* PowerShell 5.1 or higher (native to Windows).
* Administrator Privileges (recommended for full drive backups).

## 📦 How to Use the Executable

1.  Download the `BackupTool.exe` file from the [Releases](link-to-your-release) tab.
2.  Run the application (Windows SmartScreen may show an alert for new apps; click "More info" > "Run anyway").
3.  Select the **Source** folder or drive.
4.  Select the **Destination** folder or drive.
5.  Click **Start Backup**.
6.  Once finished, use the **Open Log** button to check the details of the operation.

## 🏗️ Project Structure

* `/src`: PowerShell source code (`.ps1`).
* `/assets`: Icons and screenshots.
* `settings.json`: Automatically generated file to save user preferences.

## 📝 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

Developed by **Moura**.
🌐 [moura.in.net](http://moura.in.net)
