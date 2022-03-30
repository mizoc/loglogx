# loglogx
Very Simple logging(in the meaning of ham radio) TUI script for Linux.  

I prefer paper logs, but when I calling CQ, due to the large number of QSOs, I usually use this script.  
ADIF format is supported. So, you can upload to eQSL.cc.  

## Installtion
```bash
First of all, install dialog
$git clone https://github.com/mizoc/loglogx
```

## Usage
```bash
$./loglogx.sh SAVE_DESTINATION.csv
$./csv2adif.sh IN.csv >OUT.adi  #When you want adif format
```
![demo](https://user-images.githubusercontent.com/47818505/160543535-7285091a-c507-49e5-a9be-7e673d290f9e.gif)
