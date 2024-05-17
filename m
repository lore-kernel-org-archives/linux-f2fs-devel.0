Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A88C04FFE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 May 2024 20:02:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s83mw-000226-Hg;
	Fri, 17 May 2024 20:02:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1s83mu-00021q-KV
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 May 2024 20:02:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OYpJF3LzWRRric6t2CpocxobvDPHpd3kIJwFDviGVzU=; b=YcGOJm+HMSvWhjVFIJo7BHOZio
 I9IXvx3zFXF+Bz3nMSkv+q6k84KPwJy+bsOKyLY+Ew5ra/R5q+tiYZXUnMHUecq/xv4sGum4wygJ7
 kp+OW9d5sk6wfh9h0kUsNMW5Yve0ZDnfL+o3snl2NEMJOxcfd5TAPXI+CLrENm6EwYTw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OYpJF3LzWRRric6t2CpocxobvDPHpd3kIJwFDviGVzU=; b=mWzZ8PmJX+PIz5qImV+vw7nFLx
 1zI9euBHN2Hob8w5W8aKcU4inIiazG+fmIWl+tuBAmWMPy91/kHhijMP2p5XbfyZ9ddNCscNmyW1l
 sz9V5HzEUtWI5sARXnzUtVGZlzKxESmMFp7orP9zbnGTfyyIki+thJWW1BVVqzpYgpjM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s83mv-0001Wc-3Q for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 May 2024 20:02:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F256261E2A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 17 May 2024 20:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6A72C2BD10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 17 May 2024 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715976153;
 bh=OYpJF3LzWRRric6t2CpocxobvDPHpd3kIJwFDviGVzU=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=ryQvj0suJRHxfh7tBrUs1/z+SDYVOPBZUkoeBoAO1r7ZRjTEYAdSdMFC91ZqGajYx
 fWs1zG/qtr6krtHHlzVbu1+Ut1Rd02dQybkKZJqj6kBNMcWRMXUB1eFWRG5T6DuSnE
 rY6UPqT8W2ON4TCRJ/9Qmib6C/4yaufuiaZ6nHg7gb1YFkxP4XJ+NiDYk+BtjETCuX
 BTnYTwgEEz0H4lvEBX4JlyK3O0/FGAswOwnn5FctJtKXvjcYvVvdu31JqUAlwDcdCY
 z2Fp63o3nSsdbIPLyQO62cwCd7X7rTB9y6G0j3/ccv0LsSCP5mEotlZ2x8Miz8Wcn3
 F+wWJcSxKkWyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 9508FC433DE; Fri, 17 May 2024 20:02:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 17 May 2024 20:02:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: guido.iodice@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218770-202145-pN6AHTxBx1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218770-202145@https.bugzilla.kernel.org/>
References: <bug-218770-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1s83mv-0001Wc-3Q
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

--- Comment #10 from Guido (guido.iodice@gmail.com) ---
I applied the patch to 6.9 and it works fine. I am a bit surprised that it is
not already applied to 6.9.1.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
