Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED913F589CF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zp8bmVqtjKNvhzs9Kp/pRkSrvXHjyz5tecgIx9klPPc=; b=jsVX4JKA8c3+iT2bDWjzkqw+xN
	nkEXy4ptTl+3bsKbT1uEWbItMQXdtVCKHe9pAR9dunxU5hS9btrZiVoCEE/WRn/YWZ8E8YRUWSP0k
	f8hINDe+exIugPvn54mJ9EkvqQ8D4MmEvaZhknzdUA5ivCaJQTbqWLnyTM0BgOZhdar8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFtr9-0003Ot-Rb;
	Thu, 23 Apr 2026 13:12:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFtr8-0003Of-Da
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KME06VXxZEDCxiuHOzN0Id0I7W6GQoO3+MJbI5byik4=; b=Jyo441LAY7TEtuAX4+GBn3n3Jy
 Js1E/mfQjN7HTkofxfD6V00O5Hp/dEC44h9IkJQhLbPvD4x82u3S263cq5l1fbCQzQb0n1UGeJaqQ
 r5Fc/jrU3bKaeFVJQZRJ2kkIa+ucX6ThLUKMJx85lRWvmcGuTetJKekfQG8Ila6AP0NY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KME06VXxZEDCxiuHOzN0Id0I7W6GQoO3+MJbI5byik4=; b=jadMJx1YGQVEZvowJa2TYxSu/+
 Pxt2XJdCqL7sGyZHCdEsz/N4SirO+ZzFpAVArVjo5TFaxtqel83mkDFDCjxZDd7NSNUbPjOmDegLc
 rpkx1ks4Wz1SePXKi5uI3/sWcPBWWOvyt5I3Dig69Zb/flLenRUvmdZS/o5AhvuR04x8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFtr7-0006nd-IY for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 416D844314;
 Thu, 23 Apr 2026 13:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8622C2BCB6;
 Thu, 23 Apr 2026 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776949948;
 bh=7UJbZffIRnlSy1BsD5KTY53QnosRcT5XUdA8rzeY0m0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=q+8CNK6Ty1dPCj32YKi12DJgeuILKAnyBRpIlf61cLnK+RTqGqCnujyiqkeOrrFXz
 jDJaAVYPzupJ+M1eAimqvkTh1Uy0GVdjZEgu6V3rfHDTtnPANI356Rq3gpJOGGlaIC
 E0u10VS6jFOzMiom2mPikCIFd3TmIYnl8LyN9ypBQK1ekAGuAy3zfPL7aFMAICKYiK
 1bB9gbxlFshmLeVglyRw/tGHFmcpryFso/LsH1EM3QF3XzfwkBoHtEEMimYZcEfsjg
 ve1hOkdmg5ymqaE//AwwPVzvWAJ3qA+aE5KG89uv4GT/o3wtAsT24mcDO4HAsvekWU
 eSBZzk/RyUuWA==
Date: Thu, 23 Apr 2026 09:12:05 -0400
MIME-Version: 1.0
Message-Id: <20260423-case-sensitivity-v10-2-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3340;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+pPurO/+pD2WfwcHWQv0N9xleXhBqxhdJ6hocARUJZ4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hqzV4rncvMnfwromfgLGjORebeuYGgqBGxix
 MODx4f0YwiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoaswAKCRAzarMzb2Z/
 lzuJD/9oett156EXicv6rkJiFAEDCXWQPISxbLgBsKNereRLdeoxArncX+k2TCH+NNCNpGYhmsF
 5rPmzbKsSI4Z8YDHcVcOWFN+uc2KC75iTOUgDQnRLF0dX4wUOCBmozE2jn6XI8McHNRY7B1illr
 z5PX3hGmxY/cfyb5aW9G8383RS1L7a0Z2aymfxPFQVQfM24ugoZ9D4VzTNLiwTQqSGHnuIuvyzD
 eK91r1zb1mYmsRfCOkpEL+3DyA5riUUsJF1x9c9Z/9L4ZVbrEMvTt0s+GIfDUYGTgEBBztfl+PC
 AC3nxLcV8c13VwPMY43FHJyku2am/FL9snNRum6RYgrLQfPnitU/Hj8ZOIOOdVCNO6Y9/uZyh1y
 3n3Sixh3N06mfvsFwVTqT2XG9KC2e8oEB/Ptlw+Lbu84Zv2z4Zp9uTrk4aN37W4gJ9ZQ6Idu74O
 DM+RdPFyt46ik79+6nMzg5M0ODNO5TsygyN5jXHPfM4Lw7scpGMAvCvJ46rP25FA4cGL2jli7zw
 uEKwAlEc6Qe6NPfUjIAbQPad8gGz84jgGgbVLaQmQJcbW8onIwSIOjA3ECF9YyX14wxV29TJCS4
 mLeQMaVYq43CvDhrjWyaSeyo0eWci5orp7Xw0z3rXLUbHJGRYYvVYjqKlJtbuUAjlAZHPFF9VgC
 5whXS5Ywg643qhQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFtr7-0006nd-IY
Subject: [f2fs-dev] [PATCH v10 02/17] fs: Add case sensitivity flags to
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
