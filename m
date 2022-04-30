Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3768CC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 30 Apr 2022 04:53:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nkf79-0000IK-4l; Sat, 30 Apr 2022 04:53:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nkf78-0000ID-Fb
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Apr 2022 04:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dHQjwVXuvsU9RvXAykZbXZb1cfCpz6B7NhfniusH6lk=; b=gfWeYEmmStKASFFf6WjU4DVFAJ
 2LlQQxPQfiEYlETK0OjefLJhLjLUkvsTnyBdLv87KhfBryRGVTZP8SGdnwYGota9vrYPkGxh9waDZ
 PVaJ9XbEDp0D9aFwEiDuOF3KY/13ZkxCmMO0NO2LEz5PXq/yVDB8CTVNBdfuRI+Zj73A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dHQjwVXuvsU9RvXAykZbXZb1cfCpz6B7NhfniusH6lk=; b=E3hVwDvBpBCNVQemKkU43lcSD2
 ysXDzLIKCxE5+6ubp+g/TlBnRuQCYZ7ktq7eBZaMig+PTczY+OQ7i1Lw3IyIiqj960NboDjK62EXn
 HN2qfOePLeQ9XKBvdr82yXpRUBzFHcGTRlgZLvH7bq2oKBqJJXei3/eg6w5MBZ/bqEBs=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nkf71-00EYHX-Ud
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Apr 2022 04:53:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D2441B80ED0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Apr 2022 04:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87A76C385AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Apr 2022 04:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651294411;
 bh=dHQjwVXuvsU9RvXAykZbXZb1cfCpz6B7NhfniusH6lk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=A1ldINsXWhD1hPphGR3+hs3QB0CRmAT9KspnMfhU7Z+vsm6G7PBSfzeNhwQn/uxl/
 95cwCo7G8cxgkj28V51Tn7wzYypl0qReVf8Oc8nYdaCGBHKiVBW0o+L+21RiUGU8rs
 7rHlj4YjMSip/ZMFQRfX5Rp0T80CoyCKIUfpZy3A9N+Vi39Eu6SZrK9RbGKGLfezxd
 AYGbyjIuLCut9eJDhte/Ref5Gt9D+rU/ZHTm0S11STEKjcvQkYBdEzIq0z9rS9T+n4
 hXrOmr5H3vqcPyqPaj92gWRsipvVV2Ulof6qu9pqldTpgbY2qrgnapsgYo00bMkx/c
 S7X/zHIKHJV+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6A8BCC05F98; Sat, 30 Apr 2022 04:53:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 30 Apr 2022 04:53:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215914-202145-3QygJCJcjD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215914-202145@https.bugzilla.kernel.org/>
References: <bug-215914-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nkf71-00EYHX-Ud
Subject: [f2fs-dev] [Bug 215914] kernel hangs after mounting the image
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

https://bugzilla.kernel.org/show_bug.cgi?id=215914

--- Comment #1 from bughunter (yanming@tju.edu.cn) ---
This bug has been fixed :)

Thank you for your prompt reply!

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
