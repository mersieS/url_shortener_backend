## Kurulum

- Bağımlı olunan gem paketlerini kur;

```
bundle install
```

**Not**: **.env example** dosyasında bulunan değişkenler **.env** dosyasına kopyalandıktan sonra **TOKEN, DB_USERNAME, DB_HOST** değişkenleri uygun şekilde güncellenmelidir.

- Database yaratmak için;

```
rails db:create
```

- Database migration dosyalarını çalıştır;

```
rails db:migrate
```

- Seed data oluştur (opsiyonel);

```
rails db:seed
```

- Sunucuyu çalıştır;

```
rails server
```

- Çalışma anında test kodları için rspec komutu kullanılabilir;

```
bundle exec rspec
```