-- Run once in the Supabase SQL Editor. No personal records belong in this repository.
create table if not exists public.happy_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null check (jsonb_typeof(payload) = 'object'),
  revision bigint not null default 1 check (revision > 0),
  updated_at timestamptz not null default now()
);
alter table public.happy_state enable row level security;
revoke all on public.happy_state from anon;
revoke all on public.happy_state from authenticated;
grant select, insert, update on public.happy_state to authenticated;

drop policy if exists "Read own happy state" on public.happy_state;
create policy "Read own happy state" on public.happy_state for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "Create own happy state" on public.happy_state;
create policy "Create own happy state" on public.happy_state for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "Update own happy state" on public.happy_state;
create policy "Update own happy state" on public.happy_state for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);

create or replace function public.happy_revision_guard() returns trigger
language plpgsql set search_path = '' as $$
begin
  if TG_OP = 'INSERT' then
    NEW.revision := 1;
  else
    if NEW.revision <> OLD.revision + 1 then
      raise exception 'Revision must increase by one';
    end if;
  end if;
  NEW.updated_at := now();
  return NEW;
end;
$$;
revoke all on function public.happy_revision_guard() from public, anon, authenticated;
drop trigger if exists happy_revision_guard on public.happy_state;
create trigger happy_revision_guard before insert or update on public.happy_state for each row execute function public.happy_revision_guard();
