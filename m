Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B64C61DE6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rRslYdFnE1ZX1SFpg8BL6LlWdgwlBShrO7wJXnd50EQ=; b=St5Tq/KGJ8Cu1dYjVDeZRrql0y
	TuPMleemu0mImE+d4awcwbtkRNtIL5cImxS+2z8TupzdgdGPqGZW7JzcPuUKsnY9SHV6KJRx70N/n
	WCY6oJRG8EdLcuUyb1Ot5PYGH5I7HjtPIZhYDbza7Rv5oFQl8r924pv+Qup6duAkaNR0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0NBu-0002ac-Uz;
	Sat, 29 Aug 2026 17:50:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0NBo-0002YH-RJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 17:50:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=; b=EzejT++cZVdqjMLDGRFNO8iOhG
 pGCd0OQSxHqZky5X4y9dgUkDUsMqglLBQagnOQ58rQaekwpVtFCOlWrCvda/bCrdIymySneG50g8v
 pvEfr5U0ihjmeLfJsgq5QII0LI8G1Yt03pMGVamdOlwRdQwEJJhUzL12MMdcgcjIyUWY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=; b=flSKDLKGDjKR0nH/F8yuRRHilR
 BJ6QBoWrJX94gDadN5IEK7baENFrXqeQh196E1Ev09MFlhgXZgCYOx4wwsbtJ6Dgw2eDOng4fUDvg
 eewFwL2ooIV1BbP0LoX/VxXlwBiFVkhsWe0269HPQQ+7mX6liKga+TBgGGC9WmAst7x0=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0NBN-0005vp-EV for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 17:49:33 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so3513367a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 29 Aug 2026 10:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788025767; cv=none;
 d=google.com; s=arc-20260327;
 b=LD34NYmVor5pk7oxamTU2sNt5Fb/oMDTsdV0WSa5URlzZKC96tGFNZZPTKrL+0qoXM
 vDuJgFwaFwsulx7i07mJw8bRd4DV6++AO5s7QcThDoGtsjdiKJkgDU0n3LVK/pK2b0bi
 5h5kzRNaUlLqdAYqPJToVbHpmdcTqtlyXOc8an3YbwE4tgf+n/roctPXdQ+pS6SrrozN
 pPFOHYmKSj7/eC5bdWs0lQAoPM63GwIHomqeI8FEdWpq3Z9KTQZex38OuvZkOtAUWXmu
 jD9fIHhCYwypYQ9wOOM4Av1XHuSHXer+4sRALwBhCe70Wl7h53+FOTxeH/9IkdtD24gn
 rAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=CnNktGvnU7/TiQT2TYEEboAIVNTsh8pPi1+yABsheK4e4Wmyx73QBilZQn0Lmi5fKz
 dkV/VArWm3suvhH/3gOweFDSy7dj/DXhC1FzId7ZfQmIet8N+bsCrHQsqMVE6ulWxo1L
 GnnfM0aKXAplQCiFwZdclPZmuR6zmNWYNBf+IxaD72n/gaoRPrkUm7RI9TAGqSKywg50
 UFwypfZS7drFPLsl3eZ+pIahYucqCdf0fPXWDZ2SL9c3/IxmlS7rtqCVvd8+FGKr6+IJ
 8ldja6F5zua1ogw7xG8JkPhYzMICyW/jNQrbUqd3JcLFtv4MCgWvMlCT68FaL44QvCj7
 l10A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788025767; x=1788630567; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 b=CZeVNkiSG3U0Cb1/jbojr47N4anBl2NvgZcUhZMTiTteKt32CT/ywZWWquzK+Tm6Hq
 /Qe9HCAyCybwuOGzVs7xZ0UvbILHVf5st4cpXtm+8MECF3SUurGdTFn3+UQORgrJatYE
 whz/oWbzJG+Z6nwmIJUJnWJU5oUpRtRFhAhn+tgXmvw0B7Imc7AFKYEXbaF2U6lgCxR/
 /f0V9e3Fo1XFSj07TXnWyLWO2dtIHyCbkQtdzE7tB7Y8XaIBlVzH6Td+dDx99gy6rt6G
 sRhTg+aiyQEpcutN5M6AVqOktfYWF5ukM3q+vshumwFXiyIBgO6imGx2ZFI4J6U2KrZT
 /wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788025767; x=1788630567;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 b=Oqzcs9MkebBz24I9xHeWavoru2fxgKAvdx6XSrf192I98d2FrZyDMtTqJJhVV4kqzd
 1fzkpvzh/PFlauTAS3XnmydyecbD6FsY76xlRPmpybLerFnGSgLDHM7kea90HngJ7sEi
 1ef9W/irF0HEYyzj3//y8cQqhg6XChBaElAbWuSfz97ecxZqTZdY+exC5fe57iYcvJCa
 iwUSqFEVyZ0TcQaI/W/+XpmMhb+nocID/0GyCSho+d/rNRUTMgf8cxE7E4//4ls4lUnm
 XeO+8j19cSIxDAaBL4oETuXM9/L4A/fjt9NizAXM5pyAyVdY9khjLWFFwVkI3B+0ml+D
 LPrQ==
X-Gm-Message-State: AFuF++lACxElXiHOAJS9+WwS6R/e2oHAl7xSX32Y+DlxClffeaT219UX
 mVN1CSsVgjwwE04+0Y4TgQf+qw7Yzp3PVsaI03ifUWyc7jODooZId651pTLNoM7p9pvb9maPI5b
 igm6fVfFZy+XJJU5OKaMj0B+dx5Xfp/Bfz9IoUzs=
X-Gm-Gg: AYBFou3knsI/eHYHnToBA6SQZD/mys5Kuxc8oOyYwf79d1V+CVRXXJ1Ux7DMAFmagz8
 2rV0lAhVETIdiWFDW0Wrac/Bux4bDy9pkN3LbLeL5fJa7TAMRDi4/++lVHXe1vPzVpnrUxPJRxf
 WZvfQa1zb6SUVqbGHIWHed1ONZwmCCIurAveZIBoL4nfxO+YarKnf3cNLQgF/7WbysHVYaH31yz
 H9+BCGvapXS3H8Vvd0zWPxg0WlJqwPqpvD+mI/mCa8QL+hsZMcU44WUiVnLyM3f7QIRckJB/rTV
 8Mu4XnRUcHBQU7j2sDU/jgcWn0GFVZv+TpSUA1S3QBf0d6T391w1q3pi5jUYmIoGM73/XRxv+mz
 Gmg==
X-Received: by 2002:a05:6402:2354:b0:6a6:32f6:10 with SMTP id
 4fb4d7f45d1cf-6a632f6018fmr2135352a12.22.1788025766571; Sat, 29 Aug 2026
 10:49:26 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 10:49:26 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Aug 2026 10:49:26 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com>
References: <CAH=xXfHWW_J92z3YgvoLSx8+z6rekq=p2kiP15KE9=2+Ju2RjQ@mail.gmail.com>
Date: Sat, 29 Aug 2026 10:49:26 -0700
X-Gm-Features: AcwNN1VPFbUxMZo0vv3M1b072VLJ8ALxYO_nCN1eu9bWQAa0bdENrYB8eDbqABo
Message-ID: <CAH=xXfFTThTDXpLX=F3j1Nmj8ypViopBLSRkwAvX2wGJ5wkaQQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0NBN-0005vp-EV
Subject: [f2fs-dev] [PATCH v2 01/11] f2fs: initialize sb_info early in
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
