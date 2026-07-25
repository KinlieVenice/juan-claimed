import * as React from "react";
import { Link } from "react-router-dom";
import { ChevronDown, KeyRound } from "lucide-react";
import { AuthLayout } from "@/components/layout/AuthLayout";
import { GoogleSignInButton } from "@/components/auth/GoogleSignInButton";
import { EgovSignInButton } from "@/components/auth/EgovSignInButton";
import { StaffSignInForm } from "@/components/auth/StaffSignInForm";
import { Separator } from "@/components/ui/separator";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogTrigger,
} from "@/components/ui/dialog";
import { cn } from "@/lib/utils";

// Demo-only — mirrors the accounts seeded by userRoleSeeder.ts / demoPersonaFactory.ts's
// seedDemoAdminAndAgent (all password "password123"). Update this list if those seeders
// change. Not gated behind an env var like VITE_PRESET_* since it's just a reference list,
// not an auto-fill — showing it is an explicit user click, not the default view.
const STAFF_CREDENTIALS = [
  { role: "Superadmin", username: "superadmin" },
  { role: "National Agent", username: "agent_national_doh" },
  { role: "Provincial Agent (Cavite)", username: "agent_prov_cavite" },
  { role: "City Agent (Carmona)", username: "agent_city_carmona" },
] as const;
const STAFF_PASSWORD = "password123";

function StaffCredentialsDialog() {
  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button type="button" variant="outline" size="sm" className="w-full gap-2">
          <KeyRound className="size-3.5" />
          Show credentials
        </Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Seeded staff credentials</DialogTitle>
          <DialogDescription>Demo only — for testing agency staff sign-in.</DialogDescription>
        </DialogHeader>
        <div className="space-y-2">
          {STAFF_CREDENTIALS.map((cred) => (
            <div key={cred.username} className="rounded-lg border border-slate-200 p-3 text-sm">
              <p className="text-xs font-semibold text-slate-500">{cred.role}</p>
              <p className="font-mono text-slate-800">
                username: {cred.username} password: {STAFF_PASSWORD}
              </p>
            </div>
          ))}
        </div>
      </DialogContent>
    </Dialog>
  );
}

export function LoginPage() {
  const [staffOpen, setStaffOpen] = React.useState(false);

  return (
    <AuthLayout>
      <div className="space-y-2 text-center lg:text-left">
        <h2 className="font-display text-2xl font-black text-slate-900">Sign in</h2>
        <p className="text-sm text-slate-600">Choose how you'd like to continue.</p>
      </div>

      <div className="space-y-3">
        <GoogleSignInButton />
        <EgovSignInButton />
      </div>

      <div className="flex items-center gap-3">
        <Separator className="flex-1" />
        <span className="text-xs text-slate-400">or</span>
        <Separator className="flex-1" />
      </div>

      <Link to="/form" className="block text-center text-sm font-semibold text-slate-500 underline-offset-4 hover:text-slate-700 hover:underline">
        Continue without signing in
      </Link>

      <div className="border-t border-slate-200 pt-6">
        <button
          type="button"
          onClick={() => setStaffOpen((v) => !v)}
          className="flex w-full items-center justify-between text-xs font-semibold text-slate-500 hover:text-slate-700"
        >
          Agency staff sign-in
          <ChevronDown className={cn("size-3.5 transition-transform", staffOpen && "rotate-180")} />
        </button>
        {staffOpen && (
          <div className="mt-4 space-y-4">
            <StaffSignInForm />
            <StaffCredentialsDialog />
          </div>
        )}
      </div>
    </AuthLayout>
  );
}
