Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6F4CCFA13
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hA8efJ+eOjRMla29m2dXQ9bv4Pk4FASyQ9n8PF/GMpM=; b=f0wkIMAQ3O+Jwyk5er+suR8RHn
	88QPa7jLDh5ZMLc5pBFS81ucuwNc4lZ4rQhHvnXrZmR/T0T6Zgzvt7GEF4YzBV0XRkQjMkOxjCrOX
	OhThZEsliBYvv3rgQtyK1Be/BMB667h4AmQ8HN36wbHgaY5RY+aLTK6f1plTNeSZseFY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wI9L6-0004W4-Ow;
	Wed, 29 Apr 2026 18:08:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wI9L5-0004Tv-Mc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 18:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TRxThEE0rG0zIff4S1AEBrksd0ChfZDwcTBwyktROYQ=; b=ewW0eTERiGCsmFkvpZqF5Xsh3D
 coTqD/R/J1xWFR1AoAxqv3v/ud0c7DtHvl2iGJaohaCx1YRdsFqPKLwnrADw8LojL+NuzYoOPVVYA
 TwqOO/oBk3JyMpJv6OztaNxH0V+lE9ma9IMSGGU2y25CUNRgbhHPaUkk453WAR0yPsVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TRxThEE0rG0zIff4S1AEBrksd0ChfZDwcTBwyktROYQ=; b=IpHrvJIE9IAz15jm02CikBVyPr
 bq4iuMC+WSQmEE/U/oFcGnZOZQCzjxISQU0K+5OwqmM4Fzdf8ae7A0PnYHSEsQaCQixXzaYOT8ANI
 WG8it7zW+XY/JYpYi54PSE4nxDedZn89jbgdGfLDRPJK4QPAAqJtlDhZL1CYH3G/BicE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wI9KZ-00017N-Te for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 18:08:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 99A6943EE0;
 Wed, 29 Apr 2026 18:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2BCC19425;
 Wed, 29 Apr 2026 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777486085;
 bh=qee/kCsMg8C4eRFPxmiZaknm+clMPDWXLjgwoKgpYx8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=cp7aPOO+0dpAl5comMlMldcJa1APBJg4dyIBsWMJ2dtOrQbwWwziadV1HHKwrhyO2
 EKu4+yuEtoA6jUBez4Y0IWm7LnpjZ7KIQ0cKbWX4NFBhaQoo8h8ksY6WyypcBJIiWf
 YVKLHIwg3nRuxX0c7vGmZp0keEDeDDm30aZiICMEh6w5Ltf7b9eGdLSsN7GUeHd2RO
 KG8J5iHDbC2xwSoCytBzBwqRmnDRaD72VrktoFD4aXdoNzEgYb39fr+hiUjydoGqNK
 eZvAfEO7UeiBTmVpcpqsgS3jMPggCeKbV1zsEWMalElaMbD0tnnbSQkclFiQ1gT2dT
 +Oqta2nmBEIpg==
Date: Wed, 29 Apr 2026 14:07:26 -0400
MIME-Version: 1.0
Message-Id: <20260429-case-sensitivity-v12-15-8057123bebe0@oracle.com>
References: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
In-Reply-To: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=3j19l6mVyr/XReBrhpdSBMPAL80WouHe9sT+TihiyQM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjdM8DNWFfItbp41H9vWWe4sjWWzOyQ+8ADF
 lrE33haaFeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3QAKCRAzarMzb2Z/
 l6qCD/49AW4062WfbZHsVpGZySPK2wkZN4kfzlroTWbJi5jHIlMQIwp5bYVt4lATNx2xi3HKgCa
 yItm/0qjXDMJPU9Fn94bdyvedMVogpUZIY/ZRViPTT9ruiASIFp9YTJaUFH3gm+q6lKMGGueSfn
 Z8EN2By/rS44QT2tQtZeRQg+zuoeN0qOLicrbGM8Ug4pCtBZ8RgpvTKfaLyrnDSp4V386qjxeSF
 m6/1X0kKy/gtY/4vezUg9HU0vMFe/Z8hWm7GM3FiUBaQtO3NkImZILcblBqflbk1iwbr7Qyj/ZN
 GolZ7i6mSX43sZPXu2qZvJcXrsjI2l1ZrjkAcd2TiNhxk01B8C29+OkVaZDoYfOFPJ7cem1CUkD
 yF4wuNlaIqyfQ7wUC2gDXnZx464eKD6yuPpBqLgQh5Shi11DAwcJh+bESsAO0t8+6/KX8qiwJ+D
 FmGWua4a6ZHifxfcGv//3z8Lqg/FuYL/G/tSGUlJR3ucsFKGHFkl58j6LSSMV6/nXs5C/WsGKGX
 BXuIrC5tVEveeTCH07Efv3p8TfnjaJqw+kQMv4dnuhYU1F4RwUb/4o3W2yBHobxSWo9aYMfSm/7
 xCr9iOFnAKJYKyohvVvXxada0v9urbMpe8ELrwuwZW6XK/aKH29m1vV2wOnVmP/IH9CA5qJVTgt
 LYV9F6XEAovyiZQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wI9KZ-00017N-Te
Subject: [f2fs-dev] [PATCH v12 15/15] ksmbd: Report filesystem case
 sensitivity via FS_ATTRIBUTE_INFORMATION
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

FS_ATTRIBUTE_INFORMATION responses have always reported
FILE_CASE_SENSITIVE_SEARCH and FILE_CASE_PRESERVED_NAMES
unconditionally. Case-insensitive filesystems like exFAT, and
casefolded directories on ext4 or f2fs, have no way to signal
their actual semantics to SMB clients.

Now that filesystems expose case behavior through ->fileattr_get,
query it via vfs_fileattr_get() and translate the FS_XFLAG_CASEFOLD
and FS_XFLAG_CASENONPRESERVING flags into the corresponding SMB
attributes. Filesystems without ->fileattr_get continue reporting
default POSIX behavior (case-sensitive, case-preserving).

SMB's FS_ATTRIBUTE_INFORMATION reports per-share attributes from
the share root, not per-file. Shares mixing casefold and
non-casefold directories report the root directory's behavior.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/server/smb2pdu.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ee32e61b6d3c..cf0bc453a036 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -14,6 +14,7 @@
 #include <linux/falloc.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fileattr.h>
 
 #include "glob.h"
 #include "smbfsctl.h"
@@ -5541,16 +5542,33 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	case FS_ATTRIBUTE_INFORMATION:
 	{
 		FILE_SYSTEM_ATTRIBUTE_INFO *info;
+		struct file_kattr fa = {};
 		size_t sz;
+		u32 attrs;
+		int err;
 
 		info = (FILE_SYSTEM_ATTRIBUTE_INFO *)rsp->Buffer;
-		info->Attributes = cpu_to_le32(FILE_SUPPORTS_OBJECT_IDS |
-					       FILE_PERSISTENT_ACLS |
-					       FILE_UNICODE_ON_DISK |
-					       FILE_CASE_PRESERVED_NAMES |
-					       FILE_CASE_SENSITIVE_SEARCH |
-					       FILE_SUPPORTS_BLOCK_REFCOUNTING);
+		attrs = FILE_SUPPORTS_OBJECT_IDS |
+			FILE_PERSISTENT_ACLS |
+			FILE_UNICODE_ON_DISK |
+			FILE_SUPPORTS_BLOCK_REFCOUNTING;
 
+		err = vfs_fileattr_get(path.dentry, &fa);
+		/*
+		 * -EINVAL, -EOPNOTSUPP: ntfs-3g and other FUSE
+		 * filesystems that lack FS_IOC_FSGETXATTR support.
+		 */
+		if (err && err != -ENOIOCTLCMD && err != -ENOTTY &&
+		    err != -EINVAL && err != -EOPNOTSUPP) {
+			path_put(&path);
+			return err;
+		}
+		if (!(fa.fsx_xflags & FS_XFLAG_CASEFOLD))
+			attrs |= FILE_CASE_SENSITIVE_SEARCH;
+		if (!(fa.fsx_xflags & FS_XFLAG_CASENONPRESERVING))
+			attrs |= FILE_CASE_PRESERVED_NAMES;
+
+		info->Attributes = cpu_to_le32(attrs);
 		info->Attributes |= cpu_to_le32(server_conf.share_fake_fscaps);
 
 		if (test_share_config_flag(work->tcon->share_conf,

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
