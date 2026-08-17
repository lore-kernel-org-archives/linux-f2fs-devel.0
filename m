Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016F3C5DF66
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 02:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w2lYaFopwqtJc5RYUoAeykhI5SAe2sw8pplJKfmlFNo=; b=ZA1ZXctZhCO4rY426o1WAeTZih
	Woni+WgPITGBH3Nn5dxmJyPI5iFkRQwKEtT75B6E+TBaJy//BiaBRiYsBmNGWrfbQy0B2LbGt1AwQ
	n9uiyV2xWPo/tdu2sdompeUkxJziYdqnreJA5pCuozHSntFmWhoqgkaWxIDmI1eIyYPo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvnGK-00087M-0x;
	Mon, 17 Aug 2026 02:39:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wvnGJ-00087G-CO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 02:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Zauh1kTmy8nBz2EB4DNBM9Fk2fcwR8IRcats4T5Q2I=; b=RdzGMkj361gq7DgEVEIcIj3r8+
 HJ6d7vAc5Y/5Fk843tqBdlWk/mXQhCQ574yVYvAzhPT4+s05NV1IN1wdDS4r1gFaQ0cLRC/jVplGd
 PcBt/D/BS3X99ufINO9XAqgyZ2kYYBfVFkucVSmRPvSFD6O4Y41poLRNadhyBY6Gtd6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5Zauh1kTmy8nBz2EB4DNBM9Fk2fcwR8IRcats4T5Q2I=; b=J
 rQ/0M/XpVmjS+5CQGpSzUPV0tACjQOKGP9XWCJ45J1JDfqqOoIWSh40W1MEVHLTRZ0k8LAGy/sy3I
 CkE2TgfNZ6S9NOn3FB9v/yajOXx7VyvMtV5mARs3IJ696fF9v9T/32Z/QofyeqwwejySPKcoHAy4v
 l18cRJaI3y1prnZY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvnGK-0004XM-2R for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 02:39:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 249CE43457;
 Mon, 17 Aug 2026 02:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152731F000E9;
 Mon, 17 Aug 2026 02:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786934375;
 bh=5Zauh1kTmy8nBz2EB4DNBM9Fk2fcwR8IRcats4T5Q2I=;
 h=From:To:Cc:Subject:Date;
 b=jeuGEjdwFT5l0+v1EgK4obxRgS/XwXLe2xzQkRvvB5HnMSgXahgn9ujxrPsDIyGUu
 +3mUw8AmohQ5ukt0t2OcRwRwCnUL6xEKzCHxovAtmOwpXHZCM+e7d/K473TeX6Au6D
 EHA4v7sXNoXHCP3tUzbabbnx66iwrB25TQcBwsbs1GPk7/vE/A9Ju85QVF0QegsMPl
 2jDzh3TmF9UxBsTo3NbaIuCznkMI3CsG3SrT0Jkn6hwJ9DrNZ63A2iC33LydCc9DTw
 2qg9NVT79TWR33gf+y4igjFDvJIPrOTWyfWa0g4MY6EYA3tiir0V8gWwFEDoRRGA37
 XEyzGEGwbibsQ==
To: jaegeuk@kernel.org
Date: Mon, 17 Aug 2026 02:39:27 +0000
Message-ID: <20260817023927.1066935-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
X-Headers-End: 1wvnGK-0004XM-2R
Subject: [f2fs-dev] [PATCH] f2fs: fix to reset all pinned status during fggc
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

Otherwise, the pinned status may affect latter flow of fggc.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c4da2f31805b..c5715a237187 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2183,6 +2183,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
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
