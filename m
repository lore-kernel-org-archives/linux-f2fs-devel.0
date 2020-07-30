Return-Path: <SRS0=xc4u=BJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E97DC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2020 05:09:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A342072A;
	Thu, 30 Jul 2020 05:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="IY/admx3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Z28iLYhW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdyooRrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A342072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k10pA-0003rE-2x; Thu, 30 Jul 2020 05:09:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1k10p9-0003r7-4g
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jul 2020 05:09:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sRoZs4D1CNYfrOlS/aIbzgfYQ1SktXdRegTngPqrg14=; b=IY/admx3SYkRiFTprkPCnQ9ont
 TPqgIlay56fRx6Efw2vLwzKcEcO5o83DT4eYkEEfuhcrfh3FyKdCiZF1Fwiu0f5cJHqPT7OegYOZy
 KHqNleY9bKRvKv40cWN0sVcdKY5hke7aUO6jQRnbYyiFcObfwMs7/Dih4OnBd/j66Cxc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sRoZs4D1CNYfrOlS/aIbzgfYQ1SktXdRegTngPqrg14=; b=Z
 28iLYhWF+2CrU+BDaZYYpojo7sk+ffgIwOWT/5uyoSlZ2x1z3UwlNGxCuhwTVJlm5Wb5pGphbJsec
 J0hl5/trlRye+HnenlJ1cFyTT2ENmJzEqO+OrQOPBhyIB5XZ7nMIdrTMQ0nuKR36UkCuGGYZCeWWg
 sPseDvtmfCmCclMQ=;
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1k10p4-003xuZ-NF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jul 2020 05:09:47 +0000
Received: by mail-pj1-f66.google.com with SMTP id ha11so3550680pjb.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2020 22:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sRoZs4D1CNYfrOlS/aIbzgfYQ1SktXdRegTngPqrg14=;
 b=fdyooRrCV2FclnceL3/Yy52L/nRYSE9ERsZFzzFuLa3JmRzvQwUDzkKA7/vTPmKPJ9
 Caeb7dcjTkKReY5z4JeUlDtndhMDeNlHdqSVIhtH3otK8TY1/2N6EUsLwv2eFSbw/C4R
 OwsdfK2BJMI25F1/ytu4jlRYHSyR1eAlbOZiWVO2x9DTyNEOBqS12k7Zlx12Bbv89L5u
 r2DWb2jJ3w6AMa35/wrUiSSuB5n8ewiT40jWARpeXMLeh66v/y/DNDzRS+yC5x2iDLYi
 RfMuO1bo1wAtts0VaskgEoIhQcbSgUrglP1bbuzoTQK38R9sQOVCFIm1P5kE3bv6Bgj9
 2GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sRoZs4D1CNYfrOlS/aIbzgfYQ1SktXdRegTngPqrg14=;
 b=aubOVJfw2Oqbx4rnMLUxJ1dpBP3ejWIPoz0qu7RA0iAFQMTqSWPBx8QccGxsEKvraC
 b5PcpmvjA+QFAQ7Oke6n5MCQuAGu90uZowDOTmX+GCcAk1nMXolksbiV+mzPrkICNLzl
 QqSFZ6VzrnreFEzRMWFFDb3Yk3NFH3lxzqv1vkufsJIFlSR2FdJHAhxKpQNhqcSZt9xk
 KHIwe99UudwVumM2/kE3wQEMHjZ4UG2NKlO4Lx3a27+Ym5/DtGsz/tAaFWgKTLETpdQ4
 UEwOVjcygYHVVOlM2aTRFHH8WC+3G0UIOQ1+kzIwN1Ql0Z+kXJKFxPkKP2TlDk1T7ApI
 RGsQ==
X-Gm-Message-State: AOAM530MHngVjIpjglUVUMHnezlnOn1htYXjtT79yvFr7j1/AQXJSMy/
 c9WUpgyI0QHexLLyx0bEJ6Q=
X-Google-Smtp-Source: ABdhPJzhloODSlqZ3SGmchjbJDqStVbAQ+Gk407WqgbI1VfbjtKH+UMNMIzktYU3EmXJczDNA+Tfng==
X-Received: by 2002:a17:902:7d90:: with SMTP id
 a16mr29784015plm.226.1596085776116; 
 Wed, 29 Jul 2020 22:09:36 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com
 ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
 by smtp.gmail.com with ESMTPSA id q3sm3690057pjo.16.2020.07.29.22.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 22:09:35 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 30 Jul 2020 14:09:28 +0900
Message-Id: <20200730050928.356916-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
X-Headers-End: 1k10p4-003xuZ-NF
Subject: [f2fs-dev] [PATCH] f2fs: make file immutable even if releasing zero
 compression block
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

When we use F2FS_IOC_RELEASE_COMPRESS_BLOCKS ioctl, if we can't find
any compressed blocks in the file even with large file size, the
ioctl just ends up without changing the file's status as immutable.
It makes the user, who expects that the file is immutable when it
returns successfully, confused.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cc7f5670390f..8a422400e824 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3535,14 +3535,14 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		goto out;
 
-	if (!F2FS_I(inode)->i_compr_blocks)
-		goto out;
-
 	F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
 	f2fs_set_inode_flags(inode);
 	inode->i_ctime = current_time(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 
+	if (!F2FS_I(inode)->i_compr_blocks)
+		goto out;
+
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 
-- 
2.28.0.rc0.142.g3c755180ce-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
