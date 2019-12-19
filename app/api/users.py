from flask import g
from app.api.auth import token_auth
from app.api import bp
from app.models import User
from flask import jsonify, request
from app.routes import parse_data, change_favorite


@bp.route('/user/nrecords', methods=['GET'])
@token_auth.login_required
def get_nrecords():
    user = g.current_user
    res = 0
    if user is None:
        res = -1
    else:
        for record in user.records:
            res += 1

    json_obj = {'records': res}

    return jsonify(json_obj)


@bp.route('/user/add_records', methods=['POST'])
@token_auth.login_required
def add_records():
    data = request.json
    parse_data(data, g.current_user)
    return '', 200


@bp.route('/user/add_record', methods=['POST'])
@token_auth.login_required
def add_record():
    data = request.json
    data = [data]
    parse_data(data, g.current_user)
    return '', 200


@bp.route('/user/get_records', methods=['GET'])
@token_auth.login_required
def get_records():
    user = g.current_user
    json_obj = []
    for record in user.records:
        json_obj.append({'id': record.id, 'name': record.name, 'category': record.category, 'distance': record.distance,
                         'heartrate': record.heart_rate, 'time': record.time, 'difficulty': record.difficulty,
                         'datetime': record.date_time, 'isfavorite': record.is_favorite})
    return jsonify(json_obj)


@bp.route('/user/set_favorite', methods=['POST'])
@token_auth.login_required
def set_favorite():
    data = request.json
    id = data.id
    value = data.value
    change_favorite(id, value, g.current_user)
    return '', 200
