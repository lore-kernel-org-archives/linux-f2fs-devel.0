Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A646C00140
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 Jul 2022 02:51:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oHG60-0005DO-7I; Fri, 29 Jul 2022 02:51:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oHG5y-0005DI-F7
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Jul 2022 02:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nPeIeKssccgcymXfSwb89sxYDS8GKFleGsJMeAUBMhg=; b=K2v2fcJWbftbrqFM/hsfJNuWPn
 uhku0TAukqk+rwN/qJjc5wp5MRT1FVb4GiQW/6yroEHyGw6kRsGZOQIoPezzqG9MBnVikA61Rvzrs
 pqej/3tr2vm6Tv8srqb3oSbmycoa3J9bKs3p6NFa8Tff8RNdGkIuF3Flca9bHSuNVViw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nPeIeKssccgcymXfSwb89sxYDS8GKFleGsJMeAUBMhg=; b=bCbWUSTZysuF3j/+LrO9pyNj2d
 KevbNyX/IPO4x0QSDejtENcylAkbwIhSXgSWV8845pPpy1NN8u2RPDlHu8GApoGG1ABWWBcdVhw5r
 D1PnnCBnMIqVT0xyQ0nyg4oHGerr1mtBbwxq84jpbmtTDH6Lxkwqb5bukGE45p/FlITs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oHG5v-0002bd-8B
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Jul 2022 02:51:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D6B4361DEC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 29 Jul 2022 02:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7F24C433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 29 Jul 2022 02:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659063069;
 bh=nPeIeKssccgcymXfSwb89sxYDS8GKFleGsJMeAUBMhg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=aB1unUSHimXYdPthPMC0UTiirHe9WOH0fQxuRKQ69emelfiNK3OrMLcuaN2OMP43a
 P/10PsyhsBEpybjGvKp038q9RdWNfVZbwS1WH7Uk/+OYMghtv9TCf/2DJJXvg5lps5
 hZA6LDFuU299BEbxG+GxspZCs4Iu9cHH7+Xv7rkcZzhEMB8y/GTLtm3guNiJtXkwqk
 ZFUEkKOQARFaqCH9zQsFoSObvqDzBKWExbNiouwE0Cddnb4kMJwlt338zF7k4C/Jth
 cWKrUa89i1TyrpjBxkCzZWI1aEXrcMbjR+38Ogsx5Bj0QlbQRiVVk9VeOerf+qUycR
 aY4rsu7k91COQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8BD8CC433E6; Fri, 29 Jul 2022 02:51:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 29 Jul 2022 02:51:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chao@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-vLCrUGANqn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oHG5v-0002bd-8B
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

--- Comment #43 from Chao Yu (chao@kernel.org) ---
(In reply to bernd_b from comment #42)
> I added the dmesg output in the attachment but I fear there is nothing
> useful to be found.

[ 2443.069033] f2fs_get_lock_data_page i:205012000
[ 2443.069688] f2fs_get_lock_data_page i:205014000
[ 2443.070016] f2fs_get_lock_data_page i:205015000
[ 2443.070344] f2fs_get_lock_data_page i:205016000
[ 2443.070672] f2fs_get_lock_data_page i:205017000
[ 2443.071000] f2fs_get_lock_data_page i:205018000

Thanks a lot for helping to debug this bug, I guess the output looks useful,
since at least we have found where it loops at. I have no idea why it loops
here since it's an impossible case, I can make a patch to skip this loop, but
I'm afraid that won't fix root cause... :(

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
