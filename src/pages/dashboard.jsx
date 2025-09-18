import { Link } from "react-router";
import { useAuth } from "@/contexts/auth-context";
import CenterBox from "@/components/center-box";

export default function Dashboard() {
  const { user, logout } = useAuth();

  return (
    <CenterBox>
      <h1 className="font-bold">Dashboard</h1>
      <div className="mt-4 flex gap-4">
        <Link to="/">Back</Link>
      </div>
      <p className="mt-4">Welcome {user?.email || user?.username}!</p>
      <button
        className="mt-4 px-2 py-1 bg-gray-600 hover:bg-gray-500 rounded-lg"
        onClick={logout}
      >
        Logout
      </button>
    </CenterBox>
  );
}
