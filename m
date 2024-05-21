Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4F4C25B74
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 May 2024 21:02:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s9WcZ-0005Am-3m;
	Tue, 21 May 2024 21:02:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bugzilla-daemon@kernel.org>) id 1s9WcY-0005Ad-21
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 May 2024 21:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kRCc+7QG6/rEzQfQBJ5W1YrNnxTqwi1EncCSbiCpyck=; b=BXOieSKEKsAb+kpTBtUov6fpGc
 j9AMa7SqXaGIM2RJvATdvqTlmB9v2EefyKm8e8wO/Pjbf4MWw/7sZjywvqPw3Vcnpey9Dl8fTCQtp
 3sghkFtiEEcMhn8lBzyR23swSV10uoG5ZokYhu88PNa8+JN6x0IkhfuWCaWlLAZGG/5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kRCc+7QG6/rEzQfQBJ5W1YrNnxTqwi1EncCSbiCpyck=; b=B
 hM6IRaXK8epk1UdZKaspa9hJVVOsUhZmnB5QKV/ddAyfB/XB8cUyzAV9xjKg29uybT5BieXergV3r
 oqc5u+ztZIHokZVrkNKiZKi8u5yDOkzI0kyJ5eAEXzTk+8Gg/q/PKAew+cvTwvysbYRIskyddi6Lh
 seeHDzbFQNNzdqHE=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s9WcW-0005vq-TD for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 May 2024 21:02:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5F7A4CE10C5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 21 May 2024 21:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A23E9C32782
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 21 May 2024 21:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716325311;
 bh=U+RuMmEUT2tzgY5giAsfugphKbe1TwOZI7f+8rNW2JI=;
 h=From:To:Subject:Date:From;
 b=i8Mrn3RQqLRVDzYXYPf8SWUgPo6OLPJunGy3u6eEz6So9ovsQz/4aQY2pX12D8wqZ
 JgdH/ruu1PCg66MoM9wele8GYw5HaXq+Z6aJKsejfQ1f7RN1+e9kx2BMJ6MD8LjaMJ
 YZU0Vg8xu3rUofeuOMMc+XmMqgxLjdelpvfJekKnv3JXp/RpgP6qL02I7sCJeybx2s
 OrRe+a1B7/okuvo5Bj7h4Gn9O04CstmpgI+6R4/iRoXG4NLfVcWqPqBjmqFD0jSmII
 3ezYolOntXpo3xVLCsJRy7R5u/JusMzopfVaaFhbQmZWClhrgJfFhSPcdcN1KuRLzm
 NY+tRuekCW7LA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8AC99C53B50; Tue, 21 May 2024 21:01:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 21 May 2024 21:01:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: patrik.plihal@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218870-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1s9WcW-0005vq-TD
Subject: [f2fs-dev] [Bug 218870] New: F2FS mount/unmount results in
 invalid_blkaddr
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

https://bugzilla.kernel.org/show_bug.cgi?id=218870

            Bug ID: 218870
           Summary: F2FS mount/unmount results in invalid_blkaddr
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: patrik.plihal@gmail.com
        Regression: No

At least 3 people hit an issue with f2fs mount taking a long time (due to
fsck).

In 2 cases it's is the boot partition which delays boot time, in my case it
simply delays a mount.


I prepared a example to reproduce the invalid_blkaddr (and which I presume is
the root cause for the long-mount/fsck)

  1. dd if=/dev/zero of=test.img count=100 bs=1M
  2. mkfs.f2fs -f ./test.img
  3. fsck.f2fs test.img  | grep errors # nothing
  4. mount -t f2fs ./test.img ./mnt
  5. umount ./test.img
  6. fsck.f2fs test.img  | grep errors 
    # Info: fs errors: invalid_blkaddr 


my initial comment / analysis started here:
https://bbs.archlinux.org/viewtopic.php?pid=2172855#p2172855

Linux blackbox 6.9.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 17 May 2024 16:56:38
+0000 x86_64 GNU/Linux

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
