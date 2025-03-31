Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31455C369A5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLVn-0005i0-7O;
	Mon, 31 Mar 2025 20:13:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVc-0005az-Nv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WswJTGahjguprfnJcGyNP3rkD9EX3cx9XQY8hKSOTIM=; b=K9F/4UR9HzjrbcBFBtWXR0xKm7
 hCQpqF1u04k9bXTPuviKTxjzCYR6qwLxU2p8MjGc2i0yfkLMjHIvQ6jrxK9mOnbmzhtMZmcC+fL2r
 AeQIHLNDlPO1NnpjMdvFSyWEkrlYa/jbDSSwPUEEF9a413yVOftBEHK2BC0Q8CyobV1Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WswJTGahjguprfnJcGyNP3rkD9EX3cx9XQY8hKSOTIM=; b=MKBILy0j+APdNETs6UJmCZ8Y7U
 3v/qCfDeNdmtpTZUPrTvzYD6bhLOCmF1FNjBfKqcg9DfXrckxJpTKLUMlwCoDKClhtMnmsQiD4Tf9
 jVqdLgcDZxMmb3C8fSITmhogu8pod85PY62F/ufCxMZeGR6xMdqTirczz7R2efa87YZY=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVb-0003br-A0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=WswJTGahjguprfnJcGyNP3rkD9EX3cx9XQY8hKSOTIM=; b=imLrigisVjRyb1ITd7YbFfc1ii
 LPEjOSTaLFS4CANsAP/xFZk0djmsaoNRoEAqovp1fycZChCS3aw4YHuKnaCWAIDXNhbCxPpzJDzfh
 eCznoSzjDroVIdnVUBtQAVWX6nMqzb+kefv4TxBLdRa6lN5a2u7SeZzNhDNJ01grieyWAUdvofxO9
 E0EoUz4dvBy+hL6myyBnzYGsk7y95HI4R1ORXppDz1G1bDmauC6riAWrqvWyhfZoyO3SwMdBsOLys
 lC9hJ9TZdnGk91i8jF7Sj6t3JGCrsS/seoyy5i78ttegns7TfIpg3bDK1pH75eUg621tO0A/k5mZ9
 YgGguUSA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVP-00000004RtU-3rM2;
 Mon, 31 Mar 2025 20:13:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:11:30 +0100
Message-ID: <20250331201256.1057782-71-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVb-0003br-A0
Subject: [f2fs-dev] [PATCH 070/153] f2fs: Add f2fs_get_xnode_folio()
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

The folio equivalent of f2fs_get_xnode_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/node.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a32ac1ecb61c..8b5c81116653 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3732,6 +3732,7 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct page *f2fs_get_inode_page(struct f2fs_sb_info *sbi, pgoff_t ino);
+struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
 struct page *f2fs_get_xnode_page(struct f2fs_sb_info *sbi, pgoff_t xnid);
 struct page *f2fs_get_node_page_ra(struct page *parent, int start);
 int f2fs_move_node_page(struct page *node_page, int gc_type);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 225006e6ba32..3b73562c77f6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1555,6 +1555,11 @@ struct page *f2fs_get_inode_page(struct f2fs_sb_info *sbi, pgoff_t ino)
 	return &folio->page;
 }
 
+struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid)
+{
+	return __get_node_folio(sbi, xnid, NULL, 0, NODE_TYPE_XATTR);
+}
+
 struct page *f2fs_get_xnode_page(struct f2fs_sb_info *sbi, pgoff_t xnid)
 {
 	struct folio *folio = __get_node_folio(sbi, xnid, NULL, 0,
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
