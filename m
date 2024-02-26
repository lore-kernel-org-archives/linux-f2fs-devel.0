Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC28C47DD9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Feb 2024 03:19:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1reRWi-0004Eb-Hs;
	Mon, 26 Feb 2024 03:19:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1reRWh-0004EM-7y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 03:19:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GmO6fwtPPRc5uVcx4Jw3SiECTlbLWxfjY4BXirgPdhg=; b=PjQMhT0rXiXZ0oxL08tBhyN8ws
 2YBPlxfyh2L6k7VWv5OIkl1nSujv77Fzyx2PSBdCmV26VYzjwtnlrMZy1DkSLG5YYtqkkjYHukZ8H
 74m7xMRMnb/PvFzkP/pFXpfBJy8qD0X8csrewUDk1bl65Cg1BOUjvam3gPq6LuwCogUs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GmO6fwtPPRc5uVcx4Jw3SiECTlbLWxfjY4BXirgPdhg=; b=A
 OZn2TLmRfab2aid+5fD19OtiwA2zYkKkVXQhl7i7oOscdcrZpHbVX8Ii6r+xc9bykKs1SG5SMet0q
 ojgwRgZKcF/Oz1L4xqGG35Vvwe7tppn5Bq18gf9jLhpKw1tnDOoKyCkzEvqDM22HllRpSDR1f1Xr+
 v27w0hmGy2MKgLJ0=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1reRWh-0003PS-0c for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 03:19:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 24344CE0E69
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Feb 2024 03:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7B5C433F1;
 Mon, 26 Feb 2024 03:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708917562;
 bh=Sz0jqU0v0tnHzoX+q1gyX1BWNEr6Uw1vZ878UbaRw+A=;
 h=From:To:Cc:Subject:Date:From;
 b=nkdIayy8WuuXHCfivhW41LDvhKRAvve89Ehr0XoCveRNsV4v4Kelo/ZpsOlV/Eg+r
 PxoMAuAfgTgOaNX2ibsqQyn0Qz6pgcjNxO3ScsvOQzXVFcUhTMpVV31pG2GelcA8RO
 wANUevdAV3n5yqwv0PiSMc7qA90+P265iqNOWlxyXIqonAGCoCcF96MIjgzndLcZ4d
 IO5+xAcdzr7BWd+M0c91iM7LAh0HMaYWwpN2q5g1VFBYc9D8l1KyDHXlmOB+0EMI60
 pBGfV+D0Bt4GZiqpJbXHeKqgh//InS4JpPxDQusj6OaMacfBQgVYkasLDzpXiHq8nF
 Zv8nuxqfAbijg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 26 Feb 2024 11:19:16 +0800
Message-Id: <20240226031916.2420870-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1reRWh-0003PS-0c
Subject: [f2fs-dev] [PATCH] f2fs: fix to check return value in
 f2fs_insert_range()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_insert_range(), it missed to check return value of
filemap_write_and_wait_range(), fix it.

Meanwhile, just return error number once __exchange_data_block()
fails.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6ddc2092842b..0a80fdf0cdb8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1679,10 +1679,12 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	}
 	filemap_invalidate_unlock(mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	if (ret)
+		return ret;
 
 	/* write out all moved pages, if possible */
 	filemap_invalidate_lock(mapping);
-	filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
 	truncate_pagecache(inode, offset);
 	filemap_invalidate_unlock(mapping);
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
