Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA94C25B78
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 May 2024 21:42:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s9Am4-0001lt-Oo;
	Mon, 20 May 2024 21:42:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1s9Aly-0001lQ-8N
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 21:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oV+EZE6BOSm7W/204sMlEB7zawNydnr08nGsCNsQH8I=; b=PvXTk8Z38pBAo4M6Kd2L8tBXgm
 O5ZlCGoQAfVaFyZGJacuhf789j80zPF4ErHMiK2DogD3784v93zRBBatWOBWa+ybcca2kO4e1IQw+
 sA1AYSx/3VTH/oCMJDpYvBZmFLyQ7M+6MXIF1Cd3KBH3PQBBFDZkYyC+LaFBX9mfIxoE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oV+EZE6BOSm7W/204sMlEB7zawNydnr08nGsCNsQH8I=; b=F/Z0Yr1/N8EewvtpGKu/IoJGp4
 oOBg5UrN0y0470r3Fcm9Ev4TM/U0lqwHT47Cm+GYq1xvkZVRu+1ouh/3YZ82uLj2yr2gOOGC/BJFW
 Wqx73y1bYQLUw7xuX71LPRfOxGrIVJE/kx40HZTFJMkFc+tJcskRrOGs60CwwRz26s/g=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s9Aly-0007Lj-NU for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 21:42:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 990F66140D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 May 2024 21:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A28EC2BD10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 May 2024 21:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716241331;
 bh=oV+EZE6BOSm7W/204sMlEB7zawNydnr08nGsCNsQH8I=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Bi1m5JaFMBM0B3O2BhkuCDaODWhuclU5ndXlBsgkv3r6GsWnEP35AXvdfM6m8vUV6
 wj1h/TZZ+MfzXCwoCWcZD1zgQeM6l4s1VOe/tevkJgO8Po51NlAkV0mF5gaJGnTcZa
 EXdOfglglJsWPY9TY13u8PPNh2pfoanCVlQjPJwrnLzt3qd/xBWZs8tM73mTShXl0q
 LR07BoMfP4HhSVIgggzLRRX7jiT1jQ4qgAI+znRG7pQDO8t+WwhWwLVWP6Ig98boLB
 w67UzK8akc7VbN1x1f3ZlYLzjg1tousgr+Q/5/ssF4/N0y7WFA6lyQxAauEPUK63jZ
 YJi/olYmN0yGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 2C8B0C53B7F; Mon, 20 May 2024 21:42:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 20 May 2024 21:42:11 +0000
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
Message-ID: <bug-218770-202145-67zp5nkpFj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1s9Aly-0007Lj-NU
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

--- Comment #12 from Guido (guido.iodice@gmail.com) ---
(In reply to Jaegeuk Kim from comment #11)
> The patch is in the next pull request.
> https://patchwork.kernel.org/project/f2fs/patch/ZkumXs7POGImbr-k@google.com/
> 
> Once Linus pulled it, I can ask Greg to queue it in -stable.

Thank you!

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
