Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55703C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Jul 2022 19:56:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oCRQJ-0003pj-LY; Fri, 15 Jul 2022 19:56:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oCRQG-0003pd-Ld
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Jul 2022 19:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N+6e0mYBcLNAKIWBnl2Urcq2GWlOD+YajUp1CtqHR8g=; b=cig4OlNQtw++1NUPaU0SFBZdhf
 m/YuIlbKMkMdLl0QMJkbmRggvTLUQToro9hkXFgE1ZaeOwm2BVkTFxK1EphYXxXjcTOrOLrFOuhUv
 X7WmABu5r9ACdA+jzFqOklSGzEl7ZALokeM78P3C/aEGK+TyTYPc+9s++WCRpjUeVHQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N+6e0mYBcLNAKIWBnl2Urcq2GWlOD+YajUp1CtqHR8g=; b=dye/wjZsqGFtndrWd25bSSuMqQ
 EdxFkd8UN3AJh3B74HhU2pGlxCE18HaHgD+VmpQAVtFY1ydYOQ9UYO7xWBNULqSdLN5QEdlQf28H8
 r1FKsfhw5BOiOyn6Bk8PMW1qPTvsbhUW03iBSNXSPVvPujJ66WrXu3T1VRPQqKPDOruc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oCRQC-0002CI-7Q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Jul 2022 19:56:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D348060BCC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Jul 2022 19:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41914C34115
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Jul 2022 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657914969;
 bh=Gy0B4S1bQYiOFk1Oi97UR57sn1f20+u0CzhNtS0khLs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=RFe239CzHFSyj7p1Ji5IT/x0dMLbIlYnv4Fi6UAV0UrgVQNzVzGQjNWBLySt/r5+f
 W4KDLFkCYSTh4h7gq5dMABqh0N05J5wJkr5Y9im0MPS59ZbONV5Qp9MaScoJqWikE6
 nuZkkr1ME9iokBcaaELXdUNISH0qR/84+6YM6PGvuz9atGS8hZ1iuMjOnbCMKnw/2f
 HFcSIgWTKNvwpuODCtk8ZkIwm/QdE2IxCnLsIrBVyAOaC6vcIbLJOOx2a4brvJfKJf
 d7cgn8DVyqRnFPe2UsXNfe4KLgJBtHWKVxZQeoZbdKPjMy9OXAdbsgcdeaOyr3DDpD
 c5QAd/P9Kx5Zg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 24251C05FD6; Fri, 15 Jul 2022 19:56:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 15 Jul 2022 19:56:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: surae@yandex.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216162-202145-VbL8ASyEsB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216162-202145@https.bugzilla.kernel.org/>
References: <bug-216162-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oCRQC-0002CI-7Q
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

Andrej (surae@yandex.ru) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |surae@yandex.ru

--- Comment #7 from Andrej (surae@yandex.ru) ---
I confirm for 5.18.11 bug persists

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
