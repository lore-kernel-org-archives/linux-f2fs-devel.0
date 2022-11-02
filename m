Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1219C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Nov 2022 16:59:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oqH5e-0000OB-8W;
	Wed, 02 Nov 2022 16:59:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1oqH5c-0000O5-ST
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:59:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZglQcrqmc4gpqd8gumrt5a0LqZuP5yHWyO8Xs14+BaQ=; b=gXxv4qqpDtThU2j0t2N+REEDHK
 ltU/qa8cFFVNgjZzWw6Q/Hhqjf6BfoT14GyWSeAEZLu7vyJ6fXu+ZnBdasMMHwdsLykV6Pt6GOpto
 KPlwMrOAOIYsfdJyoiI6Ao3wjnNrCpmMDabBmWtURaZuQtqfkpghmVjI0Zr1i8NwEazs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZglQcrqmc4gpqd8gumrt5a0LqZuP5yHWyO8Xs14+BaQ=; b=CB0K1MsL13vWvTpCgEhsAqqPkW
 wcFECy1c1HWH2T4WN6DQGyyTh15rePwpSW2N/5LfvBR0vJz7Cvlhq6Lx/yw57W3uJv0REsSwn1CF6
 dMGPCk3Ca6NO4op6D4r4oSwRuhFE51fbj796S3PHEnwEh1j5mSzOlzRDW7EcbxHlTtEo=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oqH5a-00079S-QX for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 16:59:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 90EECB80DA8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  2 Nov 2022 16:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 375E8C433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  2 Nov 2022 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667408374;
 bh=ZglQcrqmc4gpqd8gumrt5a0LqZuP5yHWyO8Xs14+BaQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=RlkrJp78WDAcMIcxmdpKmYlIP+u9JlpNFh3ZLA++Ea44dGnpT/Z37KX27Wpk8tEYQ
 72DIvJujblYnFzVJTrp+WGwnQogMakyuRLR1EDhoBcBHm09fbd6Fksnx77/xyPynsj
 Z3WMY83tEWUw4M4aD2RfdbKEafPUK0hV+qZEv42qk+qZuL0z2NtKubGi6LY3Wt7xEe
 5IjMxx/LznUaaVdV0RPIACa3PWfNjQqWNm/p0/lLG1Azn4macrJ6O/4aqYl+N2XWRL
 tUMa6rxPXwfvci8MBBd+WXgR/cFMdj2i6z7DU19qUiU1kSNc61lBYrvmdGc1m7PUvc
 dkHbjxwCkeLWQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 1BFE1C433E6; Wed,  2 Nov 2022 16:59:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 02 Nov 2022 16:59:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-7ZMmLWRpwT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1oqH5a-00079S-QX
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

--- Comment #71 from Guido (guido.iodice@gmail.com) ---
Since the problem occurred with the 5.18 kernel, I assume there is something
wrong after that version. I think the analysis of the problem should start with
the changes that occurred with version 5.18.

At the moment, I am still stuck on version 5.17.9 for this very reason, which
in fact prevents me from using the PC with more recent versions of the kernel.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
