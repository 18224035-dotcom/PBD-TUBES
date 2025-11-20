
-- basdatfood.sql
-- DDL untuk seluruh relasi skema BasdatFood

CREATE TABLE IF NOT EXISTS pengguna (
    username VARCHAR(20) NOT NULL,
    email VARCHAR(40) NOT NULL,
    password VARCHAR(30) NOT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS driver (
    username VARCHAR(20) NOT NULL,
    nama VARCHAR(40) NOT NULL,
    nik VARCHAR(20) NOT NULL,
    alamat VARCHAR(80) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    jenis_kendaraan VARCHAR(20) NOT NULL,
    no_plat VARCHAR(15) NOT NULL,
    bank VARCHAR(20) NOT NULL,
    no_rekening VARCHAR(25) NOT NULL,
    PRIMARY KEY (username),
    CONSTRAINT fk_driver_pengguna
        FOREIGN KEY (username) REFERENCES pengguna(username)
);

CREATE TABLE IF NOT EXISTS pelanggan (
    username VARCHAR(20) NOT NULL,
    nama VARCHAR(40) NOT NULL,
    status_langganan VARCHAR(20) NOT NULL,
    PRIMARY KEY (username),
    CONSTRAINT fk_pelanggan_pengguna
        FOREIGN KEY (username) REFERENCES pengguna(username)
);

CREATE TABLE IF NOT EXISTS restoran (
    username VARCHAR(20) NOT NULL,
    nama_restoran VARCHAR(40) NOT NULL,
    alamat_restoran VARCHAR(80) NOT NULL,
    nama_pemilik VARCHAR(40) NOT NULL,
    nik_pemilik VARCHAR(20) NOT NULL,
    npwp_pemilik VARCHAR(20) NOT NULL,
    bank VARCHAR(20) NOT NULL,
    no_rekening VARCHAR(25) NOT NULL,
    PRIMARY KEY (username),
    CONSTRAINT fk_restoran_pengguna
        FOREIGN KEY (username) REFERENCES pengguna(username)
);

CREATE TABLE IF NOT EXISTS promo (
    kode_promo VARCHAR(15) NOT NULL,
    nama_promo VARCHAR(40) NOT NULL,
    deskripsi VARCHAR(100) NOT NULL,
    min_nilai_pesan INT NOT NULL,
    max_nilai_diskon INT NOT NULL,
    kategori VARCHAR(20) NOT NULL,
    kadaluarsa DATE NOT NULL,
    besar_diskon INT NOT NULL,
    PRIMARY KEY (kode_promo)
);

CREATE TABLE IF NOT EXISTS pengiriman (
    no_resi VARCHAR(20) NOT NULL,
    username_driver VARCHAR(20) NOT NULL,
    alamat_tujuan VARCHAR(100) NOT NULL,
    waktu_mulai DATETIME NULL,
    waktu_selesai DATETIME NULL,
    status_pengiriman VARCHAR(20) NOT NULL,
    PRIMARY KEY (no_resi),
    CONSTRAINT fk_pengiriman_driver
        FOREIGN KEY (username_driver) REFERENCES driver(username)
);

CREATE TABLE IF NOT EXISTS pesanan (
    kode_pesanan VARCHAR(20) NOT NULL,
    username_pelanggan VARCHAR(20) NOT NULL,
    kode_promo VARCHAR(15) NULL,
    no_resi VARCHAR(20) NULL,
    waktu_pembuatan DATETIME NOT NULL,
    biaya_pesanan INT NOT NULL,
    biaya_pengiriman INT NOT NULL,
    total_harga INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (kode_pesanan),
    CONSTRAINT fk_pesanan_pelanggan
        FOREIGN KEY (username_pelanggan) REFERENCES pelanggan(username),
    CONSTRAINT fk_pesanan_promo
        FOREIGN KEY (kode_promo) REFERENCES promo(kode_promo),
    CONSTRAINT fk_pesanan_pengiriman
        FOREIGN KEY (no_resi) REFERENCES pengiriman(no_resi)
);

CREATE TABLE IF NOT EXISTS pembayaran (
    kode_pembayaran VARCHAR(20) NOT NULL,
    metode VARCHAR(20) NOT NULL,
    waktu DATETIME NOT NULL,
    kode_pesanan VARCHAR(20) NOT NULL,
    PRIMARY KEY (kode_pembayaran),
    CONSTRAINT fk_pembayaran_pesanan
        FOREIGN KEY (kode_pesanan) REFERENCES pesanan(kode_pesanan)
);

CREATE TABLE IF NOT EXISTS cashless (
    kode_pembayaran VARCHAR(20) NOT NULL,
    rekening_pelanggan VARCHAR(30) NOT NULL,
    metode_digital VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (kode_pembayaran),
    CONSTRAINT fk_cashless_pembayaran
        FOREIGN KEY (kode_pembayaran) REFERENCES pembayaran(kode_pembayaran)
);

CREATE TABLE IF NOT EXISTS tunai (
    kode_pembayaran VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (kode_pembayaran),
    CONSTRAINT fk_tunai_pembayaran
        FOREIGN KEY (kode_pembayaran) REFERENCES pembayaran(kode_pembayaran)
);

CREATE TABLE IF NOT EXISTS menu (
    nama_menu VARCHAR(40) NOT NULL,
    username_restoran VARCHAR(20) NOT NULL,
    harga INT NOT NULL,
    PRIMARY KEY (nama_menu, username_restoran),
    CONSTRAINT fk_menu_restoran
        FOREIGN KEY (username_restoran) REFERENCES restoran(username)
);

CREATE TABLE IF NOT EXISTS varian_menu (
    nama_menu VARCHAR(40) NOT NULL,
    username_restoran VARCHAR(20) NOT NULL,
    variasi VARCHAR(30) NOT NULL,
    PRIMARY KEY (nama_menu, username_restoran, variasi),
    CONSTRAINT fk_varian_menu
        FOREIGN KEY (nama_menu, username_restoran)
        REFERENCES menu(nama_menu, username_restoran)
);

CREATE TABLE IF NOT EXISTS kategori_menu (
    nama_menu VARCHAR(40) NOT NULL,
    username_restoran VARCHAR(20) NOT NULL,
    kategori VARCHAR(20) NOT NULL,
    PRIMARY KEY (nama_menu, username_restoran, kategori),
    CONSTRAINT fk_kategori_menu
        FOREIGN KEY (nama_menu, username_restoran)
        REFERENCES menu(nama_menu, username_restoran)
);

CREATE TABLE IF NOT EXISTS detail_pesanan (
    no_urut INT NOT NULL,
    kode_pesanan VARCHAR(20) NOT NULL,
    nama_menu VARCHAR(40) NOT NULL,
    username_restoran VARCHAR(20) NOT NULL,
    kuantitas INT NOT NULL,
    pesan_pelanggan VARCHAR(100),
    PRIMARY KEY (no_urut, kode_pesanan),
    CONSTRAINT fk_detail_pesanan_pesanan
        FOREIGN KEY (kode_pesanan) REFERENCES pesanan(kode_pesanan),
    CONSTRAINT fk_detail_pesanan_menu
        FOREIGN KEY (nama_menu, username_restoran)
        REFERENCES menu(nama_menu, username_restoran)
);

CREATE TABLE IF NOT EXISTS alamat_pelanggan (
    username_pelanggan VARCHAR(20) NOT NULL,
    alamat VARCHAR(100) NOT NULL,
    PRIMARY KEY (username_pelanggan, alamat),
    CONSTRAINT fk_alamat_pelanggan
        FOREIGN KEY (username_pelanggan) REFERENCES pelanggan(username)
);
