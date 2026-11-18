import Link from "next/link";
import { ChevronDown, GraduationCap } from "lucide-react";
import { Button } from "@/components/ui/button";

type MenuLandingPageProps = {
  onLoginClick: () => void;
};

export function MenuLandingPage({ onLoginClick }: MenuLandingPageProps) {
  return (
    <header className="h-24 bg-[#1f40b5] px-5 sm:px-10 lg:px-14">
      <nav
        aria-label="Navigasi utama"
        className="mx-auto grid h-full max-w-[1800px] grid-cols-[1fr_auto_1fr] items-center"
      >
        <Link
          href="/"
          className="flex w-fit items-center gap-2.5 text-white"
          aria-label="MVP ARS International School - Beranda"
        >
          <span className="grid size-10 shrink-0 place-items-center rounded-full border-2 border-white/80 bg-white text-blue-800">
            <GraduationCap aria-hidden="true" className="size-6" />
          </span>
          <span className="leading-none">
            <span className="block font-heading text-xl font-black tracking-wide sm:text-2xl">
              MVP ARS
            </span>
            <span className="mt-1 block text-[9px] font-semibold tracking-[0.12em] sm:text-[10px]">
              INTERNATIONAL SCHOOL
            </span>
          </span>
        </Link>

        <div className="hidden items-center gap-7 text-base font-semibold text-white md:flex">
          <Link className="transition-opacity hover:opacity-75" href="/">
            Home
          </Link>
          <Link
            className="inline-flex items-center gap-1 transition-opacity hover:opacity-75"
            href="/admin/jurusan"
          >
            jurusan
            <ChevronDown aria-hidden="true" className="size-3.5" />
          </Link>
          <Link
            className="inline-flex items-center gap-1 transition-opacity hover:opacity-75"
            href="/admin/category"
          >
            Components
            <ChevronDown aria-hidden="true" className="size-3.5" />
          </Link>
          <Link
            className="transition-opacity hover:opacity-75"
            href="/admin/artikel"
          >
            Docs
          </Link>
        </div>

        <div className="flex justify-end">
          <Button
            onClick={onLoginClick}
            className="h-10 rounded-full border border-slate-200 bg-white px-5 font-semibold text-orange-600 shadow-sm hover:bg-slate-50"
          >
            Login
          </Button>
        </div>
      </nav>
    </header>
  );
}
