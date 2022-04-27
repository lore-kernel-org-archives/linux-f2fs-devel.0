Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BB6C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 Apr 2022 11:51:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1njgCF-0008OL-Oc; Wed, 27 Apr 2022 11:51:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1njgCE-0008O5-2o
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Apr 2022 11:51:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+NELzBXUOcoA/UkcVTq9MTU5/eDHSmGzfIUeJNDABKs=; b=k917uhiLaNa5vIfi16OxH6nzzV
 T3i19K7GKb5KDMvGLP8DH+dC+OegfmNi4pPKgkrmbiIWKUxVrrO2p/xRSNTEzoEPU2DNu62qka0oh
 l/lRwqVmoAA/1OyAIgp+Yo/7MJY3cPeolR2X30U5HYC7F26uCKaQ155GYjQEA2Hwx8ic=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+NELzBXUOcoA/UkcVTq9MTU5/eDHSmGzfIUeJNDABKs=; b=XNjiU67qoEzFsgT9VeT4pMZJm0
 aYPTmZ8XOaJAdsPJmeN/gxOr//iAqWhPD/fq9qltl0pL1OOvK1QG8SKF7/RYCuCRr0+uwrVYX5TRH
 DhQMsyM0UHjOMs5htn4HWjw1OI/jS7yWNXf1hXMPwy1RCqba7/KMYDNq+6fctlsmR/Fk=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1njgCA-0001cd-JG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Apr 2022 11:51:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D1E9AB82669
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 Apr 2022 11:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FC77C385AC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 Apr 2022 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651060247;
 bh=+NELzBXUOcoA/UkcVTq9MTU5/eDHSmGzfIUeJNDABKs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=pMFZeexTUWHNyz07HMPpCbNLXPhfmYFaGR0AoltYRgGMg/Qge9mHQZtN6TiRoxvyg
 jq2dlqjKWvFZsKEERZuor81keV5qB67UePlszcziyRx8LxVLoZtNa8c+vSIBv8jOWP
 l02zn2IW3nKhg6gvsM9y/kNauTet1G32s0zBTKE4ai/LADEcgRzQDaj2+8TKKcEdzA
 z8KNjxRK3ogWOwwS8fhh/S/pF2i8DlZBwZichqT27ToQaC31s8Ie4LUTdi2Ct/FCDY
 ErOdhs7WsbvCxK/Kw323ay++x5Vv9XvgbeJTTRIeaC7oPnCUODB/GcrGKLgEbEW2a+
 6hmRtIIlAWqtg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6F8D3C05FD0; Wed, 27 Apr 2022 11:50:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 27 Apr 2022 11:50:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215894-202145-rH50BveXvD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215894-202145@https.bugzilla.kernel.org/>
References: <bug-215894-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1njgCA-0001cd-JG
Subject: [f2fs-dev] [Bug 215894] kernel BUG at fs/f2fs/segment.c:2291!
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

https://bugzilla.kernel.org/show_bug.cgi?id=215894

--- Comment #1 from bughunter (yanming@tju.edu.cn) ---
Thank you for the prompt reply, this bug has been fixed after adding the patch!

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
