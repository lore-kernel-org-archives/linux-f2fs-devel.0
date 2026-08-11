Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FB8C5AC67
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hERWdJfsxI61B0O/KAY+aXa2BcbD8Li99DCyByN7hNw=; b=UFcCg97leYmW+ZH1sUANavUzuP
	LZO0zgI9S0tOkW2gWF80fnlHAdwBooFHYUF8Kgb1SztxDog3yZyE3/p6wvaXZj45Lgxe0QvZC7B+n
	VuRydUPHp7IkNO8KDH4oWGvSUwa1neMJ8um3l0AtMQwSCTITzN8FAf7DshSfbalhxL3Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtgjc-0003G6-ED;
	Tue, 11 Aug 2026 07:17:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wtgjG-0003Fe-M5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 07:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O/q3Bkj6uidYoR8ggnMA5gsRdg+prqQDEuz93hM3wU8=; b=N+tdjQIBiVMX751EkHeXhFdMgo
 dKxbsl1UtYii6B2QAzZLkvyDTrHtfRnCmSNhqsvejJWB9PvMr5wfGVVsQy2cpFGnS07nI209Cn33v
 zqJzk+KINapesLEFNPJmUgu6GaS/A6DraiFppImcM4v8b3hENH4JVOJbqvsY5h1h4C0c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O/q3Bkj6uidYoR8ggnMA5gsRdg+prqQDEuz93hM3wU8=; b=M
 VQOcHQQXYQ0H/HNYGaXdc68O6WZgqG1CVT1dBqlbKbMI8gumSuQvA/p6s+qH8RNQgoL49BiDdRYcu
 fgCdAqe/hUvdXIG5TtSjyzLzsngI7uyYg4Q0kMgoa/5AUtob5IK5hnNjxNVcM9f95fvKh0IksD7uE
 VftcNQqrPA0hdt/A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtgjC-000244-Qi for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 07:16:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B28C600DA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 07:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B761F000E9;
 Tue, 11 Aug 2026 07:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786432604;
 bh=O/q3Bkj6uidYoR8ggnMA5gsRdg+prqQDEuz93hM3wU8=;
 h=From:To:Cc:Subject:Date;
 b=GUw2WsVWOwvo68eY0s0AhJjf5w1AxrDCcyDVr+IUuK8CjmDyE4fiQER+n89dLOOb7
 EL1a6/ggNhYiJi9zIYppiGCNzC6dwc319n7rrhrNCUm1ilxPyzfkcZlOrdR99y4W3H
 AqYRMTN598B5BfCkKCCLk0+sSdlsfvMxuX3u554wIN51cedJ6gtENmhET5sfALsxCT
 vQ4u16PxjsVdte2THzWHxYBfwBYO/r3yY5SLt2I3DwRigdDDtLrvIGueipZJD5DS0M
 BXnzpRvu37z1FpOyDnraUVGoj7BHbNCnj7iT8g4UdyQZbyOQO2aUiJCetfvhDhzFP6
 Ziga2/pZefe/Q==
To: jaegeuk@kernel.org
Date: Tue, 11 Aug 2026 15:16:36 +0800
Message-ID: <20260811071637.4176024-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
X-Headers-End: 1wtgjC-000244-Qi
Subject: [f2fs-dev] [PATCH v5 1/2] f2fs: fix to off-by-one issue in
 f2fs_zero_post_eof_page()
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Otherwise, it will drop one more page after new_size which is not
necessary.

Cc: stable@kernel.org
Fixes: ba8dac350faf ("f2fs: fix to zero post-eof page")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v5:
- no changes
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 56529a82e027..9dbe509926b2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -50,7 +50,7 @@ static void f2fs_zero_post_eof_page(struct inode *inode,
 	if (lock)
 		filemap_invalidate_lock(inode->i_mapping);
 	/* zero or drop pages only in range of [old_size, new_size] */
-	truncate_inode_pages_range(inode->i_mapping, old_size, new_size);
+	truncate_inode_pages_range(inode->i_mapping, old_size, new_size - 1);
 	if (lock)
 		filemap_invalidate_unlock(inode->i_mapping);
 }
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
