Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502B4CA6019
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqVMxzX+L1XU8cHN/C+v/dOg3Lf2+YxPYK3Yo1VcPSI=; b=ObjPHP0GCaH1HZlDKyIIxM5MgD
	CqriGw7j5Lbk4M8NKXmBNVFVm7zW6n8eZ0+OVeCV9iTRka0YnWns198TyunvBON/nXLfhnSI6TpS+
	ainNCEE0W/B/0ASzqzdnsP2drqbJFw8kP9IqxH3nsd4pwxMcy5v4CjMFxqGOl3BjLBKA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF8ga-0006H2-Jy;
	Fri, 09 Oct 2026 11:22:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF8gY-0006G7-VL
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 11:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O7Xi6h1I5Mb6FlicJ0w7Ua9QyL0wb103FvJh6JPXnG0=; b=YKKSyH7e7QglFSq/z9PedOrNgO
 HFvlPnY3loE1Pblhwskt3GLCypTTwSm4fZbNw5eZRSo75lVJ10+UfTPTJCiCxWKahmkP7q7I7Vn1Q
 wAPup4erPcz5VRg7mDUv+ZdLNyHzVv0iFivXYYpssUQmO8TtDGCAtYXUYMJuGBqANd6I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O7Xi6h1I5Mb6FlicJ0w7Ua9QyL0wb103FvJh6JPXnG0=; b=XP0bie3HbvTSf2Jt5vn9ULMELL
 mYxvnHCMUpiPS1OVaUNQcf3r3BD2MdgfPjaetsXDpV9rHIiHtncH1APYu0KK+v+jhJF02mdMR+X1m
 NS5P3NX8W5EV0XWgz0+GUzzOAzalQYDPWAZHsVL6ifj4bT/kP58NxZw+934lC8KWNEe0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF8gR-0005cS-SJ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 11:22:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90E7A43206;
 Fri,  9 Oct 2026 11:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A5C1F0089A;
 Fri,  9 Oct 2026 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791544954;
 bh=O7Xi6h1I5Mb6FlicJ0w7Ua9QyL0wb103FvJh6JPXnG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cZB2UcRisGi0IojFPdySQgrV+KJHWv4fRxJ6+jRuYzEt7Pj4pyMoxjjcHp6cjNijZ
 76dmfcEi2zg9G/CrgIslUcUbkrChYjvK3Ho7Zz9DvJNbHuHRKZ/yyK2RFEA0TqPNO6
 LDE69pnhH7SGgk+9SL9FDEqcdKbHmOY9DsNBTfA4VEvDEYbpUYy/CFmIEk9p37QySg
 eUmZv33JFAaiP8QEE/w4J3t/4zRV5NHE6efihViNL8Pp7FtzfcJSJOJqbKxoQAaZIM
 +fvnbAySD0fhiQf4LfcKaTk77eyE4LFhbTLZhFLZ7Rq+w63MfZFe2wSdaxXS0gs5Hj
 pE8VzlTbm7Uqg==
To: stable@vger.kernel.org
Date: Fri,  9 Oct 2026 11:22:20 +0000
Message-ID: <20261009112220.2276173-3-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009112220.2276173-1-chao@kernel.org>
References: <20261009112220.2276173-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xF8gR-0005cS-SJ
Subject: [f2fs-dev] [PATCH RESEND 6.12.y 3/3] f2fs: fix to reset all pinned
 status during fggc
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
Cc: Sasha Levin <sashal@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, stable@kernel.org
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
index 664260807072..6c831276d81d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2132,6 +2132,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
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
