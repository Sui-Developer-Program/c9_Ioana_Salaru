/*
/// Module: tip_jar
/// */
module tip_jar::tip_jar;


// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

//declaram modul

use sui::coin::Coin;
use sui::sui::SUI;


//declaram structura TipJar
public struct TipJar has key{
    id:UID,
    no_of_tips: u64,
    total_amount: u64,
    owner: address,
}

// creaza un obeict TipJar si il transfera ca shared object 
fun init(ctx: &mut TxContext){
    let tip_jar = TipJar{
        id:object::new(ctx),
        no_of_tips: 0,
        total_amount: 0,
        owner: ctx.sender(),
    };

    sui::transfer::share_object(tip_jar);
}


public fun tip(tip_jar: &mut TipJar, payment: Coin<SUI>){
    tip_jar.no_of_tips = tip_jar.no_of_tips + 1;
    tip_jar.total_amount = tip_jar.total_amount + payment.balance().value();

    sui::transfer::public_transfer(payment, tip_jar.owner);
}

// pe maine: https://faucet.sui.io/  - ne logam si dam ceva pe un buton
