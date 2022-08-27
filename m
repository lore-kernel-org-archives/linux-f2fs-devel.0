Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C253C0502F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 27 Aug 2022 07:01:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oRppJ-0005q4-LC;
	Sat, 27 Aug 2022 07:01:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1oRppH-0005pr-Vl
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Aug 2022 07:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=boGDg4hXmqQ0JJie+5NJ9GcEN6L9TH2JdHVUO60GeLk=; b=ki4J+sp9repsD5NnZtqIuVAMxs
 NVJjuJeWRXnz3PBzCrZOT5d5G3zaHMZ0++PKcy+Sw3WZTRIAF4NeqiYsMkOSuWfpXGedRfVG4wYMe
 zKTnNEiMwLAp/9mZt9NolIi6NtYxJ+WKTS+RBejWolABz6YtuB26Y5mCLix6Hv7YbNJo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=boGDg4hXmqQ0JJie+5NJ9GcEN6L9TH2JdHVUO60GeLk=; b=UD2ypSQfJvzjV5SPmdv3XuiWYd
 sH+AQme+1OrdRE7/bNVQxzVcc7O1bH3h3/oJA1kr/ZE3ZLdcNBOT3Jhpf9KEl1V5Po9aYZqB9fNGF
 fRVsFayCh+nUDkFEQEOdzgdM0Xy+ezpBFRZPND2QnBIJ+COUe1EXCAAXorhMqlbFILtI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oRppH-002PS5-Ds for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Aug 2022 07:01:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 232626102F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 27 Aug 2022 07:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FB4C433B5;
 Sat, 27 Aug 2022 07:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661583692;
 bh=8UZ3nfyjvR/tlY+3mxGCVsnHwuM9TQPRtN/Xaf4/Y3k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ow3GS9VpEWEwaBcfZsOmQP3mhfwpOEhyaxUiMt1sumBXKJzOjeWFbPUm+P0JSfHsg
 VtA6vPA/q4JLRxmxt2pGM5L693TcfBzdpgRm/EFZ1NZhJ6lfmYUel8pwvNZoifkQds
 JXuuBeZheUzAFx5xwRSEwfEQO8LFPmen2nLAipWnVExDTkuoBDj8j0a1B0MO0mG8SF
 xmekiN4n+XelAPcJSWJRL6/k2QglePYbdIO7cyDRxuiPHYT1b7K6GPDXEhkT1VFn56
 wEi6KFndg39w3zleKkYb/RGdzMpBQZtBoqG0/n6XWum3PyNszMiwFUD4a4geFjHMfC
 C3oDVdTYXnQ1g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Fri, 26 Aug 2022 23:58:49 -0700
Message-Id: <20220827065851.135710-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827065851.135710-1-ebiggers@kernel.org>
References: <20220827065851.135710-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1oRppH-002PS5-Ds
Subject: [f2fs-dev] [PATCH v5 6/8] f2fs: simplify f2fs_force_buffered_io()
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

This makes it easier to reuse this code for STATX_DIOALIGN.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8a9455bf956f16..8e11311db21060 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -808,22 +808,9 @@ int f2fs_truncate(struct inode *inode)
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
-static bool f2fs_force_buffered_io(struct inode *inode,
-				   struct kiocb *iocb, struct iov_iter *iter)
+static bool f2fs_force_buffered_io(struct inode *inode, int rw)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int rw = iov_iter_rw(iter);
 
 	if (!fscrypt_dio_supported(inode))
 		return true;
@@ -836,13 +823,9 @@ static bool f2fs_force_buffered_io(struct inode *inode,
 	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
 		return true;
 
-	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
-		if (block_unaligned_IO(inode, iocb, iter))
-			return true;
-		if (F2FS_IO_ALIGNED(sbi))
-			return true;
-	}
-	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
+	if (f2fs_lfs_mode(sbi) && rw == WRITE && F2FS_IO_ALIGNED(sbi))
+		return true;
+	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
 		return true;
 
 	return false;
@@ -4222,7 +4205,7 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return false;
 
-	if (f2fs_force_buffered_io(inode, iocb, iter))
+	if (f2fs_force_buffered_io(inode, iov_iter_rw(iter)))
 		return false;
 
 	/*
-- 
2.37.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
