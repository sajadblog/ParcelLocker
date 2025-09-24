#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H

#include <QJsonDocument>
#include <QObject>

class QQmlContext;
class MainController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isConnected READ isConnected WRITE setIsConnected NOTIFY isConnectedChanged FINAL)
    Q_PROPERTY(bool isEnglish READ isEnglish WRITE setIsEnglish NOTIFY isEnglishChanged FINAL)
    Q_PROPERTY(bool isFullScreen READ isFullScreen WRITE setIsFullScreen NOTIFY isFullScreenChanged FINAL)
public:
    explicit MainController(QObject *parent = nullptr);
    void registerYourself(QQmlContext* context);

    Q_INVOKABLE void checkPinNumber(int pinNumber);

    bool isEnglish() const;
    void setIsEnglish(bool newIsEnglish);

    bool isConnected() const;
    void setIsConnected(bool newIsConnected);

    bool isFullScreen() const;
    void setIsFullScreen(bool newIsFullScreen);

signals:
    void isEnglishChanged();
    void isConnectedChanged();

    // TODO : There should be a uuid to check received states base on ID not pin number
    void pinNumberEvaluated(int pinValue, QString lockerId, QStringList items);

    void isFullScreenChanged();

private :
    bool m_isEnglish{true};
    bool m_isConnected{true};
    bool m_isFullScreen{false};
    QJsonDocument m_mock_api;

    void lazyCheckPinNumber(int pinNumber);
};

#endif // MAINCONTROLLER_H
