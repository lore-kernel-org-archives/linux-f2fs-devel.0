Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6BB10F9963
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1HoVkDTL0T7S9hRXRbqkoWKIVDCuGJ8XQGmQlsYCTs=; b=mQ81p3bMPlo82tPTKCd3Y7y2LX
	SEuLqLgYP1F9JUebNO3NH4hUqLszVicDUFYom5UbLcWsu4C4av7oq+OD11AdjID3WkiDYoj/KiCly
	bKYSV38TxhrzHchjksJtaTNl0hTW3YX0+WlayH+3soLA/AmcZalUBDZTUmxOm9mAR6cs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wAXOy-0000cb-PG;
	Wed, 08 Apr 2026 18:13:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wAXOx-0000cV-QM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Apr 2026 18:13:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O6RsDu6HtXmFCjennut7ksFIWRY1jX3Ooy5GPn2CdMs=; b=iK8yXVTJNU/NBz5i2uhOSLq/YJ
 fFBTZ9abCATcHMP3uwOrAGOWwjhE4/ooCF4Ca1b7yhCUnNkEFBqzaiazl5y536NNTHmiKwQSMb4nc
 M+pgvvHVyxr74tq3gx3olVaeGa849oURrKlCzcilj1UIgLyvu6OXUFLVzwpaOPUHLPVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O6RsDu6HtXmFCjennut7ksFIWRY1jX3Ooy5GPn2CdMs=; b=k6LL28HpuILbJt2Fy5FsJZGW4X
 qogWSnZfMf2apx5vUb8o6JfTX2Osh6EGlPBem8xXP661ggJqAtW/wYhZsPNKpG2AOiKPv/wl70Ohg
 IjzLW5dmAXhCDXUvU7yy+xBThx5JPKb/QclCBn2bn2lO3IYOBPYTiad3I1dXsjBEJE3c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wAXOx-0005wa-Ch for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Apr 2026 18:13:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 96587600CB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Apr 2026 18:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314A8C19421;
 Wed,  8 Apr 2026 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775671988;
 bh=dqzQLKq0cVpjLfRqGnLvvW4jDvNvFUXj35X1JhYiyCY=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=T3VD4OlTVJQEe70UJ+HwyjJFbFPq5h46JHgQM6YJbgjBjSjFMGrxUE29Cp6lNVTSU
 4B2vKBDQ3h3FxwrwXzMz2hTL4WCJ8V38vX5ALjlPjceiVwMNeXHsbPINdS8GKSIDGJ
 f/KCn85XS4Bx+k/Cc4Sfh1l/zkxFL89ukYsLH7dBOKZpusQKi4PCbw2BIPeMdGLpwM
 MTepnklb1tATkZgAUZisCO5U6mR95aTg2+aEpM6ige+vH1ZKmYH24aw72HiyKyqimp
 SS0DBCYVp8aFlZbyJEXPivbxTPNvEcmtGoDOpsjxwWr7s844LuQIla0g4bcWg/Ajh3
 qnurIJM3ugO3g==
Date: Wed, 8 Apr 2026 18:13:06 +0000
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <adaasm42rLxRY2GN@google.com>
References: <20260406154940.2407853-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260406154940.2407853-1-jaegeuk@kernel.org>
X-Headers-End: 1wAXOx-0005wa-Ch
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: do not support mmap write for large
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

 - log v2:
  : add comments 

 fs/f2fs/file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c4880f24b54..c0220cd7b332 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -82,7 +82,12 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	int err = 0;
 	vm_fault_t ret;
 
-	if (unlikely(IS_IMMUTABLE(inode)))
+	/*
+	 * We only support large folio on the read case.
+	 * Don't make any dirty pages.
+	 */
+	if (unlikely(IS_IMMUTABLE(inode)) ||
+	    mapping_large_folio_support(inode->i_mapping))
 		return VM_FAULT_SIGBUS;
 
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
-- 
2.53.0.1213.gd9a14994de-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
