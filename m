Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E250AE83065
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wo9aMh69l2wwVdj4931Z61Hw7ifXkw0dQsViI03Td3M=; b=l8K310JXM0XiLjyKeWm0IbgwjA
	0H6hxn4JYay9FZR1sgmPXyAm/tHFwtD1v9nmW1VpOzLJy9POmMUNO+A/uwiPrPN3aR8ECSvGNq/Jz
	cUp0hBV3v6leXWqOtnENy2Fl3FRNhQ5rDJQSqhs4vKxyMNgyBrhU1upMW9cS+JshPSLs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vnCTW-0002QO-QT;
	Tue, 03 Feb 2026 09:13:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vnCTU-0002QH-Kj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 09:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U5IAZOiZv36aqaRxt4HG5BNNYkjGILnO18MppaP6+40=; b=eS3S7tY/HOECvKu8GJBdIgSHu2
 5VLgP3vFpkyGvZIqrE4g29EEJAUXQv4Cav+uoaB8lI/bIOj2/BX48XiDa01EY8/MAi4fx8eayb5D9
 gSKM85gRRu9N/W3vwHEl/bEb+kwXwMZxCVq65gGRv+gDv+F5Yg36AyUzA5U1O6VqwYMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U5IAZOiZv36aqaRxt4HG5BNNYkjGILnO18MppaP6+40=; b=MzjyT5hu++9SpK94b83DrA0Vkw
 pXqxJU19XJ6Vt5o+fGkFC7KO8C48Mto/uEDAQHniuFfwgh/41Bjgb+sqQaF22nLhKH5vscqnp2kLG
 lWjHYHSxKgBUgtqK6XrOYI4H7uE68XJcdqTVXO12jXDNJsmJF/6NPwXvAx5HKF4Zi6xY=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vnCTT-0004W2-Qk for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 09:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=U5
 IAZOiZv36aqaRxt4HG5BNNYkjGILnO18MppaP6+40=; b=TlFvv7PrUPeiy0w+e4
 5/ADLDDCL6swhMKZ364FLs4rlekHtzky8WFLT/HpXw09v4sHUyVmW8qYpDpXlGoM
 lXVOi0d1gj2PiUzOQo0IiFZB24vc1s3zz9VDZvaB1fZDLS27DVw4gERw32EsDEBj
 G9b2Qtuc69p4hgOsdCXuhN5Hs=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3l2kivIFpOegGAA--.25117S4; 
 Tue, 03 Feb 2026 17:13:14 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  3 Feb 2026 17:12:49 +0800
Message-Id: <20260203091256.854842-3-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203091256.854842-1-nzzhao@126.com>
References: <20260203091256.854842-1-nzzhao@126.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3l2kivIFpOegGAA--.25117S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryfZF13ury7AF1rtFWrXwb_yoW8Ar1rpF
 ZrG3WrGr4DuFy8Wrn7tF15Zr1Y9a4xKw4UZFZ7Xw4kJ3WDX34Syr1rK347ZF18trWrJryI
 qF4IkFyxur15JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRy7KsUUUUU=
X-Originating-IP: [58.240.165.118]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQrzw2mBvCqXRQAA3n
X-Headers-End: 1vnCTT-0004W2-Qk
Subject: [f2fs-dev] [RFC PATCH v1 2/5] f2fs: Introduce
 f2fs_inode_may_use_large_folio
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
Cc: Nanzhe Zhao <nzzhao@126.com>, Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Introudce a helper function to check whether an inode may use
large folio for scalability.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/f2fs.h  | 16 ++++++++++++++++
 fs/f2fs/inode.c |  3 +--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bdcd446f6b18..e5b8f5374666 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5035,6 +5035,22 @@ static inline bool f2fs_quota_file(struct f2fs_sb_info *sbi, nid_t ino)
 	return false;
 }
 
+static inline bool f2fs_inode_may_use_large_folio(struct inode *inode)
+{
+	if (f2fs_has_inline_data(inode))
+		return false;
+
+	if (f2fs_compressed_file(inode))
+		return false;
+
+	if (f2fs_is_atomic_file(inode))
+		return false;
+
+	if (f2fs_quota_file(F2FS_I_SB(inode), inode->i_ino))
+		return false;
+	return true;
+}
+
 static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b8cf1fab6391..e2e85ac9c44e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -620,8 +620,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &f2fs_file_inode_operations;
 		inode->i_fop = &f2fs_file_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
-		if (IS_IMMUTABLE(inode) && !f2fs_compressed_file(inode) &&
-		    !f2fs_quota_file(sbi, inode->i_ino))
+		if (f2fs_inode_may_use_large_folio(inode))
 			mapping_set_folio_min_order(inode->i_mapping, 0);
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &f2fs_dir_inode_operations;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
