
"use client";

import { useRouter } from "next/navigation";
import { useState, type FormEvent } from "react";

import { MenuLandingPage } from "@/components/landing-page-menu";
import { Button } from "@/components/ui/button";
import { LandingPageHero } from "@/components/landing-page-hero";
import { LockKeyhole, Mail, X } from "lucide-react";
import { Field, FieldLabel } from "@/components/ui/field";

import {
  InputGroup,
  InputGroupAddon,
  InputGroupInput,
} from "@/components/ui/input-group";

type LandingPageClientProps = {
  openLoginInitially: boolean;
};

export function LandingPageClient({
  openLoginInitially,
}: LandingPageClientProps) {
  const router = useRouter();

  const [isLoginOpen, setIsLoginOpen] = useState(openLoginInitially);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loginError, setLoginError] = useState("");
  const [isLoggingIn, setIsLoggingIn] = useState(false);

  async function handleLogin(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    setLoginError("");
    setIsLoggingIn(true);

    try {
      const response = await fetch("/api/auth/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          email: email.trim(),
          password,
        }),
      });

      const result = await response.json();

      if (!response.ok) {
        throw new Error(result.error ?? "Login gagal.");
      }

      router.replace("/admin");
      router.refresh();

    } catch (error) {
      setLoginError(
        error instanceof Error
          ? error.message
          : "Login gagal."
      );

      setIsLoggingIn(false);
    }
  }

  return (
    <main className="min-h-screen bg-[#1f40b5]">
      <MenuLandingPage
        onLoginClick={() => {
          setIsLoginOpen(true);
          setLoginError("");
        }}
      />

      <LandingPageHero />

      {isLoginOpen && (
        <div
          className="fixed inset-0 z-[100] flex items-center justify-center bg-slate-950/60 p-4 backdrop-blur-sm"
          onMouseDown={(event) => {
            if (event.target === event.currentTarget) {
              setIsLoginOpen(false);
              setLoginError("");
            }
          }}
        >
          <div
            role="dialog"
            aria-modal="true"
            aria-labelledby="login-title"
            className="relative w-full max-w-md rounded-3xl bg-white p-7 shadow-2xl"
          >
            <Button
              type="button"
              variant="ghost"
              size="icon"
              aria-label="Tutup form login"
              onClick={() => {
                setIsLoginOpen(false);
                setLoginError("");
              }}
              className="absolute right-3 top-3"
            >
              <X />
            </Button>

            <div className="mb-6 pr-8">
              <p className="text-sm font-semibold text-blue-600">
                ADMIN PANEL
              </p>

              <h2
                id="login-title"
                className="mt-2 text-2xl font-bold tracking-tight"
              >
                Masuk ke panel admin
              </h2>

              <p className="mt-2 text-sm leading-6 text-slate-600">
                Gunakan akun terdaftar untuk melanjutkan.
              </p>
            </div>

            <form onSubmit={handleLogin}>
              <Field className="w-full space-y-3">
                <FieldLabel htmlFor="email-input">
                  Email
                </FieldLabel>

                <InputGroup>
                  <InputGroupInput
                    id="email-input"
                    type="email"
                    autoComplete="username"
                    placeholder="Email"
                    value={email}
                    onChange={(event) =>
                      setEmail(event.target.value)
                    }
                    required
                  />

                  <InputGroupAddon align="inline-start">
                    <Mail
                      aria-hidden="true"
                      className="text-muted-foreground"
                    />
                  </InputGroupAddon>
                </InputGroup>

                <FieldLabel htmlFor="password-input">
                  Password
                </FieldLabel>

                <InputGroup>
                  <InputGroupInput
                    id="password-input"
                    type="password"
                    autoComplete="current-password"
                    placeholder="Password"
                    value={password}
                    onChange={(event) =>
                      setPassword(event.target.value)
                    }
                    required
                  />

                  <InputGroupAddon align="inline-start">
                    <LockKeyhole
                      aria-hidden="true"
                      className="text-muted-foreground"
                    />
                  </InputGroupAddon>
                </InputGroup>

                {loginError && (
                  <p
                    role="alert"
                    className="text-sm text-destructive"
                  >
                    {loginError}
                  </p>
                )}

                <Button
                  type="submit"
                  className="mt-2 h-11 w-full rounded-xl"
                  disabled={isLoggingIn}
                >
                  {isLoggingIn ? "Memproses..." : "Login"}
                </Button>
              </Field>
            </form>
          </div>
        </div>
      )}
    </main>
  );
}
