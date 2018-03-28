
set verbose true;
use jagdb;

# db.xaa100m_row.find({uid:  { $lt: '9d%', $gt: '3d'} }).count()  # 4 sec
# db.xaa100m_row.find({uid:  { $gt: 'd%'} }).count()   # 30 sec
db.xaa100m_row.find({uid:  { $lt: '9d%'} }).count()  # 5 sec

db.xaa100m_row.find({uid:  { $lt: 'd%'} }).count()

exit;

