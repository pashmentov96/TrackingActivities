from app import db, login
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin


class User(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), index=True, unique=True)
    email = db.Column(db.String(120), index=True, unique=True)
    password_hash = db.Column(db.String(128))
    records = db.relationship('ActivityRecord', backref='user', lazy='dynamic')

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def __repr__(self):
        return '<User {}>'.format(self.username)


class ActivityRecord(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64))
    distance = db.Column(db.Float)
    difficulty = db.Column(db.Float)
    observations = db.relationship('ObservationRecord', backref='activity', lazy='dynamic')
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))


class ObservationRecord(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    elevation = db.Column(db.Float)
    pace = db.Column(db.Float)
    heart_rate = db.Column(db.Float)
    distance_from_start = db.Column(db.Float)
    activity_record_id = db.Column(db.Integer, db.ForeignKey('activity_record.id'))


@login.user_loader
def load_user(id):
    return User.query.get(int(id))