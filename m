Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3989C9EC64
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9T3s1hz7/4yA1YdB6Lm+KhiAN32w4SBV5dkAI24DuU=; b=DvckeBRbRmm0AZx923y91zM9Yt
	8rIWkj0CHTqJttz7bLB6hOGSkkKuhGnhhsAetUQ/UrsfopEzqJ74qCFRKyjrHzGzXuuQBzKdrUNY0
	TfserAVcYomxOP2Bt2pYXT4q/Opp/+ML6726Gd5vLvKdbR2gwMJp/ucBknpKYXGasiT8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vfF6n-0002ow-14;
	Mon, 12 Jan 2026 10:25:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1vfF6l-0002om-9P
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jan 2026 10:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x5uDjxc9n5c3/z/kTIYL8x8g8it8OofmOkc12yMpw1E=; b=kvSkTnVjJy+NSxwU0DbI7HwrSA
 JPIpnkWQZsur04/2Vd8PGCf3JV+n031POTNbMG8v469tM90P0i1UsksUaMcHy4EpjZ2s4UK2JeKKo
 aRt4pV/1q8L5dpxJz4qQL5RaECvzK4qoSMee8lNgdsj2YTZxR0pKMUSSMdJH05PHoNZY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x5uDjxc9n5c3/z/kTIYL8x8g8it8OofmOkc12yMpw1E=; b=eATxN+gV9Z6CFkF04vSY6k5lof
 6p+U+M8c8rO1FVigBgrUl35mUOqrbTFcpUsjXfQTDAf4Buuq3P9yV87Sml4ot2YWaaHK2cBFu66dh
 7kJxhgF4WshkYKEh1WWBeJOd/pCnVCYyn2gI0wRbxiPrn9eAw5tUTQiW1mvYN+sUhZ1w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vfF6k-0003XE-0R for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jan 2026 10:25:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 53DF06013B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Jan 2026 10:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A1EBC19422
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Jan 2026 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768213504;
 bh=yzLUiQQ6hBDTynj58EYIUE0wVQS5XnrsbRw1F0y3E40=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=W+52bef74TEq8oPbmv1rCpQ35kVQeiGFNGRn5ayqB7VRx70HXg/XkIDgBESF+JyLN
 bfPY91ni8g1cFSvsL0G/Otl8AOmSugroJx5AoaBHtUqc+jDp7Rd9uXk2+PRYTagN5g
 XBAMWfeVRNqxORba0ZP8Qhy2SbT3UaiTN9qg74vBm+4hXo8+ahIV2Oe0MOVwkEEtN6
 lafKsASe5Bl/fPxAm+gBl/ee9jbXayJB2tVXBv+mVLARaeY8HI2JTgidrxlTihPQch
 OwVsRFIYregflob36gEVGocAOC8i0wopHcbB0ToqQVC4y2fsi1TvWKPzZtUMhZqsrB
 WIGGBc3DL7ecw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id ED998C41612; Mon, 12 Jan 2026 10:25:03 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 12 Jan 2026 10:25:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc
Message-ID: <bug-220951-202145-xmxirIY145@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220951-202145@https.bugzilla.kernel.org/>
References: <bug-220951-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1vfF6k-0003XE-0R
Subject: [f2fs-dev] [Bug 220951] swapfile activation bug causes data
 corruption when swapfile < 2MB with fragmented extents
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

https://bugzilla.kernel.org/show_bug.cgi?id=220951

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
Xiaolong,

Thanks for your report and analysis!

I think your analysis is correct, based on that, I made a fix, could you please
have a try?

f2fs: fix to avoid mapping wrong physical block for swapfile

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=bugfix/common&id=ac3dbe269a28f2d75ae963b3c6066a5259348ed2

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
