`CollectionScreen` adalah layar utama Photocard Vault. Hanya widget ini yang
memiliki state: `_isLoading`, `_cards`, `_query`, dan `_selectedTag`. Semua
widget anaknya bersifat stateless. Mereka menerima nilai lewat parameter
constructor dan melaporkan aksi pengguna ke atas lewat callback (state hoisting).

## Widget yang diekstrak

### CollectionSearchBar
- **Trigger:** Keterbacaan (readability). Kolom pencarian beserta padding dan
  teks petunjuknya akan membuat method `build()` layar terlalu penuh.
- **Memiliki:** Hanya tampilannya: padding, teks petunjuk, dan ikon pencarian.
- **Melapor ke atas:** `onChanged(String)` berisi teks yang sedang diketik.
  Layar menyimpannya di `_query` lalu menyaring daftar kartu.

### TagFilterRow
- **Trigger:** Keterbacaan. Menyusun baris chip yang bisa digeser mendatar
  adalah tata letak yang berdiri sendiri.
- **Memiliki:** Baris yang bisa digeser, jarak antar chip, dan tampilan chip
  ketika dipilih (`tag == selected`).
- **Melapor ke atas:** `onSelected(String?)` berisi tag yang ditekan, atau
  `null` ketika chip yang sedang dipilih ditekan lagi untuk membatalkan filter.

### CollectionGrid
- **Trigger:** Keterbacaan. Konfigurasi grid cukup panjang dan tidak berkaitan
  dengan logika state layar.
- **Memiliki:** Tata letak grid yang responsif (`maxCrossAxisExtent`, jarak,
  dan rasio aspek) serta `ValueKey` untuk tiap tile agar identitas tile tetap
  terjaga ketika daftar disaring.
- **Melapor ke atas:** `onToggleOwned(String id)`, diteruskan dari sebuah tile
  bersama id kartu tersebut.

### PhotocardTile
- **Trigger:** Pemakaian ulang (reuse). Satu instance dibuat untuk setiap
  kartu, sehingga ini adalah potongan UI yang paling sering berulang.
- **Memiliki:** Tata letak kartu, gambar dengan tampilan cadangan saat gagal
  dimuat, pemotongan teks (`maxLines` dan ellipsis), serta ikon hati yang
  mengikuti nilai `card.owned`.
- **Melapor ke atas:** `onToggleOwned()` ketika hati ditekan. Tile tidak tahu
  posisinya di dalam daftar; grid yang menambahkan id-nya.

### EmptyState
- **Trigger:** Pemakaian ulang. Tampilan "tidak ada yang ditampilkan" yang sama
  bisa dipakai untuk pencarian yang tidak menemukan hasil sekarang, dan untuk
  kondisi kosong lain di layar berikutnya.
- **Memiliki:** Ikon, jarak, dan gaya teks pesan.
- **Melapor ke atas:** Tidak ada. Widget ini murni untuk tampilan.

## Mengapa state berada di layar

Teks pencarian, tag yang dipilih, dan daftar kartu semuanya memengaruhi apa
yang ditampilkan grid, sehingga ketiganya harus berada di satu induk bersama.
Menyimpannya di `CollectionScreen` menghasilkan satu sumber kebenaran (single
source of truth), dan widget anak tetap sederhana, mudah dipakai ulang, dan
mudah diuji.