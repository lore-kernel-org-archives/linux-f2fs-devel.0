Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10940C77B62
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 14:55:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pji47-00022w-6j;
	Tue, 04 Apr 2023 14:55:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1pji46-00022m-J3
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 14:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WlIQw7/j0g439cxIh8Bf75rzXhQHTIStlmhsPCq2zc8=; b=QUgoKQSyyeh+qJn4ypOSniuoGm
 eY30RSdlHg+sB1vK+UB7JRRTj7lnYunfaHS5FqrSUMMC5Oe5eXvs8a+Gcv5qLA+hOm8zg6g1ksp+D
 /PBdDRtDL2YPKmw/nOTkO6aHFCwylhTjWFlQRMi/YLqUelf1tbvrmCACRF9a1gkO17so=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WlIQw7/j0g439cxIh8Bf75rzXhQHTIStlmhsPCq2zc8=; b=IpZuSrzaZsbmyrRCPLb4pC7P+i
 cNnp+SlV99K0ydgJPjIV+7BI4nw9KLO5/qX6ru3W3YT1oGzNkP80mAtG6ojw3txeGspuPi3IcAnN7
 HswPlBshYhJEBZpnsBZzQSRRfQZd/UprdEzZYeVMm73s1JXADiGRAuaDSbtcjHLiy99Y=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pji44-00024G-VM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 14:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680620110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlIQw7/j0g439cxIh8Bf75rzXhQHTIStlmhsPCq2zc8=;
 b=Y3kWBAeCBYmXLA9IPNjyoG3USBm/aS7KuqCb71tAFJHuvATQZ7LBuXkHwPIXo9qt1Pp6U3
 0AWXpuoecJjz5UGTEcPleHCPgNtfdSXpuLbrVi0g9pCJMDCk220/nbjiJkilG7dXTXd3pv
 CA9hBePlYTbSHwBnfaQRDZ1m5eAcOxc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-439DAkh2Ne2sRlD26XF7eQ-1; Tue, 04 Apr 2023 10:55:09 -0400
X-MC-Unique: 439DAkh2Ne2sRlD26XF7eQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 h7-20020a0cd807000000b005dd254e7babso14675658qvj.14
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Apr 2023 07:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680620106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlIQw7/j0g439cxIh8Bf75rzXhQHTIStlmhsPCq2zc8=;
 b=CH/geM4Co2oFbfZBAZMVmGYhN1bjcsUTFroKC1mX9C/Ux9oLHi1RqOp89rJ3NfecqI
 /cHH3UBydGGhsV2QEVZafE5lwnK0HTxKMTBrjeU+KlH1lk+QzreY702/cPyXML9yAi3D
 QXIY6+GMI2vvaPqldBtzXgoQNHWt052MGMialEkoZd6DkbxmTvPk6kCKx65GGv7TuxZP
 5MKRYt5FiFupkPWS4Xx/1IFGXcqBYAhVVJYImtFawAiXc3eYtwJnxekgvHqRX9t64VIp
 rBJjFgNgIGybzLLY1jVbIxDbEknO+pMYbAdzhxxiwX5yWWfCs1wGy78k0SVxWkAMSzHt
 O1YQ==
X-Gm-Message-State: AAQBX9fSiFig4Wc2Z85ZMpV3UvRUK0VPfBMV11VFu97kZ1VbJnHbgoIw
 WlK00kz8NO9c/tsQySb8+tdDxW3C/91HR/ydika/rqNXYiqMixo2mzrKqOqga7MF0Qfxt9ymB8l
 aICcEx9rUhzpR6A536GHLA+auUv9UfnK5hjUD
X-Received: by 2002:ac8:7c49:0:b0:3e4:db72:2fe9 with SMTP id
 o9-20020ac87c49000000b003e4db722fe9mr3470324qtv.36.1680620106389; 
 Tue, 04 Apr 2023 07:55:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZkIqkTYw/ppN5CuEt6hgDbTeahRxMEc8GNEiOIjYIzOXDUEk9J53kAIKMBFKs3QN5nxJK1Ew==
X-Received: by 2002:ac8:7c49:0:b0:3e4:db72:2fe9 with SMTP id
 o9-20020ac87c49000000b003e4db722fe9mr3470285qtv.36.1680620106020; 
 Tue, 04 Apr 2023 07:55:06 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
 by smtp.gmail.com with ESMTPSA id
 j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 07:55:05 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
 hch@infradead.org, linux-xfs@vger.kernel.org, fsverity@lists.linux.dev
Date: Tue,  4 Apr 2023 16:53:03 +0200
Message-Id: <20230404145319.2057051-8-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Headers-End: 1pji44-00024G-VM
Subject: [f2fs-dev] [PATCH v2 07/23] fsverity: pass Merkle tree block size
 to ->read_merkle_tree_page()
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
Cc: linux-ext4@vger.kernel.org, agruenba@redhat.com,
 damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, rpeterso@redhat.com, xiang@kernel.org,
 jth@kernel.org, linux-erofs@lists.ozlabs.org,
 Andrey Albershteyn <aalbersh@redhat.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

XFS will need to know size of Merkle tree block as these blocks
will not be stored consecutively in fs blocks but under indexes in
extended attributes.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/btrfs/verity.c         | 3 ++-
 fs/ext4/verity.c          | 3 ++-
 fs/f2fs/verity.c          | 3 ++-
 fs/verity/read_metadata.c | 3 ++-
 fs/verity/verify.c        | 3 ++-
 include/linux/fsverity.h  | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 4c2c09204bb4..737ad277b15a 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -713,7 +713,8 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  */
 static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 						pgoff_t index,
-						unsigned long num_ra_pages)
+						unsigned long num_ra_pages,
+						u8 log_blocksize)
 {
 	struct page *page;
 	u64 off = (u64)index << PAGE_SHIFT;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 35a2feb6fd68..cbf1253dd14a 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -361,7 +361,8 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 
 static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       unsigned long num_ra_pages,
+					       u8 log_blocksize)
 {
 	struct page *page;
 
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 019c7a6c6bcf..63c6a1b1bdef 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -256,7 +256,8 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 
 static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       unsigned long num_ra_pages,
+					       u8 log_blocksize)
 {
 	struct page *page;
 
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index cab1612bf4a3..d6cc58c24a2e 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -44,7 +44,8 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 		struct page *page;
 		const void *virt;
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
+		page = vops->read_merkle_tree_page(inode, index, num_ra_pages,
+						   vi->tree_params.log_blocksize);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			fsverity_err(inode,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index c2fc4c86af34..9213b1e5ed2c 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -199,7 +199,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 
 		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
 				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
+					params->tree_pages - hpage_idx) : 0,
+				params->log_blocksize);
 		if (IS_ERR(hpage)) {
 			err = PTR_ERR(hpage);
 			fsverity_err(inode,
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 3e923a8e0d6f..ad07a1d10fdf 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -103,7 +103,8 @@ struct fsverity_operations {
 	 */
 	struct page *(*read_merkle_tree_page)(struct inode *inode,
 					      pgoff_t index,
-					      unsigned long num_ra_pages);
+					      unsigned long num_ra_pages,
+					      u8 log_blocksize);
 
 	/**
 	 * Write a Merkle tree block to the given inode.
-- 
2.38.4



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
