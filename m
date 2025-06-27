Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77B7C7EE31
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Jun 2025 02:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8IkRJ4iBLE30BIEDgZrGLyWDuUf//k3b/ncWdt0Ao20=; b=F/ymoiXwt0ucvp9ZIFixbxE8X1
	BXaKGCnX6PL4w/TFZlflCilbeLrSm00gAtpQBouEq9a6DOedu+UClgehp4DdqyeSJ0ERQZaI+hC/m
	VbVKjpoE4hdrlvPjekP7Ku/punWR13jkLInJsgfdF9J2IZOsUyPN/YBZaO5qcrYfrdnc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uUyzQ-0005kw-7y;
	Fri, 27 Jun 2025 02:38:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uUyzO-0005kn-DK
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Jun 2025 02:38:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=04UyyxkQC8wqx3mtOffpg7KRYMq/hHJZ+isfRrmBOPI=; b=jO+7JT/7nn6VBwpDEiiXM0RuEe
 Wlb14aCMZRWGGllaH9Fhk/GS78wdDIrSjpqjOjlwCrIZk1a6FFIVkSgFBOsmK+GmX5YsiknKB6HcK
 snCit2BJOwfN0int+kzPJWlj2h2efWXDwr9NnN2s5doBliVHZmszThT5tKTqmokEXf30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=04UyyxkQC8wqx3mtOffpg7KRYMq/hHJZ+isfRrmBOPI=; b=Ety20BIBPrkTx8snohiFCT4U0x
 kim0ocrWsoTbKVE5M61bELBraEWF5ZMPKPqY7EweL6WZuAD++rLRKnU1U99fJg9sGZ+rrfzTdl7Z5
 rI2BUgjUgxP1zXLZjptvB0fgelcELc/DNtjDeGPwdMOSUYuK8xR1nw4eL8YuxCwCKFmA=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uUyzO-0007Gz-00 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Jun 2025 02:38:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 343CEA5214D;
 Fri, 27 Jun 2025 02:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE470C4CEEE;
 Fri, 27 Jun 2025 02:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750991922;
 bh=DzX/NhNydrE1FbXKlYOIdNNqYXACSw7i/Wy3/su2Q70=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bD1b19HP8i8N55wdi6AEbrP3k9D/ENSAj4fhJSfGgTNBq1amL7xXZKFfS3A8o/05X
 +F+3uEBzng1VHCFyIaiUPcYLpEHofiBrfssusXE0zwc1ktLtNNLVkihg35hx+larQV
 ogW8n5VPbxlhZFXl8uq5F5sQWAHzljb6OtLB7+xUX/xhzCZghPRWwoNkLNtbS3HYz2
 b+4nIqy8y2cBx/Td4+xO70lTo1MUJG2rFdLms/YAkbNYDBKc8FjRo4trw/kzme8/Cu
 f1cQi01oXp7ezdcYhz+LkfD3XQGJ8d5Oi4isLziM9qYgmHEBK/xS+qOQTam04Mg8SC
 kM8WTeKCX+nsQ==
To: jaegeuk@kernel.org
Date: Fri, 27 Jun 2025 10:38:18 +0800
Message-ID: <20250627023818.146534-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250627023818.146534-1-chao@kernel.org>
References: <20250627023818.146534-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1uUyzO-0007Gz-00
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to check upper boundary for
 gc_no_zoned_gc_percent
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch adds missing upper boundary check while setting
gc_no_zoned_gc_percent via sysfs.

Fixes: 9a481a1c16f4 ("f2fs: create gc_no_zoned_gc_percent and gc_boost_zoned_gc_percent")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index d74472d96026..bdef926b3377 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -628,6 +628,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_no_zoned_gc_percent")) {
+		if (t > 100)
+			return -EINVAL;
+		*ui = (unsigned int)t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "gc_boost_zoned_gc_percent")) {
 		if (t > 100)
 			return -EINVAL;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
