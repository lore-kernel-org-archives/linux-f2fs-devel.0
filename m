Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D80C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ulWoVowDs3UvrhTiVhGKE7B1YXj8g8MeV/rDgXmZjc0=; b=DxZcBQx0N+EW2rwAV6mjTFam30
	ByoTN12yhb2AZvWyEqQknqmn7TFO38ya0C5gkY7MwnLKQBZzmT5IVRPSvLvts/AXTXEcoWfV0SxHn
	CN04ZldgDZZ952wLiW0Ezzqe74731NRMXVV2ag7/uJwSFCYHT+jM42+VULg+9zQRloRk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2GW1-0002Na-6c;
	Thu, 03 Sep 2026 23:06:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2GVa-0002NF-KB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:06:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0byPuk5ss0w8gPStks6iC7C9A3PMDT/7QIWY5qOJydM=; b=N4hVywxldLXGl9R/nCTv/AOjHq
 qxir2cfp+6fyBH0gWdUqyPYDaZQXst/fZDBLpe1sEH8ecmle1AFX9S3IYisdmDI5UOAuD5xcp7GP/
 7OUh1TAciUt09SXPa+iEZGLPZvZTFPsdSPmJn8lvc2OKG9OXXWbnIxhcJvghytohBGU4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0byPuk5ss0w8gPStks6iC7C9A3PMDT/7QIWY5qOJydM=; b=f58q+7tAPNPQpDOoO+turNDouH
 sF9eEN7LeBwCo07frHtk3Qb8QephIlwuYu+BnABlFgRUGcr9/TaMSeqbZZETWZlOv4DBdOxlfkrBG
 3vEinv8tIsT0ICjEZWSXvTdZDtZJkvAL48b+aeZdOaALxdvF/KCTyWBFOxRlcI/B/Q3M=;
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2GVa-00077T-5u for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:06:14 +0000
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso481504a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788476768; x=1789081568; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0byPuk5ss0w8gPStks6iC7C9A3PMDT/7QIWY5qOJydM=;
 b=XXYqU2JjmWeS9mVWnCsBuLj6VDQzFYqERHyF8l6CCdUkkotyT+Wlta0Q5x+DbVPz3d
 iqiTxkJSb6O9cz4bkK3GxebWoX2Mx5TSP9PYmlypmjO7r6kXQcij9cpGVTe+mik/Tu3S
 kBVoyucrxvWiCIfgoc1NYBk42zThH2ZPjfFIw4rCaZy9Gd6VYdHrJhWrAKlRwZOW4Dsy
 97LfoR9bpZbB9PTDxAD30o/3GykxZX7A4DtGBaVJtH6y85dmanSiVSrp7rli+SIgApUM
 KooM3DXyjqZk7s21nbL7lEBJo5GsQYLRaCFx62uC71PLznkn1duhPLngm/5oxJeGKjBM
 hLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476768; x=1789081568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0byPuk5ss0w8gPStks6iC7C9A3PMDT/7QIWY5qOJydM=;
 b=aeqUxWrBUdZPUb8Kbf0mULfqxFET2DsNzVS5k4sxAlnfkW3SGJtLhDA+mXRbi3yOYN
 5MxgKJ7NOJywy48g6Gp7a7MPzS2px6yepBBYFvfal42Xndp3Nsfso+1jwN/IF66G/IlY
 c3DSowltNaz1YmUtmvOJHDalh8j/DpyKuP7H/QM1ndZ0ixOh09heRKUvXLCjR67OPPAH
 QwbQu/Nm5CuV1YU7P9Vbv1ZxlXkIOQnNPR0YLbc1zvntvqzQzKf1nwissYBYb+cNvVlt
 uu8digWJhqd5WjlCY/F7N4/KXgXUdPOW3dZ59tY6UIuZLQYqBi9YyEedctzZFOkZP1nk
 Z8Aw==
X-Gm-Message-State: AFuF++kSON4Z4Of+MHkTBM9ZjBX36WvHPbzvZN5bp83Y7GwsJSBVG/WL
 cNdShH7VE8OHjlO6fuaXHe6VeZQNMFFFFPw2XaUQofHv5wfiqvlMercRgkKSzSXScxY=
X-Gm-Gg: AYBFou2IOVQPLk/pVwr0zqRti5tyjc4ZAfr80mqndUkNWa9DqnkcW3cN2aR4Np0l1fS
 PT+IcAUzzEeIVlH9PJMUPR95vwNUTgOAZFoWfmDhukJlV487l0FGJpfBMaU/U6tblDnvYRMdeb5
 /1QVrol0GA8GO8kVSPYB5MwxtkTjU2Llijt2bjvwoCdqmC/aIBbDWXXMcqhDGEX2YZwcXVFBWFa
 uN1+LMluRQigEj6eTrSTM7HovGSG1uzlX1MbsqaSOZHN/U7BGk6y0tqebusvjDhYXgLnyJxI4so
 HPwcvLNTUY6U+KtwpO0srU8kQkUcda7WxQQt4Cfhukg5Fn5r6bM5zbT/7Ku9RZjc3253S+TuLOt
 Yjs4Mi3/Ys3tgo6DPJ1yalRaAoYY3KWliXLUl7lS/yqQBtdvCZROQLQn/wfSdUC/GMO/6Ecscrs
 tE7ESTPFVQBMMy/Vk+VXQyTAgfV/pDQUbybe1z8KjHvoz5vhTtBdb84G4QcUib+LJFArZ0wd2N7
 P+ZCA==
X-Received: by 2002:a05:6a00:2289:b0:857:726d:2e99 with SMTP id
 d2e1a72fcca58-8616af5b1aemr3118130b3a.22.1788476768342; 
 Thu, 03 Sep 2026 16:06:08 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152c2a536sm429263b3a.31.2026.09.03.16.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:06:07 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:06:05 -0700
Message-ID: <cd63b907d18ebef2f8dfa3c843d008c27de4ee8b.1788476500.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788476500.git.zhangxp1998@gmail.com>
References: <cover.1788476500.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2GVa-00077T-5u
Subject: [f2fs-dev] [PATCH v8 01/11] f2fs: initialize sb_info early in
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
index 253a579e9d5b..c48acfb30a0d 100644
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
