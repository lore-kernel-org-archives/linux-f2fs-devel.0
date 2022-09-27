Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD42C07E9D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Sep 2022 00:49:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ocyn1-0006x2-QG;
	Tue, 27 Sep 2022 00:49:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1ocyn0-0006wm-DI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Sep 2022 00:49:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=venpNbv3OoFx0DhZW4AC/B1VGY9wDU80bIIgnvj87q4=; b=gtI3stfXLwyXG3RGcM4WB7xkYz
 k+S85lCdlnTar+i4NbBSdBILCHqQkjgHff57L3S6RUU75kjrZkq0PSbv5UUauEVJnd7QUggtgFN6C
 ka3eXcGyraNgy5JsYlfV82BiURlQYqf7PBr8NNzrokk6cGKNXItMIZnvaToUBAy8MTQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=venpNbv3OoFx0DhZW4AC/B1VGY9wDU80bIIgnvj87q4=; b=OLn1BMCH+r45T08Q638f6qy17X
 LfHcmnaxNTAMdA1gIn3p47SwOJY7svAdO4JihOtxIw09Bj2qAJaYJ7Jf12mTYevgY9wcDCJ1Fqyq/
 cW9pICVf8TeeSJ9Wjn5f67xO4CIpCBN3Zp7iNEBUe7DdGjgO3MMzz2BmjL/cEOq6k9+s=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ocymh-003xdL-Mp for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Sep 2022 00:49:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9C1B0B8170D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Sep 2022 00:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65748C433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Sep 2022 00:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664239743;
 bh=XshBo1SdrZpWj09lDzHOhFpRHzo8fE+/VEtHhW7RdAI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=az70msycCsZKAMFoxdBUPDskCZNdsE1gZPp0tMdiG5584G5x54+BrNj4ZRXOKl1YM
 8J6nlJ3L91hdFkEevcMiOI+WOBXedXkRFrO/kvjr/wBlGFUDnnyoESyuLWmq3A/+cW
 AtUaEXNRYbE8nCDcblVVfj4boHeMCerp0MX3xKn4yjmlTXuua9IdPnXOKltlDbbJyr
 LH4C1GW6nPyE6HlToHwJeocaUmOmsth73yXUEYZpb+nQHoHN9NlF5zGbXDF3X+6bQk
 9GbiYg20PFMJ+0n9t4w5zEBgnFUVNrFxh4nMuwO5YYVB3LC29hU0hWpptaNFAca+Y8
 SwsNy5NxNn6VQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 55D42C433E4; Tue, 27 Sep 2022 00:49:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 27 Sep 2022 00:49:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Zhiguo.Niu@unisoc.com
X-Bugzilla-Status: CLOSED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-208565-202145-Z19X3kgGrV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208565-202145@https.bugzilla.kernel.org/>
References: <bug-208565-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1ocymh-003xdL-Mp
Subject: [f2fs-dev] [Bug 208565] There may be dead lock for cp_rwsem during
 checkpoint
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

https://bugzilla.kernel.org/show_bug.cgi?id=208565

Zhiguo.Niu (Zhiguo.Niu@unisoc.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |CLOSED

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
