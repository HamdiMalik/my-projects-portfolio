package com.holtihealth.app.helper

import com.holtihealth.app.R
import com.holtihealth.app.database.Article
import com.holtihealth.app.database.Disease

object InitialDataSource {
    fun getArticles(): List<Article> {
        return listOf(
            Article(
                title = "Penyakit Antraknosa pada Cabai",
                image = R.drawable.penyakit_antraknosa,
                description = """
            Penyakit antraknos adalah salah satu penyakit yang paling merugikan pada tanaman cabai. Penyakit ini disebabkan oleh jamur dari genus Colletotrichum, yang dapat menyerang berbagai bagian tanaman, seperti buah, daun, dan batang. Antraknos dikenal karena kerusakannya yang signifikan, terutama pada buah cabai yang siap panen, sehingga dapat menyebabkan kerugian ekonomi yang besar bagi petani.
             
            Penyebab dan Penyebaran
             
            Penyakit antraknos disebabkan oleh beberapa spesies jamur Colletotrichum, seperti Colletotrichum capsici dan Colletotrichum gloeosporioides. 
            
            Jamur ini menyebar melalui:
             
            * Air hujan: Percikan air yang membawa spora jamur ke bagian tanaman yang sehat.
            * Angin: Spora jamur dapat terbawa angin dan menginfeksi tanaman di sekitarnya.
            * Alat pertanian: Alat yang terkontaminasi dapat menjadi media penyebaran.
            * Buah atau tanaman terinfeksi: Buah yang terinfeksi bisa menjadi sumber spora jamur.
            * Jamur ini cenderung berkembang biak di lingkungan yang lembap dan suhu hangat (23–30°C), kondisi yang sering ditemui di daerah tropis seperti Indonesia.
             
            Gejala Antraknos
             
            Gejala antraknos pada cabai meliputi:
             
            1.Buah Cabai:
             
            * Muncul bercak-bercak cekung berwarna coklat tua hingga hitam.
            * Bercak tersebut sering kali berbentuk melingkar dengan konsentrasi spora jamur di tengahnya, yang tampak seperti lingkaran kecil-kecil.
            * Buah yang terinfeksi parah akan membusuk dan akhirnya rontok.
            
            2.Batang dan Daun:
             
            * Bercak hitam atau coklat dapat muncul pada daun dan batang, meskipun lebih jarang dibandingkan buah.
            * Bagian yang terinfeksi dapat mengering dan mati.
                
            Dampak Ekonomi
            
            Penyakit antraknos dapat menyebabkan kehilangan hasil panen hingga 50–90% jika tidak ditangani dengan baik. Buah yang terinfeksi tidak layak jual, baik untuk konsumsi lokal maupun ekspor. Selain itu, penyebaran penyakit ini dapat menurunkan kualitas tanaman secara keseluruhan.
            Pengendalian dan Pencegahan
           
            Berikut langkah-langkah pengendalian dan pencegahan penyakit antraknos:

            1.Pengelolaan Kultur Teknis:
            
            * Gunakan benih yang sehat dan bebas penyakit.
            * Terapkan rotasi tanaman dengan jenis tanaman non-solanaceae (keluarga cabai) untuk memutus siklus hidup jamur.
            * Hindari menanam cabai terlalu rapat untuk meningkatkan sirkulasi udara.
          
            2.Sanitasi Kebun:
            
            * Buang dan musnahkan buah atau tanaman yang terinfeksi.
            * Bersihkan gulma dan sisa tanaman yang dapat menjadi inang jamur.
           
            3.Penggunaan Fungisida:
            
            * Aplikasi fungisida berbahan aktif seperti mankozeb, klorotalonil, atau tembaga hidroksida dapat membantu mengendalikan jamur.
            * Penyemprotan dilakukan sesuai jadwal dan anjuran dosis pada kemasan.
           
            4.Varietas Tahan Penyakit:
            
            * Pilih varietas cabai yang memiliki ketahanan alami terhadap penyakit antraknos.
           
            5.Pengelolaan Lingkungan:
            
            * Jaga kelembapan kebun dengan mengatur irigasi, terutama saat musim hujan.
            * Hindari penyiraman overhead yang dapat memicu penyebaran spora melalui percikan air.
            
            Penyakit antraknos merupakan ancaman serius bagi produksi cabai di Indonesia. Pengendalian yang efektif memerlukan kombinasi metode pencegahan, pengelolaan lingkungan, dan penggunaan fungisida yang tepat. Dengan pengelolaan yang baik, dampak antraknos dapat diminimalkan, sehingga petani dapat meningkatkan hasil panen dan kualitas cabai yang dihasilkan.

            Jika Anda seorang petani atau penggiat agribisnis cabai, penting untuk selalu memantau tanaman Anda dan mengambil tindakan pencegahan sejak dini untuk mencegah kerugian akibat antraknos. 
          
        """.trimIndent(),


                ),
            Article(
                title = "Penyakit Layu Fusarium pada Cabai",
                image = R.drawable.layu,
                description = """
           Penyakit layu fusarium adalah salah satu penyakit serius yang menyerang tanaman cabai. Penyakit ini disebabkan oleh jamur Fusarium oxysporum f.sp. capsici, yang menyerang sistem perakaran tanaman. Layu fusarium menyebabkan tanaman cabai layu mendadak, daun menguning, dan akhirnya mati. Penyakit ini sulit diatasi jika sudah menyerang, sehingga pencegahan dan pengelolaan yang baik menjadi kunci utama.
           
           Penyebab dan Cara Penyebaran
           
           Jamur Fusarium oxysporum hidup di tanah dan dapat bertahan lama, bahkan tanpa inang. Penyakit ini menyebar melalui:

           1. Tanah Terinfeksi: Jamur ini berkembang di tanah yang terkontaminasi dan menyerang melalui akar.
           2. Air Irigasi: Penyiraman menggunakan air yang tercemar spora fusarium dapat memperluas penyebaran.
           3. Alat Pertanian: Peralatan yang terkontaminasi jamur dapat menjadi sarana penyebaran.
           4. Benih yang Tidak Bersih: Benih yang terkontaminasi jamur dapat menjadi sumber infeksi awal.
           
           Lingkungan yang lembap dan suhu hangat (24–30°C) mendukung perkembangan jamur ini. Tanaman yang kekurangan nutrisi atau stres juga lebih rentan terhadap serangan layu fusarium.
           
           Gejala Penyakit Layu Fusarium
           
           Gejala penyakit ini dapat diamati pada berbagai bagian tanaman cabai:

           1. Gejala pada Daun:
           
            * Daun bagian bawah menguning dan layu secara bertahap.
            * Daun yang terinfeksi akhirnya rontok.
           
           2.Gejala pada Batang:

            * Batang tampak coklat kehitaman jika dibelah, akibat infeksi pembuluh pengangkut.
            * Aliran nutrisi terhambat, menyebabkan layu.
           
           3. Gejala pada Tanaman Secara Umum:

            * Tanaman layu, meskipun tanah tampak cukup lembap.
            * Tanaman mati secara perlahan atau mendadak, tergantung tingkat infeksi.
            
           Dampak pada Produksi Cabai
            
            Penyakit layu fusarium dapat menyebabkan kehilangan hasil panen yang signifikan, terutama jika menyerang tanaman muda. Infeksi pada fase generatif (berbunga atau berbuah) dapat menyebabkan tanaman mati sebelum menghasilkan buah yang layak panen.
           
           Pengendalian dan Pencegahan
           
           1.Pengelolaan Kultur Teknis:

            * Gunakan benih yang bersertifikat bebas penyakit.
            * Terapkan rotasi tanaman dengan tanaman yang tidak rentan terhadap fusarium, seperti jagung atau kacang-kacangan.
            * Jangan menanam cabai di tanah yang memiliki riwayat infeksi fusarium.
           
           2.Sanitasi dan Karantina:

            * Singkirkan dan musnahkan tanaman yang terinfeksi untuk mencegah penyebaran.
            * Bersihkan alat pertanian dengan desinfektan sebelum digunakan di area lain.
           
           3.Penggunaan Agen Hayati:

            * Aplikasi jamur antagonis seperti Trichoderma spp. dapat menekan perkembangan Fusarium oxysporum.
            * Gunakan pupuk organik yang telah terfermentasi untuk meningkatkan mikroorganisme baik di tanah.
           
           4.Pemilihan Varietas Tahan:

            *Pilih varietas cabai yang memiliki ketahanan alami terhadap layu fusarium.
           
           5.Penggunaan Fungisida:

            * Fungisida sistemik berbahan aktif seperti karbendazim atau benomil dapat digunakan untuk mengendalikan penyakit ini.
            * Penyemprotan harus dilakukan dengan tepat, sesuai dosis yang dianjurkan.
          
           Pengelolaan Tanah:

            * Tingkatkan drainase tanah untuk mencegah genangan air.
            * Lakukan pengapuran untuk menurunkan tingkat keasaman tanah (pH optimal sekitar 6–7).
           
           
           Penyakit layu fusarium merupakan ancaman besar bagi budidaya cabai, terutama di lahan yang sebelumnya terinfeksi. Pengelolaan terpadu yang mencakup pencegahan, sanitasi, dan penggunaan teknologi hayati sangat penting untuk mengurangi dampaknya.

           Dengan menerapkan langkah-langkah di atas, petani dapat menjaga produktivitas tanaman cabai dan meminimalkan kerugian akibat penyakit layu fusarium. Mari budidayakan cabai secara berkelanjutan dengan pengelolaan yang baik!
        """.trimIndent(),

                ),
            Article(
                title = "Penyakit Bercak Daun Cabai",
                image = R.drawable.bercak,
                description = """
            Penyakit bercak daun pada cabai adalah salah satu masalah utama yang dapat mengurangi produktivitas tanaman. Penyakit ini disebabkan oleh infeksi jamur atau bakteri yang menyerang daun cabai, sehingga menghambat proses fotosintesis dan pertumbuhan tanaman. Jika tidak ditangani dengan baik, bercak daun dapat menyebabkan kerontokan daun dan penurunan hasil panen.
            
            Penyebab dan Cara Penyebaran
            
            Penyakit bercak daun pada cabai dapat disebabkan oleh berbagai patogen, di antaranya:

            1. Jamur:
            
                * Cercospora capsici (penyebab bercak daun cercospora).
                * Alternaria solani (penyebab bercak daun alternaria).
                
            2. Bakteri:
            
                * Xanthomonas campestris pv. vesicatoria (penyebab bercak bakteri).
            
            Patogen ini menyebar melalui:

                * Percikan air hujan: Membawa spora jamur atau bakteri dari daun yang terinfeksi ke daun sehat.
                * Angin: Spora jamur dapat terbawa angin ke tanaman lain.
                * Tanah atau Seresah Tanaman: Sisa-sisa tanaman yang terinfeksi menjadi sumber inokulum untuk infeksi berikutnya.
                * Alat Pertanian: Alat yang tidak dibersihkan dapat menyebarkan patogen.
                
            Lingkungan dengan kelembapan tinggi, suhu hangat (20–30°C), dan ventilasi udara buruk mendukung perkembangan penyakit bercak daun.
            
            Gejala Penyakit Bercak Daun
            
            Gejala bercak daun pada cabai bervariasi tergantung patogen penyebabnya, 
            
            tetapi beberapa ciri umum meliputi:

            1. Bercak Jamur (Cercospora atau Alternaria):

                * Muncul bercak bulat kecil berwarna coklat hingga kehitaman, sering kali dikelilingi oleh lingkaran kuning.
                * Bercak dapat membesar dan menyatu, menyebabkan daun mengering.
                
            2. Bercak Bakteri (Xanthomonas):

                * Bercak kecil berwarna coklat gelap hingga hitam, sering dikelilingi oleh halo berwarna kuning pucat.
                * Infeksi berat menyebabkan daun menggulung, layu, dan rontok.
            
            3. Kerontokan Daun:

                * Tanaman yang terinfeksi berat mengalami kerontokan daun yang signifikan, sehingga pertumbuhan buah terganggu.
            
            Dampak pada Produksi
            
            Penyakit bercak daun dapat menurunkan produktivitas cabai hingga 30–50%. Tanaman dengan daun yang rusak tidak mampu berfotosintesis secara optimal, mengurangi jumlah dan kualitas buah yang dihasilkan.
            
            Pengendalian dan Pencegahan
            
            1. Pengelolaan Kultur Teknis:

                * Gunakan benih yang sehat dan tahan penyakit.
                * Tanam dengan jarak yang cukup untuk meningkatkan sirkulasi udara.
                * Terapkan rotasi tanaman untuk mencegah akumulasi patogen di tanah.
            
            2. Sanitasi Kebun:

                * Singkirkan daun atau tanaman yang terinfeksi dari kebun untuk mengurangi sumber inokulum.
                * Bersihkan gulma yang dapat menjadi inang alternatif patogen.
            
            3.Penggunaan Fungisida atau Bakterisida:

                * Untuk jamur, gunakan fungisida berbahan aktif seperti mankozeb, klorotalonil, atau difenokonazol.
                * Untuk bakteri, gunakan bakterisida berbahan aktif tembaga oksiklorida atau tembaga hidroksida.
                * Penyemprotan harus dilakukan secara preventif atau segera setelah gejala awal muncul.
            
            4. Pemanfaatan Agen Hayati:

                * Gunakan jamur antagonis seperti Trichoderma spp. atau bakteri Pseudomonas fluorescens untuk menekan perkembangan patogen.
            
            5. Pengelolaan Lingkungan:

                * Hindari penyiraman overhead yang dapat memercikkan patogen ke daun.
                * Kurangi kelembapan dengan menjaga drainase yang baik dan memotong cabang yang terlalu rimbun.
            
            Penyakit bercak daun adalah tantangan serius bagi petani cabai, tetapi dapat dikelola dengan baik melalui pencegahan, pengelolaan kultur teknis, dan penggunaan agen kimia atau hayati. Langkah-langkah pengendalian yang terintegrasi akan memastikan tanaman tetap sehat, produktivitas terjaga, dan hasil panen berkualitas tinggi.

            Dengan perhatian yang tepat, petani dapat mengatasi penyakit ini dan meningkatkan keberlanjutan budidaya cabai. 
        """.trimIndent()

            ),
            Article(
                title = "Penyakit Busuk Buah Antraknosa ",
                image = R.drawable.busuk_buah,
                description = """
           Busuk buah antraknosa adalah salah satu penyakit paling merugikan pada cabai yang menyebabkan buah membusuk, baik saat masih di tanaman maupun setelah dipanen. Penyakit ini disebabkan oleh infeksi jamur Colletotrichum spp., terutama Colletotrichum capsici dan Colletotrichum gloeosporioides. Penyakit ini tidak hanya menurunkan kualitas dan kuantitas hasil panen tetapi juga berdampak langsung pada nilai ekonomi cabai, baik untuk konsumsi lokal maupun ekspor.
           
           Penyebab dan Penyebaran
           
           Busuk buah antraknosa disebabkan oleh jamur Colletotrichum, yang memiliki siklus hidup panjang dan mampu bertahan pada sisa-sisa tanaman yang terinfeksi. 
           
           Jamur ini menyebar melalui:

            * Percikan Air: Air hujan atau penyiraman overhead dapat membawa spora jamur ke buah sehat.
            * Angin: Spora jamur dapat terbawa angin dan menyebar ke tanaman lain.
            * Serangga dan Kontak Langsung: Luka akibat serangga atau kerusakan mekanis memudahkan infeksi jamur.
            * Alat Pertanian dan Pemanenan: Peralatan yang terkontaminasi dapat menyebarkan patogen.
            * Jamur ini tumbuh subur dalam kondisi lembap dan hangat, dengan suhu optimal 25–30°C, sehingga penyakit sering muncul saat musim hujan atau di daerah dengan kelembapan tinggi.
            
           Gejala Busuk Buah Antraknosa
           
           Gejala utama busuk buah antraknosa pada cabai meliputi:

           1. Bercak Coklat atau Hitam:

            * Pada buah cabai, muncul bercak cekung berbentuk bulat atau tidak teratur.
            * Bercak ini berwarna coklat gelap hingga hitam, dan semakin membesar seiring waktu.
           
           2. Pusat Bercak dengan Lingkaran Konsentris:

            * Di tengah bercak, terdapat lingkaran konsentris berisi massa spora jamur yang tampak seperti bubuk oranye atau merah muda.
           
           3. Buah Membusuk:

            * Bagian yang terinfeksi menjadi lunak dan akhirnya seluruh buah membusuk.
            * Buah yang terinfeksi sering kali rontok sebelum matang.
           
           4. Infeksi pada Daerah Pasca Panen:

            * Gejala juga dapat muncul setelah panen, terutama jika buah tidak disimpan dengan benar.
           
           Dampak pada Produksi Cabai
           
           Busuk buah antraknosa dapat menyebabkan kerugian hasil hingga 50–90% jika tidak dikendalikan dengan baik. Buah yang terinfeksi tidak dapat dijual atau dikonsumsi, sehingga menurunkan pendapatan petani. Selain itu, penyakit ini mempercepat kerusakan selama penyimpanan dan transportasi, terutama untuk pasar ekspor.
           
           Pengendalian dan Pencegahan
           
           1. Pengelolaan Kultur Teknis:

            * Gunakan benih bebas penyakit atau yang telah diolah dengan fungisida.
            * Terapkan rotasi tanaman dengan jenis tanaman non-solanaceae untuk memutus siklus hidup jamur.
            * Hindari penanaman terlalu rapat untuk meningkatkan sirkulasi udara.
           
           2.Sanitasi Kebun:

            * Buang dan musnahkan buah atau tanaman yang terinfeksi.
            * Bersihkan gulma dan sisa tanaman yang dapat menjadi tempat bertahan hidup jamur.
           
           3. Penggunaan Fungisida:

            * Aplikasi fungisida berbahan aktif seperti mankozeb, klorotalonil, azoksistrobin, atau difenokonazol.
            * Fungisida harus diaplikasikan secara berkala, terutama pada musim hujan atau saat gejala awal muncul.
           
           4. Peningkatan Ketahanan Tanaman:

            * Pilih varietas cabai yang memiliki ketahanan terhadap penyakit antraknosa.
           
           5. Penggunaan Agen Hayati:

            * Aplikasi jamur antagonis seperti Trichoderma spp. dapat membantu menekan perkembangan Colletotrichum.
            * Pupuk organik yang terfermentasi juga dapat meningkatkan mikroorganisme baik di tanah.
           
           6. Penyimpanan dan Penanganan Pasca Panen:

            * Simpan buah cabai di tempat yang kering dengan sirkulasi udara baik.
            * Hindari menyimpan buah dengan luka atau yang telah terkontaminasi.
            
            Busuk buah antraknosa adalah ancaman serius bagi budidaya cabai, terutama di daerah dengan kelembapan tinggi. Pengendalian yang efektif memerlukan kombinasi langkah pencegahan, pengelolaan lingkungan, dan penggunaan fungisida. Sanitasi kebun, rotasi tanaman, dan penggunaan benih tahan penyakit dapat membantu mengurangi risiko infeksi.

            Dengan manajemen yang tepat, petani dapat meminimalkan dampak busuk buah antraknosa dan memastikan hasil panen yang lebih berkualitas serta menguntungkan.
            
        """.trimIndent()
            ),
            Article(
                title = "Penyakit kutu daun ",
                image = R.drawable.kutu_daun,
                description = """
           Kutu daun adalah salah satu hama utama yang sering menyerang tanaman cabai. Hama ini dapat menyebabkan kerusakan langsung pada tanaman serta menjadi vektor berbagai penyakit virus. Kutu daun menyerang dengan cara mengisap cairan dari daun, batang, dan bunga, sehingga menghambat pertumbuhan tanaman. Serangan kutu daun yang tidak terkendali dapat mengurangi hasil panen cabai secara signifikan.

           Penyebab dan Karakteristik Kutu Daun
           
           Kutu daun pada cabai biasanya berasal dari jenis Aphis gossypii atau Myzus persicae. 
           
           Hama ini memiliki beberapa ciri utama:

            * Ukuran kecil (1–3 mm) dan tubuh lunak.
            * Warna bervariasi, mulai dari hijau, kuning, hingga hitam tergantung spesiesnya.
            * Hidup berkoloni, terutama di bagian bawah daun atau pada tunas muda.
            * Mampu berkembang biak dengan cepat, terutama dalam kondisi hangat dan lembap.
           
           Cara Penyebaran:

            * Kutu daun berpindah dari satu tanaman ke tanaman lain dengan bantuan angin atau serangga lain.
            * Tanaman inang alternatif seperti gulma di sekitar kebun menjadi tempat persembunyian dan sumber infeksi.
           
           Dampak Serangan Kutu Daun pada Cabai
           
            * Kutu daun memberikan dampak langsung maupun tidak langsung terhadap tanaman cabai:

           1.Dampak Langsung:

            * Daun yang diserang menggulung, menguning, atau mengalami deformasi.
            * Pertumbuhan tanaman terganggu karena kehilangan nutrisi akibat cairan yang diisap.
            * Koloni besar menyebabkan tunas dan bunga rontok, mengurangi pembentukan buah.
           
           2. Dampak Tidak Langsung:

            * Kutu daun menjadi vektor virus tanaman seperti Potato Virus Y (PVY) dan Cucumber Mosaic Virus (CMV), yang menyebabkan kerusakan lebih parah.
            * Menghasilkan embun madu (honeydew), yang memicu pertumbuhan jamur jelaga (sooty mold), sehingga mengurangi kemampuan daun untuk berfotosintesis.
           
           Pengendalian dan Pencegahan Kutu Daun pada Cabai
           
           1. Pengendalian Secara Kultur Teknis:

            * Sanitasi Lahan: Bersihkan gulma dan sisa tanaman yang dapat menjadi tempat berkembang biak kutu daun.
            * Pengaturan Jarak Tanam: Tanam cabai dengan jarak yang cukup untuk meningkatkan sirkulasi udara dan mengurangi kelembapan.
            * Rotasi Tanaman: Hindari menanam cabai berulang kali di lahan yang sama tanpa rotasi dengan tanaman non-solanaceae.
           
           2. Pengendalian Secara Mekanis:

            * Gunakan semprotan air dengan tekanan tinggi untuk mengurangi populasi kutu daun di daun dan batang.
            * Perangkap kuning lengket dapat digunakan untuk menarik dan menangkap kutu daun.
           
           3. Pengendalian Hayati:

            * Manfaatkan musuh alami seperti kumbang Coccinellidae (kumbang kepik) dan lalat predator Syrphidae yang memakan kutu daun.
            * Aplikasi jamur entomopatogen seperti Beauveria bassiana atau Verticillium lecanii dapat membantu mengurangi populasi kutu daun secara alami.
           
           4. Pengendalian Kimiawi:

            * Gunakan insektisida berbahan aktif seperti imidakloprid, abamektin, atau dimetoat untuk mengendalikan kutu daun.
            * Hindari penggunaan insektisida secara berlebihan untuk mencegah resistensi.
           
           5.Pemanfaatan Pestisida Nabati:

            * Ekstrak daun mimba, serai, atau bawang putih dapat digunakan sebagai pestisida alami untuk mengusir kutu daun.
            * Semprotan air sabun ringan juga efektif untuk melumpuhkan kutu daun.
           
           Kutu daun adalah hama yang sering menyerang tanaman cabai dan dapat menyebabkan kerugian besar jika tidak segera ditangani. Kombinasi pengendalian secara kultur teknis, mekanis, hayati, dan kimiawi sangat efektif untuk menjaga populasi kutu daun tetap terkendali.

           Dengan penerapan pengelolaan hama terpadu, petani dapat melindungi tanaman cabai dari serangan kutu daun dan memastikan hasil panen yang optimal.
        """.trimIndent()
            ),
            Article(
                title = "Penyakit Trips Dan Tungau ",
                image = R.drawable.tungau,
                description = """
           Trips dan tungau adalah dua hama utama yang menyerang tanaman cabai. Kedua hama ini menyerang bagian daun, bunga, dan buah dengan cara mengisap cairan sel tanaman. Serangan yang parah tidak hanya menyebabkan kerusakan fisik pada tanaman, tetapi juga menurunkan hasil panen secara signifikan. Trips juga dapat menjadi vektor penyakit virus yang berbahaya bagi cabai.
           
           Hama Trips pada Cabai
           
           Karakteristik Trips
           
           Trips adalah serangga kecil berukuran 0,5–1,5 mm dengan tubuh ramping berwarna kuning, coklat, atau hitam. Trips memiliki sayap sempit dengan bulu halus, dan mereka bergerak cepat di permukaan tanaman. Spesies trips yang umum menyerang cabai adalah Thrips parvispinus dan Frankliniella occidentalis.

           Gejala Serangan Trips
           
           1. Bercak Perak pada Daun:

            * Trips mengisap cairan dari jaringan daun, menyebabkan munculnya bercak keperakan.
            * Daun yang terinfeksi berat akan mengering dan akhirnya rontok.
           
           2. Kerusakan pada Bunga:

            * Bunga yang terserang trips sering kali tidak berkembang dengan sempurna, sehingga gagal menjadi buah.
           
           3. Infeksi Virus:

            * Trips adalah vektor virus Tospovirus, seperti virus bercak layu cabai (Chilli Veinal Mottle Virus), yang menyebabkan gejala bercak kuning, daun keriting, dan buah cacat.
           
           Dampak Serangan Trips
           
           Serangan trips dapat mengurangi produktivitas hingga 30–50%, terutama jika menyerang pada fase pembungaan dan pembuahan.
           
           Hama Tungau pada Cabai
          
           Karakteristik Tungau
          
           Tungau adalah hama kecil berukuran kurang dari 1 mm dengan tubuh berbentuk oval. Tungau yang umum menyerang cabai adalah Tetranychus urticae (tungau merah) dan Polyphagotarsonemus latus (tungau kuning). Tungau berkembang biak dengan cepat dalam kondisi kering dan panas.

           Gejala Serangan Tungau
           
           1. Bercak Kuning pada Daun:

            * Tungau merah mengisap cairan dari daun, menyebabkan munculnya bercak kuning atau putih.
            * Daun yang terserang berat akan menggulung, mengering, dan rontok.
           
           2. Daun Mengkerut dan Tepi Menggulung:

            * Tungau kuning menyebabkan daun muda mengkerut, menggulung, dan menjadi rapuh.
           
           3. Jaring Halus:

            * Tungau merah sering meninggalkan jaring halus di bawah permukaan daun yang terinfeksi.
           
           Dampak Serangan Tungau
           
           Serangan tungau dapat menghambat fotosintesis tanaman, mengurangi pertumbuhan, dan pada kasus yang parah, menyebabkan tanaman mati.
           
           Pengendalian Trips dan Tungau pada Cabai
           
           1. Pengelolaan Kultur Teknis

            * Tanam cabai dengan jarak yang cukup untuk meningkatkan sirkulasi udara.
            * Singkirkan gulma dan sisa tanaman yang dapat menjadi tempat berkembang biak trips dan tungau.
            * Terapkan rotasi tanaman untuk mengurangi populasi hama.
           
           2. Pengendalian Mekanis

            * Gunakan perangkap lem kuning untuk mengurangi populasi trips.
            * Semprot tanaman dengan air untuk membersihkan trips dan tungau secara fisik, terutama pada bagian bawah daun.
           
           3. Pengendalian Hayati

            * Gunakan musuh alami seperti kumbang predator Orius spp. untuk mengendalikan trips.
            * Aplikasi jamur entomopatogen seperti Beauveria bassiana atau Metarhizium anisopliae dapat menekan populasi trips dan tungau.
           
           4.Pengendalian Kimiawi

            * Gunakan insektisida untuk trips seperti abamektin, spinosad, atau imidakloprid.
            * Gunakan akarisida seperti propargit atau bifenazat untuk mengendalikan tungau.
            * Rotasi bahan aktif insektisida atau akarisida untuk mencegah resistensi.
           
           Pengendalian Nabati

            * Ekstrak daun mimba atau serai dapat digunakan sebagai semprotan nabati untuk trips dan tungau.
           
           Trips dan tungau adalah hama yang merusak produktivitas tanaman cabai, tetapi dapat dikendalikan dengan pendekatan terpadu. Kombinasi pengelolaan lingkungan, penggunaan musuh alami, dan aplikasi insektisida atau akarisida yang tepat akan membantu menjaga tanaman tetap sehat.
           
           Dengan langkah pengendalian yang tepat, petani dapat meminimalkan kerugian akibat serangan trips dan tungau serta memastikan hasil panen cabai yang berkualitas.  
        """.trimIndent()
            ),
            Article(
                title = "Penyakit Virus Kuning ",
                image = R.drawable.virus_kuning,
                description = """
           Virus kuning atau dikenal juga sebagai penyakit kuning pada cabai merupakan salah satu ancaman serius dalam budidaya cabai. Penyakit ini disebabkan oleh infeksi virus seperti Tomato Yellow Leaf Curl Virus (TYLCV) dan Chilli Veinal Mottle Virus (ChiVMV), yang ditularkan oleh serangga vektor seperti kutu kebul (Bemisia tabaci) dan kutu daun (Aphis gossypii). Penyakit ini mengakibatkan perubahan warna daun, pertumbuhan terhambat, dan penurunan hasil panen secara drastis.
           
           Penyebab dan Penularan Virus Kuning
           
           Penyakit kuning pada cabai disebabkan oleh virus yang masuk ke dalam jaringan tanaman melalui luka kecil yang dibuat oleh serangga vektor.

           Penyebab Utama:

            * Tomato Yellow Leaf Curl Virus (TYLCV)
            * Chilli Veinal Mottle Virus (ChiVMV)
           
           Vektor Penyebar Virus:

            * Kutu Kebul (Bemisia tabaci): Serangga kecil ini merupakan vektor utama TYLCV.
            * Kutu Daun (Aphis gossypii): Menularkan virus ChiVMV dan beberapa virus lainnya.
           
           Faktor Pendukung Penyebaran:

            * Kelembapan tinggi dan suhu hangat.
            * Keberadaan gulma di sekitar kebun yang menjadi inang alternatif virus.
            * Penanaman cabai secara terus-menerus tanpa rotasi tanaman.
           
           Gejala Virus Kuning pada Cabai
           
           1.Daun Menguning dan Menggulung:

            * Daun muda menunjukkan warna kuning terang yang tidak merata.
            * Daun menggulung ke atas, terutama pada tanaman yang masih muda.
           
           2. Pertumbuhan Tanaman Terhambat:

            * Tanaman yang terinfeksi tampak kerdil dan tidak tumbuh dengan baik.
            * Batang dan cabang menjadi lemah.
           
           3. Produksi Buah Menurun:

            * Bunga gugur sebelum terbentuk buah.
            * Buah yang dihasilkan kecil dan cacat.
           
           4. Penyebaran Cepat:

            * Infeksi dapat menyebar dengan cepat melalui serangga vektor, terutama pada musim hujan atau di daerah dengan populasi serangga tinggi.
           
           Dampak Virus Kuning pada Cabai
           
           Infeksi virus kuning dapat menurunkan hasil panen hingga 50–80%, terutama jika infeksi terjadi pada fase pertumbuhan awal. Selain itu, buah yang dihasilkan sering kali tidak layak jual, sehingga berdampak pada pendapatan petani.
           
           Pengendalian Virus Kuning pada Cabai
           
           1. Pencegahan Serangan Vektor

            * Gunakan perangkap kuning lengket untuk mengurangi populasi kutu kebul dan kutu daun.
            * Terapkan mulsa plastik perak untuk mengurangi keberadaan serangga di sekitar tanaman.
           
           2. Pengelolaan Kultur Teknis

            * Tanam varietas cabai yang tahan virus kuning jika tersedia.
            * Jaga kebersihan lahan dengan membuang gulma dan tanaman yang terinfeksi.
            * Terapkan rotasi tanaman dengan jenis yang tidak rentan terhadap virus seperti jagung atau kacang-kacangan.
           
           3. Penggunaan Agen Hayati

            * Manfaatkan musuh alami seperti kumbang kepik (Coccinellidae) dan laba-laba predator untuk mengendalikan populasi kutu daun dan kutu kebul.
            * Aplikasi jamur entomopatogen seperti Beauveria bassiana untuk menekan serangga vektor.
           
           4. Pengendalian Kimiawi

            * Gunakan insektisida berbahan aktif seperti abamektin, imidakloprid, atau tiametoksam untuk mengendalikan serangga vektor.
            * Penyemprotan insektisida harus dilakukan secara hati-hati untuk mencegah resistensi.
           
           5.Penyemprotan Nabati

            * Gunakan ekstrak daun mimba, serai, atau bawang putih sebagai insektisida alami.
           
           6. Sanitasi Lahan dan Tanaman

            * Segera cabut dan musnahkan tanaman yang menunjukkan gejala virus kuning untuk mencegah penyebaran.
            * Bersihkan peralatan pertanian untuk menghindari kontaminasi.
           
           Virus kuning pada cabai adalah penyakit yang sangat merugikan, terutama di lahan dengan populasi serangga vektor yang tinggi. Pencegahan dan pengendalian yang efektif memerlukan kombinasi pengelolaan hama terpadu, sanitasi kebun, dan penggunaan insektisida atau agen hayati.

           Dengan strategi pengendalian yang tepat, petani dapat melindungi tanaman cabai dari virus kuning dan memastikan hasil panen yang optimal. 
        """.trimIndent()
            ),
            Article(
                title = "Hama Ulat Tanah ",
                image = R.drawable.ulat_tanah,
                description = """
           Ulat tanah merupakan salah satu hama penting yang menyerang tanaman cabai, terutama pada fase pembibitan dan awal pertumbuhan. Hama ini sering menyerang bagian pangkal batang hingga menyebabkan tanaman roboh dan mati. Jenis ulat tanah yang paling umum ditemukan adalah Agrotis ipsilon (ulat grayak tanah).
           
           Karakteristik Ulat Tanah
           
            * Ulat tanah adalah larva dari ngengat yang berwarna cokelat hingga hitam dengan tubuh tebal dan licin.
            * Larva ini biasanya aktif pada malam hari, sementara di siang hari bersembunyi di dalam tanah atau di bawah sisa tanaman.
            * Serangan ulat tanah lebih sering terjadi pada musim penghujan, saat kelembapan tanah tinggi.
           
           Gejala Serangan Ulat Tanah pada Cabai
           
           1. Pemotongan Pangkal Batang

            * Tanaman muda tiba-tiba layu dan roboh karena pangkal batang digigit oleh ulat tanah.
            * Pada inspeksi lebih dekat, pangkal batang terlihat terpotong bersih atau terkoyak.
           
           2. Serangan pada Malam Hari

            * Ulat tanah menyerang saat malam hari, terutama pada tanaman muda atau bibit.
           
           3. Kerusakan pada Daun atau Buah

            * Selain batang, ulat tanah juga dapat merusak daun yang berada dekat permukaan tanah atau buah yang menyentuh tanah.
           
           Dampak Serangan Ulat Tanah
           
            * Serangan ulat tanah dapat menyebabkan kerugian besar, terutama pada fase pembibitan.
            * Tanaman yang roboh tidak dapat tumbuh kembali, sehingga mengurangi populasi tanaman cabai di lahan.
            * Pada serangan berat, hasil panen dapat turun hingga 30–50%.
           
           Pengendalian Ulat Tanah pada Cabai
           
           1. Pengelolaan Kultur Teknis

            * Lakukan pengolahan tanah secara baik sebelum tanam untuk membunuh ulat atau pupa yang bersembunyi di dalam tanah.
            * Hindari penanaman cabai di lahan yang memiliki banyak sisa tanaman sebelumnya, karena dapat menjadi tempat berkembang biak ulat tanah.
            * Tanam bibit cabai dengan jarak tanam yang cukup untuk mengurangi kelembapan.
           
           2. Sanitasi Lahan

            * Singkirkan gulma dan sisa tanaman yang dapat menjadi tempat perlindungan bagi ulat tanah.
            * Pasang mulsa plastik hitam perak untuk menghambat pergerakan ulat tanah di permukaan.
           
           3. Pengendalian Hayati

            * Gunakan predator alami seperti burung atau kumbang tanah (Carabidae) untuk memangsa ulat tanah.
            * Aplikasi nematoda entomopatogen seperti Steinernema spp. untuk menyerang larva di dalam tanah.
            * Gunakan jamur entomopatogen seperti Metarhizium anisopliae untuk menekan populasi ulat tanah.
           
           4. Pengendalian Kimiawi

            * Sebarkan insektisida granular berbahan aktif seperti karbofuran atau klorpirifos di sekitar tanaman.
            * Semprotkan insektisida pada malam hari, ketika ulat tanah aktif.
            * Gunakan insektisida sistemik jika serangan meluas.
           
           5. Pengendalian Mekanis

            * Lakukan inspeksi rutin pada malam hari untuk menangkap ulat tanah secara manual.
            * Pasang perangkap berupa wadah yang diisi dengan air dan sedikit minyak untuk menangkap ngengat dewasa.
           
           6. Penggunaan Pestisida Nabati

            * Aplikasikan larutan ekstrak daun mimba atau tembakau yang dicampur dengan sabun cair untuk mengurangi populasi ulat tanah.
            
            Pengendalian ulat tanah pada cabai memerlukan pendekatan terpadu yang melibatkan sanitasi, pengelolaan kultur, dan pengendalian hayati atau kimiawi. Dengan langkah yang tepat, serangan ulat tanah dapat diminimalkan sehingga tanaman cabai tetap tumbuh sehat dan menghasilkan panen yang optimal.
            
            Tips Tambahan:
            
            * Menggunakan lampu perangkap di lahan dapat membantu mengurangi populasi ngengat dewasa, sehingga siklus ulat tanah dapat diputus
        """.trimIndent()

            )
        )
    }

    fun getDiseases(): List<Disease> {

        return listOf(
            Disease(
                name = "Sehat",
                symptoms = """
            Tanaman cabai yang sehat memiliki daun yang hijau cerah, tegak, dan bebas dari bercak atau kerusakan. Tanaman tumbuh subur dengan batang yang kuat dan akar yang berkembang baik. Tidak ada tanda-tanda penyakit atau hama pada daun atau buah cabai.
            
            Tanaman juga menunjukkan pertumbuhan yang konsisten, dengan daun yang tidak layu, tidak menguning, dan tidak terhambat oleh kondisi cuaca atau lingkungan.
        """.trimIndent(),
                control = """
            1. Pastikan tanaman mendapatkan cukup air dan sinar matahari untuk pertumbuhannya.
            2. Gunakan pupuk yang seimbang dan sesuai dengan kebutuhan tanaman cabai.
            3. Prune atau potong daun yang sudah tua atau rusak untuk mendorong pertumbuhan baru.
            4. Lakukan pemeliharaan berkala seperti pengecekan terhadap potensi serangan hama atau penyakit.
            5. Jaga kebersihan lingkungan sekitar tanaman dan lakukan rotasi tanaman untuk menghindari penurunan kualitas tanah.
        """.trimIndent()
            ),
            Disease(
                name = "Thrips",
                symptoms = """
            Hama ini menyerang tanaman dengan menghisap cairan permukaan bawah daun (terutama daun-daun muda). Serangan ditandai dengan adanya bercak keperak-perakkan. Daun yang terserang berubah warna menjadi coklat tembaga, mengeriting atau keriput dan akhirnya mati. Pada serangan berat menyebabkan daun, tunas atau pucuk menggulung ke dalam dan muncul benjolan seperti tumor, pertumbuhan tanaman terhambat dan kerdil bahkan pucuk tanaman menjadi mati. Hama ini merupakan vektor penyakit virus mosaik dan virus keriting. 
            Pada musim kemarau perkembangan hama sangat cepat, sehingga populasi lebih tinggi sedangkan pada musim penghujan populasinya akan berkurang karena banyak thrips yang mati akibat tercuci oleh air hujan. Hama ini bersifat polifag dengan tanaman inang utama cabai, bawang merah, bawang daun, jenis bawang lainnya dan tomat, sedangkan tanaman inang lainnya tembakau, kopi, ubi jalar, waluh, bayam, kentang, kapas, tanaman dari famili Crusiferae, Crotalaria dan kacang-kacangan.
        """.trimIndent(),
                control = """
            1. Menggunakan tanaman perangkap seperti kenikir kuning.
            2. Menggunakan mulsa perak.
            3. Sanitasi lingkungan dan pemotongan bagian tanaman yang terserang thrips.
            4. Penggunaan perangkap warna kuning sebanyak 40 buah per ha atau 2 buah per 500 m2 yang dipasang sejak tanaman berumur 2 minggu. Perangkap dapat dibuat dari potongan bambu yang dipasang plastik map warna kuning. Plastik diolesi dengan lem agar thrips yang tertarik menempel. Apabila plastik sudah penuh dengan thrips maka plastik perlu diganti.
            5. Pemanfaatan musuh alami yang potensial untuk mengendalikan hama thrips, antara lain predator kumbang Coccinellidae, tungau, predator larva Chrysopidae, kepik Entomophthora sp. Anthocoridae dan patogen.
            6. Pestisida digunakan apabila populasi hama atau kerusakan tanaman telah mencapai ambang pengendalian (serangan mencapai lebih atau sama dengan 15% per tanaman contoh) atau cara-cara pengendalian lainnya tidak dapat menekan populasi hama.
        """.trimIndent()
            ),
            Disease(
                name = "Bercak Daun",
                symptoms = """
            Penyakit ini menimbulkan kerusakan pada daun, batang dan akar. Gejala serangan penyakit ini mulai terlihat dari munculnya bercak bulat berwarna coklat pada daun dan kering, ukuran bercak bisa mencapai sekitar 1 inci. Pusat bercak berwarna pucat sampai putih dengan warna tepi lebih tua. Bercak yang tua dapat menyebabkan lubang-lubang. Bercak daun mampu menimbulkan kerugian ekonomi yang besar pada budidaya cabai, daun yang terserang akan layu dan rontok. Penyakit bercak daun ini dapat menyerang tanaman muda di persemaian, dan cenderung lebih banyak menyerang tanaman tua. Serangan berat menyebabkan tanaman cabai kehilangan hampir semua daunnya, kondisi ini akan mempengaruhi kemampuan cabai dalam menghasilkan buah. 
            Kondisi lingkungan yang selalu hujan mendukung perkembangan dan penyebaran penyakit bercak daun. Pada musim kemarau dan pada lahan yang mempunyai drainase baik, penyakit layu kurang berkembang.
        """.trimIndent(),
                control = """
            1. Sanitasi dengan cara memusnahkan dan atau sisa-sisa tanaman yang terinfeksi/terserang.
            2. Menanam bibit yang bebas patogen pada lahan yang tidak terkontaminasi oleh patogen, baik di persemaian maupun di lapangan.
            3. Perlakuan benih sebelum tanam.
            4. Perbaikan drainase.
            5. Waktu tanam yang tepat adalah musim kemarau dengan irigasi yang baik dan pergiliran tanaman dengan tanaman non solanaceae.
            6. Pengendalian kimia dapat dilakukan dengan fungisida secara bijaksana, efektif, terdaftar dan diijinkan oleh Menteri Pertanian, berpedoman pada peramalan cuaca dan populasi spora di lapangan.
        """.trimIndent()
            ),
            Disease(
                name = "Busuk Buah Antraknosa",
                symptoms = """
            Gejala awal penyakit ini ditandai dengan munculnya bercak yang agak mengkilap, sedikit terbenam dan berair, berwarna hitam, orange dan coklat. Warna hitam merupakan struktur dari cendawan (mikro skelerotia dan aservulus), apabila kondisi lingkungan lembab tubuh buah akan berwarna orange atau merah muda. Luka yang ditimbulkan akan semakin melebar dan membentuk sebuah lingkaran konsentris dengan ukuran diameter sekitar 30 mm atau lebih. Dalam waktu yang tidak lama buah akan berubah menjadi coklat kehitaman dan membusuk, ledakan penyakit ini sangat cepat pada musim hujan. Serangan yang berat menyebabkan seluruh buah keriput dan mengering. Warna kulit buah seperti jerami padi. Penyakit ini menyerang bagian buah cabai, baik buah yang masih muda maupun yang sudah masak. Cendawan ini termasuk salah satu patogen yang terbawa oleh benih. Penyebaran penyakit ini terjadi melalui percikan air, baik air hujan maupun alat semprot. Suhu optimum bagi perkembangan cendawan ini berkisar antara 20–24° C.
        """.trimIndent(),
                control = """
            1. Pencegahan dapat dilakukan dengan membersihkan lahan dan tanaman yang terserang agar tidak menyebar.
            2. Seleksi benih atau menggunakan benih cabai yang tahan terhadap penyakit ini perlu dilakukan mengingat penyakit ini termasuk patogen tular benih.
            3. Kultur teknis dengan pergiliran tanaman, penggunaan benih sehat dan sanitasi dengan memotong dan memusnahkan buah yang sakit.
            4. Penggunaan fungisida sesuai anjuran sebagai alternatif terakhir. Hindari penggunaan alat semprot, atau lakukan sanitasi terlebih dahulu sebelum menggunakan alat semprot.
        """.trimIndent()
            ),
            Disease(
                name = "Kutu Daun",
                symptoms = """
            Serangan berat biasanya terjadi pada musim kemarau. Bagian tanaman yang diserang oleh nimfa dan imago biasanya pucuk tanaman dan daun muda. Daun yang diserang akan mengkerut, mengeriting dan melingkar, menyebabkan pertumbuhan tanaman terhambat dan tanaman menjadi kerdil. Hama ini juga mengeluarkan cairan manis seperti madu, yang biasanya disebut dengan embun madu. Embun madu menarik datangnya semut dan cendawan jelaga. Adanya cendawan pada buah dapat menurunkan kualitas buah. Aphid juga dapat berperan sebagai vektor virus (50 jenis virus) seperti, Papaya Ringspot Virus, Watermelon Mosaic Virus, Cucumber MosaicVirus (CMV). Penyebaran hama ini sangat luas, meliputi daerah beriklim tropis dan sedang kecuali Canada bagian utara dan Asia bagian utara. Kisaran inang dari hama ini cukup luas, seperti tanaman dari family Fabaceaae (Legumes, Lucerne), Solanaceae, Cucurbitaceae dan asteraceae. Kutu daun menyebabkan kerusakan yang cukup serius pada beberapa tanaman sayuran, seperti asparagus, cabai, terong dan okra. Selain tanaman sayuran, kutu daun juga menyebabkan kerusakan yang cukup parah pada jeruk, kapas dan melon.
        """.trimIndent(),
                control = """
            1. Hindari menanam cabai secara berurutan di lokasi yang sama. Lakukan rotasi tanaman dan kosongkan area penanaman selama sekitar satu bulan untuk memutus siklus hidup kutu daun.
            2. Menjaga kebersihan kebun sangat penting. Singkirkan sisa-sisa tanaman dan gulma yang dapat menjadi tempat persembunyian bagi kutu daun.
            3. Menggunakan mulsa perak dapat membantu menekan perkembangan kutu daun dengan mengurangi kelembapan yang disukai oleh hama ini.
            4. Tanam tanaman pendamping seperti catnip, yang dapat menolak kutu daun. Sementara itu, tanaman seperti mustard dan nasturtium dapat berfungsi sebagai perangkap untuk menarik kutu jauh dari tanaman cabai.
            5. Semprotkan minyak hortikultura yang tidak aktif untuk membunuh telur kutu daun yang mungkin bertahan di musim dingin.
        """.trimIndent()
            ),
            Disease(
                name = "Virus Kuning",
                symptoms = """
            Helai daun mengalami vein clearing dimulai dari daun pucuk berkembang menjadi warna kuning jelas, tulang daun menebal dan daun menggulung ke atas. Infeksi lanjut dari gemini virus menyebabkan daun mengecil dan berwarna kuning terang, tanaman kerdil dan tidak berbuah. Keberadaan penyakit ini sangat merugikan karena mampu mempengaruhi produksi buah. Selain cabai virus ini juga mampu menyerang tanaman tomat, buncis, gula bit, babadotan, atau tanaman pertanian yang lain. Penyakit ini disebabkan oleh virus gemini dengan diameter partikel isometri berukuran 18–22 nm. Virus gemini mempunyai genome sirkular DNA tunggal. Virus dapat ditularkan melalui penyambungan dan melalui vektor Bemisia tabaci.
        """.trimIndent(),
                control = """
            1. Kendalikan serangga vektor virus kuning yaitu kutu kebul (Bemisia tabaci) dengan menggunakan musuh alami predator seperti Menochilus sexmaculatus atau jamur patogen serangga seperti Beauveria bassiana atau Verticillium lecani.
            2. Penanaman varietas tahan seperti hotchilli.
            3. Melakukan sanitasi lingkungan terutama tanaman inang seperti ciplukan, terong, gulma bunga kancing.
            4. Pemupukan tambahan untuk meningkatkan daya tahan tanaman sehingga tanaman tetap berproduksi walaupun terserang virus kuning.
            5. Kultur teknik yang meliputi: perendaman benih, penggunaan mulsa plastik (untuk menekan gulma inang, populasi vektor, menunda perkembangan virus).
            6. Penanaman tanaman pembatas seperti jagung dan tagetes.
        """.trimIndent()
            )
        )
    }
}