Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E7DC43334
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Jul 2022 07:42:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oDLOS-00086n-5o; Mon, 18 Jul 2022 07:42:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oDLOR-00086h-9U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jul 2022 07:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e4UmK0asEzdhWt8tSX2+YSfNmsdZpxCYfAri6+myDRo=; b=G/761u6tBuwEDuleweZpJ3t34l
 nN3qwM/c4jYti3163RbH1Ba2OVP4IcgnT8dnWh+GMvSLCDqDfR3yPseW31Ehl4+Kpl+1Oee6Sogs5
 F9i5eAKIOf0Dj5THJA5cWlB308JR6HjW3hcJoOOKcNdGG1J0ly0K1WyRTGWLGumZWP2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=e4UmK0asEzdhWt8tSX2+YSfNmsdZpxCYfAri6+myDRo=; b=KDGvmFIs6sDy8xk6LNy11gr607
 smINui6nCCArE6c4DRy10Xr+KdTJQCh5M/Mt9WXmV3lVotvasmDDTEyvh60LD2vux9CfN2fhHNk31
 mBtsarStQQP19OPgxOduwOYs+KRBTiekJT8AYy63/P3JQEerykJ8r1vt3obym+KqA9Tw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oDLOR-002SP4-CS
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jul 2022 07:42:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC1E6137C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 18 Jul 2022 07:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9504EC341C8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 18 Jul 2022 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658130128;
 bh=e4UmK0asEzdhWt8tSX2+YSfNmsdZpxCYfAri6+myDRo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=CTCP6qwN9owH73BHKK+TS9xBkgjuHfasvjQoxO3O/D2hAN3VRi3vkypM7QdXqzbTG
 6HgLeYHbTD20iBDY1wZIdBCpFXoOXUt2ZilOyTS5XCHh8Tx7MG3X4a9MuF6Jx9SMEk
 sROCELFnC9+Owyaox/oBzcRYagZqE2DgLdu0G+ANtxen3Z4Nb30AIevioU+NGjA1fg
 oE5KNAS6/gzrH+wh3wFiped8neIa4Z/Qug3uBTOqKgr8RFo3TzTDZvM0DI6hEURSyb
 knkCciX3xIRA3VwMDMpWyZWDc27596Fu0PbuEbu2BZjRfW88+t8vtyEFPEBU6VuDdh
 PI6pCB3L6iz5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 814FACC13B5; Mon, 18 Jul 2022 07:42:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 18 Jul 2022 07:42:08 +0000
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
Message-ID: <bug-216162-202145-qr2ad79moz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216162-202145@https.bugzilla.kernel.org/>
References: <bug-216162-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oDLOR-002SP4-CS
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

--- Comment #12 from ghtm2@protonmail.com ---
Ah, I somehow completely missed that the dev branched was linked before in
comment 3, sorry.
That branch does indeed fix the issue, thanks for the hint.

Maybe the fix warrants a push to master and a new release?
Most distros aren't exactly fast in packaging up new releases, the majority are
still on f2fs-tools-1. 14 or older...

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
