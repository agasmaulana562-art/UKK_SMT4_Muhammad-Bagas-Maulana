import { NextResponse } from "next/server"
import { getAuthenticatedUser } from "@/lib/auth"
import { prisma } from "@/lib/prisma"

function isFacilityCodeList(value: unknown): value is string[] {
  return Array.isArray(value)
    && value.every((code: unknown) => typeof code === "string" && code.trim() === code)
    && new Set(value).size === value.length
}

async function getAuthorizationError() {
  const user = await getAuthenticatedUser()
  if (!user) {
    return NextResponse.json({ error: "Silakan login untuk melanjutkan." }, { status: 401 })
  }
  return null
}

export async function GET(request: Request) {
  const authorizationError = await getAuthorizationError()
  if (authorizationError) return authorizationError

  const requestedId = new URL(request.url).searchParams.get("unitTypeId")
  const parsedId = requestedId === null ? null : Number(requestedId)
  if (requestedId !== null && (!Number.isSafeInteger(parsedId) || (parsedId ?? 0) < 1)) {
    return NextResponse.json({ error: "ID tipe unit tidak valid." }, { status: 400 })
  }

  try {
    const unitTypes = await prisma.unitType.findMany({
      orderBy: { id: "asc" },
      select: { id: true, name: true, branchId: true },
    })
    const selectedUnitTypeId = parsedId ?? unitTypes[0]?.id ?? null
    if (selectedUnitTypeId === null) {
      return NextResponse.json({ unitTypes, selectedUnitTypeId: null, facilityCodes: [] })
    }

    const unitType = await prisma.unitType.findUnique({
      where: { id: selectedUnitTypeId },
      select: {
        facilityAssignments: {
          select: { facilityCode: true },
          orderBy: { facilityCode: "asc" },
        },
      },
    })
    if (!unitType) {
      return NextResponse.json({ error: "Tipe unit tidak ditemukan." }, { status: 404 })
    }

    return NextResponse.json({
      unitTypes,
      selectedUnitTypeId,
      facilityCodes: unitType.facilityAssignments.map((assignment) => assignment.facilityCode),
    })
  } catch (error) {
    console.error("Failed to fetch facility assignments:", error)
    return NextResponse.json({ error: "Gagal memuat pengaturan fasilitas." }, { status: 500 })
  }
}

export async function PUT(request: Request) {
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

  const unitTypeId = body.unitTypeId
  const facilityCodes = body.facilityCodes
  if (typeof unitTypeId !== "number" || !Number.isSafeInteger(unitTypeId) || unitTypeId < 1) {
    return NextResponse.json({ error: "ID tipe unit tidak valid." }, { status: 400 })
  }
  if (!isFacilityCodeList(facilityCodes)) {
    return NextResponse.json({ error: "Daftar fasilitas tidak valid." }, { status: 400 })
  }

  try {
    const unitType = await prisma.unitType.findUnique({
      where: { id: unitTypeId },
      select: { id: true },
    })
    if (!unitType) {
      return NextResponse.json({ error: "Tipe unit tidak ditemukan." }, { status: 404 })
    }

    const facilities = await prisma.facility.findMany({
      where: { code: { in: facilityCodes } },
      select: { code: true },
    })
    if (facilities.length !== facilityCodes.length) {
      return NextResponse.json({ error: "Terdapat kode fasilitas yang tidak ditemukan." }, { status: 400 })
    }

    await prisma.unitType.update({
      where: { id: unitType.id },
      data: {
        facilityAssignments: {
          deleteMany: {},
          create: facilityCodes.map((code) => ({
            facility: { connect: { code } },
          })),
        },
      },
    })

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error("Failed to update facility assignments:", error)
    return NextResponse.json({ error: "Gagal menyimpan pengaturan fasilitas." }, { status: 500 })
  }
}
