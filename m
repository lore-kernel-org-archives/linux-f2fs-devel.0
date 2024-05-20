Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6DBC25B77
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 May 2024 20:08:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s99Jb-000118-53;
	Mon, 20 May 2024 20:08:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1s99JZ-000111-R6
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 20:08:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ixToW84LOVTDZtNFkxEgZ8H/GJe0jCsOGWRjJq/5P/U=; b=nQB14v4whr4Q9r6WwSDnEEijQI
 pC5UUmrsohz4kDss0NKC02UITW8TgBlcbbpcr9eCi/dUUEVLq57o/L65uJDFTYBWWBtXHIt7d/7Db
 218ZuAkogrTqT8ofPF2jDw6UKANd6fJuR3Itr0ZZS9FvGszkWC573gkDhfud7KhdarYc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ixToW84LOVTDZtNFkxEgZ8H/GJe0jCsOGWRjJq/5P/U=; b=G443Jcr3Mc5zwnS4umjO55INZY
 NBXul8tWPc3SktgCdnNjk0kOJidX+ys66XWV9cgPSd8yGvewIhPzRuelotIKvwPAnoYDWm6TH1aXx
 NN/+0W2FMw3vAUrV7jzmyN583N+3bo69Zd7pvOQL5tGniMNGtCrXo/OKzsoBjgF1YU0E=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s99JZ-0002HU-Dh for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 20:08:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4C45861E48
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 May 2024 20:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 013A2C2BD10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 May 2024 20:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716235726;
 bh=ixToW84LOVTDZtNFkxEgZ8H/GJe0jCsOGWRjJq/5P/U=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=VjiVYKO5tFM5AFUNMyUGEZMr6cMEs6dzoqM21FGIBHcjTBNPGa91u+4blF6iTIvIU
 XQcq9wxzTVctuHJeP61ToWm8pPduOGWK6mdeTyeyIEyY7iIWO8TECJa5PnbWSrzEVE
 V9Px8in6jUcElOiG8GG2Itdlfq/ILrqhzQYeeqnraszxj4AeWqHWuxvua8jrzOp5FS
 SXZWYYi+brG4XOXckpswqtnR6n96LZq6OzZHASJdjNcTypZ15NLLjjOViL4kszeOif
 yQdeNltb1yFpM5FSHP87AXHXdzGyXKh+JQWjaXElzEgcz4DpSM3pb7UbjlDFZq26Al
 tkvCNgZvlS0fA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id DD3BEC53B7F; Mon, 20 May 2024 20:08:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 20 May 2024 20:08:45 +0000
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
Message-ID: <bug-218770-202145-U4j5Cb4Upi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1s99JZ-0002HU-Dh
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

--- Comment #11 from Jaegeuk Kim (jaegeuk@kernel.org) ---
The patch is in the next pull request.
https://patchwork.kernel.org/project/f2fs/patch/ZkumXs7POGImbr-k@google.com/

Once Linus pulled it, I can ask Greg to queue it in -stable.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
