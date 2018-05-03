#include <QApplication>
//#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //QGuiApplication app(argc, argv);
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
/*

#ifdef Q_OS_WIN
    QString extraImportPath(QStringLiteral("%1/../../../../%2"));
    qDebug()<<"Running in QOSWIN. This is str: "<<extraImportPath;
#else
    QString extraImportPath(QStringLiteral("%1/../../../%2"));
    qDebug()<<"Running in the NOT q os win. This is str: "<<extraImportPath;
#endif


    engine.addImportPath(extraImportPath.arg(QGuiApplication::applicationDirPath(),
                                                       QString::fromLatin1("qml")));


*/
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));



    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
