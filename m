Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4148606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DkPJmToE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZDr1p4jK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c+C5cUST;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GgRR/vBF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tisTsXUfBxu8GYC2jzhTdjtmyKqKAxMdidG/yzoVgCE=; b=DkPJmToEXbjZOU4/79FM56sAZv
	4I8gmJ8eM0pZMT64YLhyUXGBJ5bAEbdZ6xABpVM2mlBjfrNlc08nUKkmZwHt6G76mNMhHTEawSl8W
	IdVeycayxzw6eexO3ZmL+blRUYBQYi5jwiPbr2a/wNGSjxhOxbw5YGGBSgg/OL0IwPl0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsIC-000000007ew-1vZi;
	Thu, 22 Oct 2026 12:53:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsIA-000000007eh-1gIa
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zv9V/TKUN6qAvAS+r24903BwcwIFwrBucgFy7IrQaD0=; b=ZDr1p4jKLUvE9wDS3xr70X0Akf
 BIB+CoT0ScMnZhv0ut7cYdzEP6zpJhhTtdC68KrSZC/2UZywSVLSCsyUJa2jRb7UoUsBm1NUT/Pb+
 txg+yAWXkOdghxUR1H7SmvzDKsRtPioQzZNpzYFTq1ub2tF7GKsn7Vs5fWz8T6CR+2Kk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zv9V/TKUN6qAvAS+r24903BwcwIFwrBucgFy7IrQaD0=; b=c+C5cUSTuN7Ush5jZ2Fnmx6Gc7
 SKyPZOChzcOzaH9SRRWjgWH8j+BhXWMzHkkWj7d+TR0rCiESG5JmzFJRO7BJZ0/280Csr3LYzrxQZ
 cEC6vsHd9pNOy9AS6oBeqc2PaQK/sNlZYJVdAqM9uzzy50TZsonPyjLCfshhoAFV1Ahw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsI8-000000001GR-3Pz7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CE9B60211
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E412C1F000C2;
 Thu, 22 Oct 2026 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673582;
 bh=Zv9V/TKUN6qAvAS+r24903BwcwIFwrBucgFy7IrQaD0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GgRR/vBF1oFc/ehV5Z53H/GFDc+8DFGdKvAPE8DsyQdGiUKHQHGiCSbu0JEE2O6ZC
 0s3n2Fr9LlIZTIWiqGyvu+GQ62NA4Vl+73nqRXub5C7JFC2hBgl82gaMJ74M2hoGf4
 PqQWK2Z17OnZxsaWoB56BT5yBHmS0SrrTBM87JL70Gc3ySBvvoqQa/RpatxdMHROpo
 JqyU1wnBlUPNZFQtSZeqaLx/q2GC5Dv+h9r8SZk0CcaO6AXp2WaGyeGLTqSxddIJwl
 NPP/sQOeXpGwZZ86xO8SKYFdtwxiHER6BCKxbbNRB2ut6ASRZACTcblLVii9nsmt/P
 dQNW/iGNOflQw==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 12:52:42 +0000
Message-ID: <20261022125244.2205275-5-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261022125244.2205275-1-chao@kernel.org>
References: <20261022125244.2205275-1-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsI8-000000001GR-3Pz7
Subject: [f2fs-dev] [PATCH 5/7] f2fs: fix to truncate meta cache entry in
 F2FS_IOC_SEC_TRIM_FILE
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

F2FS_IOC_SEC_TRIM_FILE discards and/or zeroes out data blocks of the
file in place via f2fs_secure_erase(), but it never truncates the meta
cache entry of the blocks, which may be cached by GC if the inode
requires meta inode GC, e.g. encrypted inode.

GC trusts an uptodate meta cache entry w/o reading the block from disk
again, so it can migrate data which was erased to a new block address,
then the erased data will be resurrected in the file.

- App (file F)				- GC
					- gc_data_segment() phase 3
					 - ra_data_block(F, j)
					 : cache F[j] in META[P]
- ioctl(F2FS_IOC_SEC_TRIM_FILE)
 - f2fs_down_write(i_gc_rwsem[WRITE])
					- gc_data_segment() phase 4
					 - f2fs_down_write_trylock(i_gc_rwsem[WRITE])
					 : fail, skip F[j]
 - f2fs_secure_erase(P)
 : P was erased, META[P] becomes stale
 - f2fs_up_write(i_gc_rwsem[WRITE])
					- gc_data_segment() phase 3
					 - ra_data_block(F, j)
					 : META[P] is uptodate, skip reading
					- gc_data_segment() phase 4
					 - move_data_block(F, j)
					 : META[P] is uptodate, skip reading
					  - memcpy(tentry, sentry)
					  - f2fs_update_data_blkaddr(newaddr)
					 : F[j] was resurrected w/ erased data

In addition, GC may be writing back the block w/ meta cache, we need to
wait for the writeback before erasing the block.

Let's call f2fs_wait_on_block_writeback_range() for each block before
erasing it, which waits for writeback of the cache entry, and truncates
the cache entry.

Cc: stable@kernel.org
Fixes: 9af846486d78 ("f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 27e295bdce1c..363039da3ab2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4661,6 +4661,13 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 				goto out;
 			}
 
+			/*
+			 * wait for GC's writeback and truncate the meta cache
+			 * entry of the block, otherwise GC may migrate stale
+			 * data in meta cache after the block was erased.
+			 */
+			f2fs_wait_on_block_writeback_range(inode, blkaddr, 1);
+
 			cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
 			if (f2fs_is_multi_device(sbi)) {
 				int di = f2fs_target_device_index(sbi, blkaddr);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
