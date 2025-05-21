
# Добавление нового метода `doSomething` в проект (QML → Manager → Worker → DB)

Этот шаблон описывает пошагово, как правильно добавить новый функциональный метод в существующую архитектуру с `DatabaseManager`, `DatabaseWorker`, и QML.

---

## 🔧 Общая схема
1. **QML вызывает метод у Manager.**
2. **Manager испускает сигнал → Worker.**
3. **Worker выполняет SQL-логику, эмитит результат обратно.**
4. **Manager ловит сигнал от Worker, при необходимости трансформирует.**
5. **Manager эмитит сигнал в QML или модель.**

---

## 📌 Этапы

### 1. В `DatabaseWorker`:

#### 🔹 Объявление метода

```cpp
Q_INVOKABLE void doSomething(int param);  // если нужен вызов из QML напрямую
// или
public slots:
    void doSomething(int param);  // для вызова из Manager
```

#### 🔹 Реализация

```cpp
void DatabaseWorker::doSomething(int param) {
    qDebug() << "doSomething вызван с параметром:" << param;

    if (!db.isOpen()) {
        emit errorOccurred("База данных не открыта");
        return;
    }

    QSqlQuery query(db);
    query.prepare("SELECT ... WHERE some_column = :param");
    query.bindValue(":param", param);

    if (!query.exec()) {
        emit errorOccurred("Ошибка выполнения запроса: " + query.lastError().text());
        return;
    }

    if (query.next()) {
        Project result;
        result.setProjectId(query.value("id").toInt());
        result.setProjectName(query.value("name").toString());
        result.setProjectStatus(query.value("status").toString());

        emit doSomethingResultReady(result);
    } else {
        emit errorOccurred("Ничего не найдено");
    }
}
```

#### 🔹 Добавь сигнал:

```cpp
signals:
    void doSomethingResultReady(const Project &project);
```

---

### 2. В `DatabaseManager`:

#### 🔹 Слот для приёма сигнала от Worker

```cpp
private slots:
    void onDoSomethingResultReady(const Project &project);
```

#### 🔹 Реализация слота

```cpp
void DatabaseManager::onDoSomethingResultReady(const Project &project) {
    qDebug() << "Получен результат из Worker";

    QVariantMap map;
    map["id"] = project.getProjectId();
    map["name"] = project.getProjectName();
    map["status"] = project.getProjectStatus();

    emit doSomethingResultReadyForQml(map);
}
```

#### 🔹 Метод вызова (из QML или модели)

```cpp
Q_INVOKABLE void requestDoSomething(int param) {
    emit requestDoSomethingSignal(param);
}
```

#### 🔹 Сигналы

```cpp
signals:
    void requestDoSomethingSignal(int param);  // от менеджера в воркер
    void doSomethingResultReadyForQml(const QVariantMap &project);  // в QML
```

#### 🔹 Подключение сигналов/слотов в конструкторе `DatabaseManager`

```cpp
bool connected1 = connect(this, &DatabaseManager::requestDoSomethingSignal,
                          worker, &DatabaseWorker::doSomething);
qDebug() << "requestDoSomethingSignal -> doSomething connect:" << connected1;

bool connected2 = connect(worker, &DatabaseWorker::doSomethingResultReady,
                          this, &DatabaseManager::onDoSomethingResultReady);
qDebug() << "doSomethingResultReady -> onDoSomethingResultReady connect:" << connected2;
```

---

### 3. В `QML` (если нужно)

```qml
Connections {
    target: manager
    onDoSomethingResultReadyForQml: {
        console.log("Результат получен из менеджера:", project)
    }
}

// вызов
manager.requestDoSomething(42)
```

---

## 🧠 Дополнительно

- Используй `Qt::QueuedConnection` при `connect(...)` между потоками.
- Обязательно проверяй `isOpen()` и `isInitialized` перед SQL-запросами.
- Логируй все критические ошибки для отладки.

---
