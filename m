Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25D2C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Dec 2021 18:24:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mxCTv-0006ZI-C8; Tue, 14 Dec 2021 18:24:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1mxCTt-0006Z7-Ek
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Dec 2021 18:24:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V0GQu7oLZyD6peungdVIPvnwYe0jBhf1AL+btbv5rlA=; b=QpOIUaYYNwE502dXvHK5j+zhUY
 u8XXKBLtyqM66kwHkJgkk+uuK++B2KYTUdau/asyYo4pAnJSo50+LAcFYC+TTxLXB5uT4XTkXctb8
 ItMU8KJW3dWISadKzHLYuC0vvuCG/Zg1O2a6NPrKYT0ErwqXLESYf10pcMo6KyTwFG2o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V0GQu7oLZyD6peungdVIPvnwYe0jBhf1AL+btbv5rlA=; b=Q
 9DwlkY61zbrY2Cg72Qro4JKhvCWOM1W9wi6r7vVaqzozNx0IGein2lVF7uhEMSvGRn+NvN4EfDWov
 MvdNhHTxZHSPQzRG/NsT8EyBt+qk1Y9YkdTK5IiWrTM9dj3U6f0gB7iTStQqzjCUkChJPq4edzVaO
 fM2P5NTugJfrufwE=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mxCTr-00065f-7Y
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Dec 2021 18:24:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6392FB81C50
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Dec 2021 18:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CD7C34604;
 Tue, 14 Dec 2021 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639506278;
 bh=AmPX+a0hWSnCjAZZM9pCdd+GAXYEX32Uad3FqW5pKtw=;
 h=From:To:Cc:Subject:Date:From;
 b=DFX0mUq6xjhGyLCzZiE8ytesWpSrSHAOn6/lTDKUUx0jikGjXXx9v5/LqOuNR4jsL
 dv4NIjCpZSqKrTHvLQOM3GyrnNDPt5F2pGuJtG0IHdzKmatUmwYXBK7JapdyulVkbV
 gaH+tSRZ/h7/IW/BIpcevP0r4QyB/53A4hB16D3kqyFn3Jb26Lv8TV1jBS+5XCNHaw
 js1YWOQpjlXFDKa3kKJlKhdYl6jfFuGwGl01DxAh0pdyqxOBNhhJMEJPfLMTHxsknn
 mOJHJgA/1qFRwZdftW98uLXRbpYS1MXqifAKP0I5MrSLd+zZ8kTZSIS4cO277XE2O3
 4ATk/QLVLIFOw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 14 Dec 2021 10:24:34 -0800
Message-Id: <20211214182435.2595176-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
X-Headers-End: 1mxCTr-00065f-7Y
Subject: [f2fs-dev] [PATCH 1/2] f2fs: avoid down_write on nat_tree_lock
 during checkpoint
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let's cache nat entry if there's no lock contention only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 556fcd8457f3..b1bc7d76da3b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -430,6 +430,10 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *new, *e;
 
+	/* Let's mitigate lock contention of nat_tree_lock during checkpoint */
+	if (rwsem_is_locked(&sbi->cp_global_sem))
+		return;
+
 	new = __alloc_nat_entry(sbi, nid, false);
 	if (!new)
 		return;
-- 
2.34.1.173.g76aa8bc2d0-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
