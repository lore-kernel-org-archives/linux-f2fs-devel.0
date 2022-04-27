Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42DCC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 Apr 2022 11:51:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1njgCL-0006Km-Ab; Wed, 27 Apr 2022 11:51:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1njgCJ-0006KW-CM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Apr 2022 11:51:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KCV9dYLLNMlJpXKoUhZAR+0wPm2wP7qbcPPxSDXJrB0=; b=PeXna9/Da2EciGgDtVJVMYp9No
 kfSMGxWizeHOgJvC/LbnSvqBVScDbMdd5Wb4Lw9785O6QN1pXYOXcY9WaBriB4e1GGwc0X9PytnOZ
 b0PVjpCAkmDqaHqPM59KFytCImkGYpsIOES9ph6pzVrmhDb8aDB2lri1DoJfLmzgel2o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KCV9dYLLNMlJpXKoUhZAR+0wPm2wP7qbcPPxSDXJrB0=; b=MTjkwaZExnTt5U3mQVcTCkgOvZ
 yO1IEcrrBfNrj5IOJNDUsq3I6HZuB9eusoWadQgyf7GBAdIVcuf0B8wkNNG1tLtSSmDyWcA8hC+Q2
 8lWIv8ORNt/Jvuqs3Ldwx7M5+QAeW8i9e0yokMKNUruTe05cr56X3EtP9/R6nyTkSuQA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1njgCH-00BjJC-T4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Apr 2022 11:51:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8352461768
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 Apr 2022 11:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E610EC385A7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 Apr 2022 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651060255;
 bh=KCV9dYLLNMlJpXKoUhZAR+0wPm2wP7qbcPPxSDXJrB0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=j0+cOHscFhaezfFfOiV7wuUma0ro9KliVrPsDZPSUOlDl9xF7izzVqQ2HlsoAbY4J
 rAwfdASSBcM/f+z3WGyC9/iak/dhXJQZMMqK5kNlraEcXMC9kcDb7MSe/P89U6H8co
 MumGfJxgjknfHod8WpxFQPvWmdLRc16irBUYRxkgTizBYD7EDML/+oWnT0NJH0mW7d
 Jso9ZbeVAxlGR3R6paPXOUpdJ/pJN3FbXzulsv606AyOcOtWxWlAZYPbEWmvfCzity
 KY/HFyvuUpooQmj4yZL+47PwV81ZHbJ8tBWEOTnoDurFxB+ooKSfN2C1AC7Ty4PkFZ
 wo94dwT2lbErQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D3177C05FCE; Wed, 27 Apr 2022 11:50:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 27 Apr 2022 11:50:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215893-202145-ty8JUiEUTe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215893-202145@https.bugzilla.kernel.org/>
References: <bug-215893-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1njgCH-00BjJC-T4
Subject: [f2fs-dev] [Bug 215893] F2FS Bug at fs/f2fs/checkpoint.c:192
 f2fs_is_valid_blkaddr+0xbf5/0xe50
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

https://bugzilla.kernel.org/show_bug.cgi?id=215893

--- Comment #2 from bughunter (yanming@tju.edu.cn) ---
Thank you! this problem has been fixed by changing the code.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
