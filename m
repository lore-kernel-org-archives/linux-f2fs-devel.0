Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17DECD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 20 Jun 2026 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-Id:MIME-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kY/OsWws/QZXvwwBHF6sgBeqRr6zBhHDynFwr8Oz5mw=; b=Rs6bQYtmZVlwBqlWC53FcnoBjp
	kNben+wuQ/2WBWsKVUpNR7DkT5I8TbI1fngEslfUGUrjST6rhdyqNmZ2ZQ7JC6m0EvtvbW7eEYMez
	yV2THK3WOXgNxSLxTx4FmFO9kB4l7YFh8XjjB0O+szHTL8osX+Ju74Xq55mfX0gpwGWk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1was5k-0005aO-T5;
	Sat, 20 Jun 2026 09:34:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <devnull+jiucheng.xu.amlogic.com@kernel.org>)
 id 1was5j-0005aH-5F for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 09:34:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Reply-To:Cc:To:Message-Id:Content-Transfer-Encoding
 :Content-Type:MIME-Version:Subject:Date:From:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sOumzY2LLyONrJc0LymfNf66ogEN7MKwZ2zqvflNqWg=; b=PMprElIaKa8SFKid/6w4IDvQwG
 9hmJDtm0bxnPt9ht9ejBQ7sCpMfjpzlr+Acqv4NcI66JNdUSZyRYHEB52HACgrfF5H8Wrj0raWrzv
 KHXK2W2lma8CFYhBdreYvPZ5K2nNKB+g02JtTnpL7hsDVT/AkPybui5ZePtP9xIgV4cc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Reply-To:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sOumzY2LLyONrJc0LymfNf66ogEN7MKwZ2zqvflNqWg=; b=my+NGXEBEfDKW4EDjsHw1z7/8Z
 MyOp53DEgVpsUraxtvCS8N0epO3fpBaFeObKsMaoii8GjHz53glkbViBs8PPV/8RKIlV889seEQZT
 Cqt/hUpBCp/Pla4gbKSF6RtyMfiPS/GeW5OsmuvId5+q33LeTCCU9LFXr6iGw1vwHhPU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1was5i-0007Xc-Tp for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 09:34:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BE8AE601E1;
 Sat, 20 Jun 2026 09:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69C0FC2BCB0;
 Sat, 20 Jun 2026 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781948048;
 bh=8+Kj4od/en0jCRi1eRM+TjoBTe2DN5iENFai63QL33E=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=ov+q6ee7dHN8LWCz8OFh5iBsp+epDRXHg/z3bHq3YH4gsXvFUKrtrdrjgnKcCY6ng
 AEJH8+U+r354+YiMiBoNG0mhm2G7EJFN7vDef71vzvPyxDv9kHh2whBRpDKqUCu/Di
 T9LfWjDg81rWj5zxko43P0O0zQeH3JJZu7UqLwN7xv711ze7CcMYLr9vMvoW7Sd5Yv
 3y3GWwBeW1hrh0kw3Mxrpi+YgM8GWH/C5zxJj/nTFxj9VazbH94RCS4RBN5hx+Xwfy
 wsHe+98is9B3Dyc1ThCo5ML0aJL8xvOuPG5QccSdsmLWS8xEJpAf01GL1KEYXfclND
 Ar+VuUhvZeBvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 582AECD98F2;
 Sat, 20 Jun 2026 09:34:08 +0000 (UTC)
Date: Sat, 20 Jun 2026 17:34:05 +0800
MIME-Version: 1.0
Message-Id: <20260620-origin-dev-v1-1-3b2e639e794c@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAIxeNmoC/x3MQQqAIBBA0avIrBMmA9GuEi1inGw2GgoRiHdPW
 r7F/w0qF+EKq2pQ+JEqOQ3MkwK6jhRZSxgGg8aiNahzkShJB3609xSIyC0OEUZwFz7l/Wfb3vs
 HUFYodlwAAAA=
X-Change-ID: 20260620-origin-dev-99cdccc83800
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781948046; l=1408;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=jxb8I4TnUJtPHsroLRoqXeQLJJ3g0yqJyXK0cin68SY=;
 b=0wXhatgMPTS5dc7I5i5bJ3pyFgVnevNTYeVkGK3tp06SbPEDSe6NQW8z+aZ1tlnOGmFYTQVkv
 ytHajwEBNytA88mid32RHSnx7pgiAshH3jae3kBJuL2MmyJGWKufa64
X-Developer-Key: i=jiucheng.xu@amlogic.com; a=ed25519;
 pk=Q18IjkdWCCuncSplyu+dYqIrm+n42glvoLFJTQqpb2o=
X-Endpoint-Received: by B4 Relay for jiucheng.xu@amlogic.com/20250821 with
 auth_id=498
X-Original-From: Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Headers-End: 1was5i-0007Xc-Tp
Subject: [f2fs-dev] [PATCH] f2fs: fix FG GC failure when file in victim is
 pinned
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
From: Jiucheng Xu via B4 Relay via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: jiucheng.xu@amlogic.com
Cc: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>,
 tuan.zhang@amlogic.com, linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Jiucheng Xu <jiucheng.xu@amlogic.com>

When continuous write operations occur in the system, BG GC fails to
work. This leads to large dirty_segments and small free_segments. If
fallocate() is performed on a pinned file with the allocated space
exceeding the free_segment, FG_GC reclamation fails.

The reason is that the file corresponding to the block in the victim is
pinned, causing gc_data_segment() to fail. Since the condition sec_freed
< gc_control->nr_free_secs isn't satisfied, GC stops, resulting in the
failure of f2fs_fallocate() allocation.

Setting gc_control->nr_free_secs = 1 make FG GC continue searching
for new victim.

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8acdd94272a0ced448e0ba21635d702cfec10682..3e49a73bbf3a184a314e97bff9509a66c27eac00 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1883,7 +1883,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 			.init_gc_type = FG_GC,
 			.should_migrate_blocks = false,
 			.err_gc_skipped = true,
-			.nr_free_secs = 0 };
+			.nr_free_secs = 1 };
 	pgoff_t pg_start, pg_end;
 	loff_t new_size;
 	loff_t off_end;

---
base-commit: b51f606aa323d553d786ed681a213f134dc688d6
change-id: 20260620-origin-dev-99cdccc83800

Best regards,
-- 
Jiucheng Xu <jiucheng.xu@amlogic.com>




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
