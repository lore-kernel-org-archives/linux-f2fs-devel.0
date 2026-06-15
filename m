Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC59CD98C5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OAa0WV+aSTvd22X0KP/CoaAkWPNe222YVvRWgrw5bbU=; b=bAwDi3hyiAWZzLQlsr9tsr7IAH
	5ThbSBKBX2hxCxJl2tTyLM6wtAP83wkbu8jX6Fq0btVTAaxypb7PSDHfeq3uuowBO/h0blZHJO2MQ
	risxa5UMkQQhFrlupEuIhu+UB9eW1FPq/Ki1867bvuW2hzZ90+OrSLf4FoHu/Qjcq76M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ73V-0001zm-HM;
	Mon, 15 Jun 2026 13:08:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZ73U-0001zf-Qv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Er4ZRBSGadaxynvYX+j+Eaq3Kuq2vlR4CBo1bDHaFf0=; b=UN9y4i/jb3iQbTnPPi51d/Wtrj
 tQtmQQR8FCZ1ogkfM7bdTDn5Zfgpu0m7JjMfKTMZv2Jd1i4lqrLzhuQgh6/msmyuth5MT7Dy02QT2
 FWcMFSyYG7A0dSe3lh98wjet2bxL0oPbznhuIwQaMCwmoBXMWjBpzjS8v0arWZu/4yb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Er4ZRBSGadaxynvYX+j+Eaq3Kuq2vlR4CBo1bDHaFf0=; b=MOJ7/dsSNOw6qO/qc+hsCniS4/
 vpc64XHI8djEJRD4pS5Ud0+WgeElO+HR9YBJZxHrwA8ig0SII9O4AC8RYyN8oDGqYQIv+5qtWCcb6
 UP5sdAXWZ6SqSu9Ps3MfbfdGdvQyglDkAgHGtaB/4c2McNF3DKgKz7HBOEm3hmfgEF6U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ73Q-0005wF-BM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B6E1601E6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 13:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1931F00A3D;
 Mon, 15 Jun 2026 13:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781528914;
 bh=Er4ZRBSGadaxynvYX+j+Eaq3Kuq2vlR4CBo1bDHaFf0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y7hGr13SE1WIC9KM7M3RBd5TTyv7Q2juZT4L6St5Cs/jquRr3g2aL+n4bYNavS1sl
 IGd8Y3iYId9P1QRRjrkG9P3cj0Hqcg5Uzy0mA3Luw/vFRKXPDemGeXmHlivLAvPq6u
 IiDASs8JFDXNTt+a1PadYXUlKHb1K+ebwnGo4hc75BR3tX+UXSh04EH1z0cu5vnxyg
 V5zjebQ7wa1I9x432AfL3TkXp1+iSpDU3qLI/sf/TfQqJH1YdAjjunSXUCn71UonmN
 BHXomabidsFx6HEEmigEtjMRJdb7+WnLRtNRjlE5NsElJZcUp6OuDeP/wUb4GiAfE/
 nrmaVmYCYuQMw==
To: jaegeuk@kernel.org
Date: Mon, 15 Jun 2026 21:08:19 +0800
Message-ID: <20260615130822.2576088-3-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260615130822.2576088-1-chao@kernel.org>
References: <20260615130822.2576088-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wZ73Q-0005wF-BM
Subject: [f2fs-dev] [PATCH 3/6] f2fs: avoid unnecessary sanity check on
 ckpt_valid_blocks
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The calculation of sec->ckpt_valid_blocks are the same in both
set_ckpt_valid_blocks() and sanity_check_valid_blocks(), so it
doesn't necessary to call sanity_check_valid_blocks() right after
set_ckpt_valid_blocks().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1ef4edb77078..f9c688d270e6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4802,10 +4802,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			}
 
 			/* update ckpt_valid_block */
-			if (__is_large_section(sbi)) {
+			if (__is_large_section(sbi))
 				set_ckpt_valid_blocks(sbi, segno);
-				sanity_check_valid_blocks(sbi, segno);
-			}
 
 			__clear_bit(segno, bitmap);
 			sit_i->dirty_sentries--;
@@ -5133,10 +5131,8 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 	if (__is_large_section(sbi)) {
 		unsigned int segno;
 
-		for (segno = 0; segno < MAIN_SEGS(sbi); segno += SEGS_PER_SEC(sbi)) {
+		for (segno = 0; segno < MAIN_SEGS(sbi); segno += SEGS_PER_SEC(sbi))
 			set_ckpt_valid_blocks(sbi, segno);
-			sanity_check_valid_blocks(sbi, segno);
-		}
 	}
 
 	if (err)
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
