'use client';

import Link from 'next/link';
import {
  Zap,
  User,
  Sun,
  ChevronDown,
  Plus,
  TrendingUp,
  TrendingDown,
  CheckCircle2,
  Monitor,
  Sparkles,
  ArrowRight,
  ShieldCheck,
  Briefcase,
} from 'lucide-react';

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-white text-gray-900">
      {/* Header */}
      <header className="sticky top-0 z-50 border-b border-gray-100 bg-white/95 backdrop-blur">
        <div className="mx-auto flex h-14 max-w-7xl items-center justify-between px-4 sm:px-6 lg:px-8">
          <Link href="/" className="flex items-center gap-2 transition-opacity hover:opacity-90">
            <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-primary-600 text-white shadow-md">
              <Briefcase className="h-5 w-5" />
            </div>
            <span className="text-xl font-semibold text-gray-900">Niche Hiring</span>
          </Link>
          <nav className="hidden items-center gap-6 md:flex">
            <Link href="#platform" className="text-sm font-medium text-gray-600 transition-colors hover:text-gray-900">
              Platform
            </Link>
            <Link href="#solutions" className="text-sm font-medium text-gray-600 transition-colors hover:text-gray-900">
              Solutions
            </Link>
            <Link href="#pricing" className="text-sm font-medium text-gray-600 transition-colors hover:text-gray-900">
              Pricing
            </Link>
          </nav>
          <div className="flex items-center gap-2">
            <button type="button" className="rounded-full p-2 text-gray-500 transition-colors hover:bg-gray-100" aria-label="Theme">
              <Sun className="h-5 w-5" />
            </button>
            <button type="button" className="flex items-center gap-1 rounded-full p-2 text-gray-500 transition-colors hover:bg-gray-100" aria-label="Account">
              <User className="h-5 w-5" />
              <ChevronDown className="h-4 w-4" />
            </button>
          </div>
        </div>
      </header>

      {/* Hero */}
      <section className="relative overflow-hidden px-4 pb-12 pt-10 sm:px-6 lg:px-8">
        <div className="mx-auto max-w-4xl text-center">
          <span className="inline-flex items-center gap-1.5 rounded-full bg-primary-600 px-4 py-1.5 text-xs font-medium uppercase tracking-wide text-white shadow-lg shadow-primary-600/25">
            <Zap className="h-4 w-4" />
            AI-Powered Enterprise Recruiting
          </span>
          <h1 className="mt-6 text-4xl font-bold tracking-tight text-gray-900 sm:text-5xl lg:text-6xl">
            Hire Top Talent.{' '}
            <span className="text-primary-600">In Days, Not Months.</span>
          </h1>
          <p className="mx-auto mt-4 max-w-2xl text-lg text-gray-600">
            The intelligent infrastructure for modern talent acquisition. Verified notice periods and skill-mapped candidates at scale.
          </p>
          <div className="mt-6 flex flex-wrap items-center justify-center gap-3">
            <Link
              href="#post-job"
              className="inline-flex items-center gap-2 rounded-lg bg-primary-600 px-5 py-2.5 text-sm font-semibold text-white shadow-md transition-all hover:scale-105 hover:bg-primary-700 hover:shadow-lg"
            >
              <Plus className="h-4 w-4" />
              Post a Job
            </Link>
            <Link
              href="#get-started"
              className="inline-flex items-center rounded-lg border-2 border-primary-600 bg-white px-5 py-2.5 text-sm font-semibold text-primary-600 transition-all hover:scale-105 hover:bg-primary-50"
            >
              Get Started
            </Link>
          </div>
          <p className="mt-8 text-xs font-medium uppercase tracking-wider text-gray-400">Strategic Partners &amp; Enterprises</p>
          <div className="mt-3 flex justify-center gap-6 opacity-60">
            <div className="h-8 w-20 rounded bg-gray-200" />
            <div className="h-8 w-20 rounded bg-gray-200" />
            <div className="h-8 w-20 rounded bg-gray-200" />
          </div>
        </div>
      </section>

      {/* Metrics */}
      <section id="solutions" className="border-t border-gray-100 bg-gray-50/50 px-4 py-10 sm:px-6 lg:px-8">
        <div className="mx-auto grid max-w-5xl gap-4 sm:grid-cols-3">
          <div className="rounded-xl bg-white p-5 shadow-sm ring-1 ring-gray-100 transition-all hover:scale-[1.02] hover:shadow-md">
            <p className="text-xs font-semibold uppercase tracking-wider text-gray-500">Verified Talent</p>
            <p className="mt-1 text-2xl font-bold text-gray-900">15k+</p>
            <p className="mt-1 inline-flex items-center gap-1 text-sm font-medium text-green-600">
              <TrendingUp className="h-4 w-4" />
              <span>+12%</span>
            </p>
          </div>
          <div className="rounded-xl bg-white p-5 shadow-sm ring-1 ring-gray-100 transition-all hover:scale-[1.02] hover:shadow-md">
            <p className="text-xs font-semibold uppercase tracking-wider text-gray-500">Avg. Hire</p>
            <p className="mt-1 text-2xl font-bold text-gray-900">4 Days</p>
            <p className="mt-1 inline-flex items-center gap-1 text-sm font-medium text-red-600">
              <TrendingDown className="h-4 w-4" />
              <span>~80%</span>
            </p>
          </div>
          <div className="rounded-xl bg-white p-5 shadow-sm ring-1 ring-gray-100 transition-all hover:scale-[1.02] hover:shadow-md">
            <p className="text-xs font-semibold uppercase tracking-wider text-gray-500">Success Rate</p>
            <p className="mt-1 text-2xl font-bold text-gray-900">98%</p>
            <p className="mt-1 inline-flex items-center gap-1 text-sm font-medium text-green-600">
              <TrendingUp className="h-4 w-4" />
              <span>+5%</span>
            </p>
          </div>
        </div>
      </section>

      {/* Enterprise features */}
      <section id="platform" className="px-4 py-10 sm:px-6 lg:px-8">
        <div className="mx-auto max-w-5xl">
          <p className="text-sm font-semibold uppercase tracking-wider text-primary-600">Enterprise Features</p>
          <h2 className="mt-1 text-2xl font-bold tracking-tight text-gray-900 sm:text-3xl">
            Why Enterprise Recruiters Trust Our Network
          </h2>
          <span className="mt-1 block h-1 w-20 rounded bg-primary-600" />
          <div className="mt-8 space-y-4">
            <div className="flex gap-4 rounded-xl bg-white p-5 shadow-sm ring-1 ring-gray-100 transition-all hover:shadow-md">
              <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-primary-100 text-primary-600">
                <CheckCircle2 className="h-6 w-6" />
              </div>
              <div>
                <div className="flex flex-wrap items-center gap-2">
                  <h3 className="text-base font-semibold text-gray-900">Verified Notice Periods</h3>
                  <span className="rounded-full bg-green-100 px-2 py-0.5 text-xs font-medium text-green-800">Active Verification</span>
                </div>
                <p className="mt-1.5 text-sm text-gray-600">
                  Eliminate the risk of fake availability. We authenticate every candidate&apos;s true notice period—covering both immediate joiners and regular transitions—ensuring your hiring timeline remains bulletproof.
                </p>
              </div>
            </div>
            <div className="flex gap-4 rounded-xl bg-white p-5 shadow-sm ring-1 ring-gray-100 transition-all hover:shadow-md">
              <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-primary-100 text-primary-600">
                <Monitor className="h-6 w-6" />
              </div>
              <div>
                <h3 className="text-base font-semibold text-gray-900">Technical Pre-Screening</h3>
                <p className="mt-1.5 text-sm text-gray-600">
                  Candidates undergo a rigorous AI-driven technical assessment environment to ensure skill match before they reach your recruiters, saving hundreds of engineering hours.
                </p>
              </div>
            </div>
            <div className="flex gap-4 rounded-xl bg-white p-5 shadow-sm ring-1 ring-gray-100 transition-all hover:shadow-md">
              <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-full bg-primary-100 text-primary-600">
                <Sparkles className="h-6 w-6" />
              </div>
              <div>
                <h3 className="text-base font-semibold text-gray-900">Contextual AI Matching</h3>
                <p className="mt-1.5 text-sm text-gray-600">
                  Our neural matching engine understands deep technical nuances beyond just keyword search, identifying &quot;DNA match&quot; candidates based on past performance and project complexity.
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* CTA banner */}
      <section id="pricing" className="px-4 py-10 sm:px-6 lg:px-8">
        <div className="mx-auto max-w-5xl">
          <div className="rounded-2xl bg-gradient-to-br from-primary-600 to-primary-800 px-6 py-12 text-center shadow-xl">
            <h2 className="text-2xl font-bold text-white sm:text-3xl">
              Scale Your Engineering Teams with Confidence
            </h2>
            <Link
              href="#demo"
              className="mt-6 inline-flex items-center gap-2 rounded-lg border-2 border-white bg-white px-5 py-2.5 text-sm font-semibold text-primary-700 transition-all hover:scale-105 hover:bg-primary-50"
            >
              Request Enterprise Demo
              <ArrowRight className="h-4 w-4" />
            </Link>
            <p className="mt-4 text-sm text-white/90">
              Join 500+ Fortune 1000 enterprises streamlining their talent pipeline.
            </p>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-gray-200 bg-white px-4 py-8 sm:px-6 lg:px-8">
        <div className="mx-auto flex max-w-5xl flex-col items-center justify-between gap-4 sm:flex-row">
          <Link href="/" className="flex items-center gap-2 transition-opacity hover:opacity-90">
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-primary-600 text-white">
              <Briefcase className="h-4 w-4" />
            </div>
            <span className="font-semibold text-gray-900">Niche Hiring</span>
          </Link>
          <p className="text-center text-sm text-gray-500">
            © {new Date().getFullYear()} Niche Hiring. The Gold Standard for Enterprise Recruiting.
          </p>
          <div className="flex gap-5 text-sm text-gray-500">
            <Link href="#privacy" className="transition-colors hover:text-gray-900">Privacy Policy</Link>
            <Link href="#terms" className="transition-colors hover:text-gray-900">Terms of Service</Link>
            <Link href="#security" className="flex items-center gap-1 transition-colors hover:text-gray-900">
              <ShieldCheck className="h-4 w-4" />
              Security
            </Link>
          </div>
        </div>
      </footer>
    </div>
  );
}
