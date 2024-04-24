Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956C6C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:25:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rzbgv-0008HP-L3;
	Wed, 24 Apr 2024 12:25:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1rzbgu-0008HI-1H
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 12:25:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Scp0c4xZK08UkIetzWOkeiFtPcP75zq/2dBHw96JuYs=; b=F/kNmbznAp5/ELG8aC/p4sgOUU
 eL8G8kRs+usPTHZUOV5KS6byq6JvR6OBBa8nLQIGN1PQjC4FESZST3IQeMweJNI+kLvNmHXPPE00H
 y1WwtAtq6eGqB8bliCGUABj6z0IV8UAEr9INuBrWIuufH/SR6c9ALD8H3jWS4F9XL5kI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Scp0c4xZK08UkIetzWOkeiFtPcP75zq/2dBHw96JuYs=; b=XScnEGtVYQG1QhdIYgJKV4d0oY
 eR7y1Uq5v7gfGjYhukQqCt4Q/dvsTPPOgmZqLbc2Hug0A5VTF2i3tCrP5B7J/2kp32hEwUiQgI5Bp
 bT8QhVfsSR4LbySVvqnFKVN5ua6joCCU5SyGfME2+T8wgNPb8qkOyMTXlBczqKtV2fLk=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rzbgr-0001fp-8k for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 12:25:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C60C6CE16C4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 12:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8F40C113CE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713961525;
 bh=Es4LcOmNwC4fx02DGehCA8pbhKG82ip7N647H6Ao/Bs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=HvkTmU6pcgS6nJptu7529HCWXuk72ZU2RxMNmh+bwRbiz7lf7Wcz9a7KYOf+xhud8
 1EdTF+/+DVWAnpCXCEH/kmHj9cG/gJYoYi4mztf1CaPpvDleDYESGpX/kAJqUhKmru
 5en55fXV/tlOkjVFcDw6Wgq6wbKJFY40pEy6W4lIWi/uF6aMiH7BgCTwgw0PQrKPOS
 g+tmmHSzSXMfRRm/TFIK+21r4EBXS8+7VK2C4HaKr/Zc+8sJ3+rMSnHQ14McMUFywi
 dgXrK53jWsEU4ftON7+A3H2cqhJL2KN91VhFlDrX9YKfUuzdWKK7JOq6AyykJlS8SQ
 ZPiHmHJhZatKw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D3509C433E3; Wed, 24 Apr 2024 12:25:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 24 Apr 2024 12:25:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution cf_regression
Message-ID: <bug-218770-202145-5PahhaMxMw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1rzbgr-0001fp-8k
Subject: [f2fs-dev] [Bug 218770] fsck seems unable to solve corruption
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

https://bugzilla.kernel.org/show_bug.cgi?id=218770

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|ANSWERED                    |CODE_FIX
         Regression|No                          |Yes

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---

On 4/24/24 12:21 PM, Tor Vic wrote:
> 
> I can confirm the constant fsck issue, and it was fixed in my case by 
> the following patch:
>
>
> https://lore.kernel.org/linux-f2fs-devel/20240409203411.1885121-3-jaegeuk@kernel.org/

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
