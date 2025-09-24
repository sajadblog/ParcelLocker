#include "Logger.h"

#include <QDateTime>
#include <QQmlContext>

Logger::Logger(QObject *parent)
    : QObject{parent}
{
    connect(&m_writeTimer, &QTimer::timeout, this, &Logger::writeTofile);
    m_writeTimer.setInterval(5000);
}

Logger::~Logger()
{
    writeTofile();
}

Logger *Logger::instance()
{
    static Logger inst;
    return &inst;
}

void Logger::registerYourself(QQmlContext *context)
{
    context->setContextProperty("logger", this);
}

void Logger::newLog(QString message, int level) // TODO : need to know from where it called
{
    QString logMessage{QDateTime::currentDateTime().toString("yyyy/MM/dd_hh:mm:ss.zz")+ ", " + m_kioskId + ", " + message};
    if(level >= m_outputLevel)
        qDebug() << logMessage;

    if(level < m_logLevel)
        return ;
    QMutexLocker lock(&m_writeMutex);
    m_cachedMessages.append(logMessage);
    if(!m_writeTimer.isActive())
        m_writeTimer.start();
}

void Logger::writeTofile()
{
    bool valuesWrited{false};

    QMutexLocker lock(&m_writeMutex);
    {
        //TODO : write values in file, database or send via network protocols
        valuesWrited = true;
    }
    if(valuesWrited)
    {
        m_cachedMessages.clear();
        m_writeTimer.stop();
    }
}

QString Logger::kioskId() const
{
    return m_kioskId;
}

void Logger::setkioskId(const QString &newkioskId)
{
    if (m_kioskId == newkioskId)
        return;
    m_kioskId = newkioskId;
    emit kioskIdChanged();
}
