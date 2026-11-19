Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE0606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gb4RkMqf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QRlfRJmX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f5JH8A/c;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HA2TZK71
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=bquZ2L4YHbmAAJqnDXxJY/sLXzLPz+U8NqArOQErhCc=; b=gb4RkMqfn5rWimDY06nEy+h1Y2
	VOEOjWuffTRYG6bUGgpYbBS7MR+6WkTTyrlxLtaVH5hbZJAlxmbRSq4K+bO+DNzUGIMh3XuuMInCo
	IloI0nF8gQudLnwxo7JuNluAqYdFz63+nqIcagjsyTSX5Dk4igenkZnr2CBvTlc0F1R4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xU1ku-000000007d4-1fYA;
	Thu, 19 Nov 2026 13:00:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <fengaojigui88@gmail.com>) id 1xU1kt-000000007cu-2QEt
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1UOYu9Q0PzRdpizvWhSKuoToUBKIjH2/MZWY5nBexs4=; b=QRlfRJmXHFOKoc+i086g3Ao6wW
 T+V9DYo9eqsXD7LIkcgxcyrmantFpCM9NH2SvK10aUSNrHodEH9WOZB24kir5ttcRpKAaCRFUAiCN
 BF5TY4XTztD2FAmXSvhBZMuyCKmzmyHSkywiSj8rJn+AgSrsIeeOmCsRME+kFDJLe5AA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:MIME-Version:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1UOYu9Q0PzRdpizvWhSKuoToUBKIjH2/MZWY5nBexs4=; b=f5JH8A/cKtE6R0nj6d1V8XqHFu
 NkPd8BnBtiq2u9TLtOGFnS5kigEyAntMBuWrOltI5nckOpuu9aHaKxn0Zw2oAeSzLxh54LV+9Zj4g
 8462C72IV/HdSJMP4rwvtjCqXmaci7GTEHNfiP8VtuWhIhQL77gWnDtIUAWdI+ZfLqBs=;
Received: from mail-lr2-f8.google.com ([74.125.230.72])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU1kq-000000000vC-48gs
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:00:47 +0000
Received: by mail-lr2-f8.google.com with SMTP id
 38308e7fff4ca-3ad8a138a11so9902991fa.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 05:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795093238; cv=none;
 d=google.com; s=arc-20260327;
 b=LHyrvhgAs5JCzkjCbhF2HwN57ADZ1yPg2lqLZogMh3gLrsQrvhKv6trZEy/ocDH/ti
 zz/4KDrTTisrDm2VUebvdE2B2tl+gyaEs/XKgktTsSqAA4TZDawMkBkD2cvSeD+lYmJw
 KXxYCBCKppxumxmnvdW9+0qfNDFQMV8KUwVQCR9HGYs5HF+Ytnftk2CkVeB4Txh+dQN/
 ykZFRQkgftnA22zEjkDhzlZ09GO39FCpC6EcJV++k1PIEstz5Bcxa6NT8xrTLfoR81s8
 BL6KHiT9TxxvmrRrI5uwmpD/1Jaj2GvVoZkrXlBDFAZ6aJRLeivXiWAl+UPH4yQdfAmk
 WCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=1UOYu9Q0PzRdpizvWhSKuoToUBKIjH2/MZWY5nBexs4=;
 fh=Yq8Cr+IVi2Yh6R6uCP3udC7f+PgR2e8rgSD6DgYQMI8=;
 b=XN9ed5g7SsN9jQWvEaDdXV/fyapspfbonrXHnWqviamyBpe8cIIb7+mrG5eEf6mp2f
 t+e7CbCl8LbnblPbwShjhpCyADmuckrbo9aSkfIlvApEWDaSjNzaRyJ7nbDu638DCq08
 v1ML0PHK7fXEtFR2w9nGFVd5cxq237KY+ngfZj4W+PITzH1pMjJSiJ5IyFm+ih/mePZT
 R2CqfouQI14j57g1OFrI9RjbFkAFz6vIUMlcpvSvJSudbfaYWKemrba5nPDjHqF16jb6
 CXcUdI7tZKIZ4FbpzHC88v7sOfI5fyq6pwKO4jnHQa3SitQ9ABZXusCnNJG0BYwrNEG8
 tmKg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795093238; x=1795698038; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1UOYu9Q0PzRdpizvWhSKuoToUBKIjH2/MZWY5nBexs4=;
 b=HA2TZK71DGF2uqVzHwJLafYB0AC7QfJGfiem7iSXmDSj/iJV5iH3nrqFoOC/9/ViE4
 gV2heNeUyQM5whQNXOBvA6G6YExLtigir0kLf5N5QMbH15Al2CU7d9HgjwrjpHI9iY8K
 XuKAKjeQH9jVwvDHkaXlhkJvCbThZ4BawY/TFc2/w4n9uduyiVkgvd2MIqH/BMVahMrV
 yEgOpLRgPhAoui5begm7WLrEcpyY18VldaWh8rIlO5xAGwjzgdshfW9iUjtNn91RvaDM
 ZjFksKWwciBnKdJkbqOljrGYHtjvW/RKQl+FRoc6/8MwxzJnCZGqPWQJh9u5eL7Gid9+
 +/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795093238; x=1795698038;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1UOYu9Q0PzRdpizvWhSKuoToUBKIjH2/MZWY5nBexs4=;
 b=fZsG0ar5OlVtjNLyChD0u+A3Xvanqwf5uFq9mHhG1cZPPfKsg88LMEi23JPZ/HW88W
 jocjr6gdeJoNqmxokM2U5kjCoTObqxv5OhxoRl5713JI656prpXLTKhQBQMjRC1ASoHJ
 18L/zEKI5GOQYZFoIuWpjtZsHEeQ00lhQDu0N4Nb1GcxlNs1HOCpnXSYRHkD/RUUmRlv
 nYiBPwUNaNzSCBhDQNw8EUkIturu70WJC2e7XFLImwWJ4ANauGQLNUaP0k54XCzJbTgV
 ikOYqgOoDkf0WgaBNu43h/FAHsx0nJ9uw4YrErOI26HIk9QhdpL43kuyZk9KtspAivH0
 y+iQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHytWT5pOeaPdF/BlzRuBcU5xv0YXnnqI3GaUvwv7TzyWvF+nofX+fap8UbhEHQedqQifSdE41gw7DyfF6OcfuD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9KU0KtQVdRGZkgChCPjug9X47Ujs7cPCK9/D7Juai7PLaK+fzT
 oHcgLXAtHWdHRO+OUykIio8ssWDjq1H+f6elPaVk6b38GSE7TIVUW/rQz0gZ0g+yA7ZY9CP3cq5
 ChAeqD5jTOnil0RLnDrH9xWySy/DRMeQ=
X-Gm-Gg: AYBFou2U8L2EWn2uQrYpQlF7IsAxS4izbMohuz0XOfadt+bo7J6C+0vvBYw69Tmo5cO
 H+FxMb+CMczRQu7+vL0AX20v0Hz1OhVyCigiClmXYxuxaJmZRvnumQiETG0EzQu/roQLxBuqNAI
 uhCIn4I7WRR4uYNEoMMjscIgao5VaIpNxDeQhI4Tw0I/r3tGT1KR5AfqXPB5V9uEjca39bqwtXn
 Ti6Q/FtdrC7c8KVm5hn8Tl7k8qwihvrHrY7WqVzhUYbycBitzkfqaI+uDR1FHeK5/LeaPE45z/Q
 zIgUoHUbFhHvTc2FYbooyY3LVizT+8DlrbUnALV4IJSZSS+gOVn6YM2UQwVN7tHknHpLo8NEzCn
 cdhMWIPow5oWX8Kcmhpz3gVxBImef4O6ysg+UXKSrxCDsKNODL8HnOKdl/f7nZ+HIntyzyEJrOu
 yxhkCa2SiieGRakg==
X-Received: by 2002:a05:651c:a1a3:b0:3ab:2d74:720 with SMTP id
 38308e7fff4ca-3ae670e5029mr19241561fa.19.1795093237878; Thu, 19 Nov 2026
 05:00:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Zheng Zheng <fengaojigui88@gmail.com>
Date: Thu, 19 Nov 2026 21:00:20 +0800
X-Gm-Features: AclHuK8RtgM76QuV3Dn0Ssp2PetiT1giOj3_nSpsgXYV3CYN6aQRAYBMJyAxvJI
Message-ID: <CAO-4RZ26E_nHitssH-itT4Kjy0uAtQzG0_+uH210HiiHV6K36A@mail.gmail.com>
To: jaegeuk@kernel.org, chao@kernel.org
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xU1kq-000000000vC-48gs
Subject: [f2fs-dev] [BUG] INFO: task hung in f2fs_write_data_pages
 (fs/f2fs/data.c:3834, v7.4-rc3)
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 syzkaller-bugs@googlegroups.com, daehojeong@google.com, qiwenjie@xiaomi.com
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

We found a reproducible F2FS writeback hang on v7.4-rc3 with syzkaller. The
recipe is self-contained and reproduced on three independent fresh VMs; no
state snapshot is required.

Repository and reproducer:

  https://github.com/Zheng-zheng-codes/f2fs-write-data-pages-hang
  commit ff85a8d2e8d444ae78308f084869666cb9acc514

Hung-task report
----------------

The primary blocked task is waiting in `__f2fs_write_data_pages()`:

  INFO: task syz.2.19:29337 blocked for more than 142 seconds.
  task:syz.2.19 state:D stack:24760 pid:29337
  Call Trace:
   <TASK>
   __schedule
   schedule_preempt_disabled
   __mutex_lock
   __f2fs_write_data_pages fs/f2fs/data.c:3834 [inline]
   f2fs_write_data_pages+0xfaf/0x14a0 fs/f2fs/data.c:3879
   do_writepages
   filemap_writeback
   file_write_and_wait_range
   f2fs_do_sync_file
   f2fs_sync_file
   vfs_fsync_range
   f2fs_file_write_iter
   do_pwritev
   __x64_sys_pwritev
   do_syscall_64
   entry_SYSCALL_64_after_hwframe
   </TASK>

A second task in the same report is blocked in `f2fs_fallocate()`:

  INFO: task syz.2.19:29526 blocked for more than 142 seconds.
  task:syz.2.19 state:D stack:28664 pid:29526
  Call Trace:
   <TASK>
   rwsem_down_write_slowpath
   __down_write
   down_write
   inode_lock
   f2fs_fallocate+0x347/0x3ca0 fs/f2fs/file.c:2116
   vfs_fallocate
   __x64_sys_fallocate
   do_syscall_64
   entry_SYSCALL_64_after_hwframe
   </TASK>

Important lock observations
----------------------------

The first blocked task is waiting for the per-superblock `sbi->writepages`
mutex. The lock dump also shows another task, PID 29506, holding
`sbi->writepages` together with:

- `sbi->gc_lock`
- `fi->i_gc_rwsem[0]`
- `fi->i_gc_rwsem[1]`

The NMI backtrace for PID 29506 shows it in garbage collection reached from
writeback:

  f2fs_get_node_info
   is_alive fs/f2fs/gc.c:1163 [inline]
    gc_data_segment fs/f2fs/gc.c:1642 [inline]
     do_garbage_collect fs/f2fs/gc.c:1935
      f2fs_gc fs/f2fs/gc.c:2047
       f2fs_balance_fs fs/f2fs/segment.c:475
        f2fs_write_single_data_page fs/f2fs/data.c:3433
         f2fs_write_cache_pages fs/f2fs/data.c:3665
          __f2fs_write_data_pages fs/f2fs/data.c:3841 [inline]
           f2fs_write_data_pages fs/f2fs/data.c:3879
            do_writepages
             filemap_writeback
              filemap_invalidate_pages
               kiocb_invalidate_pages
                __iomap_dio_rw
                 f2fs_dio_write_iter
                  f2fs_file_write_iter

The relevant source in `__f2fs_write_data_pages()` is:

  if (__should_serialize_io(inode, wbc)) {
      mutex_lock(&sbi->writepages);
      locked = true;
  }

  account_writeback(inode, true);

  blk_start_plug(&plug);
  ret = f2fs_write_cache_pages(mapping, wbc, io_type);
  blk_finish_plug(&plug);

  account_writeback(inode, false);

  if (locked)
      mutex_unlock(&sbi->writepages);

In this report, `f2fs_write_cache_pages()` reaches `f2fs_balance_fs()` and GC
while the per-superblock `sbi->writepages` mutex is held. Other tasks then
block on that mutex, and the fallocate path blocks on the inode lock.
We have not
confirmed the root cause or a fix; this is the observed lock dependency.

How to reproduce
----------------

  git clone https://github.com/Zheng-zheng-codes/f2fs-write-data-pages-hang
  cd f2fs-write-data-pages-hang

  # boot v7.4-rc3 with the supplied kernel config
  # using a Debian trixie x86_64 guest

  # in the guest, as root:
  syz-execprog -procs=8 -threaded -repeat=0 \
      -executor ./syz-executor reproducer/repro.kernsight.prog

`-repeat=0` enables indefinite repetition. The hung-task reports appeared
after approximately 205-206 seconds in the external verification runs. The
recipe has 141 entries: 140 replay programs followed by the testcase.

Verification:

- Main Kernsight pipeline: attempt 5, `confirmed=true`,
  `status=verified`, 140 replay programs, 2026-11-19T08:05:41Z
- Pipeline verification scope: `snapshot_restore`
- Independent external fresh-VM verification: **3/3**
  - run 1 hit after 205 s
  - run 2 hit after 206 s
  - run 3 hit after 206 s
- A run was counted only when one hung-task report contained both
  `INFO: task ... blocked for more than` and `f2fs_write_data_pages`
- External serial logs: `external-verify/serial-{1,2,3}.log`
- Target checker: `external-verify/verify-logs.py`
- C reproducer: not generated; the syzkaller recipe is the primary reproducer

Kernel/guest details:

  kernel: v7.4-rc3, bzImage sha256
    0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882
  guest: Debian trixie x86_64, 6 GiB RAM, 4 vCPU, QEMU/KVM
  boot: oops=panic panic_on_warn=1 hung_task_panic=0
  config: CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y, CONFIG_F2FS_FS=y

Thanks,
Zheng Zheng


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
