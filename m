Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D014EC38145
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Sep 2022 01:34:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oW6RR-0001Ip-Ay;
	Thu, 08 Sep 2022 01:34:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oW6RQ-0001Ii-Ic
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Sep 2022 01:34:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UrHHAURT5LXHtKaAWZ8lTHCMibD8SJwiWuVUx3G2kws=; b=jaDjxgBMhkOcOLNRupAqUIAzgU
 QBgo29GvS4OkQiwzo6Li6f+MAz24Th37YD6RT2n1aGUgMjfsCagVP6Y/BRjYqDMcFEkhtNe5b8rq+
 W5SvDkX4IE5D9Z6yXJ7fWU6t/euXI3keWONfFOBnJ6jvnTj/YRkyqxAD/Dn6zPxXR9YE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UrHHAURT5LXHtKaAWZ8lTHCMibD8SJwiWuVUx3G2kws=; b=eb9ivZhjFhEwgbNUPg6fmVi16+
 AOsNm83cBIIPqQ1cL0PUmP1Zg/j5vN5IlxY0iw8weTLH6Kx89TwexmoDnidzm0Hz93SFXdJUYt+WY
 4uWDwCdv13i9csjQdeEO8ZxzY3xLUk6+YZ12GMARLvdoHIth7qLRAbvjwmOSVjjWeRfk=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oW6RL-001fFI-0S for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Sep 2022 01:34:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 51F57B81F7B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 Sep 2022 01:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9455EC43141
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 Sep 2022 01:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662600870;
 bh=XiN+ogWcKG76oVRTO4bG4eUG/o0uiVX9a/lPSZ5k6v8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Pbt+f1aSihQZm48FUZdisvEzzzT9hNAzkiIWkQMpl6or6VRtspdY+XMA1DCO4TfB5
 i4Bwriaii4GQI251DCZCmUOz9Zl4tJM5JItyKMcxOiEqjUETS7f4bCdSey6+03iw1A
 OVDwo+Ebfd8Sb5UIOmUUIEvb0N2P9D01crc72JDyIWIG0qbgJ+lLnVDGS4GztVZQ09
 HTaFl50o8efeayxpdnIMjML/EEDwOjg+fcgq01777MMTJC2WmQSNHg+HmONtMl5Twr
 hU16PCx68Vmc0eE9rBwVZXrIsRNDe5SSGpARyT2PqMkc8QXqPqhVjhBEEkTK5Mn32C
 pi6kLaLAaP/1w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 82FA9C433E9; Thu,  8 Sep 2022 01:34:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 08 Sep 2022 01:34:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: zachcook1991@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213089-202145-754qMrtuhC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213089-202145@https.bugzilla.kernel.org/>
References: <bug-213089-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oW6RL-001fFI-0S
Subject: [f2fs-dev] [Bug 213089] Add "pre: crc32" softdep
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

https://bugzilla.kernel.org/show_bug.cgi?id=213089

Zachary Cook (zachcook1991@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |zachcook1991@gmail.com

--- Comment #4 from Zachary Cook (zachcook1991@gmail.com) ---
*** Bug 187471 has been marked as a duplicate of this bug. ***

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
