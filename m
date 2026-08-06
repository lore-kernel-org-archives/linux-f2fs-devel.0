Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26790C56207
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8BDMcsYEpOiTRugukqJTjv6RdfiS9AFxN+4N7oA1iDg=; b=HlPygfMZ5ySThV/6r87+V3YErn
	ZAqNu2L7/3iGrK2bB9pJYEOwZ9NUfdjv1QKKd//CdpkDF8FnGQe4SiJr54cFaVPRnH0m7imp29l5u
	xpeTA5VlbIbCLYBhYXHmOKtNLMSFi4aqwXHZrWFc9jCKV9F2pBSjp6vu+wZ3y1fJ3dP4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrzha-0001iU-P7;
	Thu, 06 Aug 2026 15:08:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wrzhZ-0001iH-IB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0NhSZMxoocoJBKQ1xqet64wm9X5U1CRxDHknTgi5hq0=; b=OSpooQFqYrL50sVNGZyyLczaDT
 ptEx0uWZLXs9x9dTZ/dpo7eRSQOeXMWGP3v1n8JrGU+SeRzQQmk8Gld0Wd7W+0wx7Aqk66nefep3Z
 sjVsTm6ZoorTvx660ZEIZHLIs+JEoSgZPTv3NizXiRRpLDOBLGtbGy/Ga21/H+n/OVhI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0NhSZMxoocoJBKQ1xqet64wm9X5U1CRxDHknTgi5hq0=; b=WpR58mvJSnN0y2v+BEzy/wDaTA
 +y2z+rWORnYNhP9hNjQDAaQqjrTz3glUGHsG+Ojwl+AzZKDj6IVNdiuiNLLbowBCMbojIik00077b
 GDK0fVm5xJ36KFHYZa/BCc0CKgj0pEVFpQpl/10mc2etg2ySbOL+a4dHuO4Auypa+oS0=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrzhY-0006Om-VQ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 15:08:10 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-848643382fcso2613790b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786028883; x=1786633683; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0NhSZMxoocoJBKQ1xqet64wm9X5U1CRxDHknTgi5hq0=;
 b=gbJDD1q6wtMzcULLeT8VrVwO/VVrQ23Ww35I/wpXPj3I1YA3NHK6xsj1yGu8vdpLov
 qHoLs/t19SyeAxnh0LSlwMKBtYD/cEYhrQDlUaMOq9O5QncgoFlzJ/ajfW6/GQG8D48Y
 aCnInKC2xwqJBYCWz0XOP0aYfdzXXfPU7N8j5gqVschUc64YoAFyQb6iV5Wh/WlY7XTf
 0xmdwRvyJ8KuCLqzLSpkfpcZGuQutvtVwUSt3hg9FLrntb2Nh2bUsZ8bdLxeYeTzKkLU
 IxU5ESupTWtSlvOIHDRw7fOPKq+37ZD1uNyzJkv3pyygTbQPrrnb0hai81fw3Wafwoj/
 9jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786028883; x=1786633683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0NhSZMxoocoJBKQ1xqet64wm9X5U1CRxDHknTgi5hq0=;
 b=OnjoDxuMxHxS6WJh5WK3fy9UALLEYwgWaFWtMO8ZKzN9hjrwQ1sslGGffiSYobGWJ3
 p+fGh9qDIpVXVRC9NrCsbLcioBIh7WLpYUMEkGnMsplrEdMyH9lR4LH3JAJiz/ZJX7AT
 ibriwZ1T9sGeEmJCnKfBk1VVrWbJXZIeHOqTQiOze4o0kkmUb94HGApW6wCt4yivvi3P
 uxFfBRigcmIyVRFeVw+f2179JeFbP13xJDKfcDBUEVMSdvfoxp4eBw5XCyBUB2RFq3sO
 fnoNQX1Tk/6VuPxZRr5cPpKf6WxT80Q0S6k7PesC0NjKXes3jiiqDH5zaIjD8ViZ0SBK
 xr1w==
X-Gm-Message-State: AOJu0YxiwcOAVI5YIwo0h4OV7IEt/rwL+fFCzTJ0b8EPiOct6TavjmxQ
 MYhyXhxiA0IjUCdQmWRDWdjTVLq+0eBIgUYO9GxH96f45ivpaqVGIu+F
X-Gm-Gg: AR+sD11SZg+QZNeiVDXftjBOzrxBPKpRe1DWlgGfQddK/MqfLGrlYnVzwQIvSmpN96H
 E6zliSLQAvopL3JpqlVwCeezIjA6T5HmfM4RB5k2w2Lvl615L5DMtz0lx1wEJESYGL+hbAm/lkB
 HAjT21sCviKb9n4EZHBlt4ee/X8MuWsRHElA+buWiAz0bfo0+sC1ghHDOW7BqaTQoEbT+jFxFMA
 NNZ8Hjtr0UCeCVHmpsPg5iVKEbVzabozWDMBnzeTO3rt/04msTjutgzDl71N+WYl1+YUc0BbEUD
 9CvvHPhacBBOQQ3+WKqU7Ouq+3c0+YyF0rtCENnTYaA9VqDmiwNrt8Oy6LCjsQ77/wChhGFyGgD
 l76FHfN0qIGX0sbcp/o6fkAW5qsM/GwtIkQW+g0zmhnxZi11ettBw5C63oaYoGtsbqorKT3HiFU
 ghUC+gJN/rqARfN1EUCKpcIDv7liNzuXFqcHOfk7n+RHb1WVbv8u2uo8J2LIUj4EROyk5mFGJXh
 loGTwrUU7fuY6m40QKCarfE
X-Received: by 2002:a05:6a00:409b:b0:848:467d:293a with SMTP id
 d2e1a72fcca58-84f2e12c9e9mr19261659b3a.35.1786028883261; 
 Thu, 06 Aug 2026 08:08:03 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f45bc9c6bsm1586448b3a.56.2026.08.06.08.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 08:08:02 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu,  6 Aug 2026 23:07:47 +0800
Message-ID: <20260806150748.3554436-3-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806150748.3554436-1-qiwenjie@xiaomi.com>
References: <20260806150748.3554436-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wrzhY-0006Om-VQ
Subject: [f2fs-dev] [RFC PATCH 2/2] f2fs: enable buffered RWF_DONTCACHE
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Expose FOP_DONTCACHE and propagate IOCB_DONTCACHE
to write_begin folio allocation so buffered
RWF_DONTCACHE can reach the F2FS write path.

The write-side completion and bio-isolation
semantics are prepared by the previous patch in
this RFC series.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 9 ++++++---
 fs/f2fs/file.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8a1e407..40c8f7a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3982,6 +3982,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
 	pgoff_t index = pos >> PAGE_SHIFT;
+	fgf_t fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	bool need_balance = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
@@ -4031,9 +4032,11 @@ repeat:
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
 	 */
-	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT,
-				mapping_gfp_mask(mapping));
+	if (iocb && (iocb->ki_flags & IOCB_DONTCACHE))
+		fgp_flags |= FGP_DONTCACHE;
+
+	folio = f2fs_filemap_get_folio(mapping, index, fgp_flags,
+				       mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
 		goto fail;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b99d9cd..b3d1684 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5578,6 +5578,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
