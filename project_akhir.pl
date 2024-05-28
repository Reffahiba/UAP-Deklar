% % Fakta tentang fungsi dari lapisan kulit
% lapisan_kulit(epidermis, 'Barrier permeabilitas').
% lapisan_kulit(epidermis, 'Proteksi dari patogen').
% lapisan_kulit(epidermis, 'Termoregulasi').
% lapisan_kulit(epidermis, 'Sensasi').
% lapisan_kulit(epidermis, 'Proteksi UV').
% lapisan_kulit(epidermis, 'Regenerasi').
% lapisan_kulit(dermis, 'Proteksi dari patogen').
% lapisan_kulit(dermis, 'Sensasi').
% lapisan_kulit(dermis, 'Regenerasi').
% lapisan_kulit(hipodermis, 'Termoregulasi').
% lapisan_kulit(hipodermis, 'Sensasi').

% % Aturan untuk mengidentifikasi fungsi dari lapisan kulit
% fungsi_kulit(Kulit, FungsiKulit) :-
%     lapisan_kulit(Kulit, FungsiKulit).

% % Fakta tentang gejala penyakit kulit
% gejala(gatal).
% gejala(kulit_bersisik).
% gejala(kulit_kering).
% gejala(kulit_menebal).
% gejala(kulit_pecah_pecah).
% gejala(pembengkakan_pada_kulit).
% gejala(timbul_bercak_merah_yang_ditutupi_sisa_kulit_sel_sebelumnya).
% gejala(timbul_bintik_kecil).
% gejala(demam).
% gejala(ruam_menyerupai_cincin).
% gejala(ruam_pada_kulit).
% gejala(bercak_putih).

% % Fakta tentang penyakit kulit
% penyakit(psoriasis) :- 
%     gejala(gatal), 
%     gejala(kulit_bersisik), 
%     gejala(kulit_kering), 
%     gejala(kulit_menebal), 
%     gejala(kulit_pecah_pecah), 
%     gejala(pembengkakan_pada_kulit), 
%     gejala(timbul_bercak_merah_yang_ditutupi_sisa_kulit_sel_sebelumnya), 
%     gejala(timbul_bintik_kecil). 

% penyakit(kurap) :-
%     gejala(kulit_bersisik),
%     gejala(demam),
%     gejala(ruam_menyerupai_cincin),
%     gejala(ruam_pada_kulit).

% penyakit(panu) :-
%     gejala(bercak_putih),
%     gejala(gatal),
%     gejala(kulit_bersisik),
%     gejala(kulit_kering),
%     gejala(kulit_menebal).

% % Predikat untuk meminta gejala dari pengguna
% input_gejala(GejalaList) :-
%     write('Masukkan gejala (ketik "selesai" untuk mengakhiri): '), nl,
%     baca_gejala([], GejalaList).

% baca_gejala(Acc, GejalaList) :-
%     write('Gejala: '),
%     read(Gejala),
%     ( Gejala == selesai ->
%         reverse(Acc, GejalaList)
%     ; 
%         gejala(Gejala) ->
%         baca_gejala([Gejala|Acc], GejalaList)
%     ;
%         write('Gejala tidak dikenal, coba lagi.'), nl,
%         baca_gejala(Acc, GejalaList)
%     ).

% % Predikat untuk memprediksi penyakit berdasarkan gejala
% prediksi_penyakit(GejalaList, Penyakit) :-
%     findall(P, (penyakit(P), cocok(GejalaList, P)), PenyakitList),
%     ( PenyakitList = [] ->
%         Penyakit = 'Tidak ada penyakit yang cocok dengan gejala yang diberikan.'
%     ; 
%         Penyakit = PenyakitList
%     ).

% cocok(GejalaList, Penyakit) :-
%     penyakit(Penyakit),
%     findall(G, gejala(Penyakit, G), GejalaPenyakit),
%     subset(GejalaList, GejalaPenyakit).

% main :-
%     input_gejala(GejalaList),
%     prediksi_penyakit(GejalaList, Penyakit),
%     format('Berdasarkan gejala yang diberikan, kemungkinan penyakit: ~w~n', [Penyakit]).


:- dynamic penyakit/1.
:- dynamic gejala/3.
:- dynamic yes/2.
:- dynamic no/1.

% Daftar penyakit
penyakit("Kurap").
penyakit("Psoriasis").
penyakit("Panu").

% Fakta gejala dengan nilai keyakinan untuk setiap penyakit
gejala("Kurap", "Apakah anda memiliki ruam menyerupai cincin?", 0.6).
gejala("Kurap", "Apakah anda memiliki kulit bersisik?", 0.7).
gejala("Kurap", "Apakah anda mengalami demam?", 0.8).
gejala("Kurap", "Apakah anda memiliki ruam pada kulit?", 0.6).

gejala("Psoriasis", "Apakah anda memiliki ruam merah dan bersisik?", 0.8).
gejala("Psoriasis", "Apakah kulit Anda kering, kemerahan, dan terasa gatal?", 0.7).
gejala("Psoriasis", "Apakah Anda memiliki lesi kulit yang menebal dan berwarna putih keperakan?", 0.6).

gejala("Panu", "Apakah anda memiliki bercak putih di kulit?", 0.7).
gejala("Panu", "Apakah Anda mengalami gatal-gatal pada kulit?", 0.6).
gejala("Panu", "Apakah kulit Anda bersisik dan pecah-pecah?", 0.5).

% Fungsi untuk nilai keyakinan
nilai_keyakinan(0, 0).
nilai_keyakinan(1, 0.25).
nilai_keyakinan(2, 0.5).
nilai_keyakinan(3, 0.75).
nilai_keyakinan(4, 1).

% Fungsi untuk mengajukan pertanyaan
pertanyaan(Penyakit, Pertanyaan, NilaiKeyakinanSistem) :-
    write(Pertanyaan), nl,
    write('Berikan nilai keyakinan (0-1): '), nl,
    read(NilaiKeyakinanPengguna).
    proses_respon(Respon, Penyakit, NilaiKeyakinanSistem).

% Fungsi untuk memproses jawaban pengguna
proses_respon(NilaiKeyakinanPengguna, Penyakit, NilaiKeyakinanSistem) :-
    number(NilaiKeyakinanPengguna),
    NilaiKeyakinanPengguna >= 0, NilaiKeyakinanPengguna =< 1,
    EffectiveConfidence is NilaiKeyakinanPengguna * NilaiKeyakinanSistem,
    asserta(yes(Penyakit, EffectiveConfidence)).
proses_respon(_, Penyakit, NilaiKeyakinanSistem) :-
    write('Jawaban tidak valid. Mohon berikan nilai antara 0 dan 1.'), nl,
    pertanyaan(Penyakit, _, NilaiKeyakinanSistem).

% Fungsi untuk melakukan diagnosa berdasarkan gejala-gejala
diagnosa(Penyakit) :-
    penyakit(Penyakit),
    gejala(Penyakit, Pertanyaan, NilaiKeyakinanSistem),
    pertanyaan(Penyakit, Pertanyaan, NilaiKeyakinanSistem),
    fail.
diagnosa(_).

% Fungsi untuk mencari penyakit berdasarkan gejala yang diberikan
temukan_penyakit :-
    retractall(yes(_, _)),
    retractall(no(_)),
    penyakit(Penyakit),
    diagnosa(Penyakit).

% Fungsi untuk menghitung tingkat keyakinan total untuk setiap penyakit.
hitung_keyakinan(Penyakit, Keyakinan) :-
    findall(C, yes(Penyakit, C), KeyakinanList),
    sum_list(KeyakinanList, Keyakinan).

% Fungsi untuk menampilkan hasil diagnosa
hasil_diagnosa :-
    findall(Penyakit, (yes(Penyakit, _)), PenyakitList),
    list_to_set(PenyakitList, PenyakitUnik),
    cari_penyakit_terbaik(PenyakitUnik, PenyakitTerbaik),
    (   PenyakitTerbaik \= none
    ->  write('Pasien kemungkinan menderita: '), write(PenyakitTerbaik), nl
    ;   write('Maaf, saya tidak dapat membuat diagnosis.'), nl
    ),
    retractall(yes(_, _)), % Hapus semua fakta "ya"
    retractall(no(_)). % Hapus fakta "tidak"

% Fungsi untuk menemukan penyakit dengan tingkat keyakinan tertinggi
cari_penyakit_terbaik([Penyakit], Penyakit) :- !.
cari_penyakit_terbaik([Penyakit|Rest], PenyakitTerbaik) :-
    hitung_keyakinan(Penyakit, Keyakinan),
    cari_penyakit_terbaik(Rest, PenyakitSaatIniTerbaik),
    (   PenyakitSaatIniTerbaik \= none,
        hitung_keyakinan(PenyakitSaatIniTerbaik, KeyakinanTerbaik),
        Keyakinan =< KeyakinanTerbaik
    ->  PenyakitTerbaik = PenyakitSaatIniTerbaik
    ;   PenyakitTerbaik = Penyakit
    ).
cari_penyakit_terbaik([], none).

% Contoh penggunaan
:- temukan_penyakit, hasil_diagnosa.





% penyakit(psoriasis) :- 
%     gejala(gatal), 
%     gejala(kulit_bersisik), 
%     gejala(kulit_kering), 
%     gejala(kulit_menebal), 
%     gejala(kulit_pecah_pecah), 
%     gejala(pembengkakan_pada_kulit), 
%     gejala(timbul_bercak_merah_yang_ditutupi_sisa_kulit_sel_sebelumnya), 
%     gejala(timbul_bintik_kecil). 

% penyakit(kurap) :-
%     gejala(kulit_bersisik),
%     gejala(demam),
%     gejala(ruam_menyerupai_cincin),
%     gejala(ruam_pada_kulit).

% penyakit(panu) :-
%     gejala(bercak_putih),
%     gejala(gatal),
%     gejala(kulit_bersisik),
%     gejala(kulit_kering),
%     gejala(kulit_menebal).