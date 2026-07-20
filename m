Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ECBC44515
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Km73Tq6+atVpIrZSvHh2B5GCmvK9NfsScDX6MOVY+gg=; b=P8uvO2AzpvN1447JH27kTS1vXN
	lN8c8j7hkrNEQrj1+0Qt+qwuvWLdofDRohOZ/OuvL3jBGYovrX1ERKowxzgeJ2K31cURk3TW1DXDN
	oGoCeX+u2exMevKrqkQRZLlIsaJOhCFGu5etvABWNk5/xc+L+fRzHU07m6B1l9WxoV4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlneS-0002Yp-Pc;
	Mon, 20 Jul 2026 13:03:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wlneR-0002Yi-B4
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:03:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3/RXqpH2A+Mx18dcLpvgIAxJG53mSbWCLS60eLPBuhc=; b=Qd/kZIUKGUleEqo49oiR+Ximiu
 48Q8x6wpeatVnT5c6g8b1Ir/ALPM7wfiEdYWG1onNH4u+M9zOv1pCYjHwSsqKdYcjouEKDbLnlINv
 1YizoWSzoDg4owtdRiBqJtbxxOdhqUIF7J2UGHuOpgqOGw1A7Riygg+0/br2nfOSz81s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3/RXqpH2A+Mx18dcLpvgIAxJG53mSbWCLS60eLPBuhc=; b=d
 FmD1jj6M4MXwiUd31EVnqs9ZG5IwkU+lgfGyXYXqE9uJZLziwsROpW7MLJxZSAYzHqOPBdO53d81S
 I3Lg7lywYAv+youXSk129AGc/m8bWY+kRB229UMRXnWUsz9z02eAPC5AThq2vjp0/dqaeJ1jlLg8p
 gnrIJ6rVAYeScjcQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlneQ-0001HC-NL for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:03:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FF6D40980
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 13:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C921F00A3A;
 Mon, 20 Jul 2026 13:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784552588;
 bh=3/RXqpH2A+Mx18dcLpvgIAxJG53mSbWCLS60eLPBuhc=;
 h=From:To:Cc:Subject:Date;
 b=g/DCLmbrxTt3o4FjZP2KRplto5OK45PsO2SbWCJI5r6W8Qqjb8Hll34g6g2Nx/5xu
 /sVxXRejG10RDdiCLFbGsWQTX65hKWX8O2WZjCxz+W3EV43lzn9n/dc9khGLqno4G6
 nUjdySfajCEQWSigdLBcM1DcKMVUPSRzSmhU5oS3tfN2q6RPuTx2MaPisBnQjWgp7F
 pvjKBWDVhNOraMUooZT/lUH9b5Ok3HNGgSAD6B5iydQXUllO19WPiUVnR/9njG+u6Z
 GZ19vyov9ZdEfkfj3hy6+BrYx5W0xOS5ItZNmN1tQLvJOeUY6HEixf5wjWYTZEVXMm
 h0bfyCW7XuiiA==
To: jaegeuk@kernel.org
Date: Mon, 20 Jul 2026 21:03:01 +0800
Message-ID: <20260720130301.3530581-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
MIME-Version: 1.0
X-Headers-End: 1wlneQ-0001HC-NL
Subject: [f2fs-dev] [PATCH v2] f2fs: fix to zero post-EOF data when
 extending file size
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

generic/794  4s ... - output mismatch (see /share/git/fstests/results//generic/794.out.bad)
    --- tests/generic/794.out   2026-06-12 08:46:32.766426241 +0800
    +++ /share/git/fstests/results//generic/794.out.bad 2026-07-05 18:32:55.000000000 +0800
    @@ -1,4 +1,16 @@
     QA output created by 794
     append_write
    +FAIL: non-zero data in gap [4080,4096) after shutdown+remount
    +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
    +*
    +001000
     truncate_up
    ...
    (Run 'diff -u /share/git/fstests/tests/generic/794.out /share/git/fstests/results//generic/794.out.bad'  to see the entire diff)
Ran: generic/794
Failures: generic/794
Failed 1 of 1 tests

Steps of generic/794:
1. write 4096 bytes to file w/ 0x5a
2. use fiemap to get PBA of first block in file
3. truncate file to 4080
4. umount; write 4096 bytes to file w/ 0x5a directly via PBA; mount
5. extend filesize via
   a) append 4096 from offset 4096, or
   b) truncate 8192, or
   c) fallocate 4096 from offset 4096
6. verify the gap is zeroed in memory [4080,4096)
7. sync range 4096 from offset 4096; shutdown -f (flush meta before shutdown)
8. umount; mount; verify [4080,4096) is zeroed or not.

When extending file size (e.g. via truncate, fallocate, or write) across an
unaligned EOF boundary, we need to ensure that post-EOF data in the partial
page is zeroed out in pagecache and marked dirty, meanwhile, tagging the inode
with FI_ZERO_POST_EOF, so that following checkpoint() and fsync() can persist
the page contain zeroed data before committing inode w/ updated i_size.

This help to prevent stale disk data beyond the previous EOF from being exposed
after remounting or crash recovery.

Since f2fs is a LFS filesystem, we only support direct write via PBA in pinfile,
and pinfile has section-aligned filesize, so in Android, there should no problem,
but for other usage in different environment, let's fix this w/ fsync_mode=strict
mount option.

Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2:
- fix to set wb_task to avoid f2fs_balance_fs() during checkpoint
- don't skip mapping_empty() check in f2fs_zero_post_eof_page()
 fs/f2fs/checkpoint.c |  8 ++++++++
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/file.c       | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 064f5b537423..8bc0b2f33ad6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1359,6 +1359,14 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 		inode = igrab(&fi->vfs_inode);
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
 		if (inode) {
+			if (is_inode_flag_set(inode, FI_ZERO_POST_EOF)) {
+				F2FS_I(inode)->cp_task = current;
+				F2FS_I(inode)->wb_task = current;
+				filemap_write_and_wait(inode->i_mapping);
+				F2FS_I(inode)->wb_task = NULL;
+				F2FS_I(inode)->cp_task = NULL;
+				clear_inode_flag(inode, FI_ZERO_POST_EOF);
+			}
 			sync_inode_metadata(inode, 0);
 
 			/* it's on eviction */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8011bbdf2c68..64d3dae7b507 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -939,6 +939,7 @@ enum {
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
 	FI_OPENED_FILE,		/* indicate file has been opened */
 	FI_DONATE_FINISHED,	/* indicate page donation of file has been finished */
+	FI_ZERO_POST_EOF,	/* indicate unaligned EOF gap was zeroed in pagecache */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c54897a25981..0207e3be0b6d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -36,21 +36,48 @@
 #include <trace/events/f2fs.h>
 #include <uapi/linux/f2fs.h>
 
+static int fill_zero(struct inode *inode, pgoff_t index,
+					loff_t start, loff_t len);
+
 static void f2fs_zero_post_eof_page(struct inode *inode,
 					loff_t new_size, bool lock)
 {
 	loff_t old_size = i_size_read(inode);
+	unsigned int offset;
+	bool strict =
+		F2FS_OPTION(F2FS_I_SB(inode)).fsync_mode == FSYNC_MODE_STRICT;
 
 	if (old_size >= new_size)
 		return;
 
-	if (mapping_empty(inode->i_mapping))
+	if (!strict && mapping_empty(inode->i_mapping))
 		return;
 
 	if (lock)
 		filemap_invalidate_lock(inode->i_mapping);
+
 	/* zero or drop pages only in range of [old_size, new_size] */
 	truncate_inode_pages_range(inode->i_mapping, old_size, new_size);
+
+	/*
+	 * When expanding an unaligned EOF size, zero post-EOF data in
+	 * pagecache and set FI_ZERO_POST_EOF, so following checkpointing
+	 * or fsync can persist correct data to disk before committing
+	 * inode w/ updated i_size.
+	 */
+	if (!strict)
+		goto out_unlock;
+
+	offset = old_size & (PAGE_SIZE - 1);
+	if (offset) {
+		unsigned int len = min_t(loff_t, PAGE_SIZE - offset,
+							new_size - old_size);
+		pgoff_t index = old_size >> PAGE_SHIFT;
+
+		fill_zero(inode, index, offset, len);
+		set_inode_flag(inode, FI_ZERO_POST_EOF);
+	}
+out_unlock:
 	if (lock)
 		filemap_invalidate_unlock(inode->i_mapping);
 }
@@ -304,6 +331,13 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	if (S_ISDIR(inode->i_mode))
 		goto go_write;
 
+	if (is_inode_flag_set(inode, FI_ZERO_POST_EOF)) {
+		ret = filemap_write_and_wait(inode->i_mapping);
+		if (ret)
+			return ret;
+		clear_inode_flag(inode, FI_ZERO_POST_EOF);
+	}
+
 	/* if fdatasync is triggered, let's do in-place-update */
 	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(inode, FI_NEED_IPU);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
