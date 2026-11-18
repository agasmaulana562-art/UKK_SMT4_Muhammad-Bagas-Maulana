import { Suspense } from "react";
import { LandingPageClient } from "@/components/landing-page-client";

export default function Home(props: PageProps<"/">) {
  return (
    <Suspense fallback={<div className="min-h-screen bg-white" />}>
      <LandingPageContent searchParams={props.searchParams} />
    </Suspense>
  );
}

async function LandingPageContent({
  searchParams,
}: Pick<PageProps<"/">, "searchParams">) {
  const { login } = await searchParams;

  return <LandingPageClient openLoginInitially={login === "1"} />;
}
