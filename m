Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C35EB3634
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8soB65zlTu2v0BZMVJ1hST4YvEN8YOKN9odwXk+III=; b=DbKph6il3xaIbESAsJSMnA7/Wi
	kHWwmoXbAgMPX6RC1qBqO2zGmlLriewD9UUxgRSK+kEKTUBaMdW02Ey0c2qyP/Br8sqVHASRcGe4m
	wC0WrKf/YEQzpeZG/xACGIixmYsuG/A+Z6hIgFWKowQiUJQH5DAbI/DLbeX2oq7pb4WI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxA9t-0007YF-Jj;
	Mon, 02 Mar 2026 20:46:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jlayton@kernel.org>) id 1vxA9i-0007WD-9l;
 Mon, 02 Mar 2026 20:46:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ukJlA5hNGeDu8wDq4qMPFOKZ33ejxXPqDyKKGt/DkT4=; b=GK7yyqzHnPaZomFnhL+bHS9Bfb
 yyZo5obrRu9skJ+6Fbqs2cNZLW0GWZXu5+qPX1Ze1Fs7E9xsyiCi4Ggu57LA/BddBPvCKwnFPKfFe
 Lekc7r2w4iAhjltgJ0CMWyU3Ym6ft4aDYbSo9MFepQzyLcETBLdVt6peyj9d6ZbU4fmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ukJlA5hNGeDu8wDq4qMPFOKZ33ejxXPqDyKKGt/DkT4=; b=O0fHhdO77VTVTmLmgTIu03tptu
 ov7MaF32PGCQGVtoeUHkeC+TXKtJMbCNQQgq+S7HxTb3xp1Yf3/JnMt4WtP0ynwxnTyATf0HuP4gt
 jQvSCe+KcQ8b8U5ys79K1ypljXmrpDNrRyxreD9MQ8q+Bcb9wAvvmBkaa1vkq9SziJsc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxA9a-0006k3-5G; Mon, 02 Mar 2026 20:46:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C279E43B9E;
 Mon,  2 Mar 2026 20:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A47FC2BC9E;
 Mon,  2 Mar 2026 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772484364;
 bh=qBOGZ+H4FCJyoScuTijEcAxm33DX4t54AKihmOD4lfc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WD9QSZaB4Ynf3T2024pRykq9e0/jdmE8EG7gpxceQsWLs9ldUDrFlX4ArZiie0vbL
 19LbIvHDGkRkdQlFvg2Y7NwamnoN3dr7aJrGPp3z71wIC5mJJ7qSa4bmsCB3TH/SeC
 hUi3DjOP9V4XSETuRPjeZTuWgMSi9immDKfUAEtwEpfS0taqUCB19NTdwT9PAl2Dr1
 X6n/FZutnR9+MwmmLPosjsknaR7URHBAA5CT4uRPA0WQdzY1319ktmFMHsHOHDXsX6
 uClORVRaA5wOmwgDDGWX9W7QBFGsaZ2Twg5ddM1UZAYTdINoixEOU0+4vzdq6qPVwW
 Ibfy5Y48Gl/bg==
Date: Mon, 02 Mar 2026 15:25:12 -0500
MIME-Version: 1.0
Message-Id: <20260302-iino-u64-v2-88-e5388800dae0@kernel.org>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Sterba <dsterba@suse.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
 Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, 
 Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Yangtao Li <frank.li@vivo.com>, 
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
 Dave Kleikamp <shaggy@kernel.org>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 John Johansen <john.johansen@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
 Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, 
 Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4782; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qBOGZ+H4FCJyoScuTijEcAxm33DX4t54AKihmOD4lfc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIHR7PXwpRijiaDSNoHBRx6sRq6q8UIIYKp7
 0L0gu64QBiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyBwAKCRAADmhBGVaC
 FdutD/9ObZxe+nOy3nsTFaq7Ut8ArWcplsqSov2kMlKcZpVCHHzCKDenXVX9I9pFuqNSk3FCVmR
 ZtENkgoSqrEgrLbDJ9RYgQz5YLIkClSpE+d+3sRwa1vcidi9xUmF9r1539KnV74bVbjnUn7n39b
 5Yz4oalHYtyM0RxZBk4NYEBKtBfrTqeXOydheHjmorfO4SLpKbS0DJSXG6yKJp+8cYAotA5dyLc
 3wz9mx4uNNIi189tf6M4st3QnK1Rse02wHg82ld1a3TZwDRBfVMBrAtlw7DNUBGBc+nVPRYksak
 VxsyEvoslW6Mw05AybupfOtcxkiI7AacYGnromEJLcZ9ZlsBvV9WkRnM9x/QaFVylYPnp96tPfm
 vie5eyII+IYTlT43Ms7C5qU2fcqdKWkC6fZeKSw3Kh7u/pRdAWPgmiOQdnJIZMUoz4UB6CSQJK8
 a47IYq+UxK3Wc55K1/6Nr/HQ7be+ZGdPny2IRYMf644RLf9W0bUdW+9jBTSSRT7I/77bh4GypLj
 13ZdGuuNKShNp8yE8pV0NP6WB8IbR3yr/yVN3F5UOGRYYRzT5c7/SWeas3JKNG3EhQqXtFQBTC8
 n8AEMtgsyD6/eAVFe8FdKpcragAugbl/JXE/AL/jlB+vFGxVdYQthx9JOUOfU1J2NFyfRZMlbfb
 M6QevW1Grdb83mA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Headers-End: 1vxA9a-0006k3-5G
Subject: [f2fs-dev] [PATCH v2 088/110] jffs2: replace PRIino with %llu/%llx
 format strings
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jeff Layton via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jeff Layton <jlayton@kernel.org>
Cc: nvdimm@lists.linux.dev, jfs-discussion@lists.sourceforge.net,
 Jeff Layton <jlayton@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-unionfs@vger.kernel.org, linux-mm@kvack.org, linux-sctp@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-x25@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, codalist@coda.cs.cmu.edu,
 linux-ext4@vger.kernel.org, bpf@vger.kernel.org, devel@lists.orangefs.org,
 linux-trace-kernel@vger.kernel.org, ecryptfs@vger.kernel.org,
 selinux@vger.kernel.org, autofs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-media@vger.kernel.org, linux-can@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, ocfs2-devel@lists.linux.dev,
 linux-fscrypt@vger.kernel.org, linux-hams@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 v9fs@lists.linux.dev, samba-technical@lists.samba.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-perf-users@vger.kernel.org, audit@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netfs@lists.linux.dev, linux-integrity@vger.kernel.org, ntfs3@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now that i_ino is u64 and the PRIino format macro has been removed,
replace all uses in jffs2 with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jffs2/dir.c  |  4 ++--
 fs/jffs2/file.c |  4 ++--
 fs/jffs2/fs.c   | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 6ef2641b39b3c66924eb4641f5c0024ae11ff255..c4088c3b4ac0362074cfa186c04f9c3afcccdff2 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -129,7 +129,7 @@ static int jffs2_readdir(struct file *file, struct dir_context *ctx)
 	struct jffs2_full_dirent *fd;
 	unsigned long curofs = 1;
 
-	jffs2_dbg(1, "jffs2_readdir() for dir_i #%" PRIino "u\n", inode->i_ino);
+	jffs2_dbg(1, "jffs2_readdir() for dir_i #%llu\n", inode->i_ino);
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
@@ -211,7 +211,7 @@ static int jffs2_create(struct mnt_idmap *idmap, struct inode *dir_i,
 
 	jffs2_free_raw_inode(ri);
 
-	jffs2_dbg(1, "%s(): Created ino #%" PRIino "u with mode %o, nlink %d(%d). nrpages %ld\n",
+	jffs2_dbg(1, "%s(): Created ino #%llu with mode %o, nlink %d(%d). nrpages %ld\n",
 		  __func__, inode->i_ino, inode->i_mode, inode->i_nlink,
 		  f->inocache->pino_nlink, inode->i_mapping->nrpages);
 
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index f6b9d76d9dbc32f582069aeef0b73cf3c6ff842e..1e18d3a798409d23440a5890808bc25372549e93 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -88,7 +88,7 @@ static int jffs2_do_readpage_nolock(struct inode *inode, struct folio *folio)
 	unsigned char *kaddr;
 	int ret;
 
-	jffs2_dbg(2, "%s(): ino #%" PRIino "u, page at offset 0x%lx\n",
+	jffs2_dbg(2, "%s(): ino #%llu, page at offset 0x%lx\n",
 		  __func__, inode->i_ino, folio->index << PAGE_SHIFT);
 
 	BUG_ON(!folio_test_locked(folio));
@@ -259,7 +259,7 @@ static int jffs2_write_end(const struct kiocb *iocb,
 	uint32_t writtenlen = 0;
 	void *buf;
 
-	jffs2_dbg(1, "%s(): ino #%" PRIino "u, page at 0x%llx, range %d-%d, flags %lx\n",
+	jffs2_dbg(1, "%s(): ino #%llu, page at 0x%llx, range %d-%d, flags %lx\n",
 		  __func__, inode->i_ino, folio_pos(folio),
 		  start, end, folio->flags.f);
 
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 4ad37a42c03d8357f3ef99596b725bea3db1932b..6ada8369a76227c30ec27e8efebd93939376494e 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -43,7 +43,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	int ret;
 	int alloc_type = ALLOC_NORMAL;
 
-	jffs2_dbg(1, "%s(): ino #%" PRIino "u\n", __func__, inode->i_ino);
+	jffs2_dbg(1, "%s(): ino #%llu\n", __func__, inode->i_ino);
 
 	/* Special cases - we don't want more than one data node
 	   for these types on the medium at any time. So setattr
@@ -243,7 +243,7 @@ void jffs2_evict_inode (struct inode *inode)
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 
-	jffs2_dbg(1, "%s(): ino #%" PRIino "u mode %o\n",
+	jffs2_dbg(1, "%s(): ino #%llu mode %o\n",
 		  __func__, inode->i_ino, inode->i_mode);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
@@ -334,7 +334,7 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 		ret = jffs2_read_dnode(c, f, f->metadata, (char *)&jdev, 0, f->metadata->size);
 		if (ret < 0) {
 			/* Eep */
-			pr_notice("Read device numbers for inode %" PRIino "u failed\n",
+			pr_notice("Read device numbers for inode %llu failed\n",
 				  inode->i_ino);
 			goto error;
 		}
@@ -351,7 +351,7 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 		break;
 
 	default:
-		pr_warn("%s(): Bogus i_mode %o for ino %" PRIino "u\n",
+		pr_warn("%s(): Bogus i_mode %o for ino %llu\n",
 			__func__, inode->i_mode, inode->i_ino);
 	}
 
@@ -374,12 +374,12 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 	struct iattr iattr;
 
 	if (!(inode_state_read_once(inode) & I_DIRTY_DATASYNC)) {
-		jffs2_dbg(2, "%s(): not calling setattr() for ino #%" PRIino "u\n",
+		jffs2_dbg(2, "%s(): not calling setattr() for ino #%llu\n",
 			  __func__, inode->i_ino);
 		return;
 	}
 
-	jffs2_dbg(1, "%s(): calling setattr() for ino #%" PRIino "u\n",
+	jffs2_dbg(1, "%s(): calling setattr() for ino #%llu\n",
 		  __func__, inode->i_ino);
 
 	iattr.ia_valid = ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_ATIME|ATTR_MTIME|ATTR_CTIME;
@@ -428,7 +428,7 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
 	struct jffs2_inode_info *f;
 	int ret;
 
-	jffs2_dbg(1, "%s(): dir_i %" PRIino "u, mode 0x%x\n",
+	jffs2_dbg(1, "%s(): dir_i %llu, mode 0x%x\n",
 		  __func__, dir_i->i_ino, mode);
 
 	c = JFFS2_SB_INFO(sb);

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
