#include "DoorController.h"

#include <QQmlContext>
#include <QRandomGenerator>
#include <QThreadPool>

DoorController::DoorController(QObject *parent)
    : QObject{parent}
{}

void DoorController::registerYourself(QQmlContext *context)
{
    context->setContextProperty("doorController", this);
}

void DoorController::open(QString lockerId)
{
    QThreadPool::globalInstance()->start([this,lockerId](){
        lazyOpen(lockerId);
    });
}

void DoorController::close(QString lockerId)
{
    QThreadPool::globalInstance()->start([this,lockerId](){
        lazyClose(lockerId);
    });
}

bool DoorController::isDoorOpen(QString lockerID)
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
