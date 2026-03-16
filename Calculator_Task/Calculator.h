#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QObject>
#include <QString>

class Calculator : public QObject {
    Q_OBJECT

    // The magic line that exposes the screen text to QML
    Q_PROPERTY(QString display READ display NOTIFY displayChanged)

public:
    explicit Calculator(QObject *parent = nullptr);

    // Getter for the property
    QString display() const;

    // This makes the function callable from QML
    Q_INVOKABLE void buttonPressed(const QString &value);

signals:
    // This signal tells QML to refresh the UI when the text changes
    void displayChanged();

private:
    QString m_display;            // What is currently on the screen
    double m_previousOperand;     // The left side of the math equation
    QString m_pendingOperator;    // The math symbol (+, -, ×, ÷)
    bool m_waitingForOperand;     // True if we just pressed an operator and are waiting for the next number

    void calculate();             // Helper function to do the math
};

#endif // CALCULATOR_H
