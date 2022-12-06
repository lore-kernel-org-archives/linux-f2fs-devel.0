Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EADC352A1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Dec 2022 22:57:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p2gsX-0002AK-3e;
	Tue, 06 Dec 2022 22:57:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1p2gsV-0002AE-GP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Dec 2022 22:57:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xtRMZJwfaR6T33EJabGhsom5tvBKwuBPBUZp3zABIi4=; b=YSZ3VAiq3+mM0qz0/HVsddLWDu
 sk2p+EMYladFbbnjbqQYNiIdg7iDmpntZGJieAZay4ZTIRU39VoSo81h+jYfuQZq5Z/iSPf6d6PIS
 jAOm9goFIeyq2ey4th3VqcaJOqNJQCz5sw32n0nEYpLkmwNVwosQ/kt+noJWdYQVxj04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xtRMZJwfaR6T33EJabGhsom5tvBKwuBPBUZp3zABIi4=; b=XMTCE9mYqvH1v4vAd8JLcZFX6/
 27MQiRTdVlEFsNpF9LwUslS78sPTbRAccHKd1318zqUlhg8a/g6T90lW7nZLadomLEyynR8I5x8wH
 pV15uaGY+MuT5hfGYp1hjQY7rqc9WoTegweIsNxMu0kF5mlxpBCBQPsuljPeiWqeOQGw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p2gsT-008Vco-Fz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Dec 2022 22:57:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 49068618A6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Dec 2022 22:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC41EC433D7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Dec 2022 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670367442;
 bh=xtRMZJwfaR6T33EJabGhsom5tvBKwuBPBUZp3zABIi4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=VhUclzl3wqPCZPoQQ8ncuO7UqE0IfcW6J91j6cdZQjl1sHAND8XdAcekuSNsedZUe
 jM4kOiv0LE8j2Mh1IQosCUNca0ERboI0Kb3evJo7lL9dYFoyNBNrpi9tSbSls15rTg
 Bq9RcupikpmbuMOhujmXSAiUibRqDqBvoq5M3fohtD+JUSffHJ/MLnnJXWgNhiXyUn
 2YVDlRr9XiA2m2btqckgg0bku3CD3zT50W4cqHHMV9VDaAi3OakghVHXQbVFd50WLw
 n8V3DncwPUjyNX/s2YqccEAK0uVssi4vHqYRRMoheCL1z3WzvtuxixRIbkx1wkmj41
 GCsjO7TcQ8MGg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 90E67C433E4; Tue,  6 Dec 2022 22:57:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 06 Dec 2022 22:57:22 +0000
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
Message-ID: <bug-216050-202145-GZ6EbRyKCP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1p2gsT-008Vco-Fz
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

--- Comment #106 from Guido (guido.iodice@gmail.com) ---
(In reply to Yuriy Garin from comment #105)
> I'm running next debug patch, but problem is not happening for 4 days at
> this time.
> 
> Can anybody suggest a way to increase chances of this GC problem?
> 
> Sometimes it happens twice a day, usually once in a 2-3 days, but sometimes
> it runs well for month - with the same work pattern - development
> compilations all day, never turn computer off, no hibernation.
> 
> By "way", I mean not scary, dangerous, intrusive way, like LLJY script in
> #83, something "more natural", less intrusive.
> 
> Thanks!

Running the script on a 5.15 (lts) kernel should be safe (not really intrusive,
gc is a supported operation).

anyway, I obviously do not take responsibility :-)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
