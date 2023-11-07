Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EE9C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Nov 2023 04:45:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r0Dy8-0004vY-MA;
	Tue, 07 Nov 2023 04:45:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1r0Dy7-0004vS-FV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 04:45:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nnrDWNHgsplSq1p2fUKGXOHI5nMlRkX7df0078s3prk=; b=EcC3mcd85+hSO/HZRiTZ2ObTD6
 LAnD5+j0hN0kmC3aZ1fEndQ7m8Os2jIqFYEPuxCBHDpQ/KlzgEP5BNwKK7QNTFN1GzaUEcxkN1hv4
 29TTPveFl8UoWt2hXsRqZw/uLC8TxPXGGaOYtr8Wp8BmMv+6g5emvnwz5xANWq1407Fw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nnrDWNHgsplSq1p2fUKGXOHI5nMlRkX7df0078s3prk=; b=K
 RBBJKV9KXtUk4bx2MFbTHC+MLc9j6br8bTFJrf7eha7iK0Y6fqUd+Cdbs7WG3DHIzwQXTn7qqDnss
 qvW/O2LLM+qmjQehH4xy5/0Phr+nGd12pvCgIsoWD0FGOE6mBCN6OqoYHgsTidoXd/Z1oSS6n7ocL
 RM9aFdDhCDQZ8iTg=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r0Dy5-0000U4-A8 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 04:45:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 16DD1CE0E05
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Nov 2023 04:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47069C433C8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Nov 2023 04:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699332324;
 bh=OzxF+wKTlkTeokV+iQfnTi1bpG5IL/pboG/VvoglCgY=;
 h=From:To:Subject:Date:From;
 b=HxKZpsAVnFyy7fPB7vGRjefGYpP/arMaGR59dCefDB8DakHnfk/Q2Oi9y1dcniD2o
 K7BR37dcBXHYJ19c7cv2hKGQQ96fGrOvWsa8g9e/YgC+1dPr1v3Kv8hyuzIJeMujgU
 H0lseEM4kD7o4rbt/qiThtyQ8hVB9/RmDeeY458Njn634lfGVJFev0OC8rGnh5XGGE
 nCitOs9b8BPK4Y9TufxX4RbvUe21aFMOkzDqq4qgYyKj8vuImQOEfgFeW6rEmyi9gM
 Y8CiTWTm9IBfpYsTz/RnTLTy8FHRAl7pZ8fr+Zc6bJ/6cRSYAGhUczBpFyZPJGXvSW
 rvdSy7HBmKMRg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  6 Nov 2023 20:44:34 -0800
Message-ID: <20231107044434.157292-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Headers-End: 1r0Dy5-0000U4-A8
Subject: [f2fs-dev] [PATCH] f2fs: explicitly null-terminate the xattr list
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

When setting an xattr, explicitly null-terminate the xattr list.  This
eliminates the fragile assumption that the unused xattr space is always
zeroed.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/xattr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 47e88b4d4e7d0..a8fc2cac68799 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -747,20 +747,26 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		 * Before we come here, old entry is removed.
 		 * We just write new entry.
 		 */
 		last->e_name_index = index;
 		last->e_name_len = len;
 		memcpy(last->e_name, name, len);
 		pval = last->e_name + len;
 		memcpy(pval, value, size);
 		last->e_value_size = cpu_to_le16(size);
 		new_hsize += newsize;
+		/*
+		 * Explicitly add the null terminator.  The unused xattr space
+		 * is supposed to always be zeroed, which would make this
+		 * unnecessary, but don't depend on that.
+		 */
+		*(u32 *)((u8 *)last + newsize) = 0;
 	}
 
 	error = write_all_xattrs(inode, new_hsize, base_addr, ipage);
 	if (error)
 		goto exit;
 
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
 	if (S_ISDIR(inode->i_mode))

base-commit: be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
-- 
2.42.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
