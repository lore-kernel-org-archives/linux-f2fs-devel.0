Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9FEC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jun 2022 03:11:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nwElu-0002cn-60; Wed, 01 Jun 2022 03:11:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nwElt-0002ch-4u
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 03:11:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O7Nyv8zeeTTcBmjqXh/T8xQIwD5MvHuFcTjLwg6cFVo=; b=Hsjw/EHIg58Q5cZR8P5c218eob
 f7yhV1ASJ/QvNC3UzbFULnTwQIovLMJr+CCceyLvCMq+dobBDSQgp55rnSVv2WZiz9uTC+8gdnQs9
 Qik4hjNkwKKoLM+YwDbmbDqk473vVn99EHwLvnfXvoZYrlgPMwDiPXrz1UhPqlxDk7vQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O7Nyv8zeeTTcBmjqXh/T8xQIwD5MvHuFcTjLwg6cFVo=; b=dyuo+Ez6VxTkp0yWrZKcNnxULb
 T3Ai4gNliJppTTKNzTgKty7BQ+mmE3LNVjgIKFzH5aJLtXw86ZwcRFZD+eiAXHzSjcO/6QoNDhj0N
 s6vjaWJ/RAMfUk1TkuhBT4x7H144r2o9SEDvbhzEaOZMkZRfSj2zB7qTI37tgBa9DbeU=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nwElr-00EaUJ-2A
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jun 2022 03:11:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BC01CB81768
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 03:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E373C34114
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  1 Jun 2022 03:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654053087;
 bh=O7Nyv8zeeTTcBmjqXh/T8xQIwD5MvHuFcTjLwg6cFVo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=m95aDtmXCUtCoS/ZFZrvfLoH7Cz4chqC4aH7fOMXK1y+XkmCrLRVGwBau0877oKbK
 zGLzBhBFxqYST3Dpx3N4Fj7eOqykgUt/hxIDpsUH33sVpl3gmYotlcf1TbUqdBsHEC
 SMpgAvcnW0LqBnSSxyzScRqB71IqGciiUiD4AszMCGRcp2f4qtDJypbx37Sbq9opcQ
 UwpFBpJjcRdfcAYqm+ZPehTpnZm6lGOvgYt3VmueQM8rgUiT4DjTFAxeh6VvPadZ6s
 1BzbTuZxuh4qg6muCxNSwjSpseqhkaQlzw/ISPN9nRKsfpiCLmchoWwYN8tdcOkYTI
 L/j/N2UrD12aw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 3545EC05FF5; Wed,  1 Jun 2022 03:11:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 01 Jun 2022 03:11:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jaegeuk@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216050-202145-0GYrtXl2ca@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216050-202145@https.bugzilla.kernel.org/>
References: <bug-216050-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nwElr-00EaUJ-2A
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

--- Comment #7 from Jaegeuk Kim (jaegeuk@kernel.org) ---
dm-2:
GC calls: 168 (BG: 169)

dm-3:
GC calls: 10 (BG: 10)

dm-7:
GC calls: 37 (BG: 64)

Mostly it's healthy. Do you see f2fs_gc thread is running?
May I ask some function traces when that's happening?

# echo 1 > /sys/kernel/tracing/events/f2fs/enable
# echo 1 > /sys/kernel/tracing/tracing_on
# cat /sys/kernel/tracing/trace_pipe

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
