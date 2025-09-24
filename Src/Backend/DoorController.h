#ifndef DOORCONTROLLER_H
#define DOORCONTROLLER_H

#include <QObject>

class MainController;
class QQmlContext;
class DoorController : public QObject
{
    Q_OBJECT
public:
    explicit DoorController(std::shared_ptr<MainController> mainControllerPtr, QObject *parent = nullptr);
    void registerYourself(QQmlContext* context);

    Q_INVOKABLE bool open(QString lockerID);
    Q_INVOKABLE bool close(QString lockerID);
    Q_INVOKABLE bool isDoorOpen(QString lockerID);

signals:
    void statusChanged(QString lockerId, bool isOpen, bool success);

private :
    Q_INVOKABLE void lazyOpen(QString lockerID);
    Q_INVOKABLE void lazyClose(QString lockerID);

    std::shared_ptr<MainController> m_mainControllerPtr;
};

#endif // DOORCONTROLLER_H
