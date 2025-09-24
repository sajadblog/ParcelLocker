#include "DoorController.h"

#include "MainController.h"

#include <QQmlContext>
#include <QRandomGenerator>
#include <QThreadPool>

DoorController::DoorController(std::shared_ptr<MainController> mainControllerPtr, QObject *parent)
    : QObject{parent}, m_mainControllerPtr(mainControllerPtr)
{}

void DoorController::registerYourself(QQmlContext *context)
{
    context->setContextProperty("doorController", this);
}

bool DoorController::open(QString lockerId)
{
    if(m_mainControllerPtr == nullptr ||! m_mainControllerPtr->isConnected()) // INFO : Ignore the request
        return false;
    QThreadPool::globalInstance()->start([this,lockerId](){
        lazyOpen(lockerId);
    });
    return true;
}

bool DoorController::close(QString lockerId)
{
    if(m_mainControllerPtr == nullptr ||! m_mainControllerPtr->isConnected()) // INFO : Ignore the request
        return false;

    QThreadPool::globalInstance()->start([this,lockerId](){
        lazyClose(lockerId);
    });
    return true;
}

bool DoorController::isDoorOpen(QString )
{
    return static_cast<int>(QRandomGenerator::global()->bounded(2)) % 2 == 0 ;
}

void DoorController::lazyOpen(QString lockerID)
{
    int delay = QRandomGenerator::global()->bounded(100, 5000);
    QThread::msleep(delay);
    emit statusChanged(lockerID, true, delay % 2 == 0);
}

void DoorController::lazyClose(QString lockerID)
{
    auto delay = QRandomGenerator::global()->bounded(100, 10000);
    QThread::msleep(delay);
    emit statusChanged(lockerID, false, delay % 2 == 0);
}
