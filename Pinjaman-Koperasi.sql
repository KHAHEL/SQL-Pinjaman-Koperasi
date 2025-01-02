CREATE TABLE anggota (
    no_anggota CHAR(5) CONSTRAINT anggota_noanggota_pk PRIMARY KEY,
    nama VARCHAR2(100) NOT NULL,
    tgl_masuk DATE,
    jenis_kelamin VARCHAR2(10)
);

CREATE SEQUENCE anggota_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

insert into anggota
values (anggota_seq.nextval, 'A', to_date('30 November 2024', 'dd month yyyy'), 'Male');
insert into anggota
values (anggota_seq.nextval, 'B', to_date('30 November 2024', 'dd month yyyy'), 'Male');
insert into anggota
values (anggota_seq.nextval, 'C', to_date('30 November 2024', 'dd month yyyy'), 'Male');

create table simpanan(
  no_simpanan char(5) constraint simpanan_nosimpanan_pk primary key,
  no_anggota char(5),
  jns_simpanan varchar2 (50),
  tgl_simpanan date,
  jumlah number(10,2),
  constraint simpanan_noanggota_fk FOREIGN key (no_anggota) references anggota(no_anggota)
);

CREATE SEQUENCE simpanan_seq
START WITH 10
INCREMENT BY 10
NOCACHE;

insert into simpanan
values (simpanan_seq.nextval, 3, 'wajib', to_date('30 November 2024', 'dd month yyyy') , 1000000);
insert into simpanan
values (simpanan_seq.nextval, 2, 'wajib', to_date('30 November 2024', 'dd month yyyy') , 100000);
insert into simpanan
values (simpanan_seq.nextval, 1, 'wajib', to_date('30 November 2024', 'dd month yyyy') , 10000);

create table pinjaman(
  no_pinjaman char(5) constraint pinjaman_nopinjaman_pk primary key,
  no_anggota char(5),
  tgl_pinjaman date,
  jml_pinjaman number(10,2),
  jangka_waktu_bulan number(2,0),
  constraint pinjaman_noanggota_fk foreign key (no_anggota) references anggota(no_anggota)
);

create sequence pinjaman_seq
start with 100
increment by 1
nocache;

insert into pinjaman 
values (pinjaman_seq.nextval,3, to_date('30 November 2024', 'dd month yyyy'), 100000, 12);
insert into pinjaman 
values (pinjaman_seq.nextval,2, to_date('30 November 2024', 'dd month yyyy'), 100000, 12);
insert into pinjaman 
values (pinjaman_seq.nextval,1, to_date('30 November 2024', 'dd month yyyy'), 10000, 12);

create table pembayaran(
  no_pembayaran char(5) constraint pembayaran_nopembayaran_pk primary key,
  no_pinjaman char(5),
  tgl_pembayaran date,
  jml_pembayaran number(10,2),
  constraint pembayaran_nopinjaman_fk foreign key (no_pinjaman) references pinjaman(no_pinjaman)
);

create sequence pembayaran_seq
start with 100
increment by 1
nocache;

insert into pembayaran
values (pembayaran_seq.nextval,102, to_date('30 November 2024', 'dd month yyyy'), 100000);
insert into pembayaran
values (pembayaran_seq.nextval,101, to_date('30 November 2024', 'dd month yyyy'), 10000);
insert into pembayaran
values (pembayaran_seq.nextval,100, to_date('30 November 2024', 'dd month yyyy'), 1000);

create table pengurus(
  no_pengurus char(5) primary key,
  no_divisi char(5),
  nama varchar2(100) not null,
  jabatan varchar2(50) not null,
  email varchar2(100) not null,
  constraint pengurus_nodivisi_fk foreign key (no_divisi) references divisi_koperasi(no_divisi)
);

create sequence pengurus_seq
start with 1
increment by 1
nocache;

insert into pengurus
values (pengurus_seq.nextval, 3, 'D', 'Ketua', 'jack@gmail.com');
insert into pengurus
values (pengurus_seq.nextval, 1, 'E', 'Bendahara', 'xavier@gmail.com');
insert into pengurus
values (pengurus_seq.nextval, 2, 'F', 'Sekertaris', 'percy@gmail.com');

create table transaksi(
  no_transaksi char(5) constraint transaksi_notransaksi_pk primary key,
  no_anggota char(5),
  jns_transaksi varchar2(50),
  jumlah number(10,2),
  constraint transaksi_noanggota_fk foreign key (no_anggota) references anggota(no_anggota)
);

create sequence transaksi_seq
start with 1
increment by 1
nocache;

insert into transaksi
values (transaksi_seq.nextval, 3, 'Pinjaman', 1000000);
insert into transaksi
values (transaksi_seq.nextval, 2, 'Pinjaman', 100000);
insert into transaksi
values (transaksi_seq.nextval, 1, 'Pinjaman', 10000);


select * from transaksi;

create table riwayat_anggota(
  no_riwayat char(5) constraint riwayatanggota_noriwayat_pk primary key,
  no_anggota char(5),
  status_awal varchar2(9),
  status_akhir varchar2(9),
  tgl_perubahaan date,
  keterangan varchar2(100),
  constraint riwayatanggota_noanggota_fk foreign key (no_anggota) references anggota(no_anggota)
);

create sequence riwayat_anggota_seq
start with 100
increment by 1
nocache;

insert into riwayat_anggota
values (riwayat_anggota_seq.nextval, 1, 'Non Aktif', 'Aktif', to_date('30 November 2024', 'dd month yyyy'), 'Kembali Aktif');
insert into riwayat_anggota
values (riwayat_anggota_seq.nextval, 2, 'Aktif', 'Non Aktif', to_date('30 November 2024', 'dd month yyyy'), 'Diberhentikan Karena Pelanggaran');
insert into riwayat_anggota
values (riwayat_anggota_seq.nextval, 3, 'Aktif', 'Aktif', to_date('30 November 2024', 'dd month yyyy'), 'Masi Aktif');

select * from riwayat_anggota;

create table divisi_koperasi(
  no_divisi char(5) constraint divisikoperasi_nodivisi_pk primary key,
  nama_divisi varchar2(100),
  keterangan varchar2(100)
);

create sequence divisi_koperasi_seq
start with 1
increment by 1
nocache;

insert into divisi_koperasi
values (divisi_koperasi_seq.nextval, 'Keuangan', 'Mengelola Keuangan');
insert into divisi_koperasi
values (divisi_koperasi_seq.nextval, 'Layanan', 'Memberikan Layanan Kepada Anggota');
insert into divisi_koperasi
values (divisi_koperasi_seq.nextval, 'Pemasaran', 'Membuat Strategi Pemasaran');

select * from divisi_koperasi;
