Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01E9C00A5A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Jan 2023 13:19:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pIUp9-0001BL-B0;
	Thu, 19 Jan 2023 13:19:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1pIUp6-0001BA-7d
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Jan 2023 13:19:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lSIR0CQTZ4zEsfVZyaIBiyNt4XjLMcWEJoaM0oE6mDs=; b=AVjcDbBnx/E9ncRutG6oaGmoRR
 tZpitdLTysxMPWdvc6B3+g3NvpX14yneGOVNpG+z8cg+qgJ/ShecwFvog8fJZY1ESC88lWuQRtbBT
 QnlMoIrXemZvfBsuutuwVdSP3reg2odVylbgKuWTFb1NTfSSJIz2tDDF1QpFcX+PAcfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lSIR0CQTZ4zEsfVZyaIBiyNt4XjLMcWEJoaM0oE6mDs=; b=aXYgq6hg+8b73RJMmfXKHZvV8N
 cT4r3w0/eG9Sg6QvKfp8tHQfX9eg0IxT+ueNf1M4UqHU0ktVGXtbknd7abspSsrdr4Ybw8uL1jzmE
 ZYWSadP6mrcxW+PqkY1vLbaGcbQwA0azFaKjoOmoyF5JRExxf3wSnIYPj4BBjxjtNODk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pIUp4-009AWz-31 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Jan 2023 13:19:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AE8F06127C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Jan 2023 13:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9727C433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Jan 2023 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674134351;
 bh=lSIR0CQTZ4zEsfVZyaIBiyNt4XjLMcWEJoaM0oE6mDs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=CGn9pyfbF6BsU/nut2U3vrpiFhLGIxZ/Jlv3FI7XGPIrwwrFAj5vL4vtTI7i9/bGx
 GSpct4SVPG/RGYYl+s0mglMW7tRIO7guoO3WhS5WsaB6GJFEM1n8Fy/eQDxB2v5d95
 HhV51Qe98O2nE0SijU6SX5/O/O52JzgtEp1hnNeELdd/v6fcEXGjkv5Zh+t6eDayKn
 WwYFso2v4Xw5yhEtHt7xs2ChhTn1VmZ4cfjuaWseq8PBU0zkYWAp97QdqU22ae2hCr
 DEEDsOHDDCA9LXwaX6xjdRcGPTO+KduJ3l+ircXW0WgpdtZsBh20Iiec+L+HNoDq8x
 l/ITV13KIfa2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6CA73C43142; Thu, 19 Jan 2023 13:19:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 19 Jan 2023 13:19:10 +0000
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
Message-ID: <bug-216050-202145-CO7EtPZFhE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1pIUp4-009AWz-31
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

--- Comment #125 from Guido (guido.iodice@gmail.com) ---
Can I ask to other reporters what distro they use?
I use manjaro but the problem occurs also with archlinux kernel.

Maybe it's related to CONFIG_F2FS_UNFAIR_RWSEM=y ?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
