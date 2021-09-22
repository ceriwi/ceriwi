---
layout: default
---

## Apa itu ceriwi crawler
Ceriwi crawler adalah crawler sederhana untuk mengumpulkan data dari halaman website berdasarkan rule.

## Fitur yang tersedia saat ini
 - Extract web menggunakan file config json.
 - Merubah format data hasil crawler ke dalam bentuk excel.

## Bagaimana cara menggunakannya

pull dan up terlebih dahulu image ceriwi-crawler beserta image pendukung lainnya dengan menggunakan perintah dibawah ini.
```bash
git clone https://github.com/ceriwi/example-config.git
cd example-config
docker-compose up -d
docker-compose exec myceriwi run --db-migration
```

Untuk mengambil data berdasarkan rule yang sudah di buat, bisa menjalankan perintah berikut :
```bash
cat config/blog-1.json | docker-compose exec -T myceriwi run --config
```

Hasil crawler bisa dilihat di http://localhost <br />
untuk mengubah port atau configurasi lainnya silakan buka file docker-compose.yml

## File konfigurasi 
File konfigurasi adalah file yang berisi aturan untuk mengambil data, di dalam file konfigurasi Ada 4 bagian utama :
source, data, dataRebuild, dataType.
```json
{
    "source": {},
    "data": {},
    "dataRebuild":{},
    "dataType":{}
}
```

### Konfigursi source
Konfigurasi source berperan untuk mengatur dari mana data di ambil.
Berikut adalah properties yang tersedia di konfigurasi source :
 - **name** : string <br />
   Berfungsi sebagai nama dari konfigurasi.
 - **url** : string <br />
   Berfungsi sebagai alamat data yang akan di ambil
 - **remove-query** : true atau false <br />
   Berfungsi menghapus query url, contoh `?a=1&b=1#coba`
 - **remove-fragment** : <br />
   Berfungsi menghapus fragment url, contoh `#coba`
 - **browser** : json object <br />
   Berfungsi mengarahkan browser mana yang akan digunakan jika properties 
   browser tidak di tulis maka default yang di gunakan adalah curl, 
   untuk saat ini browser yang bisa dihubungkan hanya selenium - chrome.

contoh :
```json
    "source": {
        "name":"demo get data blogjs part 2",
        "url":"https://ceriwi.github.io/test/rule4/index.html",
        "remove-query": true,
        "remove-fragment": true,
        "browser": {
            "name" : "chrome",
            "host" : "http://chrome:4444/wd/hub"
        }
    }
```

## konfigurasi data
Konfigurasi data berperan untuk mengatur data mana yang akan di ambil.
Berikut adalah properties yang tersedia di konfigurasi data :
 - **id** : json object
 - **class** : json object
 - **tag** : json object
 - **attrib** : json object
 - **xpathidclas** : json object
 - **xpath** : json object
 - **pattern** : json object

masing masing dari properties di atas memiliki properties lagi di dalamnya.
### Konfigurasi data.id
properties data.id berisikan array object dengan properties sebagai berikut :
  - **name** : string <br />
  - **alias** : string <br />
  - **child** : json object <br />
  - **remove** : json object <br />
  - **remove-after-select** : json object <br />

### Konfigurasi data.class
properties data.class hampir sama dengan data.id yang membedahkan di data tidak ada index :
  - **name** : string <br />
  - **alias** : string <br />
  - **index** : int <br />
  - **child** : json object <br />
  - **remove** : json object <br />
  - **remove-after-select** : json object <br />

### Konfigurasi data.tag
properties data.tag sama dengan data.class

### Konfigurasi data.attrib
properties data.tag sama dengan data.class

### Konfigurasi data.xpathidclass
properties data.xpathidclass sama dengan data.class

### Konfigurasi data.xpath
properties data.xpath sama dengan data.class

### Konfigurasi data.pattern
properties data.pattern sama dengan data.class

### konfigurasi data.\*.child
konfigurasi data.\*.child memiliki fungsi sama dengan konfigurasi data

### konfigurasi data.\*.remove
konfigurasi data.\*.remove memiliki fungsi untuk menghapus bagian yang tidak diperlukan dari sebuah data
Berikut adalah properties yang ada di data.\*.remove :
 - **class** : json object
    ```json
    "remove":{
        "class":[
            {"name":"items"}
        ]
    }
    ```
 - **tag** : json object
     ```json
    "remove":{
        "tag":[
            {"name":"p"}
        ]
    }
    ```
 - **id** : json object
    ```json
    "remove":{
        "id":[
            {"name":"item-1"}
        ]
    }
    ```
 - **attrib** : json object
    ```json
    "remove":{
        "attrib":[
            {"name":"class", "value":"card"}
        ]
    }
    ```
 - **xpath** : json object
    ```json
    "remove":{
        "xpath":[
            {"name":"p"}
        ]
      }
    ```
 - **pattern** : json object
    ```json
    "remove": {
        "pattern":[
            {"pattern":"#kategori : #i"}
        ]
    }
    ```
 - **striptag** : json object
    ```json
    "remove": {
      "striptag":[
          {"name":""}
      ]
    }
    ```

### konfigurasi data.\*.remove-after-select
Sama dengan data.\*.remove hanya saja yang membedakan, konfigurasi ini di jalankan seteleh data sudah terbentuk atau element data sudah pilih


## konfigurasi dataRebuild
Konfigurasi dataRebuild berperan untuk mengatur ulang data yang ingin di ambil.
Berikut adalah properties yang tersedia di konfigurasi dataRebuild :
  - **name of data or alias** : "" | "optional" | "fix"

**string kosong** jika data rebuild memiliki aturan string kosong, maka data ini wajib ada, jika data tidak ada maka tidak akan di simpan kedalam database,

**optional** jika data rebuild memiliki aturan optional, maka data akan tetap di simpan ke dalam database meski field tersebut tidak di temukan pada pembentukan data.

**fix** jika data rebuild memiliki aturan fix, maka data tersebut akan menjadi data fix sampai data berikutnya di temukan, contoh ini bisa di lihat pada file konfigurasi produk-4.json

## konfigurasi dataType 
Konfigurasi dataType berperan untuk mengatur bagaimana cara data di simpan, 
Ada 2 value yang tersedia di dataType, value tersebut adalah :
  - **string kosong** <br />
  Secara default jika dataType tidak di tulis dalam file konfigurasi maka dataType bernilai string kosong
  ```json
      "dataType":""
  ```
  - **multi** <br />
  ```json
      "dataType":"multi"
  ```
Untuk lebih menjelaskan apa itu dataType bisa di ambil contoh pada file konfigurasi blogjs-1.json dan produk-1.json. <br />
Data yang terbentuk oleh file konfigurasi blogjs-1.json adalah sebegai berikut 
```bash
Array
(
    [title] => Surabaya
    [content] => Surabaya, Kota dimana aku dilahirkan, kota pahlawan yang penuh dengan kenangan.
    ..... di potong biar hemat .....
)
```
Sedangkan data yang terbentuk oleh file konfigurasi produk-1.json
```bash
Array
(
    [0] => Array
        (
            [nama produk] => Produk 13
            [harga] => Rp 13.000
        )

    [1] => Array
        (
            [nama produk] => Produk 14
            [harga] => Rp 14.000
        )
    ..... di potong biar hemat .....
)
```

Untuk mendapatkan contoh konfigurasi yang lain anda bisa temukan di <https://github.com/ceriwi/example-config>
