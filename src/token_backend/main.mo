import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Debug "mo:base/Debug";

actor Token {
  var owner : Principal = Principal.fromText("ID_TOKEN");
  var totalSupply : Nat = 1000000000;
  var symbol : Text = "PANG";

  // hashmap in Motoku is a hash like object
  var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

  //create a legal
  balances.put(owner, totalSupply);

  public query func balanceOf(who : Principal) : async Nat {

    let balance : Nat = switch (balances.get(who)) {
      case null 0;
      case (?result) result;
    };

    return balance;
  };

  public query func getSymbol() : async Text {
    return symbol;
  };

  public shared (msg) func payOut() : async Text {
    if (balances.get(msg.caller) == null) {
      let amount = 10000;

      balances.put(msg.caller, amount);
      Debug.print(debug_show (msg.caller));
      return "Success";
    } else {
      return "Already claimed token";
    };
  };
};
