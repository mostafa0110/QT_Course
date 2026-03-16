#include "Calculator.h"

Calculator::Calculator(QObject *parent) : QObject(parent),
    m_display("0"), m_previousOperand(0.0), m_waitingForOperand(true) {}

QString Calculator::display() const {
    return m_display;
}

void Calculator::buttonPressed(const QString &value) {
    // 1. If it's a Number
    if (value >= "0" && value <= "9") {
        if (m_waitingForOperand) {
            m_display = value; // Replace the screen with the new number
            m_waitingForOperand = false;
        } else {
            if (m_display == "0") m_display = value; // Don't allow "007"
            else m_display += value; // Append digits (e.g., "7" + "8" = "78")
        }
    }
    // 2. If it's the Clear button
    else if (value == "C") {
        m_display = "0";
        m_previousOperand = 0.0;
        m_pendingOperator = "";
        m_waitingForOperand = true;
    }
    // 3. If it's the Equals button
    else if (value == "=") {
        calculate();
        m_pendingOperator = "";
        m_waitingForOperand = true;
    }
    // 4. If it's an Operator (+, -, ×, ÷)
    else {
        if (!m_waitingForOperand) {
            calculate();
            m_pendingOperator = value;
            m_waitingForOperand = true;
        } else {
            m_pendingOperator = value; // Allow user to change their mind on the operator
        }
    }

    // CRITICAL: Tell QML that the m_display variable has changed!
    emit displayChanged();
}

void Calculator::calculate() {
    if (m_pendingOperator.isEmpty()) {
        m_previousOperand = m_display.toDouble();
        return;
    }

    double currentOperand = m_display.toDouble();
    double result = 0.0;

    if (m_pendingOperator == "+") result = m_previousOperand + currentOperand;
    else if (m_pendingOperator == "-") result = m_previousOperand - currentOperand;
    else if (m_pendingOperator == "×") result = m_previousOperand * currentOperand;
    else if (m_pendingOperator == "÷") {
        if (currentOperand == 0.0) {
            m_display = "Error"; // Prevent dividing by zero
            return;
        }
        result = m_previousOperand / currentOperand;
    }

    // Convert the double back to a string, removing unnecessary trailing zeros
    m_display = QString::number(result, 'g', 10);
    m_previousOperand = result;
}
