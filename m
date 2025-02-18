Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06582C021B7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2025 05:52:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tkGWs-0004uB-6r;
	Tue, 18 Feb 2025 05:52:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tkGWo-0004tF-Mv
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mxcT87qzqMqEF0E5qIM4Iboa5YWipVr/RZOEFYdP3iw=; b=CcIDlhVVjFAjD/231ehzduPeFe
 C1FLnq81AaxnDXHyzKwpmP6j23qkvB09n0Z2yp2rab7mqSwpBX7SzztES+ckZigpAPklXhKApFkhV
 KMm7fUyWjVQpi/MYOSS5M7K01uXMfKn7BZqigjE1mI+Ku+/L64g/OIliP1nNl0jJ0Be4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mxcT87qzqMqEF0E5qIM4Iboa5YWipVr/RZOEFYdP3iw=; b=jw14PKq1Fj2qkXYgqNBTMap+EY
 qYLJgxb4IVnrbkA95oQSJ/gomyI8cN88cnIYcETwnE8hDn2ltiGTKabrMJ2xA3194rfB9PY+gp19G
 QmCwQF0AIFcviI6ffVVUQfBPrb+Ly/wsYnpySeSob7PWlyotJsHpLd2CO/p1e7JIe87w=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tkGWo-0007cB-Ix for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Feb 2025 05:52:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=mxcT87qzqMqEF0E5qIM4Iboa5YWipVr/RZOEFYdP3iw=; b=DZyrIhccJeGOJDnCE/gaJLJMWD
 if7gTSLmZYa//ywHTpcVaZB2YmZ89Fhz3VbFEouF+LGLEBRzP0ApRxWltndG2gfi0xMRvV5BBn6iy
 CDVIDBl4e0OJOVrcANv/VQ9owsyjR1P5jBauGX0q277lXZ8hbycxXgcU02sjgIz6nTP/7m+njcDTm
 exmn2qi7VV7R4iTovbZQiU99XuAtaXL4y8Vr1xKIvspqSscK4pxAvbgwxlRxS1TGevaFe3WCdpuJQ
 QrxF3DLnM7Rn6+aMJ9bERqapxfXOVyE4xB6tgJoA2b7D/yQwRioMOSlyub07NW5wjj+qTYm0TPHQj
 7rG/wC0w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tkGWd-00000002TsJ-04dY; Tue, 18 Feb 2025 05:52:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 18 Feb 2025 05:51:47 +0000
Message-ID: <20250218055203.591403-14-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tkGWo-0007cB-Ix
Subject: [f2fs-dev] [PATCH 13/27] f2fs: Use a folio in do_write_page()
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
Cc: linux-fsdevel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert fio->page to a folio then use it where folio APIs exist.
Removes a reference to page->mapping and a hidden call to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/segment.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a29da14c5f19..088b4ad81771 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3902,6 +3902,7 @@ static int log_type_to_seg_type(enum log_type type)
 
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
+	struct folio *folio = page_folio(fio->page);
 	enum log_type type = __get_segment_type(fio);
 	int seg_type = log_type_to_seg_type(type);
 	bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
@@ -3912,9 +3913,9 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 
 	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 			&fio->new_blkaddr, sum, type, fio)) {
-		if (fscrypt_inode_uses_fs_layer_crypto(fio->page->mapping->host))
+		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
 			fscrypt_finalize_bounce_page(&fio->encrypted_page);
-		end_page_writeback(fio->page);
+		folio_end_writeback(folio);
 		if (f2fs_in_warm_node_list(fio->sbi, fio->page))
 			f2fs_del_fsync_node_entry(fio->sbi, fio->page);
 		goto out;
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
