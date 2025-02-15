Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB77C021A0
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 Feb 2025 11:42:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tjGZA-0002F1-5a;
	Sat, 15 Feb 2025 11:42:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1tjGZ8-0002Ev-CK
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Feb 2025 11:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LFDuUyim0ITeS0ffmeGmpYohbUKNYe8o8XLNpB3ddHc=; b=OT7GYWFVIQZoWqUpWBlML7H04O
 Ze4x517wkMWLTets8XKrMy6LqMe0UV0vc1btW7yWrEwwbexP8FB/jkrsfKfahFNNi5MXU8diYyM4l
 RY99SVhw1any7LtukOZOjm/NmU7BAhd/JwAaHQKydn9NFDcAMhMehbDxJXLQYfw5dK2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LFDuUyim0ITeS0ffmeGmpYohbUKNYe8o8XLNpB3ddHc=; b=HzXgDRhgH3bw+irwN4D68/DYQY
 KwwUni54qn0pVmTSWOdP+OCETtnPNS9bPT8a2toah4o+v9dsObF4vBbTPibcB9f5vzWrXb/xX8L5H
 B8vzAWCXDnYgMs4xgriwJ7ftImtWNYSaOzZ9QOSYmvgXu4sQJ91viNYk/jcaBBKMLdi0=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tjGZ8-0002sY-79 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Feb 2025 11:42:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 69FD4A402FB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 15 Feb 2025 11:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F30DC4CEDF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 15 Feb 2025 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739619743;
 bh=IIioUIsMmv0R9hXFDBy0TnHJ4bb7kzpWaS6k7nsBnbQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Quz+q5J2VYEvByHsCOHeWefA/4Zi2IvRzxlxTcYuAU6DnfJnZQt+4yFS1XHjAYUBJ
 G+5Q9bgjhGBYVdxdKE4qUjDqbwPMbT9kodKMz+WP246AASympD2XE+GdVozl7OCP7F
 3vC+/sROPnP7LFXvWQUfoaohfnqhwd0Nm/Ds9V5grtsNIh3DkgUAQU9DxZzLf3m6bq
 nDHgqbr8JPY0avkn5JuQiUr0230U8gz1IAVLxsucW2BCkM/8GAWp3Dil+ZW6OSLeC9
 leyuY2D3sA6qPRsWZFlpe/p1iLLlE4oI6iYTlW5QAbgwVP5yhoTKOjv+9QvPTxC+wS
 iOpv4pcimod1g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 38395C3279E; Sat, 15 Feb 2025 11:42:23 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 15 Feb 2025 11:42:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219784-202145-nzBeOR79w2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219784-202145@https.bugzilla.kernel.org/>
References: <bug-219784-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1tjGZ8-0002sY-79
Subject: [f2fs-dev] [Bug 219784] RIP:
 0010:__list_add_valid_or_report.cold+0x4f/0x60
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

https://bugzilla.kernel.org/show_bug.cgi?id=219784

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.13.2

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
