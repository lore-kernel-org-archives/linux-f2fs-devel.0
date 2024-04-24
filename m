Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B316C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:31:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rzgSf-0000hG-8H;
	Wed, 24 Apr 2024 17:31:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1rzgSd-0000h7-QE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 17:31:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qo7bSI5eu/bifzsdJw79rgRE6bUPHVxT8ASBlVIVyKg=; b=DISmpVkO8i+KJJoEoxcELflKVs
 3Oh/zt2xDxtBAa65+FTwro4pVU1IAenIe9ugz5GhSLyqM0Eo5eTLREgcQjZcda3VCAd+6Dkxinley
 8+vFk1+TeNWB3On4WAUhazZJbHCbVzf9jrx+jg9vb31uSextxCycfIeEGtxwDD0rhoxg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qo7bSI5eu/bifzsdJw79rgRE6bUPHVxT8ASBlVIVyKg=; b=Vij4XlkEfuHivXQo0/JNoWXc9Y
 VFAklTbSACx+zWddftoZ2QBdujscBSiqNZ48pD1kZIIw74Nqkb0Q3JHLiNJBYp7Xw3JTMKLtgWr+u
 cEzkci8tUqF8f5Sjy/T563DEqjF8HdX7SftlMLUj0knsqbjs6NPst46ON5mdpEoEq3rQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rzgSc-0003Gg-V5 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 17:31:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BD11461C2F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 17:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 211FAC113CD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713979860;
 bh=bOttw6+xmIbTGFQO9Aa/8n4k7rukx1rhPW7DRuvpjxk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=gfrTDf2WxONDg53tqgam9X0vQpzJB0Fk7v9eLhf+0YnAOENLqK0DiPRepPJBxQ/nE
 yO2+SHnUAQWPiKsJSR5+drDdGAfnCVhPVNi1VQnZhoRdp5gizqe6UiEmsPoWRdlIUw
 0YvfNCww4LWVEQEeVbHsdsulLU9WmYwb6EvYpI0F7XsZ+mUi5wEQpfHym99KzegvfD
 rJrYW01YpSdRXPujMEkKICfQLpJBhVsgo8zuwN3G9N8a4SV1pdKQN598yW1Qote+ZC
 P0wYVutSYVpHq5d24/hD5wmt3EKdRtlP+B3lzATACv4STKPcMP+d/IdUcqh7+sdg3Z
 FF49GDd6UlMvw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id F2514C433E2; Wed, 24 Apr 2024 17:30:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 24 Apr 2024 17:30:59 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218770-202145-IT4HtWQAbu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1rzgSc-0003Gg-V5
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

Jaegeuk Kim (jaegeuk@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jaegeuk@kernel.org

--- Comment #6 from Jaegeuk Kim (jaegeuk@kernel.org) ---
Thank you for the report. It seems I need to reapply that patch indeed.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
