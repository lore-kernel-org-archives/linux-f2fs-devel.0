Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CF9EB3633
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6U9ddyYfSG3A7EUhMyBrNsKFVtl/BhwriPYySOXLbE=; b=W56YsGfXO/pmVONES6MJ4MzdLF
	5qvAKd1ETeJTjNXWSdN2Tp34oAlbc1k2nHACYbv6+88bpPNhmEnurRermMPQ+CUtIZb6M2odjfm2k
	wN07IG4krUOZV0Tg9sllyfoJK/xeqXtg2jlNnTNpjDxf/JpTKOvFtKJFIJ+FPdmOWPmU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxABE-0003qv-9f;
	Mon, 02 Mar 2026 20:47:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jlayton@kernel.org>) id 1vxABC-0003qX-VC;
 Mon, 02 Mar 2026 20:47:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aTrF/gcP4a8NRAtNnRiPMhucgInwn7vNM2ZqmvOhTXU=; b=fwl/fxNH4jYj98dG/2TtR16NWt
 sIqootIkrdQgVn+rnbvSZHslgpVSufGDs6i2VnY3lclaLGkAQVUr7FzXkwzg4f7i4XD9KUyAPuQ60
 a+3fT3mp9YcgQsTCnypwGOL1aMevDKOFG1iBnCyEbl8bUYMOvq0bZJKKxQd/Ijyl+rMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aTrF/gcP4a8NRAtNnRiPMhucgInwn7vNM2ZqmvOhTXU=; b=Iqy3bzZudG/od7W4h1lbbt25Mp
 OshBvk/aQplzPSAW4XooPe/jO4WcYCgJHwGhRv3O5pIbh7CWffjJHBZHCWynXBlCBkls735wl68gC
 wqi9ScW+mXTCSEoo6lk2b9bw75Rbj+C46J1jk11h+2+Krq+tRKIF8UKgFI0vhq0vjCXU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxABC-0006wg-Hi; Mon, 02 Mar 2026 20:47:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3436643FFA;
 Mon,  2 Mar 2026 20:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D5CC19425;
 Mon,  2 Mar 2026 20:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772484465;
 bh=NxjvYMp7mxab9bptASYUwAt9ZY5sMtCtrMkINyf4Lcg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mKF118EbNTK1Q1JUm9zwYzLqmUqwW6hCPa6VhG06QJSh9gQRRQlhj48rBLELE2moS
 ar+wMJ0VUkk9bJ3zmdqav5lqol2OWllhoiXWdAhQiADxgu1TM32Uk3nkqrPSU1EBtC
 cOFO6OSQqnZrWXlWrX29lqXNAQDHdTGIkcRToSyBMgCrTEpUxTgYkfZBg/tJpvkClT
 4AUWKg+1Uj+xABZgUfW/xSDHNL8jydoULCCCXXJ6C4Ck1CZw+OWSCPQ5sjr2jCOUsU
 M22kG90SsDj2mIOwFRJCm9veSRej5OGv2Oqv0cm7PIOSvtGTv42ooCNsZ2RAPqSJmV
 YOhPUJxpdP5vA==
Date: Mon, 02 Mar 2026 15:25:19 -0500
MIME-Version: 1.0
Message-Id: <20260302-iino-u64-v2-95-e5388800dae0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NxjvYMp7mxab9bptASYUwAt9ZY5sMtCtrMkINyf4Lcg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBppfIJgP6owvPx6m4AecvkwS2n3SHqtsEhINcBU
 pHfVmz8frGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaaXyCQAKCRAADmhBGVaC
 FQGCEACfHvP6/q3GLuGZ3TS9t0/lSTulN0XS7r9+2/P3SZbBO22xao3gkyH9Kg0UHItz/okfvjd
 CBSNAlu0vC2UpEVaFkN0vJAy563Q5AEsg5zHOhDs/mCzlCxfWySyO3bIe7yoq/tTH7GqrUOPEKX
 ym072YWOMvHXuEFrJizTgOu0JwtiP9/CLIJuGbiokKXmELraTmmoIH/3hguaJSRDlUuKcWMuqOh
 V6lbAYhrp2Ww/+Z6oNOaADOIwcMvZeX0FbcwZc9cIUj3LojkSThWvRALJUImWCPjHmYHkzok6tV
 NQGX4vI+03B/kJa04kExDMCqhK/zaUfCJSbwbt8sm91xiIbijmBBqSSQ9Oph1yQG7fJIveQR3m6
 90vBLCxRjJIgD264u5wvR7VjZNdbEFZ1EzOPcQ2hP4mD/vT4jStUT6ZO+7KChUgKoGDbSXLXlVK
 YWtnAbs8gYWIZx++mqPFpNIQOq+2lH+0oGmU67E8s8GQn1tHV9kP3iwPiNiaBOzmWKYtiGrpueD
 e4xJZO2lhWqKQOOlU/Sewzw35+YTV3Qc0WqKBnLK+xNdb8CgMs8GTfxIeLxHXP8w4jxh7IpIy09
 ut6Y+AwYf0NWJq+dmqoYtGmDVp+LWbbU5O8xS+ngUV1Jn8NcXzZrnpn8L7PJQxM07xG1j7iqFML
 BGuz/QSgMhcfFng==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Headers-End: 1vxABC-0006wg-Hi
Subject: [f2fs-dev] [PATCH v2 095/110] qnx4: replace PRIino with %llu/%llx
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
replace all uses in qnx4 with the concrete format strings.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/qnx4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 1226de01f2d3c1d79fc054f2b882fdca2d9d78ff..4deb0eeadbdef3a580d57fbe4e8518da0f550cb7 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -62,7 +62,7 @@ static int qnx4_get_block( struct inode *inode, sector_t iblock, struct buffer_h
 {
 	unsigned long phys;
 
-	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%" PRIino "u] iblock=[%ld]\n", inode->i_ino, iblock));
+	QNX4DEBUG((KERN_INFO "qnx4: qnx4_get_block inode=[%llu] iblock=[%ld]\n", inode->i_ino, iblock));
 
 	phys = qnx4_block_map( inode, iblock );
 	if ( phys ) {
@@ -128,7 +128,7 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
 			brelse( bh );
 	}
 
-	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %" PRIino "u = %ld\n", iblock, inode->i_ino, block));
+	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %llu = %ld\n", iblock, inode->i_ino, block));
 	return block;
 }
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
