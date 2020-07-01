Return-Path: <SRS0=TgVm=AM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C63C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:01:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0328420722;
	Wed,  1 Jul 2020 05:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="G2fSHIWP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HAdhcRsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0328420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jqUrv-0003mm-8e; Wed, 01 Jul 2020 05:01:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <SRS0=hiTD=AM=bugzilla.kernel.org=bugzilla-daemon@kernel.org>)
 id 1jqUru-0003mf-55
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jul 2020 05:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yyAAQ4+hP5HgT1J6jXqG1yeKcC5DyFPne4xdMbsPJ/s=; b=G2fSHIWPNgSPN1sISifPltUuCj
 Bm8YlMB+nBNSdpnz9xDFhe7Wx/7571xQ3KYlM3F5DI2qXRV9d2mz4XB2TjRUdUmvbwEKxf2EnpKZ8
 +auz/LvDSYv+IFOUTtmM5kZnU2QkBYChx4J1wjT99sHEZ2gk7E1Vz7IejpIXiZr3SGAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yyAAQ4+hP5HgT1J6jXqG1yeKcC5DyFPne4xdMbsPJ/s=; b=HAdhcRshB+iSqH93FzhjWNA0kj
 FE0FDuJNQT5RlKnbyQQyoFfdX9gznxi8b/KcRtKuzUYuN4hcoDVc1bouud4RQZRsLiv11vOcTM46d
 LSwcsyoKGh9PDJ1GAdmctsTKxmvdoFbeOuwPijtfsq99i4DQ1LDDWfwb9bGgHER2XJXY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jqUrs-003k7F-SJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Jul 2020 05:01:10 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 01 Jul 2020 05:01:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: f2fs
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zKqri0@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: filesystem_f2fs@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208325-202145-Bi3pL9QcVb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208325-202145@https.bugzilla.kernel.org/>
References: <bug-208325-202145@https.bugzilla.kernel.org/>
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Headers-End: 1jqUrs-003k7F-SJ
Subject: [f2fs-dev] [Bug 208325] f2fs inconsistent node block
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

https://bugzilla.kernel.org/show_bug.cgi?id=208325

--- Comment #4 from zKqri0@gmail.com ---
(In reply to Chao Yu from comment #3)
> (In reply to zKqri0 from comment #2)
> > Mount options are "/dev/sda2 on / type f2fs
> > (rw,relatime,lazytime,background_gc=on,discard,no_heap,user_xattr,
> > inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,
> > mode=adaptive,active_logs=6,alloc_mode=default,fsync_mode=posix)".
> 
> It looks it's default mount options.
> 
> Did you use any special mkfs options? like -O [feature_name]?
> 
> > 
> > I patched my laptop's kernel with those patches but I don't see anything in
> > "trace_pipe" while I'm getting invalid argument errors. Also I noticed that
> > the "nid" and "node_footer" are the same always in the error so its only
> one
> > node block that's messed up. 
> > 
> > Maybe a raw copy of that node block will help find what caused it ?
> 
> Yes, please, I can parse it with dentry_block, inode or dnode structure to
> see what it looks like, and what kind of fields are corrupted.


I used default mkfs options. Here is output of using dump.f2fs on that inode


>sudo dump.f2fs -i 1761978 /dev/sda2


>Info: [/dev/sda2] Disk Model: Samsung SSD 850 
>Info: Segments per section = 1
>Info: Sections per zone = 1
>Info: sector size = 512
>Info: total sectors = 102539264 (50068 MB)
>Info: MKFS version
>  "Linux version 4.20.0-arch1-1-ARCH (builduser@heftig-29859) (gcc version
>  8.2.1 20181127 (GCC)) #1 SMP PREEMPT Mon Dec 24 03:00:40 UTC 2018"
>Info: FSCK version
>  from "Linux version 5.7.2-arch1-1 (linux@archlinux) (gcc version 10.1.0
>  (GCC), GNU ld (GNU Binutils) 2.34.0) #1 SMP PREEMPT Wed, 10 Jun 2020
>  20:36:24 +0000"
>    to "Linux version 5.7.2-arch1-1 (linux@archlinux) (gcc version 10.1.0
>    (GCC), GNU ld (GNU Binutils) 2.34.0) #1 SMP PREEMPT Wed, 10 Jun 2020
>    20:36:24 +0000"
>Info: superblock features = 0 : 
>Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
>Info: total FS sectors = 102539264 (50068 MB)
>Info: CKPT version = 64d05005
>[print_node_info: 271] Node ID [0x203a7962:540703074] is direct node or
>>indirect node.
>[0]                    [0x5452202c : 1414668332]
>[1]                    [0x45445f4d : 1162108749]
>[2]                    [0x4444414c : 1145323852]
>[3]                    [0x202c2952 : 539765074]
>[4]                    [0x6e657665 : 1852143205]
>[5]                    [0x6f687420 : 1869116448]
>[6]                    [0x20686775 : 543713141]
>[7]                    [0x69207469 : 1763734633]
>[8]                    [0x6f6e2073 : 1869488243]
>[9]                    [0x46202e74 : 1176514164]
>[10]                   [0x69207869 : 1763735657]
>Invalid (i)node block

>Info: checkpoint state = 51 :  crc fsck unmount

>Done: 0.063481 secs

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
