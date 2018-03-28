
set verbose true;
use jagdb;
db.xaa100m_row.find({uid:  { $lt: '9d%', $gt: '3d'} }).count()

exit;

