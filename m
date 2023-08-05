Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBFAC001DB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Aug 2023 19:39:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qSN7A-0006ag-To;
	Sat, 05 Aug 2023 19:39:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1qSN7A-0006aZ-6q
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Aug 2023 19:39:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WMeKcb7FM9rr+EMazKIZDtK1Wk95smP9P5foyHCbPW8=; b=EkW2JhAWj2kI3eEdN6dFhsCmdM
 MSE3TmtTPCbBDkFIvBbF9aMNnfhgds6dLnoCuqxI9+NskiB53+DFQ0J6qmR0kNf2ycbsUhYGI/sV8
 YSSOVUs4rlHVxJp3pfWTf++i5BDnI0rGmO3+PIZRicMDv+0RKPV+cHLNqKKnZEI9KpEM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WMeKcb7FM9rr+EMazKIZDtK1Wk95smP9P5foyHCbPW8=; b=LaZDCpE3yl159pRlObaxlS2IXk
 EL1G5cwJLofgVAbxNKl8ERJWhYGGIiYjxGXx0aVJAAR8NQdWqwXESStXdgvtoRSnACRM3IPcN+GhP
 yHdbJ2oPPxC5mX0imlT2dcj/lnv66+16cmLEz92K0w1xeesaSLf+u2GnYprT7e67vr1I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qSN74-00EED9-Sn for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Aug 2023 19:39:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3D9CB60ECF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  5 Aug 2023 19:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 579E8C43391
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  5 Aug 2023 19:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691264332;
 bh=WMeKcb7FM9rr+EMazKIZDtK1Wk95smP9P5foyHCbPW8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=OJ3mboAYNvsiB4E1+0YH8fx2MxmcJB1cdcv4+Pk9z7ToWyNoG0xaPg3q7B7ZBc6SD
 aqDA173tqICvoR+qu3ue+RUZDuOyLtcj5lxaDZlb3YTXte4MjFAUpf7H68ni1O2ffp
 fw1ynHS5Irj27ElfWmfaQEnxguJZyb3PL/6irGgZJ93iCTL8cEVTUiNAuIvX23TIyP
 H6WlqrdWr5bak8Byaiew69aLyxSw04gzslXpcTzf2RG+L/Y/5aHxCn4/XDAytPn8ud
 I6b18swn8POaYilhZrkSApeDCYyFMxU91umc4C61DcCfVO9jq2kE9+MYrciyuqv1rs
 vQb2wvPGqSnIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 4372AC4332E; Sat,  5 Aug 2023 19:38:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 05 Aug 2023 19:38:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aleks_@gmx.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-DMp2izQDpd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1qSN74-00EED9-Sn
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

--- Comment #178 from kelak (aleks_@gmx.net) ---
>Jaegeuk has proposed a workaround solution as below, it aims to enable from
>6.6-rc1, could you please have a try with it?
>
>https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=5a47ad28e6061c8fddf5c82d49fdc3280a80b2c4


I'll try to build and test a 6.4.x kernel next week which has that
workaround-patch included.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
