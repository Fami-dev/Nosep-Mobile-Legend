#!/bin/bash
cleanup() {
    clear  # Membersihkan layar
    echo -e "\e[1;32mProgram telah dihentikan. Layar dibersihkan.\e[0m"
    exit 0  # Keluar dari program
}

trap cleanup SIGINT
# Fungsi untuk membersihkan layar dan menampilkan judul besar
show_title() {
    clear  # Membersihkan layar
    echo -e "\e[1;36m"  # Mengatur warna biru muda
    printf "%0.s=" {1..60}  # Garis pembatas atas
echo
    echo
    printf "%*s\n" $(((${#title} + 60) / 2)) "$title"  # Menampilkan judul di tengah layar dengan warna biru muda
echo
    printf "%0.s=" {1..60}  # Garis pembatas bawah
    echo -e "\e[0m"  # Kembali ke warna normal

    # Menampilkan subjudul dan copyright
    echo -e "\e[1;33mInstagram: @femaandara_\e[0m"  # Warna oranye untuk Instagram
    echo -e "\e[1;33mCopyright 2024\e[0m"  # Warna pink untuk copyright
echo
}

# Fungsi untuk membuat efek warna-warni pada teks
rainbow_text() {
    local text="$1"
    local colors=("\e[31m" "\e[32m" "\e[33m" "\e[34m" "\e[35m" "\e[36m" "\e[37m")  # Warna untuk huruf

    # Mencetak setiap huruf dengan warna berbeda
    for ((i=0; i<${#text}; i++)); do
        char="${text:i:1}"
        color=${colors[$((i % ${#colors[@]}))]}  # Mengubah warna
        printf "${color}${char}\e[0m"  # Mencetak huruf
    done
    echo  # Pindah ke baris baru
}

# Fungsi untuk animasi loading dengan emotikon hati
show_loading() {
    local heart="❤️"  # Simbol hati
    local count=10  # Jumlah hati yang ditampilkan
    echo -n "Loading: "

    # Menonaktifkan keyboard selama loading
    stty -echo  # Menonaktifkan input keyboard

    for ((i=1; i<=count; i++)); do
        echo -n -e "${heart} "  # Menampilkan hati
        sleep 1  # Delay selama 1 detik
    done

    echo -ne "\n"  # Pindah ke baris baru setelah loading selesai
    stty echo  # Mengaktifkan kembali input keyboard
}

# Fungsi untuk hitungan mundur
countdown() {
 local duration=5  # Durasi hitungan mundur
    for ((i=duration; i>0; i--)); do
        # Mencetak kalimat dengan angka hitungan mundur
        echo -ne "\e[1;32mMengulang program dalam $i\e[0m\r"  # Menampilkan hitungan mundur dalam satu baris berwarna hijau
        sleep 1  # Delay selama 1 detik
    done
    echo -ne "\e[0m\r"  # Menghapus tampilan hitungan mundur
}

countfor() {
    local detik=5  # Durasi hitungan mundur
    for ((j=detik; j>0; j--)); do
        # Mencetak kalimat dengan angka hitungan mundur
        echo -ne "\e[1;32mProgram Sedang Dibersihkan $j\e[0m\r"
        sleep 1  # Delay selama 1 detik
    done
    echo -ne "\e[0m\r"  # Menghapus tampilan hitungan mundur
    echo ""  # Menambahkan baris baru setelah hitungan mundur selesai
}

# Fungsi untuk menjalankan perintah utama (grep dan awk) setelah animasi loading
run_main_program() {
    # Jalankan perintah grep dan simpan output ke file pertama
    grep -a "https://mtacc.mobilelegends.com" "$input_file" | tee "$output1_file" | awk -F '[:]' '{print "Username : "$3"\nPassword : "$4"\nNickname : \nIDServer : \nLevel : \nSkin : \nOwnerOff : \nKualitas : \nStatus : \n"}' > "$output2_file"
}

# Variabel judul besar
title="ML NOSEP TOOLS"

# Pindah ke direktori yang diinginkan
cd /storage/emulated/0/1.❤️AKUNML❤️

# Tampilkan judul besar di tengah layar
show_title

# Meminta pengguna untuk memasukkan nama file input
while true; do
    echo -e "\e[1;36mMasukkan nama file (input.txt):\e[0m"
 echo -e "\e[1;31mctrl+c to exit\e[0m"
echo
    read input_file
echo
    # Memeriksa apakah pengguna ingin keluar
    if [[ "$input_file" == "exit" ]]; then
        cleanup 
    fi

    # Memeriksa apakah file input ada
    if [[ -f "$input_file" ]]; then
        break  # Keluar dari loop jika file ditemukan
    else
        echo -e "\e[1;31mFile '$input_file' tidak ditemukan di direktori!\e[0m"  # Notifikasi jika file tidak ditemukan
        
        # Hitungan mundur 3 detik
        echo -n ""
        countdown  # Panggil fungsi hitungan mundur
        show_title  # Tampilkan kembali judul
    fi
done

trap cleanup SIGINT 

# Hapus input_file dari tampilan
clear  # Menghapus layar
show_title  # Menampilkan judul lagi

# Tampilkan notifikasi bahwa input berhasil
echo -e "\e[1;32mInput file '$input_file' berhasil dimasukkan!\e[0m"

# Tentukan nama file output berdasarkan input dari pengguna
output1_file="Output ${input_file}"
output2_file="DataAkunML ${input_file%.*}.txt"

# Tampilkan animasi loading dengan emotikon hati
show_loading
echo

# Menjalankan perintah utama setelah animasi loading selesai
run_main_program

# Hapus file output1_file setelah proses selesai
rm "$output1_file"

# Beri notifikasi bahwa proses telah selesai dan file output1_file telah dihapus
echo -e "\e[1;32mProses Selesai😁\e[0m"
echo -e "\e[1;33m$output2_file disimpan di (❤️AKUNML❤️)\e[0m"
echo -e "\e[1;36mBerusaha Tidak Akan Menghianati Hasil😂\e[0m"
echo
echo -n ""
countdown
    #!/bin/bash

# Menampilkan dialog dengan menu
dialog --title "Pilihan" --menu "Pilih opsi:" 15 50 6 \
        1 "Input File.txt" \
        2 "Mobile Legends" \
        3 "Mobile Legends PARALLEL" \
        4 "MT Manager" \
        5 "ZArchiver" \
        6 "Keluar Program" 2>temp_choice

choice=$(<temp_choice)  # Membaca pilihan pengguna dari file temporer
rm temp_choice  # Menghapus file temporer

# Menangani pilihan pengguna
case $choice in
    1)  # Coba lagi
        cd $HOME  # Kembali ke direktori home Termux
        if [[ -f "$HOME/nosep.sh" ]]; then  # Memeriksa keberadaan file nosep.sh
            ./nosep.sh  # Jalankan file jika ada
        else
            echo -e "\e[1;31mFile 'nosep.sh' tidak ditemukan di direktori home!\e[0m"
        fi
        ;;
    2)  # Buka Mobile Legends
        am start -n com.mobile.legends/com.moba.unityplugin.MobaGameMainActivityWithExtractor
cleanup
        ;;
    3)  # Buka Mobile Legends PARALLEL
        am start -n com.ludashi.superboost/com.ludashi.superboost.MainActivity
cleanup
        ;;
    4)  # Buka MT Manager
        am start -n bin.mt.plus/bin.mt.plus.MainLightIcon
cleanup
        ;;
    5)  # Buka ZArchiver
        am start -n ru.zdevs.zarchiver/ru.zdevs.zarchiver.ZArchiver
cleanup
        ;;
    6)  cleanup
exit 0  # Keluar dari Termux
        ;;
    *)  # Pilihan tidak valid
        cd $HOME  # Kembali ke direktori home Termux          cd $HOME  # Kembali ke direktori home Termux
        if [[ -f "$HOME/nosep.sh" ]]; then  # Memeriksa keberadaan file nosep.sh
            ./nosep.sh  # Jalankan file jika ada
        else
            echo -e "\e[1;31mFile 'nosep.sh' tidak ditemukan di direktori home!\e[0m"
        fi
        ;;
esac

