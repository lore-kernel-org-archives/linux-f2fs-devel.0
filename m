Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD77CAC5A5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Sep 2025 03:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XfHeGEQkNnDB1ooV/iQ7F0pzBAijaMGkmAWt79htTUw=; b=SgYo1wFh11VImYjh97ewzsRQ0E
	igt3kNK2GhFkBy6d4v5t7C9/EaM4eXrpFCbYDqFqlxvn4nIWlgXyAGGkvV5hFGRfJI6bfKs81eksm
	N6RdCDQTrQrGBt8XDT5/OsrNTTNJq/ZIs0AO2brodrS3xhA+vKY2ImwyaGxaaMnKS32s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v1crM-0000Fi-Sw;
	Thu, 25 Sep 2025 03:41:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1v1crL-0000FU-EH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Sep 2025 03:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QWIN2IgdR3EvuBreKBqn2JJ9VPkk7lojuHnblDIjNU8=; b=Pqt95hhYrUySDkgjuWN3K4Pohp
 sSQkCS+HdwBf88ko7oFCQyKqaecRsLutpP/y10Am63uwl2oJQx4HVC9Vj8OmhSeNFMV6JjRdoSUqf
 jjgFn67OyfoD59rAvgC8ii39Mi68xGbpjZFz+7w2melR+qxjOhg2VxKnZ9b9oP5VcKWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QWIN2IgdR3EvuBreKBqn2JJ9VPkk7lojuHnblDIjNU8=; b=bp35Z3r1w1vairEdylwNsWDdT5
 mxVhUv4ToLScPU+6i+vpgKuuYpkKiBHYv+JfFOA5Din8H8zu/1tFmAYqbuKp6ofsxJKuhnKIuuiAx
 /T8ry5jlUAWjRpOWPyBQoVbOarrrOgpAGCPINo4ZqkLD40gstFxGf4e+CKD2foRuu7R0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v1crL-0006ON-PK for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Sep 2025 03:41:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 62ABA402B5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 25 Sep 2025 03:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4220DC4CEF0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 25 Sep 2025 03:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758771681;
 bh=+6WYMqMjhvXxdXAKIM7tO0+DCKJhbB3lfQFk1D2PhkI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=J3wkKUkPXzPhcZ1bvo2wacktj7s3ArYGz3Nw81iXWK9jt/HiyntnwzE58mBMCGMJu
 R8BWp7IEbfyEtYhiNTMCNc+quklPHvEs0RGvtgoPoJ5abN3GK/QpPbG+DwFURNWKzn
 zR1iXifbS4jNQxdlb3YqpApOC0p4fdjNeNQ9htrxkyr2Ez3e9RzDb2mNKSpt76ZTlM
 Jn5xU49b561zNSDpIEeHZV5waJfeYpBiDK3ylDaoz7FJHoEw9SEG2inTJn7k8R9d1V
 G7k6zhq/HVRuaK1QhrtWepzRDrLNXKROMKQSvRy2ai9zX1ziMZNoVyTjGo65SfsBh7
 p3M9E5xY69Xaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 3399EC41612; Thu, 25 Sep 2025 03:41:21 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 25 Sep 2025 03:41:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: JY.Ho@mediatek.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220575-202145-ZsShWm14FO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220575-202145@https.bugzilla.kernel.org/>
References: <bug-220575-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1v1crL-0006ON-PK
Subject: [f2fs-dev] [Bug 220575] Unable to handle kernel NULL pointer
 dereference at virtual address 0000000000000000
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
From: bugzilla-daemon--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: bugzilla-daemon@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=220575

--- Comment #9 from JY (JY.Ho@mediatek.com) ---
Oh NO...
I saw my fault...

static inline void set_page_private(...)
{
        page->private = private;
+       if (!private)  <<<<<<<<<<<<<<<<<<< :(
+               page->_private = private;
}

It should be 'if (private)'

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
