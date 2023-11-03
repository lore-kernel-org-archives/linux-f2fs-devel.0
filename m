Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FBAC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Nov 2023 06:26:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qyndK-0006KH-Ks;
	Fri, 03 Nov 2023 06:26:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1qyndJ-0006K9-Ug
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Nov 2023 06:26:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v21NKyTIYMyi53RBFoR/frPCQHogIgtMe01pTut8RPQ=; b=X+ZCexkVI1cUh3Fns/hF0ESgpz
 u69g1LBkFyxYMFT0Izz2z3AmfnDrK6dgIGiYcl/vMH2sVj71sc/SKNCFT9cRzavjAiYMGoH72OiBR
 bIqwZZrDU0nL+ERAkdL5MwfaweJJevX3KoP74Ej9HPe++dpY82DwFDu+CXKPPewaQvdE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v21NKyTIYMyi53RBFoR/frPCQHogIgtMe01pTut8RPQ=; b=b
 6GPhIYQx5HSXNvulkA6MNkzn0R36OtkCZV0/74Ij4iXi0xMzmMbOb+X7oRqag+ZE/Z5/5pGGCUO2V
 Yq4qYBNz91JCTnVW0+m0BPzdI5YFCBDt343qn5JVTok73+wgqlCABBoNlxk3/+Mu0rRAWv7joyKZC
 LkvNJQk+h1tmmM+M=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qyndI-0004ol-El for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Nov 2023 06:26:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 0AFFDB81DDF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  3 Nov 2023 06:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62EDBC433C8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  3 Nov 2023 06:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698992764;
 bh=9Ty3XEsYf0GSLon4TojUIcdDC661hKfrlBOI/UNUlvU=;
 h=From:To:Subject:Date:From;
 b=k/bGGCQVEn2iAlXjG3fQTXRh1o+cjg9NRt0vfPy/uXXkrjWwBV4AzwBq0Ec4s0/jv
 sEpJn1j6W76sQ7nwslw5+1+MO06ihMHTDJOS+iQzJFfN03rOQAmVv7CDKCnDc6MIa2
 iXkjUxG/pQ64CrVhQe2AicC16zVNcQGEduw5BsT4bQKBSCMr9pEeygRsfXl6Cc9Sgt
 n+jVc/Ezashdn6i5nJUB9+sNTM2J/XZB9rB334vyU12C6tccEldRHgZh/IBLI7t0JI
 2ck8EJ607aLKgE2yEWtmM892srjlG8sYVfh/YaNUnI6Rl9oOE0jAFQd8pqRZF0BJij
 DOpxwtIhyssoQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 4544EC4332E; Fri,  3 Nov 2023 06:26:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 03 Nov 2023 06:26:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: slandden@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218096-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1qyndI-0004ol-El
Subject: [f2fs-dev] [Bug 218096] New: first 4K all zeros when
 release_cblocks set, reserve_cblocks restores access
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

https://bugzilla.kernel.org/show_bug.cgi?id=218096

            Bug ID: 218096
           Summary: first 4K all zeros when release_cblocks set,
                    reserve_cblocks restores access
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: slandden@gmail.com
        Regression: No

Using 6.1.51 on armv7 when I release compressed blocks then the first page I
read from a file on the F2FS filesystem is all zeros.

f2fs_io release_cblocks <FILE>
hd <FILE> | head
(first 4K is all zero)
f2fs_io reserve_cblocks <FILE>
hd <FILE> | head
(first 4K now reads correctly)

I am having trouble reproducing this in a virtual machine however. This machine
has 3.5G/4G if that is somehow relevant.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
