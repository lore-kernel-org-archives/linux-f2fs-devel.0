Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4731E77180
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:47:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tL2Si-0002pl-JY;
	Tue, 10 Dec 2024 15:47:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1tL2Sg-0002pe-Ms
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Dec 2024 15:47:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R6CNNbKcS7G34+9XEbLFsL39VH45PzzBMIwqmXqnubU=; b=OGRZO5giC/vWwNuafPYttfC0GA
 5TKGsaI4EkWCrRcbmacLX14XOnZL/QIiGsABTBZ4aNL8VxNBLWUOvSoaNrCOTYW9kp0n7V9qLj2OP
 k3Ppp1S5fhcCWttCwlJLWrM/BcUv1LhrYALiqUI9vQ2ZwecLNb34QF4P9yabbVuaEmCo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R6CNNbKcS7G34+9XEbLFsL39VH45PzzBMIwqmXqnubU=; b=Mgyo6ZyOB1RE7A77hvpS0QB8ib
 yzRH5STG/VLu7iSoY+Xf2odGrm+lcWRqbrVrym1AOjAeuD3A+o2GGBYT42r6WTTOL9tmrm2DM0X6T
 Xif1e2OasOZ/g8n/tSM6GxErQDmL3vhqWbJG4XgcuRweTVEFtuk7pUWgXcxGpkKQ3YiI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tL2Sf-0000x1-FW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Dec 2024 15:47:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9C80E5C4AF3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Dec 2024 15:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFCA6C4CED6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Dec 2024 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733845654;
 bh=XKnIlDv0r3wOPhKXK9iR88q66cd2xd7dJ0qtB1VR3UQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=X1dWcXVZ0JzEUeIVHwStmKexd1Qb3RSG+7ZerI7OiZSBvhpNQX5MAmlv6eQdl3WvG
 fjPMiJYyvJcLTA+KUP9XTsRPA5fuLH+nfNelu9w1cZWUVEP/F9Ua6cfRhxgUxfBvt9
 E3kyhaml8jUjotU98/GYoe35/tGvpl++JPUBStgWHI8lUcaosWjnHtt2noTHPZoP//
 vwTZvMMA3c4EcJancyQw0HXyFc7MueUK3plqeP0NtkQZakdz+sSRnMK0+uAjHDQDaW
 ZcM2CQUhwaph1y9WFp8Fh1Byh+1E58h7SdK3Sb2s0jGVj11Ty1lO/1taCXFK7GDhRH
 p/iz05bHO/+jg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id C0068C3279F; Tue, 10 Dec 2024 15:47:34 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 10 Dec 2024 15:47:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_regression
Message-ID: <bug-219586-202145-fxRD1RnrHO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219586-202145@https.bugzilla.kernel.org/>
References: <bug-219586-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1tL2Sf-0000x1-FW
Subject: [f2fs-dev] [Bug 219586] Unable to find file after unicode change
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

https://bugzilla.kernel.org/show_bug.cgi?id=219586

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |18b5f47e7da46d3a0d7331e48be
                   |                            |fcaf151ed2ddf
         Regression|No                          |Yes

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
