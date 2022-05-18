Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90BFC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 May 2022 23:54:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrTUO-0000Hc-W4; Wed, 18 May 2022 23:54:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nrTUD-0000HF-0o
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 23:53:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xWThBicnmo/5a0AcYYHZBCQ4e3Qrt/fc0Y8Lx6T9EFw=; b=i+eoNe9x5mn9zcxVu9/rhoKft4
 X3iMwiPdAZDG534sJ0LFy0WD17RG968a5AdKQAGAAfQYhg/zg4kl4YKFR0UlvuNc1ayOZGbk3/vhJ
 S8SkO+cp0QVdGTG2HLfXhx3VlYxy9Bidds4SiGvam0BsgaBsk6I3hO6UwgcRPF/WnuBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xWThBicnmo/5a0AcYYHZBCQ4e3Qrt/fc0Y8Lx6T9EFw=; b=ffsgPgo24Unq4jlKu8U7OW9Q4z
 dhQHqF/oFXar+gNWIRyICI2nEH11KJdeqw7jKlJ3dypqv2056ph9O7QJP6V3mGBxRJxzHcwXhR2ls
 zFspQgbBRu9WXGqvcrAqrxfymO3oGziiRQ5oaBjXHf3r9wMt2UXiHZg8oAiY8J5QVs1o=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrTU7-0006Cu-Kd
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 23:53:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BA645B8225E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 May 2022 23:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390EFC34117;
 Wed, 18 May 2022 23:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652918011;
 bh=JB6LW3h19xqQuARtC/JCk4kDuw5IA+Arc9Txbr7avBA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RurWipI6Wf2z7f+35oosk8f484SsrCnSUj3Qu8ZIYKS+Lo6hPCpdBdU2PAghokXJ6
 1mkFiBa7QUFCSCgsa/CIO8YHnShL5ssiWhnKwm0g1FH9tKv5SWrPsE4WAjTzVLXXW2
 eTXrwwxSThz/fFGsUdcLv0GmZw+58moDBc76xzppXK2i/hQVT3CtoY96pmRgKHzEKb
 5RymFDzAC1YOAbbg1fiTXxMEaBaG+X7eVAxmJixZRdSkwkQP/+iXW2GCfNDzyTYLRb
 SEv4VIHE465Koq5R3t2X9qYMxpLxRPyE0JP57YB90yAXuhUUBou0gI1hCI1CQABoN0
 LmUB0/x27PG/w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Wed, 18 May 2022 16:50:10 -0700
Message-Id: <20220518235011.153058-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518235011.153058-1-ebiggers@kernel.org>
References: <20220518235011.153058-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1nrTU7-0006Cu-Kd
Subject: [f2fs-dev] [RFC PATCH v2 6/7] f2fs: simplify
 f2fs_force_buffered_io()
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

f2fs only allows direct I/O that is aligned to the filesystem block
size.  Given that fact, simplify f2fs_force_buffered_io() by removing
the redundant call to block_unaligned_IO().

This makes it easier to reuse this code for STATX_IOALIGN.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 68947fe16ea35..c32f7722ba6b0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -807,19 +807,7 @@ int f2fs_truncate(struct inode *inode)
 	return 0;
 }
 
-static int block_unaligned_IO(struct inode *inode, struct kiocb *iocb,
-			      struct iov_iter *iter)
-{
-	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
-	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
-	loff_t offset = iocb->ki_pos;
-	unsigned long align = offset | iov_iter_alignment(iter);
-
-	return align & blocksize_mask;
-}
-
-static inline bool f2fs_force_buffered_io(struct inode *inode,
-				struct kiocb *iocb, struct iov_iter *iter)
+static bool f2fs_force_buffered_io(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
@@ -839,12 +827,8 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	 */
 	if (f2fs_sb_has_blkzoned(sbi))
 		return true;
-	if (f2fs_lfs_mode(sbi)) {
-		if (block_unaligned_IO(inode, iocb, iter))
-			return true;
-		if (F2FS_IO_ALIGNED(sbi))
-			return true;
-	}
+	if (f2fs_lfs_mode(sbi) && F2FS_IO_ALIGNED(sbi))
+		return true;
 	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
 		return true;
 
@@ -4283,7 +4267,7 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return false;
 
-	if (f2fs_force_buffered_io(inode, iocb, iter))
+	if (f2fs_force_buffered_io(inode))
 		return false;
 
 	/*
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
