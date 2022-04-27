Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6076BC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 Apr 2022 12:59:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1njhGs-0001t1-88; Wed, 27 Apr 2022 12:59:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1njhGq-0001sq-IH
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Apr 2022 12:59:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+exUbMCwxRI/5Slm3+VtVczCZ8LWCgwMXOsKWwIc78Y=; b=XfOzTvhcrkgZV+lYxCwB5xKJFs
 4hBmtD2tqrEXZZPLj2AjylF8Zh2H5S1FPACjo76eh70XJRHEVkIUJebLcm0Su5Ibnt8MoAk6MQGeO
 o0yLdj8a0xeQHlHBy0k0ssmGqRytgJ/r2LMhZBQIXZvPnjpkuQ08mWJ5aR8NzuqIZwm0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+exUbMCwxRI/5Slm3+VtVczCZ8LWCgwMXOsKWwIc78Y=; b=c
 StfIwOymsjUy7yhb9B8vPHlgbcDYOxucqYfCXT7EOpfwres84rYFFahByiCC5fVRvlfPGEDIn7c1a
 Znrm+XMXR6jTy8KFLinpuyjm0DCjo4btvSsHxFKw2pe3mZRMkG6OQ1rYRZ2DLulWnqBdKhpALGfnD
 bRxah4Qf94xz7Vcc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1njhGp-00BlQO-BX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Apr 2022 12:59:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EB556B826EE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 Apr 2022 12:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB8F6C385AC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 Apr 2022 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651064383;
 bh=J7xBth5N1aP9ZvWNkfgNlqaX28JhzYDEXZTO6OxJzXg=;
 h=From:To:Subject:Date:From;
 b=vLeDe2zDqnPqYVKcnDSF90q44O/YXSN/KPufnVWaOg27PJzuQpZPZI5+dzfKfwtQ/
 gDmZTTEQlAOZrUdiLU1+4AB5HdVMeT1RU/7dXVqaTzSc0/o5BwjQw8VeybKCp3HKvh
 m2Mf7UKdbRXZiVWSj7iPSmaTj8UWzX6+f68uRcdvIls85wpcvEvh29UrxhmAdvLCge
 xjzcLpP7Yelld/Tu1WuBM5Mt2/zZvPewch3revWiBZbtzxxYC3Vo6RLvlrx4AHiDLm
 bEB7Y5hHwg9prFKYlJWyaeHkXoAH5+JXzaXlXX7gAPyI22+EN90RLw5cwWd/pIVzSR
 0hVV/FSKYhGWQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id A77B0C05FD0; Wed, 27 Apr 2022 12:59:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 27 Apr 2022 12:59:43 +0000
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
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215900-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1njhGp-00BlQO-BX
Subject: [f2fs-dev] [Bug 215900] New: kernel hangs when running commands on
 F2FS file system
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

https://bugzilla.kernel.org/show_bug.cgi?id=215900

            Bug ID: 215900
           Summary: kernel hangs when running commands on F2FS file system
           Product: File System
           Version: 2.5
    Kernel Version: 5.17
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

Created attachment 300824
  --> https://bugzilla.kernel.org/attachment.cgi?id=300824&action=edit
case.c

I have mounted a F2FS image on the Linux system. When I was performing file
operations on the mounted directory, the kernel hangs. I tried to kill the
running process but failed. Any operations on the directory have no response. I
am wondering whether a deadlock is in the kernel.

This issue can be reproduced by running the following scripts:

gcc -o case case.c
losetup /dev/loop0 case.img
mount -o
"disable_ext_identify,inline_data,nobarrier,extent_cache,grpquota,fsync_mode=nobarrier,test_dummy_encryption"
-t f2fs /dev/loop0 /root/mnt
./case

The image can be found at
(https://drive.google.com/file/d/1bjCQR_-Sz6iF_wshMGU3wWZDQ8tQIFdj/view?usp=sharing)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
