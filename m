Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4397DCA5FC4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8BODZuZ+xlCqtSl1wpG7Yh3xDwWmTLdiklJDdvOMgr8=; b=U8i4auCDKLIH7NX7lBr76IEAr+
	cn/sZP76zHHO/YSqKOIfXbI9xke4Oy37+t0QcKrTRm1voq6XYYRG5xs+63k78QG2MjbWEszGRaFbZ
	7mCQXzZsTFWcnjlO5ETAuPbbx4Jmw8wmCco7tc33hr8nSCl3rE9yskj9cQ8pX2Cvr7fs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xC4In-0007Ia-3A;
	Thu, 01 Oct 2026 00:05:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xC4IQ-0007IG-8W
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 00:05:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AUCZXbZz+9GVnFuLz2w8O+q2b2dH2s881L1+FJnaSis=; b=A/bYzyr3Gwmcg7uueoHLL0mqki
 VfCtDoGtqURz0Cs6bweg8nD28YfW8LGxwGDBLOGGdINm1WBIoC3m6OgwH/aHhpRZmuqQq2TTzKtCz
 uGUjtOvjKXJhK56NPZXuZSQ7kDE5xdVcCHs3n27sThigHb9XBtys07ADclsBJIYMHRyA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AUCZXbZz+9GVnFuLz2w8O+q2b2dH2s881L1+FJnaSis=; b=C
 pAxdsBv1QXbGkSL373Jlv2mZHKh5K6S8utGpC50CWB+V5Hrwx3uJDZK/0AXglAe9l4Mv1e/JvLEs+
 /WfU1god1QKRpUybvEKTulW5VPGD3eN/Qpd/oZ7stmMj00aDE2/0BxPhwpUWF/eM4duuySl1zCzgZ
 tFNgBJ+lkkpYfmDE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xC4IM-0002US-Bj for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 00:05:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0604041904;
 Thu,  1 Oct 2026 00:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D9B1F000FF;
 Thu,  1 Oct 2026 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790813100;
 bh=AUCZXbZz+9GVnFuLz2w8O+q2b2dH2s881L1+FJnaSis=;
 h=From:To:Cc:Subject:Date;
 b=CyylUcMuB8QBKDLToso4FTP5kV5QwsavuiwU31FyztmHqryt4pswWrPTsgUe/cmLi
 Ya8HzcxoURqKb59/vjKkby9Gk4VH6afhFEiuvQtUhk2dGsRYI2tSPJ/4kQ8eOX1E8z
 M3yKCahavlsupVeSj8TzGYVvzCJK3DazEosSkLoWYyNYOi/zg+NApi/rcOcuFWtpqq
 dkww9kXtQUc/9aMuQ6dJO/6maEHjPj6ZqVuUu7A9JZU3G/+wdCRA/ifa/8rm7kP/F4
 +kDUtpvL+PXBCFFUKz6JzALjS6FsAaq0YV4JP35YbZQkg76ER/2GXBf6MRotAaeR4O
 vZn1ZyEEZWl3w==
To: jaegeuk@kernel.org
Date: Thu,  1 Oct 2026 00:04:50 +0000
Message-ID: <20261001000450.3822520-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xC4IM-0002US-Bj
Subject: [f2fs-dev] [PATCH] f2fs: fix to set sbi->log_blocksize in advance
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
Cc: linux-kernel@vger.kernel.org,
 syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

syzbot reported a shift-out-of-bounds in __f2fs_commit_super():

UBSAN: shift-out-of-bounds in fs/f2fs/super.c:3950:27
shift exponent 4294967287 is too large for 64-bit type 'sector_t'
(aka 'unsigned long long')
CPU: 1 UID: 0 PID: 5622 Comm: syz-executor329 Not tainted
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
 __f2fs_commit_super+0x43e/0x4d0 fs/f2fs/super.c:3950
 sanity_check_area_boundary+0x7c5/0xe20 fs/f2fs/super.c:4040
 sanity_check_raw_super fs/f2fs/super.c:4215 [inline]
 read_raw_super_block fs/f2fs/super.c:4625 [inline]
 f2fs_fill_super+0x1920/0x7fa0 fs/f2fs/super.c:5160

Commit b32d4bdbae61 ("f2fs: parameterize sector conversion macros")
parameterized SECTOR_FROM_BLOCK() with sbi->log_blocksize, where
F2FS_LOG_SECTORS_PER_BLOCK(sbi) evaluates to (sbi->log_blocksize - 9).

During mount, read_raw_super_block() calls sanity_check_raw_super()
before sbi->log_blocksize is initialized in init_sb_info(). If the
image requires alignment fixing (main_end_blkaddr < seg_end_blkaddr),
sanity_check_area_boundary() updates raw_super->segment_count and calls
__f2fs_commit_super() to write back the superblock.

At this point, sbi->log_blocksize is still zero, leading to an underflow
in (0 - 9) = 4294967287 and triggering UBSAN shift-out-of-bounds when
computing SECTOR_FROM_BLOCK(sbi, folio->index).

Fix this by initializing sbi->log_blocksize from raw_super->log_blocksize
prior to calling __f2fs_commit_super() in sanity_check_area_boundary().
Note that raw_super->log_blocksize has already been validated against
PAGE_SHIFT earlier in sanity_check_raw_super().

Fixes: b32d4bdbae61 ("f2fs: parameterize sector conversion macros")
Reported-by: syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dfcbc1741488709db4b2
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fc3be097285b..8d9aaf21655a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4038,6 +4038,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 			res = "internally";
 		} else {
+			/*
+			 * __f2fs_commit_super() will access log_blocksize
+			 * in SECTOR_FROM_BLOCK(), init it in advance.
+			 */
+			sbi->log_blocksize =
+				le32_to_cpu(raw_super->log_blocksize);
 			err = __f2fs_commit_super(sbi, folio, index, false);
 			res = err ? "failed" : "done";
 		}
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
