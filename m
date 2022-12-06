Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D021AC352A1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Dec 2022 19:02:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p2dD0-0002aC-80;
	Tue, 06 Dec 2022 19:02:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1p2dCz-0002a5-Ae
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Dec 2022 19:02:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g/5KRM2pSYz2IsKusQQn4dZqp1orWBzIfwQZPqU+yKM=; b=DtCeOVgKJRCJ1PtI30OtA2RrPm
 33TNGFD8VUPFPtXzYVD8HpFY+MuJa5OcgHkgum9lQz1K0j8VvMajSUM4yLsNVClDvV3xISsG5cHoy
 ANycLsFY+Heoz5W5VH66wecW6n1VnJgS4yoNciMjSqIIW/HN4stCci45agPIc+QkFkV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g/5KRM2pSYz2IsKusQQn4dZqp1orWBzIfwQZPqU+yKM=; b=R/BqIssLiAaeGdQjGY5su7dvMl
 Cl0Urj4l/TAFWO2s1znSTb/kNS4bYUppyu6PytIpuEsot5f3ze0zTDotK7a51sFl4Wn6MkPlv694C
 kCLsCCnLqS0IXK4ycFUdGR38+b6Va3c1p87/DtTHTQpXYdz8FBKpM9QGRjGsoETCbxaA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p2dCy-0008Sy-LJ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Dec 2022 19:02:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 8AF3BCE1932
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Dec 2022 19:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7C87C433C1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Dec 2022 19:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670353332;
 bh=g/5KRM2pSYz2IsKusQQn4dZqp1orWBzIfwQZPqU+yKM=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=CF5D/VG6Ti+sBTY+QsQN94jZhpG/Pm6wMxkR5FuMi8dG0Ew672de0ROChnRhUeJVt
 ECSePuWfsX6L6Kq2TmzSP+N8XNYXJHG7Qi+0ZWCNikgjQmpWdOXB2nA06aH7ofQy0z
 ZTnYIThWjL+LZlYr6v6+CrxwqIlvj/aFLaTLaDuMQiZLLRrZzyo9gWWVPhwrXRb8Lk
 9WyAF7t5KCprxtHlOIrWVGLWARV7hXr0LGTaOiSOW7zEOBlkScS+vrlfZl4J6HbBgW
 XQTCBRh8AJ6ugWR6ApxBagdfDq8j9Jvz1u6HRtSivVQ9PMAFVSGhgFrjnJ6f2ex/Ku
 z055pI4FK8TPg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id A60C6C433E4; Tue,  6 Dec 2022 19:02:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 06 Dec 2022 19:02:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bogdan.nicolae@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-mFmx8pNcyc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1p2dCy-0008Sy-LJ
Subject: [f2fs-dev] [Bug 216050] f2fs_gc occupies 100% cpu
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

--- Comment #103 from bogdan.nicolae@gmail.com ---
Guido, so if I understand correctly, your theory is that something in the GC
strategy changed starting with 5.17, and normally this wouldn't be a problem
for a fresh partition but old partitions that were upgraded may be affected
(and can be fixed by running the GC offline or with an older kernel)?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
