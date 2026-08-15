Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A41C5DF6E
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 Aug 2026 00:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rx8BypZ2PkFLK8ufp7OBBGCPyTLfegG7tgzHHfGUIuA=; b=ifMh/6NZhdgvX3+ckgw6lungaJ
	tH/iGCv9DOwQUEyszuSg1A5C3bz8Yaz6pfbAKciqTEGJfMnb/iTAgket7PpXXHRMwCwdCQOzFBPJR
	k4mE48FTKHRlU4oBGykYL/x/V3O82s0p9v6uSA4vpVW8mNtzS7vPejizBpfUWzBbucuc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wv2gN-0001wV-4A;
	Sat, 15 Aug 2026 00:55:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wv2fu-0001w9-SE
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 00:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8DHmJF2ZtopzKqydRaDGN7e5alQPJiqpq+1JLMhGR6Y=; b=KVj6UxXdH3+7EUKI8YIdqCLE7A
 aILzUAjFQb6pv8CRWEXHV2ZYZSMSWt5iZUSfob6wkpuOi0o3t3GMOxqjooxJ1wUwv46Vl5mZzVu0Y
 wNn09cjl0w2yyfhqAYKhWjbeCXXMeKeJSiTRZQTOigIUvXAr+NJ5gDGe7e6yrJd8aMt4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8DHmJF2ZtopzKqydRaDGN7e5alQPJiqpq+1JLMhGR6Y=; b=j
 TLpsrdn7dB2wKMZt9pQc4tIWaJIY0iuecLTP0ymnCFTW+CIzRmvaeHUxt2gg0odrmhL5MAkWlVXMc
 XMXCHqTrcVlsd+EyBQo9mFjlX7jzZTJJDZPLpgAilbdfAu9Dr6/zkoBKZfHodYi4FH0npwBrZmfFw
 B7syn9Q9cB2/s8tg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wv2fv-0001Iy-3M for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 00:55:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EC3B600E2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 00:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F81A1F000E9;
 Sat, 15 Aug 2026 00:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786755297;
 bh=8DHmJF2ZtopzKqydRaDGN7e5alQPJiqpq+1JLMhGR6Y=;
 h=From:To:Cc:Subject:Date;
 b=OT6PeBFaDkHNWiR5oYxVCFfDWfO0G4gYVQyi6j/sXawi+vbdluoN76crc253uPIL/
 vexUC9U9Wm8wm/FE9jh0MjbK+eoEcDE8ogpOA3q56J2yNAU5BiCY9Rgww9yEcCiznD
 uo5yJnVhPF+2iGmad9pLUh/8OOlBz0pw1O494t9qU3BLVbgTUBHdTqx+3es5c5xWMk
 6x6EDCbAKIo08Y2HGJUXhqXUpJnKUu1p3Ho+UHlsGgMTQsVaPHjAjMnFuZBzZA/wDT
 0M5A+QpIn5i3ZTH4mWPvKnbFkHGwPn9TQRXFjiFdZeM/rV5IvDbsYNFSm5I/4uNj4p
 y+6G52ENQwh1w==
To: jaegeuk@kernel.org
Date: Sat, 15 Aug 2026 08:54:38 +0800
Message-ID: <20260815005441.1444273-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
X-Headers-End: 1wv2fv-0001Iy-3M
Subject: [f2fs-dev] [PATCH 1/3] fsck.f2fs: fix to avoid memory leak reported
 by LeakSanitizer
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

==5957==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 4096 byte(s) in 1 object(s) allocated from:
    #0 0x7f08b78bc340 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55b9e0fcbcc7 in update_data_blkaddr /share/tools-f2fs/fsck/mount.c:2523

SUMMARY: AddressSanitizer: 4096 byte(s) leaked in 1 allocation(s).

When a process calls exit(), the C runtime executes all registered
atexit handlers.
AddressSanitizer / LeakSanitizer (LSan) hooks into exit() to inspect
the heap, it checks whether all memory allocated via malloc() / calloc()
was explicitly released.

Relocate sanity check and ASSERT(0) before node block allocation to fix
this issue.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/mount.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 2e7ea45..26f213e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2520,22 +2520,22 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
 	if (node_blk == NULL) {
 		struct seg_entry *se;
 
-		node_blk = (struct f2fs_node *)calloc(F2FS_BLKSIZE, 1);
-		ASSERT(node_blk);
-
 		get_node_info(sbi, nid, &ni);
 
-		/* read node_block */
-		ret = dev_read_block(node_blk, ni.blk_addr);
-		ASSERT(ret >= 0);
-		node_blk_alloced = true;
-
 		se = get_seg_entry(sbi, GET_SEGNO(sbi, ni.blk_addr));
 		if (IS_DATASEG(se->type)) {
 			ERR_MSG("NAT and SIT is inconsistent: ino: %u, nid: %u, blkaddr: %u, segtype: %d",
 				ni.ino, ni.nid, ni.blk_addr, se->type);
 			ASSERT(0);
 		}
+
+		node_blk = (struct f2fs_node *)calloc(F2FS_BLKSIZE, 1);
+		ASSERT(node_blk);
+
+		/* read node_block */
+		ret = dev_read_block(node_blk, ni.blk_addr);
+		ASSERT(ret >= 0);
+		node_blk_alloced = true;
 	}
 
 	/* check its block address */
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
