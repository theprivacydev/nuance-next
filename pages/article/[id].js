import React from "react"
import { useRouter } from "next/router"

function Article() {
  const router = useRouter()
  const id = router.query.id
  console.log(id);
  return <div>First Article</div>
}

export default Article
