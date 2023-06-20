import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel, QVBoxLayout, QWidget, QPushButton, QTextEdit
import psycopg2

class SQLQueryApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("SQL Query App")
        self.setGeometry(100, 100, 500, 500)

        self.connection = None
        self.cursor = None

        self.init_ui()

    def init_ui(self):
        self.label = QLabel("Enter your SQL query:")
        self.text_edit = QTextEdit()
        self.button = QPushButton("Run Query")
        self.result_label = QLabel()

        layout = QVBoxLayout()
        layout.addWidget(self.label)
        layout.addWidget(self.text_edit)
        layout.addWidget(self.button)
        layout.addWidget(self.result_label)

        widget = QWidget()
        widget.setLayout(layout)
        self.setCentralWidget(widget)

        self.button.clicked.connect(self.run_query)

    def run_query(self):
        query = self.text_edit.toPlainText()

        try:
            self.cursor.execute(query)
            result = self.cursor.fetchall()
            self.display_result(result)
        except (psycopg2.Error, Exception) as e:
            self.display_result(str(e))

    def display_result(self, result):
        if isinstance(result, list):
            result_str = '\n'.join([str(row) for row in result])
        else:
            result_str = str(result)
        self.result_label.setText(result_str)

    def connect_to_database(self):
        try:
            self.connection = psycopg2.connect(
                host='localhost',
                port='5432',
                database='dvdrental_db',
                user='postgres',
                password='password123'
            )
            self.cursor = self.connection.cursor()
        except psycopg2.Error as e:
            print(f"Error connecting to database: {str(e)}")
            sys.exit()

    def closeEvent(self, event):
        if self.connection:
            self.cursor.close()
            self.connection.close()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = SQLQueryApp()
    window.connect_to_database()
    window.show()
    sys.exit(app.exec_())

