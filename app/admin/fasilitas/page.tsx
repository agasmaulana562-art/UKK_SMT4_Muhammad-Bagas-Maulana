'use client'

import { useEffect, useState, type FormEvent } from "react"
import Link from "next/link"
import { Pencil, Plus, Save, Trash2, X } from "lucide-react"
import { Button, buttonVariants } from "@/components/ui/button"
import { Card } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"

type Facility = {
  code: string
  name: string
  createdAt: string
  updatedAt: string
}

export default function FacilityManagementPage() {
  const [facilities, setFacilities] = useState<Facility[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const [isSaving, setIsSaving] = useState(false)
  const [deletingCode, setDeletingCode] = useState<string | null>(null)
  const [editingCode, setEditingCode] = useState<string | null>(null)
  const [isFormOpen, setIsFormOpen] = useState(false)
  const [code, setCode] = useState("")
  const [name, setName] = useState("")
  const [error, setError] = useState("")
  const [notice, setNotice] = useState("")

  useEffect(() => {
    let isActive = true

    async function loadFacilities() {
      try {
        const response = await fetch("/api/facilities")
        const result = await response.json()
        if (!response.ok) throw new Error(result.error ?? "Gagal memuat data fasilitas.")
        if (isActive) setFacilities(result.facilities)
      } catch (loadError) {
        if (isActive) {
          setError(loadError instanceof Error ? loadError.message : "Gagal memuat data fasilitas.")
        }
      } finally {
        if (isActive) setIsLoading(false)
      }
    }

    void loadFacilities()
    return () => {
      isActive = false
    }
  }, [])

  function openCreateForm() {
    setEditingCode(null)
    setCode("")
    setName("")
    setError("")
    setNotice("")
    setIsFormOpen(true)
  }

  function openEditForm(facility: Facility) {
    setEditingCode(facility.code)
    setCode(facility.code)
    setName(facility.name)
    setError("")
    setNotice("")
    setIsFormOpen(true)
  }

  function closeForm() {
    setIsFormOpen(false)
    setEditingCode(null)
    setError("")
  }

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setIsSaving(true)
    setError("")
    setNotice("")

    try {
      const response = await fetch(
        editingCode ? `/api/facilities/${encodeURIComponent(editingCode)}` : "/api/facilities",
        {
          method: editingCode ? "PATCH" : "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ code: code.trim(), name: name.trim() }),
        },
      )
      const result = await response.json()
      if (!response.ok) throw new Error(result.error ?? "Gagal menyimpan fasilitas.")

      setFacilities((currentFacilities) => [
        ...currentFacilities.filter((facility) => facility.code !== editingCode && facility.code !== result.facility.code),
        result.facility,
      ].sort((first, second) => first.code.localeCompare(second.code)))
      setIsFormOpen(false)
      setEditingCode(null)
      setNotice(editingCode ? "Fasilitas berhasil diperbarui." : "Fasilitas berhasil ditambahkan.")
    } catch (saveError) {
      setError(saveError instanceof Error ? saveError.message : "Gagal menyimpan fasilitas.")
    } finally {
      setIsSaving(false)
    }
  }

  async function deleteFacility(facility: Facility) {
    if (!window.confirm(`Hapus ${facility.code} - ${facility.name}? Fasilitas ini juga dihapus dari semua tipe unit.`)) {
      return
    }

    setDeletingCode(facility.code)
    setError("")
    setNotice("")
    try {
      const response = await fetch(`/api/facilities/${encodeURIComponent(facility.code)}`, {
        method: "DELETE",
      })
      const result = await response.json()
      if (!response.ok) throw new Error(result.error ?? "Gagal menghapus fasilitas.")
      setFacilities((currentFacilities) => currentFacilities.filter(
        (currentFacility) => currentFacility.code !== facility.code
      ))
      setNotice("Fasilitas berhasil dihapus.")
    } catch (deleteError) {
      setError(deleteError instanceof Error ? deleteError.message : "Gagal menghapus fasilitas.")
    } finally {
      setDeletingCode(null)
    }
  }

  return (
    <Card className="m-6 p-6">
      <div className="flex flex-wrap items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold">Facility Management</h1>
          <p className="text-sm text-muted-foreground">Kelola data fasilitas apartemen.</p>
        </div>
        <div className="flex flex-wrap items-center gap-2">
          <Link href="/admin/fasilitas/form" className={buttonVariants()}>
            <Plus aria-hidden="true" />
            Tambah facility
          </Link>
          <Button type="button" variant="outline" onClick={openCreateForm}>
            <Plus aria-hidden="true" />
            Tambah data master
          </Button>
        </div>
      </div>

      {error && <p role="alert" className="mt-4 text-sm text-destructive">{error}</p>}
      {notice && <p role="status" className="mt-4 text-sm text-green-700">{notice}</p>}

      {isFormOpen && (
        <form onSubmit={handleSubmit} className="mt-5 grid gap-4 rounded-md border p-4">
          <h2 className="text-lg font-semibold">{editingCode ? "Edit fasilitas" : "Tambah fasilitas"}</h2>
          <div className="grid gap-1.5">
            <label htmlFor="facility-code" className="text-sm font-medium">Kode Facility</label>
            <Input
              id="facility-code"
              value={code}
              onChange={(event) => setCode(event.target.value.toUpperCase())}
              required
              maxLength={20}
              pattern="[A-Za-z0-9_-]+"
              placeholder="Contoh: FCT018"
              disabled={isSaving}
            />
          </div>
          <div className="grid gap-1.5">
            <label htmlFor="facility-name" className="text-sm font-medium">Nama Facility</label>
            <Input
              id="facility-name"
              value={name}
              onChange={(event) => setName(event.target.value)}
              required
              maxLength={191}
              placeholder="Nama fasilitas"
              disabled={isSaving}
            />
          </div>
          <div className="flex flex-wrap justify-end gap-2">
            <Button type="button" variant="outline" onClick={closeForm} disabled={isSaving}>
              <X aria-hidden="true" />
              Batal
            </Button>
            <Button type="submit" disabled={isSaving}>
              <Save aria-hidden="true" />
              {isSaving ? "Menyimpan..." : "Simpan"}
            </Button>
          </div>
        </form>
      )}

      <Table className="mt-5">
        <TableCaption>{facilities.length} fasilitas</TableCaption>
        <TableHeader>
          <TableRow>
            <TableHead>No</TableHead>
            <TableHead>Kode Facility</TableHead>
            <TableHead>Nama Facility</TableHead>
            <TableHead>Dibuat</TableHead>
            <TableHead>Diperbarui</TableHead>
            <TableHead className="text-right">Aksi</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {isLoading ? (
            <TableRow>
              <TableCell colSpan={6} className="text-center">Memuat fasilitas...</TableCell>
            </TableRow>
          ) : facilities.length === 0 ? (
            <TableRow>
              <TableCell colSpan={6} className="text-center">Belum ada data fasilitas.</TableCell>
            </TableRow>
          ) : facilities.map((facility, index) => (
            <TableRow key={facility.code}>
              <TableCell>{index + 1}</TableCell>
              <TableCell className="font-mono">{facility.code}</TableCell>
              <TableCell className="font-medium">{facility.name}</TableCell>
              <TableCell>{new Date(facility.createdAt).toLocaleDateString("id-ID")}</TableCell>
              <TableCell>{new Date(facility.updatedAt).toLocaleDateString("id-ID")}</TableCell>
              <TableCell className="text-right">
                <div className="flex justify-end gap-2">
                  <Button
                    type="button"
                    size="icon"
                    variant="outline"
                    aria-label={`Edit ${facility.code}`}
                    onClick={() => openEditForm(facility)}
                  >
                    <Pencil aria-hidden="true" />
                  </Button>
                  <Button
                    type="button"
                    size="icon"
                    variant="destructive"
                    aria-label={`Hapus ${facility.code}`}
                    disabled={deletingCode === facility.code}
                    onClick={() => void deleteFacility(facility)}
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
