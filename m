Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A3606A338
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EckqmAz9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VO4IYF7x;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nKvqZ7Qi;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IPMpUAYf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=VZDS7tTJfGIo4XpjipevRan/iMWKiJRYLcJUo8ON+Qs=; b=EckqmAz9i3eumlmgJYArPEo6sy
	NucG0xl6WGzKgp7pabAp0rhtIxsTtLzql+bII1xAx04ONY8qT6G80HjEvDFKYi1RxdH3KH8i8Jhqo
	IqMpaQsVwQVNP5KYpH3P+rqmtCJje+j2n8mUJkGozPm7KNYapCYGtlrJJ84JqCBv+y8Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xKEUg-000000004oH-00xC;
	Fri, 23 Oct 2026 12:35:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xKEUe-000000004oA-1dvG
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dRvNq6pb6ywdYj3iS1o6fM4YSIqd7nISkOx7nY+yegk=; b=VO4IYF7x9YQya8obeXcuzH3Oal
 7HcScDfxsj4qw7g4sRC9YneYNfkYNxXjRQQD85wo4az+tHzYXYGi8JbCDvntNE46K+PIXaSIScrZS
 6YAiph3JdhvyBaBdzfpgdkIzXRKapCMHgNF8AAUTxSEqTsdwFnWeIlCSf+w+X3Drj3zU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dRvNq6pb6ywdYj3iS1o6fM4YSIqd7nISkOx7nY+yegk=; b=nKvqZ7QiP785H5mL41sy/IK5tY
 /qiZgA1LKVY12+RC7XxGN5mCv67oJIiy6pEzdYsL0fay7PMerl24LZ++BhD8Ih9OTMzKT8HlmDB2f
 9TDOaeougHs6DvCdFsg4ByfLzhhdMFrnSvwSRB888RwoZdDB+ymosf6bx3iiNzTLqvDg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xKEUb-000000003qP-3A4h
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:35:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 552F541887
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 23 Oct 2026 12:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B9A1F01825;
 Fri, 23 Oct 2026 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792758924;
 bh=dRvNq6pb6ywdYj3iS1o6fM4YSIqd7nISkOx7nY+yegk=;
 h=From:To:Cc:Subject:Date;
 b=IPMpUAYfBbjvhjzzvguVJ2skKOffxeCEnjhmCW96lbsm4BLNgHbYXI8V0hO9OcBwU
 frPYPb6qa189HzSUVL+GbR168xFF0QO7YFglfLZBkUJzhzikSiyHtAjZykMdakml1K
 Nttb4e6YOxGQWYfdiZSpIV/JgkoB7BtrZSVZFDWqxHIU++BgW/qlNg3rc6DOKDDeoW
 68NYw3tJ3ydDcu0dLHVHiOKWlO/mr/XbWbbtdtGormtcHpBDJ+9Z4vl2ztqnR8frtU
 cDEZCJ4+3sRI5jZop6o+55kONO5u7JU4sQpjRuye4BW4U+udVBE6nmIEZMhwFc7maG
 4HUEzS45GNaQw==
To: jaegeuk@kernel.org
Date: Fri, 23 Oct 2026 20:35:17 +0800
Message-ID: <20261023123518.504064-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xKEUb-000000003qP-3A4h
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix to fetch ino via ino_of_node()
 under cache lock
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

In f2fs_writeback_node_caches(), it's better to fetch ino via ino_of_node()
under cache lock, otherwise, node cache content may become stale after cache
is unlocked due to racing w/ truncation.

Commit 493b9dc8b52c ("f2fs: cache: use node cache") fixes similar issue in
f2fs_flush_inline_data() introduced in commit 34c061ad85a2 ("f2fs: Avoid double
lock for cp_rwsem during checkpoint").

Cc: stable@kernel.org
Fixes: 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 424e95ca5878..44f94000d452 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2195,9 +2195,11 @@ int f2fs_writeback_node_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 
 			/* flush inline_data */
 			if (f2fs_cache_test_inline(entry)) {
+				nid_t ino = ino_of_node(sbi, entry);
+
 				f2fs_cache_clear_inline(entry);
 				f2fs_unlock_cache(entry);
-				flush_inline_data(sbi, ino_of_node(sbi, entry));
+				flush_inline_data(sbi, ino);
 				goto lock_node;
 			}
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
