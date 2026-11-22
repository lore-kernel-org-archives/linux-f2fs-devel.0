Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC6606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bgFjlhC7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xq5XcFHS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ws1Ur44u;
	dkim=neutral header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=N4KtVa4E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=KqekZwmzbCkOW6ASzS27T8LZf0FzP9zEdp6pY3o04cU=; b=bgFjlhC7R6pLx+h195JUqVcF4P
	De+FVzE3GDcsueNnCNecA87ZR5ZDioUjvZO6lTOmLVp2C6WhQPmHhzQrKob6OVfaDoMlAMGRtiCzW
	GOhAnEYs/YSNyrkTEwyjQ+uH7n7YQrA/dtEpB1U5PtsrKR6ZilGOl1ykn1FZdrIrSroI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVBQz-000000003Gp-4APe;
	Sun, 22 Nov 2026 17:33:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <hengyul@cs.unc.edu>) id 1xVBQy-000000003Gd-220k
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 17:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8YUeZtd56yJ2PhtpzFvOodt26i8q7u6e5Opw1KxAgmk=; b=Xq5XcFHSlvo8akYSHYVtw8CalW
 LhEZPGFo+mfNd/YRUtgN3/vH0ya50pY/cITNBX6F6ytNebFs18AR/CMoi44Lgb4UEdIMJnTSX6saa
 3oJlkB1HS7P7arqmG8poKJOsfZJWFkRM4zNMjEFHwedWTp1LOoHYECPx2eilq5LJTBJc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8YUeZtd56yJ2PhtpzFvOodt26i8q7u6e5Opw1KxAgmk=; b=Ws1Ur44uZcMrYXkzqfdBA28OXE
 YkHGVRdgw5AiCZiQYeumb89zRqrr7yq9ATXgJUgbFyXHVrba6fens/wUnyCKwMYqFqYDXmiW81km+
 yr4SjBMNFIhvilt03NDE1YyK7rJPr9FXte1IuCddtG+w2d6WrFlWN74O4bF+DdcoC+6k=;
Received: from mail-qk1-f176.google.com ([209.85.222.176])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVBQx-000000004xE-2nzQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 17:33:00 +0000
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-9496317b730so346599685a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1795368774; x=1795973574; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8YUeZtd56yJ2PhtpzFvOodt26i8q7u6e5Opw1KxAgmk=;
 b=N4KtVa4EhKrcACKaq6azePNT22U5vv29KhLjV++R4W5P4ZfRW+KPDyomjuKAuFkCA/
 L9SEBsAFMHpCA8zgdSvCAB/6EQqdJ9uUHp0pAFCONXT4XOk8s31OLJSVQysNPXnLxp9B
 dNJJqtUU8EkC0QzQi0TQQ5V69p613GtyZ0ZBGAkT7ag/YtExGJIXUJq6lbaLabX0GQ87
 F61IKSJw01wcGckQ8qlySwPvnjsqmHnlB+rp9NoxFdx/YCW+iydqPo6nxS3kV90Xmjdd
 /B+SbxSG9ZbjD2YZNIeD5wWwAB+eeHMs3VaJ3Ojk29LIqwoBBSGlFpa2lQQlLn3lsuib
 8DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795368774; x=1795973574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8YUeZtd56yJ2PhtpzFvOodt26i8q7u6e5Opw1KxAgmk=;
 b=SevVGedbpc9zEdTUoKfcJzifNwBMbMWZOqVXuwrlXcv7w+Vgp1119vAIX5TBwQONve
 aaOTEl9/cD0UYPgdUMlTuP3DKDN9waPVN4FSYqO3z7nGzUBtBTTlM5SiE6QuO0G8v9RX
 +6lepwlgL6wmoxIaRV5pwE5rTQrTPT6QfFFmyQW7hF7E0pdnDLuCqYAcKKAkCH/bejw2
 br7m2mZ27tFCLAVAfK+V0tCjFeb/2as8riap09zCx9hJGB4dB/n0R18llsqerGoTdGwq
 wgrYRZ+WtHTyuhH+bAFep/blQdNEtS4OclLlFE4zlw4DTkDMkCBLVc6/FMEt0RvT3dTt
 Xj0g==
X-Forwarded-Encrypted: i=1;
 AL+hErH6pPALKhm3gBICkjQsywoxoFsLFnkupSrhA0MJqxy6g9B3e8LeoWup8SYVhQB9bqc4MFt1jCerGv50LcPSQ98z@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/hfsYnpsoVR9PQAfKQVqGDTZRI8xJmlVHimXC45HD56ilS8EE5
 eD3+uP0DXv2kA1QJoiELvsd09PNxdA1Ji4gR9HQJ55+2CMhpVTcDbZWuafYBPRm8FO9NEPW7i0G
 qbEY=
X-Gm-Gg: AZFdTZeZfUD7ds7dGc/Ra5nx6WWtfbNtf2iun4GdNGTirYSeePcRQy3sIwtDyQu+VxD
 pXuqsPGhcEc4yJIa+sUmy6pkuv0JKr6koZmqqdpxhlSFMeAtUuA/khEQerSzED1qe+CEQ3zDZTu
 zo7FpgQ42/ya3qarJRUh922MOzfELBoJxB4pwLhZicvJ4NPl9/QuZJHxTtrEEY2y46D9Q8Wgg0w
 7+E+6RrMUrKUsodEFtCo8duisktO6ieb0Qldv60dBW+02GSCwrqqbHq0H9ETzHUxwZPLcsGinoJ
 2Ea2YAJBZJLaPe9r1ZDjtcPEG2yZoQV/KN7/IDfgh2A03hjrocDC41HvvqSMn5Sm8ctGTbbcT9t
 YKsNzeJMoT8PE9YfpGLJF1E/R3wmAw8qPJ0X7ZPBRVfctIH/RpoeiJqExfq9QKLcbBjdL8SFr3I
 Id8JhT9JZPOjHg2axP4ntWrDzvQUyohG67G3dp+E3CnW/TZbxUSTM8p3orKJR1r4yC1kUKllOFk
 Hc08BqC0mK5wjlmS+xdDjqs2jvUwZz0reUnJqSn/VI1KeEAEIm3aSM+TmM0FxS5yTreIOpiJpSn
 hl7m2rN3S4YSJKK6yQ8tX70A3P7YLiXKu5io1o8wXHlNM7reMXqosjg64ZxF+US/LJqfEIPVug=
 =
X-Received: by 2002:a05:690c:9b0c:b0:873:5c6b:a305 with SMTP id
 00721157ae682-8b5204dab2emr36320217b3.51.1795361803007; 
 Sun, 22 Nov 2026 07:36:43 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52028d160sm36223427b3.10.2026.11.22.07.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 07:36:42 -0800 (PST)
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sun, 22 Nov 2026 10:36:36 -0500
Message-ID: <20261122153636.2731348-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVBQx-000000004xE-2nzQ
Subject: [f2fs-dev] [PATCH] f2fs: fix to reject inline_data inode which has
 blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Hengyu Liang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Taerang Kim <kth5965@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit c240c87bcd44 ("f2fs: fix to do sanity check on blocks for
inline_data inode") made f2fs_sanity_check_inline_data() return false,
i.e. "sane", as soon as an inline_data inode has blocks or node ids.

However, the function returns true for a corrupted inode, and that
commit meant to detect exactly this state. The early return also skips
the older checks that reject inline_data on a directory and on a
compressed, encrypted or verity file. As of now, such an inode on a
corrupted image is loaded, and setting this one bit in i_inline of an
inode is enough for the following:

- unlink() of a small compressed file that owns one data block hits
  BUG_ON() in clear_inode(). With panic_on_oops=1 the machine panics.
  Otherwise the task is killed, and the file system can no longer be
  unmounted (EBUSY).
- unlink() of a larger compressed file succeeds, but the orphan inode
  cannot be evicted, and the next mount fails with EIO until fsck.f2fs
  repairs the image.
- A directory lists only 70 of its 300 entries, yet rmdir removes it
  once those 70 are deleted, and fsck.f2fs then finds the other 230
  inodes unreachable.

The issue can be reproduced with:

    mkfs.f2fs -q -f -O extra_attr,compression /dev/vda
    mount -t f2fs -o compress_algorithm=lz4 /dev/vda /mnt
    touch /mnt/f; chattr +c /mnt/f; echo hello > /mnt/f; sync
    ino=$(ls -i /mnt/f | awk '{print $1}'); umount /mnt
    blk=$(dump.f2fs -d 1 -i $ino /dev/vda |
          sed -n 's/.*nat_entry.block_addr *\[0x\(.*\)\]/\1/p')
    # i_inline 0x21 -> 0x23 (F2FS_INLINE_DATA)
    printf '\043' | dd of=/dev/vda bs=1 seek=$((0x$blk * 4096 + 3)) \
        conv=notrunc
    mount -t f2fs /dev/vda /mnt; rm /mnt/f

Before that commit, the result is:

    rm: can't stat '/mnt/f': Structure needs cleaning

After it, the result is:

    kernel BUG at fs/inode.c:776!

With this patch, the result is the same as before that commit.

This patch will make the check return true for an inline_data inode
which has blocks, as the message of that commit describes.

Fixes: c240c87bcd44 ("f2fs: fix to do sanity check on blocks for inline_data inode")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

I noticed afterwards that Taerang Kim pointed out the same early return
in this thread:
https://lore.kernel.org/linux-f2fs-devel/20260317152838.26664-1-kth5965@gmail.com/

Tested on f2fs dev (b61a029304bb) with KASAN and lockdep: the reproducer
above, the same file with F2FS_DATA_EXIST also set, a 5000-byte
compressed file, and a directory with the flag and 300 entries now fail
with -EUCLEAN at iget, without BUG, lost entries or a failed mount. On
healthy images made by v6.8, v6.18, dev with and without this patch,
and sload.f2fs (default; flexible inline xattr + compression;
noinline_data; noinline_xattr; sizes around MAX_INLINE_DATA, conversion
by append, truncate, mmap, O_DIRECT, fallocate and atomic write,
symlinks, xattr node blocks, compressed files, roll-forward recovery
after F2FS_IOC_SHUTDOWN), every file reads back unchanged and fsck.f2fs
reports no error. The f2fs/*
and the generic shutdown/log/metadata quick tests of fstests that can
run here give the same results with and without the patch.

 fs/f2fs/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 032c1cf8c615..2c50a72580af 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -54,7 +54,7 @@ bool f2fs_sanity_check_inline_data(struct inode *inode, struct f2fs_cached_block
 		return false;
 
 	if (inode_has_blocks(inode, ientry))
-		return false;
+		return true;
 
 	if (!support_inline_data(inode))
 		return true;

base-commit: b61a029304bb5531312ebc133b2a895d14dc3fee
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
