Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57018C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Dec 2022 01:04:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p7nWn-0005ig-MS;
	Wed, 21 Dec 2022 01:04:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1p7nWm-0005iO-QG
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Dec 2022 01:04:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/Ir9kF3+VyqY3s6udyQwVSuky83F0WX9JdBvMFD2E8E=; b=kFH/uKiOwz83n0tK7jdkp2v+2N
 s+nYGPGnyz/0Lm3+Mr48BBhGASiggQUq6HspBkwGEPFwJr4KvFZph9oZYZdvVsiSJ7OA5jlgNMrpK
 losaKRZwAweP9/PLuGGukdwcPXkHUSLcj4a4JZLYa2Q5hC4YF/ZCDOPQuPGE1mwvyE0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/Ir9kF3+VyqY3s6udyQwVSuky83F0WX9JdBvMFD2E8E=; b=mU8px8syrUnGfdRzkD/g+3rup1
 4wV3OxcLMdOnYvk/EGCXje7Eov+6yyfRmzATcd8XoVudbha0VGmaKUhSIh0vnj60fk2tuZDIUOeBt
 JItKbMCrVFJDIABlFikosOa9PlZeYyoyejMjl1uAqwyijVSg0QTc0KmBW4aLKXVnvg1E=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p7nWm-006GiI-7T for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Dec 2022 01:04:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BF3E36166E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Dec 2022 01:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26EEDC43392
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Dec 2022 01:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671584646;
 bh=/Ir9kF3+VyqY3s6udyQwVSuky83F0WX9JdBvMFD2E8E=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=iLabGvM0VYCodbYz+E1hETejU9ZFgAe3HclvO2F5Nyh1oWa7c2V+7G7a+7bUc4WL7
 VuwfgNBa2DyYHm4W1vbwcRGhV3Uix9WaCXR/FFRMqX3BZh75N4MwA9GZem8aMTddm+
 n3YIICwClrrSjFUhpF46ldFce9MAvDqWT3wvLuby73iV/RurfkPuCZ32828okut0qe
 wxGynKQsGDdAyl2IC0L9HsuHWyEKv/Fo5xDOIS4wOCKEicXdDkSvIcr6IgeD9kUFdz
 zt9KMgJraYv+7rhoy8KUsXm/yKNItBkBVjzFfXlJFFeQ//+RfVfcFBiYEfYu0eXwpg
 qq0KuzhwvHFrw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 049B1C43141; Wed, 21 Dec 2022 01:04:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 21 Dec 2022 01:04:05 +0000
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
Message-ID: <bug-216050-202145-WzJQ0aAVTZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1p7nWm-006GiI-7T
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

--- Comment #121 from Yuriy Garin (yuriy.garin@gmail.com) ---
(In reply to Yuriy Garin from comment #119)

Forgot to add note:

$ uname -a
Linux ... 6.1.0-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 14 Dec 2022 04:55:09 +0000
x86_64 GNU/Linux

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
