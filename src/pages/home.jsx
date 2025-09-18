import { Link } from "react-router";
import { BotIcon } from "lucide-react";
import CenterBox from "@/components/center-box";

export default function Home() {
  return (
    <CenterBox>
      <BotIcon width={64} height={64} />
      <div className="mt-4">Hello Vite+React+Tailwind4+PocketBase</div>
      <div className="mt-4 flex gap-4">
        <Link to="/dashboard">Dashboard</Link>
        <Link to="/register">Add User</Link>
      </div>
    </CenterBox>
  );
}
