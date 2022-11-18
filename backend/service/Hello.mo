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
  stable var nameKey : Nat = 0;
  stable var nameEntries : [(Text, Text)] = [];
  var nameHashMap = HashMap.fromIter<Text, Text>(nameEntries.vals(), maxHashmapSize, isEq, Text.hash);

  public func addName(name : Text) : async () {
    nameKey := nameKey + 1;
    let key = Nat.toText(nameKey);
    nameHashMap.put((key, name))
  };

  public func greet(name : Text) : async ({ #ok : Text }) {

    let storename = addName(name);
    await storename;

    return #ok("Hello, " # name # "!");

  };

  public func getName(key : Text) : async ({ #ok : Text }) {
    let name = nameHashMap.get(key);
    switch name {
      case null { return #ok("No name found") };
      case (?name) { return #ok(name) }
    }
  };

}
