# GitHubFollowers

![GitHub followers](https://img.shields.io/github/followers/{username}?style=social)
![GitHub forks](https://img.shields.io/github/forks/{username}/{repo}?style=social)
![GitHub stars](https://img.shields.io/github/stars/{username}/{repo}?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/{username}/{repo}?style=social)
![GitHub repo size](https://img.shields.io/github/repo-size/doguner1/GithubFollowers)

Bu proje, SwiftUI kullanarak geliştirilmiş bir iOS uygulamasıdır. GitHub kullanıcı bilgilerini (takipçiler, takip edilenler vb.) çekmek ve görselleştirmek amacıyla oluşturulmuştur.

## Ekran Görüntüleri

![Ekran Kaydı](https://github.com/doguner1/GitImageData/blob/main/GithubFollowes/Ekran%20Kaydı%202024-06-19%2017.10.57.mov)


## Kullanılan Mimari ve Yöntemler

- **MVVM (Model-View-ViewModel) Mimari**: Uygulama, kullanıcı arayüzünü (View) ve iş mantığını (ViewModel) ayrı olarak yöneten MVVM mimarisiyle tasarlanmıştır.
  
- **SwiftUI**: Apple'ın modern UI framework'ü olan SwiftUI kullanılarak UI bileşenleri oluşturulmuştur.
  
- **Combine Framework**: Asenkron veri işleme için Combine framework'ü kullanılmıştır. Özellikle GitHub API ile iletişim kurarken veri akışını yönetmek için bu framework tercih edilmiştir.

- **SDWebImageSwiftUI**: Görüntüleri asenkron olarak yüklemek ve önbelleğe almak için kullanılan bir SwiftUI kütüphanesidir. Uzak sunucudan görüntüleri etkin bir şekilde yönetmek için tercih edilmiştir.

- **WebKit**: Web içeriğini görüntülemek ve entegre etmek için kullanılan bir framework'dür. Bu projede, web tabanlı içerikleri göstermek için kullanılmıştır.

## Amaç

Bu proje, SwiftUI ve Combine framework'ünü kullanarak iOS platformunda GitHub kullanıcı bilgilerini dinamik olarak çekmek ve kullanıcı dostu bir arayüzde göstermek amacıyla geliştirilmiştir. Kullanıcılar, uygulama içindeki çeşitli ekranlar aracılığıyla takipçi, takip edilenler gibi bilgilere erişebilir ve bu bilgileri görsel olarak analiz edebilirler.

## Nasıl Çalıştırılır?

1. Bu projeyi bilgisayarınıza klonlayın:
   ```bash
   git clone https://github.com/doguner1/GithubFollowers.git
   cd GithubFollowers

2. Xcode'u açın ve projeyi başlatın:
   ```bash
   open SwiftUILoginScreen.xcodeproj

3. Bir simulatör veya cihaz üzerinde projeyi çalıştırın.


## Katkıda Bulunma

1. Projeyi fork'layın.
2. Yeni bir dal (branch) oluşturun:
    ```bash
    git checkout -b feature/yenilik
    ```
3. Yaptığınız değişiklikleri commit edin:
    ```bash
    git commit -am 'Yeni bir özellik ekledim'
    ```
4. Dalı (branch) ana repoya push'layın:
    ```bash
    git push origin feature/yenilik
    ```
5. Bir Pull Request oluşturun.

## Geliştirici
- [Doğu GNR](https://github.com/doguner1)