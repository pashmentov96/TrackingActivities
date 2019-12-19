"""favorite activities

Revision ID: cee63128f62b
Revises: ebf266cd6946
Create Date: 2019-12-19 08:49:06.436380

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'cee63128f62b'
down_revision = 'ebf266cd6946'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('activity_record', sa.Column('is_favorite', sa.Boolean(), nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('activity_record', 'is_favorite')
    # ### end Alembic commands ###