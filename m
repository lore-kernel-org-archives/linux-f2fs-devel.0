Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4FFCA5FF1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vtsr512MCQ5BjIGQHiUr/pL4SNcrnYenGTXsvoCF/OQ=; b=HzAkzOpmFnyEUahBlCE8Yies/J
	+j36xo87J9suv7vnc03JrF+x0486rj821NauAs/jY+xHp+yg+ZkmqytA4c2Mf66vx8YJns1f6FMu3
	0mCYpg2WBJWrh8sHs31STIUF7/uuviFdxxlHObcktPN3WrKZ4p2miSGOrrdq8g5ZgcLk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEOj2-0005kR-QR;
	Wed, 07 Oct 2026 10:18:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xEOim-0005jt-E5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 10:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y0GnRc4T4ZE9nqw5bVtX9AvOSXcgvcWFrOaRGb2SBZA=; b=W5kWsmBgRcIGCtt3MBKiFCjHD1
 ryxpNGP8GSL/lhRmL/zZNdMlzRAx0PUOsQafzec4VGF+Hsf3dKdl2O+Bt7pfh5aNmHXSidBv+n8Zp
 CljsIcaQQQulZ281XkoySBa40CWy1/6mkpVELV7CafeVjy/LHG40UfLG3F40DvnflGPw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Y0GnRc4T4ZE9nqw5bVtX9AvOSXcgvcWFrOaRGb2SBZA=; b=F
 nNp8YNGW/BUFaXY5pyK+EvoY+y33umvjzhV8oe7kM7MEy6Qq0I8RQ/qVDI9UTfsqxPFG14Gj8n/Sc
 mDG7HMMJflfl26dGaONLSZTXecxWU4OvdPeQjAvRaRioJzWUNie+5J04oqVZNG2KP4n6SgfTGwVIE
 w7BW3pSdViNVDSlc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEOii-000334-5W for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 10:17:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B82B601FB;
 Wed,  7 Oct 2026 10:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5E71F0089C;
 Wed,  7 Oct 2026 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791368270;
 bh=Y0GnRc4T4ZE9nqw5bVtX9AvOSXcgvcWFrOaRGb2SBZA=;
 h=From:To:Cc:Subject:Date;
 b=WXJr9iWzUetPxK+2oME2HcLBQfpvbTLx+pVOqI1/8VNqJvZL2n6MPZKNfVCB7Wo1o
 1rA+gxL9GtPv2ST/DmmkjKfNmfjELQjFqi6oalbxc+5+kxAdxIFOnvSZM8NGaXZlBh
 9pOeEuICelhpcu7TE8Q7vL0sppc/+XNZm/dWneTDnNDSztYYmb8Pt8tSav4NS+oN0j
 31HvrBEcLiZ8Bi61o+MhUTSKKjpUUIYvo3/TOAXUwfLqzGfGPzD8bQZaWbsD9zGGFu
 b8ZWPK7DR5GmM+65lQDoNPfSYiFTRQaKxN4NJE/VASoVvhf1KIeQ8DqtJZ9OtgicWJ
 LZwbl4pTmEXvA==
To: jaegeuk@kernel.org
Date: Wed,  7 Oct 2026 10:17:38 +0000
Message-ID: <20261007101738.2348038-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xEOii-000334-5W
Subject: [f2fs-dev] [PATCH] Revert "f2fs: skip node_change lock for inline
 data writes"
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

This reverts commit 66eec36c2421383e5b32e9c1740f656474c80df8.

Fault injection + shutdown stress test reports inconsistent inline
data after "f2fs_io shutdown 2" (mode=lfs, nonzone, segs=1):

[__chk_dentries:2067] [  6]-[0x26] name[0MVNBi,Cv33...] len[0x20] ino[0x4190] type[0x7]
[ASSERT] (fsck_chk_inode_blk:1142)  --> [0x4190] junk inline data
[fsck_chk_inode_blk:1150] ino[0x4190] has inline data!
...
[FSCK] other corrupted bugs                           [Fail]

ino 0x4190 is an encrypted symlink, the inode block pointed by the
last checkpoint's NAT entry contains valid inline data, however
F2FS_DATA_EXIST is not set in i_inline (i_size is stale as well).

The node_change rwsem was taken in prepare_write_begin() for inline
inodes in order to serialize write_begin with block_operations():
checkpoint holds node_change for write from the last check of
F2FS_DIRTY_IMETA until all dirty node blocks are flushed, so either
1) FI_DATA_EXIST is set before the check, the inode is in DIRTY_META
   list, and f2fs_sync_inode_meta() -> f2fs_update_inode() syncs
   F2FS_DATA_EXIST and i_size into the inode block before it is
   written by checkpoint, or
2) FI_DATA_EXIST is set after block_operations(), then the inode
   block written by this checkpoint does not contain the new inline
   data.

Commit 66eec36c2421 ("f2fs: skip node_change lock for inline data
writes") skips the lock for writes which fit in inline area, assuming
setting FI_DATA_EXIST only dirties inode metadata.
However, dirtying inode metadata after F2FS_DIRTY_IMETA was checked,
while f2fs_write_inline_data() (which never holds any checkpoint
lock) copies inline data into the inode block, breaks the above
ordering, then checkpoint persists an inode block which has inline
data but stale i_inline/i_size:

- f2fs_symlink                       - f2fs_write_checkpoint
 - f2fs_add_link                      - block_operations
  - f2fs_init_inode_metadata
  : i_inline = F2FS_INLINE_DATA
  - f2fs_update_parent_metadata
  : clear FI_NEW_INODE
                                       - f2fs_flush_inline_data
                                       - f2fs_lock_all
                                       - f2fs_down_write(node_change)
                                       : F2FS_DIRTY_IMETA is zero, skip
                                         f2fs_sync_inode_meta()
 - page_symlink
  - f2fs_write_begin
   - prepare_write_begin
   : missed f2fs_map_lock(), i.e.
     f2fs_down_read(node_change), so
     it isn't blocked by checkpoint
    - set_inode_flag(FI_DATA_EXIST)
    : inode becomes dirty, too late
  - f2fs_write_end
   - f2fs_i_size_write
 - filemap_write_and_wait_range
  - f2fs_write_single_data_page
   - f2fs_write_inline_data
    - memcpy_from_folio
    - f2fs_mark_cache_dirty
    : ientry has inline data, but
      no F2FS_DATA_EXIST in i_inline
                                       - f2fs_down_write(node_write)
                                       - f2fs_writeback_node_caches
                                        - __write_node_cache
                                        : write ientry w/ stale i_inline
                                       : F2FS_DIRTY_IMETA isn't rechecked
                                      - f2fs_flush_nat_entries
                                      - do_checkpoint
- f2fs_io shutdown 2
: dirty inode is lost, fsck finds "junk inline data"

Besides the fsck error, for regular inline file, stale i_size may
cause data loss after sudden power-off even if checkpoint is
committed.

Let's revert the commit to restore node_change serialization for
inline data writes, and add a comment above f2fs_map_lock().

Fixes: 66eec36c2421 ("f2fs: skip node_change lock for inline data writes")
Cc: Seongjae Jeong <jsjlee1020@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
Drop original one or apply this revert patch is both fine to me.
 fs/f2fs/data.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d4ba5e77906..4bfa301a5df6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3915,11 +3915,15 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	/* f2fs_lock_op avoids race between write CP and convert_inline_page */
 	if (f2fs_has_inline_data(inode)) {
-		if (pos + len > MAX_INLINE_DATA(inode)) {
+		if (pos + len > MAX_INLINE_DATA(inode))
 			flag = F2FS_GET_BLOCK_DEFAULT;
-			f2fs_map_lock(sbi, &lc, flag);
-			locked = true;
-		}
+		/*
+		 * it needs to cover FI_DATA_EXIST and inline data update w/
+		 * node_change, otherwise concurrent checkpoint may persist
+		 * inline data only w/o F2FS_DATA_EXIST.
+		 */
+		f2fs_map_lock(sbi, &lc, flag);
+		locked = true;
 	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
 		f2fs_map_lock(sbi, &lc, flag);
 		locked = true;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
