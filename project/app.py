from flask import Flask, request, render_template, redirect, url_for

app = Flask(__name__)


@app.route('/')
def hello_world():
    return redirect('login')


@app.route('/welcome')
def welcome():
    return render_template('welcome.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')

    elif request.method == 'POST':
        name = request.form['username']
        passwd = request.form['password']
        if name != '' and passwd != '':
            return render_template('index.html', name=name)
        else:
            return render_template('login.html')


if __name__ == '__main__':
    app.run(debug=True)
