Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67936C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Nov 2022 21:04:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ougcy-0004Bq-O8;
	Mon, 14 Nov 2022 21:04:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1ougcq-0004BR-IB
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Nov 2022 21:04:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JghAEfSFPCL3BwwR3m5YE250Md5ItcdZlWQvACcvqlw=; b=QPovvcm3riKgMuBFA1WBr8G0aB
 ko3jguIMxmCms5eddCV8hdPup9I1B0O6nPN6Gi2VjU7fgWaAxqnAqxtJZ0Tc/BJcSfzoGDYCXHJ0F
 lCqH6LGLL5OajyCGzPVZ0kLK6wIH639f+a9nYO+ZSO0MH3dtjWbi/BxO2cnHX2nhxf04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JghAEfSFPCL3BwwR3m5YE250Md5ItcdZlWQvACcvqlw=; b=JvG1ctS8n3NC4UZFn/Aqw4sm0Q
 mYCzuKJ44JMYbV4i/asn//jGcmfb5w8wFCbIjA5iGu2Hh8yGv6dQSThTag0R2/7XX/otXuD+r7Yiv
 LoPZIfa7H51jlRaIknYlxdOow9XHNIycSI3vj6rsGxH+Mqm3omyIR4zGEopOWXneLdIQ=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ougco-008CyM-Kg for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Nov 2022 21:04:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0A905B812A4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Nov 2022 21:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFB1EC433D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Nov 2022 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668459841;
 bh=JghAEfSFPCL3BwwR3m5YE250Md5ItcdZlWQvACcvqlw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=ekZ3/qYMjos/ytbCIGyXLGcA7OgKqzkSjdkGEyFO+H6dKhq5M5LZDesKn9qBQZY+u
 15toqsuvUmJYmcdCL7YXoNuQv+43MH/jK1nc9RZ1estgvY80PVGe7EtkPEVnNc/c3g
 5wTz/i17G3j9zLqyM1pxtMLeNdtJjuq8HkzpwvYNdoipSF+V1mi9E8JMx8rw8HfYzh
 iPkB5UZfWgVGAYJNz/k/E2JouvE9moTEQgyC+T0C//mdrQvMKm+ZEJINSsGuQVs2Mj
 TAEWiVr1x124a/4JkVAQu4hJeD+OPijwiuxSUcL/QBPGfvSWNiiMcKQcq9S75e9hqn
 pnRu4lcnRKTyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 92A84C433E6; Mon, 14 Nov 2022 21:04:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 14 Nov 2022 21:04:01 +0000
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
Message-ID: <bug-216050-202145-XupP6aHBiP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1ougco-008CyM-Kg
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

--- Comment #86 from Yuriy Garin (yuriy.garin@gmail.com) ---
(In reply to Jaegeuk Kim from comment #79)

Running this patch (and debug printk) on 6.0.8-arch1-1.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
