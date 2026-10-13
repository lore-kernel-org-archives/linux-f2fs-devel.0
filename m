Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F65ACA9ED2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ra+7Ocb+R7m8qQO24B4Ur3dZffXvFQTLSlz5eUbmcN8=; b=ANKPxbJ1giFgJ/KjBwdDL6rapX
	n9MhB26TThZbInOfKGh23CHYPjHAb9NAP/wngEhialC0UCvVtdNrMLxT59qHzwzi6fDg/HwOWduC2
	MH9hpq5oJS88hXNueykoXJtVRbyiqj8l6CGx3w3jYM6jTUj68qyRnrLo241tFuNb4YZc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGaBQ-0002Wu-RP;
	Tue, 13 Oct 2026 10:56:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGaAl-0002WD-T8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:55:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NJvSD+gIR0TJD53Ex3slDvieQEd2xTrsZ1lZ54elzsc=; b=V+EyAbNuGcvtAXMSg8sbmBZnqX
 jN/ulMITqwj4adaJUrv2+CMt/UHGz+31f3gYzcHG/eufgOpsg7mHh7PaK8BJl/bMdvFmpmYR7ollG
 bvVf3nxoAgXK871hnDRfli7DAi3JWL24Pu+xByyoBWKtOfVoLKApSNhFRzymz/ESMfYk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NJvSD+gIR0TJD53Ex3slDvieQEd2xTrsZ1lZ54elzsc=; b=B
 GWHKdDzfcIAVarvBIzMCmDkgEsDM0SsLW9w3Z5nwSyTnu9zJfb893pjA+/SGm3I7OKMDFAl36qXJe
 wbGMuEKXeA8e1E4a77vVX7wljNndNIMJDAACBzRK8E41S675nCpKQRsn/8gARLR0zEt63pwUQf7x9
 UyRO9is+Hfn5+5lk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGaAm-0003lw-0I for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:55:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6607C602C3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 10:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8AE1F00893;
 Tue, 13 Oct 2026 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791888950;
 bh=NJvSD+gIR0TJD53Ex3slDvieQEd2xTrsZ1lZ54elzsc=;
 h=From:To:Cc:Subject:Date;
 b=LATEmsWuJm+s3uPnKytlrQq0s3XJ1v3+TM0Fo5H4NlnwnLCkq5xqPisGJBdP5gptJ
 W1evG1sDhhxZgm/Mj5DzSsDIm8kBI1pIaIAuXcN8KUN+dEfheit2F4eQthh49sJ4kD
 b4v44P9KVFibyA+HiyLx3uNIKeqwW+nAB2+LFqQlVaYiRWjoApKUBBU+PIZX+TYo3U
 50Z1hpD2hXrRk0jsP6FC6tqU1zvJPehviLtwKbWD6SQvhND0yDXHJS8z69fbV83hnq
 kuSiv2UWqnUtBOawHBKMUPhZ6VCbf7UjTpP4d146GUx7W7X6uKCdhiR3HuzljUEK2p
 2OIyi66b20a0A==
To: jaegeuk@kernel.org
Date: Tue, 13 Oct 2026 10:55:38 +0000
Message-ID: <20261013105538.3636822-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xGaAm-0003lw-0I
Subject: [f2fs-dev] [PATCH] f2fs: fix to invalidate curseg if
 change_curseg() fails
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

From: Chao Yu <chao@kernel.org>

Our consistency stress test (fsstress + fio + atomic write workers +
"f2fs_io shutdown 1") triggers below kernel BUG:

 F2FS-fs (vdd): Stopped filesystem due to reason: 0
 ------------[ cut here ]------------
 kernel BUG at fs/f2fs/segment.c:3989!
 Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
 Workqueue: writeback wb_workfn (flush-253:48)
 RIP: 0010:f2fs_allocate_data_block+0x257a/0x38e0
 Call Trace:
  <TASK>
  do_write_block+0x155/0xc10
  f2fs_outplace_write_data+0x192/0x340
  f2fs_do_write_data_page+0xc57/0x1880
  f2fs_write_single_data_page+0xda9/0x15a0
  f2fs_write_cache_pages+0x973/0x1f20
  __f2fs_write_data_pages+0x6c4/0x1890
  do_writepages+0x21e/0x560
  __writeback_single_inode+0x119/0x11b0
  writeback_sb_inodes+0x67d/0x17a0
  wb_writeback+0x207/0x820
  wb_workfn+0x128/0xc30
  process_one_work+0x925/0x1600
  worker_thread+0x60a/0xff0
  kthread+0x35f/0x460
  ret_from_fork+0x474/0x7e0
  ret_from_fork_asm+0x1a/0x30
  </TASK>

The BUG is f2fs_bug_on(sbi, curseg->next_blkoff >= BLKS_PER_SEG(sbi))
in f2fs_allocate_data_block(), next_blkoff was 512.

The root cause is a race in between atomic write commit and shutdown
as below:

Thread A (commit atomic write)  Thread B (shutdown)        Thread C (writeback)
- f2fs_ioc_commit_atomic_write
 - f2fs_commit_atomic_write
  - __f2fs_commit_atomic_write
   - __replace_atomic_write_block
    - f2fs_replace_block
     - __f2fs_replace_block
                                - f2fs_ioc_shutdown
                                 - f2fs_do_shutdown
                                 : F2FS_GOING_DOWN_METASYNC
                                  - f2fs_sync_fs
                                                           - f2fs_write_single_data_page
                                                           : pass f2fs_cp_error() check
                                  - f2fs_stop_checkpoint
                                  : set CP_ERROR_FLAG
      - change_curseg
       - reset_curseg
       : curseg->segno = new_segno
       : curseg->alloc_type = SSR
       : curseg->next_blkoff = __next_free_blkoff()
         which is BLKS_PER_SEG if there is no free
         slot in new_segno
       - f2fs_get_sum_cache
       : return -EIO due to f2fs_cp_error()
      : return error w/o restoring curseg
     : goto out_unlock, skip restoring
       old segno, blkoff and alloc_type
                                                            - f2fs_do_write_data_page
                                                             - f2fs_outplace_write_data
                                                              - do_write_block
                                                               - f2fs_allocate_data_block
                                                               : curseg->segno is valid
                                                               : f2fs_bug_on(next_blkoff >=
                                                                 BLKS_PER_SEG)

Since commit 86f33603f8c5 ("f2fs: handle errors of
f2fs_get_meta_page_nofail"), change_curseg() can fail after the curseg
has already been switched to the new segment, then the curseg is left
in an inconsistent state: it points to a segment which may have no
free slot, its summary block is zeroed, and the caller can not restore
it. Subsequent block allocation on the curseg will trigger the BUG.
Moreover, the writeback thread dies with curseg_lock, curseg_mutex and
sentry_lock held, so the commit, shutdown and other I/O threads hang
in D state.

Since change_curseg() only fails once CP_ERROR_FLAG is set, no
checkpoint will be committed afterward, let's invalidate the curseg via
reset_curseg_fields() on failure, as new_curseg() does for -ENOSPC,
then f2fs_allocate_data_block() will fail with -ENOSPC on the curseg
instead of triggering BUG, and do_write_block() can handle the error
since CP_ERROR_FLAG has been set.

Cc: stable@kernel.org
Fixes: 86f33603f8c5 ("f2fs: handle errors of f2fs_get_meta_page_nofail")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dab66ab3311d..453f9284ec86 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3243,6 +3243,7 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 	if (IS_ERR(entry)) {
 		/* GC won't be able to use stale summary blocks by cp_error */
 		memset(curseg->sum_blk, 0, sbi->sum_entry_size);
+		reset_curseg_fields(curseg);
 		return PTR_ERR(entry);
 	}
 	sum_node = SUM_BLK_ENTRY_ADDR(sbi, entry, new_segno);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
