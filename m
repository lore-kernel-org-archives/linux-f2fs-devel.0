Return-Path: <SRS0=JMaF=5N=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE5C2D0EC
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 28 Mar 2020 08:40:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6511C20716
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 28 Mar 2020 08:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bmZp5YLt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="XDqYVDFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6511C20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jI70r-0005O2-OO; Sat, 28 Mar 2020 08:40:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jI70q-0005Nv-Ij
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Mar 2020 08:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qd3Z2aBouOAdI1z8bL68QeaTaCd7Z8GxR7DocnLcXV8=; b=bmZp5YLtqU042swyikGI6BkuVM
 GU3SXmoBb+7644GKTjhcTyytPBiT3mH5oRGyTFNYMIruSKIjVvhzjfxQibbKIJOtRTLPCh5tDBgIW
 Anvnb5sFWmceu+jSAt1cfNHcsco6j7HwnVKo5XDL+M1uSDUEv4362EyB1aAlKsWq6N2g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qd3Z2aBouOAdI1z8bL68QeaTaCd7Z8GxR7DocnLcXV8=; b=X
 DqYVDFDlbf2+PfPLYNGgzOykat6FFT6suz2oNl5RVxg+M5h23mDdGMVwzUgcR6QTbGuxWdtGTY1Bf
 U46+cgtj153QkkM6R42bZhLtPgWet7tc8HUmCzSDDsnKORPy4Eeu6EL8quFIotjX2YtUJbO7IAhj+
 aFmv31eOY/Fe4dh0=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jI70m-00BtgE-Pm
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Mar 2020 08:40:16 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 483F33832ECACFC86A19;
 Sat, 28 Mar 2020 16:40:02 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Mar 2020 16:39:54 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Sat, 28 Mar 2020 16:39:47 +0800
Message-ID: <20200328083947.125066-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jI70m-00BtgE-Pm
Subject: [f2fs-dev] [PATCH v2] f2fs: introduce f2fs_bmap_compress()
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

to support bmap() on compressed inode: if queried block locates in
non-compressed cluster, return its physical block address.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- give blkaddr on non-compressed cluster suggested by Jaegeuk.
 fs/f2fs/data.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 24643680489b..89b73ee74120 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3585,6 +3585,37 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	return 0;
 }
 
+
+static sector_t f2fs_bmap_compress(struct inode *inode, sector_t block)
+{
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	struct dnode_of_data dn;
+	sector_t start_idx, blknr = 0;
+	int ret;
+
+	start_idx = rounddown(block, F2FS_I(inode)->i_cluster_size);
+
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	ret = f2fs_get_dnode_of_data(&dn, start_idx, LOOKUP_NODE);
+	if (ret)
+		return 0;
+
+	if (dn.data_blkaddr != COMPRESS_ADDR) {
+		dn.ofs_in_node += block - start_idx;
+		blknr = f2fs_data_blkaddr(&dn);
+		if (!__is_valid_data_blkaddr(blknr))
+			blknr = 0;
+	}
+
+	f2fs_put_dnode(&dn);
+
+	return blknr;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+
 static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
@@ -3596,6 +3627,9 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		filemap_write_and_wait(mapping);
 
+	if (f2fs_compressed_file(inode))
+		return f2fs_bmap_compress(inode, block);
+
 	return generic_block_bmap(mapping, block, get_data_block_bmap);
 }
 
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
