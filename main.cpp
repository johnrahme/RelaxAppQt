#include <QApplication>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QWindow>
#include <QQmlContext>
#include <QStandardPaths>
#include <QDir>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    const QStringList musicPaths = QStandardPaths::standardLocations(QStandardPaths::MusicLocation);
    const QUrl musicUrl = QUrl::fromLocalFile(musicPaths.isEmpty() ? QDir::homePath() : musicPaths.first());
    engine.rootContext()->setContextProperty(QStringLiteral("musicUrl"), musicUrl);
    const QStringList arguments = QCoreApplication::arguments();
    const QUrl commandLineUrl = arguments.size() > 1 ? QUrl::fromLocalFile(arguments.at(1)) : QUrl();

    QString workingDir = "file://"+QDir::currentPath();
    //If on android use this instead
    workingDir = "";

    engine.rootContext()->setContextProperty("baseDir", workingDir);
    engine.rootContext()->setContextProperty(QStringLiteral("url"), commandLineUrl);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
