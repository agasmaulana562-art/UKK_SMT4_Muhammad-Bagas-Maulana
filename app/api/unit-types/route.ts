import { NextResponse } from "next/server"
import { getAuthenticatedUser } from "@/lib/auth"
import { prisma } from "@/lib/prisma"

async function getAuthorizationError() {
  const user = await getAuthenticatedUser()
  if (!user) {
    return NextResponse.json({ error: "Silakan login untuk melanjutkan." }, { status: 401 })
  }
  return null
}

function isDuplicateUnitType(error: unknown) {
  return typeof error === "object" && error !== null && "code" in error && error.code === "P2002"
}

export async function GET() {
  const authorizationError = await getAuthorizationError()
  if (authorizationError) return authorizationError

  try {
    const unitTypes = await prisma.unitType.findMany({
      orderBy: { id: "asc" },
      select: {
        id: true,
        name: true,
        branchId: true,
        _count: { select: { facilityAssignments: true } },
      },
    })
    return NextResponse.json({
      unitTypes: unitTypes.map(({ _count, ...unitType }) => ({
        ...unitType,
        facilityCount: _count.facilityAssignments,
      })),
    })
  } catch (error) {
    console.error("Failed to fetch unit types:", error)
    return NextResponse.json({ error: "Gagal memuat data type unit." }, { status: 500 })
  }
}

export async function POST(request: Request) {
  const authorizationError = await getAuthorizationError()
  if (authorizationError) return authorizationError

  let body: Record<string, unknown>
  try {
    const parsedBody: unknown = await request.json()
    if (!parsedBody || typeof parsedBody !== "object" || Array.isArray(parsedBody)) {
      return NextResponse.json({ error: "Format request tidak valid." }, { status: 400 })
    }
    body = parsedBody as Record<string, unknown>
  } catch {
    return NextResponse.json({ error: "Format request tidak valid." }, { status: 400 })
  }

  const name = typeof body.name === "string" ? body.name.trim() : ""
  const branchId = body.branchId
  if (!name || name.length > 191) {
    return NextResponse.json({ error: "Nama type unit wajib diisi (maksimal 191 karakter)." }, { status: 400 })
  }
  if (typeof branchId !== "number" || !Number.isSafeInteger(branchId) || branchId < 1) {
    return NextResponse.json({ error: "Branch tidak valid." }, { status: 400 })
  }

  try {
    const unitType = await prisma.unitType.create({
      data: { name, branchId },
      select: { id: true, name: true, branchId: true },
    })
    return NextResponse.json({ unitType: { ...unitType, facilityCount: 0 } }, { status: 201 })
  } catch (error) {
    if (isDuplicateUnitType(error)) {
      return NextResponse.json({ error: "Type unit sudah ada." }, { status: 409 })
    }
    console.error("Failed to create unit type:", error)
    return NextResponse.json({ error: "Gagal menambahkan type unit." }, { status: 500 })
  }
}
