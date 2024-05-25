Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F4AC25B78
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 May 2024 15:31:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sBynq-0002Vk-GE;
	Tue, 28 May 2024 15:31:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1sBynp-0002Vd-5X
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 15:31:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lZaPVPWvc8i7vn0VE7oFzvo8+BiYL/CMtQb7YRel81A=; b=YAQJnhAgT9btGo+ftE3ZB2S4/w
 MtOtbHsRlX/8wtlak9qRYbgJ9WfqolBZuDWkacLBbRd8dQc29GqF8N3GNlzrNUyeX31yfJl5bB6WK
 x/EMbqEQyeQXmjhnrTQAHxNyiPwpQFZq84Rzwj4ZEOP5TpNjfrW0m6sm12uNomVZBTyM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lZaPVPWvc8i7vn0VE7oFzvo8+BiYL/CMtQb7YRel81A=; b=HJpmv8j7O/OmRT71bgl/gGNZMC
 xQHEWwM5KCYSLu3I5yUAIZalK7K/x17HWp/LWEVwcjJuv2mM27TK313BULblkHqqTZZ2aRgqb4TMw
 bskSddlNNFyBJgSPWLUEm+MA0n4aQ8DZWZnNK7opsdsnRTxecf1P5NcDCPK5VpLnPp5M=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sBynp-0000nO-Gb for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 May 2024 15:31:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A2D99CE0A53
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 May 2024 19:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8A2AC32781
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 May 2024 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716666305;
 bh=M3W87A9WiGc5xhat85TjFYhjcDYTjNTQIVnUkacGQs4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=JHpXFqj+avSULRoW6bVM/22FYdD0rTMltjp1zXxGaN+iRDWWf0FdgrqdrygUYIvEo
 h3N3XPoRTM8MJPeB6FeR7C/5PxJdjgREv4etw+n49LaTIc2r9j2OZJUAPPqcJLDtE2
 8utfDVYAw4UniAl3RNqo1zLJchNLipFyBxEFtCoGnZtd7YA44HTKKGzCbeG0A/al4g
 upo/Y6YbHFrVYFhhq59eE65lCYTRODgSDanlF6RNDc1Kk5qEbOzo4I1hOIxf/3+JSo
 HXjBNXN8xpOoSniAKYw7v11X7n4rdxBrTlXehO2uJT3kuQfGvzUxH68NymmScoEHVr
 RyE0B1ml/krow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id BFEF2C53B73; Sat, 25 May 2024 19:45:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 25 May 2024 19:45:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218870-202145-X77OQbJQ8u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218870-202145@https.bugzilla.kernel.org/>
References: <bug-218870-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1sBynp-0000nO-Gb
Subject: [f2fs-dev] [Bug 218870] F2FS mount/unmount results in
 invalid_blkaddr
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

https://bugzilla.kernel.org/show_bug.cgi?id=218870

Jaegeuk Kim (jaegeuk@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jaegeuk@kernel.org

--- Comment #5 from Jaegeuk Kim (jaegeuk@kernel.org) ---
Can you try 6.9.2 later?

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=b863827181d80ae33f822dc74d32e377737858c2

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
