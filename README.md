# MASM-in-class

## 環境設置

### Irvine

下載 [Irvine library](https://github.com/surferkip/asmbook)，解壓縮 `Irvine.zip` 到 C 槽根目錄下 -> `C:\Irvine`

### VS 2022

建立新專案 -> 空白專案 -> 建立

工具 -> 匯入和匯出設定 -> 匯入選取的環境設定 -> 否，只需匯入新設定並覆寫目前設定 -> 選 `Visual C++` -> 完成

右鍵專案名稱 -> 組建相依性 -> 把 masm 打勾

右鍵專案名稱 -> 加入 -> 新增項目 -> 輸入檔名 -> `[name].asm`

右鍵 asm 檔 -> 屬性 -> 一般 -> 項目類型 -> Microsoft Marco Assembler

右鍵專案名稱 -> 屬性 -> Microsoft Marco Assembler -> General -> Include Paths -> 編輯 -> 輸入 `C:\Irvine`

右鍵專案名稱 -> 屬性 -> 連結器 -> 一般 -> 其他程式庫目錄 -> 編輯 -> 新增一行並輸入 `C:\Irvine`

右鍵專案名稱 -> 屬性 -> 連結器 -> 輸入 -> 其他相依性 -> 編輯 -> 輸入 `Irvine32.lib`

Debug x64 改成 x86，在執行時有可能被防毒軟體擋掉，到防毒軟體那邊允許執行