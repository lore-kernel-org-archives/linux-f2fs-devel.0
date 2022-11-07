Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEF1C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Nov 2022 18:42:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1os74M-00085k-Rx;
	Mon, 07 Nov 2022 18:42:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1os74M-00085e-5M
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Nov 2022 18:42:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q27KcdADbzgZzC54xcLkH5dHAjluRVHy3b3TFoyobKI=; b=Lo0vaX3BRD88ppg88oOXxCDZt6
 b4HsSQYof3re4K0QoLkuZyBOuPvwbclAU9D4i2snOG6nBdm/OC43Enn5WmX7frz3laRaTutgn7ZEJ
 uFQv63I+Q9305qKSyXNcwB0KgCy3QSPSQDnkyS7sH463CaXbjsMBuT6rCp9u3iLcyAtQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q27KcdADbzgZzC54xcLkH5dHAjluRVHy3b3TFoyobKI=; b=US5ov1+8IURRoY/avZiCWjlmIn
 9oVNRRnBRMFGfmchNepj4FHuUYzrUv4Kr2mBUvQlwFrltpCfNHhx94loZqt1qrfU3E8UJHaLJFhw8
 pW3wNa6yRamc6Y8ErVG+pLNW0DnM6x8q/p7tKbA9Y27aOl4VRZr9rOWbVoguiUcwSrgA=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1os74L-0005SB-CE for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Nov 2022 18:42:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 15593B81613
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  7 Nov 2022 18:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1B2FC433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  7 Nov 2022 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667846513;
 bh=q27KcdADbzgZzC54xcLkH5dHAjluRVHy3b3TFoyobKI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=N7KiLji6zWpPAW8OzBo/O2Aco5RnLSaBptKh4BHzvlhm2ow0BwD2galkLlBX4dIzt
 pAaTnxQFGVznZlRFJEI3LF8nCC90LoEyC8el6ur9WZ9iHFFWelUDtaYZBHk+77jBhY
 0GzQ6M6BorcPbirVf4B5B6Zhi7b9eAcnn65KHlfArwNdVrv1jq+ca5lZ6+MXy2lhhD
 +D5CTwAdzaPJN/+yd1Nnsn6vbunH3r0F249gXPiOvapfx73ehLltHvDBCNQqUJZ2zF
 jkl7ZMKpsD2cgxp1GC4NcI2pwrWc0xnrAVq+LakH/e5ZthBeynq7iwi1qnEHxG2jWY
 mRgF/+Va+wFMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id A8424C433E4; Mon,  7 Nov 2022 18:41:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 07 Nov 2022 18:41:53 +0000
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
Message-ID: <bug-216050-202145-lzFepumMG1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1os74L-0005SB-CE
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

--- Comment #78 from Guido (guido.iodice@gmail.com) ---
I tried background_gc=sync. It doesn't solve the problem...

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
