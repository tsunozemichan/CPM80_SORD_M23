# CPM80_SORD_M23
CP/M-80 for SORD M23

SORD M23へのCP/M-80の移植プロジェクトです。

現状で、基本的なBIOSは完成しています。現在は、コントロールコードの完備、画面制御コードの完備を行っています。

ファイルの説明

- bios.z80 BIOSファイル
- cpmloader08.z80 CP/M-80のローダー(FDのトラック先頭に配置)
- updateCPMSYS.py bios.binをCPM.SYSに組み込むpyrhonスクリプト
- CPM.SYS CP/M-80のシステム。SORD M23エミュレータで実行可能
- cpm_M23.d88 SORD M23エミュレータ用のディスクイメージ(D88形式)


2026/01/01

- TAB、ESCキーの実装完了
- カーソルのX,Y座標の計算サブルーチンの実装完了

ToDo:
- (CP/Mには直接関係ないが)S-OSに必要なサブルーチンを実装していく

