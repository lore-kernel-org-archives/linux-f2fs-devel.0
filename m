Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F7EC41513
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 May 2024 15:31:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sBynq-0006NI-Gn;
	Tue, 28 May 2024 15:31:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1sBynp-0006NC-28
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 15:31:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x5lfjctJigBGlBdl8aX6S4ibrqak1L+cG5k33co0IgA=; b=m3XIvmVbiZp7eqJkMMRbL0x1Hf
 4LUekPaqhqtf1Z9DN6hyZqlT2NPIRMLx7zZvxQXm4ybKUIuWV+eXMqp0ECNfx5OtfXkRSXkjJWAwD
 k8hxbXoXV5k3JsTnjDrRVZrBAeJTfiZD0eFW5B9dZ0UNKHJ9uG+JZufe/dAL2gC2DFxc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x5lfjctJigBGlBdl8aX6S4ibrqak1L+cG5k33co0IgA=; b=c8Iwh86u17GnveSrMOxMmCH6j1
 T9O3Ll2Px8tic7kPrnVh9eWYcz32kZ6ubq2FRUsCU4grXqhTUAihsGCpsk6BynRVLhURFVZt3BdnP
 gLgOY609cAN+Z0YBOtztrIHl8F4bGzn2/lmMYvrxU+3/Qjj4OrNX/caUJ3CYbc4AUZXY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sBynp-0000nP-HT for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 15:31:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 34D3FCE0A55
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 May 2024 19:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EE69C2BD11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 May 2024 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716666359;
 bh=x5lfjctJigBGlBdl8aX6S4ibrqak1L+cG5k33co0IgA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=WRnxe2qPEGJ41ztLtiiUG+o484xg6LT6maRUJkWrKsxA25ndJ2XtgfdJip5ec3QRU
 hVUgXHxZc8/31WRgCUL9yAKLz/EN3wfhdKWa2K+nXcnBIamGgGNwIsuiwExJDyvYEU
 qyMFRuAN/GXeCwThxZP4Y1JA75CbdGP5WcP3Qb7DzhMrnOax9Au8b59InDH4aFdOwu
 GNjfLpm1TVob5ZUchqMDE6+nyNuxmPUg//LiQ+vwbBhsdy52qS2Xo5a5qTq0UueJjd
 Rrfbhxtg1TjonCRtqiYxC6TWZBFw9mWjofQz6wTI7adbJq5zn50vc53Vh/+cEVt1cT
 j8beZDI4wpQCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 64297C53B7F; Sat, 25 May 2024 19:45:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 25 May 2024 19:45:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218770-202145-txyoQWQt1W@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1sBynp-0000nP-HT
Subject: [f2fs-dev] [Bug 218770] fsck seems unable to solve corruption
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

https://bugzilla.kernel.org/show_bug.cgi?id=218770

--- Comment #13 from Jaegeuk Kim (jaegeuk@kernel.org) ---
6.9.2 will have the fix.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=b863827181d80ae33f822dc74d32e377737858c2

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
