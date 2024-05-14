Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE30C04FFE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 May 2024 16:32:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s6v4d-0004Yn-7v;
	Tue, 14 May 2024 16:32:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1s6v4b-0004Ya-R4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 May 2024 16:32:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YMRtcaNFk2sINDbidBYpnpxaAdSnc2qHcF1EkcZ11Ps=; b=ZCuJBsX6kpmcoUhcZ4L3yjDtsu
 OOIRqb0W83B7Ub0qbgXJ5e8snaKTTp1S0DNXvdJj6jkzmBbJsALqyeUytp2KCzeHhFPPNb/oJcJ3j
 5FtpbIu9FcZSK2j8B/pRKk8DDQWmCbBy+a0MyKEpYFyRWaas/0OUjXEKe+KZjEaes4Iw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YMRtcaNFk2sINDbidBYpnpxaAdSnc2qHcF1EkcZ11Ps=; b=LFNkbaPiGtmy/Z/Vqz+RizOrvE
 ZZ7BldMqdjzsA92McG6DUU3sT8HTc79H4/AZTGko8H03Kb4zxLZHmf1vAhTMevHjoYVEWSlvYK8DS
 kHR1bckuTXQ6a77cLbzD6yXkwC8+eM0mYnsxumvH8oY9vBaz+xVx+3NlawD+94poHums=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s6v4c-0002wf-2L for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 May 2024 16:32:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 82F53CE12A5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 May 2024 16:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD20BC2BD10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 May 2024 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715704324;
 bh=YMRtcaNFk2sINDbidBYpnpxaAdSnc2qHcF1EkcZ11Ps=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Sp1ietsKwf2JjNP65Jys8FPxNZ0fLgL0YH/GYy9gDmp0N9LpcY0Gf1G2EPhUQM85z
 zX9PkA3CtS6u8Smyn72PEplNcVH7rNy8qQn3Eu1ITSw2wJdSAodkfb+q/kt2gFUghc
 8Mo1BWMyj2zC/N8dvkIu9SmDrHu4rRKUSJh/RtDYX59cLwgKsD3zGEoxnPTSH3+gG2
 N9DOwKhiuSExJD5oajyMTCeWK41hUR0R8dZOd6VfhGhVkDycyTFhIWQ0+q7e1KJVGp
 t+M3byWp402w/HBRRCNrqyTBZhkxypceFA2ud2crcg62ttjPiTO5kD7zuULC7UlP0g
 +Lk+0jpVs7VSw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 9F86DC53B73; Tue, 14 May 2024 16:32:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 14 May 2024 16:32:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218770-202145-kwKRxyQK1E@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1s6v4c-0002wf-2L
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

--- Comment #9 from Jaegeuk Kim (jaegeuk@kernel.org) ---
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=b864ddb57eb00c4ea1e6801c7b2f70f1db2a7f4b

is going to be merged in upcoming weeks and LTS probably will pick up later
given the tag.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
