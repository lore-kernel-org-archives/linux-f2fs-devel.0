Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E3EC4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:58:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s1TOe-0008Ob-Md;
	Mon, 29 Apr 2024 15:58:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1s1TOc-0008OR-SP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Apr 2024 15:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bnYX+YVSVvHPAx8ScNj8MCXTStKuAKrAa11vyHOlnGg=; b=QzpUK/Zbhm40loDb7aI8CEt7+O
 MU5bAStKNkSyuamdjiXGXrcKmJzLjLukunzoIXOlBXeYZV1I56ji/LNHoUkFr6nChb+D05Li9iQrH
 CafBOTXFP5WS053yoTI7U9KQa1/eKuG/8iZsvqcP3S4xV2a5kemTEm5Fb2++abbwrQpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bnYX+YVSVvHPAx8ScNj8MCXTStKuAKrAa11vyHOlnGg=; b=HriH58/dOcKQnwDKsEQNI2TarD
 QB+S1oOJrKBZISFUU01/d8j4KRKaNgVv75X/+TbgPbnsZKH+zXKE2ZCJthfHhg+vD3M6xNKePdMnB
 AcReufWILFjWln8RCUi71CjWp8dIn5eS7QUF3sF5hybA6tThlUkd6mYRq1MTYZxyIfZ0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s1TOc-0005wu-51 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Apr 2024 15:58:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3B66760E92
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Apr 2024 15:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F189FC113CD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Apr 2024 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714406301;
 bh=bnYX+YVSVvHPAx8ScNj8MCXTStKuAKrAa11vyHOlnGg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=ZqD5bTbTVxLEvxdV3rgOa6ViuaLzq9gt4dcCvDL9DXOEfMJwURjBZiKZmfiRfgD00
 7wJ+fX2xyk5z2n+FuwI8u8gRYGtDmf+ofnfebucGzKklag/K/RIBX+ViqAaViDMNIw
 XWjr3WTsWAcN6p07TIWVJfuo59s1S+5lWvuielHR/qjPoZYUFTC7iNt2HPmjN1kVKj
 NgnkKk1UiWgFSwLjgoWL0JpOMSrUBiFEZfKnRvIVAuRk/2OIS4MYcrggehpz2vdjRv
 lfSvHa8CvwP41JggIE9wnNJGIRfEo20t8kdS9Rd4rbrXYWwSBj/l+D31q/OHhNXQ/9
 p55uLCMVADrNg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id E32A9C16A72; Mon, 29 Apr 2024 15:58:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 29 Apr 2024 15:58:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218770-202145-XWaZlWBOLy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1s1TOc-0005wu-51
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

--- Comment #7 from Guido (guido.iodice@gmail.com) ---
(In reply to Jaegeuk Kim from comment #6)
> Thank you for the report. It seems I need to reapply that patch indeed.

Does rc6 contain the reapplied patch?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
