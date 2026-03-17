Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277CEFD874A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kLhkg2/44Mrz4xiPdDbcotT1n2ndvs3F9WUHz7glUZE=; b=X/oy5midd9G5AlgiSKDbVP1bPk
	rH5XazAknl3r96+4AAY3wUArmQXNvZlJhajlOJKSRRw8PKAbyFbB8C5xgaTaAZIqhdLNkioyKKtt8
	3t8c4v4XY7zOS5iLibg4WufeywDNV2lhBEVzOi/jftcmh2F/U3whVduU2cjlHz4WxWsU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2T2R-00015W-PN;
	Tue, 17 Mar 2026 11:56:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w2T2D-00015E-Jn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 11:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iDPxju2IDlrMZ6zS/g+ADdbdvFamsu8tRDlhwAWTmGg=; b=BNFh/622r+D04Dsf+RfToiCDZ9
 JjMuA2GnMk0hB7MiMGBIQ/swGyLsgEl16lMfw1nlhZIRZTWLmj/lp8YJs7gN/WWNGZb3NM1VFZf6T
 lkBztrrIszRx3Qrm+UWXzkpc7Lx0dX5FMnqCPVwJ4wYem4e6P64pndm7mq4JBSpb2a80=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iDPxju2IDlrMZ6zS/g+ADdbdvFamsu8tRDlhwAWTmGg=; b=IK9yGL3s7jUwX+b4OwG3oKgnKV
 kfXk6CO/NsNx1CEuITwOy46QtYnziVyS2gNzmVQCc4AHQ0GV1gyBG+1oKSoZGNW+AkjJ6zLKrB5tB
 /+rxKrQHqj2c5Q5r0YAQbOaGaHo3CVFQdJmwT5GvOnX5IJA53IH06h/WPQFhQOish6Zc=;
Received: from mail3-165.sinamail.sina.com.cn ([202.108.3.165])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w2T2C-0004Yz-9I for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 11:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773748588; bh=iDPxju2IDlrMZ6zS/g+ADdbdvFamsu8tRDlhwAWTmGg=;
 h=From:Subject:Date:Message-ID;
 b=Tmcu0J+WzA6QYC5VLmkCNMxRi8P10CebwiGgdqARTqiclgvcBJNwP2POKr2dWLBEd
 32o7rhFaG4ZDcZSMdjKJyG5t/fH6jxEjd9fo0u/it8R6EkGaOIDplsEjH4CGNEkDTK
 oYEDSiv7BJw+3VYRxgXstqHFRQ8U+Q40MrD8llUI=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.33) with ESMTP
 id 69B9415C00005203; Tue, 17 Mar 2026 19:56:14 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 5995746684948
X-SMAIL-UIID: 5D39B2DAFC2E4DE7AAF75FDD55F85AC9-20260317-195614-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 17 Mar 2026 19:56:01 +0800
Message-ID: <20260317115459.208306-8-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317115459.208306-2-monty_pavel@sina.com>
References: <20260317115459.208306-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.43.0
X-Headers-End: 1w2T2C-0004Yz-9I
Subject: [f2fs-dev] [PATCH v4 4/4] f2fs: fix inline data not being written
 to disk in writeback path
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When f2fs_fiemap() is called with `fileinfo->fi_flags` containing the
FIEMAP_FLAG_SYNC flag, it attempts to write data to disk before
retrieving file mappings via filemap_write_and_wait(). However, there is
an issue where the file does not get mapped as expected. The following
scenario can occur:

root@vm:/mnt/f2fs# dd if=/dev/zero of=data.3k bs=3k count=1
root@vm:/mnt/f2fs# xfs_io data.3k -c "fiemap -v 0 4096"
data.3k:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..5]:          0..5                 6 0x307

The root cause of this issue is that f2fs_write_single_data_page() only
calls f2fs_write_inline_data() to copy data from the data folio to the
inode folio, and it clears the dirty flag on the data folio. However, it
does not mark the data folio as writeback. When
__filemap_fdatawait_range() checks for folios with the writeback flag,
it returns early, causing f2fs_fiemap() to report that the file has no
mapping.

To fix this issue, the solution is to call
f2fs_write_single_node_folio() in f2fs_inline_data_fiemap() when
getting fiemap with FIEMAP_FLAG_SYNC flags. This patch ensures that the
inode folio is written back and the writeback process completes before
proceeding.

Fixes: 9ffe0fb5f3bb ("f2fs: handle inline data operations")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v4:
- Fix the missing return value check for f2fs_get_inode_folio().
v3:
- Call f2fs_write_single_node_folio() instead of f2fs_sync_node_pages()
v2:
- Call f2fs_sync_node_pages() in getting fiemap path rather than
writeback path.
---
 fs/f2fs/inline.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 86d2abbb40ff..62a8a1192a41 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -814,6 +814,15 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 		goto out;
 	}
 
+	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
+		err = f2fs_write_single_node_folio(ifolio, true, false, FS_NODE_IO);
+		if (err)
+			return err;
+		ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
+		if (IS_ERR(ifolio))
+			return PTR_ERR(ifolio);
+		f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+	}
 	ilen = min_t(size_t, MAX_INLINE_DATA(inode), i_size_read(inode));
 	if (start >= ilen)
 		goto out;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
