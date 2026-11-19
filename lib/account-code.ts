type AccountCodeUser = {
  id: number
  role: string
}

const accountRoles = ["admin", "staff"] as const

function getRolePrefix(role: string) {
  const normalizedRole = role.toLowerCase()
  return normalizedRole === "admin"
    ? "ADM"
    : normalizedRole === "user"
      ? "USR"
      : normalizedRole.toUpperCase().slice(0, 3)
}

export function formatAccountCode(role: string, number: number) {
  return `${getRolePrefix(role)}${String(number).padStart(7, "0")}`
}

export function getAccountCodesForUser(users: AccountCodeUser[], userId: number) {
  const roleCounts = new Map<string, number>()

  for (const user of users) {
    if (user.id === userId) {
      return Object.fromEntries(
        accountRoles.map((role) => [
          role,
          formatAccountCode(role, (roleCounts.get(role) ?? 0) + 1),
        ]),
      )
    }

    const role = user.role.toLowerCase()
    roleCounts.set(role, (roleCounts.get(role) ?? 0) + 1)
  }

  throw new Error(`Account code position missing for user ${userId}.`)
}
