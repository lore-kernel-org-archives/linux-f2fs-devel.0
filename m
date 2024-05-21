Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C251C25B74
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 May 2024 21:35:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s9X8f-00067X-68;
	Tue, 21 May 2024 21:35:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1s9X8d-00067Q-Cg
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 May 2024 21:35:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Oofgs9X89LDfTuUZFAyyHSDR1E8NAgSOAeIymh5YqrI=; b=WGiLXnouehWEaKlk3HfO1GNHsG
 XWRGosYdP8VCqpucdYnlH1MzPKsbMinpucyjg+NJrQ+Wk4XLqTT82nK4AayZh4G15pq1HLDEeVCcd
 blBgXgrmEBXjRDJYETcygsSNU8dbqL9scw1tq1AHMvLnpf5C4RuAV1T44n1l6O5n8BcI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Oofgs9X89LDfTuUZFAyyHSDR1E8NAgSOAeIymh5YqrI=; b=bXhyXgiK8J3hZO0sDnYAW8HKyu
 jzk69xSUasCq7p84gd8gJkgHaWDt8O6uVybFxy2Hj7FYIC5zuC/kqGkH5N1qLMlN/0CEp9t/WF41M
 3cup8fZALGjHfF5qT7qA8FDDSuoX78+QtGJDjHIJz/+qE4lE3sOtdx9Xsdqrs/4Qszqw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s9X8c-0007WZ-72 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 May 2024 21:35:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1D6C562443
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 21 May 2024 21:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6623C2BD11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 21 May 2024 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716327307;
 bh=Oofgs9X89LDfTuUZFAyyHSDR1E8NAgSOAeIymh5YqrI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=OIsGBdztyNwXhNRWPZhicKmcf3MGDKR3U3+oZjzkP/qT/vLiJWqZ75UlZw2J/G2cL
 bbCFPxRvp8zXJM1gwNuQYBIN/QC/zG4KY/BKbhmRwOd94ncDIcDgi+71GV8jB21Qii
 7IoiSg7+AIvnH1qkqf/7qB7kF+bVIhB+qJJdVI120JR/PhNOABYjlmdbUSpAbxzkOk
 q040vvskWNBbchcx2BvwTY/fhMrVRE6SnKHOwRwmF0n2KEUl/TdMgI50li5uYj/0ZY
 d5qKdt/XCEjda3dAr3KQ0bKnhGOUCU2MpydNldKN1NW0Whi7ctOjyzJRXnJXC/R3np
 Is+YxqglQ6/Bw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id B48ADC53B73; Tue, 21 May 2024 21:35:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 21 May 2024 21:35:07 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: patrik.plihal@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218870-202145-4eL4t3Bc6J@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218870-202145@https.bugzilla.kernel.org/>
References: <bug-218870-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1s9X8c-0007WZ-72
Subject: [f2fs-dev] [Bug 218870] F2FS mount/unmount results in
 invalid_blkaddr
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

https://bugzilla.kernel.org/show_bug.cgi?id=218870

--- Comment #1 from Patrik Plihal (patrik.plihal@gmail.com) ---
It seems to not occur in 6.8.9 (can be downgraded + fsck reissued), I missed
this info initially.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
