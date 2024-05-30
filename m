Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F05C25B74
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 May 2024 10:48:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sCdKP-0003hq-Th;
	Thu, 30 May 2024 10:48:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1sCdKO-0003hh-TT
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 May 2024 10:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gcchDmzqCUy02JKOlxQg/orMu88el+LDETCBk8lCpsk=; b=hhq6S7vlW/yf6u5HvW7DARS2Ja
 lGlqZXSye+nzeSEKWbrvcBJOK3Xs+URIS7jJdHbYpkaKtRiX9Qjdhol6EW+coAA2mXPe8hOe15RPp
 Iy8sTzq9QihVh6kd6LevpSQH1kNiyK/ty6/YCjH0C+ejkxlIsRFY6Le9fvPxyAJrzKAc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gcchDmzqCUy02JKOlxQg/orMu88el+LDETCBk8lCpsk=; b=JkV6x7KUIvfODxSpcO37ZoxCOX
 X6LLBoyKN95ubtc1FcIjDsujsjvAhW15M62kwDMadIYnHgcowE1qJV5P1bdgB9cOSErW0ShHtjnbm
 QPNi+vZAMDrQ5rTwVeIckKXBtRPII5A7h6sSiHB3o9twG1K/UzCssD8FYXAMXKSGmnCM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sCdKM-0004yT-JA for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 May 2024 10:48:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 76F33623CD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 May 2024 10:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C23FC3277B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 May 2024 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717066084;
 bh=KrtmLXaKkOvGlVWGkPtd5HtFi91oSXoe+tMMmp7xPnk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=VcmVdWei5urP0JFIym6UvLiMJpn10pdukKrRLlZVRwKMaVcqZzEY3rwrFptsIeBiN
 YGUFaz8zA4ytpKgBiIpD8eDmYZKvV5oqshy54XNC6KOH+I77+5ICi868OBKZjbsSQl
 /jlhd9+W3o8b1mV1/tHz67MxTg80KoTfv6CmrunesfSFdJmv3viYyFVP4Y7aN1F256
 XJM4udHsT4R8FDnJx4l+maZbth8NxFc5cx0fEecus9HZ+tjp4H+RZ7ZtBLITnzeJfM
 dv1BqU2AHQxpuvFVmDBHpmeB6AbwLFfVml8s1NhN5Guu+f5I9zTi50RIOL8eyZJe2w
 3QLInNQMcWg/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 148E2C53B50; Thu, 30 May 2024 10:48:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 30 May 2024 10:48:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmw.gover@yahoo.co.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218870-202145-gPDpVXP9bZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218870-202145@https.bugzilla.kernel.org/>
References: <bug-218870-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1sCdKM-0004yT-JA
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

--- Comment #8 from Paul Gover (pmw.gover@yahoo.co.uk) ---
Just tried 6.9.3.
Appears the fix is now in and working - at least, I booted twice with a short
fsck, not the full works - so I'm currently a happy bunny.  Thanks.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
