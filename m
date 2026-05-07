Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B86BCD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2026 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a/3/N/H0Oo4yBLaDPp7y8sficvMDHi8zzgvqQC1u0Qw=; b=hPwSp7YnyWXzZbRbm9i+LEDybm
	9/QcAkDcs9FECn2wh/koYf/fb1e0IFDfZ8DAb9FiRUcEHEWxbTKyNH35dGY1XbyO7GaOM0IEKSZVv
	k+trLyb5Oz/nr5UKRffFw8Z0LK9kTlAnbFWOv1652ey9rOS2aaRa4mn/+oFDYMN0K9Us=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKx62-00016a-6t;
	Thu, 07 May 2026 11:40:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wKx5e-00015b-8A
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=arjuK+L72D0jf7N8tYKkdUcWpAVW9VDCbwqiGefCQAg=; b=BCEZbcIxcEHZttFCnQSIfJJF0E
 XxFZq9bRTz216XJRsC75Kj56B7ntJcdwXnrHhysSe3M5Y89bnWv2vYmNXAmIw6cjUOtoovES7b14V
 Bbik8TW0jq9O9hipZgslWL42rvUXBgU9b5hsMDbi6kQp4g7tFfQ0/Wk6WEevWOpo0g80=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=arjuK+L72D0jf7N8tYKkdUcWpAVW9VDCbwqiGefCQAg=; b=TYtRArga/g8HCkj/VSsKeYK+iP
 aQqohG2C57lon2ycNSVj4CjFM7Og4cQVIewNwwDU+Wx3QzrG60bd7a81To6T6BobsBLIbnZGQboHm
 R8yW7umrLYSp+uAg7hBY1s99sFe6q7z9wNwhJ4nRU8y9UXSJOWlc+5HwopGLpi5xXvZQ=;
Received: from smtp153-168.sina.com.cn ([61.135.153.168])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wKx5c-0002oY-NG for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1778154024; bh=arjuK+L72D0jf7N8tYKkdUcWpAVW9VDCbwqiGefCQAg=;
 h=From:Subject:Date:Message-ID;
 b=KmlAObIBmRWIJHUVGoxuX7tIHh99/KGe9Yr0KF+IkxAV5IGI8JIZMahHm4Of25zrj
 i8UpN9yJZL6RlaGlz+vRpsVMwhqc8D9fk+hCpriv2GxiztBh0FEs1IpsexaNA/Wawx
 sm1sDSs4szDHSjYclQ6wyj/5yGvg3BURj5baBJbY=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.33) with ESMTP
 id 69FC7A1800006ED5; Thu, 7 May 2026 19:40:11 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 8689466685042
X-SMAIL-UIID: 558B4663D4514446958DC517B556BB0F-20260507-194011-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu,  7 May 2026 19:39:52 +0800
Message-ID: <20260507113840.1353304-8-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507113840.1353304-2-monty_pavel@sina.com>
References: <20260507113840.1353304-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.43.0
X-Headers-End: 1wKx5c-0002oY-NG
Subject: [f2fs-dev] [RFC PATCH 3/4] f2fs: support setting inline extent flag
 via ioctl
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

Allow userspace to enable or disable inline extent format on a
per-file basis through the FS_IOC_SETFLAGS/FS_IOC_GETFLAGS ioctl
interface using the F2FS_EXTENT_FL flag.

When setting the flag, the file's direct block addresses are converted
to inline extent format. Compressed files are excluded from this
conversion as the two features are mutually exclusive. Clearing the
flag converts back to direct block format without restrictions.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/file.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2ca09ac1f3d4..a499dbcf53dd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -33,6 +33,7 @@
 #include "acl.h"
 #include "gc.h"
 #include "iostat.h"
+#include "iextent.h"
 #include <trace/events/f2fs.h>
 #include <uapi/linux/f2fs.h>
 
@@ -2117,6 +2118,58 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 	return 0;
 }
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+static int f2fs_iext_enable_inline_extent(struct inode *inode)
+{
+	int ret = 0;
+	struct folio *ifolio = NULL;
+
+	if (f2fs_has_inline_data(inode))
+		goto out;
+
+	ret = filemap_write_and_wait(inode->i_mapping);
+	if (ret)
+		goto out;
+
+	ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
+	if (IS_ERR(ifolio))
+		return -ENOMEM;
+
+	if (!f2fs_iext_convert_to_inline_extent(inode, ifolio)) {
+		f2fs_folio_put(ifolio, true);
+		f2fs_err(F2FS_I_SB(inode), "convert to inline extent failed!");
+		ret = -EINVAL;
+		goto out;
+	}
+	folio_mark_dirty(ifolio);
+	f2fs_folio_put(ifolio, true);
+
+out:
+	return ret;
+}
+
+static int f2fs_iext_disable_inline_extent(struct inode *inode)
+{
+	struct folio *ifolio;
+	int ret;
+
+	ret = filemap_write_and_wait(inode->i_mapping);
+	if (ret)
+		return ret;
+
+	ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
+	if (IS_ERR(ifolio))
+		return PTR_ERR(ifolio);
+	if (!f2fs_iext_support_inline_extent(inode, ifolio))
+		goto out;
+	f2fs_iext_convert_to_direct_blocks(inode, ifolio);
+	folio_mark_dirty(ifolio);
+out:
+	f2fs_folio_put(ifolio, true);
+	return 0;
+}
+#endif
+
 static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -2129,6 +2182,30 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 	if (IS_NOQUOTA(inode))
 		return -EPERM;
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	if (iflags & F2FS_EXTENT_FL) {
+		int ret;
+
+		if (!S_ISREG(inode->i_mode))
+			return -EOPNOTSUPP;
+		if (iflags & F2FS_COMPR_FL)
+			return -EOPNOTSUPP;
+		if (f2fs_compressed_file(inode))
+			return -EOPNOTSUPP;
+		ret = f2fs_iext_enable_inline_extent(inode);
+		if (ret)
+			return ret;
+	}
+	if ((iflags ^ masked_flags) & F2FS_EXTENT_FL) {
+		if (masked_flags & F2FS_EXTENT_FL) {
+			int ret = f2fs_iext_disable_inline_extent(inode);
+
+			if (ret)
+				return ret;
+		}
+	}
+#endif
+
 	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
 		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
 			return -EOPNOTSUPP;
@@ -2224,6 +2301,7 @@ static const struct {
 		FS_NOCOMP_FL |		\
 		FS_INDEX_FL |		\
 		FS_DIRSYNC_FL |		\
+		FS_EXTENT_FL |		\
 		FS_PROJINHERIT_FL |	\
 		FS_ENCRYPT_FL |		\
 		FS_INLINE_DATA_FL |	\
@@ -2240,6 +2318,7 @@ static const struct {
 		FS_NOATIME_FL |		\
 		FS_NOCOMP_FL |		\
 		FS_DIRSYNC_FL |		\
+		FS_EXTENT_FL |		\
 		FS_PROJINHERIT_FL |	\
 		FS_CASEFOLD_FL)
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
