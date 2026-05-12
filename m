Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8357CD4851
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 05:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IAGCbzSNyThDvMhc7M/EMYBZ0zcoE8iQdzryerebv88=; b=ERAOEjP/LQ1GdORggF6zHjP/mm
	2XE9X75jW5nHCLWRIO7eXz7zj9CGLfQl0RiQIb32ZVzUHa4P/qJ0DRLaUSbKIj5L/CdZdEikIQZiQ
	Zi06TaAGVNV7rQbSPNn6ww4W0Z9dT1sG7N5CO7BGkI0EMakxG0B8uQiL2dWjr+aSZb0c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMfov-0002up-LT;
	Tue, 12 May 2026 05:38:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wMfoj-0002tB-Bm for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:38:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M9+U2qOebilkGiCBYkyQkIQiqg6xsbq5mzyvOEMl2d0=; b=S95dKrmSbfvRGADu9cOyDsuU0w
 auXTXA5ZNQal37JvhidKQj1J57l5GGHX1AB/XhMd2WQVKIc+gNlQzFuipNykWbBWs5KETXwYJ8Fjd
 b6c7w1vhHkPFxrBod1UfdNNScxccKKU89OShw82ukEO1zbUsxLs8DftZfhWF/BzjYIk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M9+U2qOebilkGiCBYkyQkIQiqg6xsbq5mzyvOEMl2d0=; b=i14ypk6C5vsLLcIJUmkSpsA28q
 fEjzWfw4uCRTHvuaq5RoGmoust3CptvWXEk0Sozudrg+EIwCgyYfom0Xl2DBBPqnwTky1F8UE42pf
 +IGXAauIGhGVrR6hlNKGNfVTmOsoD++WMTxMkaAIkBsDzFmbKPDgD/Ji6HF0En2/bC6A=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMfog-0004rt-29 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:38:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=M9+U2qOebilkGiCBYkyQkIQiqg6xsbq5mzyvOEMl2d0=; b=Ge+4D1DW2pmkX62K/Bv0iADaDG
 D9R7VZelwjKVRFhBQMh+fdN1xy3bTuTe0Q/vildGqQgQLb2afEaPyK1v8EjHjl8TnlRLR/yk3EOY3
 CpVRLT1IjABfASeE4xKUXId4njNbkiTLXbvLgvpTV9DskB9fVGLdpCqTkGu0rwCamvFqNjPrjYQlk
 YbHGYfjRwa7iH7D+9ACskU7jjidW0jq5xkwsjL3UJn+LvYQDv+evewZXQlDFu8MBYFt9cGvlHes4X
 x8utjRA/kzC2L5QS64m/B+xrrdAcsM9s1jEftrIQO9KN4bMqlXv1c7GOwxY0yHbsBHC6xopqolwXm
 jLuSKVEw==;
Received: from
 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wMfoT-0000000FfTW-0JM3; Tue, 12 May 2026 05:37:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
Date: Tue, 12 May 2026 07:35:26 +0200
Message-ID: <20260512053625.2950900-11-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wMfog-0004rt-29
Subject: [f2fs-dev] [PATCH 10/12] swap: add a swap_activate_fs_ops helper
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
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong " <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add a helper abstracting away the low-level details of enabling
fs_ops-based swapping.  This prepares for taking swap_info_struct
private.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/file.c        | 4 +---
 fs/smb/client/file.c | 3 +--
 include/linux/swap.h | 5 +++++
 mm/swapfile.c        | 7 +++++++
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 10ab2a923835..ce4d860c4e7a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -588,7 +588,7 @@ int nfs_swap_activate(struct file *file, struct swap_info_struct *sis)
 	ret = rpc_clnt_swap_activate(clnt);
 	if (ret)
 		return ret;
-	ret = add_swap_extent(sis, sis->max, NULL, 0);
+	ret = swap_activate_fs_ops(sis);
 	if (ret < 0) {
 		rpc_clnt_swap_deactivate(clnt);
 		return ret;
@@ -596,8 +596,6 @@ int nfs_swap_activate(struct file *file, struct swap_info_struct *sis)
 
 	if (cl->rpc_ops->enable_swap)
 		cl->rpc_ops->enable_swap(inode);
-
-	sis->flags |= SWP_FS_OPS;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_swap_activate);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index e1bbc65ce7f3..e11065be1e64 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3326,8 +3326,7 @@ int cifs_swap_activate(struct file *swap_file, struct swap_info_struct *sis)
 	 * from reading or writing the file
 	 */
 
-	sis->flags |= SWP_FS_OPS;
-	return add_swap_extent(sis, sis->max, NULL, 0);
+	return swap_activate_fs_ops(sis);
 }
 
 void cifs_swap_deactivate(struct file *file)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index b1cbb67ddd8e..916889738f08 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -406,6 +406,7 @@ extern void __meminit kswapd_stop(int nid);
 int add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
 		struct block_device *bdev, sector_t start_block);
 int generic_swap_activate(struct file *swap_file, struct swap_info_struct *sis);
+int swap_activate_fs_ops(struct swap_info_struct *sis);
 
 static inline unsigned long total_swapcache_pages(void)
 {
@@ -532,6 +533,10 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 {
 	return -EINVAL;
 }
+static inline int swap_activate_fs_ops(struct swap_info_struct *sis)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_SWAP */
 #ifdef CONFIG_MEMCG
 static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2c9d2af736c4..26852c2ad36e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2757,6 +2757,13 @@ add_swap_extent(struct swap_info_struct *sis, unsigned long nr_pages,
 }
 EXPORT_SYMBOL_GPL(add_swap_extent);
 
+int swap_activate_fs_ops(struct swap_info_struct *sis)
+{
+	sis->flags |= SWP_FS_OPS;
+	return add_swap_extent(sis, sis->max, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(swap_activate_fs_ops);
+
 /*
  * A `swap extent' is a simple thing which maps a contiguous range of pages
  * onto a contiguous range of disk blocks.  A rbtree of swap extents is
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
