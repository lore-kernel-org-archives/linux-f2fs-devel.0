Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A57E8536F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=35YIKZ7A4vglAQP26q22bFNlg5pSwcFJtq5iEDZj3CE=; b=ISXV7VV+JFR/AtYW6IMQSGpuVV
	7DgE6imO0mJG1+YgqNNk0dpFlxjLpkfz94WNAlYCr9tUOyi53tS7D7Afjo+lJba/77goh40uGENUI
	//eS99SeMz6ldket4Jd8FMTFWWOnZOr+SMa3UMJZYsZtfqFsTrajcB3GOT4iErate07s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w8fkT-0007jW-If;
	Fri, 03 Apr 2026 14:43:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w8fkQ-0007jO-Bm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Apr 2026 14:43:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AF4nYcla3VpIRuqQdqNpWrxZwQFtoeEwcSNMCzgIhlc=; b=CgK7Yh0Pms6/q7oVHB8D4Q/sMq
 12PRtW9MGsi4hXVtaw1xcDbPQoCPP6VtslTSrPaSujd3Jy8gaSt6mhJWufV3pnh6H6PTQi6zW4zW9
 MtdT/+EO0Yq7eBOgUguEBj9vxVnMik8y6+93woBokncc592Pa3NkcwhDZxYO0nltTBiM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AF4nYcla3VpIRuqQdqNpWrxZwQFtoeEwcSNMCzgIhlc=; b=Y
 6WuES8jhfaecxtdyfuflYNzpdb0KkfDORw/eOXeOrzjw+yelbrBFi3L87n1664ib/8T1gFzmqSWwF
 f55LVpStJQ7CLC2ndkaypC44WPUL7SDS3LVUehcGeAzlF4EsMOWBsEaVWAF40xo0zisF6T6TQokmq
 IZBcWMqJ6xrz1Fks=;
Received: from r3-18.sinamail.sina.com.cn ([202.108.3.18])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w8fkO-0001UY-A5 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Apr 2026 14:43:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1775227424; bh=AF4nYcla3VpIRuqQdqNpWrxZwQFtoeEwcSNMCzgIhlc=;
 h=From:Subject:Date:Message-ID;
 b=HIkqxWw+SCBYKGZT0A2ypa/tqziNwjz1Y8JLacBQ4mAdOsaa9WokbJuTlmvQRsD+q
 ANWhwp6AXlrfLkkiSej/xn0gCkUHPVXZVPccSPGlBAU5gOV/b52I58dTbpDE07wNE3
 02ncnbqXat/6IaoLyXQeezABL0s8XyoB8oiYprrg=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.32) with ESMTP
 id 69CFD21400004103; Fri, 3 Apr 2026 22:43:34 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 3632074456635
X-SMAIL-UIID: 1A2EBCEA659143209B1AED43C96B5EFB-20260403-224334-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri,  3 Apr 2026 22:40:17 +0800
Message-ID: <20260403144015.221811-3-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1w8fkO-0001UY-A5
Subject: [f2fs-dev] [PATCH] f2fs: fix node_cnt race between extent node
 destroy and writeback
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@vger.kernel.org,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

f2fs_destroy_extent_node() does not set FI_NO_EXTENT before clearing
extent nodes. When called from f2fs_drop_inode() with I_SYNC set,
concurrent kworker writeback can insert new extent nodes into the same
extent tree, racing with the destroy and triggering f2fs_bug_on() in
__destroy_extent_node(). The scenario is as follows:

drop inode                            writeback
 - iput
  - f2fs_drop_inode  // I_SYNC set
   - f2fs_destroy_extent_node
    - __destroy_extent_node
     - while (node_cnt) {
        write_lock(&et->lock)
        __free_extent_tree
        write_unlock(&et->lock)
                                       - __writeback_single_inode
                                        - f2fs_outplace_write_data
                                         - f2fs_update_read_extent_cache
                                          - __update_extent_tree_range
                                           // FI_NO_EXTENT not set,
                                           // insert new extent node
       } // node_cnt == 0, exit while
     - f2fs_bug_on(node_cnt)  // node_cnt > 0

Additionally, __update_extent_tree_range() only checks FI_NO_EXTENT for
EX_READ type, leaving EX_BLOCK_AGE updates completely unprotected.

This patch set FI_NO_EXTENT under et->lock in __destroy_extent_node(),
consistent with other callers (__update_extent_tree_range and
__drop_extent_tree) and check FI_NO_EXTENT for both EX_READ and
EX_BLOCK_AGE tree.

Fixes: 3fc5d5a182f6 ("f2fs: fix to shrink read extent node in batches")
Cc: stable@vger.kernel.org
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0ed84cc065a7..87169fd29d89 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -119,9 +119,10 @@ static bool __may_extent_tree(struct inode *inode, enum extent_type type)
 	if (!__init_may_extent_tree(inode, type))
 		return false;
 
+	if (is_inode_flag_set(inode, FI_NO_EXTENT))
+		return false;
+
 	if (type == EX_READ) {
-		if (is_inode_flag_set(inode, FI_NO_EXTENT))
-			return false;
 		if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
 				 !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
 			return false;
@@ -644,6 +645,8 @@ static unsigned int __destroy_extent_node(struct inode *inode,
 
 	while (atomic_read(&et->node_cnt)) {
 		write_lock(&et->lock);
+		if (!is_inode_flag_set(inode, FI_NO_EXTENT))
+			set_inode_flag(inode, FI_NO_EXTENT);
 		node_cnt += __free_extent_tree(sbi, et, nr_shrink);
 		write_unlock(&et->lock);
 	}
@@ -688,12 +691,12 @@ static void __update_extent_tree_range(struct inode *inode,
 
 	write_lock(&et->lock);
 
-	if (type == EX_READ) {
-		if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
-			write_unlock(&et->lock);
-			return;
-		}
+	if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
+		write_unlock(&et->lock);
+		return;
+	}
 
+	if (type == EX_READ) {
 		prev = et->largest;
 		dei.len = 0;
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
