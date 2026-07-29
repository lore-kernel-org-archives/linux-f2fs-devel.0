Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93FDC53219
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B6MSFjuY8zLk5xdXJdIu9cnbsLTsQCvPTQEPYrg9g5I=; b=hDoewILgxUcxxRXo/bPvdYpJHs
	EnkPhCuOsLvgXZNvMIGJ7dDsnFFD4UDmk1HuwGwZ/kx3jwJSbmxs4wUbZD+p9AgYCVfOG7BSB8jN2
	1J96uUhUB9wjizRPS5KzKsG2ay67Ae39IPqmO7rLZzvKVFMzunumG3YHMYH1FEre/OE0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wosAH-0000we-T0;
	Wed, 29 Jul 2026 00:28:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wosAG-0000wX-LU
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 00:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pr//3zSCP7LkXyyDIjhyaLOi/lRso285vWAPwff1rr4=; b=GsesTWT4nCYNMeHkbS7oxs+S/S
 alBY/0PUnX5KRM9PHL81Vop+HLztCN5PTz1oynK+cJu+1or/U3ItnR6BddDIG7TicNX57GcAtGaQF
 YWNmYR5wSSVa7dmygxJ2kSUAzp9sN7apMJ5err1oPsMPG5C09PtwVUU4cfC3U3E8nFmA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Pr//3zSCP7LkXyyDIjhyaLOi/lRso285vWAPwff1rr4=; b=D
 eGz8PsGbfZiX0DX4w7QhUBQDJixPgcVkbM89TYhldALZz5ZaSO6luC1wwBcx5HuIWhsXteXCuuk8/
 QtKv7J9TAlpoYSXf0pzqaSHQmbYszberuaw88YElU72aczR6kMI4it2fRfcyAVD7W7P1GztIS0bvG
 nPAr+eywxyGeUFEA=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wosAE-0001wd-Nn for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 00:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Pr
 //3zSCP7LkXyyDIjhyaLOi/lRso285vWAPwff1rr4=; b=BMTR29DnWtK4C4hKDa
 x26S1cpQ8LAouQEbIaWholjpU4byq/p+jQ+v4po6X3lisKKSRMGbTScKqzzgiJ8c
 y2XBychPbQGx5Gw7cCZDk8kMV0iRJQWGhkAnL057pYsJTVGBqc0Qv2O4yBFScU10
 2O5GR+LEpSpJXnTmUPQKecAxY=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD3t2srSWlqMbx2Eg--.31071S2; 
 Wed, 29 Jul 2026 08:28:28 +0800 (CST)
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 29 Jul 2026 08:28:27 +0800
Message-ID: <20260729002827.303608-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: _____wD3t2srSWlqMbx2Eg--.31071S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw43Kw1fCF4kGw1UCFWfXwb_yoWrZr1UpF
 4rKFyrGF4kXrWUWrW0yr1jgrs8tFyxJFWUZFy8Kw1DA3Z8WryFgF1kK3WYvay7Jr1rAa1v
 va1Y9ryUWrs8taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1q2NUUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQxSImppSSzBuAAA3S
X-Headers-End: 1wosAE-0001wd-Nn
Subject: [f2fs-dev] [DISCUSSION] f2fs: compatibility between compressed
 files and large folios
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi all,

Chao Yu and I discussed the compatibility between compressed files and large
folios.

The main race scenario is that f2fs_new_inode() creates an inode without the
compression flag and enables large-folio support for its mapping. Later,
f2fs_setflags_common() can set the compression flag while large-folio support
is already enabled for the inode. Neither f2fs_iget() nor f2fs_new_inode()
can prevent this for an active inode.

Here are the two approaches I am considering.

1. Reject setting the compression flag on a large-folio mapping

We can reject setting the compression flag in f2fs_setflags_common() if the
inode mapping supports large folios:

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2250,6 +2250,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
        if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
                if (masked_flags & F2FS_COMPR_FL) {
                        if (!f2fs_disable_compressed_file(inode))
                                return -EINVAL;
                } else {
+                       if (mapping_large_folio_support(inode->i_mapping))
+                               return -EOPNOTSUPP;
+
                        /* try to convert inline_data to support compression */
                        int err = f2fs_convert_inline_inode(inode);
                        if (err)
                                return err;

Another implementation is:

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2250,6 +2250,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
        if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
                if (masked_flags & F2FS_COMPR_FL) {
                        if (!f2fs_disable_compressed_file(inode))
                                return -EINVAL;
                } else {
+                       if (IS_ENABLED(CONFIG_F2FS_LARGE_FOLIO))
+                               return -EOPNOTSUPP;
+
                        /* try to convert inline_data to support compression */
                        int err = f2fs_convert_inline_inode(inode);
                        if (err)
                                return err;

The concern with this approach is that new files trying to set compression
through the ioctl will be rejected, so compression will not be available. I
think we can document that enabling large-folio support in f2fs disables
compression.

2. Keep the compression flag and restore order 0

If the compression flag and compression functionality need to remain
available, we can restore the mapping order to 0 after set_compress_context()
successfully sets the compression flag in f2fs_setflags_common():

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2268,6 +2268,10 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
                                return -EINVAL;
                        }
                        err = set_compress_context(inode);
+                       if (!err &&
+                           mapping_large_folio_support(inode->i_mapping))
+                               mapping_set_folio_order_range(
+                                       inode->i_mapping, 0, 0);
                        f2fs_up_write(&fi->i_sem);

                        if (err)
                                return err;

Under normal Android workloads, a file whose compression flag can be set by
f2fs_setflags_common() has no data blocks. Also, an application will not read
a newly created file with size 0 and fill the page cache with zeroed large
folios. Therefore, setting the mapping order to 0 here is safe.

A theoretical sequence is: create a file, use ftruncate() to extend it to a
non-zero size without allocating data blocks, read the file holes so that
zeroed large folios are left in the page cache, and then set the compression
flag through the ioctl. If truncate_inode_pages() is not called before the
mapping order is reset, the existing large folios remain in the page cache.
Also, since mapping_set_folio_order_range() is not atomic, readahead may
theoretically access the mapping's folio-order flags without holding the inode
lock. Neither case is expected under normal Android workloads.

Jaegeuk previously mentioned that a file could have both the compression flag
and a large-folio mapping. Its writeback could use the normal large-folio path
without actually compressing the file. After the inode is evicted and the file
is opened again, f2fs_iget() would see the compression flag, prevent the
large-folio mapping from being enabled, and return to the normal order-0 read
path. Chao Yu pointed out that it would be functionally strange if a file
with the compression flag was not compressed during its first writeback.

Please let us know which of the above approaches you think is better, or
whether we have another better approach.

Thanks,

Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
