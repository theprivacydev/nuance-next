import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Trie "mo:base/Trie";
import Text "mo:base/Text";

import ImageType "../model/ImageType";
import ImageStoreHelper "../helper/ImageStoreHelper";
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

import Int "mo:base/Int";
import Option "mo:base/Option";
import Order "mo:base/Order";
import Prelude "mo:base/Prelude";
import Principal "mo:base/Principal";
import Result "mo:base/Result";

import Time "mo:base/Time";

actor ImageBucket {

  type ImageId = ImageType.ImageId;
  type ImageObject = ImageType.ImageObject;

  stable var imageObjectStore : Trie.Trie<ImageId, ImageObject> = Trie.empty();

  // atomic, no await allowed
  public func create(image : ImageObject) : async ImageId {
    let imageId = ImageType.generateNewRemoteObjectId();
    imageObjectStore := ImageStoreHelper.addNewImage(imageObjectStore, image, imageId);

    return imageId
  };

  public query func getImageById(id : ImageId) : async ?ImageObject {
    return ImageStoreHelper.getImageById(id, imageObjectStore)
  };

  // atomic, no await allowed
  public func delete(id : ImageId) : async () {
    imageObjectStore := ImageStoreHelper.removeImage(imageObjectStore, id)
  };

}
