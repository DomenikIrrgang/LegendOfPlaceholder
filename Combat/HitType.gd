extends Node

const MISSED = "MISSED"
const DODGED = "DODGED"
const PARRIED = "PARRIED"
const LANDED = "LANDED"
const CRITICAL = "CRITICAL"
const NO_RESOURCE = "NO_RESOURCE"
const TARGET_DEAD = "TARGET_DEAD"
const IMMUNE = "IMMUNE"

static func to_array():
	return [
		MISSED,
		DODGED,
		PARRIED,
		LANDED,
		CRITICAL,
		NO_RESOURCE,
		TARGET_DEAD,
		IMMUNE,
	]
