# Günlük Görev Takip Uygulaması (Daily Task Tracker)

Modern ve kullanıcı dostu bir iOS mobil uygulaması olan Günlük Görev Takip Uygulaması, günlük işlerinizi organize etmenizi ve takip etmenizi sağlar.

## 🚀 Özellikler

### 📋 Görev Yönetimi
- **Görev Ekleme**: Başlık, öncelik seviyesi, bitiş tarihi ve notlar ile yeni görevler oluşturun
- **Görev Düzenleme**: Mevcut görevleri güncelleyin ve değiştirin
- **Görev Silme**: Tamamlanan veya gereksiz görevleri silin
- **Görev Tamamlama**: Tek dokunuşla görevleri tamamlandı olarak işaretleyin

### 🎯 Öncelik Sistemi
- **Yüksek Öncelik** (Kırmızı): Acil ve önemli görevler
- **Orta Öncelik** (Turuncu): Normal görevler (varsayılan)
- **Düşük Öncelik** (Yeşil): Ertelenebilir görevler

### 📊 Farklı Görünümler
- **Bugün**: Bugün oluşturulan görevler
- **Bekleyen**: Henüz tamamlanmamış görevler (öncelik sırasına göre)
- **Tamamlanan**: Bitirilen görevler
- **Tümü**: Tüm görevlerin listesi

### 💾 Veri Saklama
- UserDefaults kullanarak otomatik veri saklama
- Uygulama kapatılıp açıldığında görevler korunur
- JSON formatında güvenli veri saklama

## 🛠 Teknik Özellikler

### Geliştirme Ortamı
- **Platform**: iOS 16.0+
- **Dil**: Swift 5.0
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Xcode**: 15.0+

### Kullanılan Teknolojiler
- **SwiftUI**: Modern ve responsive kullanıcı arayüzü
- **Combine**: Reactive programming ve data binding
- **UserDefaults**: Lokal veri saklama
- **Foundation**: Temel iOS framework'leri

## 📱 Kullanıcı Arayüzü

### Ana Ekran
- Tab tabanlı navigasyon sistemi
- Floating Action Button ile hızlı görev ekleme
- Liste görünümü ile görev listeleme
- Boş durumlar için bilgilendirici mesajlar

### Görev Ekleme Ekranı
- Form tabanlı görev oluşturma
- Öncelik seçimi
- Opsiyonel bitiş tarihi belirleme
- Not ekleme imkanı

### Görev Detay Ekranı
- Görev bilgilerini görüntüleme
- Düzenleme modu ile güncelleme
- Tarih formatlaması ve lokalizasyon

## 🔧 Kurulum ve Çalıştırma

### Gereksinimler
- macOS 13.0+ (Ventura veya üzeri)
- Xcode 15.0+
- iOS 16.0+ (test cihazı için)

### Adımlar
1. **Proje dosyasını açın**:
   ```bash
   open DailyTaskTracker.xcodeproj
   ```

2. **Target seçin**: iPhone veya iPad simulator

3. **Çalıştırın**: ⌘+R veya Run butonuna basın

## 📁 Proje Yapısı

```
DailyTaskTracker/
├── DailyTaskTrackerApp.swift      # Ana uygulama entry point
├── ContentView.swift              # Ana görünüm ve tab navigation
├── Models/
│   ├── Task.swift                 # Görev veri modeli
│   └── TaskStore.swift            # Görev yönetimi ve veri saklama
├── Views/
│   ├── TaskRowView.swift          # Görev liste öğesi ve detay görünümü
│   └── AddTaskView.swift          # Yeni görev ekleme formu
├── Assets.xcassets/               # Uygulama varlıkları
└── Preview Content/               # SwiftUI preview varlıkları
```

## 🌟 Kullanım Kılavuzu

### Yeni Görev Ekleme
1. Ana ekrandaki mavi **+** butonuna dokunun
2. Görev başlığını girin
3. Öncelik seviyesini seçin
4. İsteğe bağlı olarak bitiş tarihi belirleyin
5. Gerekirse not ekleyin
6. **"Ekle"** butonuna dokunun

### Görev Tamamlama
- Görev satırındaki daire ikonuna dokunarak görevı tamamlandı olarak işaretleyin

### Görev Düzenleme
1. Düzenlemek istediğiniz göreve dokunun
2. Açılan detay ekranında **"Düzenle"** butonuna basın
3. Değişiklikleri yapın
4. **"Kaydet"** butonuna basın

### Görev Silme
- Liste görünümünde görev üzerinde sola kaydırın ve **"Delete"** seçeneğini kullanın

## 🎨 Tasarım Özellikleri

### Renk Paleti
- **Ana Renk**: Mavi (#007AFF)
- **Yüksek Öncelik**: Kırmızı (#FF3B30)
- **Orta Öncelik**: Turuncu (#FF9500)
- **Düşük Öncelik**: Yeşil (#34C759)
- **Metin**: Sistem renkleri (Dark Mode desteği)

### Typography
- Sistem fontları kullanılarak okunabilirlik optimizasyonu
- Farklı font ağırlıkları ile hiyerarşi oluşturma
- Türkçe karakter desteği

### Accessibility
- VoiceOver desteği
- Dynamic Type desteği
- High Contrast Mode uyumluluğu

## 🔄 Gelecek Özellikler

- [ ] Widget desteği
- [ ] iCloud senkronizasyonu
- [ ] Kategori sistemi
- [ ] Bildirim sistemi
- [ ] Dark mode optimizasyonu
- [ ] iPad için optimize edilmiş arayüz
- [ ] Export/Import özellikleri
- [ ] Görev istatistikleri

## 🤝 Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/YeniOzellik`)
3. Değişikliklerinizi commit edin (`git commit -am 'Yeni özellik eklendi'`)
4. Branch'i push edin (`git push origin feature/YeniOzellik`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

## 🙏 Teşekkürler

- Apple SwiftUI dokümantasyonu
- iOS tasarım prensipleri
- Türkçe lokalizasyon kaynakları

---

**Not**: Bu uygulama eğitim amaçlı geliştirilmiştir ve sürekli olarak geliştirilmektedir.