Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC0BC55174
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Day85o9n9Psa8ElAAY0vbDDSgaDZ+wdJH6Yhg10ku+w=; b=bo1lbiqzkRJtOV/2jQ6f/Ti9i8
	zafTlsSIXJj3q4kNXh+ANyuCmz786/e75Lp2FVOgF7vcnSsRClaIwGpha7xFZZVJHVKvAPIQot9lq
	KQX1KbwmCjwi7LL0VLeXeh7cBeaL/pNiUYS8x4unI7b/mx/9Dv3NztDsFk1Mu8ka+w4Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrakv-0007iq-Gp;
	Wed, 05 Aug 2026 12:29:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wraku-0007ie-Ai
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lWl2gpPpOoFF3WEPX5Hv0dwD+S5zhvnvdIZck7e0O4o=; b=GApW2hWzo/kpVHvBmXoAu7swnO
 mOpFrkf2Ldgmq3vEicK8938v70Gs9A23AOMGbMras5iIlPoE3lpWtrPO3nEvW5BVjfTBf+uKQ4UtL
 zjHAx1nJ39tYklJBPAS6VLTRvxEnh2HM9rwR0gZyaytYXGO3rj6vENX9AWQNJkyq7sFo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lWl2gpPpOoFF3WEPX5Hv0dwD+S5zhvnvdIZck7e0O4o=; b=Z
 4+KljdN7gGHvJz9zbx51J5TJ5LUrymmgZv3yGHXZt3D4p5bKRUROqn2F61TB5t/rgz49Zgn1XSCkX
 DRxRSE8+krwgebxGjOlaZ5brtrO23YUcvBXDv6q5p5HLNlp84LpbY3rRMtjURJfj8jeHl6uV8v27b
 bc4To0xHov4Gp4G0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wraky-00068F-7f for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:29:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 274A460A6A;
 Wed,  5 Aug 2026 12:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13A21F000E9;
 Wed,  5 Aug 2026 12:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785932990;
 bh=lWl2gpPpOoFF3WEPX5Hv0dwD+S5zhvnvdIZck7e0O4o=;
 h=From:To:Cc:Subject:Date;
 b=K3foTXhWAbslvEbRQodNr2qw2B1f3jBBDWJUGPCwVvsFaV5xyFFb5Na/QNQpL0b9z
 aJDANdiXz6KCKMjgJtEImb+fl97Jlg4038cMQMnAuA4r4abLmJYfxQQr0GBkU5YZvH
 iBuV0DJ5u/Pq0cOlGS1F0JCrbvEaZR0O2df7TtTB1F02BltlTsOobqeqOwbBqfgWew
 qDrn1HjooBxMvEc1WBOEYHZBRB5ywmSah/CSuYhajUp2rOOVOKVnJiW16Jzpnx9Q6D
 Qxqp/OaT3dHNcRfJtH1ptVUAF+Bd/d0pHJSO0AqADYeLiFZMa8ZykAZiTL5kyOxicQ
 0lLuxNtqrafzA==
To: jaegeuk@kernel.org
Date: Wed,  5 Aug 2026 12:29:47 +0000
Message-ID: <20260805122947.675205-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
MIME-Version: 1.0
X-Headers-End: 1wraky-00068F-7f
Subject: [f2fs-dev] [PATCH] f2fs: print error information in f2fs_put_super()
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
Cc: Chao Yu <chaseyu@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chaseyu@google.com>

So that we can how in which path we may missed to account the
reference correclty: normal path or error handling path.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6b55c30f0daa..76768bb7efcf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2080,7 +2080,8 @@ static void f2fs_put_super(struct super_block *sb)
 		if (!get_pages(sbi, i))
 			continue;
 		f2fs_err(sbi, "detect filesystem reference count leak during "
-			"umount, type: %d, count: %lld", i, get_pages(sbi, i));
+			"umount, type: %d, count: %lld, err: %d, cp_err: %d",
+			i, get_pages(sbi, i), err, f2fs_cp_error(sbi));
 		f2fs_bug_on(sbi, 1);
 	}
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
