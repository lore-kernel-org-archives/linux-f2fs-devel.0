Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A1DC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 May 2022 23:48:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nvp7E-0001rX-7E; Mon, 30 May 2022 23:48:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nvp7C-0001rI-IE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 May 2022 23:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TSNc1nhRiXoc4rCrUlsYlmagcWFslIy0sI0BhMNtrGo=; b=db+IoMLaxDXRuCxbYIkNeZuPEg
 jjOhdqykhs02kjB+ZN4gJSx0EgR4QcbXseoznkrfGYTmNzNsnM0KPVf5hMOfWNPbouMyYv9FO4tMR
 0vHfxfJDPOcMo3YvqHArj20wU5BPyw7o5Inq+gtssz8954R9hJHEr/lH5eVLplw8H2Zk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TSNc1nhRiXoc4rCrUlsYlmagcWFslIy0sI0BhMNtrGo=; b=lq6WHfNoNCw2KyMogiVJWmf2DH
 pAWjUKnlJqBh61e+W4NlH4gj8ebKWhvJNuKaBOVYERE9tEgR7iGlWBAOWKWP71SmMKFAkq6BKtmle
 CgC2Jbte1gNdjCZ2EG9aqtPYDbwe0doQQYnh+rj34A8kGy+wD/0/t8BX5CbRX59KIS4c=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nvp76-0003ZT-GZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 May 2022 23:48:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8A9ECB80E72
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 30 May 2022 23:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46AF0C385B8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 30 May 2022 23:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653954462;
 bh=TSNc1nhRiXoc4rCrUlsYlmagcWFslIy0sI0BhMNtrGo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=P5McZ7hTn2K9DPnj+qldTID50yX+UwtWkWdMEnD6nGwlQHrdiYgLLlXzxB3kfFxJ8
 0GZBWTgZolXFGT9iyJZRr2XGpCjoQiYMo6oOxpdA6LnlPZwLnO4ua11mPQyGGgy4Vj
 gGT5TSy2iRFOGvbFEUDtxGOHOUgbDybZXmZgazQHxLgb/Wi74km8aCWja9ziHwbHbV
 qVESMcodRDIg6z4xmecCHTOL7DYd+U6hpG8HoQAoMKxcMEj2X8w3fCqG8SKm9s3pDL
 KsZUwrqed4ppXr/6xDtnB17GajYj2TWAYMk5vgzC1n0QX+FIP5mkoKR6cSotUO6e7/
 ZtMLvxiI5SC9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 2A212C05FD4; Mon, 30 May 2022 23:47:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 30 May 2022 23:47:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-dzOsqgXLVU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nvp76-0003ZT-GZ
Subject: [f2fs-dev] [Bug 216050] fsfs_gc occupies 100% cpu
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

https://bugzilla.kernel.org/show_bug.cgi?id=216050

--- Comment #2 from Guido (guido.iodice@gmail.com) ---
my f2fs mounts:

/dev/nvme0n1p3 on / type f2fs
(rw,noatime,lazytime,background_gc=on,nodiscard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,checkpoint_merge,fsync_mode=posix,discard_unit=block)
/dev/nvme0n1p4 on /home type f2fs
(rw,noatime,lazytime,background_gc=on,nodiscard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,checkpoint_merge,fsync_mode=posix,discard_unit=block)
/dev/nvme1n1 on /run/media/guido/nvme1 type f2fs
(rw,noatime,lazytime,background_gc=on,nodiscard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,checkpoint_merge,fsync_mode=posix,compress_algorithm=lz4,compress_log_size=2,compress_mode=fs,compress_cache,discard_unit=block)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
