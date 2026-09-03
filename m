Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F8CC624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D0HBxZQ8rYLHf2Q3RoK3Z3D/jEn97ZFJvmUioz6PKio=; b=Nl/3zN7xaEQB1N0psZaJv3DHhc
	yNviUiMje610KJMVESbyxqmrXYRdw65iLpLf2//kktXSvD+YXLHeFW9RqiQlFHhOhoibGNgR3/VuH
	Z2Kiml6bfzfCslyxFt3BIwRw66A2uV3vfyBf/xveAUusBWmRSpTu8axIKdw2qAtNt+64=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2HGI-0003qJ-7X;
	Thu, 03 Sep 2026 23:54:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2HGH-0003qD-2K
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:54:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AEnmAlX/LH/SeLgbqUjIwUEnaiBZCUaJcuwBR8UE3MI=; b=FcSFX6OZpI6RvyrmmeU2xo/Z7l
 IogOpBL2x40Vvzn6fdbNwdoteZ74OTp7rDWRaW5dl6yQEEogyu6+eLH9xpBNoHU3IShO5i5Qw++X2
 fIP7Ug8zjhs+mmy5A/8oumx0HZzxKUe+DmUnsUn4TBJVHsnfTTiIBGSmeqGB5Y4Cjvu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AEnmAlX/LH/SeLgbqUjIwUEnaiBZCUaJcuwBR8UE3MI=; b=Nlqm3rNsDohv4XoTFIbFJoh4+8
 9T2xQiafGM7pvMvUeX5Fu/HB5ur2y4E4OI+LN6o4uuGiNJAHuHXg/NEmTr3/D1Vrc5OmGxZp3EPLX
 0lmq2DDby14+pjRoWMAxy9Xe/AOa8ggQJvw5tVDs2iDF4WlNxTGPyEEpxD38e8snXtWU=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2HGE-0008Pn-4p for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:54:26 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cc891373e0so4092095ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788479660; x=1789084460; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AEnmAlX/LH/SeLgbqUjIwUEnaiBZCUaJcuwBR8UE3MI=;
 b=YRhskhYGbNIwwx7iy9RSmnCPnKRnj/835Iw7y/crx5G0xdbXnKToPeq7G/JqaaFdjg
 0x+Q3XrzfW7jiklz2NMYmOxFiao0qtr1dkJRWcAxPYHZ2q34MKIW42hiQYgPnSvai13L
 RbFZt/7vtG8tUKY/CUqCPV4i3djCSPCeoJzFtqMAwZccLLcHGj4Qn74N6JD5I3WuP3rc
 0i1pEowA1xIE6VnJ4U4Z/sYs1eVRpdpMz9uRWWC45PHvBmGb3y5+ooM+oZlUwC7LqpMX
 7VYpggYL32ZalRRLKdLFTOddlA2qEMPhCMDygOqn9/SA+MTTL4Y89qAeCgSnuT91cJh/
 RRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788479660; x=1789084460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AEnmAlX/LH/SeLgbqUjIwUEnaiBZCUaJcuwBR8UE3MI=;
 b=CDRiLZUjb0o3AYTw02W/V1vHmwGh3uEQWWAjwwyslmOr/EwfN9dGmhKUU6W6xRDrDV
 kIjxK5lhYKhRQ6o1LiRii99P75i6Sw7KXCQ942CM8aAFjqapZCiozerafSDkvG2p/05/
 87DgUkdCf3GTBxWwWAbtP5IICgYKj8Lj0pV9/LyPmLWHskWtuBw1TW071cixiXqv0LCf
 aFvdGD5Af1NURxgwFxdxaayKWW1XOjrJ4mjfbkyCYboP3Qxpx4hPd1RIfaZXWWM3o1e3
 1PpLzS82Z37CtL4kolz+W2ySYj6yvPol5TSfouQlHR2+hzksDh3llRQoGpcqr6H3zVvS
 o3oQ==
X-Gm-Message-State: AFuF++me6/f4Is3dEdTZd6n2RHQ5F0PixCy15e3KcbzohFmZ+vneYSWO
 3q4showVmlJtizOQA4tCPysk2gsuevtvmlryTUsxjTConX0yaeV39nOVf7R+sKVHAk0=
X-Gm-Gg: AYBFou1dW49lbcpQHtzM3qW5b3KleswuG+y0c49fnoXJvKWDGQJ+N+tM5gcR+fnWF2T
 d9n97G3mUMFnmoR4mqZVwdkkLhBUnc9Oxbxbbr0z0sA2ecFPOu5/ruuSZ6TRO/wawFX/PbFNu4D
 /IZf8oN9M7zXw3yr+xTT2NI6S6hg0G50NFMDNcUgqNZhNa8FbZvchOaUDNq14Wg1d40Z3YUVC2C
 6o7obXWSitFAY9JLx6gE8FgYj/IeGQvV4UqVPf8cmz/DKcNG1dwWnAt2CvC5P2iuurVlytz/5fz
 31uM/GN5N2U2tBUFo0J9df3HPpHaczF6QHU2w0Fx+e6F5DnISi2HQLe03HEEVCuEPVgn+n7iP1r
 b16MKf0KmaYcu6l58fPHGxL7jxSjkV3m1wxCf163+qby+lhuytMSL8yK7s4AmqZxlWzC5G+SdmX
 iNX2bG6/m8SbY9Gesd6hJPOdJF66BaujUFpy1IbbD0Y8LTaNm4LSfv8Y9DW10/ptfxytsVOKe/g
 Z33
X-Received: by 2002:a17:90b:1c0a:b0:398:d132:ba76 with SMTP id
 98e67ed59e1d1-39b2623abfemr2881705a91.21.1788479660384; 
 Thu, 03 Sep 2026 16:54:20 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm3699926c88.2.2026.09.03.16.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:54:20 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:54:17 -0700
Message-ID: <41898b6a3cc76d464d6d1d8774daae6c185e88b3.1788479509.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788479509.git.zhangxp1998@gmail.com>
References: <cover.1788479509.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2HGE-0008Pn-4p
Subject: [f2fs-dev] [PATCH v9 01/11] f2fs: initialize sb_info early in
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
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
index 1314b6ccced9..eda8dd8f4eb0 100644
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
+	if (unlikely(!sb_set_blocksize(sb, sbi->blocksize))) {
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
