; Robot domain from the UCPOP distribution.

(define (domain robot-domain)
  (:requirements :equality :conditional-effects)
  (:constants robot)
  (:predicates (object ?x) (location ?x) (empty-handed) (at ?x ?y)
	       (grasping ?x) (connected ?x ?y))
  (:action pickup
	   :parameters (?x ?loc)
	   :precondition (and (object ?x) (location ?loc)
			      (not (= ?x robot)) (empty-handed) (at ?x ?loc)
			      (at robot ?loc))
	   :effect (and (grasping ?x)
			(not (empty-handed))))
  (:action drop
	   :parameters (?x)
	   :precondition (and (object ?x)
			      (not (= ?x robot)) (grasping ?x))
	   :effect (and (empty-handed)
			(not (grasping ?x))))
  (:action move
	   :parameters (?from ?to)
	   :precondition (and (location ?from) (location ?to)
			      (not (= ?from ?to)) (at robot ?from)
			      (connected ?from ?to))
	   :effect (and (at robot ?to)
			(not (at robot ?from))
			(forall (?x)
				(when (and (grasping ?x) (object ?x))
				  (and (at ?x ?to) (not (at ?x ?from))))))))
