Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277B7C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rRslYdFnE1ZX1SFpg8BL6LlWdgwlBShrO7wJXnd50EQ=; b=fD9VJw4l0fq4NpREoR2jjhN7u6
	6QsmPCrgDSfI5esnPJh9W2v+DRhFOSrtxYIuSYSZKObIuGWjvHH05kYD1/CJbNyMUxvgNuwui9Zzt
	g7hEC0ivAUzEZb9Rz8xTbAWIkjKfw1ow0DCZfE2Zdn1hXr5LmNA+K4BkFgANuEj086XE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0udl-0002Hu-Ia;
	Mon, 31 Aug 2026 05:33:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x0udj-0002Hl-QG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=; b=Fpsie/dEc4W6DIBbSBPgOWBK2/
 Y/mu53ykqdeV96VovXbn/7N7SrNbQY4g/lyCZD4fBLBlNQ+uBY0t3pBRLNl81q8vgR1hhCuTVeQO4
 0IuDl60+txhO3d/TnPzKMUKJrUYCFpXJEQS1KWXG8R1VvT7ZoqgCDarLOhJJCC42Bz1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=; b=alqvp9d7PopHRXrfXNT+zMr75p
 oN40eNrThdjyplNzV5Gj8lLD7ul6J5Sx24fYoYB0Ov5LhAXD8goNSxYMdKLHjG6l2Au4mzxOpYryL
 ub64oOTorbjJC794yfmz52kLWn3yUc1yNOpl4qSX/q1OGQffb7bBKLXNvmNMnbqVt+lA=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0udi-00089q-7h for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 05:33:03 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a5f968ada7so6121487a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 22:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788154375; cv=none;
 d=google.com; s=arc-20260327;
 b=UfnoH8m4GrMJf/VTEhXSuUkzCqHzdWYzLYbRSuXWrQTBdEimrVIM7EOCCWEEKD5Kmt
 DDloHbL0/ecE6HfkNCzGewXfMeChWc7YZbs5sESrpYkKwtTCeIk6LiWF0QU+bKC26eTP
 dzu8+zdP0odpMQURDXav8d0JVc6oc0ajaK8dOx8cyj8EmmOsXmNk8rifrQs48B9X/oLF
 J5EUL5vRG5NY/RFMJp3k+Fc4PrFbtqKDqaYur1+p6bnWwrfhc7FTEMLQ0l6VyFghcLW9
 7V46E7hKe6HnWzOg5Z07jjNso0HZ4+vPBgXnJwymAaRydJP+fypkq5SeTWVcVBtQLcXJ
 PYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=pAL6AVccvPkYa3v+NMwCpRDaLSEiDzjwnENnRa92nxWZQ4YdpaUDKCnKWqnjt+BZ0Z
 hKsazWQsHq6O61hk0yqHyPcH40f1CorwlMbH7fDdwZdZ70R6SgENtMc42bid9dA/CwBW
 svizOgMcCH2PoXtTYAHZw922f5gfEoy849VIS81pbg7FinjGxcMqfsVyvFShS1Ga10JL
 eFhE6mBclL5dx+2RDhRvNGqP34OoiTm+yzxs5zNGqQOWugwmhcsklr7Vak4ZLAFh+5qF
 uPVpSID+IUu5Xg2mOQI7koKoJAxwqGbEXqyZGZFRl6YlVNtyvnxDnFLUnTcM/UAxWCpv
 h1WQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788154375; x=1788759175; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 b=QeG2sLG0OHgNfLNw5ORQOmoJF/7vhjsxBc+9Uk7ezcV/5IXs0naiNvFs7LnKxwd08u
 JAC2yZMc/qvg9QlNmM7gMEDzoJOhp46g4ATn837co4Ww+gWkUu67oaO+RHBj0ZbvPJjm
 YZWQglHetGnXklgrbb+VBptoRAwtGDKNObJiLY2+U8wb+JnqdWz3vRBzQUOCcZ2yc9j0
 OoVGrePNGaDGNSkjJsKkuvnJ5auUp7rnuPgIKjqo5RXn5/7zEZQHyDiYhpOL6IHiNd0X
 YT+uVbpolc7z8NZzh5Hfst9m9Bw2Z8ioB47dXK3KG4F+DRo3EQD/7w6+lqVQtk1LPVdP
 bA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788154375; x=1788759175;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C/Ut8igNUUEDDCrdtbCLiaGMVpNyyvqtTQshGja4fhw=;
 b=HKi7+evpTgOXzfHPwfVOGkc1nURuVdGhfko9QGWe0MdTGImugGY/gaKtZ82WRLZpK7
 CTsyELjiUFbK68CxLxo4VnbjOckRs0aEuGxc7lKiOq6I4T9KnWHaV1gyCRTbAasw2Cl5
 OD9z92FzpjVua/izvhgNtBV4aDhR1+GjB6BTAsDitA0ldmhWC76Lw4CtTCv7Awbbnbh3
 rh2C5Oi56lRobbXqISs6ppdQJ4oCvxv1JGyOc/UnIYh0T01oXcp/GogMpej2Dinz4pmH
 DTTZHk778xVn8CbF6fvy8KB9HX1opivOiIOtF2OnYCQHVVY9G8c6DnPPb/Zrs+cRPhgm
 M/Mw==
X-Gm-Message-State: AFuF++mOnGQJ1kfQSRREXnalHoQQAKmDKuBfMpxAjM2FW+Pu2S2IV0Tf
 WINqrUYranm4wfzO1esCtM6ysxTgpe4mQxVT9zckR5VGeqpBIu+j+XMD/0ldo1Vkb2QwrJNvKD2
 2QRsEkFIuvGYoeQMDsXbZw/7M8oGQ7Ty5zs338c8=
X-Gm-Gg: AYBFou1BZdcy9cKIRu87fJlBBarGIX82UKhCSsSn0uxNr1bf3KPHXpY6LdO91A4skao
 wIrgny64XafG3lKQd5pydhn2taoJxy51enaa+rQPFqAumkVvE4eNUQSsyOjHFEsVb5hbkydB5jO
 zDbF4KCvwwyQpNswScLukFhfr7TGETW1/zae4mvd3uUV1vr3glNYpmY8Muj4BNCm4B+OhJwrAG4
 RuNX9Bb4iJaXm7zQrK0XjCyofubmxF8wzgT5zC9Gmd/8umNUW92TC2a3wV88koPWjgbN5zC0gy+
 6ZSLViIPxTbjQFvnmjEW/oWFpbe6jkdyg/4cTt+m3xj8XOlLiDvcqJaWUWNYQZQ93HI1EpA1zSX
 YbA==
X-Received: by 2002:a05:6402:20cd:b0:6a0:a46b:ad3c with SMTP id
 4fb4d7f45d1cf-6a647693f75mr3043988a12.1.1788154375170; Sun, 30 Aug 2026
 22:32:55 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:32:54 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 07:32:54 +0200
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
References: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
Date: Mon, 31 Aug 2026 07:32:54 +0200
X-Gm-Features: AcwNN1W8uweP2JBSMGV-7BI3xN00j4I-usGHDHDv_RvI16_JsR6crt1gVAKyW-I
Message-ID: <CAH=xXfHL4bWFMVa=-a8sRuR_bn9VcaFRo+X3eeZfedSa0C7dww@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x0udi-00089q-7h
Subject: [f2fs-dev] [PATCH v3 01/11] f2fs: initialize sb_info early in
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
