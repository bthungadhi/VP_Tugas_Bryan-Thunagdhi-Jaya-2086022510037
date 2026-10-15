1. Row Overflow ke Samping Kanan (A RenderFlex overflowed on the right)

Screenshot Error

![alt text](error.png)

Penyebab Error

Error ini terjadi ketika total lebar widget di dalam Row melebihi ruang yang tersedia. Salah satu contohnya adalah penggunaan Text dengan kalimat yang terlalu panjang tanpa pengaturan lebar. Akibatnya, teks tetap berusaha ditampilkan secara horizontal hingga melewati batas layar dan memunculkan garis kuning-hitam.

Kode Sebelum Diperbaiki

Row(
  children: [
    const Icon(Icons.person),
    Text(
      'Nama Member Dengan Teks Yang Sangat Panjang Melebihi Lebar Layar Tanpa Memotong Teks',
      style: const TextStyle(fontSize: 16),
    ),
  ],
)

Kode Sesudah Diperbaiki

Row(
  children: [
    const Icon(Icons.person),
    Expanded(
      child: Text(
        'Nama Member Dengan Teks Yang Sangat Panjang Melebihi Lebar Layar Tanpa Memotong Teks',
        style: const TextStyle(fontSize: 16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
)

Solusi

Untuk mengatasi masalah ini, saya menggunakan Expanded agar widget Text menempati ruang yang tersisa di dalam Row. Selain itu, maxLines: 1 membatasi teks menjadi satu baris, sedangkan TextOverflow.ellipsis menambahkan tanda titik tiga jika teks terlalu panjang. Dengan cara ini, teks tidak lagi melewati batas layar.

2. Column Overflow ke Bawah (A RenderFlex overflowed on the bottom)

Screenshot Error

![alt text](error.png)

Penyebab Error

Error ini muncul ketika jumlah tinggi seluruh widget di dalam Column melebihi tinggi ruang yang tersedia. Misalnya, halaman memiliki beberapa kartu, jarak kosong yang besar, dan tombol di bagian bawah. Ketika semuanya tidak muat di layar, sebagian konten akan melewati batas yang tersedia dan menyebabkan overflow. Masalah ini juga dapat terjadi ketika keyboard muncul dan mengurangi ruang untuk menampilkan konten.

Kode Sebelum Diperbaiki

Column(
  children: [
    const SearchBar(),
    const SizedBox(height: 250),
    const CardTile(),
    const SizedBox(height: 250),
    const CardTile(),
    const SizedBox(height: 250),
    ElevatedButton(
      onPressed: () {},
      child: const Text('Simpan'),
    ),
  ],
)

Kode Sesudah Diperbaiki

SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
  child: Column(
    children: [
      const SearchBar(),
      const SizedBox(height: 250),
      const CardTile(),
      const SizedBox(height: 250),
      const CardTile(),
      const SizedBox(height: 250),
      ElevatedButton(
        onPressed: () {},
        child: const Text('Simpan'),
      ),
    ],
  ),
)

Solusi

Saya mengatasi masalah ini dengan membungkus Column menggunakan SingleChildScrollView. Dengan begitu, pengguna dapat menggulir halaman untuk melihat konten yang tidak muat di layar. Saya juga menggunakan BouncingScrollPhysics agar efek gulir terasa lebih natural. Solusi ini cocok untuk halaman yang memiliki banyak konten dengan tinggi yang dapat bertambah.

3. ListView di Dalam Column (Vertical viewport was given unbounded height)

Screenshot Error

![alt text](error.png)

Penyebab Error

Error ini terjadi ketika ListView diletakkan langsung di dalam Column tanpa batas tinggi yang jelas. ListView membutuhkan ruang vertikal yang terukur agar dapat menampilkan dan menggulir daftar dengan benar. Sementara itu, Column mencoba memberikan ruang kepada anak-anaknya berdasarkan kebutuhan masing-masing. Akibatnya, ListView tidak mendapatkan batas tinggi yang dibutuhkan dan Flutter menampilkan error.

Kode Sebelum Diperbaiki

Column(
  children: [
    const Text('Daftar Koleksi'),
    ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
        );
      },
    ),
  ],
)

Kode Sesudah Diperbaiki

Column(
  children: [
    const Text('Daftar Koleksi'),
    Expanded(
      child: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    ),
  ],
)

Solusi

Untuk memperbaikinya, saya menggunakan Expanded pada ListView.builder. Widget ini membuat daftar menggunakan sisa tinggi yang tersedia di dalam Column, sehingga ListView mendapatkan batas ruang yang jelas. Dengan demikian, daftar dapat ditampilkan dan digulir tanpa menimbulkan error akibat tinggi yang tidak terbatas.

Perlu diperhatikan bahwa solusi ini digunakan ketika Column berada di dalam parent yang memiliki batas tinggi. Jika parent-nya juga memiliki tinggi yang tidak terbatas, pendekatan layout yang digunakan perlu disesuaikan.