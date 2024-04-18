Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E75FC4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Apr 2024 03:33:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rxIX5-00075J-Gz;
	Thu, 18 Apr 2024 03:33:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rxIX4-000756-10
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Apr 2024 03:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5nHyX/Ucwsvwce6O3sInmrQRAT8LByI2h9dZpfC2CYs=; b=Fmv325w+Unfd/D0mu4szXYay2K
 vE0KXAQ4WzXYK9P3aW/BS6Gh0E+quUyrU1YelB0EfrafRtHlkTVEJHrb/Ql13Bd5MikRf8RfViD/x
 KDZsDECuQ4E/zBsxR4m5huySyFmgIueJPNOJf/akVeGaiFStUtgqvZ5JwCduph06Ffyg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5nHyX/Ucwsvwce6O3sInmrQRAT8LByI2h9dZpfC2CYs=; b=E
 FljgG2dPSXQ8uQoJjsXNMHwC3HI5Xx91/Vjlhkx8Gb+S8dKmNJBtNTgHtJyJhT8xJSA7eEQV9uT9j
 hDy2e+f/sIE0lJevPGMTltFg1dNV5vPrEZooVfYHAyWlZWh2CYjNaW0ODttoKTqllV4yG7H3uDx3L
 jUknWciQrJdTZdzo=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rxIX4-0005rf-0v for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 Apr 2024 03:33:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BAC69CE1708;
 Thu, 18 Apr 2024 03:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAA5C113CC;
 Thu, 18 Apr 2024 03:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713411221;
 bh=dtjgZZ6LyAOmfuoyAzD6stsAAaBCfQKvQN9RlMz/f+g=;
 h=From:To:Cc:Subject:Date:From;
 b=rXcYnAUoQmz1RoeSI/bOHzs5HBQcoEDjWOcyHplG7AvaejllZ6i2YOcGsyejYXbCQ
 MQhfjOj3/bwFEzO9EcumWhzk3MqZ3KO9JnznSNPTgcRfeHZhF6dFqzSf/LbPOwBZZg
 Mszy4ZxKdiduI9gNSCFqPAfNSt68nwnZ2027W7919ixgNHsKsiH1K25/PypzJqvLOW
 u/KNtN9MFDAcSzaKP/pcxjy+m87+zXbaGIT0FF45K/0hjnfL2CXl6mBWjVTnl3spXC
 7aJloVkZONMLlcyq1aIgv2bdsEgSopRcvS++3GIeR0OUfTZU5a7nnJQ08PrK+Wec3e
 VdlKHm3DTUlzA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 18 Apr 2024 11:33:34 +0800
Message-Id: <20240418033334.861570-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rxIX4-0005rf-0v
Subject: [f2fs-dev] [PATCH] f2fs: assign write hint in direct write IO path
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
Cc: Hyunchul Lee <cheol.lee@lge.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs has its own write_hint policy, let's assign write hint for
direct write bio.

Cc: Hyunchul Lee <cheol.lee@lge.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/file.c    | 15 ++++++++++++++-
 fs/f2fs/segment.c | 17 +++++++++++------
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b3b878acc86b..3f7196122574 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3722,6 +3722,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 			block_t old_addr, block_t new_addr,
 			unsigned char version, bool recover_curseg,
 			bool recover_newaddr);
+int f2fs_get_segment_temp(int seg_type);
 int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ac1ae85f3cc3..d382f8bc2fbe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4685,8 +4685,21 @@ static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
 	return 0;
 }
 
+static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
+					struct bio *bio, loff_t file_offset)
+{
+	struct inode *inode = iter->inode;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
+	enum temp_type temp = f2fs_get_segment_temp(seg_type);
+
+	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
+	submit_bio(bio);
+}
+
 static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
-	.end_io = f2fs_dio_write_end_io,
+	.end_io		= f2fs_dio_write_end_io,
+	.submit_io	= f2fs_dio_write_submit_io,
 };
 
 static void f2fs_flush_buffered_write(struct address_space *mapping,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index daa94669f7ee..2206199e8099 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3502,6 +3502,15 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 	}
 }
 
+int f2fs_get_segment_temp(int seg_type)
+{
+	if (IS_HOT(seg_type))
+		return HOT;
+	else if (IS_WARM(seg_type))
+		return WARM;
+	return COLD;
+}
+
 static int __get_segment_type(struct f2fs_io_info *fio)
 {
 	int type = 0;
@@ -3520,12 +3529,8 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 		f2fs_bug_on(fio->sbi, true);
 	}
 
-	if (IS_HOT(type))
-		fio->temp = HOT;
-	else if (IS_WARM(type))
-		fio->temp = WARM;
-	else
-		fio->temp = COLD;
+	fio->temp = f2fs_get_segment_temp(type);
+
 	return type;
 }
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
