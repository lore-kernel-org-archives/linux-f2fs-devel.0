Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BFFF9937D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:In-Reply-To:Date:From:To:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=jO7uiehPsFpYWhRIfAfWShdwrgmiUf2Q5fS4tTH9o0Y=; b=Bhj4JNsRJ8D8tp21wRf12b95Br
	eFMrZSIwKJzI5XEFu1rzzc9bkYFn/7wTcmkuFt4c19gNpz08y+qU9dmzpOuc8PAV6wL8wrRnXJHFO
	lqCkpt5VJTPg4gu0ObQZCi6JmNYJNDy+Gk0TX1jbNe50BNhoGwEMazjyq+EROGatjJfM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFsae-0005Qy-KK;
	Thu, 23 Apr 2026 11:51:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gregkh@linuxfoundation.org>) id 1wFsad-0005Qp-Vc
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 11:51:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:In-Reply-To:Date:From:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t/SEj8adaLigsLhjIR7BpyKNDaIOFtUH8CzFiRdI8Zo=; b=lxtOSAZ66oHlyT5O1BtKBiD473
 X+893KMcfuJLjkG3JNiGqKHLOe9jDI6tKlo+UlLJgFCjwBCcT6pKr4a1JTzYaTjPU1g/kiiwHGKL5
 Rlx7Nckynz0Gf8/+JvwxcV3cbgA0tB98z1DMq4Dz6bwwSbEupy4R+JOEju7X6cuxamb4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 In-Reply-To:Date:From:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t/SEj8adaLigsLhjIR7BpyKNDaIOFtUH8CzFiRdI8Zo=; b=aS+7XSH7pP0tysQ70r54oTxiTc
 sMgb8NKzNQTmzX3RiRgqFaZnlnFGQbcFxJOezjkUtFABsoEsLGQqu3ndYbKeabBj2EQqyq4wxv1In
 jBsS/gwy5fWNqC6z22zbEhV8xYSwzoh9YCBsgfSiZj3Hki5XG1/sIATXyOkjwZ0gdVCM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFsae-0001v9-1o for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 11:51:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A4F7343A53;
 Thu, 23 Apr 2026 11:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39ED6C2BCB3;
 Thu, 23 Apr 2026 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1776945082;
 bh=IOWknTxYHvsittigFwjgop2S8p/X2WOmd0RKuLL+O88=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=Px1Li/S3P++WGQx2PoQC4kfsix8ouZa6IvPTTM8TXnXjFFhpAZrk4wj0TNxa5Wsc4
 O6xYh6XmpPiyO7F3Koa0loPgo4t/O2uQ6rqo19GKUEQmBmaj7fb2ZyTwrA31Wl71sR
 9hrQoU9lY464pYp2BW0K3trhhMGdMNMBMKn7h6oA=
To: chao@kernel.org, gregkh@linuxfoundation.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, rob_garcia@163.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Apr 2026 13:50:43 +0200
In-Reply-To: <20260317023933.1654240-1-rob_garcia@163.com>
Message-ID: <2026042343-depth-ozone-4a52@gregkh>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-Headers-End: 1wFsae-0001v9-1o
Subject: [f2fs-dev] Patch "f2fs: fix to wait on block writeback for
 post_read case" has been added to the 5.15-stable tree
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
Cc: stable-commits@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


This is a note to let you know that I've just added the patch titled

    f2fs: fix to wait on block writeback for post_read case

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     f2fs-fix-to-wait-on-block-writeback-for-post_read-case.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-225733-greg=kroah.com@vger.kernel.org Tue Mar 17 03:41:01 2026
From: Robert Garcia <rob_garcia@163.com>
Date: Tue, 17 Mar 2026 10:39:33 +0800
Subject: f2fs: fix to wait on block writeback for post_read case
To: stable@vger.kernel.org, Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Robert Garcia <rob_garcia@163.com>, linux-kernel@vger.kernel.org
Message-ID: <20260317023933.1654240-1-rob_garcia@163.com>

From: Chao Yu <chao@kernel.org>

[ Upstream commit 55fdc1c24a1d6229fe0ecf31335fb9a2eceaaa00 ]

If inode is compressed, but not encrypted, it missed to call
f2fs_wait_on_block_writeback() to wait for GCed page writeback
in IPU write path.

Thread A				GC-Thread
					- f2fs_gc
					 - do_garbage_collect
					  - gc_data_segment
					   - move_data_block
					    - f2fs_submit_page_write
					     migrate normal cluster's block via
					     meta_inode's page cache
- f2fs_write_single_data_page
 - f2fs_do_write_data_page
  - f2fs_inplace_write_data
   - f2fs_submit_page_bio

IRQ
- f2fs_read_end_io
					IRQ
					old data overrides new data due to
					out-of-order GC and common IO.
					- f2fs_read_end_io

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Minor context change fixed. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2537,9 +2537,6 @@ int f2fs_encrypt_one_page(struct f2fs_io
 
 	page = fio->compressed_page ? fio->compressed_page : fio->page;
 
-	/* wait for GCed page writeback via META_MAPPING */
-	f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
-
 	if (fscrypt_inode_uses_inline_crypto(inode))
 		return 0;
 
@@ -2718,6 +2715,11 @@ got_it:
 		err = -EFSCORRUPTED;
 		goto out_writepage;
 	}
+
+	/* wait for GCed page writeback via META_MAPPING */
+	if (fio->post_read)
+		f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
+
 	/*
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.


Patches currently in stable-queue which might be from rob_garcia@163.com are

queue-5.15/sunrpc-lock-against-sock-changing-during-sysfs-read.patch
queue-5.15/smb-client-fix-potential-uaf-in-smb2_is_valid_oplock.patch
queue-5.15/pstore-inode-only-d_invalidate-is-needed.patch
queue-5.15/wifi-iwlwifi-read-txq-read_ptr-under-lock.patch
queue-5.15/alsa-control-avoid-warn-for-symlink-errors.patch
queue-5.15/binfmt_misc-restore-write-access-before-closing-files-opened-by-open_exec.patch
queue-5.15/spi-cadence-quadspi-implement-refcount-to-handle-unbind-during-busy.patch
queue-5.15/f2fs-fix-to-wait-on-block-writeback-for-post_read-case.patch


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
