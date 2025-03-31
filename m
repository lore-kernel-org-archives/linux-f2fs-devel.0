Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7692BC3601F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:14:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLWV-0006Cd-Mz;
	Mon, 31 Mar 2025 20:14:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVr-0005kn-Ka
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s30KGiItEE9dVhGu3NTo/00cB+JKGW3OHB1eQp6hXmY=; b=MUonKd2viroVh5gFj/tosprDjF
 98aQp9krZuMx8iFMoQmvfVKJndEuZJtHcTXMgj11eGZrBP6rbsSmT8xpQZiQ7YbPd7chgFbgiPftm
 gGKNsP5fH4zPvrIL8YB43Rfa031Y0IlIqew7xV1QcfG1hkZ4zyjRpwONuLh3Uf9KraD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s30KGiItEE9dVhGu3NTo/00cB+JKGW3OHB1eQp6hXmY=; b=cLc7BGg5yPUM4It3r3gIQ3uHTq
 A/ZQrpTPPaOtNLStFbBE0E5x5AaHoax9esm1CBPLzzHb8BX49X+ZVI+D9LHlyCLIHLlLWqFsi1p8g
 HxV7k+l8mYirDmpp+X6p1WwpBpY5Kcr3iWhHdC6C6BLZMkXPoaiqiMl9QKFb6PqfnG3Y=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVl-0003gW-BX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=s30KGiItEE9dVhGu3NTo/00cB+JKGW3OHB1eQp6hXmY=; b=kZ6Z4zhR+gv9NKyknhpzxf9VSx
 B2ZF/vrMdhr35wz7pcm95fuR5hv6KCQpYf3g5BBye2rxb7rT1WVU3PiBnIYzChrTQ15G9NlhSjvvG
 CZ01G+eXbmMQg7gEJzj737ybqwgj1aThNJypJrpTkc+HnPiU84AFcflq/b+GuYhbktazFmPNVXyL/
 HUwhYhe7qzG51HxZ+XfReGX0I74eKJCDRqhLAg7LWHVRLCR4OmxHogcCFN6LMRXTOk/xbDVpUERJe
 fnuI3LHyygnkxEeqxQDkiB6eUJTscC+4kX23qVFQW6coYQ7wU0AEAk/usq82Ojc/rzZ/uK+5cOnuM
 vYV6i7bg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVa-00000004STt-02NV;
 Mon, 31 Mar 2025 20:13:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:12:22 +0100
Message-ID: <20250331201256.1057782-123-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVl-0003gW-BX
Subject: [f2fs-dev] [PATCH 122/153] f2fs: Pass a folio to
 f2fs_has_enough_room()
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

The only caller already has a folio so pass it in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/dir.c    | 4 ++--
 fs/f2fs/f2fs.h   | 2 +-
 fs/f2fs/inline.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 5c02d55563e3..aa3c18a39cd7 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -621,14 +621,14 @@ int f2fs_room_for_filename(const void *bitmap, int slots, int max_slots)
 	goto next;
 }
 
-bool f2fs_has_enough_room(struct inode *dir, struct page *ipage,
+bool f2fs_has_enough_room(struct inode *dir, struct folio *ifolio,
 			  const struct f2fs_filename *fname)
 {
 	struct f2fs_dentry_ptr d;
 	unsigned int bit_pos;
 	int slots = GET_DENTRY_SLOTS(fname->disk_name.len);
 
-	make_dentry_ptr_inline(dir, &d, inline_data_addr(dir, ipage));
+	make_dentry_ptr_inline(dir, &d, inline_data_addr(dir, &ifolio->page));
 
 	bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2fc95b671b10..9f4a041b2d7e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3654,7 +3654,7 @@ ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
 			struct page **page);
 void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 			struct page *page, struct inode *inode);
-bool f2fs_has_enough_room(struct inode *dir, struct page *ipage,
+bool f2fs_has_enough_room(struct inode *dir, struct folio *ifolio,
 			  const struct f2fs_filename *fname);
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 			const struct fscrypt_str *name, f2fs_hash_t name_hash,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d27205a789af..919d30034fe0 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -615,7 +615,7 @@ int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry)
 		goto out_fname;
 	}
 
-	if (f2fs_has_enough_room(dir, &ifolio->page, &fname)) {
+	if (f2fs_has_enough_room(dir, ifolio, &fname)) {
 		f2fs_folio_put(ifolio, true);
 		goto out_fname;
 	}
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
