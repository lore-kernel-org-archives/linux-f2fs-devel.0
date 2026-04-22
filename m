Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA23FAD3E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HOkZw4e1v/DNPz/DS2JlteBkZGTHSEUyYbsvO6D1H8=; b=KrTXC50hugiLBRyi2cEN7DzIeT
	YwvF9K0I+00Gy3LLrCPmQiPiSY7PpylQy30fPhVcJFY2jJItCdH5Do7nYXS4qGLfMrwwJNnZ65mw8
	a1jKHLRBYZHqVqfbMlEPHtwLyHQTXSdkpMqBdkUht0CjR94SAmIpEFEcPxjL9B8PEdXo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh1e-000178-JT;
	Wed, 22 Apr 2026 23:30:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFh1c-000171-Ts
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2inOlzgycscHkjDPH6rkFDMRJ6yL5UAvFEB5pmiMtB0=; b=YPw5muPxIHPwFmxREMWxFbbr19
 5rMzGp7L8tlqDF5RU1UnbNc3lr0MsJTcUw9IiLyF0cYMErPESNGtv+VO7p06X4c5ZjlUvYy1M0VZn
 MWrsielMp8fFjyWpFzqAQ7McwD4Rtb0rgk9GDLR3lDvOkGAsRfUMVom4qjil2M0pZtk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2inOlzgycscHkjDPH6rkFDMRJ6yL5UAvFEB5pmiMtB0=; b=GLVuvpFMqojxHCCeBceuY2mviY
 SrcuRBiRfsAOaxnZORLLjSfpPBmDjZb60ONyQPJFa6pctQWCKr4bJi+RcGiY1YN1WmiIpN45rpsrw
 2eTyeOJtQPGMzfYeWeVJUIiWe3yrNEzrth+anaEMu0ITzjcVIa5LSZV6ArUOXTpAXk0k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh1c-0006d8-CT for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A2F2401D3;
 Wed, 22 Apr 2026 23:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B25C19425;
 Wed, 22 Apr 2026 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776900622;
 bh=uytnG4T41lmij4usJJKWFHkDGf7l9bOy8F5b+Jr0Bz8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ngex4nC0VVrNAo5mw+72SuWXiDcV74tTuNdtVOwaDfEbcNRwf9gNdBNUg3v5BdmNt
 j1X83Pro3ZJBaPBP2/t43CauNjGcLGCMqfvjGMB/1t8Cu9L56KFREx7YBarEuFASo+
 KH9xqh3X6g5SeR77yZ20bQ2PhVnCK/Jl7NnoXELn4mZuuLmevcUEuZd283k+16jvU5
 ZYFxhTxpGubkcaY7lQbhpm4hSblmakq8t0eAkkSFhBF/71U4nT3WS0hgUPRzNiacwB
 iwy5YPxVMX09+PhoeDMmHs8p6AIvg5vgoYNqBwXIAidL72ne84/vQZweQPVtm1Iz2b
 N00H+eeqqKYqQ==
Date: Wed, 22 Apr 2026 19:29:56 -0400
MIME-Version: 1.0
Message-Id: <20260422-case-sensitivity-v9-2-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3063;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=sEgEaAVKkk3OcJq+fmpgufZDvvVtq2OzcLqvqCXcHKQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoFS16vtgH3TX9/MlKIt0UPwe9oTupY7K4XZ
 FKcQg0AtR+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 l/dGEACO5DxHKVVVOf2qk2IsxSXIeTaH2XRX84xMfJeZ63ZrvUUXoVF+G+OtN+NDWg4m9WswVuC
 VbEHnm93dBdgWUtHFd9R3A1uo679Nn2FV+1iObWn6yuWcPlWF1+FJV3n6nOne6U/c5B8x7BtOSY
 yqwei18I4bgVgJ0oHmwo3XJdPQgfboTZVI/u+9E4P7eBxvZD/Tk3/43trbvBnrBiCO1GUFRc+w9
 yU7KdGz2aEYEsn9Wlm+CSc+FtR9qhBj3U1cxf+YtJ1EupPF6suBR97duPzNKbfPrbjqYjGIJyrb
 XL3osbDPb+xUmUkc6lQEtJBJriwowZOejHW5SWFlDC/1P6U11U+NyTAr7ona3S5hKim2QxuvJPo
 x2DaNO3BsC1pTs7138R+/aJM4z6ToDRfZMP6KqAhQcDce4VIDmjnsyM4oe+7OuBgl2h2jTv118D
 kMnS1PxbAvHYNcN/lHkJxhLwFA4RgJ/THdEfmf7vOfS0OquBUVKf6O36Pjv6GOvCRUjM9MuSyex
 EBRb4LsKoOUhCgcj6vNOSH8yoNQvNAQSDFqlk1J1G63bj5DYo+SdOWbJq41FwF01O/IoHtFrLJe
 8Y5fk+NNHWvCN3SQWXrY26QoMC6/ATimUztTTgu6pmcHx0WfRYhnSnP6DPbA9NeILmlScSir2ot
 oFUnpfyWCrmsAoQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFh1c-0006d8-CT
Subject: [f2fs-dev] [PATCH v9 02/17] fs: Add case sensitivity flags to
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
case-preserving. These flags are read-only; userspace cannot set
them via ioctl.

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
