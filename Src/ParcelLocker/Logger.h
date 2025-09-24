#ifndef LOGGER_H
#define LOGGER_H

#include <QMutex>
#include <QObject>
#include <QTimer>

class QQmlContext;
class Logger : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString kioskId READ kioskId WRITE setkioskId NOTIFY kioskIdChanged FINAL)
public:
    explicit Logger(QObject *parent = nullptr);
    ~Logger();
    void registerYourself(QQmlContext* context);

    Q_INVOKABLE void newLog(QString message, int level = 0);
    void writeTofile();

    QString kioskId() const;
    void setkioskId(const QString &newkioskId);

signals:
    void kioskIdChanged();

private :
    QString m_kioskId{"tempID"};
    QStringList m_cachedMessages{};
    QTimer m_writeTimer;
    QMutex m_writeMutex;
    int m_logLevel{0};
    int m_outputLevel{0};
};

#endif // LOGGER_H
