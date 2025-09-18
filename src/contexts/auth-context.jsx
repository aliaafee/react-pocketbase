import { createContext, useContext, useEffect, useMemo, useState } from "react";
import { pb } from "@/lib/pb";

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(pb.authStore.model);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // initial refresh attempt
    (async () => {
      setUser(pb.authStore.model);
      setLoading(false);
    })();

    // subscribe to auth changes
    const unsubscribe = pb.authStore.onChange((_token, model) => {
      setUser(model);
    });
    return unsubscribe;
  }, []);

  const value = useMemo(
    () => ({
      user,
      isAuthed: !!user,

      login: async (email, password) => {
        setLoading(true);
        const authData = await pb
          .collection("users")
          .authWithPassword(email, password);
        setLoading(false);
        setUser(authData.record);
        return authData.record;
      },

      register: async ({ email, password, passwordConfirm }) => {
        // Your users collection must be “users” with standard fields
        setLoading(true);
        const record = await pb
          .collection("users")
          .create({ email, password, passwordConfirm });
        // Optionally auto-login:
        await pb.collection("users").authWithPassword(email, password);
        setLoading(false);
        setUser(pb.authStore.model);
        return record;
      },

      logout: () => {
        pb.authStore.clear();
        setUser(null);
      },
    }),
    [user]
  );

  return (
    <AuthContext.Provider value={{ ...value, loading }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth must be used within <AuthProvider>");
  return ctx;
}
