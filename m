Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBB3E7717F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:39:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tLej1-0006A9-Ns;
	Thu, 12 Dec 2024 08:39:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1tLej0-00069T-3t
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Dec 2024 08:39:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lPigq0T7QIS3hMN493FLQgBmYDD1KoMY3YYKPR83NHU=; b=dZ629bdC9c2EF9IeT8jBS3vXv8
 0J4yW11lgcnyi7qPmOPCBVPrZnJNOLyB7YXrDtaHQHHly9m8lm34Rs1sEUW10UHHMSQXwRRxa+A2D
 CA2h2gGGg47AtiyzAbMNvPPpgJQZ9a+MT4LRQwVjaT+kueVX8u5t19kaHv9C44TgXZgI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lPigq0T7QIS3hMN493FLQgBmYDD1KoMY3YYKPR83NHU=; b=d5duKs0H0I8u0lUJE9uUpwyD2u
 aK71whPqA5MLNHTassTtCiesLKmLRyxlkIYIM3W7l6Wgr5WNHFvOJmFAcqMOc2GvwqPWmx4w3xSSP
 Tc2XglK3f1EOqIKnEYxIGLTCYahSlANlLVfLuYKFPLwUxFH0/Nlk/QcIvVHIIYGGjoUQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tLej0-00035E-8r for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Dec 2024 08:39:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7B72D5C038C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Dec 2024 08:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E0D0C4CECE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Dec 2024 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733992744;
 bh=iD0ugfaOyuhjC7xvcOcDy2bJJ41ed6vV7wrBMfa5dwI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=e4k2oRCaE+6Gz5yNaFGeWsNagdmyWe/Blggt1KQn4XG0QvLsO2Dr8ZCMJ5CntrRv4
 W8i8+CXF6DI7XM5Zq1u70bLhXJRB3f+wBZIsSFr6fJi8xl/8NSHs3DFaf5e4WStwRu
 bNCCcAn5N3kapTNtv4iN3Q9LjVKAAVxxETJpCPlqjl0AQIcj8C3qyFaxLhNwdh4b5p
 1HKMINafLPYNz5WAfRujWuE0R2j6WXeSLUqI6NOmKBkWq2DF4SSORdbjH2rRjelv5I
 rLquDNHgfSXq+y6cO2cJJGodgPtKOlvKhOfFKLfGiR8JUVpCWutu6rQ8Nro15LY6fP
 m4thN5pZLUHsQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 77C38C3279F; Thu, 12 Dec 2024 08:39:04 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 12 Dec 2024 08:39:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hanqi@vivo.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219586-202145-1GF0Lvy4X3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219586-202145@https.bugzilla.kernel.org/>
References: <bug-219586-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1tLej0-00035E-8r
Subject: [f2fs-dev] [Bug 219586] Unable to find file after unicode change
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
From: bugzilla-daemon--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: bugzilla-daemon@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=219586

HanQi (hanqi@vivo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
