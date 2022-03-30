![loglogx](https://latex.codecogs.com/png.image?\inline&space;\huge&space;\dpi{200}\color{Blue}\log{\log{x}})  

loglogx is a very simple logging(in the meaning of ham radio) TUI script for Linux.  

I prefer paper logs, but when I calling CQ, due to the large number of QSOs, I usually use this script.  
So, it has only a few functions.  

ADIF format is supported and you can upload to eQSL.cc.  

## Installtion
Install dialog.  
```bash
$git clone https://github.com/mizoc/loglogx
$cd $_
#link *.sh to somewhere like /usr/local/bin/, if you want.
```

## Usage
```bash
$./loglogx.sh SAVE_DESTINATION.csv
$./csv2adif.sh IN.csv >OUT.adi  #When you want adif format
```
![demo](https://user-images.githubusercontent.com/47818505/160543535-7285091a-c507-49e5-a9be-7e673d290f9e.gif)
