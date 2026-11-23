import { NextResponse } from "next/server"
import { getAuthenticatedUser } from "@/lib/auth"
import { prisma } from "@/lib/prisma"

const facilityFields = {
  code: true,
  name: true,
  createdAt: true,
  updatedAt: true,
} as const

type RouteContext = { params: Promise<{ code: string }> }

async function getAuthorizationError() {
  const user = await getAuthenticatedUser()
  if (!user) {
    return NextResponse.json({ error: "Silakan login untuk melanjutkan." }, { status: 401 })
  }
  return null
}

async function getFacilityCode(context: RouteContext) {
  const { code: rawCode } = await context.params
  const code = rawCode.trim().toUpperCase()
  return /^[A-Z0-9_-]{1,20}$/.test(code) ? code : null
}

function isMissingFacility(error: unknown) {
  return typeof error === "object" && error !== null && "code" in error && error.code === "P2025"
}

function isDuplicateFacility(error: unknown) {
  return typeof error === "object" && error !== null && "code" in error && error.code === "P2002"
}

export async function GET(_request: Request, context: RouteContext) {
  const authorizationError = await getAuthorizationError()
  if (authorizationError) return authorizationError

  const code = await getFacilityCode(context)
  if (!code) return NextResponse.json({ error: "Kode fasilitas tidak valid." }, { status: 400 })

  try {
    const facility = await prisma.facility.findUnique({
      where: { code },
      select: facilityFields,
    })
    if (!facility) return NextResponse.json({ error: "Fasilitas tidak ditemukan." }, { status: 404 })
    return NextResponse.json({ facility })
  } catch (error) {
    console.error("Failed to fetch facility:", error)
    return NextResponse.json({ error: "Gagal memuat data fasilitas." }, { status: 500 })
  }
}

export async function PATCH(request: Request, context: RouteContext) {
  const authorizationError = await getAuthorizationError()
  if (authorizationError) return authorizationError

  const currentCode = await getFacilityCode(context)
  if (!currentCode) return NextResponse.json({ error: "Kode fasilitas tidak valid." }, { status: 400 })

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

  const code = typeof body.code === "string" ? body.code.trim().toUpperCase() : ""
  const name = typeof body.name === "string" ? body.name.trim() : ""
  if (!/^[A-Z0-9_-]{1,20}$/.test(code)) {
    return NextResponse.json({ error: "Kode fasilitas wajib diisi (maksimal 20 karakter)." }, { status: 400 })
  }
  if (!name || name.length > 191) {
    return NextResponse.json({ error: "Nama fasilitas wajib diisi (maksimal 191 karakter)." }, { status: 400 })
  }

  try {
    const facility = await prisma.facility.update({
      where: { code: currentCode },
      data: { code, name },
      select: facilityFields,
    })
    return NextResponse.json({ facility })
  } catch (error) {
    if (isMissingFacility(error)) {
      return NextResponse.json({ error: "Fasilitas tidak ditemukan." }, { status: 404 })
    }
    if (isDuplicateFacility(error)) {
      return NextResponse.json({ error: "Kode fasilitas sudah digunakan." }, { status: 409 })
    }
    console.error("Failed to update facility:", error)
    return NextResponse.json({ error: "Gagal memperbarui data fasilitas." }, { status: 500 })
  }
}

export async function DELETE(_request: Request, context: RouteContext) {
  const authorizationError = await getAuthorizationError()
  if (authorizationError) return authorizationError

  const code = await getFacilityCode(context)
  if (!code) return NextResponse.json({ error: "Kode fasilitas tidak valid." }, { status: 400 })

  try {
    await prisma.facility.delete({ where: { code } })
    return NextResponse.json({ success: true })
  } catch (error) {
    if (isMissingFacility(error)) {
      return NextResponse.json({ error: "Fasilitas tidak ditemukan." }, { status: 404 })
    }
    console.error("Failed to delete facility:", error)
    return NextResponse.json({ error: "Gagal menghapus data fasilitas." }, { status: 500 })
  }
}
