#include "MainController.h"
#include <QFile>
#include <QJsonArray>
#include <QJsonObject>
#include <QQmlContext>
#include <QRandomGenerator>
#include <QThreadPool>
#include <QTranslator>
#include <QGuiApplication>
#include "Logger.h"

MainController::MainController(QObject *parent)
    : QObject{parent}
{


    QFile file(":/mock_api.json");
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        m_mock_api = QJsonDocument::fromJson(file.readAll());
        file.close();
    }
}

void MainController::registerYourself(QQmlContext *context)
{
    context->setContextProperty("mainController", this);
}

void MainController::checkPinNumber(int pinNumber)
{
    if(!m_isConnected) // INFO : Ignore the request
        return;

    QThreadPool::globalInstance()->start([this,pinNumber](){
        lazyCheckPinNumber(pinNumber);
    });
}

bool MainController::isEnglish() const
{
    return m_isEnglish;
}

void MainController::setIsEnglish(bool newIsEnglish)
{
    if (m_isEnglish == newIsEnglish)
        return;
    m_isEnglish = newIsEnglish;

    static QTranslator ptTranslator;
    if(newIsEnglish)
    {
        qApp->removeTranslator(&ptTranslator);
    }else{
        if(ptTranslator.load(":/translation/ParcelLocker_pt.qm")){
            qApp->installTranslator(&ptTranslator);
        }
    }

    emit isEnglishChanged();
}

bool MainController::isConnected() const
{
    return m_isConnected;
}

void MainController::setIsConnected(bool newIsConnected)
{
    if (m_isConnected == newIsConnected)
        return;
    m_isConnected = newIsConnected;
    logger->newLog(QString("Connection changed %0").arg(newIsConnected));

    emit isConnectedChanged();
}

bool MainController::isFullScreen() const
{
    return m_isFullScreen;
}

void MainController::setIsFullScreen(bool newIsFullScreen)
{
    if (m_isFullScreen == newIsFullScreen)
        return;
    m_isFullScreen = newIsFullScreen;
    emit isFullScreenChanged();
}

void MainController::lazyCheckPinNumber(int pinNumber)
{
    QThread::msleep(QRandomGenerator::global()->bounded(2000, 9000));
    if (!m_mock_api.isNull()) {
        QJsonObject rootObj = m_mock_api.object();
        QJsonArray codesArray = rootObj["codes"].toArray();

        for (const QJsonValue &value : std::as_const(codesArray)) {
            QJsonObject codeObj = value.toObject();
            QString pin = codeObj["pin"].toString();
            QString lockerId = codeObj["lockerId"].toString();
            QJsonArray itemsArray = codeObj["items"].toArray();

            QStringList items;
            for (const QJsonValue &item : std::as_const(itemsArray)) {
                items.append(item.toString());
            }

            if(pin.toInt() == pinNumber){
                emit pinNumberEvaluated(pin.toInt(), lockerId, items);
                return;
            }
        }
    }
    emit pinNumberEvaluated(pinNumber, "", {});
}
