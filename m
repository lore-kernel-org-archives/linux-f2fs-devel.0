Return-Path: <SRS0=ibKk=A2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52146C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jul 2020 19:33:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBD42065D;
	Wed, 15 Jul 2020 19:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="O0ofAYge";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="YIOhc9yn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fEZnQPiM";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="fqllWkPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBD42065D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GfVUzWh7qXS5IJaxpSUpZTt03cuKVr5anoHOroxHFxQ=; b=O0ofAYgeQvzwdBf0JUVQDD/qZr
	cKgF6m5k6wDOE+vHXfl+w2GtzVlfhowANgoy26iPnbbmaTq8gJ4FAzsVEzlwrA6MK+q6UuW2coRwr
	46dwIP8iRR6FV6D/NklxMjax79NleqvhKH45q900PPiFX5wtbZNrEbUDTE4ACFt1CNcM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jvnA0-0001Iq-KR; Wed, 15 Jul 2020 19:33:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3GVQPXwcKAPwxgsqfiwksskpi.gsq@flex--tcombes.bounces.google.com>)
 id 1jvn9z-0001Ij-SD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jul 2020 19:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AVfda8N0HNmPsslRK6SlLZ+QkkYuIfrubWy707gmiOs=; b=YIOhc9ynz7bY6Q1TJxX3kjI/k2
 GvjTBd2uKX3V/8nsXrfaFKxkyL7KfBNrG+hyCqxilOi7s3p7nfjaoEV/Z6JS0cfnXJ+o+h4zxX/mn
 8EgolbQOA2OHr/HappnNJXfwGRmGzMwwrQZrQc+5NX8vDg/PDdZSZoX/Qvoz1kw0Ugsc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AVfda8N0HNmPsslRK6SlLZ+QkkYuIfrubWy707gmiOs=; b=f
 EZnQPiMzXRLDr86VLU89D87e7B97bxMo5A/j12f7vKv1M/mrpuM429SUq/39VMQqN7ze5iXxLG2Ei
 e1FvJZUCgEg44Qxg5RiQUpZEhoC7gZB/X9/2ONCc1zhjLNV9lJNRJnmsVQt2n0usN35tTitPzLLxL
 Vg/DxbToH2wEaHgM=;
Received: from mail-wr1-f73.google.com ([209.85.221.73])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jvn9y-004r7H-Pd
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jul 2020 19:33:43 +0000
Received: by mail-wr1-f73.google.com with SMTP id y18so2208940wrq.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2020 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=AVfda8N0HNmPsslRK6SlLZ+QkkYuIfrubWy707gmiOs=;
 b=fqllWkPjBbr6VR40c/ModwQJgheYEMm3LGxdpSLBJWv3TCpz4BaKUU5N9CCZ2Nqtfh
 j729X1eyrhqmujPTYbzCg9v/gSr70JR+wyPfQ1Ppo/bhzZb+JnJNwKG/tHuw3QG04DYW
 a0LlT/CVlROuJIkNF4YpOYJdUXjibmVlCwSnwtjT0zQHwyRBQWYw5zBSXYYy+qMARDN3
 YQN5fVVr4O89hQpR6mrZuHxwlsLkWyT5kGk9WJBiMHROF251oISbdx9Fa0i4bFS/hQ2X
 ig+WSJlTYb+l7LYOHMo3+oo3fzf1/65M3jnezPhJbn1Jnil2EnUscFowdhWnKtVf6r8/
 Y+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=AVfda8N0HNmPsslRK6SlLZ+QkkYuIfrubWy707gmiOs=;
 b=sJyg1XznI/pVBo52FzloKdTCk7Q2UojSGcJLSM+KX9Px8uOT551DCP41HYBULktb0S
 CujOF9A+XOdSvDSWMgj/zSAX9GSDlZcWz8+0fToAQ21+mAcub6vdXSKkm0AduOZSpuLZ
 F8heoBKlekAnSLeumNhEPdKtjWpLQYtT1i6xfMtvU5bKdQ/Ilx9ob8Xukh0B7nNxWpu0
 QimFHfouCykY9df+3cN4pTUw/p+9SlONjqTuzdF1Sgk22Lp8FjkmMOPTIOHmWVTWVV/Q
 E197utELzD/NDM/KHkNIfjAyb5Yj+N8WzfDARHkXBGG6nzMiFhRKAvNv3mYMgWaP2mvk
 1auQ==
X-Gm-Message-State: AOAM530TFqnDKXzHJELOTipUWdwcFd34XKSG61874R6axDbWWZ5+RQUL
 f+KUWRaw8X+7unTjVDTFVACRmSdRYMUkf9Zd1o8kbN9qu9XK+M/Vex4CHuuqwDILJLTlgjQMZCj
 yJkdpFZuKsnsQTBflktiAB5p6FPC6iTU2+PXvIJ4ztGuTgYmsVWyMYd0KWH/qMwyq8Xw7KPzVrs
 OXlC/2OOwv
X-Google-Smtp-Source: ABdhPJy1xCoHQ0sI/9Yb3sEZf38SEATuC9784lrxgCY30Skbx7C5ZbZtzcv7ZMhPUoSVMme6U25AdpamcZmu
X-Received: by 2002:a1c:cc09:: with SMTP id h9mr1323189wmb.1.1594840089237;
 Wed, 15 Jul 2020 12:08:09 -0700 (PDT)
Date: Wed, 15 Jul 2020 19:08:05 +0000
Message-Id: <20200715190805.3349558-1-tcombes@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1jvn9y-004r7H-Pd
Subject: [f2fs-dev] [PATCH] fsck.f2fs: avoid randomness in sum_blk
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
From: Theotime Combes via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Theotime Combes <tcombes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch removes random bytes in sum_blk when loading a new directory.

Signed-off-by: Theotime Combes <tcombes@google.com>
---
 fsck/mount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index c63e8d1..a54abc4 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1940,9 +1940,9 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 	SM_I(sbi)->curseg_array = array;
 
 	for (i = 0; i < NR_CURSEG_TYPE; i++) {
-		array[i].sum_blk = malloc(PAGE_CACHE_SIZE);
+		array[i].sum_blk = calloc(PAGE_CACHE_SIZE, 1);
 		if (!array[i].sum_blk) {
-			MSG(1, "\tError: Malloc failed for build_curseg!!\n");
+			MSG(1, "\tError: Calloc failed for build_curseg!!\n");
 			goto seg_cleanup;
 		}
 
-- 
2.27.0.389.gc38d7665816-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
