Return-Path: <SRS0=17kY=YC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60592C47404
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Oct 2019 10:15:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20281206C0;
	Wed,  9 Oct 2019 10:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="Awcdd5GI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="W+1clj9r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BigrFyBn";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="o54gf+5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20281206C0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YUeld1b8wDWHVC5HMvXQdpl0VGA/I78Cxva5g6kxQmU=; b=Awcdd5GI7RclR4rDJIn7jmlvSM
	kJA9rvgl05eB5ENMYzyHNy3L+lgl5HdaJDhFLeI4ypSwtCujE1n28tBQNq7mUDC+H2l5w8ceiak0v
	THzlEyCMh4kCz9ZuHjd6bJNAVcxm2vt03H0M91HeBki8+UTA+VSWAjIR85WRjyFlXqm4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iI90M-0006Tl-Hb; Wed, 09 Oct 2019 10:15:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3-VGdXQwKAAYn0gtmxgtjgrrmuumrk.ius@flex--huangrandall.bounces.google.com>)
 id 1iI90K-0006TI-Md
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Oct 2019 10:15:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=//5Om/XvJWZ+udEKS9YxOJkf+X7Db3sKLHkQ/lC+RWM=; b=W+1clj9rUF89DJOE4X+Bb8YtGz
 +HF6PhhMP5CZRyOVvhEV9/2fHnrobOCHZhy4l5DHOszAL9KEfx6ov7WDy3t8F9ZH3cHq0aUcKTpuI
 Ybh6mW2iuvN8HEmPciYiag17es3eMt0IRneav3ucE2jlfckIWlnGM5pfOTr9ikofQAWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=//5Om/XvJWZ+udEKS9YxOJkf+X7Db3sKLHkQ/lC+RWM=; b=B
 igrFyBn8KMOce8eA5ZvPR+1vmCdqzIgfwQAYVDyGiFaJIQ2NNrd1+ZQbH9HDZsVFW5ooPVxOKodis
 dVD4WxON4JlTPy5//JRDBpfRj7vPQAi26MCT/Bpm6ocmS3uXmqjXckK2Cb3F8mmCxND3XOFcDPYg9
 DtOc9rWjgxT64qpk=;
Received: from mail-io1-f73.google.com ([209.85.166.73])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1iI90I-003mv6-K9
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Oct 2019 10:15:36 +0000
Received: by mail-io1-f73.google.com with SMTP id r13so3744645ioj.22
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Oct 2019 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=//5Om/XvJWZ+udEKS9YxOJkf+X7Db3sKLHkQ/lC+RWM=;
 b=o54gf+5aWdKfvI+AHUNpNBXeNjtTe200eLPmyr6FlwG3dJE2vLTfRwjsOBV8E1/65K
 IwO6CN5sWE3V73+pnV123sFvgITRCD26mt+DHCXnWKuj5heDgJDIHnjBAv6AL+z9Py3X
 4OMQvnkpWMPCLzbKKyoxRJLLWMrjZ9UjGJCPMyugBqfTDjS0hQ89G7O+474TB+UAA2NZ
 3soNbJs2d7npdXHKIhj93Qugh9DEbg7pdjH99OWrgaJY+GGkRDRKfAnWnlZVsmgeMne8
 cIDHvfZPbuyO+MhUyOrCSJLwv6MA1yJZXyy9SiyZUsqUPb3/m/srQcmTAYb1/xoSGuPq
 mytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=//5Om/XvJWZ+udEKS9YxOJkf+X7Db3sKLHkQ/lC+RWM=;
 b=d5++ygukDqNGySNU4nyQC17RZafNmsynnsD4Dn2hUtembJAb52W72EXAseCvBcqEcZ
 eHnwgeE8h8QlJha/7gcHAZ7r9e3Hl4xXrzXhX3rSrAJ0qWx2UOTY+JV17VOZ2dEHWetG
 LUEd4Ct1GNPXtOZsa42RObbxsPCtnvhzZG2Xlo6CafdZ1DgDqxWfcNdJA9J6Il5hKlX2
 /q2HSqcrga9+XjFwU8Yq2MlPbsSExSEyxGQG0Mhs+osfN1jOlyJrTgrwSJaYUKj5Fru8
 iDc5TAhonMmBTmP7+6bLkGKpheC3CZ3WJoYNrRFWhhi4dz/ZIdqTnbtuh4gFsz2jnSKN
 3KBQ==
X-Gm-Message-State: APjAAAWzbBMZ2+WJuJu1gc4gc5nM5DxEnJDJC9eLTlDsX+RU7pvPQI7E
 CyOysdRjhVvfaMO997JLfx042dNzoB/A85asQ1s=
X-Google-Smtp-Source: APXvYqxX6Bw7jJd8SeEqXgmezuewciPrpKwID/S4IXEyDLLyKeZpW5yRhwJ1SU2B+wrojPsFSueCrn1hxoyFqMenH/o=
X-Received: by 2002:a63:495b:: with SMTP id y27mr1959951pgk.438.1570591225171; 
 Tue, 08 Oct 2019 20:20:25 -0700 (PDT)
Date: Wed,  9 Oct 2019 11:20:19 +0800
Message-Id: <20191009032019.6954-1-huangrandall@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
To: jaegeuk@kernel.org, yuchao0@huawei.com, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Headers-End: 1iI90I-003mv6-K9
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid memory leakage in
 f2fs_listxattr
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
From: Randall Huang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Randall Huang <huangrandall@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_listxattr, there is no boundary check before
memcpy e_name to buffer.
If the e_name_len is corrupted,
unexpected memory contents may be returned to the buffer.

Signed-off-by: Randall Huang <huangrandall@google.com>
---
 fs/f2fs/xattr.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index b32c45621679..acc3663970cd 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -538,8 +538,9 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
 	struct inode *inode = d_inode(dentry);
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	struct f2fs_xattr_entry *entry;
-	void *base_addr;
+	void *base_addr, *last_base_addr;
 	int error = 0;
 	size_t rest = buffer_size;
 
@@ -549,6 +550,8 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	if (error)
 		return error;
 
+	last_base_addr = (void *)base_addr + XATTR_SIZE(xnid, inode);
+
 	list_for_each_xattr(entry, base_addr) {
 		const struct xattr_handler *handler =
 			f2fs_xattr_handler(entry->e_name_index);
@@ -559,6 +562,15 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 		if (!handler || (handler->list && !handler->list(dentry)))
 			continue;
 
+		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
+			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
+			f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
+						inode->i_ino);
+			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+			error = -EFSCORRUPTED;
+			goto cleanup;
+		}
+
 		prefix = xattr_prefix(handler);
 		prefix_len = strlen(prefix);
 		size = prefix_len + entry->e_name_len + 1;
-- 
2.23.0.581.g78d2f28ef7-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
