Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75C8E7717F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Dec 2024 02:11:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tLCCF-00070r-30;
	Wed, 11 Dec 2024 02:11:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1tLCC5-00070f-Cx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Dec 2024 02:11:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fBNIMDIfuafXCJ/IMsX/OjJQjvTVc0K1tFVI+B2RwSs=; b=V4zQ9cbrV3jSRaOH4CSX3frORw
 MtLvzcqbbWZQh6dmCewXUIRIOYCxac43+xuBQx3ut7yYUPt8xd92j6CabQlP6hWuNNCtXA+VWJ82w
 nWBPTz9or/jjDeJechU1YFIJr4IqGKE1nMzFH/5TkDniOD6mMwdISvZwbLLY8sl4YnXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fBNIMDIfuafXCJ/IMsX/OjJQjvTVc0K1tFVI+B2RwSs=; b=GToTI8o74LJBWUCHZm/zKIVB0a
 B4f1FEIwLbZjA8RL2DmGti/k/dfDb1H6FdTmdOCUhPYBYcW824JoEEt8YZP9IVNpzwgK9yzrKaNAS
 iElvXwyceVj4PU+7gNkTsxClgMrG5l1He8vAY2sTzBwUo0izEu/t1NmdRA9B3csBusYo=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tLCC1-0003g5-8a for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Dec 2024 02:11:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 32D99A41D39
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Dec 2024 02:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41BE5C4CED6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Dec 2024 02:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733883067;
 bh=fBNIMDIfuafXCJ/IMsX/OjJQjvTVc0K1tFVI+B2RwSs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=gCqbAt46LkVtzCxD3ESIckG7zAciTHUd97pPqKOF5baD+MnXQe+UDfCpk3yF0pDWF
 rNi8O3QV7dEWWZnR+Ssor0zsrukCa5ENo+eMAdz5j7h8PLmjutlgeVYZ1qO9UPqQBf
 YIfTgnk23EiNl3vbxtJIKeQstXb2vVZuQC9IlHavUMdDmuU+qtw3sKHBzGUdUPJWxH
 Ce70W7fnr77WCTiIb8lmizoNLfTVbE5ikOWMvvWSs/YrLkCPGqWe+cVqtsIQ+R20qZ
 3oHOYQwC25L4BMmfwK1kWCmowta22bYhQ4Z9q+ISUEiyE0An2LMfGnji+9CnsCKwRl
 3I6J/ymvlkIlw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 24480C3279F; Wed, 11 Dec 2024 02:11:07 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 11 Dec 2024 02:11:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hanqi@vivo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219586-202145-uFtTMcsE4d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219586-202145@https.bugzilla.kernel.org/>
References: <bug-219586-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1tLCC1-0003g5-8a
Subject: [f2fs-dev] [Bug 219586] Unable to find file after unicode change
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

https://bugzilla.kernel.org/show_bug.cgi?id=219586

--- Comment #2 from HanQi (hanqi@vivo.com) ---
(In reply to Jaegeuk Kim from comment #1)
> Hi,
> 
> I think that unicode patch introduced a regression, as old and new paths
> gives a different file length. Wasn't that broken to fix?

Hi Kim,
I'm using the latest version of the kernel and following the above steps still
reproduces the problem, can you tell me which patch fixed it? My kernel version
is as follows:
uname -r
6.13.0-rc2+

Currently, the f2fs.fsck utility can only repair directories or files that are
not encrypted, but it cannot repair encrypted files with the encryption feature
because it cannot get the key to calculate the hash, so it cannot repair
encrypted files with fsck.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
