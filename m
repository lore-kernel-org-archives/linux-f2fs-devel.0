Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681D5C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Jul 2022 13:31:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oAtVh-0001H3-Fx; Mon, 11 Jul 2022 13:31:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oAtVg-0001Gx-2V
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jul 2022 13:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V81qhbsXgzCsc1CnO6jbrn3L0Bo55H+jxny/Z2uAdRE=; b=iKtNs44qLPIwHcq6AUnVJepNJN
 Zn/mY04cu4v7o/AdgQ2LuDvTR20s2fVGuYXQV6yncUB5plNRVv2Xr6yZMZ8MLaKCpCuPcohyxuI++
 tLuLXj9Yef2KVxjG9lLR184uJbgr2FSphtwpU9CE2OQ9nz9LfdrVDdAHjNLrGno2z5hg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V81qhbsXgzCsc1CnO6jbrn3L0Bo55H+jxny/Z2uAdRE=; b=Zwg3lHLp2e4zqc35841bB/NVNw
 zsKCek8hUsvC27o13QmSwzRHJQdB0H2nJacRF26joLVHHqbrlBEygyrIfjKD/dsVk7qSwGwcESrXu
 1WITses6Voa4x46blq2IZlPKyExUVLlP3W0AyJ/PRxxtPdxZnSYv4l8zVjWGv3dHvSA8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oAtVb-00Dp50-L3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jul 2022 13:31:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 76DF66149D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 Jul 2022 13:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D92AFC34115
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 Jul 2022 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657546280;
 bh=V81qhbsXgzCsc1CnO6jbrn3L0Bo55H+jxny/Z2uAdRE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Ecke00mH/KJgOzwqsnWJ8OjtRYNY6CDUOSV7KD8iSXShAoT4kcgnlk/x1joWAPrLS
 n0qIJ4+/8Cv0g65nGUsOZYGIb19GEGtl4YZUcd7a9wxIWxAAQkB3yeHHbv9Ictx86U
 cB7p2lSNAfrlp5NqrCkkFQI+JHWfC+saaMHmxV82fwWhvFzUusGJ7Ousn+HDQri7Kg
 gPGpMO6nrUHyAnyScPZV/MVwN6OdDPyp2WmNh/S4uISjwhSf+nG+im3ct1tlG9e7i/
 Zlumi1GuV/g8B/0npjlt28hSLogjK73Dsi6psIddn5kt7T8YWOXJ7Id2MTk1MTC3de
 /0kdAYMTPUyqQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id BBC9EC05FD6; Mon, 11 Jul 2022 13:31:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 11 Jul 2022 13:31:20 +0000
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
Message-ID: <bug-216162-202145-R71UzEeyWR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216162-202145@https.bugzilla.kernel.org/>
References: <bug-216162-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oAtVb-00Dp50-L3
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

--- Comment #6 from ghtm2@protonmail.com ---
Another week, another point release and the issue still persists on 5.18.10.

Can I ask for the offending commit to please be reverted?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
