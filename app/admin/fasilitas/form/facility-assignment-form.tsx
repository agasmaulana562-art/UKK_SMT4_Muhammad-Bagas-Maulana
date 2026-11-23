'use client'

import { useEffect, useState, type FormEvent } from "react"
import { useRouter } from "next/navigation"
import { ArrowLeft, Save } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Card } from "@/components/ui/card"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"

type Facility = {
  code: string
  name: string
}

type UnitType = {
  id: number
  name: string
  branchId: number
}

type AssignmentsResponse = {
  unitTypes: UnitType[]
  selectedUnitTypeId: number | null
  facilityCodes: string[]
}

type FacilityAssignmentFormProps = {
  initialUnitTypeId?: string
}

export function FacilityAssignmentForm({ initialUnitTypeId }: FacilityAssignmentFormProps) {
  const router = useRouter()
  const [facilities, setFacilities] = useState<Facility[]>([])
  const [unitTypes, setUnitTypes] = useState<UnitType[]>([])
  const [unitTypeId, setUnitTypeId] = useState<number | null>(null)
  const [selectedCodes, setSelectedCodes] = useState<string[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [isSaving, setIsSaving] = useState(false)
  const [error, setError] = useState("")
  const [notice, setNotice] = useState("")

  useEffect(() => {
    let isActive = true

    async function loadFormData() {
      try {
        const [facilityResponse, assignmentResponse] = await Promise.all([
          fetch("/api/facilities"),
          fetch(
            initialUnitTypeId
              ? `/api/facilities/assignments?unitTypeId=${encodeURIComponent(initialUnitTypeId)}`
              : "/api/facilities/assignments",
          ),
        ])
        const [facilityResult, assignmentResult] = await Promise.all([
          facilityResponse.json(),
          assignmentResponse.json(),
        ])
        if (!facilityResponse.ok) {
          throw new Error(facilityResult.error ?? "Gagal memuat data fasilitas.")
        }
        if (!assignmentResponse.ok) {
          throw new Error(assignmentResult.error ?? "Gagal memuat tipe unit.")
        }

        if (isActive) {
          const assignments = assignmentResult as AssignmentsResponse
          setFacilities(facilityResult.facilities)
          setUnitTypes(assignments.unitTypes)
          setUnitTypeId(assignments.selectedUnitTypeId)
          setSelectedCodes(assignments.facilityCodes)
        }
      } catch (loadError) {
        if (isActive) {
          setError(loadError instanceof Error ? loadError.message : "Gagal memuat pengaturan fasilitas.")
        }
      } finally {
        if (isActive) setIsLoading(false)
      }
    }

    void loadFormData()
    return () => {
      isActive = false
    }
  }, [initialUnitTypeId])

  async function changeUnitType(nextUnitTypeId: number) {
    setError("")
    setNotice("")
    setIsLoading(true)
    try {
      const response = await fetch(`/api/facilities/assignments?unitTypeId=${nextUnitTypeId}`)
      const result = await response.json()
      if (!response.ok) throw new Error(result.error ?? "Gagal memuat pengaturan fasilitas.")
      setUnitTypeId(nextUnitTypeId)
      setSelectedCodes((result as AssignmentsResponse).facilityCodes)
    } catch (loadError) {
      setError(loadError instanceof Error ? loadError.message : "Gagal memuat pengaturan fasilitas.")
    } finally {
      setIsLoading(false)
    }
  }

  function toggleFacility(code: string) {
    setNotice("")
    setSelectedCodes((currentCodes) => currentCodes.includes(code)
      ? currentCodes.filter((currentCode) => currentCode !== code)
      : [...currentCodes, code])
  }

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    if (unitTypeId === null) return

    setIsSaving(true)
    setError("")
    setNotice("")
    try {
      const response = await fetch("/api/facilities/assignments", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ unitTypeId, facilityCodes: selectedCodes }),
      })
      const result = await response.json()
      if (!response.ok) throw new Error(result.error ?? "Gagal menyimpan pengaturan fasilitas.")
      setNotice("Pengaturan fasilitas berhasil disimpan.")
    } catch (saveError) {
      setError(saveError instanceof Error ? saveError.message : "Gagal menyimpan pengaturan fasilitas.")
    } finally {
      setIsSaving(false)
    }
  }

  const selectedUnitType = unitTypes.find((unitType) => unitType.id === unitTypeId)

  return (
    <Card className="m-6 p-6">
      <div className="flex flex-wrap items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold">
            Atur Fasilitas{selectedUnitType ? `: ${selectedUnitType.name}` : ""}
          </h1>
          {selectedUnitType && (
            <p className="text-sm text-muted-foreground">
              Branch {selectedUnitType.branchId} • {selectedCodes.length} dari {facilities.length} fasilitas dipilih
            </p>
          )}
        </div>
        <Button type="button" variant="outline" onClick={() => router.push("/admin/fasilitas")}>
          <ArrowLeft aria-hidden="true" />
          Kembali
        </Button>
      </div>

      {error && <p role="alert" className="mt-4 text-sm text-destructive">{error}</p>}
      {notice && <p role="status" className="mt-4 text-sm text-green-700">{notice}</p>}

      {isLoading && unitTypes.length === 0 ? (
        <p className="mt-5 text-sm text-muted-foreground">Memuat pengaturan fasilitas...</p>
      ) : unitTypes.length === 0 ? (
        <p className="mt-5 text-sm text-muted-foreground">Belum ada tipe unit untuk diatur.</p>
      ) : (
        <form onSubmit={handleSubmit} className="mt-5">
          <div className="mb-4 grid max-w-sm gap-1.5">
            <label htmlFor="unit-type" className="text-sm font-medium">Tipe unit</label>
            <select
              id="unit-type"
              value={unitTypeId ?? ""}
              onChange={(event) => void changeUnitType(Number(event.target.value))}
              disabled={isLoading || isSaving}
              className="h-9 rounded-md border border-input bg-background px-3 text-sm"
            >
              {unitTypes.map((unitType) => (
                <option key={unitType.id} value={unitType.id}>
                  {unitType.name} — Branch {unitType.branchId}
                </option>
              ))}
            </select>
          </div>

          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-12">Pilih</TableHead>
                <TableHead>Kode Facility</TableHead>
                <TableHead>Nama Facility</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {facilities.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={3} className="text-center">Belum ada data fasilitas.</TableCell>
                </TableRow>
              ) : facilities.map((facility) => (
                <TableRow key={facility.code}>
                  <TableCell>
                    <input
                      type="checkbox"
                      aria-label={`Pilih ${facility.name}`}
                      checked={selectedCodes.includes(facility.code)}
                      onChange={() => toggleFacility(facility.code)}
                      disabled={isLoading || isSaving}
                      className="size-4 accent-primary"
                    />
                  </TableCell>
                  <TableCell className="font-mono">{facility.code}</TableCell>
                  <TableCell>{facility.name}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>

          <div className="mt-4 flex justify-end">
            <Button type="submit" disabled={unitTypeId === null || isLoading || isSaving}>
              <Save aria-hidden="true" />
              {isSaving ? "Menyimpan..." : "Simpan pengaturan"}
            </Button>
          </div>
        </form>
      )}
    </Card>
  )
}
