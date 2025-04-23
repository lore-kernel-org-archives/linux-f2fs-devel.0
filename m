Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FFBC369CB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:06:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u7hIO-0001Ee-QG;
	Wed, 23 Apr 2025 21:06:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kanepyork@gmail.com>) id 1u7hIN-0001EX-PG
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Apr 2025 21:06:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6GgomoTqcxsuEbINY7I6CWSn0GXbkD5Th2M/o+l0ZGo=; b=g9KDh54vPW7JwUcFEwbfcho0N1
 BGNoG6wRjP0UReP5STXwcm+1t4RxPyj/ybakVQ5+gGfCFgog89N4a6oABo+biG1HgaXex7ivEbxxZ
 Ki5+0LbYPAqzjzoQaHKM5D2UkPg64VASjhg26jE4pxQG5Euzbgc6gMMlIMfudvOQGfPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6GgomoTqcxsuEbINY7I6CWSn0GXbkD5Th2M/o+l0ZGo=; b=jMQcwncUWOAjOPM1yPuMH3a+yg
 43kTqvjrTIxh6fgrf39JOnF5ahAEKa7CxQE30aIbLDowY5tomw4hLjOs6gq1q3R5uoQ2URn0KFqdh
 /69lNc/KhwAhZyXBBMHuIMorJu9jpxKzAQsQcUFQPLTSvSoa0gU4YhRubp6WkWu4zhCE=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1u7hI8-0004hT-22 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Apr 2025 21:06:15 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-39efc1365e4so138324f8f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 23 Apr 2025 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745442348; x=1746047148; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:references:in-reply-to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GgomoTqcxsuEbINY7I6CWSn0GXbkD5Th2M/o+l0ZGo=;
 b=JLlipDVNqAGsX+KAvtpS55BdYCjegAZblmtgg52IqINxaTAV6FakEpBFiK2QpC4S/p
 XqWEAA5uFeVllUThpVF7MzNmX4AmlgpMdiB7+XOrV5532GHqSiOHAe12HSMejCsEnnBE
 bQ4T7RbQ0d9idJ0E2ssc93SLaVpng/UnQ16xNpLwNzLd23/4XOnrsZ07i3gBZF6KXvze
 ymTasAHS5AgeIRP2e57IEo4gygS4r0+1tUEokTkZxAyx/Y8KFYaGXaxBH8nXLo97AaL9
 +bPTy9UqJEXLXwm7QM7qx4lWwg+xkIpiGn8+Ixsjxi5wmqniCnVk6Co5h/gSC8D1eWR/
 X8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745442348; x=1746047148;
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6GgomoTqcxsuEbINY7I6CWSn0GXbkD5Th2M/o+l0ZGo=;
 b=UhEmBKTmGUqwkg6y2Mzn076QzdjlLQhb6hNC+khJ8ojEfsps+U8kcWTTBI3Z/EYaiz
 hJn1XprkykO2iehauORi+JvRD2Kq9hBrxrqj6YlhcEr3LHmp2hTmyszTqrEwiYbKs9lv
 7GLg4o6o0vOlRCorc3VzhQWo6Hk9LrAw3qtfE1GWRo+bPhKYYQlAwn/ejF2JhJ9/TKBE
 8tFy1+457Dt5jPEfDgQEUXggSgr0N1qob4ytgb9QYyUWgIY25fNxqAs0loWhVq3m1d+r
 7LoCx44pGlpLB5B2hytmylOhEI356f6nAoo+zm8uRlPaverfx//XZe4LoIbUyFom0IGd
 /q/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOk7EH3TDBrDgFJF7mGDajMPJ6+90MoZ/BLwX7Ktli3YfSMdwsfyZbiSSZAe2RB4k2ltdpr+WIGjDstm2oBCI5@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzL8ZKMCYqvjxyKzwyIZ43VZomrByRbTpFz4oThn4pnTr8g6Ffs
 lj3cOLZBqcAE1On2AAkb8OKyBD37lvsfa5eXLepceQiQTYP0+bfp1S10nJHf93MYzhHr21t58J0
 0Gcais4ZikFNEWKNuW4+OTazR0OU=
X-Gm-Gg: ASbGncv+azEIV3WF8Tbw2TmBrSgmLxBh1yWm0t4G1FHs4M/cEMnW/Scxfv8rsbDI2Od
 sLJxjsvjt17/sLi7IR8CZm59TUuu4xr8m44lpRPNWTCbiH+BWnVV8GIV5UhvWbySrTymlDrFwxI
 rAWmHUfxrJ4f9nrXR6sSwbyZda0rGA/1xsWA==
X-Google-Smtp-Source: AGHT+IGUsLBPox/uWJmjVyGdZUaWrYeefwPGm1ePwVrDhg+0usyKnEvHQaxBIhl8yqvVIW79wshIanldFENL4YTbVZ8=
X-Received: by 2002:a5d:64a4:0:b0:39f:e37:1733 with SMTP id
 ffacd0b85a97d-3a06cf52369mr13252f8f.2.1745442348296; Wed, 23 Apr 2025
 14:05:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:05:47 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:05:47 -0700
From: Kane York <kanepyork@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <68089b8d.050a0220.36a438.000a.GAE@google.com>
References: <68089b8d.050a0220.36a438.000a.GAE@google.com>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 14:05:47 -0700
X-Gm-Features: ATxdqUFZthFAklAVbjNKhw0GESMNNwLIui2BC5RgpHNS2pvWQzLydo6IzsEC7Q4
Message-ID: <CABeNrKXCcXxviXQPdCk2R+o-M0VmOsowtWkTddQ5+Tua9eCrQg@mail.gmail.com>
To: syzbot+effe7da6578cd423f98f@syzkaller.appspotmail.com
X-Headers-End: 1u7hI8-0004hT-22
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] INFO: task hung in do_truncate (3)
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
Cc: brauner@kernel.org, kent.overstreet@linux.dev, jack@suse.cz,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-bcachefs@vger.kernel.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This crash appears to entirely ignore the provided filesystem images and just
does tricky fallocate calls followed by a truncate, so it should be easier than
normal to diagnose.

The cwd is opened with O_DIRECT. (or this is EFAULT because path is nullptr?)

The victim file is created with O_NONBLOCK and O_SYNC; that fd is discarded.

The victim file is opened again with O_SYNC and FALLOC_FL_ZERO_RANGE is called
with a gargantuan size.

The victim file is opened again with O_APPEND (!) and FALLOC_FL_INSERT_RANGE is
called with a modest size.

Truncate is called midway through the just-inserted range.

Annotated calls below.

# https://syzkaller.appspot.com/bug?id=7d29d6d7a773d4f608a33cf6a7593faadb1b5803
# See https://goo.gl/kgGztJ for information about syzkaller reproducers.
#{"threaded":true,"repeat":true,"procs":5,"slowdown":1,"sandbox":"none","sandbox_arg":0,"tun":true,"netdev":true,"resetnet":true,"cgroups":true,"binfmt_misc":true,"close_fds":true,"usb":true,"vhci":true,"wifi":true,"ieee802154":true,"sysctl":true,"swap":true,"tmpdir":true,"segv":true}
# mount file2
syz_mount_image$f2fs(&(0x7f0000000040),
&(0x7f00000000c0)='./file2\x00', 0x0,
&(0x7f0000000300)={[{@noinline_xattr}, {@noinline_dentry},
{@prjjquota={'prjjquota', 0x3d, 'active_logs=4'}}, {@jqfmt_vfsv1},
{@noinline_data}, {@noheap}, {@checkpoint_diasble}, {@fastboot},
{@fsync_mode_strict}, {@discard_unit_section}]}, 0x21, 0x552d,
&(0x7f000000abc0)="$[removed]")
# EBADF
pread64(0xffffffffffffffff, 0x0, 0x0, 0xfff)
# EBADF
openat$cgroup_freezer_state(0xffffffffffffffff, &(0x7f0000000080), 0x2, 0x0)
# openat(AT_FDCWD, nullptr, O_DIRECT, 0)
# EFAULT?
openat$nullb(0xffffffffffffff9c, 0x0, 0x4000, 0x0)
# mount 'bus'
syz_mount_image$ext4(&(0x7f0000000080)='ext4\x00',
&(0x7f00000000c0)='./bus\x00', 0x20081e,
&(0x7f0000000040)={[{@nodelalloc}, {@orlov}, {@auto_da_alloc}]}, 0x1,
0x4ef, &(0x7f00000003c0)="$[removed]")
# open file1
# O_RDWR | O_CREAT | O_NOCTTY | O_NONBLOCK | FASYNC | O_LARGEFILE | O_SYNC
# perm 0500
open(&(0x7f0000000080)='./file1\x00', 0x10b942, 0x140)
# open file1
# O_RDWR | O_CREAT | O_LARGEFILE | O_SYNC
# perm 0210
r0 = open(&(0x7f0000000100)='./file1\x00', 0x109042, 0x88)
# fallocate FALLOC_FL_ZERO_RANGE, offset 0, size 0x7000000
fallocate(r0, 0x10, 0x0, 0x7000000)
# openat(AT_FDCWD) file1
# O_WRONLY | O_CREAT | O_APPEND
# perm 0512
r1 = openat(0xffffffffffffff9c, &(0x7f0000000080)='./file1\x00', 0x441, 0x14a)
# fallocate file1 FALLOC_FL_INSERT_RANGE, offset x4000, size x8000
# EPERM?
fallocate(r1, 0x20, 0x4000, 0x8000)
# truncate file1 size x8001
truncate(&(0x7f00000000c0)='./file1\x00', 0x8001)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
