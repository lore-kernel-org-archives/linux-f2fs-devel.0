Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EF6C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 May 2022 11:22:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nqYo2-00081k-0s; Mon, 16 May 2022 11:22:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nqYo0-00080k-ML
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 May 2022 11:22:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0h6h8WkGZi6fPgWwFUE1JrMrqNtzyqIvgQ4HuLwc5RM=; b=j5Oo3BsSWmcpYHnSFUF5/4vfBx
 o5LYKI4t1DQbiQJvr/67h+wzgdIj/GTJHQ1YAMPN4sQLmdjSSYocGnUoghHeK4ypNENJnBV9aCr+m
 q5DCLX05zz0GyRJqzOuErKRmC9dwLMeDFihWf3UKoxdmK/w0ZaLHdtuqoeLCwyaxMq94=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0h6h8WkGZi6fPgWwFUE1JrMrqNtzyqIvgQ4HuLwc5RM=; b=M
 oX12Q3waWPhWyR8ffpC0nRoCG49QyuAcUtNWraYlfbo5k7nAldM/oq5QhpQuf3gB2PHLIqw/3zL1V
 U8YUJ4sEUFgBIsDBKmEklL716Z4r88BfIRrY9FcEeo2irnouhVdkq0hoCKC2IVN9bd6CX9LkVowkp
 xrglsBFKPjEHmMZc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nqYkS-00066v-8U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 May 2022 11:18:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8641E60F7B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 May 2022 11:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E70C8C385B8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 May 2022 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652699913;
 bh=Amabref4/llBtBYlL5eSKuSh0pOjknx01HiQiMNMing=;
 h=From:To:Subject:Date:From;
 b=e4WjeuBomdZ87m4DjpNd+Gqcglif4DOWZ/CMZAdQ+9pXH0hcFginvsbDfLxZmALta
 uHMoaLvXiYvN8IcdPkQVk5d2HmPry5pjX6wN994QERAO7DaN1HSCph5Q0iYuc6VFW+
 fUPf+wO9NoFJ4Ua0PuEUilXu08WFK5o9hZLttClNk8HtcNU9otBiSTKPTZw93hxFuz
 wjXzK4XVDDIH+53rwbTgK7RZpWBANgdHtrDsfdIFVAwRQ1fJ/zIG3NFew9H8c9vs6y
 P538STd6ucbJrxC1Ps52RcVvlgsGX/xmNOBfq06nThWy5JJFuhzn+aYhrQxp8lyJtD
 AFTz8A87bAFlg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id CA04DC05FD0; Mon, 16 May 2022 11:18:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 16 May 2022 11:18:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Zhiguo.Niu@unisoc.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215984-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nqYkS-00066v-8U
Subject: [f2fs-dev] [Bug 215984] New: Is there a f2fs_sload tool used on
 windows?
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

https://bugzilla.kernel.org/show_bug.cgi?id=215984

            Bug ID: 215984
           Summary: Is there a f2fs_sload tool used on windows?
           Product: File System
           Version: 2.5
    Kernel Version: 5.15
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: Zhiguo.Niu@unisoc.com
        Regression: No

Hi

I need to make an f2fs file system in the windows-x86 environment, and then use
a tool similar as f2fs_sload to preset some files in f2fs image. 
Currently, there is a windows version of make_f2fs in the SDK. Is there a
f2fs_sload tool for windows-x86?

thanks!

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
