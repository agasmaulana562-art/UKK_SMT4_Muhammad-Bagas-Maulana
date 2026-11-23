import { FacilityAssignmentForm } from "./facility-assignment-form"

export default async function FacilityAssignmentPage({
  searchParams,
}: PageProps<"/admin/fasilitas/form">) {
  const { unitTypeId } = await searchParams
  return (
    <FacilityAssignmentForm
      initialUnitTypeId={typeof unitTypeId === "string" ? unitTypeId : undefined}
    />
  )
}
