Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522F6E7717D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Dec 2024 04:14:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tLE71-0000yU-LU;
	Wed, 11 Dec 2024 04:14:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1tLE6n-0000y4-FI
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Dec 2024 04:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E845ZvasqAdOQ39QWr8ru+DgMP+li8fP9t88YsmhgSs=; b=QYHPQcs5bzMCbYobblAiQjxxpM
 V/DyR+CiwjeHyS45MAmp+URC1dOU0DUNbxJwkqyMkrs+m12gPabZYvvn5RpIBVdorL3v6hjkTegPH
 z2fSbbvjNk2GJJfEndFSMK6e4HByz5VO1iimXgsgAZSrasB97NLHRHmRTlOgWTLf/1pI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E845ZvasqAdOQ39QWr8ru+DgMP+li8fP9t88YsmhgSs=; b=FIgCQd7PWXikxd9Qz/31ASm9h/
 kenvYSEVgVVtcxIf0gOzCKymGLppMbiY4YxaOgXL96HS8Se1mKDSYsUA09Un9fleYgu+BrrA7wCYZ
 lUZvZKTsIiNSQ0DPEHG9piOOb4Bl04H0j76gLYpFupihLCqVLqAaYKaQmQ4HtVqZ5808=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tLE6m-0003Li-7B for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Dec 2024 04:13:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2DA66A41DA6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Dec 2024 04:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D045C4CED2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Dec 2024 04:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733890425;
 bh=E845ZvasqAdOQ39QWr8ru+DgMP+li8fP9t88YsmhgSs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=kxdg0Yv6oG2z5T5/VQylFcfxQ83Z2I/qRmyX3KYBEVl9wRqCI6F8SB8Shgt7h1OY+
 Q0HxTx/eVozJXNjO9nbNI/uzcKX8ugntzkRh9GpB7Wlec4LCQpxqMrdHe9AdkqFJOF
 iVFa6p7/87s09+KyJz1szxmHOvftHZD9R9hZOgdh2Lwbh6UbI6ML8EakTGemchpVYx
 6MBvsDXZgl9DVTlA9innwFS0wqTXBtgWy8M9E7AWwT1m+vFPMxuds5WUKg1a7wOyIZ
 DGww621/f9ctWzdHlwYz8xyJpQjdFKtyAaE//vzEYW8xb20EqUNrAcGtmykQRuHpr0
 b1enOflomkBSw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 234B6C3279E; Wed, 11 Dec 2024 04:13:45 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 11 Dec 2024 04:13:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219586-202145-XryfVczufq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219586-202145@https.bugzilla.kernel.org/>
References: <bug-219586-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1tLE6m-0003Li-7B
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

--- Comment #3 from Jaegeuk Kim (jaegeuk@kernel.org) ---
IMO, you need to revert unicode patch.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
