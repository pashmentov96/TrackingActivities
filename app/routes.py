from app import app, db
from flask import render_template, redirect, url_for, flash, request, jsonify
from app.forms import LoginForm, RegistrationForm
from app.models import User
from flask_login import current_user, login_user, logout_user, login_required
from werkzeug.urls import url_parse
from werkzeug.utils import secure_filename
import os
import json
from app.models import User, ActivityRecord
from datetime import datetime


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() == 'json'


def change_favorite(id, value, user):
    record = ActivityRecord.query.filter_by(id=id).first()
    record.is_favorite = value
    db.session.add(record)
    db.session.commit()


def parse_data(data, user):
    for activity in data:
        act = ActivityRecord(name=activity['name'],
                             category=activity['category'],
                             distance=activity['distance'],
                             heart_rate=activity['heartrate'],
                             time=activity['time'],
                             difficulty=activity['difficulty'],
                             date_time=activity['datetime'],
                             is_favorite=False,
                             user=user)
        db.session.add(act)
    db.session.commit()


def add_file(filename):
    with open(os.path.join(app.config['UPLOAD_FOLDER'], filename)) as json_file:
        data = json.load(json_file)
        parse_data(data, current_user)


@app.route('/', methods=['GET', 'POST'])
@app.route('/index', methods=['GET', 'POST'])
@login_required
def index():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            add_file(filename)
    return render_template('index.html', title='Home')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('index'))
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(username=form.username.data).first()
        if user is None or not user.check_password(form.password.data):
            flash('Invalid username or password')
            return redirect(url_for('login'))
        login_user(user, remember=form.remember_me.data)
        next_page = request.args.get('next')
        if not next_page or url_parse(next_page).netloc != '':
            next_page = url_for('index')
        return redirect(next_page)
    return render_template('login.html', title='Sign In', form=form)


@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('index'))


@app.route('/register', methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('index'))
    form = RegistrationForm()
    if form.validate_on_submit():
        user = User(username=form.username.data, email=form.email.data)
        user.set_password(form.password.data)
        db.session.add(user)
        db.session.commit()
        flash('Congratulations, you are now a registered user!')
        return redirect(url_for('login'))
    return render_template('register.html', title='Register', form=form)


@app.route('/user/activities', methods=['GET'])
@login_required
def table_activities():
    records = []
    for record in current_user.records:
        date_time = datetime.fromisoformat(record.date_time)
        tmp = datetime.fromisoformat(date_time.isoformat(timespec='seconds'))
        elem = {
            "name": record.name,
            "category": record.category,
            "distance": record.distance,
            "heart_rate": record.heart_rate,
            "time": record.time,
            "difficulty": record.difficulty,
            "date_time": (str(date_time.date()) + ", " + str(tmp.time()))
        }
        records.append(elem)
    return render_template('table_activities.html', title='Table activities', records=records)
