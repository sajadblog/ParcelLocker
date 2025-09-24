 // src_qmltest_qquicktest.cpp
#include <QtQuickTest>
#include <QQmlEngine>
#include <QQmlContext>
#include <DoorController.h>
#include <MainController.h>

class Setup : public QObject
{
    Q_OBJECT

public:
    Setup() {}

public slots:
    void applicationAvailable()
    {
    }

    void qmlEngineAvailable(QQmlEngine *engine)
    {
        mainController = std::make_shared<MainController>();
        doorController = std::make_shared<DoorController>(mainController);

        mainController->registerYourself(engine->rootContext());
        doorController->registerYourself(engine->rootContext());
    }

    void cleanupTestCase()
    {
    }

private :
    std::shared_ptr<MainController> mainController ;
    std::shared_ptr<DoorController> doorController ;
};

QUICK_TEST_MAIN_WITH_SETUP(testCases, Setup)

#include "tst_main.moc"
