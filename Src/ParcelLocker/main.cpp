#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <AppearanceManager.h>
#include <QCommandLineParser>
#include <MainController.h>
#include <DoorController.h>
#include "Logger.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCommandLineParser parser;
    QCommandLineOption fullscreenOption(QStringList() << "f" << "fullscreen", QCoreApplication::translate("main", "Run the application in fullscreen mode."));
    parser.addOption(fullscreenOption);
    parser.process(app);

    const QStringList args = parser.positionalArguments();
    bool showFullscreen = parser.isSet(fullscreenOption);

    QQmlApplicationEngine engine ;

    Q_INIT_RESOURCE(ToolBox);

    AppearanceManager::instance()->registerYourself(engine.rootContext());

    auto mainController = std::make_shared<MainController>();
    mainController->registerYourself(engine.rootContext());
    mainController->setIsFullScreen(showFullscreen);
    QObject::connect(mainController.get(), &MainController::isEnglishChanged,mainController.get(),[&](){
        engine.retranslate();
    });

    DoorController doorController(mainController);
    doorController.registerYourself(engine.rootContext());
    logger->registerYourself(engine.rootContext());

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
