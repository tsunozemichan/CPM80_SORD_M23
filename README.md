# CPM80_SORD_M23
CP/M-80 for SORD M23

This is a project to port CP/M-80 to the SORD M23.

At the current stage, the basic BIOS has been completed.
Work is ongoing to fully implement control codes and screen control routines.

File descriptions

bios.z80
BIOS source file

cpmloader08.z80
CP/M-80 loader (placed at the beginning of a floppy disk track)

updateCPMSYS.py
Python script to embed bios.bin into CPM.SYS

CPM.SYS
CP/M-80 system file, executable on the SORD M23 emulator

cpm_M23.d88
Disk image for the SORD M23 emulator (D88 format)

2026/01/01

TAB and ESC keys implemented

Cursor X/Y coordinate calculation subroutine implemented

ToDo

Implement subroutines required for S-OS (not directly related to CP/M)


SORD M23へのCP/M-80の移植プロジェクトです。

現状で、基本的なBIOSは完成しています。現在は、コントロールコードの完備、画面制御コードの完備を行っています。

ファイルの説明

- bios.z80 BIOSファイル
- cpmloader08.z80 CP/M-80のローダー(FDのトラック先頭に配置)
- updateCPMSYS.py bios.binをCPM.SYSに組み込むpyrhonスクリプト
- CPM.SYS CP/M-80のシステム。SORD M23エミュレータで実行可能
- cpm_M23.d88 SORD M23エミュレータ用のディスクイメージ(D88形式)
- change_cpmsys.py rawディスクイメージのCPM.SYS置換ツール
- buid_and_update_cpm.bat BIOSをアセンブルし、CPM.SYSに組み込み、さらにd88イメージに組み込むバッチファイル
- README_BIOS_BUILD.md BIOSビルド手順書

2026/01/01

- TAB、ESCキーの実装完了
- カーソルのX,Y座標の計算サブルーチンの実装完了

ToDo:
- (CP/Mには直接関係ないが)S-OSに必要なサブルーチンを実装していく

