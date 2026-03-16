#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext> // 1. REQUIRED: Include the QML Context header
#include "Calculator.h" // 2. REQUIRED: Include your new C++ class

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // 3. Create an instance of your calculator logic
    Calculator myCalculator;

    // 4. Inject it into QML!
    // Now, QML can access this exact C++ object using the name "calcBackend"
    engine.rootContext()->setContextProperty("calcBackend", &myCalculator);

    const QUrl url(QStringLiteral("qrc:/qt/qml/Calculator_Task/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
                     Qt::QueuedConnection);
    engine.loadFromModule("Calculator_Task", "Main");

    return app.exec();
}
