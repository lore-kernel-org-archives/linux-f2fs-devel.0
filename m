Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5F2C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Mar 2022 10:54:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nWFga-0002j9-DF; Mon, 21 Mar 2022 10:54:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nWFgY-0002iz-6M
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Mar 2022 10:54:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=azqoxDNPdtignEkoAPCeVMyMR49ObDEpyqSVPeyeyHs=; b=NkwTm/ipczyN5vB4V4Ay1nwETw
 GPRmkRTb3WtyDtB7XUDfRQbptl+BQPfIvntb9KVljjxGmj0KPuEb7bYIQGaoDkwJ7lkkFUCqKo4NY
 JTioIu0kHQF5fN1XFtNYwTgozTIfTv23Je2Vb1fSyJJoNd+ZuJB2a5yNxZMFRpnkK1wo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=azqoxDNPdtignEkoAPCeVMyMR49ObDEpyqSVPeyeyHs=; b=L
 fuckKpS3H6MSB9pMHgnRG51EjGxstlWM2vpX+0BrOf/drm03Rk131+y814Ti3Wh9ylWZzwbxm3Mt2
 tI2tf2ACDhD/qe29RTY0S/z3s/wujyaELGXgwNOIHQ3iMExU2x8jU7ZIs6qDEuE0dHzG1SLqBglYH
 ZKQ6b5M9ZJEYfVZc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nWFgT-0003Xq-8r
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Mar 2022 10:54:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2C425B811BE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 21 Mar 2022 10:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEDE6C340E8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 21 Mar 2022 10:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647860072;
 bh=7W/8/xCIpPzSeZC43ulA89UM+0ecZZFxlfrvQH3IXWI=;
 h=From:To:Subject:Date:From;
 b=U7JFCqmN8BEvGIl/2MkfMmm1FXZsKON265ciIAJI9ozzZIjYQYT4/fb+bUFkrApIb
 wI8XLKRaPj+uxgxqsr52fZgGHEAema4m31fzMt1oP9Cb1JkoLp1qZL4Sahp71IvqaI
 NLHb2GodvSe1n3bUBHsokp664N3Fv2ynGR/ZWHpRTKtNYvkSnQKGEzmljXfCNbrTVO
 FXOP6oKfcq6CxQcIdcVQoD897TP650Htd7JLoJe3PDF2MdNSuDxUSwasBzDdgqrm5B
 KsJKGGgGI5aA/q/4IKrHk6lVeXs33uQdpXx9+7gfh76TCRwJXrF5Cifvhshft0OY/L
 8cEDqQrhIOTuQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id B0A79C05F98; Mon, 21 Mar 2022 10:54:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 21 Mar 2022 10:54:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215709-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nWFgT-0003Xq-8r
Subject: [f2fs-dev] [Bug 215709] New: kernel deadlocks while mounting the
 image
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

https://bugzilla.kernel.org/show_bug.cgi?id=215709

            Bug ID: 215709
           Summary: kernel deadlocks while mounting the image
           Product: File System
           Version: 2.5
    Kernel Version: 5.15.4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: yanming@tju.edu.cn
        Regression: No

I have created an image with mkfs.f2fs, and modified some of the metadata of
the image. Unfortunately, when I tried to mount the image with a loop device,
the kernel deadlocked. I have attempted many ways to stop the mount process,
even executed a 'kill' command, but they are failed, only what I can do is to
reboot the system. Can anyone tell me why the kernel deadlocked, and how can I
fix this problem?

I have upload the image to the Google Drive
(https://drive.google.com/file/d/1DBwKP0-MpkD3eHPTluz3KPcxbdZAw06t/view?usp=sharing).
Looking forward to getting a reply :)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
