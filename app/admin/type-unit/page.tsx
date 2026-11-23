'use client'

import { useEffect, useState, type FormEvent } from "react"
import Link from "next/link"
import { ClipboardCheck, Pencil, Plus, Save, Trash2, X } from "lucide-react"
import { Button, buttonVariants } from "@/components/ui/button"
import { Card } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"

type UnitType = {
  id: number
  name: string
  branchId: number
  facilityCount: number
}

export default function TypeUnitManagementPage() {
  const [unitTypes, setUnitTypes] = useState<UnitType[]>([])
  const [name, setName] = useState("")
  const [branchId, setBranchId] = useState(1)
  const [editingId, setEditingId] = useState<number | null>(null)
  const [isLoading, setIsLoading] = useState(true)
  const [isSaving, setIsSaving] = useState(false)
  const [deletingId, setDeletingId] = useState<number | null>(null)
  const [error, setError] = useState("")
  const [notice, setNotice] = useState("")

  useEffect(() => {
    let isActive = true

    async function loadUnitTypes() {
      try {
        const response = await fetch("/api/unit-types")
        const result = await response.json()
        if (!response.ok) throw new Error(result.error ?? "Gagal memuat data type unit.")
        if (isActive) setUnitTypes(result.unitTypes)
      } catch (loadError) {
        if (isActive) {
          setError(loadError instanceof Error ? loadError.message : "Gagal memuat data type unit.")
        }
      } finally {
        if (isActive) setIsLoading(false)
      }
    }

    void loadUnitTypes()
    return () => {
      isActive = false
    }
  }, [])

  function resetForm() {
    setName("")
    setBranchId(1)
    setEditingId(null)
    setError("")
  }

  function editUnitType(unitType: UnitType) {
    setName(unitType.name)
    setBranchId(unitType.branchId)
    setEditingId(unitType.id)
    setError("")
    setNotice("")
  }

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setIsSaving(true)
    setError("")
    setNotice("")

    try {
      const response = await fetch(
        editingId ? `/api/unit-types/${editingId}` : "/api/unit-types",
        {
          method: editingId ? "PATCH" : "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ name: name.trim(), branchId }),
        },
      )
      const result = await response.json()
      if (!response.ok) throw new Error(result.error ?? "Gagal menyimpan type unit.")

      setUnitTypes((current) => {
        const updated = current.filter((unitType) => unitType.id !== result.unitType.id)
        updated.push(result.unitType)
        return updated.sort((first, second) => first.id - second.id)
      })
      setNotice(editingId ? "Type unit berhasil diperbarui." : "Type unit berhasil ditambahkan.")
      resetForm()
    } catch (saveError) {
      setError(saveError instanceof Error ? saveError.message : "Gagal menyimpan type unit.")
    } finally {
      setIsSaving(false)
    }
  }

  async function deleteUnitType(unitType: UnitType) {
    if (!window.confirm(
      `Hapus ${unitType.name} - Branch ${unitType.branchId}? Semua pengaturan fasilitas untuk tipe ini juga akan dihapus.`
    )) {
      return
    }

    setDeletingId(unitType.id)
    setError("")
    setNotice("")
    try {
      const response = await fetch(`/api/unit-types/${unitType.id}`, { method: "DELETE" })
      const result = await response.json()
      if (!response.ok) throw new Error(result.error ?? "Gagal menghapus type unit.")
      setUnitTypes((current) => current.filter((item) => item.id !== unitType.id))
      if (editingId === unitType.id) resetForm()
      setNotice("Type unit berhasil dihapus.")
    } catch (deleteError) {
      setError(deleteError instanceof Error ? deleteError.message : "Gagal menghapus type unit.")
    } finally {
      setDeletingId(null)
    }
  }

  return (
    <Card className="m-6 p-6">
      <div>
        <h1 className="text-2xl font-bold">Type Unit Management</h1>
        <p className="text-sm text-muted-foreground">
          Klik Atur Fasilitas untuk mengelola daftar fasilitas tiap tipe unit.
        </p>
      </div>

      <form onSubmit={handleSubmit} className="mt-5 flex flex-wrap items-center gap-2">
        <Input
          aria-label="Nama type unit"
          value={name}
          onChange={(event) => setName(event.target.value)}
          placeholder="Nama type unit (contoh: Penthouse)"
          required
          maxLength={191}
          disabled={isSaving}
          className="max-w-sm"
        />
        <select
          aria-label="Branch"
          value={branchId}
          onChange={(event) => setBranchId(Number(event.target.value))}
          disabled={isSaving}
          className="h-9 rounded-md border border-input bg-background px-3 text-sm"
        >
          <option value={1}>Branch 1</option>
          <option value={2}>Branch 2</option>
        </select>
        <Button type="submit" disabled={isSaving}>
          {editingId ? <Save aria-hidden="true" /> : <Plus aria-hidden="true" />}
          {isSaving ? "Menyimpan..." : editingId ? "Simpan Perubahan" : "Tambah Type Unit"}
        </Button>
        {editingId && (
          <Button type="button" variant="outline" onClick={resetForm} disabled={isSaving}>
            <X aria-hidden="true" />
            Batal
          </Button>
        )}
      </form>

      {error && <p role="alert" className="mt-4 text-sm text-destructive">{error}</p>}
      {notice && <p role="status" className="mt-4 text-sm text-green-700">{notice}</p>}

      <Table className="mt-5">
        <TableHeader>
          <TableRow>
            <TableHead>No</TableHead>
            <TableHead>Nama Type Unit</TableHead>
            <TableHead>Branch</TableHead>
            <TableHead>Fasilitas Terpasang</TableHead>
            <TableHead className="text-right">Aksi</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {isLoading ? (
            <TableRow>
              <TableCell colSpan={5} className="text-center">Memuat type unit...</TableCell>
            </TableRow>
          ) : unitTypes.length === 0 ? (
            <TableRow>
              <TableCell colSpan={5} className="text-center">Belum ada data type unit.</TableCell>
            </TableRow>
          ) : unitTypes.map((unitType, index) => (
            <TableRow key={unitType.id}>
              <TableCell>{index + 1}</TableCell>
              <TableCell className="font-medium">{unitType.name}</TableCell>
              <TableCell>Branch {unitType.branchId}</TableCell>
              <TableCell>
                <span className="rounded-full bg-muted px-2 py-1 text-xs">
                  {unitType.facilityCount} fasilitas
                </span>
              </TableCell>
              <TableCell className="text-right">
                <div className="flex justify-end gap-2">
                  <Link
                    href={`/admin/fasilitas/form?unitTypeId=${unitType.id}`}
                    className={buttonVariants({ variant: "outline", size: "sm" })}
                  >
                    <ClipboardCheck aria-hidden="true" />
                    Atur Fasilitas
                  </Link>
                  <Button
                    type="button"
                    size="icon"
                    variant="outline"
                    aria-label={`Edit ${unitType.name}`}
                    onClick={() => editUnitType(unitType)}
                  >
                    <Pencil aria-hidden="true" />
                  </Button>
                  <Button
                    type="button"
                    size="icon"
                    variant="destructive"
                    aria-label={`Hapus ${unitType.name}`}
                    disabled={deletingId === unitType.id}
                    onClick={() => void deleteUnitType(unitType)}
                  >
                    <Trash2 aria-hidden="true" />
                  </Button>
                </div>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </Card>
  )
}
