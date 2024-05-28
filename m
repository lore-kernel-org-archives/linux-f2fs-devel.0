Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0597C25B78
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 May 2024 16:56:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sC07z-0003RI-6R;
	Tue, 28 May 2024 16:56:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1sC07x-0003RA-CF
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 16:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2wWwUKVcwZDU7LxU5nidax6T8iaFOi1QYdTQ2mCCdlA=; b=aDIXh+H59J8BmgiDfgoowBAuRd
 GXhI5KvpNw9YyOqNcTJMOQOhHsG2Ls2SBXU9+wCZgP/mex4Rd3zQGlOofM6eurw21zyaBtfFzj0JO
 h7wu1b+lFsLhqBbnSZ+Fzt+C9dIWZZAOMlRGlFGGJmie6R+mFddAMRZ+itF7LZQeYgak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2wWwUKVcwZDU7LxU5nidax6T8iaFOi1QYdTQ2mCCdlA=; b=C5ccFQJo9FDBKQXtLiQmLdYvgN
 +QHpveCB53cJwN5bEXqU8O59xc4Kgf25lxVydNiqoHBnx/blRV7CHYMmsBTNKXVUJ0MBRhYu4axWB
 66JlVxAWhxuYHrEWBWx5N0rNM3MiEfC2uaGIQkYdjROLVw3NoCQqqrp7Q0VrBvC4I3zo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sC07y-00089h-OC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 16:56:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9C6D662290
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 May 2024 16:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 512ECC32782
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 May 2024 16:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716915395;
 bh=2wWwUKVcwZDU7LxU5nidax6T8iaFOi1QYdTQ2mCCdlA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=tNcVcgc0NXqkTtI0b16FttIYqDqzdyCPMGQ0uuScGhJM0mkUREyGvS5WF5J/sdEnq
 RqrgyRcjZOuB6wGlaF3UFbObXSzlvpB2KR1VcCKmyxaG1Fb00j9rDqn0BxRA1Rvkl2
 i1IidQEj6lXxYPGFYWacDdM7OV66JwzIpolZyGMd2a9fabmDCmqQG+Fo6JWD5YUpx2
 EB64LdlxVnwFe31E3H/6MdzfyAQhiDIxJmMbGbvAsbZ4eMDW78irDo6SsWuyumDc+7
 uLmn2n6KoaYLTRV7Kncp5ZxuEvWH1oupnR6iLgqfTm9xDQa7DfeeU84BXp5ALSuMRL
 DHPYOZJ/yYHnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 41D98C53B50; Tue, 28 May 2024 16:56:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 28 May 2024 16:56:35 +0000
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
Message-ID: <bug-218770-202145-eDfxBsk6OT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1sC07y-00089h-OC
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

--- Comment #15 from Jaegeuk Kim (jaegeuk@kernel.org) ---
correction; 6.9.3-rc1 has the fix.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
