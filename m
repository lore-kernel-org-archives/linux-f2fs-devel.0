Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C150CC77B6E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Apr 2023 19:58:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pmgbm-0003MJ-0R;
	Wed, 12 Apr 2023 19:58:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pmgbk-0003MD-9H
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Apr 2023 19:58:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gm72Acyf6Ges1fts3YL93DjCWA3McH5WHsPUuGnQZN0=; b=apWvEoxA3zf5ZrknWjvu9c5voY
 KZYQAjJOrGZ7pAqksjoeMnaMzglXsY2wqMirH8cjtbJf44DiUYzgDYL4IY/gk7J3sWO1ORJnmfDz1
 JBs1qo9PkvPo8Pn53d+ZWKT2+RYqwtTxpgBb/XAamb60KQZN158aFdmBeX8/oZjQa7Yk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gm72Acyf6Ges1fts3YL93DjCWA3McH5WHsPUuGnQZN0=; b=ZWyZoASy/eMZwf8vFou84onV1b
 krqnMCbtxoVQTLUO7NvWmVQVoggFOJY7Wkocy+c5KDXRyc2hNedDRss0amTGwBNqh5wLKXAS7BXPs
 U2VY7VW6lFu7T5ZHpnKvJ7pKfalcbcvyWPlLhJgtROzdACuE3jYUzRFG62/f1rYCqbuc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pmgbk-005cJI-3W for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Apr 2023 19:58:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AB62961129
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Apr 2023 19:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FB02C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Apr 2023 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681329494;
 bh=gm72Acyf6Ges1fts3YL93DjCWA3McH5WHsPUuGnQZN0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=MPVlAmO8dCBH7pa+n8NAToz/9Q7JJYBslSUOAZn908VMY33qT9KJReEtyT1UvhkpR
 8EDOuQZxT6k6PP5hFdA0qXadg1IYuEjZ1NWhI51GAGX2SDIEHd8SCvyXxAKDOwknxH
 NQOtVXKyPeK3IZiplBc5Hi3hOl6/dFymQoC9awl0ZgUA7lGKR10mphWQyG3B8JQPzN
 YiVB2WqUnSmBf7CMY3BTTRWQcCIMxpkg/snmIPyuF4ftfEUNxluVeHXJjUS7aAcIV9
 tZtswI196okMAehBZp/nsj1LRtZr06dtr1tHttK9KIhHVAgF+4a6vvDflxluUh77Ow
 Q7hNvSEm2dddg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 10E13C43141; Wed, 12 Apr 2023 19:58:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 12 Apr 2023 19:58:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-L2zaVrNMVL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pmgbk-005cJI-3W
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

--- Comment #157 from Jaegeuk Kim (jaegeuk@kernel.org) ---
Sorry, I found some issues in the original patches.

Could you try two patches now on top of the tree?
https://github.com/jaegeuk/f2fs-stable/commits/linux-6.2.y

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
