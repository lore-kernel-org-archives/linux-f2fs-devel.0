Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29B0C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Jun 2022 20:49:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nxEEk-0004HQ-Oq; Fri, 03 Jun 2022 20:49:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nxEEj-0004HK-Ff
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jun 2022 20:49:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=42sEX9LajnXm94h9nUzr0rVR0FipQIP3i9mVTCxe2i8=; b=Bj5R4jUwQYhVJKKF4EJbSiSww2
 BUROBiZUSyuYnhsrpUTQjpyzkdvydnxhtEqvFW5wjmYmJUYQNxjLnuPHrSTGnpQlHb5ewHn38C2ta
 rkiIVb+Cy0gVH6p3zvrHbd1BrPxIfnI046/MaGyECelumy5S5ICjxbvHKuA4QZ2cj+bo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=42sEX9LajnXm94h9nUzr0rVR0FipQIP3i9mVTCxe2i8=; b=ViWq2/S3NSs1hnVwjScZst6Brj
 9du56lhE1v4wURv/msu97Ah7YV1IiE4/AQHKk1UrBjiGQnTqH/Q6+TKVwR63EuFyacGVYy7avK2XC
 yCOm7bPdMMfm4HJX8v63z3vFGh5hcPBIL/IMmtgeNPfLASp4U4IHVqzplHqipXfqDKd8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nxEEh-004A51-KJ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jun 2022 20:49:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 40DA0619FA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  3 Jun 2022 20:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4DF8C385A9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  3 Jun 2022 20:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654289369;
 bh=42sEX9LajnXm94h9nUzr0rVR0FipQIP3i9mVTCxe2i8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=ZhgFGJAyFHTe7tKyTCHcQ7D1LY8fblA3f+7Q6ZpUspmy0fqSMHQ7i1Ap3upN2d1Ln
 yR5nkv8MiAlzdsds3ZFUrVOKywTrsi9L5YRrST3+A/5vv5Dyh1Md/iXxisxYBhP168
 8ti/LBr4H3do5J40xYHHxIG8jQCXRSapcU125c9uyP9XJMMi2+Gld6k6hRc4bzCP4N
 YMn7vNkVr1c0R6rCfeE0+s3nuVZ5ilavBFUjeKLiHhMuWfIP4rl0mVyoVXc+2mszRC
 D/wdAd0k2Lppoc0eC8yRNYJFNRWl4SRJOdwmPL0uep9TsvoeW6Q0QqZZizPeJUDB+g
 fdhAn37mDntBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8585ECAC6E2; Fri,  3 Jun 2022 20:49:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 03 Jun 2022 20:49:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-cI8b9pIvKe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nxEEh-004A51-KJ
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

--- Comment #20 from Guido (guido.iodice@gmail.com) ---
with atgc and gc_merge it seems that the problem does not recur but reading the
documentation I have the feeling that I will see it again in 7 days...

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
