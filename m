Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAEDC624C6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rRslYdFnE1ZX1SFpg8BL6LlWdgwlBShrO7wJXnd50EQ=; b=R69GHC5d1/KWLSVAuM7tWfYhyT
	Yh/MsIRcGzV+lWvxDLmNbvDa5Juhnv1HjxQgicX1maZ4rCAAYODpAqJDYdVLhmlYZz776pIKNbivG
	8gFCi9EzwDysFshKOFBOnzjO+RCEEU54EuvV74Q8bB4XKrDt6C9aGd5PkTFmR71c3t9k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15eq-0008OY-1i;
	Mon, 31 Aug 2026 17:18:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15ep-0008OS-Dj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:18:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=; b=HyWtstPjs5SLvdCzS4sddO+6E6
 CV9+Ui9aYY0PcUjLgDBq/Xy0Wtntj71KSuQThj2hMGYfy0uSN7Uslh5rY1F8y7rD8Vdq66LCRxEQp
 bSA+QT4kofKg53Vh4Ap9tpg4hKf/r7kx14pABDqXulDImTgjj+Ad8O7TLKj85aVpAgRQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:References:
 In-Reply-To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=; b=cvDWwaIXPo7meES8TfuGoSFP8e
 ZM44iR2ssSo9iy9+NLvChRwVXstcLksFkdPvbYB3yKyfcQl9fFBOJmuXeoNjJbru77ikFGefZIe4c
 XYw0ush1HUYCa+1glQX4kNX2vDp3ZxsVjc2NOwXj5li2ftoyfLpdxHmkljBevTfc6tFA=;
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15eo-0001lu-2K for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:18:55 +0000
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so5872078a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788196727; cv=none;
 d=google.com; s=arc-20260327;
 b=Jv3vuY+iRS0LSgbHscVCF2o1VPuwGsmGX8NF2xm8/OSu4OTqPMu3eV9ReJbMG89VQF
 qLm6ERh1wVEdFVcFs47QKMgPTjEB1WQ78QDZ7NTep98eM7+cf53jJ+9dYZCfTV8ZJ+Sw
 mJbDehOLFt4CItRYddibzlZjKnR/khcJOSy6RKERf0/sfnKsk1dN4RVuCs13XBwcWE4X
 zXA9tD1KhMZ5YNUm4wsa0S3VBfU9LenugVyUe84fzKklP7xeQzBIo8z/7sja1CPcVTH8
 RzooqHmuEJBxPvTEjlD5mCPeCRkSxmEz0Brqgpkk9Sx1nyRWqZbVWd07/h2N4t4zA9Pv
 CIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 fh=VuKasonysUlrzBqN1m+Uwp6MGXQbTFgxS8WCuR8ZZ+o=;
 b=XkOgxfBMN+dwxUDr0mMmn6TB8Db6AHfokgjdDyEKrC+aF2DPakVXBXrCM37q0v0sEW
 zewcgCEWH4Os33hp+pfWN+HLtKvbAh3M/r0piMpFXvAxZQLD1hC1YePvN41llMERYtyp
 tvV5NBRe7lY6YaQeMolAnWot81pQCXFXsoTUF9rBsX109XYBHUChtvvzoFMdqdEs/NOi
 fUf+VYCTuvMqis6waJAYhMsOyw/4Q7YFXX4EOkRb1g2rzy9nPzn/tgCuesQQ0MmgcvtA
 jiBgLh2Q06nnB2wpXf0r/t5rSTm4SK+brmAIwXPUGYM2La9Jln5YzS006tqtDfCs2sDq
 /UvQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788196727; x=1788801527; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 b=lx+yt74korxPtX8EZu29g6mO7PbJDQXpbSGGRcHmWrmkT3b5f9Aj01QeXqUZXDMsgj
 g6dp9lrM4vFu/mSviv+ecd0HBtdtF4ZzeTcxJjGIpE9493SiUN8QzPi54smGzEAI02dR
 kKO3oH5Ya1JMkVX9oSaVH4RMDXCS8ZEKdBCuhy5DAwRs/aLfRmAc4B5pF25Yb/XJTSkI
 g+9Kgbp9pwQy6rzPb0jz77Nrize8ePW++snnDO140Q6XQqLk+jGX7h42bBgz7+YQox8O
 fPHcFV3q9fjIihL1KIEBG65UTZT6Z5oFXAo01PTQQ8s25L6KFM5tE3Ry4QhGIw3RcUNG
 r+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788196727; x=1788801527;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 b=AC3Rg+T8jTrRlt5dCdMnO3YBWyHZCNlR3hNH47+IU5hjQNzuLCffHsSBwQt0DpGl8A
 M1rFEf3g08OiVuL8C+WuUP2QmjI0C3qPdrwa0GX6BVQvwp2zzuBo8qYNH85xc+AzQnCV
 1kgnNEMVx+yHYa7KU3t11I9wsMGPkQYrE7Fz73UO4+3B0q+Ysv1ihUefL2vOsDasN5kg
 AX+EQ4s0t3YuhBT0Wrn4UY302k3DhTsZ0h7o2n+LodrMFz/h5bGNmOqeiWSf2Tz7yGCz
 yihgDTZFG4BctxvEoXlwHTV0XNyfxVdERNrK+rmiwF4mkykNtm8xZZGO0jzR0xmVqSYv
 0Iwg==
X-Gm-Message-State: AFuF++mw7WszxmC+/1zDblNWNMQy/LgEh42SflNKMkgoepUrZsNYUO3R
 CLdIJVsaR5CnXJ6plswF6Ba4/Pn3PLhiT42Ddb6H87ocQbWGc4ZmqRpc5Ib/8pxe8lrrtva2naU
 WZSFhhi1LQSQkWD9SETp69q7dDTLyUQQFExEwZis=
X-Gm-Gg: AYBFou12svYG0X6Wvr5bK9J7qYpeIG5y2weP86EFka+6wTMc+Z5ImVTNH2C158i+PvT
 vyS6fwd4bgSnE20hGBQdubnVIv/yCtAreulAWeadqo9jBhGHahAiXIOVcRcS3OATX8iUVsXtT/D
 nVKbaTZR1RXQ0rTnYnkvZs7koLPJwhvWRRfXzgpk04Piuq2Byc0Kcwr9VnWYlfpaLlyg9vA2of/
 sdYHt6QkTLpgrAVyhYxGDcTJCOT7xSo81b/42nRZzfykEz1U+mCfHxFz1nIb4Eb4AFmDMCAsuJ5
 1YQ5USCTiknzBCxTRc08iRduroi//7qvubHVMPst8p0Z6tNMlDQ9K4owRfL+VBW7RONefIn08ls
 kN+9LgiNrmY/A
X-Received: by 2002:a05:6402:2483:b0:6a3:8652:a373 with SMTP id
 4fb4d7f45d1cf-6a663a61f85mr2069275a12.3.1788196727393; Mon, 31 Aug 2026
 10:18:47 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 12:18:46 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 12:18:46 -0500
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH=xXfH7TPGt-zKXvJRNTgGDZKa1Xoq_sF3-WGs5kdsQLuYn4g@mail.gmail.com>
References: <CAH=xXfH7TPGt-zKXvJRNTgGDZKa1Xoq_sF3-WGs5kdsQLuYn4g@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 12:18:46 -0500
X-Gm-Features: AcwNN1XECKmKu1GxTPVkn99OW4KkbkvHxEsTNP08mCZaiXBBRgOrQ9k6FodzJbI
Message-ID: <CAH=xXfHU6McbWkYRreT_1=Fh9g+ONkSd8J7TYvqMQtQLboncLQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15eo-0001lu-2K
Subject: [f2fs-dev] [PATCH v5 01/11] f2fs: initialize sb_info early in
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 Kelvin Zhang <zhangxp1998@gmail.com>
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
@@ -5125,12 +5125,6 @@ static int f2fs_fill_super(struct super_block
*sb, struct fs_context *fc)
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
@@ -5138,6 +5132,14 @@ static int f2fs_fill_super(struct super_block
*sb, struct fs_context *fc)

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
@@ -5217,8 +5219,6 @@ static int f2fs_fill_super(struct super_block
*sb, struct fs_context *fc)
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
