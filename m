Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9590AC5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 02:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=igmGzsGU+SfzezHMPVnHbSt8M6pgRDik0+VOdlNxM98=; b=X5e6WCNAkOPW9Q9RBUtM0GE9L6
	MeBII2jlGqC91+p7zY0Lbc+rNlQDHuPhTAcE/cGQZEXzTPpu+YgyBU2KffN5Eu55BWdOc2LASCovn
	04mJFISd5fEDB5xIVVSokHp7hbhKTfWFMIZ0f1TDCq5Iy7TD0+tSEUYdfuOH3THSWjJY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvn4w-0006vS-RS;
	Mon, 17 Aug 2026 02:27:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1wvn4v-0006vL-Pn
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 02:27:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ul2vM3JfxSlWJCZNaogOWLN+q61AuBwPdjD6s+9mX7s=; b=BIQeu0TsgPaZABC2EoRpuJ3d4Y
 X5n5ztVy9Tqjfrq+DEQlGu9uYmdZwdJuNEcxQQqDs1DF+u2pStXgvV9JjP+FJhswEcc5hpH1wLOZL
 83yfdd0bFTc0uBSwerFMf916QEre6tpt2KNy1+uhvP3c5QbRIXnLvGm6w85KRWPdXFcI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ul2vM3JfxSlWJCZNaogOWLN+q61AuBwPdjD6s+9mX7s=; b=l
 s6GdFCVKKuqEiy3rspKiGWamrCBm/5BWT5n2qZoXUCEGGlLU9DTQ+TSoieYnQ+MSAZVIbZQmwyifo
 AkJ1wXGJxVlVibtrLJ7rOiDIgXw9x22KjafoRFJtKeDAKyPtl75UzO9DF0HtAjJixYdkI2WQI0yU7
 eK60lNzgw22QEHGo=;
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvn4y-0004FO-UR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 02:27:57 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-39266382df6so2247473a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 16 Aug 2026 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786933672; x=1787538472; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ul2vM3JfxSlWJCZNaogOWLN+q61AuBwPdjD6s+9mX7s=;
 b=J8PGaj0YLthcI/9Qijbk7S5HHuVrn1i0zD1QuvVNUhnGH5S4I4lD31i2TSaznXipTj
 Wc0o785TcHJqJUXLkSgFIkaA5tpcBy5Y8pQ56v0N6BT2cU3bMj1Ueck5uPiLlPpG65yj
 3j+/PM3XtGWAShXtH8JNcgljJLWPSEnEZYTj2LLZM9bTL3dErjKBUTwUWpIQyRmHbL1h
 qBY8jD9jB7e/XwoJCF4tsVfMxyJW54SxnaMmQwBhl7V6QOqX5f59xihTJri6Y6H77TrK
 tUIWo85MNF8xazfld8De3jiafw8pwVRKynSjaSBnYcYXPUPCEXT+x0GWp4J9tKeTEj5B
 cczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786933672; x=1787538472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ul2vM3JfxSlWJCZNaogOWLN+q61AuBwPdjD6s+9mX7s=;
 b=pcMZMast9xZ5HNLagg2Ts2mwg2J4AjHyYhDLOhn8ZkVqku1ur32JRt7Z+OkWtOVa+k
 Ac+EKgzro+bBHY9Pn6j0t3jTa9VDpYqC4napsGjMJK6fQFXG3JJY1/2EifYe7tDLBCWL
 r1oBkKo4TXnnPtIbcWDiXTaDqOwzvWV4T98+QMIeeWqJj+FqHOD1XVHwnogyjGKBZ9zu
 skYTcjNNLGvWeq11nAVSB0ENSGFJWY6hovfmstWWv9X7CIpcACKbu12/IOzyArxSvN/q
 cRPw6AEPBBXWyfmF8TdXQnF3TKDdvWTJmCFd2S9x/oDmnMlSJ7c7qFrrYHYtUk/dYGEj
 Gobg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQbYokLBy9Vgc6J5HfCMXDvyiFtSy9BqEmOH9KgvCHWHV5UEPUoBNv/zeEzPKRw+NH5fCyDvP6sGtMbUchDlL8@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwW6CylINCd1Acm7hVOe1tcW7s3zG26u+L6c0g6aBj557n2IEi9
 0I1NXVf9w34hTopKuLIX7iiIx7v/qPUfBJAnMNcLud2/VG8EelVIhAx8
X-Gm-Gg: AR+sD129uLYQyYw3UmoCwR6T+UlobqI07Y88PxpT54pujCSko5rlR1gT+mfZrJQKzba
 0iwJ/exiTUCPRbqj/dFNgzdiJOEm1ld/Z71j7/HCYPnsgXFbfKZNS9a72uvh54asDpGDUWd/xFT
 chbj5McomhXBq3GiFWmIYnC2HxzQ11m29UliQh9//HIXi5EwS/qCbG//r2nsyCczflT1ywpSji0
 BaUewBN3ldQWb792CWGbB+yZbi8QedKJYKv5jI8wcRZs+zGK58YWJKWExEvqV9MWg3VTI2sGUXd
 9QfZqNA33XZtprQGR3x+T8YrUzcAqSF4Zgazyj8BCFXeuYLib0oJXMYEdOirvCjI9yydAX1E6mm
 jk367WwmHyirgtIoIWI8ppuzNN2TnHPjBya5DBWZeuc7IATF2Q8x5PPNsL0uRTmlJxZE96+iMAY
 6JyBfHFYqMknCyuAqSvvRlKYcsRu19GzZj5Fv4wn3s9XNHTPg4FnklJFhD46vbJwIwxZt92dBgg
 OG5rFl8I6E=
X-Received: by 2002:a17:90b:1850:b0:37f:bfd6:8b40 with SMTP id
 98e67ed59e1d1-3933b751fecmr22700949a91.5.1786933671569; 
 Sun, 16 Aug 2026 19:27:51 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3954d2b8080sm324315a91.4.2026.08.16.19.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 19:27:51 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Sunmin Jeong <s_min.jeong@samsung.com>
Date: Mon, 17 Aug 2026 10:27:23 +0800
Message-ID: <20260817022723.3324123-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wvn4y-0004FO-UR
Subject: [f2fs-dev] [PATCH] f2fs: fix i_size when pinned fallocate partially
 fails
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
Cc: zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 Zhan Xusheng <zhanxusheng1024@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Commit 4275b59673eb ("f2fs: fix to round down start offset of fallocate
for pin file") moved the allocation loop's start down to a section
boundary, but the error path still converts @expanded against @pg_start,
which holds the unrounded start.

@pg_start exists for that conversion: commit 88f2cfc5fa90 ("f2fs: fix to
update last i_size if fallocate partially succeeds") added it as an
immutable base because map.m_lblk moves every round.  Each round now maps
exactly sec_blks blocks starting from rounddown(pg_start, sec_blks), so
pg_start + expanded overshoots the last allocated block by
pg_start % sec_blks, and a partial failure leaves i_size covering a tail
that was never allocated.  Nothing corrects that afterwards either, since
file_dont_truncate() has already cleared FADVISE_TRUNC_BIT.

Keep @pg_start pointing at where allocation actually begins.

Fixes: 4275b59673eb ("f2fs: fix to round down start offset of fallocate for pin file")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/f2fs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..cc0d2b8c4684 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1919,8 +1919,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 		block_t sec_len;
 
 		if (map.m_lblk % sec_blks) {
-			map.m_lblk = rounddown(map.m_lblk, sec_blks);
-			map.m_len = pg_end - map.m_lblk;
+			pg_start = rounddown(map.m_lblk, sec_blks);
+			map.m_lblk = pg_start;
+			map.m_len = pg_end - pg_start;
 			if (off_end)
 				map.m_len++;
 		}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
