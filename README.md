<!-- Etkinlik Takip - Flutter Uygulaması -->
<!DOCTYPE html>
<html lang="en">
  <header>
    <h1>📱Etkinlik Takip</h1>
  </header>
<p>Firebase tabanlı bir etkinlik takip uygulaması</p>

<h2>Özellikler</h2>
<ul>
  <li><b>Kullanıcı Kayıt &amp; Giriş:</b> E-posta ve şifre ile kayıt/giriş, oturum süresi kontrolü, güvenli token saklama.</li>
  <li><b>Etkinlik Listesi:</b> Firestore'dan etkinlikleri (başlık, açıklama, tarih) listeleme, sadece görüntüleme.</li>
  <li><b>Push Bildirim:</b> Firebase Cloud Messaging ile foreground/background bildirim alma.</li>
  <li><b>Offline Cache:</b> Son çekilen etkinlikler çevrimdışıyken gösterilir, online olunca otomatik güncellenir.</li>
  <li><b>Test:</b> Homeview model unit testi.</li>
</ul>

<h2>Teknik Bilgiler</h2>
<ul>
  <li><b>State Management:</b> flutter_bloc (Cubit)</li>
  <li><b>Local Storage:</b> hive, flutter_secure_storage</li>
  <li><b>Navigation:</b> auto_route</li>
  <li><b>Firebase:</b> firebase_auth, cloud_firestore, firebase_messaging</li>
  <li><b>Push Notification:</b> flutter_local_notifications</li>
</ul>

<h2>Klasör Yapısı</h2>
<pre>


lib/
├── data/        # Modeller, servisler, cache
├── features/    # Ekranlar (auth, home, dashboard, profile)
├── product/     # Ortak bileşenler, tema, navigation, state, utility
├── main.dart    # Uygulama girişi
</pre>

https://github.com/user-attachments/assets/5f5f7c2a-836a-489c-a909-5581a434e6fc

</html>
