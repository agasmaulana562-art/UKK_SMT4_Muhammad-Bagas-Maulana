import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import {
  LayoutDashboard,
  UsersRound,
} from "lucide-react";
import Image from "next/image";
import Link from "next/link";

export function AppSidebar() {
  return (
    <Sidebar className="border-r-0 [&>div]:bg-blue-600 [&>div]:text-white">
      {/* Container utama diberi paksa bg-blue-600 lewat Arbitrary Variant Tailwind */}
      <div className="flex h-full w-full flex-col bg-blue-600 text-white">
        {/* Header Logo */}
        <SidebarHeader className="p-4 bg-blue-600">
          <div className="flex items-center justify-center gap-3 px-3 py-2">
            <Image
              src="/img/smk_mvp_ars_logo_white.png"
              alt="SMK MVP ARS"
              width={200}
              height={200}
              className="w-auto h-auto max-h-12 object-contain"
              priority
            />
          </div>
        </SidebarHeader>

        {/* Content Menu */}
        <SidebarContent className="bg-blue-600">
          <SidebarGroup>
            <SidebarGroupLabel className="text-white/80 text-xs font-semibold px-2 mb-2">
              Menu Utama
            </SidebarGroupLabel>
            <SidebarGroupContent>
              <SidebarMenu>
                {/* Dashboard */}
                <SidebarMenuItem>
                  <SidebarMenuButton
                    render={<Link href="/admin" />}
                    className="text-white hover:bg-blue-700 hover:text-white active:bg-blue-800"
                  >
                    <LayoutDashboard className="w-4 h-4 mr-2" />
                    <span>Dashboard</span>
                  </SidebarMenuButton>
                </SidebarMenuItem>

                {/* User Management */}
                <SidebarMenuItem>
                  <SidebarMenuButton
                    render={<Link href="/admin/user-management" />}
                    className="text-white hover:bg-blue-700 hover:text-white active:bg-blue-800"
                  >
                    <UsersRound className="w-4 h-4 mr-2" />
                    <span>User Management</span>
                  </SidebarMenuButton>
                </SidebarMenuItem>

              </SidebarMenu>
            </SidebarGroupContent>
          </SidebarGroup>
        </SidebarContent>

        <SidebarFooter className="bg-blue-900" />
      </div>
    </Sidebar>
  );
}
