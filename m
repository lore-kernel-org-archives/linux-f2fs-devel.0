Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAA6FF885A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Apr 2026 01:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0eI7NGNixyPS6zSn/+Ks4hjmSRlHEb87e81a1vdEm4=; b=C02H71KWNcYw7yIFC9lpYhUAbR
	N4v+99OoWq3a5nUnr4OQUFkzwiqwXKVdtEZNVwzoYjNQP1zhuyWxW2g5t5/FWOrUuYddutd327tjE
	9iaMRx3GEVicjFcPBLkV8dYhEugy2D7hfbvDPvRxwjWr+yaQLLl3SXFmp4NYMErNm1jc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wGSDI-0000xL-Ex;
	Sat, 25 Apr 2026 01:53:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wGSDG-0000xF-TC
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Apr 2026 01:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M76L0VIZ7k/ZCZVS7EN5BXOb5R2OAPfqgXzdJQ55+yI=; b=gfP52mn7/kh0ukGXXNLWmUPEqI
 th4cmgup6LS3h1VgWKb3mzfiwRqxHjF6TBUcSVMG8oSw8vXLvflFPhjuAAU4Ss/v1FL6mSxm/EDP6
 z13lxe2pU7oV88ThVaZyiwLJuC+Y5gnk/AjSk/5vmbpytq85GE346i+8c1WJfXEncMjI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M76L0VIZ7k/ZCZVS7EN5BXOb5R2OAPfqgXzdJQ55+yI=; b=Z+FH0uIDBNV783ijkH4YJT9z8W
 FbNxMtWWnnPYi76scBxZFBrC6ZFAEa9mrLXO+8xzdxSDDBIYDtQs4BY+IRPz0IIsFveFf+Tt8oRQZ
 vkovs7R4dmv3NCYVmyI5Ds1MwbWsBMfQc8pCZd+TFingjEHM3UGNVyROFgwdfI4IIPgQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wGSDD-0002zj-MY for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Apr 2026 01:53:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E34F600AE;
 Sat, 25 Apr 2026 01:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F77C2BCB2;
 Sat, 25 Apr 2026 01:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777082008;
 bh=TFF/jZiZrtLjdmF8xjSA6CfyQJOvsGBZ0ycggreXc9A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iAJ/CuUkYBRHUgd5Vbk3R/RuxMgydkd1Q6LIHyPEp6KVnjtqQH541808e5rOlhi/N
 xJaIk8KIl309tG3fxJsIz2dOLkIvk4YMdWbQCy4X+8763pE3WFjtogZlfJ+6c81jhJ
 d7anFQbPh7MXEI4PA2DVVjQNSHokYmBhniv/yH3jY0uIKMGS95aWiFZ7Ne90lphGFO
 l3H7iVTSeROA7Yy1lvxoeHkMAd9+DCEjTKGA1PmdKYrDvgUwbMwCMzDlw13GZYDbAb
 0+v2h/UWhZ1zjA32z/qtjWA2vXrava0BIz6mh78WjGjZBC9HCg8bdXJKNGbu190u4G
 2MgyyP7UDE0YQ==
Date: Fri, 24 Apr 2026 21:53:04 -0400
MIME-Version: 1.0
Message-Id: <20260424-case-sensitivity-v11-2-de5619beddaf@oracle.com>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3394;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=42BtA/ECrX4U52i4InslT9hET7DZ27jCO0bDUKFKJW4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6QnCcLxEgVgqxUPTsyyPkPTGM1fwG8lYKAg
 sf1zpx+aSSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 l/qtEACCmS3MA/uOWQjFk94bJTW2Zo02V0sdsO47IYXAL+DmIVBmnacrvD2LJdNNMyIKdJgHtHQ
 GKb0TFBuvc3NiwOXlTkQZn5XVmKiYhiMzapxwOT+tMeeQvpUGmzW731Mp1BUwoNPyDJdW/5Kuul
 EGoiFMVzqBQnyBTx6u4EKz5pRGYZYg3q6DvmoLInvN/PbMjnQ6lhcekaXJY34iLQUqk9cF+Nc1y
 ocLCfH5KwM5Ez9EIr2H+jf3J5BBPh4+vXUkvpGCL01OzK2j3EOcubXFZoBsxeHAaTtH4C1D62bB
 e7y8i/cxDq9L1Q316+QHxnNU53WPxIKQwj+UFQIVIwY1px/hIehHn/sSS4dFVyV7ILoYWxliiPp
 gcps9ZU5bNVtk2C8ThjeatIhQGRiACG/J9FiOzgZnF+E/glef20kAf6ZuYzcuZ+cGcUye+RtS5a
 92drAqIv90+Eo9mxYAxsDJqA+5f8N2W0vD1SdmyWYT+gXxG64CCULaJRH21bKfv9y/KP12lttW6
 mnmTB3PqAhuN8VguGQrADzab2S0L1QZLn1KcBvHny3QtT478jXZ1cyMfVIPcsVKsYyJsxl1VE5W
 kRVecsPbDv6pwQ0u9AGsFDnPOfSbg+zpwYOegsYepLUqrbxITMTISc6uKfXD2uH2AYmzk8qzbEu
 I+a1rEar5hUbDsg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wGSDD-0002zj-MY
Subject: [f2fs-dev] [PATCH v11 02/15] fs: Add case sensitivity flags to
 file_kattr
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
 "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 linkinjeon@kernel.org, sprasad@microsoft.com, frank.li@vivo.com,
 ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org,
 hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Enable upper layers such as NFSD to retrieve case sensitivity
information from file systems by adding FS_XFLAG_CASEFOLD and
FS_XFLAG_CASENONPRESERVING flags.

Filesystems report case-insensitive or case-nonpreserving behavior
by setting these flags directly in fa->fsx_xflags. The default
(flags unset) indicates POSIX semantics: case-sensitive and
case-preserving. Both flags are added to FS_XFLAG_RDONLY_MASK so
FS_IOC_FSSETXATTR silently strips them, keeping the new xflags
strictly a reporting interface. Callers that want to toggle
casefolding continue to use FS_IOC_SETFLAGS with FS_CASEFOLD_FL,
the established UAPI on filesystems that support the operation
(ext4 and f2fs on empty directories).

Case sensitivity information is exported to userspace via the
fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
system call.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c           | 4 ++++
 include/linux/fileattr.h | 3 ++-
 include/uapi/linux/fs.h  | 7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index f429da66a317..bfb00d256dd5 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -37,6 +37,8 @@ void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
 		fa->flags |= FS_PROJINHERIT_FL;
 	if (fa->fsx_xflags & FS_XFLAG_VERITY)
 		fa->flags |= FS_VERITY_FL;
+	if (fa->fsx_xflags & FS_XFLAG_CASEFOLD)
+		fa->flags |= FS_CASEFOLD_FL;
 }
 EXPORT_SYMBOL(fileattr_fill_xflags);
 
@@ -67,6 +69,8 @@ void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
 		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
 	if (fa->flags & FS_VERITY_FL)
 		fa->fsx_xflags |= FS_XFLAG_VERITY;
+	if (fa->flags & FS_CASEFOLD_FL)
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 }
 EXPORT_SYMBOL(fileattr_fill_flags);
 
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 3780904a63a6..58044b598016 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -16,7 +16,8 @@
 
 /* Read-only inode flags */
 #define FS_XFLAG_RDONLY_MASK \
-	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | FS_XFLAG_VERITY)
+	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | FS_XFLAG_VERITY | \
+	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
 
 /* Flags to indicate valid value of fsx_ fields */
 #define FS_XFLAG_VALUES_MASK \
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 13f71202845e..2ea4c81df08f 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -254,6 +254,13 @@ struct file_attr {
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
 #define FS_XFLAG_VERITY		0x00020000	/* fs-verity enabled */
+/*
+ * Case handling flags (read-only, cannot be set via ioctl).
+ * Default (neither set) indicates POSIX semantics: case-sensitive
+ * lookups and case-preserving storage.
+ */
+#define FS_XFLAG_CASEFOLD	0x00040000	/* case-insensitive lookups */
+#define FS_XFLAG_CASENONPRESERVING 0x00080000	/* case not preserved */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
