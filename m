Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADBACA6019
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNuPVOThW/+/67qs7OH6T3lYKCLLuJhXvq4Rk8V/i4w=; b=M/ztXy8JcH7sKLAG8PMC3HcjU7
	SkXlvl5zEDenZJoF7E9g75ozd2NVsHUhyP9ULUy3ZzooNQoWrRszMcmWrOLeQVQw89NHPTZfwX16j
	MZNmVswK3SosSEq/g7lO6PjmEoAMxvG2h0fX6EhsaEhOuO3AK1u9RzM5yR+DxALKEm7w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF8JS-0002YH-I6;
	Fri, 09 Oct 2026 10:58:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF8JK-0002Y4-Hr
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:58:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vVjrHJKa7rDFUypv5UxZTfsmJ51mWGgTIxM/zhOP14I=; b=fHE2ZsTcUEoqp9O2XUAShLJIrT
 ukTfmTEfmx9vISzutSWGIt8yv8OIcK5WteoFK4Xyztg8EAaFwtHUwmLE5ekZkDfRKDJ1fFwlVxeDj
 2ejcbRYchaxymhVwlNijvgJiVbWj4xhMvVEA2gtmHj7mL4jk7mDEG9t2X8Gqg7JDH4Ck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vVjrHJKa7rDFUypv5UxZTfsmJ51mWGgTIxM/zhOP14I=; b=QI9dBJOe/JtDWwFZOiP/J5Luoq
 mjs50ABPA0++aKoLR3yoiSNTS3Blkhv5pf8lVX/QtVaAV5O74T1lUblTPeoF49oV4ufCvfsDw82gm
 epD8PXarPQTUaHyTHHi5R6CHDsR3B8oL6WQ48/p8HwrHSSLcFry5e7s1UUxAE6NNm+kM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF8JE-00054Y-4B for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:58:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB2134367F;
 Fri,  9 Oct 2026 10:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C781F00893;
 Fri,  9 Oct 2026 10:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791543514;
 bh=vVjrHJKa7rDFUypv5UxZTfsmJ51mWGgTIxM/zhOP14I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dO2NdwCOeZi1yEnhbWIPdtPQzS1HlV2O8Fl2BQ2hPaG3/48poDSfS8l3HoXxv788L
 qNmAJdhJc/ihA2re1GWQMlmQ9O0/0gc88JSr2YHjjtui1BX6cTdTZGs3U4c9pgI+Fx
 D1wVRU7tRw2Ac1k3EYHUMmRGcBXL0vv7Q+3CvXIzz9axO2K2fHj4VIdxD8orNSPO9/
 ueuOVqnU6v2oS9di/1yX+22lTuqX+sBYB2a5oJpYJI8xrud7KKLya1tehZ2GswfOkn
 2DOjiqX7KrOhD5tq6BvoL9CLk6L2jPlbz9TDFBvi29aEW3Zbo5GGXPCPl1HHD6jy5C
 dAnojplIgJZrg==
To: jaegeuk@kernel.org
Date: Fri,  9 Oct 2026 10:58:22 +0000
Message-ID: <20261009105822.1859709-3-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009105822.1859709-1-chao@kernel.org>
References: <20261009105822.1859709-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xF8JE-00054Y-4B
Subject: [f2fs-dev] [PATCH 6.6.y 3/3] f2fs: fix to reset all pinned status
 during fggc
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 ]

Otherwise, the pinned status may affect latter flow of fggc.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8a37461fc278..8a4395bfeff6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2064,6 +2064,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 						dry_run_sections == 0);
 		put_gc_inode(&gc_list);
 
+		/* reset all pinned status during fggc */
+		f2fs_unpin_all_sections(sbi, true);
+
 		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			err = -EAGAIN;
 			goto next;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
