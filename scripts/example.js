// Generated by CoffeeScript 1.12.5
module.exports = function(robot) {
  var getKakei, key_kurasu;
  key_kurasu = 'kurasu';
  robot.hear(/くらす(.*)/i, function(res) {
    var kurasu, spendMoney;
    spendMoney = res.match[1];
    kurasu = parseInt(getKakei(key_kurasu), 10) - parseInt(spendMoney, 10);
    robot.brain.set(key_kurasu, kurasu);
    return res.send("「くらす」に" + spendMoney + "円を使いました。\n--残高---------------------\n「くらす」は" + kurasu + "です。\n--------------------------");
  });
  robot.hear(/clear/i, function(res) {
    var kurasu;
    robot.brain.set(key_kurasu, 0);
    robot.brain.set(key_taberu, 0);
    robot.brain.set(key_others, 0);
    kurasu = parseInt(getKakei(key_kurasu), 10);
    return res.send("「くらす」は" + kurasu + "です。");
  });
  robot.hear(/set(.*)/i, function(res) {
    var kurasu;
    robot.brain.set(key_kurasu, res.match[1]);
    kurasu = parseInt(getKakei(key_kurasu), 10);
    return res.send("予算設定しました！\n「くらす」は" + kurasu + "です。");
  });
  return getKakei = function(key) {
    var ref;
    return (ref = robot.brain.get(key)) != null ? ref : [];
  };
};