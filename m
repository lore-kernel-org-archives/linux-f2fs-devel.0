Return-Path: <SRS0=Klf2=NC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF263C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 06:19:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C29260F41;
	Wed, 11 Aug 2021 06:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C29260F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mDhaQ-00023A-9Y; Wed, 11 Aug 2021 06:19:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1mDhaO-00022v-NZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 06:19:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yG8SSrUP/LQOt3SSI9SYchz+BqWSQ2fzhpkId/KSIac=; b=j+v2ywdiNwtQPWPaahCePyD70O
 c9FEjUtP4AUEDa85nA45wOBfACAh/ugLhbLha6imZMX49VkgbM5cBgEw0Blu3F7SlPjs+IpAToGV5
 L29SXEo31ZrKTxrd2e0R79a02ELCqbXvlzV88G67VU1Q5lOdfCTp7hLFfpthl2y1D81E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yG8SSrUP/LQOt3SSI9SYchz+BqWSQ2fzhpkId/KSIac=; b=ijqkbSW12/CIZpMIlaf6/GvLT9
 D909bpo5yWccp+4ZwluNGxIEhunsYkLKKT0GFxA7uTGToQLU38T6k51MLdb0E6+pdua2rBtEjYOU3
 RFR6NYF7noGJ+oh0CM5QN/zK8ArM493VxXGofWDA8WEUF+48r0uO8A5EQeyoFOQ8iBMc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mDhaL-002ffa-QR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 06:19:32 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id 0317460F46
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Aug 2021 06:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628662761;
 bh=KynxJ1UQ7TacXAGbI79y7Z9qprXK8qQsKfRtzjxZMcI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=nuuSdd+6lUBmKs9fOmYULo76Am/dV4ZfIsZvFh2cyWJ//92pnHpX646Qx76dIjrsq
 5AJixqU7tPjGBsHZmPVCQFSfVfosWGJKKjtqi/jKdG57IdH4BQLDAzdzpOCcvB8zOW
 kOjtHfRamOqMklpjw0RelDaOSxi9PXFodxZV4ukznymnn5hrcU3iYqoDNUyDAzSCjj
 Gdxe1HfCCC9iitupnr6/5DTNomAHCEiNaRaQfuReNV/sW4CO6p81acM0ozreb8Igrx
 dIsTdXNz2spypjLCt3yCj0bWj7G/TkaHzULBiT2ikFupJNDB/3SSH/9/VFU5BvceRK
 Ic0m/w4KVQUvw==
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 11 Aug 2021 06:19:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: david@ixit.cz
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-206057-202145-CrKFqrtXNT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206057-202145@https.bugzilla.kernel.org/>
References: <bug-206057-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1mDhaL-002ffa-QR
Subject: [f2fs-dev] [Bug 206057] 5.5.0-rc2-next: f2fs is extremely slow,
 with ext4 system works well
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

https://bugzilla.kernel.org/show_bug.cgi?id=206057

David Heidelberg (okias) (david@ixit.cz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #10 from David Heidelberg (okias) (david@ixit.cz) ---
Currently Nexus 7 2012 works on F2FS well, closing.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
