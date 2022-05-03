Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39D7C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 May 2022 05:08:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nlklz-0004Xm-CQ; Tue, 03 May 2022 05:08:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1nlkly-0004Xg-JT
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 May 2022 05:08:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IG99yunbbSrbwapye0wyCpT83VQQmP4Fb/T3lTdsDvk=; b=C6WDI+py77Si1omtvfLAVWkqHc
 H0EjeVtlQi2/qZT1HLH5AEBSfPw+rInttpZ0mXmLN0pcoEElbQ7/Tp7em5ebhB55i8C4gtAEWT4m+
 r/nWsRqDHCJzWpWbGd4DfOj8mFIdq/lwazYdfsBxyrptqjnWv69eJJAUPO/K1hgas1ZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IG99yunbbSrbwapye0wyCpT83VQQmP4Fb/T3lTdsDvk=; b=X
 pgn0Pp5gHM7DzgQhjYfzfbzhgD2gwHx1GSi8y/YdL7RWhUcHDFUoKThETiX2ivk1b5UcB1YoCXOnK
 MX4epzcTFaU+KU6ogB2Ta2qvSXpWbB00j9e5svTaJK/V1GT87wZdVG9bHU7tg9iC3f+FJWUEfGHfD
 /C+oCu1qjxCmK8Co=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nlklq-00HHmA-Qk
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 May 2022 05:08:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6D55261525
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 May 2022 05:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9538C385A4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 May 2022 05:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651554492;
 bh=IsNddQ1Ph2ihYziaYGL4YkxXucuWMb+uDRPYCXSyOnQ=;
 h=From:To:Subject:Date:From;
 b=dNGKjOw1CxTHGRsrcaZgRwhUn61avAx+58sTAqqV9Ln6QDV5bNxOHPxAASUj/qWQu
 tsycVnPAaleDVq7KX4ANPfyWvBSnemIXGZwxLhYk5UqMbXcUCnhccmaVYdwG7y2YtD
 9ElfromIIlfcUWtQKc/Ct7sEmn8K/F2SRy8OJCD2TeNHmJiebEpq9G99FQEw1F1XWK
 w+jFxgyBndNiV40dFmBVUzze9vI5xC9bLGdNmnRzoLyNMDnsKrjpVWBphw8t9WLA08
 MfzH7AwXehwjC1QNUDOnkXqj37W4d50iQr2BHHuhx1/rPGoqHtN9JLR4VNMNIN6o7S
 /RHh/IxpJe/3g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id AC86BC05FCE; Tue,  3 May 2022 05:08:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 03 May 2022 05:08:12 +0000
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
Message-ID: <bug-215935-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1nlklq-00HHmA-Qk
Subject: [f2fs-dev] [Bug 215935] New: kernel hangs when invoking system calls
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

https://bugzilla.kernel.org/show_bug.cgi?id=215935

            Bug ID: 215935
           Summary: kernel hangs when invoking system calls
           Product: File System
           Version: 2.5
    Kernel Version: 5.18.0-rc2
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

Created attachment 300870
  --> https://bugzilla.kernel.org/attachment.cgi?id=300870&action=edit
case.c

I'd mounted a F2FS image with several mount options. When I was invoking file
operations on the mount point, the kernel hangs, and the process cannot be
killed.

The file operations are in case.c, and the image is provided at
(https://drive.google.com/file/d/1YchwhB5R5ToURLSFy20rQc0wDOvRCltP/view?usp=sharing).

This issue can be reproduced by running the following commands:
losetup /dev/loop0 case.img
mount -o
"disable_roll_forward,nouser_xattr,noacl,active_logs=6,disable_ext_identify,inline_dentry,flush_merge,nobarrier,fastboot,data_flush,alloc_mode=reuse,fsync_mode=posix,test_dummy_encryption"
/dev/loop0 /mnt/test/
gcc -o case case.c
./case

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
