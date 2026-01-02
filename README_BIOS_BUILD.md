# SORD M23 CP/M BIOS ビルド＆更新ツール

## 概要

SORD M23用のCP/M BIOSをアセンブルし、CPM.SYSファイルを作成、さらにd88ディスクイメージに組み込むまでを自動化するスクリプト集です。

## ファイル一覧

### メインスクリプト
- `build_and_update_cpm.bat` - Windowsバッチファイル版
- `build_and_update_cpm.ps1` - PowerShell版

### ユーティリティ
- `change_cpmsys.py` - rawディスクイメージのCPM.SYS置換ツール
- `change_cpmsys_d88.py` - d88ディスクイメージのCPM.SYS置換ツール

## 必要な環境

- Windows OS
- Python 3.x
- AILZ80ASM.exe (Z80アセンブラ)
- makeCPMsys.py (BIOS→CPM.SYS変換スクリプト)

## 使用方法

### バッチファイル版

```batch
build_and_update_cpm.bat <BIOSソースファイル.z80> [d88イメージファイル]
```

**例1: BIOSをアセンブルしてCPM.SYSを作成（d88更新なし）**
```batch
build_and_update_cpm.bat bios.z80
```

**例2: BIOSをアセンブルしてCPM.SYSを作成、d88イメージも更新**
```batch
build_and_update_cpm.bat bios.z80 cpm_new.d88
```

### PowerShell版

```powershell
.\build_and_update_cpm.ps1 <BIOSソースファイル.z80> [d88イメージファイル]
```

**例1: BIOSをアセンブルしてCPM.SYSを作成（d88更新なし）**
```powershell
.\build_and_update_cpm.ps1 bios.z80
```

**例2: BIOSをアセンブルしてCPM.SYSを作成、d88イメージも更新**
```powershell
.\build_and_update_cpm.ps1 bios.z80 cpm_new.d88
```

## 処理フロー

1. **アセンブル**: AILZ80ASM.exeでBIOSソースファイルをアセンブル
   - 入力: `<basename>.z80`
   - 出力: `<basename>.bin`, `<basename>.lst`

2. **CPM.SYS作成**: makeCPMsys.pyでBIOSバイナリをCPM.SYSに組み込む
   - 入力: `<basename>.bin`
   - 出力: `CPM.SYS`

3. **d88更新**: change_cpmsys_d88.pyでd88イメージを更新（オプション）
   - 入力: 指定されたd88ファイル、`CPM.SYS`
   - 出力: 更新されたd88ファイル（上書き）

## 個別ツールの使用方法

### change_cpmsys.py (rawイメージ用)

```batch
python change_cpmsys.py <cpm.img> <新CPM.SYS> [<cpm_new.img>]
```

- `<cpm.img>`: 元のrawディスクイメージ
- `<新CPM.SYS>`: 置き換えるCPM.SYSファイル
- `[<cpm_new.img>]`: 出力ファイル名（省略時は元のファイルを上書き）

### change_cpmsys_d88.py (d88イメージ用)

```batch
python change_cpmsys_d88.py <cpm.d88> <新CPM.SYS> [<cpm_new.d88>]
```

- `<cpm.d88>`: 元のd88ディスクイメージ
- `<新CPM.SYS>`: 置き換えるCPM.SYSファイル
- `[<cpm_new.d88>]`: 出力ファイル名（省略時は元のファイルを上書き）

## ディスク構成の詳細

### SORD M23 CP/M80 ディスク仕様
- セクタサイズ: 256バイト
- トラックあたりのセクタ数: 16
- FCB開始位置: トラック2、セクタ1

### CPM.SYS配置
- グループ29h: トラック22、セクタ9-16
- グループ2Ah: トラック23、セクタ1-8
- グループ2Bh: トラック23、セクタ9-16
- グループ2Ch: トラック24、セクタ1-8
- 合計: 32セクタ (8192バイト)

## トラブルシューティング

### エラー: アセンブルに失敗しました
- AILZ80ASM.exeが正しいパスにあるか確認
- BIOSソースファイルに文法エラーがないか確認

### エラー: CPM.SYS作成に失敗しました
- makeCPMsys.pyが正しいパスにあるか確認
- Pythonが正しくインストールされているか確認

### エラー: d88イメージ更新に失敗しました
- d88ファイルが存在するか確認
- d88ファイルに書き込み権限があるか確認
- change_cpmsys_d88.pyが正しいパスにあるか確認

## ライセンス

これらのツールはSORD M23のCP/M開発をサポートするために作成されました。
自由に使用・改変していただいて構いません。

## 更新履歴

- 2026-01-02: 初版リリース
  - build_and_update_cpm.bat/ps1 作成
  - change_cpmsys.py 作成
  - change_cpmsys_d88.py 作成
