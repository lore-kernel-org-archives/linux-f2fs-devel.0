Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79370C07E9D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Sep 2022 00:49:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ocymG-0008I4-Fx;
	Tue, 27 Sep 2022 00:49:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1ocymF-0008Hy-TW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Sep 2022 00:49:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0ikvGO5bIOM00f0l9X7hnJ4dxkGJv18q9AAmwFkJ1DU=; b=RBUgKJSGraNXPsMU0x9lJa7luI
 izpviKL3VgrsmeIs6Gx6IG93D12nEmHMFzpPOBKgDGqmqOuzqStnqKkrl0Vwo4NSTkcNb6cjs3Fe7
 2wsRsLWAi3vg1UTuiTzFF6ApW3zR0yA8BsMGUftcAar/TTfV03wRN++8KDQdZNM3L+M0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0ikvGO5bIOM00f0l9X7hnJ4dxkGJv18q9AAmwFkJ1DU=; b=HOu8YhEgYFZ/OmLDpMXTcDS9vn
 0izrlGb8N66U6BGMcy6zktkffAMfIisBhmeTg6m+D9q3hB6a+MHuebXrA04zeZ5dnLJ4AN1eKgtsP
 +18NjAnLg1S/qwFhc/rnxBwEBzlZhFi//IOuFKZIckHWicNhSDNV5i8J15V7UuRcqzqc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ocymR-000169-2x for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Sep 2022 00:48:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B256A614FF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Sep 2022 00:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D236C433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Sep 2022 00:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664239733;
 bh=PwDJh25Ep2QMe+K2h/yfWxjweVLlD0K/scHUhQFT5YY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=QbZJVD9IEkSG78NlXXlnk11aKBl/FdntOk95G5Ywv+q5xbJRjq9s6Ni5fBuk2C2tY
 G62Pj3RpZTdgSvxzsD7HeRRDxAenVz071QHE6u+qGRXhTNRHc63RthtMznT0Vgdz2U
 qhBsW+oHADbnWiPQ48WAy7MDnQMMPC5PDjp2JBXPQsDKc6tBjCmagt6ADwWchRgDZO
 7oSl+Ic0q4tHrh8gPD/oWvDSExvVP4fRVfWzE26ZU35YYumA+KYTZINA5ijqEk08N9
 llATcVmCWAe9+xhFohOMx4HuqRZ2ykEmGzM57VoJyu7AvWNYf0WTXvQ4SxEylUkNJb
 AmNr54BQJMj/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id F1E79C433E6; Tue, 27 Sep 2022 00:48:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 27 Sep 2022 00:48:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Zhiguo.Niu@unisoc.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-208565-202145-WCK5abChQt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208565-202145@https.bugzilla.kernel.org/>
References: <bug-208565-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1ocymR-000169-2x
Subject: [f2fs-dev] [Bug 208565] There may be dead lock for cp_rwsem during
 checkpoint
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

https://bugzilla.kernel.org/show_bug.cgi?id=208565

Zhiguo.Niu (Zhiguo.Niu@unisoc.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |RESOLVED
         Resolution|---                         |CODE_FIX

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
