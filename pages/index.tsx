import Head from "next/head"
//import Image from "next/image"
import styles from "../styles/Home.module.css"
import { GreetingSection } from "../ui/components/GreetingSection"
import Link from "next/link"
import { useState } from "react"
import { Button } from "react-bootstrap"
// import logo from "../images/nuance-flag.png";
// import logo from "../images/nuance-logo.svg"
// import { useRouter } from "next/router"

export default function Home() {
  const [articleTitle, setArticleTitle] = useState("First Article")
  const [siteDesc, setSiteDesc] = useState(
    "This is the first article on Nuance-next"
  )

  // const router = useRouter()
  // const { id } = router.query

  // console.log(id)

  return (
    <div className={styles.container}>
      <Head>
        <title>Create Next App</title>
        <meta name="description" content="Generated by create next app" />
        <meta name="og:title" content={articleTitle} />
        <meta name="twitter:card" content={"summary_large_image"} />
        <meta name="twitter:title" content={articleTitle} />
        <meta name="twitter:description" content={siteDesc} />
        <meta
          name="twitter:image"
          content={
            "https://i.pcmag.com/imagery/articles/015t2XCInYI4JmscpwIFyrH-1.fit_lim.v1634848953.jpg"
          }
        />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className={styles.main}>
        <h1 className={styles.title}>Welcome to Nuance-Next!</h1>

        <p className={styles.description}>
          This is an app designed to test out how Next.js works on the IC for
          the first Decentralized Blogging Dapp: Nuance!
        </p>

        <Link href={`/article/7`}>
          <Button
            // onClick={() => router.push(`/article/7`)}
            variant="primary"
          >
            To Article
          </Button>
        </Link>

        <div className={styles.grid}>
          <a
            href="https://github.com/theprivacydev/nuance-next"
            className={styles.card}
          >
            <h2>View Code &rarr;</h2>
            <p>
              See how we built this app by looking at the code on the GitHub
              Repo!
            </p>
          </a>

          <a href="https://nextjs.org/learn" className={styles.card}>
            <h2>Learn Next&rarr;</h2>
            <p>Learn about Next.js in an interactive course with quizzes!</p>
          </a>

          <a href="https://dfinity.org/" className={styles.card}>
            <h2>Learn IC &rarr;</h2>
            <p>Discover what the Internet Computer Protocol is all about</p>
          </a>

          <a
            href="https://www.aikin.io/"
            target="_blank"
            rel="noopener noreferrer"
            className={styles.card}
          >
            <h2>Learn about Aikin &rarr;</h2>
            <p>
              Aikin is the company that built Nuance - blogging Dapp on the IC.
            </p>
          </a>
        </div>
      </main>

      <footer className={styles.footer}>
        <a
          href="https://exwqn-uaaaa-aaaaf-qaeaa-cai.ic0.app/"
          target="_blank"
          rel="noopener noreferrer"
        >
          Built by{" "}
          <span className={styles.logo}>
            {/* <Image src="/vercel.svg" alt="Vercel Logo" width={72} height={16} /> */}
            The Aikin/Nuance Team
          </span>
        </a>
      </footer>
    </div>
  )
}
