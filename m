Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E87C77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 May 2023 16:11:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1puy1S-0000f9-Vx;
	Fri, 05 May 2023 16:11:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1puy1R-0000f3-LM
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 16:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JuERPl7P4baGWw2XUhcPYMr3bPUwF/oHbidI+QWlZfA=; b=D2rPlK4zRnZ0LDea+PCO+9XXsk
 UiJRVW6EQO4sPA80JrzieYENAJRwa5NseD3NCMsJ+mp+edPbb0k1XdBnYaHwrLjzF/KSP6A0JHFUU
 AG9jpB4uNKfWBzTLOntBJdgiYa1bwlMfDsKhtXkEoeIXza48QRRMt11vh7MDuhUGDVlI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JuERPl7P4baGWw2XUhcPYMr3bPUwF/oHbidI+QWlZfA=; b=QErhhFsZiTLxDr42oRs0kvsYDZ
 w76X1T11GP9/qXquM1NTarYTwSuQDg2TXAP+0v862na1VjJAFKFJVzxFwVIYALbS/ZpxarBAjHLzf
 Vg8nWYHNL1aYjpcBmJpR/H7p7gUezryXByKnQlLXncLTsH3+G4aotbp/r4BAix36qKqc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1puy1M-00FQlb-P8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 16:11:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 33B1463F0D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 May 2023 16:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92FF6C4339B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 May 2023 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683303049;
 bh=JuERPl7P4baGWw2XUhcPYMr3bPUwF/oHbidI+QWlZfA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Ake1bPIACxEh6V2Gm74RcN17GABCvVlHwyPJ8bRl6GjPB4IAc+Lg3QFTwa7z/elIn
 m2WG2EyvTOpS3Tyt0dpaOwZEHvqtFIqUKG5t1Tca6MZG+888cYUuD+BLCpKpnLN5gC
 7FtN1Qeo7bS+ROobroOFrdu8U/DAGUsMrDBH2cAuaDSqYDyyCfWN5hV+JpB1UQpWPD
 bAv4B64tDojXPKghHhKhemItfX9gVttdsqfAmgRQlNd7iSLqIwMmOwJL4BdMSGs9x0
 O8CqX0r9Tx4gpt5qEMePxPQyrutGf7GjChl/SrPTaqLuXTyxRgTSzpqla/XwnNpUgW
 ghLj1IFtiHPdA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 743BFC43141; Fri,  5 May 2023 16:10:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 05 May 2023 16:10:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-vRhweEoD7K@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1puy1M-00FQlb-P8
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

--- Comment #160 from Guido (guido.iodice@gmail.com) ---
After several weeks, no problem. I also foced gc now with no problem.

Now I would like to swith to kernel 6.3, what patch I should use?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
