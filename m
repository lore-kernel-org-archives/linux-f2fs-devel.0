Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE4606A33C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JrVn6QHI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ig4zl3kd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aOPCautJ;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OnfBVEAg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=yFe4uXYsx1vgZX1ZvFcb81CfzwToKIo6ABMvZzU43jo=; b=JrVn6QHIjyXparODPOQ2EJwai7
	D+wvA1YBhT7vEB9Zd/fuyUN7SoClYAaDDX2MjD6Hgu0++vLTPG7kMBvlb+TcWSte7/z4PXt67VCN/
	deHPFkj0mmgsSpGv+6zZZQVwRwhrDFrPAVfbLIcop2ychWcC032pkJf1E8qof9mAh5tE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsI5-000000007eH-0Onh;
	Thu, 22 Oct 2026 12:53:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsI3-000000007eA-3LnH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JgFKhpkT5XI8KFhoSBHdBkczKlFEWgcD2DZDQ/kGhUA=; b=Ig4zl3kdQ7DOcU7E+J02DcHNeQ
 1FNQ6pRgxqseZE3fKcd1p4k6vEpKXgwFNnNISQ1UT33NksC3ACwf14LOrx3eCo4cyepKP9cxqdENP
 HMNNbIOweUhA+Jz0pUO7ap7kZ9WlBridVLuVMv9kii7kIa+3d/4fLgN3nEPpxPUwUwto=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JgFKhpkT5XI8KFhoSBHdBkczKlFEWgcD2DZDQ/kGhUA=; b=aOPCautJsuAYSX4Zl/FasFzUTc
 TdjqeelqhLFknqtykfoeej0xOvizdOfaOH+HskBeIoAJvdoamWoiRisP7qkQH3Ko2uBkKbrXMhNAt
 GONS8l/rLnAOUhia26+3Ey5j+zskSCc0TkjRSntbGWhEOcjhETB95sf7vtx7+DqZrqTQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsI3-000000006rD-0cXS
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A488243ADE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B991F000C1;
 Thu, 22 Oct 2026 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673577;
 bh=JgFKhpkT5XI8KFhoSBHdBkczKlFEWgcD2DZDQ/kGhUA=;
 h=From:To:Cc:Subject:Date;
 b=OnfBVEAgGVeufO9YCJhASbf7BuYWrHZMwDga/KArg1dlgh9NB+iNlHVGpLLobBHN/
 EjyNZAnvJKOfRTZU8NqMaYmLZtdFQAWAkAq8+waKGsDeT7HGq5n3Mt4hBpelRv3667
 59XCB5QTqntxBQeVEB5wtRX2DpLf13BtJcrQp1lZX+RXJ+PzzEjGj/c+aQilJQDPDa
 lM3vxQ3M8vXkM/C78Bvla4ADbmg6abHAcViJ07h+f+uzaJ0XdjGdIZSMRxXETBy1ZN
 CaSUXyp0d6N0OEyLp4yaAP3mwCvtl13WVZVIXtkIHSr0RepACIurEzzwGRDu6iHkIk
 Ycy5k1mSpbvcg==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 12:52:38 +0000
Message-ID: <20261022125244.2205275-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsI3-000000006rD-0cXS
Subject: [f2fs-dev] [PATCH 1/7] f2fs: fix to persist i_size extended inside
 last block for fsync
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

generic/737 fails on 16k block size f2fs, after writing a 1M file w/
O_SYNC buffered or direct IO and shutdown, the file size is 0xff000
rather than 0x100000, i.e. the last fsynced 4k data is lost.

It can be reproduced as below w/ 16k block size:

xfs_io -fs -c "pwrite -S 0x5a 0 32k" /mnt/f2fs/file
xfs_io -x -c "shutdown" /mnt/f2fs
umount /mnt/f2fs; mount /dev/vdd /mnt/f2fs
stat -c %s /mnt/f2fs/file
28672

xfs_io writes 4k per pwrite() and fsyncs it, the 16k-sized 4k unaligned
direct IO falls back to buffered IO as well:

- pwrite [16k, 20k): allocates the block, last_disk_size = 32k (end of
  the page) after writeback, i_size (20k) is unaligned, so fsync writes
  the inode and its dnode w/ fsync mark
- pwrite [20k, 24k), [24k, 28k): in-place update of the block, i_size is
  unaligned, fsync writes the inode w/ i_size = 28k
- pwrite [28k, 32k): in-place update of the block, f2fs_i_size_write()
  sets FI_AUTO_RECOVER as the inode was clean; i_size (32k) is aligned
  and equals last_disk_size, so f2fs_skip_inode_update() returns true,
  and nothing is written for fsync since the in-place update doesn't
  dirty the dnode

After shutdown, roll-forward recovery restores i_size = 28k from the
last fsynced inode, and do_recover_data() only extends i_size to the end
of a recovered block when i_size doesn't exceed the block's start
(28k > 16k), so i_size stays at 28k, losing the fsynced 4k data.

FI_AUTO_RECOVER means that the dirtied inode can be recovered from data
blocks via roll-forward recovery, it's not true when i_size is extended
inside the old last block, let's clear FI_AUTO_RECOVER in that case, so
that fsync will write the inode. It happens w/ 4k block size as well,
e.g. w/ 1k O_SYNC appends.

Cc: stable@kernel.org
Fixes: 26de9b117130 ("f2fs: avoid unnecessary updating inode during fsync")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e9f8b31d5dab..d6b3955f9a6f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3615,8 +3615,9 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 {
 	bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
 	bool recover = is_inode_flag_set(inode, FI_AUTO_RECOVER);
+	loff_t old_size = i_size_read(inode);
 
-	if (i_size_read(inode) == i_size)
+	if (old_size == i_size)
 		return;
 
 	i_size_write(inode, i_size);
@@ -3625,7 +3626,18 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		return;
 
 	f2fs_mark_inode_dirty_sync(inode, true);
-	if (clean || recover)
+
+	/*
+	 * Roll-forward recovery only extends i_size to the end of a recovered
+	 * block if i_size doesn't exceed that block's start, so it can't
+	 * recover an extension inside the old last block, e.g. an O_SYNC 4k
+	 * append filling up a 16k block, which is an in-place update of an
+	 * already allocated block. Let fsync write the inode for it.
+	 */
+	if (i_size > old_size &&
+	    old_size > round_down(i_size - 1, i_blocksize(inode)))
+		clear_inode_flag(inode, FI_AUTO_RECOVER);
+	else if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
