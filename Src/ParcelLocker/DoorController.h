#ifndef DOORCONTROLLER_H
#define DOORCONTROLLER_H

#include <QObject>

class QQmlContext;
class DoorController : public QObject
{
    Q_OBJECT
public:
    explicit DoorController(QObject *parent = nullptr);
    void registerYourself(QQmlContext* context);

    Q_INVOKABLE void open(QString lockerID);
    Q_INVOKABLE void close(QString lockerID);

signals:
    void statusChanged(QString lockerId, bool isOpen, bool success);

private :
    Q_INVOKABLE void lazyOpen(QString lockerID);
    Q_INVOKABLE void lazyClose(QString lockerID);
};

#endif // DOORCONTROLLER_H
