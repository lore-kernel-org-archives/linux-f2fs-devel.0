Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB465F531DC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0oqhDRVp7HlicEcD8RdfDpC+imq1vVdOse9OYEUQZSE=; b=J+C4tHDKvBTCDqQnb+d2UhGJ4L
	Gf09v0in5Wl+dC94oIfc0f6mcymzRTR66MpLkYQyMGYoEhKTsJKwiK0AIOeltOcS7UVRXsUJNUXx8
	sGeMKVwlJIvPBSB6OW352alzw+GjxBx3vgbDvzbqKkihIwE9KJ2WZIZzNyKy7LChQXFk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCQ3H-0000CH-2l;
	Mon, 13 Apr 2026 22:46:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wCQ3F-0000CA-VG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 22:46:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ed6NjF8u4DKfs50ZairXzX8oJdI9IJ6y8PSMQ8MJQK0=; b=R5tChF/K1ysZSV/gHGTir5cMfr
 R7MZgwJ9829MgeitC/+HRUAF9mLVF255TsmvmNMy7LJXKfmZTW4QMJbpNRmbBnWsr9LFVumj0QAy/
 63jpi0I5uPu620NeWGbN7GOG5wAXepIug/AspjkZHACD0Mi3F8CX2dd4gPMDrjAFl8j8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ed6NjF8u4DKfs50ZairXzX8oJdI9IJ6y8PSMQ8MJQK0=; b=eFOwxYXAPDAtpieMdiHurSd/Oa
 jFsxGWHD2SD2RgxjOnyw9sL+S04pT3CqR+2cdIil2qI44shbRVcv1+tVIkPqMwL8FmsRhdnbx1MUf
 STHjW3bELMM8uGu27xXIzmZP57XuqapYfqguyufyJxidsbVTcwB2tjCRnNl0COY6Q2aA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCQ3F-000564-J6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 22:46:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 36FBC43674
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Apr 2026 22:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01058C2BCAF;
 Mon, 13 Apr 2026 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776120391;
 bh=uSNfWH9CexRDvlTXr+w3luyUgQKOD+ai2y34931n82Q=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=PKV7TAIiy0JVDpUk0FS2caf9bsF9AEoLbaJyJjQtklB2KRXDhgJsbs2dIrU4GZBlF
 Ypavspx0BewVfd4k5XDktLvw9lmz4NQaOt0cyhJBqteNmNe38cpI5IaHBlRDITH98e
 Z7uCoEYpc/hQLi16WTtZntL37yaVsX7Qg4HoZDtmEWJRnM+b3cY5k1L0C1fytNkg6o
 nk6pZkZP5Z7BsSlhh0OWUosZZmuwHsxFsV5dcfdEZkj7e40Ue17HjvvBTSbSfx7k4/
 HI3UOV6OPTMn80g+w4AEj/9a6DXO4dsB7RYbxjDkDJSkW9P9HDWla3v2wAxuLjqBj8
 l9x18ewim58/A==
Date: Mon, 13 Apr 2026 22:46:29 +0000
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <ad1yRX54HIx-PAf3@google.com>
References: <20260406154940.2407853-1-jaegeuk@kernel.org>
 <adaasm42rLxRY2GN@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adaasm42rLxRY2GN@google.com>
X-Headers-End: 1wCQ3F-000564-J6
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: do not support mmap write for large
 folio
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let's check mmap writes onto the large folio, since we don't support writing
large folios.

Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 - add f2fs_err to catch any issue

 fs/f2fs/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c4880f24b54..e917342cb828 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -82,8 +82,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	int err = 0;
 	vm_fault_t ret;
 
-	if (unlikely(IS_IMMUTABLE(inode)))
+	/*
+	 * We only support large folio on the read case.
+	 * Don't make any dirty pages.
+	 */
+	if (unlikely(IS_IMMUTABLE(inode)) ||
+	    mapping_large_folio_support(inode->i_mapping)) {
+		f2fs_err(sbi, "Not expected: immutable: %d large_folio: %d",
+				IS_IMMUTABLE(inode),
+				mapping_large_folio_support(inode->i_mapping));
 		return VM_FAULT_SIGBUS;
+	}
 
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		err = -EIO;
-- 
2.54.0.rc0.605.g598a273b03-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
