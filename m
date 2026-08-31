Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3202C61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Klxseu7tll32ppaBV4nuGrdDKui3DsdAZ+KSWl0hJEM=; b=E+bEHnOEQZwrVK3sj67f0W0L/Y
	TYoCXddcGlKTjgnBmCVuokpfNMKIvKJQFNGhvzZGlPHsnvxqyaJIfZ1BRN554ZlQeC1KWPQfifJkM
	zSnNfTm+PFJGV/ZoaAHyB8ZBDtFfDZdnRf3tnTozhkIgU1mXbiTshpPTYj2RRoPzO1N0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1A8U-0005iq-Lh;
	Mon, 31 Aug 2026 22:05:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1A8Q-0005ih-TE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 22:05:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1SU3rdh97lkeZJr+7CduyypOUNik8G+JmicPTmnCyvI=; b=kZ+X4lZtbXStxi+9HqXoDigLGJ
 UUyHs8MJACeKMBWebW63XtJWGsnXfWyCz8cHjaK9h/6Ka4VWPoNQA9HnBlXIYYwCiW1hKzlby6Adj
 4Z8rfV3DAt9G5rytouXOOYijhYZj/5MJa1PesVp9sVq+QIIRWabRLx/jfdG/Gp1ofysc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1SU3rdh97lkeZJr+7CduyypOUNik8G+JmicPTmnCyvI=; b=Neg03TksM6W+6fSTOWYU90Vvxh
 RwFUGP02sX1THrzhQA2viEZAx/0zsguEDKmMH5DJ2orNXCSZtVN7fucuFoB4jEyjO/bwbXFzNCz6Z
 ++6gBJlOkeCGyhh9rnekzf2k5OsarDiKlMaA1M+1+lDrfWDTjR0uuC+sSra95IrnEzgc=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1A8P-0004fF-Fz for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 22:05:46 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-398b3d66515so2753987a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788213940; x=1788818740; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1SU3rdh97lkeZJr+7CduyypOUNik8G+JmicPTmnCyvI=;
 b=FmbMO/ElcHu2qWjWZPEw8rilNkQ+k2kOZ5J2oLhH9BXa6tf4jguFKRNV0aYMvbpOnQ
 bD6lkOv4Foe3TnvY7137VNzIAdsaHwHOodcMsBsdMP2tHdbV7ogC0V1fBJz0ynU2YeER
 HBdrIAd/bV8vQK31KdBwL/HxAd0ZEczNLYzVmfaDVhxLLrFdZPgiqNOu+RZI6UwjspS1
 /FJM25gyNC5ME3QHrCsdq7I8vDHMfUd2KPkhezmKTilnlIQeky7kn9Sydn0M6HF0spGb
 cYl6RMBKNEbW+0U2ONTdKMiagua01SGpaQ+jpl5Olw0iJBmbyNQqdU33x49iNe9EZbv/
 PlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788213940; x=1788818740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1SU3rdh97lkeZJr+7CduyypOUNik8G+JmicPTmnCyvI=;
 b=hMH+/qTpxsttDzzsU2jV2A2ETh5mLZndgRHhQyRp86CD/r8sWCrLcqUMRv3jvOoZsg
 1JAebpkhfm6bMcLkauYDmvY+jXWub4ODCc7iyfiBu5UlpoiLD+xiqTeGo6VkjmA/MfCt
 uxQ7P/Q0dXQZTZR1NYVqjPG+uL3RzJeLTJbvfFttC4LJ21WGuO8zsl1u43+/Kt4Giytb
 lJ+B8Q7GBaKGfJhGgKitqRGapFHmhJjKp+ygrP87sSyBF5TBE1GS8jvqP+wmBD96lUem
 c1+kK8T++PVzjtCPsACedw4Uv+dCNFXYUYg3meGx0DFkqwR6RJxT4g12id8V5+5Kfdhh
 3YLA==
X-Gm-Message-State: AFuF++kGYN7CSmxeLH7MweYdxESkIrTIFUkc3/g6yZxB2W7qTLcc13bZ
 Fji/dk2jmnn6uG+DwblLCFx6mJlVUlMdR1+KphEDTtffsKxHQnbkUR0T9fFWkmHo
X-Gm-Gg: AYBFou21p3oi4Ja0//XsI1V0lWoGHuEKNKdjW+W8xPGRFaqxOyGvvk/3BGEAjYQu860
 8FyA6rqs5kAOqBQgs5IwxbAq7Ay+Jzg077Uj7XJ1TmceRz8bsbBxchOfvlIdUOJe6ZR6T4FKWdm
 9S6ZBi5zPLbboyqgdCtIAWFDuWd+rwIMSlrRlISdRcdisHkdSIx/n2xLXeoJd357l3yZA7gIhyM
 tcTaFrNGid1beiCVwd8HAovTj8YIk4CH0oZhRAu/639jGAWOIDim7uDNmwwcYtWvNtemaDr5EL1
 BVguURz0Aw8dYjGcpwYggQAo0LuhsaxdHHHZtRW0Hyw96OdTqomVNIBR3iQbQWSymP+/EcmHhdc
 G0OXiCHP+o4JRn/iBDNR1gQ7RoSINFpSE+RLq2Z3ZaafeiOGQSvYE7aRIpUGRHIzcFN9/hy3Dih
 /itKXXAU/kp+lmxhS/G1IWU7VIIX+BYyIIfJR6jNmTbEHVnZqA8HKkqUF8ezJDIUTnwIo=
X-Received: by 2002:a17:90b:538c:b0:398:d6e6:4671 with SMTP id
 98e67ed59e1d1-398d6e68870mr18634235a91.25.1788213939680; 
 Mon, 31 Aug 2026 15:05:39 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:91a4:c2d8:1d54:21ad])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d499811sm1952863a91.10.2026.08.31.15.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 15:05:39 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 31 Aug 2026 15:05:37 -0700
Message-ID: <d3fa15836c409ac6028956c06dbe11a8e0149734.1788213716.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788213716.git.zhangxp1998@gmail.com>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x1A8P-0004fF-Fz
Subject: [f2fs-dev] [PATCH v7 01/11] f2fs: initialize sb_info early in
 f2fs_fill_super
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Previously, init_sb_info() was invoked late in f2fs_fill_super(), after
processing superblock error tracking, mount options, and sb->s_maxbytes.

However, read_raw_super_block() reads the superblock folio directly
from the block device mapping using folio page offsets. This makes the
initial static sb_set_blocksize(sb, F2FS_BLKSIZE) call redundant.

Move init_sb_info() to execute immediately after sbi->raw_super is
attached, allowing the block device block size to be set dynamically via
sb_set_blocksize(sb, sbi->blocksize).

This early initialization also prepares for upcoming patches that add
dynamically computed filesystem geometry fields, such as
sbi->addrs_per_block and sbi->nids_per_block, to init_sb_info(). These
fields are required by earlier initialization steps, including mount option
consistency checks and sb->s_maxbytes computation.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/super.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 253a579e9d5b..2d9f5b77f815 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5125,12 +5125,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	mutex_init(&sbi->flush_lock);
 
-	/* set a block size */
-	if (unlikely(!sb_set_blocksize(sb, F2FS_BLKSIZE))) {
-		f2fs_err(sbi, "unable to set blocksize");
-		goto free_sbi;
-	}
-
 	err = read_raw_super_block(sbi, &raw_super, &valid_super_block,
 								&recovery);
 	if (err)
@@ -5138,6 +5132,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->raw_super = raw_super;
+	init_sb_info(sbi);
+
+	/* set a block size */
+	if (!sb_set_blocksize(sb, sbi->blocksize)) {
+		f2fs_err(sbi, "unable to set blocksize %u", sbi->blocksize);
+		err = -EINVAL;
+		goto free_sb_buf;
+	}
 	sbi->max_atc_write_bio_size = UINT_MAX;
 
 	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
@@ -5217,8 +5219,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto free_bio_info;
 
-	init_sb_info(sbi);
-
 	err = f2fs_init_iostat(sbi);
 	if (err)
 		goto free_bio_info;
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
