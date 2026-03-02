Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8DFEB3633
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qLbm3yWQD9bRLxUCGI9RbZq/IfTf0jgTH0LCxbUQmfc=; b=GpyZtVFhhXZVsQCGE9Rc41a33V
	I5BKiZstjKGihoi/bL85daxjwW/qiWTH13Mkl0pzklpGa5btxyDL1uzE6+KW3ExzAWz78EzflimaP
	1DClojxkYqamlxVfhtnF0t2Xz2G/+Xc9Zsfx/HkVnGPGhzcaX/P3/ztiRJ3T386Gj/y0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxAEb-0005W1-Nw;
	Mon, 02 Mar 2026 20:51:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jlayton@kernel.org>) id 1vxAEZ-0005VY-KH;
 Mon, 02 Mar 2026 20:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FMnXjX09cpgAbbnvNzwPBaBnYdpvcuQuDwHRdLD5uSo=; b=DNsvH5beFaE3pubjzt4eG+D8SY
 juZdIhjJkQHDaDCacVzoLJKkg1yzpjzBlKAlWBBZKN+CrRcO4/YIlqJh8fwnr6u0aMLYh97Go2VqQ
 3hK/TYb3mz3TgdmtKQZANw/mXmCDrYbyyXfPZQ3+PHCPWNGGwZqaRBgKrM3iWDYRZga4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FMnXjX09cpgAbbnvNzwPBaBnYdpvcuQuDwHRdLD5uSo=; b=jTDNm6GxLA3Y73X3M77Xa6LmZz
 aIAdO/J9w3sjKty+mQAVCmqZYV/wbiAKtgdLTTNaRNrS6wUr16ZZPA92I/8gaadsz2uNegy5GmQ/Q
 hFIjnXlmNkR9Pl6KInub8JfCJqDJcxlP0RNRoK3Elp6rGXu5gbvjIjcUk3HfGFouIaOs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxAEZ-0007LG-KT; Mon, 02 Mar 2026 20:51:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D546C6013C;
 Mon,  2 Mar 2026 20:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E3CC19425;
 Mon,  2 Mar 2026 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772484668;
 bh=bh/9FqQ+zYZ3KRPKzQcXTHwDk+54O75ySXqKcS7HYvs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ezajfXsx7jOzzXGyYD5JyoqhK8Em2M19Oms4vv5wm8s7gGd1RNIG17dLJ5uTr+5D6
 13XlSDniCDt/7J/ablb2gb7iBuW/Oox6Ug/Wbln6TdU5pjRwg8QqUZyvUmWrrwzdzh
 TdPoePjqX1wISY5ACwM75XnPKfo63iKnsAlgsvSfbHZnf07XlHfFY43qEpxpxB/MWl
 zscDqCe1CnjGQpXdKoCAVl0e8woVX3ioo/6Qwmd9fITJqR2AokFIdtHXdns/BkdG0u
 8tm3I731Q//Wx6DIYlJDNlt02wCFczoInqoYaDkiI/NtEl1kCXQ/RPXOqv4IcIOCPv
 17eeYGfWCbmqw==
Date: Mon, 02 Mar 2026 15:25:33 -0500
MIME-Version: 1.0
Message-Id: <20260302-iino-u64-v2-109-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bh/9FqQ+zYZ3KRPKzQcXTHwDk+54O75ySXqKcS7HYvs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfINtFesBvHoVALkwuzaop+mrk5+hHLUhRkav
 SbiQ5q2EFuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyDQAKCRAADmhBGVaC
 FaifD/93wgaFohJzMv84cczGy5tqsiSQqVwg9N8IAOpIePJgt0kVY/+xJf0mgMpNCnwO6zNhsuS
 g1IOSlsrTR/MJcpKIRNRt/reW3SdqaEBr7CdUBnbzbCxAGIB+xu/HLgkHB7/xhXL78vuqw+zKnn
 JWZDTxZoLmgiBqPUS8UuOWTjTgkdOZ3zJMEnhCZsH/bvVaqe/Rx87GvqY9JB1vVpsjXluNfRHKK
 wnBcICij2U5zjwQL5pknxzyX+HmPY8260HO4DpxpwCbbXYKu4ZWIJ/0RD/8Rxnqi9RMgWONvuJK
 t+OWOpldFH4s+VBc2nkWs/1iRttLrxwAIoTe727yA+1RDN0kDcWgo5OKw7ETerM45p0uldTJJZz
 +b+0XOeGvsVl2qkZ4+XzpPZhUWp47tWlf1PFhlW8GonbWOTaJNdK8qvCFr3zuvsSmJOiG/+rg5Q
 B2j6heaXrv7KtI4KgpYSMyno9u5SyNZcSqBZspBnXgh2tJj5aQYIxuCDdbq0L4shZAGYBclkCXT
 A78go1uY2C0RpRjk/L8MeHCIPpy2rSoZDGJjUO/g5YlhVBfxrWaCv8yPvr9+APQpC0tLwYTEh7+
 RFM6hW4wUjX/5fMwwSL9Dp6TWTKIc6GW5tTG3pc5VAzwgmOaFPDsLKARdA8RqzISSskdsOHTFvR
 wQa3ZehRJTPIiiA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Headers-End: 1vxAEZ-0007LG-KT
Subject: [f2fs-dev] [PATCH v2 109/110] uprobes: replace PRIino with
 %llu/%llx format strings
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
replace all uses in uprobes with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d5bf51565851223730c63b50436c493c0c05eafd..4084e926e284487ea7e28b63721797b20f0dfefd 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -344,7 +344,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 static void update_ref_ctr_warn(struct uprobe *uprobe,
 				struct mm_struct *mm, short d)
 {
-	pr_warn("ref_ctr %s failed for inode: 0x%" PRIino "x offset: "
+	pr_warn("ref_ctr %s failed for inode: 0x%llx offset: "
 		"0x%llx ref_ctr_offset: 0x%llx of mm: 0x%p\n",
 		d > 0 ? "increment" : "decrement", uprobe->inode->i_ino,
 		(unsigned long long) uprobe->offset,
@@ -982,7 +982,7 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 static void
 ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
 {
-	pr_warn("ref_ctr_offset mismatch. inode: 0x%" PRIino "x offset: 0x%llx "
+	pr_warn("ref_ctr_offset mismatch. inode: 0x%llx offset: 0x%llx "
 		"ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
 		uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
 		(unsigned long long) cur_uprobe->ref_ctr_offset,

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
