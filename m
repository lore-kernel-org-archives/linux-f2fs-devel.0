Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260E3C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 Jul 2022 23:23:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o7mSj-0006zE-K3; Sat, 02 Jul 2022 23:23:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1o7mSi-0006z8-A5
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Jul 2022 23:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nDWd22la6icGvrcEpiqfdDaS0FYMJtY3JqPVe1bEEjk=; b=RUpMCw8wYM80A9OnceXP5vgV21
 fNERWyT82EplEIkCyfPmdZr0Ke8Jit+VYCUl6S9GuDkA98ZSWh9eKpIH03WQJJnSCmL9tB1H+IgC1
 Cz8trDchjJnFi51j98IayzzcPUrYgBZ/sUGji4aXxEBbnwP4xcz3KtCtJaoWeghtT6hc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nDWd22la6icGvrcEpiqfdDaS0FYMJtY3JqPVe1bEEjk=; b=ZjPWFZSX6NCZjXLoh59or94yqA
 Tvpultyiz7aId8776P971Cg74rNULEwit8pikMbsUvygyQAJMheE7rU8mnNts7wgOTD84SuNYGMtF
 mieqT0cg3mTcNFVs/riktiUDFvLZZki9aHxwqegitg7Yg1AN3Tt3uXewUexyXNIJIXEo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o7mSh-0002I9-8r
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Jul 2022 23:23:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D4F5660FB1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  2 Jul 2022 23:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FFC9C34114
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  2 Jul 2022 23:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656804213;
 bh=nDWd22la6icGvrcEpiqfdDaS0FYMJtY3JqPVe1bEEjk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=BaCi6ypfG83TDXzfro/GU6w7TrXILUPT05R2yZjm+MCrxMBKCcXmb/v2pQl9b9pt0
 KimZZ3dpoATPWG8jbR0dR3C3r7mrs8OvGf3Wxwx+0c61q4UU/2ULi1rtx2Bpx5cEbP
 3rlG1CuC2yGkODObOu/OTM9z/zEHC/9ukuuBje57HbdQaGr8EFk9Hjqc2YFjERa1Ry
 DtNWu5uHTzS3ZL7XRmiITPfnI3Z6P0p3FzusI5CmTSEM37Qbjkfz7+BIuE1qZwf0lO
 ZGqSh27KznnpGnSSzybi24EkGptmSb6nQffy9Wsr77qOtTcoB1P0mktIexc6k1o1CF
 e3dNs//HHJ6BA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 12BB3C05FD5; Sat,  2 Jul 2022 23:23:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 02 Jul 2022 23:23:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ghtm2@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216162-202145-NJ2eqTNZyv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216162-202145@https.bugzilla.kernel.org/>
References: <bug-216162-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1o7mSh-0002I9-8r
Subject: [f2fs-dev] [Bug 216162] F2FS filesystem with compression broken
 after kernel version 5.18.1
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

https://bugzilla.kernel.org/show_bug.cgi?id=216162

--- Comment #2 from ghtm2@protonmail.com ---
I haven't had the time to bisect, but I've made a small image to demonstrate.
It's mountable on 5.18.1 but not 5.18.3 and after.
Due to limited time I was not able to test 5.18.2.

Maybe someone more knowledgeable than me could take a look?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
