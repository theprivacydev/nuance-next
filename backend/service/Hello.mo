import Array "mo:base/Array";
import Bool "mo:base/Bool";
import Buffer "mo:base/Buffer";
import Char "mo:base/Char";
import Debug "mo:base/Debug";
import Error "mo:base/Error";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Int "mo:base/Int";
import Option "mo:base/Option";
import Order "mo:base/Order";
import Prelude "mo:base/Prelude";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Time "mo:base/Time";

actor hello {

  func isEq(x : Text, y : Text) : Bool { x == y };
  var maxHashmapSize = 1000000;
  var hashMap = HashMap.HashMap<Text, [Text]>(maxHashmapSize, isEq, Text.hash);
  stable var nameEntries : [(Text, Text)] = [];
  stable var imgUrlEntries : [(Text, Text)] = [];
  var nameHashMap = HashMap.fromIter<Text, Text>(nameEntries.vals(), maxHashmapSize, isEq, Text.hash);
  var imgUrlHashMap = HashMap.fromIter<Text, Text>(nameEntries.vals(), maxHashmapSize, isEq, Text.hash);

  system func preupgrade() {
    nameEntries := Iter.toArray(nameHashMap.entries());
    imgUrlEntries := Iter.toArray(imgUrlHashMap.entries())
  };

  system func postupgrade() {
    nameEntries := [];
    imgUrlEntries := []
  };

  func safeGet<K, V>(hashMap : HashMap.HashMap<K, V>, key : K, defaultValue : V) : V {
    switch (hashMap.get(key)) {
      case null defaultValue;
      case (?value) value
    }
  };

  stable var nameKey : Nat = 0;

  public func getNameKey() : async Nat {
    return nameKey
  };

  public func resetNameKey() : async () {
    nameKey := 0
  };

  type metaTag = {
    name : ?Text;
    imgUrl : ?Text
  };

  public func addMetaTag(name : Text, imgUrl : Text) : async ({ #ok : Text }) {
    let key = Nat.toText(nameKey);
    let addName = nameHashMap.put(key, name);
    let addImgUrl = imgUrlHashMap.put(key, imgUrl);

    addName;
    addImgUrl;
    nameKey += 1;

    return #ok("added")
  };

  public func getMetaTag(key : Text) : async (metaTag) {

    let name = safeGet(nameHashMap, key, "");
    let imgUrl = safeGet(imgUrlHashMap, key, "");

    return ({
      name = ?name;
      imgUrl = ?imgUrl
    })

  }
}
