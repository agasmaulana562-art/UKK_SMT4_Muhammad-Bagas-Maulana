import { NextResponse } from "next/server"
import { getAuthenticatedUser } from "@/lib/auth"
import { prisma } from "@/lib/prisma"

type RouteContext = { params: Promise<{ id: string }> }

async function getAuthorizationError() {
  const user = await getAuthenticatedUser()
  if (!user) {
    return NextResponse.json({ error: "Silakan login untuk melanjutkan." }, { status: 401 })
  }
  return null
}

async function getUnitTypeId(context: RouteContext) {
  const { id } = await context.params
  const unitTypeId = Number(id)
  return Number.isSafeInteger(unitTypeId) && unitTypeId > 0 ? unitTypeId : null
}

function isMissingUnitType(error: unknown) {
  return typeof error === "object" && error !== null && "code" in error && error.code === "P2025"
}

export async function PATCH(request: Request, context: RouteContext) {
  const authorizationError = await getAuthorizationError()
  if (authorizationError) return authorizationError

  const id = await getUnitTypeId(context)
  if (!id) return NextResponse.json({ error: "ID type unit tidak valid." }, { status: 400 })

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
    const unitType = await prisma.unitType.update({
      where: { id },
      data: { name, branchId },
      select: { id: true, name: true, branchId: true },
    })
    const facilityCount = await prisma.unitTypeFacility.count({ where: { unitTypeId: id } })
    return NextResponse.json({ unitType: { ...unitType, facilityCount } })
  } catch (error) {
    if (isMissingUnitType(error)) {
      return NextResponse.json({ error: "Type unit tidak ditemukan." }, { status: 404 })
    }
    console.error("Failed to update unit type:", error)
    return NextResponse.json({ error: "Gagal memperbarui type unit." }, { status: 500 })
  }
}

export async function DELETE(_request: Request, context: RouteContext) {
  const authorizationError = await getAuthorizationError()
  if (authorizationError) return authorizationError

  const id = await getUnitTypeId(context)
  if (!id) return NextResponse.json({ error: "ID type unit tidak valid." }, { status: 400 })

  try {
    await prisma.unitType.delete({ where: { id } })
    return NextResponse.json({ success: true })
  } catch (error) {
    if (isMissingUnitType(error)) {
      return NextResponse.json({ error: "Type unit tidak ditemukan." }, { status: 404 })
    }
    console.error("Failed to delete unit type:", error)
    return NextResponse.json({ error: "Gagal menghapus type unit." }, { status: 500 })
  }
}
