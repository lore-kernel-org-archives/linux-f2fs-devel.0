Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CADEB7EA4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cz+rkhX7F8g4vgpHiRLtVdT0VW5c+/3WRtFwXC5Xk9k=; b=GWbhqfRciYZP3Xwh0hkTIHeD8b
	aOybhBDIASgZyKNtPJldII1EQU5cijJTpkB6CZaUL3e3VD50XI+L5fC1rMOJ2Fa77rSDxk7JxqBQr
	erpDrWVvjsMJjyH57OfvYl4gc7wo2ZXzZ6Iu0fN50Hrn3Cg/lnp0T+UeFBT9EuyXy2nw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxhVX-0004m0-OE;
	Wed, 04 Mar 2026 08:23:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vxhVQ-0004j0-JY
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 08:22:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xcvEsYAtk5/KKIdutKwHish5V09WwtfHkpjX/rFMGkA=; b=HMVqiD3h5Lgr9J6dnt2+ATQjV8
 kUktpRTO3yEzHsqqwTHaPflfRcohTmyC0sT3Pi8Cn6+EajlZEL9UlXQ0YwtHvbWFbtz5UvjlvfSdE
 WwugslyXQL/kCaPiLGwEIv55pnZMlRhXCARSlKP1P0LVY6srCeT3NPKZWXQhku/TLZjY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xcvEsYAtk5/KKIdutKwHish5V09WwtfHkpjX/rFMGkA=; b=f
 QoiKIWkgW7hSkKfnyqtgT4Pece6aB8GzpgCgF3YVYZ+CISnMgMND7vOb/B9O4fP8OfPw3M5PzwE5H
 Jeo4n28+EIDESzpbDA2Dpij8DmSlewW6sQHgNN27LFSMquQBT2xleyLdoR63NkmGWJtJFZx6xzN4i
 SYVlBv39gDWyJuy4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxhVQ-0001sI-44 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 08:22:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9055240BC0;
 Wed,  4 Mar 2026 08:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E912C2BC87;
 Wed,  4 Mar 2026 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772612565;
 bh=icWG1A7UBFSnUY7gEP52PeidpjvJUJV5q0kpmdRHvgA=;
 h=From:To:Cc:Subject:Date:From;
 b=XYk9i0oZyJO5jDEK7iH27/6pFt2XaO68lLxbi0A6JDadz8eIONsEsg4EeADOonGx9
 zMExVgmnL83/xq7KbP4dpRjoqDRSQpX1eiJpV+ib5HbtgPbNV94vT2lTGuMEWLH6g0
 WPcvq3oHME+woe+9aBiw+T+bq+8qFp38elrcu5jH2/Mn/Xbyx5eKadeSiI50NndsBC
 wO5hXQgO8DQAt6y6WWCBBc8pyTghvLDKvQpfxnCnwq4oZjk1ygLDi7BRqwICNalWdP
 zCulzxdNMClYxM7Pl+UsHdPuDvGrUxOjKvligRf/wK8HYwOPAm7OjXgsL6h301/5gQ
 /kH+fHJ55Gxyw==
To: jaegeuk@kernel.org
Date: Wed,  4 Mar 2026 16:22:31 +0800
Message-ID: <20260304082231.599770-1-chao@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
MIME-Version: 1.0
X-Headers-End: 1vxhVQ-0001sI-44
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid memory leak in f2fs_rename()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>,
 syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot reported a f2fs bug as below:

BUG: memory leak
unreferenced object 0xffff888127f70830 (size 16):
  comm "syz.0.23", pid 6144, jiffies 4294943712
  hex dump (first 16 bytes):
    3c af 57 72 5b e6 8f ad 6e 8e fd 33 42 39 03 ff  <.Wr[...n..3B9..
  backtrace (crc 925f8a80):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4520 [inline]
    slab_alloc_node mm/slub.c:4844 [inline]
    __do_kmalloc_node mm/slub.c:5237 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5250
    kmalloc_noprof include/linux/slab.h:954 [inline]
    fscrypt_setup_filename+0x15e/0x3b0 fs/crypto/fname.c:364
    f2fs_setup_filename+0x52/0xb0 fs/f2fs/dir.c:143
    f2fs_rename+0x159/0xca0 fs/f2fs/namei.c:961
    f2fs_rename2+0xd5/0xf20 fs/f2fs/namei.c:1308
    vfs_rename+0x7ff/0x1250 fs/namei.c:6026
    filename_renameat2+0x4f4/0x660 fs/namei.c:6144
    __do_sys_renameat2 fs/namei.c:6173 [inline]
    __se_sys_renameat2 fs/namei.c:6168 [inline]
    __x64_sys_renameat2+0x59/0x80 fs/namei.c:6168
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is in commit 40b2d55e0452 ("f2fs: fix to create selinux
label during whiteout initialization"), we added a call to
f2fs_setup_filename() without a matching call to f2fs_free_filename(),
fix it.

Fixes: 40b2d55e0452 ("f2fs: fix to create selinux label during whiteout initialization")
Cc: stable@kernel.org
Reported-by: syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/69a75fe1.a70a0220.b118c.0014.GAE@google.com
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e360f08a9586..6ef21deeef1c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -964,6 +964,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			return err;
 
 		err = f2fs_create_whiteout(idmap, old_dir, &whiteout, &fname);
+		f2fs_free_filename(&fname);
 		if (err)
 			return err;
 	}
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
