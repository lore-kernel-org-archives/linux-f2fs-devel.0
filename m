Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC37EDF159
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Feb 2026 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E8emAlRYkGnvnAtiS+tDF3pRQ7BfRX351ZWM/3zabYM=; b=J0HuMoYK3p8KKvZ30vxrDYhlsz
	epDatOhSvPSr46q2MwC36imWznDOUNfXBhtzh3PY5hklleC0aazcT48yn0GGOCpp9C6t0ZSCJ+OPm
	xWu+5fdws8RaGKr1FjcUlYZBYhY+KUJteV/BbkVRvjMo+q7zILc1VI/xrZvI02XFq/U4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vqsG8-0006K0-4g;
	Fri, 13 Feb 2026 12:26:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1vqsG6-0006Ju-Ft
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Feb 2026 12:26:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ihQelNxxxE86Yu975NKKOV5Xmyw2LwiMN4HOx9a3cbs=; b=P61MSyTihsiWgDfn/JlVtAgUPb
 okxyY3vTDCDLhUViyinCdN2XyO41cZ4b01dpreilEw+1fCLNTWhwVJX/DROK8AhQBS10fwXRdKF7P
 UE5KvEKQQPNNAo5Fu7I6QrSY7G9S3/v2qAQ9no8O+0Wdl+OZDK4p/FN2pno/nC3IJ9qo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ihQelNxxxE86Yu975NKKOV5Xmyw2LwiMN4HOx9a3cbs=; b=U
 wCaN6WWdKv2Dj3LipxmAI4XZuNDZZmpNTz+IWa5fimj5OdqMa6PuKilVavj8sf/eQlBh2cvSHEJS6
 ZIB0jAC+C+aifQ2y8jzarEjZf+u8XtL4xy0U5lr0/KVabU82ihDAxVg6KMWESVaSKtL4nnvRSdG9a
 dohUBskHnCROJikY=;
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vqsG6-0002Ez-4P for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Feb 2026 12:26:54 +0000
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c6e3e4e7388so295142a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 Feb 2026 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770985603; x=1771590403; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ihQelNxxxE86Yu975NKKOV5Xmyw2LwiMN4HOx9a3cbs=;
 b=D0x5ZcYhlw0byxa940FVGHxMh4iXi5nS3trTICHSmCaON7BMc1DubwtFZIcAV7HUsf
 GjnY0IDFr62DIYn9X0YqDRSF5VXS09pLQzLoyOakB+bYguHeTy+RUuM+r/v5asCqdQ7g
 7ZJnjDfIr3IvpaRVkIqogqDwcN+Kwq7fWQtzoNSNZIL3V02Q49kw9KDhMB84P/GXGWLo
 zKfFI598glk9FYKFbWmH1+Y3FID5zVdNr6a6+g4SKY4O7AlLJo/PjJnTQtCpSIDmUNCg
 oeLgRiAg0iq+PnmJyHXNsR8TwlLPuBRHrGnCAsvsbWO6iTQB4P6Kj4advVxr1qN2P5qB
 tc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770985603; x=1771590403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihQelNxxxE86Yu975NKKOV5Xmyw2LwiMN4HOx9a3cbs=;
 b=FhYj+pGDJZSF0fKdhzeO5D5HUC+QGRDkGZFgBOP56SxeAORy75Fk9lR05ZmUx3x8Pl
 YtrRS7726s9XBxOJKglTsHMOYqCio+ZMLwMXj57qvYeGxmJOK5rIZEeoxAFNvE8IIFmm
 yF02lBNsw3iDKBpe8CjczfJZxcDRvwWZORV1hpcwivQJzZJCdf5e9Cd7SfRCYp6NFXuV
 1nuy5IBZYeGlbdrc0dPGCEXYoBeyrRojJ/BE1+AXPwZOSTaRIBeknpTJHkkaAX3yZWPG
 FQqGiM7Pexe5549Ab75PwGqk/3iKU/FpNymmWvH1gO8Hy353WirLNFvrMclKcvHkyi9c
 MH4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyZ1AQSprt0JyFYyW4u5Nbua6iBh26Pw4u/bPElU+V8SMXJzCCfOgLsMMx9Z5u0rhePnm1SQrpBQZiNoZDBC9t@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yynf+xzEmTcaq+ziR9qwwi+3xd4DLJgnnL9xkqo7APEgjNFfWfn
 Q5vp8DveyLFkMIVmHU2unIeQUZbETNhMrC/twp0qJMVpLkSxMbrx1mh1
X-Gm-Gg: AZuq6aJUmfgeNGoJWQVWWVZ4JXVQycUOcxmjEzdrn2HOfE3DJYKz8stNGgQRWUQ4Yof
 u90F28u1eum+mvbB+2zBbtQUtEMu/uw8BrYtKqH61sOFj81uFwshGz9MJREKjVODzw2SoFGXhXP
 mUGL5OGbOMp7UxDeKKNyXFbLrNQJGXk1BWjA7V3pz4pTk84ymK4yOPvjS+ebjlrl4oTyZqjOxXH
 EdvtX1+jpskhuDnRkq9R3I+4BGE3tv8BDYFc3K09nI2cn+F9KPHcWNZIK0wizleTLgEp/L8u3lG
 ITg96T6cKGLLIRxjqB+czWRdoxS4U3xON7wsybt0VmXz/sH2+sZEeho9H5uz3Kf2iUUZCzMKk+w
 2KFEEoP4ZH+Og9b4HkVTjUaMtzYEzM1Ig8qHn/5y2t+Vu47PsEPr55ds1tSnbSbSagPSItFpXzQ
 VL6LGNqLWtqRKNxX3bYb8Q+e5D529/
X-Received: by 2002:a17:90a:d60c:b0:343:d70e:bef0 with SMTP id
 98e67ed59e1d1-356aad6cf5dmr1721312a91.21.1770985603379; 
 Fri, 13 Feb 2026 04:26:43 -0800 (PST)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:8eec:4bff:fe94:a95d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35662e6cc17sm12079244a91.5.2026.02.13.04.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 04:26:42 -0800 (PST)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org
Date: Fri, 13 Feb 2026 20:26:30 +0800
Message-Id: <20260213122630.287516-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1vqsG6-0002Ez-4P
Subject: [f2fs-dev] [PATCH v2] f2fs:Fix incomplete search range in
 f2fs_get_victim when f2fs_need_rand_seg is enabled
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
Cc: jinbaoliu365@gmail.com, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: liujinbao1 <liujinbao1@xiaomi.com>

During the f2fs_get_victim process, when the f2fs_need_rand_seg is enabled in select_policy,
p->offset is a random value, and the search range is from p->offset to MAIN_SECS.
When segno >= last_segment, the loop breaks and exits directly without searching
the range from 0 to p->offset.This results in an incomplete search when the random
offset is not zero.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/f2fs/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 384fa7e2085b..a5b333bbb201 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -312,10 +312,11 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 		p->max_search = sbi->max_victim_search;
 
 	/* let's select beginning hot/small space first. */
-	if (f2fs_need_rand_seg(sbi))
+	if (f2fs_need_rand_seg(sbi)) {
 		p->offset = get_random_u32_below(MAIN_SECS(sbi) *
 						SEGS_PER_SEC(sbi));
-	else if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
+		SIT_I(sbi)->last_victim[p->gc_mode] = p->offset;
+	} else if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
 		p->offset = 0;
 	else
 		p->offset = SIT_I(sbi)->last_victim[p->gc_mode];
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
