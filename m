Return-Path: <SRS0=pJun=VP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC506C7618F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jul 2019 01:50:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1962184B;
	Thu, 18 Jul 2019 01:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lhDV5YHf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Ii9sKhCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1962184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hnvYa-0005Jb-47; Thu, 18 Jul 2019 01:50:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hnvYY-0005J6-Ge
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jul 2019 01:50:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C1Lo7jSktOrnYDUNIRV83Z087w8gCLwA1orPLYFPYX8=; b=lhDV5YHfaA0/D/8fQ0BIGF3MF6
 sZ/BsVGWQq9lBX4OCUJxD2NhstrVUNL+y6FzcocBp6wBGKT8saBvZNglS2TL6eCS51viTMJQmAQap
 PiyNkM9KzvXJJ/5X6cWuoOdBXOC3CQJgk4n7R4Ujq76lB3kVpTH6EReH7fHrd4si8N24=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C1Lo7jSktOrnYDUNIRV83Z087w8gCLwA1orPLYFPYX8=; b=Ii9sKhCMOs7aqdqWUoD8xQLYdX
 YnuSdH+4ZbhDFjKJgToJcgHQXhdemFHfRAwJ7HUYyPjFxX+CwIqDVXTnJj8kilkLQTVS7Ht2c/NQ2
 AVDzpRvOxhuBP9/bdErHY2Lntznok1KWapJRH7gQvYyMncRMiwaiQwNkzCUcAMWpcUEA=;
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hnvYX-004tll-5l
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jul 2019 01:50:02 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 86E6C28753
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 Jul 2019 01:49:55 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
 id 7A2DA287A0; Thu, 18 Jul 2019 01:49:55 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 18 Jul 2019 01:49:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: midwinter1993@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204193-202145-xxQ765rybK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204193-202145@https.bugzilla.kernel.org/>
References: <bug-204193-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-Headers-End: 1hnvYX-004tll-5l
Subject: [f2fs-dev] [Bug 204193] BUG: KASAN: null-ptr-deref in
 f2fs_write_end_io+0x215/0x650
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

https://bugzilla.kernel.org/show_bug.cgi?id=204193

--- Comment #2 from midwinter1993@gmail.com ---
(In reply to Chao Yu from comment #1)
> How to reproduce this, remount to change io_bits option?

It's not triggered by remount, the following script manifests it (note that
this bug does not occur deterministically, you may execute it repeatedly):


```
#!/bin/bash

DISK=bingo.img
MOUNT_DIR=/root/mnt

dd if=/dev/zero of=$DISK bs=1M count=180
mkfs.f2fs -a 1 -o 9 -t 0 -z 10 -f -q $DISK


mkdir -pv $MOUNT_DIR

# A little bit long options, I have not reduced it yet.
mount $DISK $MOUNT_DIR -o
"background_gc=on,disable_roll_forward,no_heap,nouser_xattr,active_logs=2,disable_ext_identify,inline_dentry,noinline_dentry,flush_merge,nobarrier,noextent_cache,noinline_data,checkpoint=disable,usrquota,grpquota,quota,noquota,alloc_mode=reuse,fsync_mode=posix"

mkdir -pv $MOUNT_DIR/a

new_dir="$MOUNT_DIR/a"
for (( i = 0; i < 512; i++ )); do
    name=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 1`
    new_dir="$new_dir/$name"
    mkdir $new_dir
done


mv "$MOUNT_DIR/a" "$MOUNT_DIR/b1"

mkdir -pv "$MOUNT_DIR/b1/b2/b3/b4/b5"

sync

for (( i = 0; i < 4096; i++ )); do
    name=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10`
    mkdir $MOUNT_DIR/b1/b2/b3/b4/b5/$name
done

umount $MOUNT_DIR
```

Sorry that I didn't provide the script before because it's tedious for me to
reduce it. :(

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
