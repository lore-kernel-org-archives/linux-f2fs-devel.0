Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B805DC19F28
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Aug 2022 19:55:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oJKSp-0006wD-Aa; Wed, 03 Aug 2022 19:55:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oJKSp-0006w7-0l
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Aug 2022 19:55:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5qfrPxr3ZrqWmKrWnpHwbA12sDWBzb0DjS25t7Dl/8E=; b=DBO60LMQOyiX9y4nEYCmtQU6g8
 Yhrc0pVIVR+GJd4+85zu39wgcb6AIC8ECSPsZn6ruWQfShXd0HS5AXOfV4YbarezBvBE8mW/dHzmk
 8r+lkOz1/2l8bGw3opITcy90Qd/cSqyEEoq8ozijZMUOBvn8LMYoxayDeLPVWbB7Y/C8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5qfrPxr3ZrqWmKrWnpHwbA12sDWBzb0DjS25t7Dl/8E=; b=YhXOZayo+FAPyAdiph84zhTpWc
 fC1FjZwhBUQCrTiMwreGq/PhoGi52bbW9zVAuXcNqxIRtMPb33AMlYDba26Csm54PWrRIznczbo67
 DXzkmeNl68NxepVF/HhcyC8R+9kkxOWhfYYIEgTzApD16SKtF26D6gFDqaU4A/f1S0UQ=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oJKSe-002AfE-Jz
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Aug 2022 19:55:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 582F4B82311
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  3 Aug 2022 19:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18962C433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  3 Aug 2022 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659556513;
 bh=5qfrPxr3ZrqWmKrWnpHwbA12sDWBzb0DjS25t7Dl/8E=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=bCB0+SKHzD+YKORg9d9nui8Tb6iIwtDTp9/jd9KseUDILGpeNpM4RzRovXzRXCpL2
 uOnPYKnuOC8qx2teSKwic6pkjvPEUKgmu5AzkNfdFamAAXehFdflK+EATp6wjO5GW+
 ZTWZRNhoToQHXMfe6iui0I6DnH4KA2ymNAAuBwlIiq8YcKL+Xhr/9dvjnjoonsDB83
 SCYlfB/ZO8utiD5QCQ3CaiekoZWSasthXvRN1Gc0LUQllSw6nn6pz2+YULlNt6n3zU
 5t4vNK6qzBehJghQq3uBS+CMIvd4SMxihhNnoe3x0kkOJNB0ZW1MXnRa+5FpmbU4dN
 aOeZnovv53Llg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id F0FE1C433E4; Wed,  3 Aug 2022 19:55:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 03 Aug 2022 19:55:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bbutscheidt@yahoo.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-9FktSKWu5L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oJKSe-002AfE-Jz
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

--- Comment #48 from bernd_b (bbutscheidt@yahoo.de) ---
(In reply to Yuriy Garin from comment #47)
> 
> First time I had this problem was ~2022-06-15, at that time I was probably
> on 
> kernel 5.18.3 or 5.18.4. I had it on 5.18.6, see #25.
> 
> After next upgrade and up to now, kernel 5.18.13, I did not had this problem.
> 
I used 5.18.14 when receiving the debug output I posted here.

Questions remaining:
- Better to apply debug_v2 patch to the newest kernel or stick with 5.18.14?
- I would like to start to only apply the new debug part. Therefore, I leave
out everything from line 43?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
