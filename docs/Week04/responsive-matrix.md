
| Layar / Gambar | Kasus Pengujian (Test Case) | Status | Catatan Perbaikan & Implementasi |
|---|---|---|---|
| ![alt text](test1.png) | **Small Phone** (Lebar 320 dp) | **PASS** | Membungkus filter tag dalam `SingleChildScrollView` horizontal. Mengatur padding kartu agar pas di lebar 320dp tanpa horizontal overflow. |
| ![alt text](test2.png) | **Large Phone** (Lebar 430 dp) | **PASS** | Grid kartu otomatis beradaptasi dengan `SliverGridDelegateWithMaxCrossAxisExtent(220)` menampilkan 2 kolom seimbang. |
| ![alt text](test3.png) | **Tablet** (Lebar 800 dp) | **PASS** | Layout berubah melalui `LayoutBuilder`: bertransformasi dari 1 kolom HP menjadi 2 Pane Split Screen (Sidebar Kontrol di kiri + Galeri Kartu di kanan). |
| ![alt text](test4.png) | **Landscape** (Rotasi Perangkat) | **PASS** | `LayoutBuilder` mendeteksi mode lanskap dan otomatis berubah menjadi tampilan 2 Pane dengan sidebar yang dapat di-scroll. |
| ![alt text](test5.png) | **Long Text** (Teks 200 Karakter) | **PASS** | Diuji dengan nama member 200+ karakter. Semua `Text` memakai `maxLines` & `overflow: TextOverflow.ellipsis`. Tap pada kartu membuka modal detail untuk melihat teks lengkap. |
| ![alt text](test6.png) | **Empty State** (0 Item) | **PASS** | Diuji dengan dataset 0 kartu. Menampilkan widget `EmptyState` dengan Ikon Inbox (`Icons.inbox`), pesan penjelasan, dan tombol aksi "Reset Search". |
| ![alt text](test7.png) | **Long List** (500 Items) | **PASS** | Diuji dengan 500 kartu dari `generate500Cards()`. Parameter `shrinkWrap: true` dihapus dan dibungkus `Expanded` untuk scroll mulus 60fps. |
| ![alt text](test8.png) | **Keyboard** (Layar Pendek dengan IME) | **PASS** | `SearchBar` dan grid berada dalam `Column` + `Expanded`, memastikan kolom input tetap fokus di atas keyboard tanpa warning `A RenderFlex overflowed`. |
| ![alt text](test9.png) | **Dark Mode** (Mode Gelap) | **PASS** | Menggunakan `AppTheme.darkTheme` & `AppTheme.lightTheme` berbasis `Theme.of(context)` sehingga teks dan warna kartu sangat jelas dibaca di kedua mode. |

---

## Kesimpulan
Seluruh 9 poin tes checklist telah dijalankan dan **LULUS (PASS)** tanpa ada garis kuning-hitam (*yellow stripes*) maupun konten yang terpotong secara tidak rapi.
