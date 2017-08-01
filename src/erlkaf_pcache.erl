-module(erlkaf_pcache).

-include("erlkaf_private.hrl").

-export([
    new/1,
    free/1,
    enq/5,
    deq/1
]).

new(ClientId) ->
    Path = erlkaf_utils:get_priv_path(ClientId),
    ?INFO_MSG("persistent queue path: ~p", [Path]),
    esq:new([{fspool, Path}, {tts, 0}, {capacity, 0}]).

free(undefined) ->
    ok;
free(Queue) ->
    esq:free(Queue).

enq(Queue, TopicName, Partition, Key, Value) ->
    esq:enq({TopicName, Partition, Key, Value}, Queue).

deq(Queue) ->
    esq:deq(Queue).