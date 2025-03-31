Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BDEC369A4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVz-000479-Oq;
	Mon, 31 Mar 2025 20:13:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVn-0003vu-Lr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fFbg6vi3F3nfajynzNACp5nmDhK13wu/0bHzMfeLDiU=; b=KQETkBLJwlmC823dBKQ1qgR8B3
 4c/fc/TGMYjx9ENICTEcN3s9FwakUgXvS6YOIe4yPoaK3ib0O6VCuSqceCjiOVmPe2R9oxCgOhGmV
 nEwdvcAaV00xKwargahkC3Sj5NjJvn+ds87bYgZCRXmLju6/5//Kx5iCPeEzHCqDgnuA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fFbg6vi3F3nfajynzNACp5nmDhK13wu/0bHzMfeLDiU=; b=hkSqUIu6jpkESlF1KCi6vmenJN
 P8X8IjONhsevJrGbmL6920Kv252BtlQX8mAeBlBIEUTeqPusv/GSvztxhMxvs+KcdHmn4Ak+ebNTQ
 xCWe5QjfaN6Hyatk1FQuSPVTf7pwWWM4xbdwOWR6IY2botlXZvOmFZPeXg1Eo/mnkziA=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVi-0003ek-1t for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=fFbg6vi3F3nfajynzNACp5nmDhK13wu/0bHzMfeLDiU=; b=G5yzoeXxwroh1g+a5TRSFZzJJH
 bpLy7RAhYq36f/OBbcF1oZQTmRXokRY8uk8wRJBfN6Ao5FULAiV2ZPrN3ScicPjiwlUWA8y3ca0LO
 gA1qBh30F197uSv6FJCg9ksuo12yiH0gkGvYtB8uj4YwP7xzX/d2v65TpZKOKUxyzWhi+n1+meAco
 AWGPqyvAXA9fJc2a20H91yR3gBGXv7jx1tZgSCsiftyF8YN/sSb8BmqCFAAPlrzVDxAx6FJgUEMij
 O5Vl/uf5KW/mdL7vFRw6e3OqJzD4gN30/MS74ulJcHlMz0BlKinHqjjScmpipDosD9InhWgsa6Qtz
 T1n822Bg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVW-00000004SEz-341d;
 Mon, 31 Mar 2025 20:13:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:12:02 +0100
Message-ID: <20250331201256.1057782-103-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVi-0003ek-1t
Subject: [f2fs-dev] [PATCH 102/153] f2fs: Use a folio in
 f2fs_find_in_inline_dir()
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Remove two calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/inline.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 13ede6ccc312..8e175e5ee23f 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -358,28 +358,28 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct f2fs_dir_entry *de;
 	struct f2fs_dentry_ptr d;
-	struct page *ipage;
+	struct folio *ifolio;
 	void *inline_dentry;
 
-	ipage = f2fs_get_inode_page(sbi, dir->i_ino);
-	if (IS_ERR(ipage)) {
-		*res_page = ipage;
+	ifolio = f2fs_get_inode_folio(sbi, dir->i_ino);
+	if (IS_ERR(ifolio)) {
+		*res_page = &ifolio->page;
 		return NULL;
 	}
 
-	inline_dentry = inline_data_addr(dir, ipage);
+	inline_dentry = inline_data_addr(dir, &ifolio->page);
 
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
 	de = f2fs_find_target_dentry(&d, fname, NULL, use_hash);
-	unlock_page(ipage);
+	folio_unlock(ifolio);
 	if (IS_ERR(de)) {
 		*res_page = ERR_CAST(de);
 		de = NULL;
 	}
 	if (de)
-		*res_page = ipage;
+		*res_page = &ifolio->page;
 	else
-		f2fs_put_page(ipage, 0);
+		f2fs_folio_put(ifolio, false);
 
 	return de;
 }
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
