Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCC2EB3633
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mwVrDxMzQMGdt5q/CkSncGqutFKxcsHKA7+Qm4GxQzY=; b=Z70iYJjfTFp63TXJhwQ/e3BPyG
	GiRz4cYjlBY5aSlIZHDZTV9a0Tg8t4vOZmM7SH4nAdqCbhCfhK0+IQnTMwizcW20ZFeR4N6pIBgPd
	KQiRtqYMyPn3klbxhme12Zx4ehF45KxSxCZ0GrPrBychcLDR9Hf/bmVj7SmC3gn//yFw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxA4X-0003zN-DY;
	Mon, 02 Mar 2026 20:40:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jlayton@kernel.org>) id 1vxA4V-0003yf-03;
 Mon, 02 Mar 2026 20:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dT6fK/x+4Bt6qo6SA5ClpthLnGEOvYOzDfjZSeEA748=; b=gW+CuOEF1IMvJpG3gXR9eKuIYP
 p6AM20HVtsNQKKbYxsVDV1ftB3FNmIj/J/sFGvxtDKI2xAMFaNeqAoPTKkoQ6Kq7sQb3dycmbnBwD
 eNgQpHqcP1HFFpNNhDWiHvCNyCWVjIhu/v/5UTLmqMDB1/rruzaQN2zyN4OBCufGYOhg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dT6fK/x+4Bt6qo6SA5ClpthLnGEOvYOzDfjZSeEA748=; b=OMk25BITxAbCsladEwGC2jANbQ
 Da1g+mxoPRoBFLpXL7s1dUi+lTFXAi8bB0/L3fGhI8XScslfLRxyRzWAxdXlBo81Y6fR9oZoyChbM
 AsdwMAuD/DGW4xUcyMCRtXtwXMhjjuEsaxXjWtYovOUW4z+QFMATc6C6D6Q3amSEikcY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxA4U-0006BB-LM; Mon, 02 Mar 2026 20:40:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B159415F6;
 Mon,  2 Mar 2026 20:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD2DC2BCB3;
 Mon,  2 Mar 2026 20:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772484049;
 bh=HyR4sniz95teBoJHWgP/H2+rStT6qfCUCVZPgmMuwcs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=m+cQsJz3LSlySQ/LkV8g0UkbIMSqSvNRtu7xio/tlhYMu/YSnzafEF+V8yjx+SjoM
 yl0M/ozfu9C0JcgOkGK/507Jp7sC4ljOg6kEdREcBn4IkMyNyOJ4T84BND1Zg7v78x
 ecHvzizX37InYHwAZdg/VtThEzoQyj1CdG+IztwgFiQ6MfW/1qLXGYYw+CWVbCT3b0
 nGPk0wgOJFoUd918Owmtl8+//s429jEFvcNcVLX+GX0/YsE9Z2aPE0UNuexhzbxM4P
 gBngfBKui4FXJQDOZXLnIHPqvzn5fUbR/gxU02itW5JApfugQvpKnJGfTWDqkVmMnz
 /I5TauxXOf9mQ==
Date: Mon, 02 Mar 2026 15:24:50 -0500
MIME-Version: 1.0
Message-Id: <20260302-iino-u64-v2-66-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HyR4sniz95teBoJHWgP/H2+rStT6qfCUCVZPgmMuwcs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIA0Fa1714anVwENAiRmnB+U/0TA0CuNSmGy
 S5/qF96pyOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyAAAKCRAADmhBGVaC
 FW3MEADU+whCFtqkgurCGlaONnct++YahRLhSTluVahbwEwdjbrbG7/7TsgiZPqagHMLlQ75BmW
 ylyzoMJID0RQLRuriVYXFqgM1bsGBWwWUE5vQeLlq/U6V9hQ14AflkyIYQCaxrhsZ/BRchuJOVe
 YGfTn8zZLGQyhgcOMKgJPctCMtYNJI0dDTP+TdxEAXO4FVzGpuq4ISjGB4rVspIzqwJZ9vTDDeH
 RaPDWEy47VzON4mSIyPGs2bMeKXmNuzabCV42blfkozkCYDmWnCoil2ws40UOZyww0F2inVxIm1
 biCcqKW/4hLNP+Jg6A+FMqTdqxNXscogSoAZzVZ8SHrisiZqvfqY0cwdhGKoIb3oPmZzfohHl7I
 bEk6mxpcNHe0P05heIjqcvKOXsnJUP+v4/D62nRiOfEtOJny85qobmr26MZxCVFiq6a3Ct1b5mN
 y1XG538Y1/cHD9aEh7GND7hy1awXpMnPjoVqIjeMXMSRKNn/0LY7Be9TT21yUHp+08h0uxyOnik
 1idly8EzgBBEw1zwwIybPJxNgbwUjqF9nlUaZ1p4VRHFedCPKrra1FIbZuRVqhQU4P8fHZ0BwK8
 mTiKztWgspKLCYLbVwNJ96kS6/jElrgR3RBA/IxZyawPb5WdB+8xtUZZoi/8ynJDTOwOB4MOfoN
 M20Iy7wAit/xe/A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Headers-End: 1vxA4U-0006BB-LM
Subject: [f2fs-dev] [PATCH v2 066/110] nfsd: replace PRIino with %llu/%llx
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
replace all uses in nfsd with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c    | 2 +-
 fs/nfsd/nfs4state.c | 4 ++--
 fs/nfsd/nfsfh.c     | 2 +-
 fs/nfsd/vfs.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 5dfdd836bbb63d6af17204c8df7ecf3f450998c2..d2259d948cc33e1c192531d34679123b826cf4dc 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1039,7 +1039,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 	}
 	inode = d_inode(path.dentry);
 
-	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%" PRIino "u)\n",
+	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%llu)\n",
 		 name, path.dentry, clp->name,
 		 inode->i_sb->s_id, inode->i_ino);
 	exp = exp_parent(cd, clp, &path);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d9d548225afb764326b2bb211919e24c87f15a00..a569d89ac9123d66bb47e7d74c7c98610de21da2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1253,7 +1253,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 	if (ret) {
 		struct inode *inode = file_inode(f);
 
-		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%" PRIino "u: %d\n",
+		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%llu: %d\n",
 					MAJOR(inode->i_sb->s_dev),
 					MINOR(inode->i_sb->s_dev),
 					inode->i_ino, ret);
@@ -2888,7 +2888,7 @@ static void nfs4_show_superblock(struct seq_file *s, struct nfsd_file *f)
 {
 	struct inode *inode = file_inode(f->nf_file);
 
-	seq_printf(s, "superblock: \"%02x:%02x:%" PRIino "u\"",
+	seq_printf(s, "superblock: \"%02x:%02x:%llu\"",
 					MAJOR(inode->i_sb->s_dev),
 					 MINOR(inode->i_sb->s_dev),
 					 inode->i_ino);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 22df07be0650d9260a30e12c1371ccc4f89234db..ee72c9565e4fe85356674b22b4505d3d531dbe40 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -601,7 +601,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	struct inode * inode = d_inode(dentry);
 	dev_t ex_dev = exp_sb(exp)->s_dev;
 
-	dprintk("nfsd: fh_compose(exp %02x:%02x/%" PRIino "u %pd2, ino=%" PRIino "u)\n",
+	dprintk("nfsd: fh_compose(exp %02x:%02x/%llu %pd2, ino=%llu)\n",
 		MAJOR(ex_dev), MINOR(ex_dev),
 		d_inode(exp->ex_path.dentry)->i_ino,
 		dentry,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4c2095c83503e7fddc7e1ec528f55e36b6a326a4..eafdf7b7890fdee55ddf802d040363f33a7be628 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1163,7 +1163,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	} else if (unlikely(host_err == -EINVAL)) {
 		struct inode *inode = d_inode(fhp->fh_dentry);
 
-		pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%" PRIino "u\n",
+		pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%llu\n",
 				    inode->i_sb->s_id, inode->i_ino);
 		host_err = -ESERVERFAULT;
 	}

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
