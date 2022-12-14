Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1481FC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Dec 2022 22:46:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p5aVr-0003YV-Iu;
	Wed, 14 Dec 2022 22:46:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1p5aVd-0003Xz-03
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Dec 2022 22:45:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D51rtKA9U0RWcjz3TtgFLmSvJyVQnrXAL32Nel5MBrs=; b=Q+/uYVJs8WW906bvn4wjBCt81n
 U3n78GtWGppoc/7BXQB9cdhAYvflXdj2EUj1xu+r56WdphG1AztWn5YZoK1U8bS8nq7OfZX9dC/DI
 RQnch25H8cHLpNdZGmV+xlYTE/Q40kTYyNYlCopxyFIjt1CBE3wa3RzKw2plgTGWmumA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D51rtKA9U0RWcjz3TtgFLmSvJyVQnrXAL32Nel5MBrs=; b=LDxZkTTDV4lSQhH62764luxQ6A
 UQR9MarNtVzJLTpgp440Hj6C53vjWMQPLBbHnMqE+20xOEjNNaR+d2XDmwRDOU1xOeV11OnLwoKx9
 GRG0FbEH3w2gZZnU20rQ7/NAK1ImHq3osR9qK8yIT1MVYcVZ3h43DlGg89g1Ylg3/Mec=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p5aVZ-00HGhH-8S for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Dec 2022 22:45:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id F2B0CB81A42
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Dec 2022 22:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9331AC433F0;
 Wed, 14 Dec 2022 22:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671057941;
 bh=uJ3FO4tiueVTb/4lrSOqyDlwjeWDWqy+a4fT7SmmDcs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C0QbxiKYE2VOxgX/uB7OvsCcHekCwBxYw2+DygusA8QIW/Quxt8Sawkvfo9So92Wj
 mjwygoQ2CFNs9P6CmgHk/tVl+ql2dSMbauBMdaAScm4f6KWZgeoWkweCOQGhMKhbqX
 3k7Xy5GcgXcmkNtcKsbSDkNOzSK3XXnsz1gjrM8Z5VFoVvaxhpTxejOCJY/1i2yFci
 eF3GpIKe7EAvDJq1hWb/td9LMQxR5YRfLmjCBdXQL3XOOQcGyez3hIv9Hmkk9Qcswn
 BxQvfLOScLeHlnKv4MPCW/egRGUiIAei68p7yH4P5nrWUOsjxEnLojV0nDm308RKYn
 NCDecNzthjJjQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Wed, 14 Dec 2022 14:43:02 -0800
Message-Id: <20221214224304.145712-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214224304.145712-1-ebiggers@kernel.org>
References: <20221214224304.145712-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1p5aVZ-00HGhH-8S
Subject: [f2fs-dev] [PATCH 2/4] fsverity: optimize
 fsverity_prepare_setattr() on non-verity files
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Make fsverity_prepare_setattr() an inline function that does the
IS_VERITY() check, then (if needed) calls __fsverity_prepare_setattr()
to do the real work.  This reduces the overhead on non-verity files.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/open.c         | 16 +++-------------
 include/linux/fsverity.h | 26 ++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index 673d6db9abdf..e1e531d5e09a 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -337,26 +337,16 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
-/**
- * fsverity_prepare_setattr() - prepare to change a verity inode's attributes
- * @dentry: dentry through which the inode is being changed
- * @attr: attributes to change
- *
- * Verity files are immutable, so deny truncates.  This isn't covered by the
- * open-time check because sys_truncate() takes a path, not a file descriptor.
- *
- * Return: 0 on success, -errno on failure
- */
-int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
+int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
 {
-	if (IS_VERITY(d_inode(dentry)) && (attr->ia_valid & ATTR_SIZE)) {
+	if (attr->ia_valid & ATTR_SIZE) {
 		pr_debug("Denying truncate of verity file (ino %lu)\n",
 			 d_inode(dentry)->i_ino);
 		return -EPERM;
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fsverity_prepare_setattr);
+EXPORT_SYMBOL_GPL(__fsverity_prepare_setattr);
 
 /**
  * fsverity_cleanup_inode() - free the inode's verity info, if present
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 326bf2e2b903..84b498fff7ec 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -149,7 +149,7 @@ int fsverity_get_digest(struct inode *inode,
 /* open.c */
 
 int __fsverity_file_open(struct inode *inode, struct file *filp);
-int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
+int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void fsverity_cleanup_inode(struct inode *inode);
 
 /* read_metadata.c */
@@ -198,10 +198,10 @@ static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
 	return -EOPNOTSUPP;
 }
 
-static inline int fsverity_prepare_setattr(struct dentry *dentry,
-					   struct iattr *attr)
+static inline int __fsverity_prepare_setattr(struct dentry *dentry,
+					     struct iattr *attr)
 {
-	return IS_VERITY(d_inode(dentry)) ? -EOPNOTSUPP : 0;
+	return -EOPNOTSUPP;
 }
 
 static inline void fsverity_cleanup_inode(struct inode *inode)
@@ -274,4 +274,22 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/**
+ * fsverity_prepare_setattr() - prepare to change a verity inode's attributes
+ * @dentry: dentry through which the inode is being changed
+ * @attr: attributes to change
+ *
+ * Verity files are immutable, so deny truncates.  This isn't covered by the
+ * open-time check because sys_truncate() takes a path, not a file descriptor.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static inline int fsverity_prepare_setattr(struct dentry *dentry,
+					   struct iattr *attr)
+{
+	if (IS_VERITY(d_inode(dentry)))
+		return __fsverity_prepare_setattr(dentry, attr);
+	return 0;
+}
+
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.38.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
