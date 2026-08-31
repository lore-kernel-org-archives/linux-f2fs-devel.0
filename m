Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4A9C624A4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rRslYdFnE1ZX1SFpg8BL6LlWdgwlBShrO7wJXnd50EQ=; b=CDmLBCovRg+gN7Kmd2DpSApyP7
	JrQRsKZm2Bazq3alD8uxXSGggN6Yy6wh8O8fcuLM25u5wfdlC7s2A6N/Astou4cpsvB2SEl/nETxf
	mg9WC2kWOB6XMhIwdX5xGCPlI49xtTunb6ARlRFwYtbEldxSo1xwSFG26B8NsCCwjWN0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15Ot-0007ym-63;
	Mon, 31 Aug 2026 17:02:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15Oo-0007yV-04
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=; b=Gnl+zDk1C4L1hv8twTBaGygkrX
 4EdbWi5GDdHbGsSBDCO+yJm7oaYBvbx6+66AxYnX9kSFdW0c1DBzFDcYWGytCtDG/655gLnyJ18PW
 1oMbBEOi8HBO4HvHDKtxeXQmu9u+aAtUNcBx3WngBNrC5tTU7HqWDMXb0jVfr36xSLdA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:References:
 In-Reply-To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=; b=IfX3I0YprIaHJDJPRuni8b0YWi
 URWR9bSaXZX1MH1u9ztP1Pxr1lDL/tQRe2pTWxzZVmWrAcBFv691CfO8TAHf6+PPh7/y7uHYnSiGt
 s1xB6kJ+X8rpWxZSR38XlfUtnR3rx4rl78dqDXC5CNL+eaISSvWAyPQ866sOcABlPskw=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15Om-00014F-Fd for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:21 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a623987d32so4035594a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195734; cv=none;
 d=google.com; s=arc-20260327;
 b=LGnSFpXhpy/hlaTIvwoool8X47ijGndYjGEWnOCTmGZ8Fup8lUZkdk6oGM0bxSAvk0
 LV8UnziogHSG3UqdKxsHSDhTg4dH3Yieia4ZKeddzpXmjdhZyatihooEg20aGxryUT0a
 KK5Trdr8amvvqzxQSGKzGftph7j6kxnWCAS8Z5eaUkdK/ODO5Vpp6tGruB89ENX33rsH
 jSaK9Xyl7wLFI5FJzGiF4K5ogfGYZILd3vOyRt0680Zlk/lZPY9sA9JcuNC7+x055QWp
 U1alzjI54Rf+JRzRNh4t7xktus8yl1w0wdAWxH2ykgxtENgj1zBp45mICKpioDimiK5T
 GJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=KOxeX+SgE7xgTRr3DFnCzFLZ0OqRw/xMsKLH+p0U9XLH6MJ5Zo/pplYnA0eWuNlSPv
 jB2o6paczCoN5P3MjJjlhGepTI53ElN0vqcDvm6Y7czteU6rBPzSkwICH6LIv3vHBh6I
 kE75zqbWSLCAmazr4wAsaf+DkJ6/ENkJxCNo/ugcl4IE9tbMuh+wcXtC6jsh8chkyjHH
 6fz1k35VIjB+4e5jK1eRXZZjAHAOSsRKFq62XRkkIosbmTbNoxzvsFp2x379BzWoe8EM
 IStvZhuML5yg1t/i6LVUwIEPk9WFJptE+eLf/tw76XdEVHTMsxCMZ94xcxy0EudaKsEm
 +kOA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788195734; x=1788800534; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 b=cxKhQD4mxjbSpLfbNpB6wNQkrGjDFaEwbi4HKHJnaW90z9/we7QBVFeK2OJ/cjuzCW
 yr8Iu6L42zp1L+DpB7KiELZwggbi5+/E445OOEk37ECKf3qvmIowdJs5xCvPspupfWyN
 c7nzLIcH9+VsKMHov7s3HBSjL/SV1AL+sp4yz9kPZn8S1jBwpIOmWjll0xhJSpSqfhFT
 cBYvdvxqXtZvZwvE9TiudrTlrPxzn6AxD2wbiI6j2wcSX3NrgKM0xIT82xbgBwUoNdKy
 p+2QnC2MZ1XvKl/Pw+SLtO1XWl1p51IOtRFpBckJYpE+vf+rHyVE/4LAxD9a5sjl9f0Y
 CvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195734; x=1788800534;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 b=FkEjQug9jIcCm8AmLOwHzxs02BiIweNdhHVsdiqPfheF8X0JT2HsHsNQyzjQCqAJoO
 qMSxPiQNNI7eJhW8FmmNGt3B3IQNVKsk3tpynMubooqKZVbV9xuaXX57D/fOOmeSDSZO
 mxXNn/6ktp43TnHYxyqjMZOzNh0/+csa6I8kQU6JjytV2yeRUDdLy4X8w5haLaCOY41+
 h21RMdfK6tB/tEg5NEuk6iSee3YyPsy7wDP5UdfyQMhPFA+ldUIGuIDyALElOrDAT1ne
 HF5Sj/teT3i5djyOA6+94KjzEVIrcz7+fb1R806rJvuXmUCeHGSkPdKi5leR1ZVbbs4/
 huIQ==
X-Gm-Message-State: AFuF++kOqQSB2ZmuYlm7n8Do1vgz9b4EGKOLHLbBZLRnNes+ILCBYuaL
 z9//AoYTzXSrQzMUZEOZn9wYkokRrA5J6E5O1N9YHwZAFclsjysBbdromSvMfbeowA7pkwQXvnj
 T52XSksrweqsTUFmoys2v1GYykZMoZK1I8jNwZwk=
X-Gm-Gg: AYBFou2dmZo/34faRaHMV5QwBi6QdGfMVzw5Cq6YBaI8ly+sTwXCMj3ZjCjGXgFx2eE
 yXqGVqqQWC5vSRB2HhuuLV35+Q4CGbbeRmUvorbWgJw8xuMq+IJPtr+yci2RaDO+BREldp8Jtl/
 W0U2j+YquNbU9oSecraR72end5ov8QGGjwZIfeOAtCO52Gh9LE4GDQHjRc7UBgwSTt5y/NH0YmS
 no7PI22way85z/bMF9OL+aGWBmJxCh3oDkDk140r0WAuCxGHL8H5X+59+fj38XwW92TSOWSIbzZ
 Rj/bSRXH8Rag03/eBeLQX1ayX3RiEJr4+Ac8UJI3hztd90A9LNupxWPotq4nObpm5Sssn92JlOR
 mNw==
X-Received: by 2002:a05:6402:4250:20b0:6a6:306c:cceb with SMTP id
 4fb4d7f45d1cf-6a6306ccdc1mr7105653a12.12.1788195733806; Mon, 31 Aug 2026
 10:02:13 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:02:13 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:02:13 +0200
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
References: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 19:02:13 +0200
X-Gm-Features: AcwNN1X8t1JEq-gZM1vhFRWNWq1n-hqHETCF6GLSN__SLPSb1BiXeydxC8Mk9Yo
Message-ID: <CAH=xXfH+7+D9gkVnYyxxJOscCuE2BqKvptqJwsCmUi-AwACw6A@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15Om-00014F-Fd
Subject: [f2fs-dev] [PATCH v4 01/11] f2fs: initialize sb_info early in
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
