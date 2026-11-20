Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425E606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V464QoVc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j3Yx+6ZX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=enKkEucQ;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PUUxhvza
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=/ylR3kb5m0a+m66/LaPOZ7ekyQWsTL9YJZUkt+2wlVw=; b=V464QoVc/rirh4fkvb0P7VP9yA
	QGTEbo1KLdhatNFzpBrnjfY5XKC988yeF0L6+x/gv9t9Pk88F4gr18l1UiVZ6ax/8r6bh3298oc5v
	Zuga/M2q96+Wf0l2DOcwd57i9unfqkGMw3tyw+1eVRLNS3MezWxiDu0zZRe5ms8AlQ08=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUOSa-000000005tx-12ii;
	Fri, 20 Nov 2026 13:15:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <fengaojigui88@gmail.com>) id 1xUOSY-000000005tq-3uyt
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 13:15:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EQiG04aeGhho2nX4ngIjEvlX8jJG32lCa/NIg3JNY4Y=; b=j3Yx+6ZXh4xVpymDe6xhTR9ydJ
 trgZoJo+ucQlq3waDjBIcID+uDvxLKjUClFcVmryRre+bg0su293jG6HUtLBIuTq5GBY57kzyk8oZ
 xfaPsJht0GOtXWRBYqMjPfu2QQOeoAXs03bN+/vVbi+rtsZtRH/K6qRzsLOj3TCRtygs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:MIME-Version:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EQiG04aeGhho2nX4ngIjEvlX8jJG32lCa/NIg3JNY4Y=; b=enKkEucQ6TS4OGI6dhBbu+Vpde
 RIV4Dk4anwwr9Zrju6wcbVGhR3hVSYmqzrDa+KM3bGKompJ0bwa9rSW29oPNUEPcFEz/VU4clJxkl
 d0YBzRs+yGAOE3C4ZPefUDH4EoXtAWeZlV+nqH5XP0FZgWcyRPb35A3pichabz8E3plE=;
Received: from mail-lr2-f8.google.com ([74.125.230.72])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUOSY-000000007Cq-0iB4
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 13:15:22 +0000
Received: by mail-lr2-f8.google.com with SMTP id
 38308e7fff4ca-3adf2030cdbso3152541fa.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 05:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795180515; cv=none;
 d=google.com; s=arc-20260327;
 b=qwbk1mmvWMSr4FfyyYd9oA8Iyiznw/RJpaqe99ZtPjR5D/vqgna2jJ9QirL8lvZ7hR
 rqdDXwhw7xDVtDkpm7KAUnJVYLh78ayeG0jTglh/J5RQStcKQfQHueWsptAxvpcv+dKi
 3mkYcHv4NamRIMl0PPhc/QtWEpde5iYk8FR0wJwrUopJSyWtciKGAybbnf5uhgC8N8sF
 +O+6IYCNQlFkQx/1qbJCmsdzbVtpt44jepyNCbvUevL1P8WWXHJe5BQLrwJrA3kcsM6O
 hB8/oUWKa3LczaBoGBYvG+g7fjnBIdw8LV1BaXO2wshkwUvVfCMGq0DtdHS4eWFt6tze
 5nHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=EQiG04aeGhho2nX4ngIjEvlX8jJG32lCa/NIg3JNY4Y=;
 fh=MFXDbWcncqVz4JcAoCnF5JH09b/VO2zfiSldUHGtOLQ=;
 b=NL5Zql9H5iDGO9tJq841YQ2LvIopq2zmcNY04FDUDy1nuUhC46D09GrRhE14FWNXjE
 VHaERPIvt4ctGbTeTYqZ/WPRcWsKHzILzgD0/O2EC2IQbgN6rvIhawVjvpirAXuBWF3p
 fUlipHl/w/7hddfYrSiWMeFj799bGClqxjqwYngtUu6lfR1WjArgXyDC2q/VOV+7NiWE
 qEcEtf+kXgZGdZqlnVjmKQkJiBB7/weRiiNQ2ITatIv/rmPAavHuSFgHWE6A2H9WbpQI
 LKnLsYB/tApySGOCPx+PmNQzA4NvsX9QfMmPafjOeOJQTCA97gMI3REaL+h2rzQfm8yd
 lPPA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795180515; x=1795785315; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EQiG04aeGhho2nX4ngIjEvlX8jJG32lCa/NIg3JNY4Y=;
 b=PUUxhvzaOwh1c1TAJIdEzf0+du2p1Vu22roPJW5VAk6TozaZMV7J5/7nAg1etkrooa
 doWCt/HmlmCHYcNwmYiqA71lVHNv1TYo4/bW8LNyEPPiklszsoUxnZaRwtVv8d1MogXz
 9RfZJJm49gkVFES0OcqJPGh+tYitHwt2nbUItqENsd5yKN/HOJxu54PXTvGh7dIcIk3M
 OsH7xXQbx5/4yb0I0u0b5T96yScfdl9BcjZmAg6BukSTGnKjdNx+UZ1Rj2BaiMKeLMg0
 ezXtENXSRQG137IXzupWbwY9uaNaJht4L21KOm7VSfI2nxXfM1gORjKlGN7FsIDdRWiv
 hU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795180515; x=1795785315;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EQiG04aeGhho2nX4ngIjEvlX8jJG32lCa/NIg3JNY4Y=;
 b=Fmur2Pr3tIDoAvfJL5hSVzpsPf5yFf49si77Oafex3VkbYxNrC7tOclTn+6W9GZuEi
 KO4SX8lH26bWMjTvIsDbe1PB7pntvGWu4GKmss/0yj4IqfGv+FfqceqUR01QWL9P18pu
 ya7cUsWJK5wqSFIbv/G92J2mo8tDGD1Jw/+aKZz8se//bdGLgNCqUMoeW9yanawLN6Cs
 oIkh7ttsATBHKdSkat/X0vHsx7Q/vvx3xu0MSC8G1Bdcuj77QwK+jgFx/YYj51uOQcZZ
 YypfSFP//Q25qq7gFg5GGmQ7N0KbQdDJGsJIfx1RGJRipJ7+z8TF5AuFCkbmkHMV8nWL
 2s6w==
X-Forwarded-Encrypted: i=1;
 AL+hErEgj3M2J8wSuPiE0ahI/Ke6taxOU2Q3xmW2yUcvShIIQyrPmqGSfogf+cLdSFeHViL4m3NO7wW6mtfZPf0XLWbJ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9u+RsuoATno6QwoqEvC86GDkcf6JJd8OSUcqwF3AIiALMtJBBr
 0f6zsP33JHQmIN33vpTxu67yIABGGQ+Ks2Nxn/HUSENCnQnnJ0v/YqfDCmzQ7pbZEYrkFk2G2qg
 c5vI7hoE/MeZT9x8MvQXypbhoms5fRwKJdnaWOqQ3TfUa
X-Gm-Gg: AZFdTZfDoFRN5ZP7rleT2+Rkwn9TouC4VUM+fxGWqTiSA5PcyG2FVKb6x/WyKL8E6BG
 SDP6X9VG4AfD33aWilMbrKaPcxLbxyRj+h6ptQxqXq0xr6erHg17y7N40PiDUzPFhTDHyFTuzEc
 HlHsyIFzMEXkxUf2a0iKs8mZEyRLrgUX0lliD7X5d8Vkgw4gHZRcsNDu84xofgEv3PXPeyfJFSO
 u2yF3ArRvj1dbKE3dVmruiUS9GwbzZto73Ahkn4GOKaY9pPSO1A06UD78MlR9fF70q/Z/xvPU+f
 zeQKai1oG7r8HAcSmetCCTlgn7y/Coa9HmM/wCCVFJJVLskEVPjevn/4nc6VP2RVGgNctTfMaJz
 Ngq9TW//XUQOAZowvwr52novax+Eit4X69IxzICRRjwa73/Pt9ILMzzlH63qbrQDdIU/O
X-Received: by 2002:a05:6512:23a0:b0:5bc:ca83:1fc0 with SMTP id
 2adb3069b0e04-5c1bc84e614mr893480e87.60.1795180515196; Fri, 20 Nov 2026
 05:15:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Zheng Zheng <fengaojigui88@gmail.com>
Date: Fri, 20 Nov 2026 21:15:00 +0800
X-Gm-Features: Aa3M54o01QUrjwMOe7JbVZOC_U4U8JrBvLlJFLHGEXWyo1gmrd71mbHzknsbcAA
Message-ID: <CAO-4RZ3D4PjuOopArwKVtt31KLKwPAqTu_w+jwJKhbTkKfBykA@mail.gmail.com>
To: jaegeuk@kernel.org
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xUOSY-000000007Cq-0iB4
Subject: [f2fs-dev] [BUG] INFO: task hung in f2fs_balance_fs
 (fs/f2fs/segment.c:461, v7.4-rc3)
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jaegeuk, Chao,

We found a reproducible F2FS hang on v7.4-rc3 with syzkaller. The supplied
recipe reproduced on independent fresh VMs.

Repository and reproducer:

  https://github.com/Zheng-zheng-codes/f2fs-balance-fs-hang

Hung-task report
----------------

  INFO: task syz.3.29:17033 blocked for more than 143 seconds.
  task:syz.3.29 state:D
  Call Trace:
   io_schedule
   f2fs_balance_fs+0x5a2/0x9e0 fs/f2fs/segment.c:461
   f2fs_map_blocks+0x2626/0x4d00 fs/f2fs/data.c:2160
   f2fs_iomap_begin fs/f2fs/data.c:4798 [inline]
   f2fs_iomap_next+0x3d9/0xc20 fs/f2fs/data.c:4856
   iomap_iter
   __iomap_dio_rw
   f2fs_dio_write_iter fs/f2fs/file.c:5587 [inline]
   f2fs_file_write_iter+0x1da1/0x2d10 fs/f2fs/file.c:5711
   vfs_write
   ksys_write

The blocked task is a direct-I/O writer sleeping in the GC_MERGE branch
of f2fs_balance_fs(), which hands the request to the background GC
thread and waits:

  if (test_opt(sbi, GC_MERGE) && sbi->gc_thread.f2fs_gc_task) {
          prepare_to_wait(&sbi->gc_thread.fggc_wq, &wait, TASK_UNINTERRUPTIBLE);
          wake_up(&sbi->gc_thread.gc_wait_queue_head);
          io_schedule();
          finish_wait(&sbi->gc_thread.fggc_wq, &wait);
  }

While it sleeps, the writer holds:

  #0: (&f->f_pos_lock)              at: fdget_pos+0x2a5 fs/file.c:1413
  #1: (sb_writers#15)               at: ksys_write+0x126 fs/read_write.c:719
  #2: (&sb->s_type->i_mutex_key#29) at: f2fs_file_write_iter fs/f2fs/file.c:5675
  #3: (&fi->i_gc_rwsem[1]) READ     at: f2fs_dio_write_iter fs/f2fs/file.c:5573

The same report shows two collateral stalls caused by this sleeper: a
second thread of the same process blocked in fdget_pos() on the held
f_pos_lock, and a freeze_super() task waiting in sb_wait_write() for
sb_writers to drain.

Possible root cause
-------------------

The writer waits for the background GC thread while holding
fi->i_gc_rwsem[1] for reading.  If the GC thread selects this inode as
a victim, it must take i_gc_rwsem for writing first and cannot proceed,
which would make the wait in f2fs_balance_fs() unbounded.  The GC
thread's stack is not captured in the report, so we could not confirm
this mutual-wait explanation, nor what drove the filesystem low on free
segments.  We would appreciate your analysis.

This hang is distinct from the previously reported
"INFO: task hung in f2fs_write_data_pages" (writeback path,
sbi->writepages mutex, fs/f2fs/data.c:3834): different call chain and
different blocking primitive, though both occur under segment
allocation / GC pressure.

Reproduction
------------

  git clone https://github.com/Zheng-zheng-codes/f2fs-balance-fs-hang
  cd f2fs-balance-fs-hang

  # boot v7.4-rc3 with the supplied kernel config
  # using a Debian trixie x86_64 guest

  # in the guest, as root:
  syz-execprog -procs=1 -repeat=1 reproducer/repro.kernsight.prog

Note: run with a single process.  With -procs=8 the recipe's
state-building sequence is executed out of order and the crash does not
reproduce.

The recipe is a state-reconstruction sequence (107 replay programs plus
one model-selected priming program, followed by the crashing testcase).
The crash depends on the kernel state built by the recipe; the testcase
alone is not sufficient.

Verification:

- five independent fresh-VM runs: 5/5 reproductions, 201-205 s to the
  hung-task dump in every run (2026-11-20, external-verify/)
- C reproducer: not generated; the syzkaller recipe is the primary
  reproducer

Kernel/guest details:

  kernel: v7.4-rc3, bzImage sha256
    0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882
  guest: Debian trixie x86_64, 6 GiB RAM, 4 vCPU, QEMU/KVM
  boot: oops=panic panic_on_warn=1 hung_task_panic=0
  config: CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y, CONFIG_F2FS_FS=y

Thanks,
Zheng


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
