import { NextResponse } from "next/server"
import { getAuthenticatedUser } from "@/lib/auth"
import { prisma } from "@/lib/prisma"

const facilityFields = {
  code: true,
  name: true,
  createdAt: true,
  updatedAt: true,
} as const

async function getAuthorizationError() {
  const user = await getAuthenticatedUser()
  if (!user) {
    return NextResponse.json({ error: "Silakan login untuk melanjutkan." }, { status: 401 })
  }
  return null
}

function isDuplicateFacility(error: unknown) {
  return typeof error === "object" && error !== null && "code" in error && error.code === "P2002"
}

export async function GET() {
  const authorizationError = await getAuthorizationError()
  if (authorizationError) return authorizationError

  try {
    const facilities = await prisma.facility.findMany({
      orderBy: { code: "asc" },
      select: facilityFields,
    })
    return NextResponse.json({ facilities })
  } catch (error) {
    console.error("Failed to fetch facilities:", error)
    return NextResponse.json({ error: "Gagal memuat data fasilitas." }, { status: 500 })
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

  const code = typeof body.code === "string" ? body.code.trim().toUpperCase() : ""
  const name = typeof body.name === "string" ? body.name.trim() : ""
  if (!/^[A-Z0-9_-]{1,20}$/.test(code)) {
    return NextResponse.json({ error: "Kode fasilitas wajib diisi (maksimal 20 karakter)." }, { status: 400 })
  }
  if (!name || name.length > 191) {
    return NextResponse.json({ error: "Nama fasilitas wajib diisi (maksimal 191 karakter)." }, { status: 400 })
  }

  try {
    const facility = await prisma.facility.create({
      data: { code, name },
      select: facilityFields,
    })
    return NextResponse.json({ facility }, { status: 201 })
  } catch (error) {
    if (isDuplicateFacility(error)) {
      return NextResponse.json({ error: "Kode fasilitas sudah digunakan." }, { status: 409 })
    }
    console.error("Failed to create facility:", error)
    return NextResponse.json({ error: "Gagal membuat data fasilitas." }, { status: 500 })
  }
}
