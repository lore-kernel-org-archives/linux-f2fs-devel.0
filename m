Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26D3C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Jul 2022 21:16:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o7Nzb-0001rN-KC; Fri, 01 Jul 2022 21:15:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1o7NzZ-0001rB-KQ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jul 2022 21:15:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U0beY1Jpze4+PMpqNi2/9cnHxs+Mt1p7LJiSEtWCTVo=; b=Lip/cYq8epXXfXqm8ZRjir3/tP
 LC02BFoJ1vgw+Vy5T70SwajS2hnGuaHvB1hZVuE5pstkXlT0+/mV5cZQwLksflrL8IHEdFsTy3S1f
 RMTCKkrk+eWm0H1C70XxWVAmt9zvOR9h6E62dnhAlEDQ8DaLiob4MIioNSUyb7tb4Jfw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U0beY1Jpze4+PMpqNi2/9cnHxs+Mt1p7LJiSEtWCTVo=; b=UrQb+KL8kK+qvnIfZL8z/8QdgD
 Ni5JFU/jPRlwXVBhSOIjok6ZdZ6Gmb5uDYQu6jG4bIYU8y/04NaiDSvt/W+2TbRPTUyWFbDejrAUp
 uMYeeqtKTS0qzERSXLXLjbmJNMTWAc2WOqZl4Cg6vNQ/LNNWCbEGBmcul103qz5VFIpA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o7NzU-003y82-SO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jul 2022 21:15:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 3928CCE354C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 Jul 2022 21:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DF54C3411E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 Jul 2022 21:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656710136;
 bh=U0beY1Jpze4+PMpqNi2/9cnHxs+Mt1p7LJiSEtWCTVo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Ak+xwLkrHSvPGynzKtdJ8RXUgBv0j3ijnQnxG6Ua8Y/GwiI3X5SBLYyt5kD2BfqZm
 5BRm6nIPJxugjYz6AqhzI+WFToJQPibJmA6I3xz3L9njScwWk129pngv2k4p9uzG2z
 tnzjc2DuXZ1lpvy1Kcn0SKP1YifSyMw/v4E3lLz4uio56GlskjSa3Iu08QWvDH989b
 uJ10NKJNlp//II2Z1rsQvJphAed+mC5R4SD04Ycvx/MHc4nDsMo+j8m7gcbEk5Y+v4
 H3xyyPAH0+z2eFvq7PtSRh+XFcpRSxO1AY4yk1mHvG/Db2+eUCUE0tnnyRADQN9sXw
 IBoryu1zofGjw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 83D68C05FF5; Fri,  1 Jul 2022 21:15:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 01 Jul 2022 21:15:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yuriy.garin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-qqLCV6NDlu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1o7NzU-003y82-SO
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

--- Comment #32 from Yuriy Garin (yuriy.garin@gmail.com) ---
(In reply to Jaegeuk Kim from comment #27)
> Re #25, the dmesg is waiting for f2fs_issue_checkpoint, which is not GC. Do
> you think it's hung by other f2fs_gc?

Frankly, I have no idea. What I can tell for sure is that normally there are no
f2fs messages in dmesg. But all 3 times that I had this problem - 100% CPU by
f2fs_gc, there were similar f2fs messages and stacks in dmesg.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
